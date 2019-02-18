Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB208218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk+QZ2Ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfBREOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:14:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35534 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfBREO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:14:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id z19so26165151otm.2;
        Sun, 17 Feb 2019 20:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3zQ7MzetWIL4UARuFgAO2eqnT1z6SKxUJuSSbh4rHY=;
        b=Kk+QZ2LdlC6falH9icBuGeXSD0fGYCvW5G/Sm4q8ZY1gsb6jtBVNzIUG0DygDa3RCU
         qKTYwn/yWGjzJzMLy+V+ZXS1Kiu7tk9WovDjdbkku+nR1GFmAc8CBgYEWjYZZExfKfGU
         DD5H7h6MW23K79jyuOXq1VIkMyihmolsWgCjP69WREu3Rx+nNRO+jRCH4Ola5g+TEl9W
         +qzh8r4gtkKz3WfPrHzSesJDt8Y5QKDLmLJiMrkQqe+RZTRpbfhkeMv6X4d/prG7T4o6
         FjX1HOEsLDHDOtcEk5OeFcL+foH84Usvfw5SPZzzVy1i+fM8EmpsfXfQDhQVB9rny8SV
         mWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3zQ7MzetWIL4UARuFgAO2eqnT1z6SKxUJuSSbh4rHY=;
        b=o449jlmsCExrvibHgdvOUIYV3fn+U5rxChMYvKT8i5W2mg7rtsLTYRra8JZOqVntRb
         xBb9DePzYlQbMxuHmRIGCddFFKaIksm4r50KYglDs+Omi5HtBJB+7FSIJWVr0Th4fn1E
         eFiSKwHYdtU16qwcjHZ4VSuHpC8fn10bJsGd4WG0LMrMOJ7p6k04IOhpQa1r2JJ9Nm7C
         36CDsdRAYC49NWTHQxfsWBvGQ24lHvEtRL5CbfjXnvVgyr8QO7+YPS2Y/XXXrJRoaKUm
         Id38YWK2iU+y2X1cEn8szHGMz8oQo4edpy6t47VpGEg6uCKOcyHA+82Al0RC49FYDjvz
         i5xg==
X-Gm-Message-State: AHQUAubK87aLGLtu20rVR3FmE05pKptqMlv6kncerGaw+rCk9aB2j5RJ
        K8np3S9K5pkI3wOBz6h+GKWhfE1B5JzJtrp7898=
X-Google-Smtp-Source: AHgI3IaRjtBzmI3kHY+NZWl3+2f8BqZNMgfoSDbBhXtKUYXk5sdyOy2PqNHTEroo2QAuvZ2iM3BGiBsGsk5T9uNBtmw=
X-Received: by 2002:a9d:7417:: with SMTP id n23mr12615458otk.63.1550463268605;
 Sun, 17 Feb 2019 20:14:28 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190215105644eucas1p19d0bdab386354cff0a9a354b5e33f0fe@eucas1p1.samsung.com>
 <20190215105638.17476-1-m.szyprowski@samsung.com>
In-Reply-To: <20190215105638.17476-1-m.szyprowski@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 18 Feb 2019 09:44:18 +0530
Message-ID: <CANAwSgRHhX8t7hDzfy2y6hggUiORRcLZ1VyM_UsDyiRTJ9L12w@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: pm: fix HYP/SVC mode mismatch when MCPM is used
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, 15 Feb 2019 at 21:40, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> MCPM does a soft reset of the CPUs and uses common cpu_resume() routine to
> perform low-level platform initialization. This results in a try to install
> HYP stubs for the second time for each CPU and results in false HYP/SVC
> mode mismatch detection. The HYP stubs are already installed at the
> beginning of the kernel initialization on the boot CPU (head.S) or in the
> secondary_startup() for other CPUs. To fix this issue MCPM code should use
> a cpu_resume() routine without HYP stubs installation.
>
> This change fixes HYP/SVC mode mismatch on Samsung Exynos5422-based Odroid
> XU3/XU4/HC1 boards.
>
> Fixes: 3721924c8154 ("ARM: 8081/1: MCPM: provide infrastructure to allow for MCPM loopback")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---

Please add my.

Tested-by: Anand Moon <linux.amoon@gmail.com>

[    0.701094] smp: Brought up 1 node, 8 CPUs
[    0.701212] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.701329] CPU: All CPU(s) started in HYP mode.
[    0.701421] CPU: Virtualization extensions available.


> v2:
> - fixed support for Thumb-mode kernel
> ---
>  arch/arm/common/mcpm_entry.c   |  2 +-
>  arch/arm/include/asm/suspend.h |  1 +
>  arch/arm/kernel/sleep.S        | 12 ++++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index ad574d20415c..1b1b82b37ce0 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
>         unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>         phys_reset_t phys_reset;
>
> -       mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> +       mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
>         setup_mm_for_reboot();
>
>         __mcpm_cpu_going_down(cpu, cluster);
> diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
> index 452bbdcbcc83..506314265c6f 100644
> --- a/arch/arm/include/asm/suspend.h
> +++ b/arch/arm/include/asm/suspend.h
> @@ -10,6 +10,7 @@ struct sleep_save_sp {
>  };
>
>  extern void cpu_resume(void);
> +extern void cpu_resume_no_hyp(void);
>  extern void cpu_resume_arm(void);
>  extern int cpu_suspend(unsigned long, int (*)(unsigned long));
>
> diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
> index a8257fc9cf2a..5dc8b80bb693 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -120,6 +120,14 @@ ENDPROC(cpu_resume_after_mmu)
>         .text
>         .align
>
> +#ifdef CONFIG_MCPM
> +       .arm
> +THUMB( .thumb                  )
> +ENTRY(cpu_resume_no_hyp)
> +ARM_BE8(setend be)                     @ ensure we are in BE mode
> +       b       no_hyp
> +#endif
> +
>  #ifdef CONFIG_MMU
>         .arm
>  ENTRY(cpu_resume_arm)
> @@ -135,6 +143,7 @@ ARM_BE8(setend be)                  @ ensure we are in BE mode
>         bl      __hyp_stub_install_secondary
>  #endif
>         safe_svcmode_maskall r1
> +no_hyp:
>         mov     r1, #0
>         ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
>         ALT_UP_B(1f)
> @@ -163,6 +172,9 @@ ENDPROC(cpu_resume)
>
>  #ifdef CONFIG_MMU
>  ENDPROC(cpu_resume_arm)
> +#endif
> +#ifdef CONFIG_MCPM
> +ENDPROC(cpu_resume_no_hyp)
>  #endif
>
>         .align 2
> --
> 2.17.1
>
