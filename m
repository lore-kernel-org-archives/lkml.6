Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127E1C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECCB21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LCXDkGDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfBAX2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:28:34 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:38822 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfBAX2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:28:33 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 5C74E10C1BEE;
        Fri,  1 Feb 2019 15:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549063713; bh=lYDE3tWl/r2Q5og8kqIEuBc+58iOyqMuqF6iN/O+1SU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=LCXDkGDSAsDgzY82LdUTj86z1mdeGEPPjZY39jrH/q1TLgj/8EDoQepJOXKpyLU0w
         3/qAxWx+GgVEzZNFDKodqjt8yHEcuU9QwQSfBPiSC/qjd8/KWgRGasTUXsbbLMQGUJ
         1k3m+IZ09R1nSzDgX/RvHTV3+A80N9TEyHA0FvDhPNvejD5ijoSoK2MfiXtU4N9IBC
         y1SzC2hAXpBg9xRjbyZyPs2u4rtxwW2fO2iYvdX7SJ085maEvu+1H7Tv7z7B1cib+c
         CKLClOatkOChvlU6PlPWDFxcy3j5+ceAs9Yirsycxfq52MyV2atzQCO+bkNf4GDSGt
         rgbTV4P4YlKrQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 37FBAA0097;
        Fri,  1 Feb 2019 23:28:32 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 1 Feb 2019 15:27:53 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 2 Feb 2019 04:57:53 +0530
Received: from [10.10.161.70] (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 2 Feb 2019 04:57:54 +0530
Subject: Re: [PATCH v2 2/5] ARCv2: introduce unaligned access under a Kconfig
 option
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel
References: <20190130163244.10870-1-Eugeniy.Paltsev@synopsys.com>
 <20190130163244.10870-3-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <f95135f7-20e3-1897-d3dc-e8dadf8a2ac5@synopsys.com>
Date:   Fri, 1 Feb 2019 15:27:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130163244.10870-3-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 8:32 AM, Eugeniy Paltsev wrote:
> As of today we enable unaligned access unconditionally on ARCv2.
> Lets move it under Kconfig option so we can disable it in case of
> using HW configuration which lacks of it.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/Kconfig                      |  8 ++++++++
>  arch/arc/include/asm/irqflags-arcv2.h |  4 ++++
>  arch/arc/kernel/head.S                | 14 +++++++++-----
>  arch/arc/kernel/intc-arcv2.c          |  2 +-
>  4 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 376366a7db81..37c8aeefa3a5 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -387,6 +387,14 @@ config ARC_HAS_SWAPE
>  
>  if ISA_ARCV2
>  
> +config ARC_USE_UNALIGNED_MEM_ACCESS
> +	bool "Handle unaligned access in HW and use it"
> +	default y
> +	help
> +	  The ARC HS architecture supports unaligned memory access
> +	  which is disabled by default. Enable unaligned access in
> +	  hardware and use it in software.
> +
>  config ARC_HAS_LL64
>  	bool "Insn: 64bit LDD/STD"
>  	help
> diff --git a/arch/arc/include/asm/irqflags-arcv2.h b/arch/arc/include/asm/irqflags-arcv2.h
> index 8a4f77ea3238..9b911e2c6b31 100644
> --- a/arch/arc/include/asm/irqflags-arcv2.h
> +++ b/arch/arc/include/asm/irqflags-arcv2.h
> @@ -44,8 +44,12 @@
>  #define ARCV2_IRQ_DEF_PRIO	1
>  
>  /* seed value for status register */
> +#ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS
>  #define ISA_INIT_STATUS_BITS	(STATUS_IE_MASK | STATUS_AD_MASK | \
>  					(ARCV2_IRQ_DEF_PRIO << 1))
> +#else
> +#define ISA_INIT_STATUS_BITS	(STATUS_IE_MASK | (ARCV2_IRQ_DEF_PRIO << 1))
> +#endif /* CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS */
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
> index 25b3a247e11c..bd24ba0e0264 100644
> --- a/arch/arc/kernel/head.S
> +++ b/arch/arc/kernel/head.S
> @@ -49,11 +49,15 @@
>  
>  1:
>  
> -#ifdef CONFIG_ISA_ARCV2
> -	; Enable unaligned access as disabled by default in hw while
> -	; gcc 8.1.0 onwards (ARC GNU 2018.03) unconditionally generates
> -	; code for unaligned accesses
> -	flag    1 << STATUS_AD_BIT
> +	; Enable / disable HW handling of unaligned access in the CPU.
> +#ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS
> +	kflag	STATUS_AD_MASK
> +#else
> +	; Handling of unaligned access is disabled by default but we disable it
> +	; manually in case of any bootloader enabled it earlier.
> +	lr	r5, [ARC_REG_STATUS32]
> +	bclr	r5, r5, STATUS_AD_BIT
> +	kflag	r5
>  #endif
>  .endm

I tested these patches and we have a little problem when
CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS is disabled. AD bit is cleared, but current
gcc (2018.09 release) generates unaligned accesses still.


Misaligned Access
Path: (null)
CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4+ #484

[ECR   ]: 0x000d0000 => Check Programmer's Manual
[EFA   ]: 0x808293cf
[BLINK ]: device_node_gen_full_name+0x3e/0xd4
[ERET  ]: string.constprop.11+0x3e/0x6c
[STAT32]: 0x00000002 :   K
BTA: 0x807e8768	 SP: 0x808d9e94	 FP: 0x00000000
LPS: 0x807ede44	LPE: 0x807ede54	LPC: 0x00000000
r00: 0x00000001	r01: 0x00000001	r02: 0x00000000	
...
Stack Trace:
  string.constprop.11+0x3e/0x6c
  device_node_gen_full_name+0x3e/0xd4
  device_node_string+0x128/0x32c
  vsnprintf+0xfa/0x3c4
  kvasprintf+0x24/0x78
  kasprintf+0x16/0x1c
  __irq_domain_add+0x72/0x1b8
  init_onchip_IRQ+0x38/0x60


Guess there's no solution to this. We could force select the option in relevant
Kconfig, but this applies to pretty much every platform and defeats the purpose of
option in first place.

>  
> diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
> index 067ea362fb3e..6359896da1ea 100644
> --- a/arch/arc/kernel/intc-arcv2.c
> +++ b/arch/arc/kernel/intc-arcv2.c
> @@ -93,7 +93,7 @@ void arc_init_IRQ(void)
>  
>  	/* setup status32, don't enable intr yet as kernel doesn't want */
>  	tmp = read_aux_reg(ARC_REG_STATUS32);
> -	tmp |= STATUS_AD_MASK | (ARCV2_IRQ_DEF_PRIO << 1);
> +	tmp |= ARCV2_IRQ_DEF_PRIO << 1;
>  	tmp &= ~STATUS_IE_MASK;
>  	asm volatile("kflag %0	\n"::"r"(tmp));
>  }
> 

