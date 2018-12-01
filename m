Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F154AC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B441021473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iK/nvKC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B441021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLBDFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:05:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44779 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeLBDF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:05:29 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so4272263pfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xhgjRioIRuYJsyNEWfwjWG1geULHsOYtq+uhcMN4MHA=;
        b=iK/nvKC/t3tDgyI9k1+PXfmGJgFp114tKqmiZ/+ZF25uziT6uGVhm3gkEoGVZQznd4
         huzWkTxDTCrsfHOA9KDkCopnGLIMyi8FIHRg/niVb2Ugl3ZaIsWH4scYz6P4DJcQStiS
         gYFvnDTmBqDbn6QKExOdULFFrzMjr5QNwpbiQedYXO0hOzffKHIXVKQcIfkvQ4Ap3cFR
         0RFJxSynz+SL9u8aYbztInPmMQ0/VJiEyGFstF/ANWrU3Z/6CP9m/g+R3Np9rChIy+Gl
         X2aMPxqZPsPVoI9z+/g1LctvUljSu3LWCpD6AReN4GaIWhmNLAUo57OUA4hZMgf7nStO
         HqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xhgjRioIRuYJsyNEWfwjWG1geULHsOYtq+uhcMN4MHA=;
        b=gPYHqSdJnR5ZKIPs00z7qHh80KkmTnveKz/XJjkmYL05Es7tGcbKyOy7SbaqvU+Pfs
         of/n0sgljivIvglutwe/XrIWasYVqkcB4ByO3bsmZHw1z32eTdBKyZYBZ5fK4ysdNbLz
         KBTuMnp99is1cxG9htoSCCVx225EWUMEILUcmmc3DeowV1IUmGpAOYFod8iSWi0MJU8U
         piXtZQNLUxUqYfhZPNTAnLxk07HzW4T46Ce9G1rq4rxYB8VoZ86OQJaSJiBTLe+mFf5P
         gLqQr8HJUfdlf0/jw7ME9T4DtZwPiX+EHepDaer2YNHn6r7x+S7oveLqsYmZZppVCz7z
         6q6A==
X-Gm-Message-State: AA+aEWZUpzzcnP9PxTF+9OnPvGCx4LrYrSz2Y/VlhnOKPaCtrsvFTAJP
        ixtgymNMAIxI/XZGFbEBNCdz9Q==
X-Google-Smtp-Source: AFSGD/UcDF899RFDt1Km4lfyhrA1uZxzYa0dnCOZ5/HHY4FjeW8UaNoHPp4nL09jaNePRnC0BY0Mpg==
X-Received: by 2002:a63:6906:: with SMTP id e6mr8097620pgc.144.1543679560039;
        Sat, 01 Dec 2018 07:52:40 -0800 (PST)
Received: from ?IPv6:2600:1010:b01a:6438:c446:5087:16fa:e142? ([2600:1010:b01a:6438:c446:5087:16fa:e142])
        by smtp.gmail.com with ESMTPSA id i123sm19395028pfg.164.2018.12.01.07.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 07:52:38 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <87tvjxp8pc.fsf@xmission.com>
Date:   Sat, 1 Dec 2018 07:52:37 -0800
Cc:     Arnd Bergmann <arnd@arndb.de>, christian@brauner.io,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F53D6D38-3521-4C20-9034-5AF447DF62FF@amacapital.net>
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com> <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io> <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com> <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net> <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com> <87y399s3sc.fsf@xmission.com> <87tvjxp8pc.fsf@xmission.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 1, 2018, at 7:28 AM, Eric W. Biederman <ebiederm@xmission.com> wrot=
e:
>=20
>=20
> It just occurs to me that the simple way to implement
> procfd_sigqueueinfo info is like:
>=20
> int copy_siginfo_from_user_any(kernel_siginfo_t *info, siginfo_t *uinfo)
> {
> #ifdef CONFIG_COMPAT
>    if (in_compat_syscall)
>        return copy_siginfo_from_user32(info, uinfo);
> #endif
>    return copy_siginfo_from_user(info, uinfo);                       =20
> }
>=20
> long procfd_sigqueueinfo(int fd, siginfo_t *uinfo)
> {
>    kernel_siginfo info;
>=20
>        if (copy_siginfo_from_user_any(&info, uinfo))
>            return -EFAULT;
>    ...;               =20
> }
>=20
> It looks like there is already a place in ptrace.c that already
> hand rolls copy_siginfo_from_user_any.
>=20
> So while I would love to figure out the subset of siginfo_t tha we can
> just pass through, as I think that would make a better more forward
> compatible copy_siginfo_from_user32.

Seems reasonable to me. It=E2=80=99s less code overall than any other sugges=
tion, too.

>  I think for this use case we just
> add the in_compat_syscall test and then we just need to ensure this new
> system call is placed in the proper places in the syscall table.
>=20
> Because we will need 3 call sights: x86_64, x32 and ia32.  As the layout
> changes between those three subarchitecuters.
>=20
>=20

If it=E2=80=99s done this way, it can just be =E2=80=9Ccommon=E2=80=9D in th=
e 64-bit table. And we kick the can a bit farther down the road :)

I=E2=80=99m working on patches to clean up x86=E2=80=99s syscall mess. It=E2=
=80=99s slow because I keep finding new messes.  So far I have rt_sigreturn w=
orking like every other syscall =E2=80=94 whee.

Also, Eric, for your edification, I have a draft patch set to radically simp=
lify x86=E2=80=99s signal delivery and return.  Once that=E2=80=99s done, I c=
an trivially speed up delivery by a ton by using sysret.


