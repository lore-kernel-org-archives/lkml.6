Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B505C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1F420672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GFcDAW/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E1F420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeLGSak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:30:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44185 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeLGSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:30:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so2312949pfh.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=w45WFGc5WHZjrvRR2qUEQHnRZeD5KN/awL+SD2+Lq9k=;
        b=GFcDAW/hHKqxzPJLVGy83GWnQ8oufMB8VRQy4pg4ErWwbCKnCNfG5U57Zk7R6z+sJB
         j8kHhZ57UwCKSzxKJ1PbaYvLrMqzc/Dfyjks9moI5hjvyUim9RYyyutlSl88dn9B6oYy
         jQ2a2TgWNgAqdTp95D3H/R1dqoolFSt/T8u1UOBdvPKHFQ/ooa0N3EMbfIKXwpBbByGo
         gbpW8ESVyDQbYejrzw5BA5L2ZxTfeYjIbpq2cs+BTP+wz6+gU0Y3tFFqFg0yIODJjocK
         2qyIsJJA0CSdRa8+V6RPtdFK/ukmf6EBp/lcNrn3sye+PGP8tTkoDik3KHCZPnvghnPk
         p8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=w45WFGc5WHZjrvRR2qUEQHnRZeD5KN/awL+SD2+Lq9k=;
        b=W/GmhFrOnBoCTuVXCJacAIxPdHd1WvoXXUBoo6y97vMIGKYBoCo0cHge7006rL58aE
         +pDXbVymzU8yox8OPxbZPj6cLGK9CY94+JtbrRTPU12LJmN92EzdXLB/m3Erfq+IO60L
         5EWkrzgGPAqKwf0Delp1btce5Fvbdpd0qatCdP8xsLjEtZdhW+/jiB3OiIpAU32jdydb
         DQPbnGqZSb/WPDDQOAEzUeFDGvEMtgHmDN6HRDmvq6zdX3PROOakcNsRL3rE/KFSaoDh
         gaD8oK7C/WhPV5DQV1Fm3t0GiwKfgfug7AfoT3iN58z27N8V3mClcxVlk8hUm0GdFiF2
         od7A==
X-Gm-Message-State: AA+aEWZ9u/dD5xTcHItEze4oD5v/BF5i8egp2H/QGTrJvI1juo+jMvWC
        LMRa2D8IjxNa/A4Wmo7bEJRLi1FQcI0=
X-Google-Smtp-Source: AFSGD/UCeYLPcYkJqEmd5IQoY6ryuAxXERoJCloowyV3FdFBpqI0uimetaOcI/ey8lC+UYFDlR0kHQ==
X-Received: by 2002:a63:f047:: with SMTP id s7mr2858590pgj.441.1544207432846;
        Fri, 07 Dec 2018 10:30:32 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id s21sm9626847pfk.133.2018.12.07.10.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:30:32 -0800 (PST)
Date:   Fri, 07 Dec 2018 10:30:32 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 10:21:43 PST (-0800)
Subject:     Re: [PATCH 3/3] RISC-V: Remove EARLY_PRINTK support
In-Reply-To: <20181204135507.3706-4-anup@brainfault.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        Christoph Hellwig <hch@infradead.org>, robh@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, anup@brainfault.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-4b39b504-3f5e-4c66-afaa-7929e92a14f7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018 05:55:07 PST (-0800), anup@brainfault.org wrote:
> The EARLY_PRINTK using SBI console calls is not required
> any more because we now have RISC-V SBI support in generic
> earlycon framework.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/Kconfig.debug  |  2 --
>  arch/riscv/kernel/setup.c | 28 ----------------------------
>  2 files changed, 30 deletions(-)
>
> diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
> index c5a72f17c469..e69de29bb2d1 100644
> --- a/arch/riscv/Kconfig.debug
> +++ b/arch/riscv/Kconfig.debug
> @@ -1,2 +0,0 @@
> -config EARLY_PRINTK
> -	def_bool y
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2c290e6aaa6e..fc8006a042eb 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -35,31 +35,9 @@
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
>  #include <asm/smp.h>
> -#include <asm/sbi.h>
>  #include <asm/tlbflush.h>
>  #include <asm/thread_info.h>
>
> -#ifdef CONFIG_EARLY_PRINTK
> -static void sbi_console_write(struct console *co, const char *buf,
> -			      unsigned int n)
> -{
> -	int i;
> -
> -	for (i = 0; i < n; ++i) {
> -		if (buf[i] == '\n')
> -			sbi_console_putchar('\r');
> -		sbi_console_putchar(buf[i]);
> -	}
> -}
> -
> -struct console riscv_sbi_early_console_dev __initdata = {
> -	.name	= "early",
> -	.write	= sbi_console_write,
> -	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
> -	.index	= -1
> -};
> -#endif
> -
>  #ifdef CONFIG_DUMMY_CONSOLE
>  struct screen_info screen_info = {
>  	.orig_video_lines	= 30,
> @@ -219,12 +197,6 @@ static void __init setup_bootmem(void)
>
>  void __init setup_arch(char **cmdline_p)
>  {
> -#if defined(CONFIG_EARLY_PRINTK)
> -       if (likely(early_console == NULL)) {
> -               early_console = &riscv_sbi_early_console_dev;
> -               register_console(early_console);
> -       }
> -#endif
>  	*cmdline_p = boot_command_line;
>
>  	parse_early_param();

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
