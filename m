Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3085C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24B921872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lqe+JqFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbfBAKJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:09:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55261 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfBAKJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:09:56 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so8308854ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJGU6V0Qpvv03UVFSHLRsVJebkWB5dQmQ6QU9nLThiA=;
        b=Lqe+JqFvQaMlkAbWLM69XZaGSWD9E/2GEfDn0m+WPVGATOFTTJTR1Fm22+Fm2ynlfO
         033BBD4y98Z1ldvo023zNiuEP0khx+E9HA8Zvx8JI44sTa2ECt5Iir0m+oL1iXG7alPs
         uy0q4OTR+JK6c9tXBdRsGFnUVjou+kRQ04FFnz9hhQu/gz1PRTesKd4tb/lb7EBNymrR
         MOp29ulgvhx0xK5HtlljsdnxsQ7ZbrMzwgq8yS+yDmAe5VtyHZcHJsNA83qKsJdF8r5r
         EmwYVqpIgVTqiXpwt9VfEEdaHwHqxPCNXtX5eONx/2D+Ti7sNIzv0FAvdoUKyo5hyjXZ
         XJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJGU6V0Qpvv03UVFSHLRsVJebkWB5dQmQ6QU9nLThiA=;
        b=P7z4zAfBvVhgz/QyFqSEoJvCX7LQLZ7bivoLayEQx6vCyh9mU2cPpy6nxHhRc8wdkY
         CjkwAbkqmPiPa2qQ9KNqdXV4bnzgE/Yi+MPZNDKWf0FV0iFmygfnf6GiKaRBq024RmRs
         j9JVOhlxiYeqewI895tMIZicBS9oQv5yqTyhI2xs5SWt9yMBMk819CI8GFSu/98mVU+o
         4B0IfZ+2csbH7ksVTckS5RIEexS6YL1VwkWEenKWShXqlBZrCSTiFUxRoXu6SXlF/sHB
         M/J++5KeV7NxJFGBMufqQylyCHnpjR+ze9fPozOjTI8pPWgGJN9ot6DuUEifz8+jqmlm
         So9w==
X-Gm-Message-State: AHQUAuYAcdvWPGRZhnpQ24kHLO6HnYAyGEvHml2ErsA8/fgkDJnj8N/0
        B/4TztepAZTqZyOzQMV2Ylm8gOHfpfWmmKVOdWJ24w==
X-Google-Smtp-Source: AHgI3IY0C98e7apxvaBySppHi/qzCF0V3IK3EhrE50IZHuCn6SKuJ2pqp7TS1Ted9Dh4kYnjOZEjWMiPraX3TKAGI00=
X-Received: by 2002:a24:6511:: with SMTP id u17mr1023990itb.12.1549015795099;
 Fri, 01 Feb 2019 02:09:55 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c178e305749daba4@google.com> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov> <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com> <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <e598f3c7-22bc-91c2-2f47-0eec068f5180@I-love.SAKURA.ne.jp>
 <CACT4Y+YXsD4f+ngzN7SGXcUGBn-jG1KeyrZJBzcUWo-AbdTe4w@mail.gmail.com> <05340d28-36c2-267e-d54e-416fddfba211@i-love.sakura.ne.jp>
In-Reply-To: <05340d28-36c2-267e-d54e-416fddfba211@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Feb 2019 11:09:42 +0100
Message-ID: <CACT4Y+Ynyy-bMK4cxhgNoAaauFdjzExuELM6u0amksbR4wy7GQ@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 1:23 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/30 23:45, Dmitry Vyukov wrote:
> >> Dmitry, is it possible to update configs for linux-next.git , for
> >> we want to test a big change in LSM which will go to Linux 5.1 ?
> >>
> >> TOMOYO security module (CONFIG_SECURITY_TOMOYO=y) can now coexist with
> >> SELinux/Smack/AppArmor security modules, and SafeSetID security module
> >> (CONFIG_SECURITY_SAFESETID=y) was added. Testing with these modules also
> >> enabled might find something...
> >
> > Hi,
> >
> > syzbot configs/cmdline args are stored here:
> > https://github.com/google/syzkaller/tree/master/dashboard/config
> >
> > I've tried to update to the latest kernel, the diff is below.
> > Few questions:
> > 1. How are modules enabled now?
> > We pass security=selinux of security=smack on command line. What do we
> > need to pass now to enable several modules at the same time?
>
> Removing security= parameter from kernel boot command line will do it.
>
>   security/apparmor/lsm.c:        .flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>   security/selinux/hooks.c:       .flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>   security/smack/smack_lsm.c:     .flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>   security/tomoyo/tomoyo.c:       .flags = LSM_FLAG_LEGACY_MAJOR,
>   security/security.c:                    if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
>
> But this means that, if same kernel config/cmdline are used between
> linux-next.git and linux.git (etc.), syzbot will need to choose from
>
>  (a) stop sharing kernel cmdline between linux-next.git and linux.git (etc.)
>
> or
>
>  (b) stop sharing kernel config between SELinux, Smack and AppArmor
>
> or
>
>  (c) start testing after the LSM changes went to linux.git as Linux 5.1-rc1
>
> . Is (a) or (b) possible? If this is a too much change, (c) will be OK.


Thanks for the explanations.

Here is the change that I've come up with:
https://github.com/google/syzkaller/commit/aa53be276dc84aa8b3825b3416542447ff82b41a

I've disabled CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER (it
actually looked like omitting a user-space loader that I don't have is
the right thing to do, but okay, it indeed does not with =y).

For now I just enabled TOMOYO and SAFESETID.
I see the problem with making both linux-next and upstream work. If we
use a single config and lsm= cmdline argument, then on upstream all
kernels will use the same module (they won't understand lsm=). But if
we add security= then it will take precedence over lsm= on linux-next,
so we won't get stacked modules.

Let's go with (c) because I don't want an additional long-term maintenance cost.
If I understand it correctly later we will need to replace:
security=selinux
security=smack
security=apparmor

with:
lsm=yama,safesetid,integrity,selinux,tomoyo
lsm=yama,safesetid,integrity,smack,tomoyo
lsm=yama,safesetid,integrity,tomoyo,apparmor
