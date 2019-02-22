Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF7C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E1E20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JyIqirOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfBVRsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:48:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45036 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVRsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:48:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so1414478pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=we84lDYKq2v35AQGv4xZyNfYPHqFaFGr/WjX5MhHLzg=;
        b=JyIqirODs+RKMhl8Un4FfUhpwbFekVWNRnBioL01jwGSRBQYO695cTKRCabesNKKZs
         LAtC4Gc9VS64KjYnjKS+RuqJlCMbB5pOK4qyTZP1Z3IVTWBGO9tF23cdlv66qakSX/RI
         bF6kH9hYNi94+uGPU9/PQ+jAxcfKaWRFoCV8KjSuL+hOk/QSmi+RByqw0hcLfi6Q4yT/
         AphMTg4bYzmzuBsDeTii/6sgVVZmxiQsm5Rqp8MN3PgbCkh9KuLV56Zt1RaBzpgBK4I4
         21oFpxkE1e5FIUnR7lxFRPkPPbkbDXcd0Fxw9bztSQbRdHIH9Jgo45cQRNGQB9zidnmb
         WZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=we84lDYKq2v35AQGv4xZyNfYPHqFaFGr/WjX5MhHLzg=;
        b=JBnnqmnGtz5mmAgpR6afVuZPZivBGJ1xmg29vhrtIPodqiq0ozgu/NdcySBsSyyhC/
         dJM64l/FSYTYMqBAmYrpinnO9lV76nwtZstXX4tp0kXgpyE1m9vfJDZIXAY6gOCOdzQA
         AxNWW+4ylM1m+RAAZIOPoCeHdJv3E/GonBEe6N3tkqbsr7K0tWiCGD7U3XDfmMiAmFUd
         KVOKN+1w+OWeCm0T4tnGwG9AjILYp7akzYVGykM//3BRmkN5KaNh9tjKLhnMCwKZ+ACZ
         e/nT0PSe2Y+Yflh79CGZd5JFk6ObK02YReXX5o9IDmxCK9SEW0tsS/nnUHSpf+BJJgra
         wiLg==
X-Gm-Message-State: AHQUAua2MfOzPgmkAFxQhx5czint7F+9y2UEUCbIDUl+Iu+lgLE2k5LJ
        9tSdrKcTmDYkkp3alY/sVTBIBQ==
X-Google-Smtp-Source: AHgI3IYyTmkn1hc04F59MKeffiMfwIvtLAdNApRBEnVtp9h+rVlxZxraNsgYMqorTOp6E/l9Do7qTg==
X-Received: by 2002:a63:4342:: with SMTP id q63mr5103092pga.63.1550857703313;
        Fri, 22 Feb 2019 09:48:23 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:583:160:a579:fc1e? ([2601:646:c200:7429:583:160:a579:fc1e])
        by smtp.gmail.com with ESMTPSA id w128sm3293695pfw.79.2019.02.22.09.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 09:48:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access kernel memory that can fault
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16D57)
In-Reply-To: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
Date:   Fri, 22 Feb 2019 09:48:21 -0800
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD9148E4-00CC-4711-82D3-957D28497057@amacapital.net>
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org> <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com> <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net> <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com> <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com> <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com> <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org> <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org> <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 22, 2019, at 9:43 AM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>> On Fri, Feb 22, 2019 at 12:35 AM Masami Hiramatsu <mhiramat@kernel.org> w=
rote:
>>=20
>> Or, can we do this?
>>=20
>> long __probe_user_read(void *dst, const void *src, size_t size)
>> {
>=20
> Add a
>=20
>        if (!access_ok(src, size))
>                ret =3D -EFAULT;
>        else {
> .. do the pagefault_disable() etc ..
>        }
>=20
> to after the "set_fs()", and it looks good to me. Make it clear that
> yes, this works _only_ for user reads.
>=20
> Adn that makes all the games with "kernel_uaccess_faults_ok"
> pointless, so you can just remove them.
>=20
> (note that the "access_ok()" has to come after we've done "set_fs()",
> because it takes the address limit from that).
>=20
> Also, since normally we'd expect that we already have USER_DS, it
> might be worthwhile to do this with a wrapper, something along the
> lines of
>=20
>        mm_segment_t old_fs =3D get_fs();
>=20
>        if (segment_eq(old_fs, USER_DS))
>              return __normal_probe_user_read();
>        set_fs(USER_DS);
>        ret =3D __normal_probe_user_read();
>        set_fs(old_fs);
>        return ret;
>=20
> and have that __normal_probe_user_read() just do
>=20
>        if (!access_ok(src, size))
>                return -EFAULT;
>        pagefault_disable();
>        ret =3D __copy_from_user_inatomic(dst, ...);
>        pagefault_enable();
>        return ret ? -EFAULT : 0;
>=20
> which looks more obvious.
>=20
> Also, I would suggest that you just make the argument type be "const
> void __user *", since the whole point is that this takes a user
> pointer, and nothing else.
>=20
> Then we should still probably fix up "__probe_kernel_read()" to not
> allow user accesses. The easiest way to do that is actually likely to
> use the "unsafe_get_user()" functions *without* doing a
> uaccess_begin(), which will mean that modern CPU's will simply fault
> on a kernel access to user space.
>=20
> The nice thing about that is that usually developers will have access
> to exactly those modern boxes, so the people who notice that it
> doesn't work are the right people.

We use probe_kernel_read() from oops code. I=E2=80=99d rather it return -EFA=
ULT than oops harder and kill the first oops.

