Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F844222DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiK9P6dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395334AbfBNQFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:05:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46604 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389764AbfBNQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:05:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id i5so3841691qkd.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8URW38EG/birhvOd1CEttVcY4MAfmWXqwn5nAzVy4kw=;
        b=DiK9P6dVlYK1LD+uuGzFzqofcpOZmkVqJfbyV+F+qHsLCQZ0qpnDVwni1/bspwuc/2
         YqBwdsgunHF2wr1u/bqfUNfvk8Zsm53r9zfg25xKtVbotZ+PbLlKS4XALbJ7YI7Q44Ka
         sCwM29oB7mf9fu5zjIsaskI3E63iJTJ/OII/nHquC6C6YfEEZYbx7aPk8DyZ9QD/o+QT
         zJzuk3jTgXYOAWn6RS/CY/VYNrxIUgRa0o4pijhs6j8rBgy75k4mddxB14yu84jzSZkk
         +fwB25DVeSkjl3u/UsRSuSipRiVj5SlEse0x6hU2prSlJfqahX8Tn4F6MdCPA3XQ05bg
         UwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8URW38EG/birhvOd1CEttVcY4MAfmWXqwn5nAzVy4kw=;
        b=IXm6qGNDKkULCm2oRLjtbaXFplbxgk0OExerXeKKAzGVm7gipN1LLejwRepLFxbtL8
         RX2JlyKlJUlKwG7GLoSfv2eawdsqFoXr7JqyQh7ooY70jFeWkkKS0N3b3tykwMyYVvit
         gNDAY2Ae/kVN2FEuCVem1RF1Cvw68FaGD/d/Y9PEyXIZRWu9nzjHI4C7/RYU9y6NRzAI
         spSltWFwYKrfBF1cVQDoCbDe4t4IZ09uafw3ma60XzfkwQqEvQdCUjHVnOOB4XdYogfM
         doqysi0qMZCY9xc+bogMSpCg7e7zflQsBXmo+cfzqJ9P+QoJuea5eGT31nJHjsUN5q1D
         I8fg==
X-Gm-Message-State: AHQUAuYPSpMn2qXjc4LcruYsSaVnaUHfmHFT3vpWkzUg0iy/F8Gv7nwR
        vzb/vqKnyLSkvhscFFC24fYjxw==
X-Google-Smtp-Source: AHgI3IYMZhDLLqXZbh4N+Wx7TGf0hq6NMmZjomZ+SmjTnNVsjO9TA+C8xm6+QwiIeTqYncQWVF+EdQ==
X-Received: by 2002:a37:9c8f:: with SMTP id f137mr3406751qke.248.1550160322025;
        Thu, 14 Feb 2019 08:05:22 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id s15sm1507655qte.30.2019.02.14.08.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 08:05:21 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:05:20 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: Re: [PATCH] ARM: pm: fix HYP/SVC mode mismatch when MCPM is used
In-Reply-To: <20190214143114.24356-1-m.szyprowski@samsung.com>
Message-ID: <nycvar.YSQ.7.76.1902141104030.1594@knanqh.ubzr>
References: <CGME20190214143126eucas1p126506139ef72c1685654c8dac8957b3d@eucas1p1.samsung.com> <20190214143114.24356-1-m.szyprowski@samsung.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019, Marek Szyprowski wrote:

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

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/common/mcpm_entry.c   |  2 +-
>  arch/arm/include/asm/suspend.h |  1 +
>  arch/arm/kernel/sleep.S        | 11 +++++++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
> index ad574d20415c..1b1b82b37ce0 100644
> --- a/arch/arm/common/mcpm_entry.c
> +++ b/arch/arm/common/mcpm_entry.c
> @@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
>  	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>  	phys_reset_t phys_reset;
>  
> -	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
> +	mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
>  	setup_mm_for_reboot();
>  
>  	__mcpm_cpu_going_down(cpu, cluster);
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
> index a8257fc9cf2a..b856d183691e 100644
> --- a/arch/arm/kernel/sleep.S
> +++ b/arch/arm/kernel/sleep.S
> @@ -122,6 +122,11 @@ ENDPROC(cpu_resume_after_mmu)
>  
>  #ifdef CONFIG_MMU
>  	.arm
> +#ifdef CONFIG_MCPM
> +ENTRY(cpu_resume_no_hyp)
> +ARM_BE8(setend be)			@ ensure we are in BE mode
> +	b	0f
> +#endif
>  ENTRY(cpu_resume_arm)
>   THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
>   THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> @@ -135,6 +140,9 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
>  	bl	__hyp_stub_install_secondary
>  #endif
>  	safe_svcmode_maskall r1
> +#ifdef CONFIG_MCPM
> +0:
> +#endif
>  	mov	r1, #0
>  	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
>  	ALT_UP_B(1f)
> @@ -163,6 +171,9 @@ ENDPROC(cpu_resume)
>  
>  #ifdef CONFIG_MMU
>  ENDPROC(cpu_resume_arm)
> +#endif
> +#ifdef CONFIG_MCPM
> +ENDPROC(cpu_resume_no_hyp)
>  #endif
>  
>  	.align 2
> -- 
> 2.17.1
> 
> 
