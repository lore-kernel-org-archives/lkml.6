Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C8ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EFE208D9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRjnH5MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EFE208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392011AbeIVGQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:16:41 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46937 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392310AbeIVGQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:16:07 -0400
Received: by mail-pl1-f180.google.com with SMTP id t20-v6so3185451ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 17:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+TOgrEwVnEXJEcuIqzFeMU27oc0sGjBDlpF4mDCP8lI=;
        b=KRjnH5MBsc9RtxCkQIL/fIohZy/q1UcA4o6rrZjEPIyw987FIWj+fddMmxvt7O9ppi
         s8+udjnBVw/M22iot9ZwBNFTjLwQ+XAjV4G5m/0g2jD8g8rNpXBoeiOw8Bw5XueypAys
         LTnay06uYRU09U4h19zT8JZhDG1y9b4T60soP3qUMSymvY+eceH8iC+VM7jidflRViSK
         XA2b/hs40BlzucJkzzg8e9IAFDYz3d9C6cmjy4wGKvr22d+HVB8V0PWPcUlgr97xmL7n
         uNWX27YnKl7M51UqQnBiYS9UsRJUY3qZ3Osi9A9CPBxnUb7S26fWmEAd59rcS15qn7Hh
         5Auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=+TOgrEwVnEXJEcuIqzFeMU27oc0sGjBDlpF4mDCP8lI=;
        b=HJ8vhwhXhGZhBEzYXag23z2mB/kn46nq1KQE/9lkqTCbq9UuTCuJpT6fu6bNQVLFus
         YPvY2ZnBGa/8NUR5wYGPk8SyOooN23I1Q6UJH4l4sdCSOcg75mtY2DMrHR1ei9hWdflH
         lpZzNvohyuSft08GRqpeqA6dChxm3iF1+8I+AVpUJIASovyfZOaHeDkbpqeRki6FZ/0W
         taJvqrPDMyVg2b+s7K394JN3alp3fmwMXAu1mAf0Ur+T0X5Cl+LbBuRefDpH+7mQkiGP
         qwE6iy7APayD6srIcbjsYUDaCzBPFMwU1xKkXbmU2z+bYhw7OWqnpWwvl4yBWgrEBJPF
         g7Uw==
X-Gm-Message-State: ABuFfojqx0UQdGyVOLKetYPoJi/r2Nm5wGpDguaiwhUw96N3N/jK8Aep
        h3k59gT93E6BKBGV0cIARqUpT69x1PFLfdMxsWQ=
X-Google-Smtp-Source: ACcGV62J5I0RHAyUnErLEtNPQvorxXrrWH/1R7fYb8m8vqWzOsgkwuqYgy++a0TA6Yue0ZSRhqJKFz0eHAK0q88qO8k=
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr117265pld.312.1537575888881;
 Fri, 21 Sep 2018 17:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org> <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
 <20180922000521.u373eysq6dogcdfo@gmail.com>
In-Reply-To: <20180922000521.u373eysq6dogcdfo@gmail.com>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Fri, 21 Sep 2018 20:24:35 -0400
Message-ID: <CAKON4OxCpCMETfg087wV+ZQ3ssA7eDA8gBSxMYFL9ykVfEGwww@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     joeypabalinas@gmail.com, Theodore Tso <tytso@mit.edu>,
        dreamingforward@gmail.com, fche@redhat.com, riel@surriel.com,
        ec429@cantab.net, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 8:05 PM Joey Pabalinas <joeypabalinas@gmail.com> wr=
ote:
>
> On Fri, Sep 21, 2018 at 07:31:05PM -0400, jonsmirl@gmail.com wrote:
> > On Fri, Sep 21, 2018 at 7:17 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > People can decide who they want to respond to, but I'm going to gentl=
y
> > > suggest that before people think about responding to a particular
> > > e-mail, that they do a quick check using "git log --author=3Dxyzzy@ex=
ample.com"
> > > then decide how much someone appears to be a member of the community
> > > before deciding how and whether their thoughts are relevant.
> >
> > How does this part apply to email addresses used to commit code?
> >
> > * Publishing others=E2=80=99 private information, such as a physical or=
 electronic
> > address, without explicit permission
> >
> > It appears to me that this would conflict with the GPL since the GPL
> > granted the right to distribute (or even print it in a book) Linux and
> > Linux contains email addresses.  This also seems contradictory with
> > the Reply button I used to send this email.
>
> I don't really think email addresses used in patches which are sent,
> voluntarily, to a public mailing list are something you can sanely
> consider "private information".
>
> > How do you reconcile working on a public project while keeping email
> > address secret?
>
> This is a little more delicate, and I admit that I can't really
> think of any real solutions for this part...

I would propose adding a statement to clarify that Linux is a public
project and because of this things like names and email addresses of
people working on the project are public information. I don't see how
any other position is viable since it appears to be a GPL conflict.

But... it this bothers you, simply don't use your private, personal
email address when working on the kernel. Anyone with the skills to
work on the kernel should know enough to be able to create email
aliases. No rule says you have to use your real name either.

Aliases have been used in the past, search through the logs and you
will find a few commits from 'anonymous'. However, commits from
anonymous sources have to go through extra layers of review since the
identity of the contributor and their reputation is unknown.

If someone is using an email alias and has their hidden, true address
published then that would be a CoC violation. Although if you mess up
and submit a patch using your hidden identity, you just published it
and it is no longer hidden.


>
> --
> Cheers,
> Joey Pabalinas



--=20
Jon Smirl
jonsmirl@gmail.com
