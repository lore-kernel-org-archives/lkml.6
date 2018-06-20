Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C6DC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7E020874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dfqrv+YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7E020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeFTWMl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:12:41 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:33567 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeFTWMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:12:40 -0400
Received: by mail-ot0-f172.google.com with SMTP id h6-v6so1310473otj.0;
        Wed, 20 Jun 2018 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=n0JJgMHiZCGBAEW0VFx0cghFRnQIvnxOTMSauwV5jW0=;
        b=Dfqrv+YK03mufQRdGFykMg1zOtc7raiL9yGU4JHbg6fyBhmNDJ3NRRN38IQ/aXQcuL
         I6+PzIGi+ZLimKPKCu5hrI92iSiwYIREeTsvhSq+rVVPRbWMwj/y5U22PlrwARnKeG/I
         7SB6+unqS7kjEZ/ja6ITzBuLb/9L0nlwjxo6jPGEoz8mygCenjW0KyU10EWDAQc5r7pT
         vScKdNaAY/do8+5vVNz3+1cWQ7axY8Klr87HfuFplw/+Dd+KDWK4DOy7wyiIYsWHWSAF
         wdylIQzOCmj6lfl8njBF2+hmkToeV6TFNqfxWZk78ZqH/KLcvP29HxNSJMrR60MPpfLk
         /eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=n0JJgMHiZCGBAEW0VFx0cghFRnQIvnxOTMSauwV5jW0=;
        b=ODRLPrv7TfPKhbvBD1bE4QnPihiodSHlAideM8MEhZIoCVt8Yl+CbTNCjwdLDwS637
         UZV5WxDD2IFFe5L42yGHDpCIRvxY/pjjsV7UXnCCuYojr99XZU3+R3MAkSw1i/J6lEze
         Kg2917pZVP20TbN84aH7BFRDvz33zbVpepNAfMFe7hrZoYYVTen4k17C7c158JkLMTgm
         iLBBqsrPcAQIudUUGU7lbj57T1cNkCgdVmMHFONXZTfodAQ1PmbIDlR9eximgK1AEokb
         D0ms1aIrsKZvn++m0Hk7Bz1hdDMn+6bt68keZJsCS+V9M5rSnBLNsx+YJMNcI1SVX77V
         sp1Q==
X-Gm-Message-State: APt69E114FUFAwYM96iFiRKVLiQvgVc6l2HOroLNV4xAgoPJInhH6WTm
        N2gny09AaaV6F0EVXdnPgqDX6rcMhYEzPdtl9qg=
X-Google-Smtp-Source: ADUXVKI4o/gb3c6CscGWwEFoCTuPXznlkGuZidJu1NrZWlJyS8f+TDesMfXoAD0jPxccVAOmyzF5zZfEpe25vPwqHxs=
X-Received: by 2002:a9d:60d2:: with SMTP id b18-v6mr13378591otk.305.1529532759334;
 Wed, 20 Jun 2018 15:12:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 15:12:38
 -0700 (PDT)
In-Reply-To: <s5hr2l1ciqg.wl-tiwai@suse.de>
References: <s5h8t7bfgnq.wl-tiwai@suse.de> <CAJZ5v0hidPav5kvTW05e0k5mouFyiUiyUW50=fDqVphbEBjQaA@mail.gmail.com>
 <s5hpo0ndvc5.wl-tiwai@suse.de> <s5hy3fac6ao.wl-tiwai@suse.de>
 <CAJZ5v0gWRfbtKG0w1UiM=KbtZYkhL2kj-W_9Q+PUP293sX35_Q@mail.gmail.com>
 <s5hbmc5oma2.wl-tiwai@suse.de> <s5hr2l1ciqg.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jun 2018 00:12:38 +0200
X-Google-Sender-Auth: 3anDMq_iWUTs3ndQns4JB03WSlg
Message-ID: <CAJZ5v0iYTLjK4eDsohPdB5Yut4TeGW=hBoCrZ-K=tRzNtXt4iw@mail.gmail.com>
Subject: Re: [REGRESSION] 4.17 failed to probe ACPI PnP
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Noah Davis <noahadvs@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:20 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 20 Jun 2018 11:11:17 +0200,
> Takashi Iwai wrote:
>>
>> On Wed, 20 Jun 2018 09:28:40 +0200,
>> Rafael J. Wysocki wrote:
>> >
>> > On Wed, Jun 20, 2018 at 8:37 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > On Tue, 19 Jun 2018 10:38:50 +0200,
>> > > Takashi Iwai wrote:
>> > >>
>> > >> On Tue, 19 Jun 2018 10:28:42 +0200,
>> > >> Rafael J. Wysocki wrote:
>> > >> >
>> > >> > On Tue, Jun 19, 2018 at 8:12 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > >> > > Hi,
>> > >> > >
>> > >> > > there seems a regression regarding the probe of ACPI PnP devices.
>> > >> > > The detailed logs are found in openSUSE bugzilla:
>> > >> > >   https://bugzilla.opensuse.org/show_bug.cgi?id=1098074
>> > >> >
>> > >> > But that's on this particular machine, not in general, right?
>> > >> >
>> > >> > At least I don't see this on any of the systems in my office.
>> > >>
>> > >> Yes, it looks so.  4.17 and later works on my several machines, too.
>> > >>
>> > >> >
>> > >> > > In short, since 4.17, the laptop keyboard is lost on ASUS K501UW.
>> > >> > > Comparing the kernel messages and other logs indicates that the
>> > >> > > complete lost of ACPI PnP devices:
>> > >> > >
>> > >> > > On 4.16:
>> > >> > > [    0.390244] pnp: PnP ACPI: found 9 devices
>> > >> > >
>> > >> > > On 4.17:
>> > >> > > [    0.263266] pnp: PnP ACPI: found 0 devices
>> > >> > >
>> > >> > > ... and this leads to the failure of PS/2 keyboard detection due to
>> > >> > > the missing PNP030b entry as a result.
>> > >> > >
>> > >> > > Any hints for debugging this are appreciated.
>> > >> >
>> > >> > It looks like this may be related to the ACPICA changes that went in
>> > >> > during the 4.17 cycle.
>> > >> >
>> > >> > I would try 4.18-rc1 as there is an ACPICA fix in it that may be
>> > >> > related to this in theory.  If that doesn't help, I'd focus on the
>> > >> > ACPICA changes.
>> > >>
>> > >> OK, Noah, could you test later the kernel in OBS Kernel:HEAD repo?
>> > >> Now 4.18-rc1 kernel is being built there, and hopefully will finish
>> > >> soon later.
>> > >
>> > > 4.18-rc1 was confirmed to work, so something had fixed it.
>> >
>> > Please check this commit
>> >
>> > 5088814a6e93 ACPICA: AML parser: attempt to continue loading table after error
>> >
>> > None of the other ACPICA commits that have gone in since 4.17 should
>> > affect the behavior at hand.
>>
>> OK, I'm building a test kernel with this backport.  Stay tuned.
>
> The result looks positive, things seem working with the backport.
>
> Care to send it to Greg for 4.17.x stable?  Thanks!

Will do tomorrow, thanks!
