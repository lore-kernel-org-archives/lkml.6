Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3BDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56442087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PmXJF/lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56442087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeH1WnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:43:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1551 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1WnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535482222; x=1567018222;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aszJt4UfxD+mQxsuCwoH67L0LDwBWKIiA5IEctGg+Lg=;
  b=PmXJF/lQ87CEVATBaVdFfzBydgI9XS/Z0ijDVjjI7zKQOtbuEij8e4Ii
   O28drGI8kN1p2V95u6L+pOm6WrlbR6Ir5fejgm7qW1+Mx5Jh3te9MpdQs
   un7QT6LWeKgnjlm8UhrcQr97vfWpSH6JlMCUr7lrOX1jVOm/A/BE/Y/Yh
   X8mliJ9193Cbf+p9Iyao5WifFsYmtnaEf4TsF4U6CtfrfsljG4uWvWX/0
   kQu8FdFvvb+gS680Z7/IwtMYUcpFQayX+XesbqMajK0kX+NYzOXxbTRIc
   KrtAOSz+hHRrywp4bL/SC7qcefOPziSrs3sdYjAmp5ZUKMS/Rt/whEEMX
   w==;
X-IronPort-AV: E=Sophos;i="5.53,300,1531756800"; 
   d="scan'208";a="92573367"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2018 02:50:22 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 28 Aug 2018 11:37:36 -0700
Received: from 6pnzp12.ad.shared (HELO [10.86.61.94]) ([10.86.61.94])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Aug 2018 11:50:21 -0700
Subject: Re: [PATCH 3/8] RISC-V: Rename riscv_of_processor_hart to
 riscv_of_processor_hartid
To:     Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc:     "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180827184243.25344-1-palmer@sifive.com>
 <20180827184243.25344-4-palmer@sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <6d213376-5e00-48a9-35a2-a83807f2e481@wdc.com>
Date:   Tue, 28 Aug 2018 11:50:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827184243.25344-4-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/18 11:58 AM, Palmer Dabbelt wrote:
> It's a bit confusing exactly what this function does: it actually
> returns the hartid of an OF processor node, failing with -1 on invalid
> nodes.  I've changed the name to _hartid() in order to make that a bit
> more clear, as well as adding a comment.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>   arch/riscv/include/asm/processor.h | 4 +++-
>   arch/riscv/kernel/cpu.c            | 2 +-
>   arch/riscv/kernel/smpboot.c        | 2 +-
>   drivers/clocksource/riscv_timer.c  | 2 +-
>   drivers/irqchip/irq-sifive-plic.c  | 2 +-
>   5 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 3fe4af8147d2..9d32670d84a4 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -88,7 +88,9 @@ static inline void wait_for_interrupt(void)
>   }
>   
>   struct device_node;
> -extern int riscv_of_processor_hart(struct device_node *node);
> +/* Returns the hart ID of the given device tree node, or -1 if the device tree
> + * node isn't a RISC-V hart. */

I think multi-line commenting format should be:
/*
  *
  */

Otherwise, Reviewed-by: Atish Patra <atish.patra@wdc.com>
> +extern int riscv_of_processor_hartid(struct device_node *node);
>   
>   extern void riscv_fill_hwcap(void);
>   
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ca6c81e54e37..19e98c1710dd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -16,7 +16,7 @@
>   #include <linux/of.h>
>   
>   /* Return -1 if not a valid hart */
> -int riscv_of_processor_hart(struct device_node *node)
> +int riscv_of_processor_hartid(struct device_node *node)
>   {
>   	const char *isa, *status;
>   	u32 hart;
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 56abab6a9812..5f29f8562cf6 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -53,7 +53,7 @@ void __init setup_smp(void)
>   	int hart, im_okay_therefore_i_am = 0;
>   
>   	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> -		hart = riscv_of_processor_hart(dn);
> +		hart = riscv_of_processor_hartid(dn);
>   		if (hart >= 0) {
>   			set_cpu_possible(hart, true);
>   			set_cpu_present(hart, true);
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> index 4e8b347e43e2..ad7453fc3129 100644
> --- a/drivers/clocksource/riscv_timer.c
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -84,7 +84,7 @@ void riscv_timer_interrupt(void)
>   
>   static int __init riscv_timer_init_dt(struct device_node *n)
>   {
> -	int cpu_id = riscv_of_processor_hart(n), error;
> +	int cpu_id = riscv_of_processor_hartid(n), error;
>   	struct clocksource *cs;
>   
>   	if (cpu_id != smp_processor_id())
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 532e9d68c704..c55eaa31cde2 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -176,7 +176,7 @@ static int plic_find_hart_id(struct device_node *node)
>   {
>   	for (; node; node = node->parent) {
>   		if (of_device_is_compatible(node, "riscv"))
> -			return riscv_of_processor_hart(node);
> +			return riscv_of_processor_hartid(node);
>   	}
>   
>   	return -1;
> 

