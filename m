Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809CCC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31232258DA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byz/UR7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31232258DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeGAVCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 17:02:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33930 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeGAVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 17:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cnIgG+8f7EmEyVUXDu3MmUh68n30kZLdDsC20dD6U4w=; b=byz/UR7r5exYMhxNslGDK0jXg
        2YNVLmYq9kv6JyM4smbXm4ALxen9sZJKjMs6+eg9rKi/KpuU3v8Ft7+lr7KnbCKjoulnq9S7GOQSL
        bCfC9B5OwEqUbM/8wvGQFDtzvdsoJC3DOKrC4ceWPuMin3HJUPXFua9qwPn0Ot+PY+hb9E72mtmMW
        FKYSxgy5oB+L+pY80gzBUqkK75rScTCr8dXx2WPfIEm05+h9nEAByCRS9/dy65RHcr7bwHyhmSZ66
        8u0oleRN5xHrBU6uWU/JEUV4AnFaIqrmDVufNxJmVddcsP/xto2btn0r6JdMnMBkLsG1NdE6piB68
        IfwRGO3fQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZjTl-0000Ps-Lw; Sun, 01 Jul 2018 21:01:53 +0000
Subject: Re: [PATCH V2 01/19] csky: Build infrastructure
To:     Guo Ren <ren_guo@c-sky.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9911271e-9717-b026-6adf-f8ec100460c0@infradead.org>
Date:   Sun, 1 Jul 2018 14:01:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a26901aab87306c389e656a3ef200adfbc5195c0.1530465325.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/18 10:30, Guo Ren wrote:
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---

Hi,
Just a few comments...

> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> new file mode 100644
> index 0000000..cfeb312
> --- /dev/null
> +++ b/arch/csky/Kconfig
> @@ -0,0 +1,211 @@
> +config CSKY
> +	bool
> +	default y

shorter:
	def_bool y

> +	select ARCH_USE_BUILTIN_BSWAP
> +	select COMMON_CLK
> +	select CLKSRC_MMIO
> +	select CLKSRC_OF
> +	select IRQ_DOMAIN
> +	select HANDLE_DOMAIN_IRQ
> +	select DW_APB_TIMER_OF
> +	select GENERIC_ATOMIC64
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_CPU_DEVICES
> +	select GENERIC_IRQ_CHIP
> +	select GENERIC_IRQ_PROBE
> +	select GENERIC_IRQ_SHOW
> +	select GENERIC_SCHED_CLOCK
> +	select GENERIC_SMP_IDLE_THREAD
> +	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_GENERIC_DMA_COHERENT
> +	select HAVE_KERNEL_GZIP
> +	select HAVE_KERNEL_LZO
> +	select HAVE_KERNEL_LZMA
> +	select HAVE_PERF_EVENTS
> +	select HAVE_C_RECORDMCOUNT
> +	select HAVE_KPROBES
> +	select HAVE_KRETPROBES
> +	select HAVE_DMA_API_DEBUG
> +	select HAVE_MEMBLOCK
> +	select MAY_HAVE_SPARSE_IRQ
> +	select MODULES_USE_ELF_RELA if MODULES
> +	select NO_BOOTMEM
> +	select OF
> +	select OF_EARLY_FLATTREE
> +	select OF_RESERVED_MEM
> +	select PERF_USE_VMALLOC
> +	select RTC_LIB
> +	select TIMER_OF
> +	select USB_ARCH_HAS_EHCI
> +	select USB_ARCH_HAS_OHCI
> +
> +config CPU_HAS_CACHEV2
> +	bool
> +
> +config CPU_HAS_HILO
> +	bool
> +
> +config CPU_HAS_TLBI
> +	bool
> +
> +config CPU_HAS_LDSTEX
> +	bool
> +	help
> +	  For SMP cpu need "ldex&stex" instrcutions to keep atomic.

	  For SMP, CPU needs           instructions for atomic operations.


> +
> +config CPU_NEED_TLBSYNC
> +	bool
> +
> +config CPU_NEED_SOFTALIGN
> +	bool
> +
> +config CPU_NO_USER_BKPT
> +	bool
> +	help
> +	  For abiv2 we couldn't use "trap 1" as user space bkpt in gdbserver, because
> +	  abiv2 is 16/32bit instruction set and "trap 1" is 32bit.
> +	  So we need a 16bit instruction as user space bkpt, and it will cause a illegal

	                                                                 cause an illegal

> +	  instruction exception.
> +	  In kernel we parse the *regs->pc to determine wether send SIGTRAP or not.

	                                                whether to send

> +
> +config GENERIC_CALIBRATE_DELAY
> +	bool
> +	default y

	def_bool y

> +
> +config HZ
> +	int
> +	default 100
> +
> +config GENERIC_CSUM
> +	bool
> +	default y

	def_bool y

> +
> +config GENERIC_HWEIGHT
> +	bool
> +	default y

	def_bool y

> +
> +config MMU
> +	bool
> +	default y

same.

> +
> +config RWSEM_GENERIC_SPINLOCK
> +	bool
> +	default y

same.

> +
> +config TIME_LOW_RES
> +	bool
> +	default y

again.

> +
> +config TRACE_IRQFLAGS_SUPPORT
> +	bool
> +	default y

again.

> +
> +source "init/Kconfig"
> +
> +source "kernel/Kconfig.freezer"
> +
> +menu "Processor type and features"
> +
> +comment "Processor type"
> +
> +choice
> +	prompt "CPU MODEL"
> +	default CPU_CK610
> +
> +config CPU_CK610
> +	bool "CSKY CPU ck610"
> +	select CPU_NEED_TLBSYNC
> +	select CPU_NEED_SOFTALIGN
> +	select CPU_NO_USER_BKPT
> +
> +config CPU_CK810
> +	bool "CSKY CPU ck810"
> +	select CPU_HAS_HILO
> +	select CPU_NEED_TLBSYNC
> +
> +config CPU_CK807
> +	bool "CSKY CPU ck807"
> +	select CPU_HAS_HILO
> +
> +config CPU_CK860
> +	bool "CSKY CPU ck860"
> +	select CPU_HAS_TLBI
> +	select CPU_HAS_CACHEV2
> +	select CPU_HAS_LDSTEX
> +endchoice
> +
> +config CPU_TLB_SIZE
> +	int
> +	default "128"	if(CPU_CK610 || CPU_CK807 || CPU_CK810)
> +	default "1024"	if(CPU_CK860)
> +
> +config CPU_ASID_BITS
> +	int
> +	default "8"	if(CPU_CK610 || CPU_CK807 || CPU_CK810)
> +	default "12"	if(CPU_CK860)
> +
> +config L1_CACHE_SHIFT
> +	int
> +	default "4"	if(CPU_CK610)
> +	default "5"	if(CPU_CK807 || CPU_CK810)
> +	default "6"	if(CPU_CK860)

prefer a space after "if" on all those lines above.

> +
> +config HIGHMEM
> +	bool "High Memory Support"
> +	depends on !CPU_CK610
> +	default y
> +
> +menuconfig CPU_HAS_FPU
> +	bool "CPU has FPU coprocessor"
> +	depends on CPU_CK807 || CPU_CK810 || CPU_CK860
> +
> +menuconfig CPU_HAS_TEE
> +	bool "CPU has Trusted Execution Environment"
> +	depends on CPU_CK810
> +
> +config SMP
> +	bool "Symmetric Multi-Processing (SMP) support for C-SKY"
> +	depends on CPU_CK860
> +	default n
> +
> +config NR_CPUS
> +	int "Maximum number of CPUs (2-32)"
> +	range 2 32
> +	depends on SMP
> +	default "4"
> +
> +comment "*****System type*****"
> +
> +config RAM_BASE
> +	hex "It must be the same with the memory section in your dts"
> +	default 0x0
> +endmenu
> +
> +menu "Power management options"
> +
> +source "kernel/power/Kconfig"
> +
> +config ARCH_SUSPEND_POSSIBLE
> +	bool
> +	default y

shorter:
	def_bool y

> +endmenu
> +
> +source "mm/Kconfig"
> +
> +source "fs/Kconfig.binfmt"
> +
> +source "kernel/Kconfig.preempt"
> +
> +source "net/Kconfig"
> +
> +source "drivers/Kconfig"
> +
> +source "fs/Kconfig"
> +
> +source "arch/csky/Kconfig.debug"
> +
> +source "security/Kconfig"
> +
> +source "crypto/Kconfig"
> +
> +source "lib/Kconfig"
> diff --git a/arch/csky/Kconfig.debug b/arch/csky/Kconfig.debug
> new file mode 100644
> index 0000000..6978702
> --- /dev/null
> +++ b/arch/csky/Kconfig.debug
> @@ -0,0 +1,29 @@
> +menu "Kernel hacking"
> +
> +menu "C-SKY Debug Options"
> +config CSKY_DEBUG_INFO
> +	bool "Compile the kernel with debug info, just add -g"
> +	depends on !DEBUG_INFO
> +	help
> +	  DEBUG_INFO and COMPILE_TEST is conflict, so we provide
> +	  another way to support -g.
> +	  Some drivers eg: DW_MMC need COMPILE_TEST for new cpu
> +	  arch :(
> +
> +config CSKY_VECIRQ_LEGENCY
> +	bool "Use legency IRQ vector for interrupt, it's for SOC bugfix."

	          legacy

> +	help
> +	  It's a deprecated method for arch/csky. Don't use it, unless your
> +	  SOC has bug.
> +
> +config CSKY_BUILTIN_DTB
> +	bool "Use kernel builtin dtb"
> +
> +config CSKY_BUILTIN_DTB_NAME
> +	string "kernel builtin dtb name"
> +	depends on CSKY_BUILTIN_DTB
> +endmenu
> +
> +source "lib/Kconfig.debug"
> +
> +endmenu


-- 
~Randy
