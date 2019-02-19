Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B246E217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8RP/xCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfBSFls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:41:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40991 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSFlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:41:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so9540665pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=+EU00narZM+oAtb9nqVNjy8vCYE2Vcg6Zve0xM2lu1U=;
        b=k8RP/xCUxV5xtkryv/jf100lW4O5XaRbWAMk287JpR5LmMSL1lZAChVuWUoJxPOD3L
         hVov2BLsWjOMpP6nm4uVflQ+ATADIyGsuNwlawetV47BcEQ6zfD5kCgmH2hIQq04hYpZ
         tJkMCDsjVcHEXR9EKVOC+GJvBbJM/UNQmZQGnTMM5HX7F+TPT/bB4naLtaS4abrs7RCN
         ZFL+bzXRxyH3MBl62uTO9zC9fr2Co2LZQQYgM9FWtTWIuz+26nt4iBMsxPw2SXv6Wmkl
         Cojtg8EKS5le5bt280Xkwd7XVAB+GkykE9UrnBhMw31oI+5k6rLUd7HaEOu90FEj3Pws
         Vgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=+EU00narZM+oAtb9nqVNjy8vCYE2Vcg6Zve0xM2lu1U=;
        b=ZWcRrIxhAMlY8cTAokZDsp4v0wmUIZAOKc8YXkShnuD8yDu6uLhLQWuV4E9gLA/Wno
         frpF4Oxvpps38jIwLliW5yupAjc0dqYDOnrt3iF7fDBr9BnuuCRoZKGz1wPGEBgHg/oF
         GXB0oOCdnuKWW/kwdhLagzyuJ5j7iGPLyMeQUzJMOkzwRgpeA86qoxK73MJF4BNcZJUi
         /ZCH/0TTve6MB7HWuOCbtUjeXZn+kgcEhU/2joFB2Zcos93JX7+z+Au7OebSN+vJeNWA
         VmSBeWhTTbj4KTdY4r6i6LsguQXLuMhlpPurHws8zStb7GCpoui8bq2VpYTqctDvztZR
         pJvw==
X-Gm-Message-State: AHQUAuYWYh8Cszz/wH5r5CfSjsgIjTYQ4EV0Zy5YCmzfs+EqCGwbgTsh
        gvZZjUl4iVOi0UXoMVoRS5Q=
X-Google-Smtp-Source: AHgI3IYKIZExQR5r3/aPnC9yZU1oFOJPqaz46Q01uOmBSGih1YxF52Jq80uYH8490YaGWWQstq/MpQ==
X-Received: by 2002:a63:698a:: with SMTP id e132mr22420032pgc.136.1550554906838;
        Mon, 18 Feb 2019 21:41:46 -0800 (PST)
Received: from localhost ([61.69.157.156])
        by smtp.gmail.com with ESMTPSA id v15sm14400741pfa.75.2019.02.18.21.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 21:41:46 -0800 (PST)
Date:   Tue, 19 Feb 2019 15:41:38 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH v1] powerpc/accounting: do not account system time on
 transition to user.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <a952f14712b90f182c0fcace434b2a0e9f21ed9f.1549636481.git.christophe.leroy@c-s.fr>
In-Reply-To: <a952f14712b90f182c0fcace434b2a0e9f21ed9f.1549636481.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550554276.8eb89h3g4q.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy's on February 9, 2019 12:40 am:
> Time spent in kernel mode don't need to be accounted on transition
> to user space. As far as the time spent in user is known, it
> is possible to calculate the time spent in kernel by substracting
> the time spent in user.
>=20
> To do so, this patch modifies vtime_delta() to substract the
> time spent in user since the last call to vtime_delta().
>=20
> This patch gives a 2% improvment of null_syscall() selftest on a 83xx.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This looks like a clever little optimization, although I don't know
this time accounting code very well.

> ---
> But surprisingly, this patch degrades the null_syscall selftest by 20% on=
 the 8xx. Any idea of the reason ?

I don't know microarchitecture of any of those CPUs I'm afraid.
On the 64s CPUs, mftb is what hurts.

>=20
>  arch/powerpc/include/asm/accounting.h | 1 +
>  arch/powerpc/include/asm/ppc_asm.h    | 8 +-------
>  arch/powerpc/kernel/asm-offsets.c     | 8 ++------
>  arch/powerpc/kernel/time.c            | 4 +++-
>  4 files changed, 7 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/accounting.h b/arch/powerpc/include=
/asm/accounting.h
> index c607c5d835cc..2f1ff5f9fd7a 100644
> --- a/arch/powerpc/include/asm/accounting.h
> +++ b/arch/powerpc/include/asm/accounting.h
> @@ -27,6 +27,7 @@ struct cpu_accounting_data {
>  	/* Internal counters */
>  	unsigned long starttime;	/* TB value snapshot */
>  	unsigned long starttime_user;	/* TB value on exit to usermode */
> +	unsigned long utime_asm;
>  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
>  	unsigned long startspurr;	/* SPURR value snapshot */
>  	unsigned long utime_sspurr;	/* ->user_time when ->startspurr set */
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/as=
m/ppc_asm.h
> index e0637730a8e7..be17d570d484 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -28,9 +28,8 @@
>  #define ACCOUNT_STOLEN_TIME
>  #else
>  #define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)				\
> -	MFTB(ra);			/* get timebase */		\
>  	PPC_LL	rb, ACCOUNT_STARTTIME_USER(ptr);			\
> -	PPC_STL	ra, ACCOUNT_STARTTIME(ptr);				\
> +	MFTB(ra);			/* get timebase */		\
>  	subf	rb,rb,ra;		/* subtract start value */	\
>  	PPC_LL	ra, ACCOUNT_USER_TIME(ptr);				\
>  	add	ra,ra,rb;		/* add on to user time */	\
> @@ -38,12 +37,7 @@
> =20
>  #define ACCOUNT_CPU_USER_EXIT(ptr, ra, rb)				\
>  	MFTB(ra);			/* get timebase */		\
> -	PPC_LL	rb, ACCOUNT_STARTTIME(ptr);				\
>  	PPC_STL	ra, ACCOUNT_STARTTIME_USER(ptr);			\
> -	subf	rb,rb,ra;		/* subtract start value */	\
> -	PPC_LL	ra, ACCOUNT_SYSTEM_TIME(ptr);				\
> -	add	ra,ra,rb;		/* add on to system time */	\
> -	PPC_STL	ra, ACCOUNT_SYSTEM_TIME(ptr)
> =20
>  #ifdef CONFIG_PPC_SPLPAR
>  #define ACCOUNT_STOLEN_TIME						\
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 7a1b93c5af63..f2ba7735f56f 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -260,19 +260,15 @@ int main(void)
>  	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
>  	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
>  	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
> -	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
>  	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
> -	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
> -	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.stime);
> +	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime_asm);
>  	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
>  	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
>  	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
>  #else /* CONFIG_PPC64 */
>  #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> -	OFFSET(ACCOUNT_STARTTIME, thread_info, accounting.starttime);
>  	OFFSET(ACCOUNT_STARTTIME_USER, thread_info, accounting.starttime_user);
> -	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.utime);
> -	OFFSET(ACCOUNT_SYSTEM_TIME, thread_info, accounting.stime);
> +	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.utime_asm);
>  #endif
>  #endif /* CONFIG_PPC64 */
> =20
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index bc0503ef9c9c..79420643b45f 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -331,8 +331,10 @@ static unsigned long vtime_delta(struct task_struct =
*tsk,
>  	WARN_ON_ONCE(!irqs_disabled());
> =20
>  	now =3D mftb();
> -	stime =3D now - acct->starttime;
> +	stime =3D now - acct->starttime - acct->utime_asm;
>  	acct->starttime =3D now;
> +	acct->utime +=3D acct->utime_asm;
> +	acct->utime_asm =3D 0;
> =20
>  	*stime_scaled =3D vtime_delta_scaled(acct, now, stime);
> =20
> --=20
> 2.13.3
>=20
>=20
=
