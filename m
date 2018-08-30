Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB50C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5925F205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5925F205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeH3Qhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:37:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49912 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbeH3Qhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:37:43 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zLBtKs4QUNFj; Thu, 30 Aug 2018 14:35:28 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AAD61EC01F6;
        Thu, 30 Aug 2018 14:35:27 +0200 (CEST)
Date:   Thu, 30 Aug 2018 14:35:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register
 new cpu_dev to system
Message-ID: <20180830123559.GF20005@nazgul.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:42:49PM +0800, Pu Wen wrote:
> Add x86 architecture support for new processor Hygon Dhyana Family 18h.
> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
> AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU. In
> this way we can remove old AMD architecture support codes from Hygon
> code path and generate a clear initialization flow for Hygon processors.
> It also reduce long-term maintenance effort.
> Also add Maintainer information for hygon.c in accordance.
> 
> To identify Hygon processors, add a new vendor type X86_VENDOR_HYGON(9)
> for system recognition.
> 
> To enable Hygon processor config, add a separated Kconfig entry
> (CPU_SUP_HYGON) for Dhyana CPU in kernel config setup.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  MAINTAINERS                      |   6 +
>  arch/x86/Kconfig.cpu             |  13 ++
>  arch/x86/include/asm/processor.h |   3 +-
>  arch/x86/kernel/cpu/Makefile     |   1 +
>  arch/x86/kernel/cpu/hygon.c      | 408 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 430 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/cpu/hygon.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b..9c1d920 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6759,6 +6759,12 @@ S:	Maintained
>  F:	mm/memory-failure.c
>  F:	mm/hwpoison-inject.c
>  
> +HYGON PROCESSOR SUPPORT
> +M:	Pu Wen <puwen@hygon.cn>
> +L:	linux-arch@vger.kernel.org

This is probably the wrong ML. You either have your own or use lkml, I'd
say.

> +S:	Supported
> +F:	arch/x86/kernel/cpu/hygon.c
> +
>  Hyper-V CORE AND DRIVERS
>  M:	"K. Y. Srinivasan" <kys@microsoft.com>
>  M:	Haiyang Zhang <haiyangz@microsoft.com>
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 638411f..2e92267 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -426,6 +426,19 @@ config CPU_SUP_AMD
>  
>  	  If unsure, say N.
>  
> +config CPU_SUP_HYGON
> +	default y
> +	bool "Support Hygon processors" if PROCESSOR_SELECT
> +	help
> +	  This enables detection, tunings and quirks for Hygon processors
> +
> +	  You need this enabled if you want your kernel to run on an
> +	  Hygon CPU. Disabling this option on other types of CPUs
> +	  makes the kernel a tiny bit smaller. Disabling it on an Hygon
> +	  CPU might render the kernel unbootable.
> +
> +	  If unsure, say N.
> +
>  config CPU_SUP_CENTAUR
>  	default y
>  	bool "Support Centaur processors" if PROCESSOR_SELECT
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index c242972..9f18cdb 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -153,7 +153,8 @@ enum cpuid_regs_idx {
>  #define X86_VENDOR_CENTAUR	5
>  #define X86_VENDOR_TRANSMETA	7
>  #define X86_VENDOR_NSC		8
> -#define X86_VENDOR_NUM		9
> +#define X86_VENDOR_HYGON	9
> +#define X86_VENDOR_NUM		10
>  
>  #define X86_VENDOR_UNKNOWN	0xff
>  
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index 347137e..1f5d229 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
>  
>  obj-$(CONFIG_CPU_SUP_INTEL)		+= intel.o intel_pconfig.o
>  obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
> +obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
>  obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
>  obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
>  obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
> new file mode 100644
> index 0000000..ae90d1f
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/hygon.c
> @@ -0,0 +1,408 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hygon Processor Support for Linux
> + *
> + * Copyright (c) Chengdu Haiguang IC Design Co., Ltd.
> + *
> + * Author: 2018 Pu Wen <puwen@hygon.cn>

Year goes with the copyright.

Otherwise looks ok.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
