Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07926C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29E220844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UGwBSrc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29E220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbeGYW6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:58:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44873 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbeGYW6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:58:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so6132569pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YbNOpDJFzgCs01B4eVAYfCjNeyVyNyBdmNF8v/bcsqY=;
        b=UGwBSrc6XWiaZnEWeLgoBVvwxla3KjMf3Dd8BlqSB4g/YWP0rl2lIms98haeq9Ogi5
         waii505UleZrmRY4Fg8T3uJ0QPEAOkCPd+5L9TTEwSUDFEXFTf8X/5JQoDo8/diDFjyS
         QA8pxpvuQ8/onOuPXUYgDZ3tnzfAgCe1iC71VY9pwz3YUgZLf9/3bsqIXctD8RktioCT
         hEqXo+iSnPi8k3Hbb9X1cvHzi/tKMUKs+Q1P2tqnBY7EoTAyqvBpW07qE/LkmLrBRcdF
         Xp20C4aoP5qTXaho7PZ4TLFcRM2eeaPHDMx3kXt/MwCi//TzRs8ICbkPPX5uOk0n/RL6
         i04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YbNOpDJFzgCs01B4eVAYfCjNeyVyNyBdmNF8v/bcsqY=;
        b=qJXxvMxu0WsbiUOwqtUYn19f+BNd9CArOCDVe5RE2qCY1LiRNNbEk7KdjsvTKX9nYB
         h2WDwLVT/GgT+HwiuIacattG2+0+Fas+RxjxG9yIp7t3MX35GOfiQPTWjcG2kuOyw18F
         Vj45PmgONYz1XTDM2ekzNEbyYCRHmRtAt136isfw2OZ6jCyUeZ0hBFtZU28HORymyfrm
         bBzLoc9dDAHHPnvChT8A/fmbyoAh7ufX+rnmwSrUG+tPt/JjVkZM/6D7VjDrZetQBHwk
         XM6owKoH5Yd6lhhymBvzkFZoQg5WzB4IcFw4xTvp2Qio/O12ndnkAgm/9sTNcCr8I8TP
         bCyA==
X-Gm-Message-State: AOUpUlG2B8sGGg0OASwoBt/o7nUZrNIMK1V22oV1RJBrEFTTs9zOiL+m
        YhJtqHd/OcXWT5pcNu0tAgev3Q==
X-Google-Smtp-Source: AAOMgpeA+DAykieGTHveMdGxhKwTilrGkyDcYXmAP4z0Natcvzc862UxekB+8AfdYBt7DJ6LrkCutw==
X-Received: by 2002:a63:2dc1:: with SMTP id t184-v6mr22026735pgt.62.1532555073933;
        Wed, 25 Jul 2018 14:44:33 -0700 (PDT)
Received: from localhost (96-90-200-139-static.hfc.comcastbusiness.net. [96.90.200.139])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20040832pfm.121.2018.07.25.14.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 14:44:32 -0700 (PDT)
Date:   Wed, 25 Jul 2018 14:44:32 -0700 (PDT)
X-Google-Original-Date: Wed, 25 Jul 2018 14:42:47 PDT (-0700)
Subject:     Re: [PATCH 1/6] RISC-V: simplify software interrupt / IPI code
In-Reply-To: <20180725093649.32332-2-hch@lst.de>
CC:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-03f673cd-5779-44c6-98b3-657e5c4b9d39@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 02:36:44 PDT (-0700), Christoph Hellwig wrote:
> Rename handle_ipi to riscv_software_interrupt, drop the unused return
> value and provide a stub for the !SMP build.  This allows simplifying
> the upcoming interrupt controller driver by not providing a wrapper
> for it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/smp.h | 13 +++++++++++--
>  arch/riscv/kernel/smp.c      |  6 ++----
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 85e4220839b0..80ecb957fe9f 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -44,8 +44,17 @@ void arch_send_call_function_single_ipi(int cpu);
>   */
>  #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
>
> -/* Interprocessor interrupt handler */
> -irqreturn_t handle_ipi(void);
> +/* Software interrupt handler */
> +void riscv_software_interrupt(void);
> +
> +#else /* CONFIG_SMP */
> +
> +/*
> + * We currently only use software interrupts to pass inter-processor
> + * interrupts, so if a non-SMP system gets a software interrupt then we
> + * don't know what to do.
> + */
> +#define riscv_software_interrupt()	WARN_ON()
>
>  #endif /* CONFIG_SMP */
>
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 6d3962435720..906fe21ea21b 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -45,7 +45,7 @@ int setup_profiling_timer(unsigned int multiplier)
>  	return -EINVAL;
>  }
>
> -irqreturn_t handle_ipi(void)
> +void riscv_software_interrupt(void)
>  {
>  	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
>
> @@ -60,7 +60,7 @@ irqreturn_t handle_ipi(void)
>
>  		ops = xchg(pending_ipis, 0);
>  		if (ops == 0)
> -			return IRQ_HANDLED;
> +			return;
>
>  		if (ops & (1 << IPI_RESCHEDULE))
>  			scheduler_ipi();
> @@ -73,8 +73,6 @@ irqreturn_t handle_ipi(void)
>  		/* Order data access and bit testing. */
>  		mb();
>  	}
> -
> -	return IRQ_HANDLED;
>  }
>
>  static void

Acked-by: Palmer Dabbelt <palmer@sifive.com>

I think it's probably easier to have the whole patch set go through the IRQ
tree, so I won't put these in the RISC-V tree unless someone says something.
