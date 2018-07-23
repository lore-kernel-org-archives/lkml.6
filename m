Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21337ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44D520856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VWUKxaAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44D520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeGWRyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:54:36 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44437 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbeGWRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:54:36 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so649303vke.11;
        Mon, 23 Jul 2018 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XcKZK1qEcUIFf7j9vJK6gTysy80sixeqrONCrrToW+c=;
        b=VWUKxaAafaSYwt3Tra5nIKcY9p1zi/MldkM6UY2x1QmI68fZjoqgkQr7/yC5qpLvrM
         Bp5dTlIafBwbbzS7WRBFFgJpAhma4URgbp4AsQUZg2Y8pEP7o6lyFUec2S723RmOXp3M
         LMXQUJKNNl0HgomSZWcwgBadt+rHTfEiGzjcW0l04k92Ta6CtncG4XyomEmKwwrdBPNb
         LFm2NPAhf7ROaMLbEu7X+4GbQsqdiqvj7AQXQzN6AH2Olj5/h51MSBAdKrNPOcbVzWyS
         rKvs73duHtP5uqIaiAZHV8EHRzVdevn6iQz+YjMFLYgOLdcvFSw6YBCwrvqgQCglLt+q
         SZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=XcKZK1qEcUIFf7j9vJK6gTysy80sixeqrONCrrToW+c=;
        b=NrREFJSQnIcl19OO0bkMQaOnwFWW/E2SesrVIwtrgYHbyjVMY8R0gUQdBijJw0EoXb
         zHoolgS7zelXeaFrI9XVh9a+gYhw6ynJI0SiYER8FBiq0d+5Txzp2R1Uq1p2VY0nKd8m
         tenaNilcv42c8EfywJGmVouWsmPRqBSKBm38KHPYN7ONbf/MbL55YbQSFixnZ+JyX/Me
         CvEmt6fo5YpgKuIchSmq3YSQZmdnTKbBgoprIP4BFKyKq/tkJ7Wn3hSg29i2aGNUS9ln
         TcyMwxww4E7TN0D/yczp1xwiRbhd/nBsYtLyiFTvwtV9WojHgtf8uud4j/1xfuA9F+iZ
         0hwg==
X-Gm-Message-State: AOUpUlFJqW8rRtKY7otx00dGwBt1BgEoPe7sIXEdl8DK3KB4Pjb1n0eO
        OIR4Xdk8+vhhJQJNhYd7l+8Ee+p9En7d9BbGDXc=
X-Google-Smtp-Source: AAOMgpcG2llrpmqHVR1WTg/FeA3Xe3hLvKB+Syh7xln7/GIACEYDZrkVcxHWceAmt7AJtvXeGsfpb8C8IibHC6EurcI=
X-Received: by 2002:a1f:7d09:: with SMTP id y9-v6mr7958221vkc.15.1532364749308;
 Mon, 23 Jul 2018 09:52:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:d012:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:52:28
 -0700 (PDT)
In-Reply-To: <20180723151608.GE3358@thunk.org>
References: <CANVEwpbaU5=wMT_iSh9XrkmbLvqKjx4+v6PDizamaY0gWvk-mg@mail.gmail.com>
 <20180723151608.GE3358@thunk.org>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Mon, 23 Jul 2018 17:52:28 +0100
Message-ID: <CANVEwpYLbwQFY_5LDatHa5EBt39CVQ6=Fb0+mYgN6Ojyd-Km9w@mail.gmail.com>
Subject: Re: Does /dev/urandom now block until initialised ?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 at 16:16, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Jul 23, 2018 at 04:43:01AM +0100, Ken Moffat wrote:
>>
>> Did that, no change.  Ran strace from the bootscript, confirmed that
>> only /dev/urandom was being used, and that it seemed to be blocking.
>
> Nope, /dev/urandom still doesn't block.  Are you sure it isn't caused
> by something calling getrandom(2) --- which *will* block?

I'm not at all sure, which was why I asked.
>
> We intentionally left /dev/urandom non-blocking, because of backwards
> compatibility.
>
>> BUT: I'm not sure if I've correctly understood what is happening.
>> It seems to me that the fix for CVE-2018-1108 (4.17-rc1, 4.16.4)
>> means /dev/urandom will now block until fully initialised.
>>
>> Is that correct and intentional ?
>
> No, that's not right.  What the fix does is more accurately account
> for the entropy accounting before getrandom(2) would become
> non-blocking.  There were a bunch of things we were doing wrong,
> including assuming that 100% of the bytes being sent via
> add_device_entropy() were random --- when some of the things that were
> feeding into it was the (fixed) information you would get from running
> dmidecode (e.g., the fixed results from the BIOS configuration data).
>
> Some of those bytes might not be known to an external adversary (such
> as your CPU mainboard's serial number), but it's not exactly *Secret*.
>
>> If so, to get the affected desktop machines to boot I seem to have
>> some choices...
>
> Well, this probably isn't going to be popular, but the other thing
> that might help is you could switch distro's.  I'm guessing you run a
> Red Hat distro, probably Fedora, right?
>

Wrong, linuxfromscratch (sysv version) and beyond linuxfromscratch
plus extras such as chronyd. The only initrd is on the haswell, and just
for intel microcode.

> The problem which most people are seeing turns out to be a terrible
> interaction between dracut-fips, systemd and a Red Hat specific patch
> to libgcrypt for FIPS/FEDRAMP compliance:
>
> https://src.fedoraproject.org/rpms/libgcrypt/blob/master/f/libgcrypt-1.6.=
2-fips-ctor.patch#_23
>
> Uninstalling dracut-fips and recreating the initramfs might also help.
>
> One of the reasons why I didn't see the problem when I was developing
> the remediation patch for CVE-2018-1108 is because I run Debian
> testing, which doesn't have this particular Red Hat patch.
>
>> The latter certainly lets it boot in a reasonable time, but people
>> who understand this seem to regard it as untrustworthy.  For users
>> of /dev/urandom that is no big deal, but does it not mean that the
>> values from /dev/random will be similarly untrustworthy and
>> therefore I should not use this machine for generating long-lived
>> secure keys ?
>
> This really depends on how paranoid / careful you are.  Remember, your
> keyboard controller was almost certainly built in Shenzhen, China, and
> Matt Blaze published a paper on the Jitterbug in 2006:
>
>         http://www.crypto.com/papers/jbug-Usenix06-final.pdf
>
> In practice, after 30 minutes of operation, especially if you are
> using the keyboard, the entropy pool *will* be sufficiently
> randomized, whether or not it was sufficientl randomized at boot.  The
> real danger of CVE-2018-1108 was always long-term keys generated at
> first boot.  That was the problem that was discussed in the "Mining
> your p's and q's: Detection of Widespread Weak Keys in Network
> Devices" (see https://factorable.net).
>
> So generating long-lived keys means (a) you need to be sure you trust
> all of the software on the system --- some very paranoid people such
> as Bruce Schneier used a freshly installed machine from CD-ROM that
> was never attached to the network before examining materials from
> Edward Snowden, and (b) making sure the entropy pool is initialized.
>
> Remember we are constantly feeding input from the hardware sources
> into the entropy pool; it doesn't stop the moment we think the entropy
> pool is initialized.  And you can always mix extra "stuff" into the
> entropy pool by echoing the results of say, taking series of dice
> rolls, aond sending it via the "cat" or "echo" command into
> /dev/urhandom.
>
> So it should be possible to use the machine for generated long lived
> keys; you might just need to be a bit more careful before you do it.
> It's really keys generated automatically at boot that are most at risk
> --- and you can always regenerate the host SSH keys after a fresh
> install.  In fact, what I have done in the past when I first login to
> a freshly created Cloud VM system is to run command like "dd
> if=3D/dev/urandom count=3D1 bs=3D256 | od -x", then login to VM, and then
> run "cat > /dev/urandom", and cut and paste the results of the od -x
> output into the guest VM, to better initialize the entropy pool on the
> VM before regenerating the host SSH keys.
>
> Cheers,
>
>                                         - Ted

Thanks. In that case I'll go with the simple fix (haveged).

=C4=B8en
