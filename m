Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3C0C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6237D20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN/FX4Qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6237D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeJCTvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:51:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35941 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeJCTvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:51:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so5756892qth.3;
        Wed, 03 Oct 2018 06:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oQS9SuJ0Jo2IQYmm2lR+CQj4GDyeVThV04IXSPuhN4s=;
        b=EN/FX4QxJuX36I5WokxXcMCBC8JazhVm0k+8kuGtrC/gSGvjKV7bdsn3Io+4pn1ocD
         u5/DG8CQe09mG63Ocf1diSvKHeJ06Z8WL4z2PKxMfNbSmDLYYuVgAZnb52CSTMQ/rFry
         VRDV2perNEqjLSqD8h/MMzutyCFgalWifX4CBxre7XqVJT5ktJY3pzRbTXGEPtvY4gpo
         JHXjw1zdOSWSs3d69aNDcysehUdXFJMJM7OsKtjY3zeFBzUvfZPMwJ3AqzTSpphkNbSp
         rAsLgD0YWRgdKWI2KhE9ApZG+obxa48XKZXfE8QKAW/Y/+3aBGIOK1jKRRLMPTusb69P
         OJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQS9SuJ0Jo2IQYmm2lR+CQj4GDyeVThV04IXSPuhN4s=;
        b=k3FCHLsmUaBtHQ9MAnjG1FzjQaxjB3iz3egnei6IAIsGxUtVAKqYJNaQ2oigw3/IYP
         3JA4tKWu6kq8nnPkdq6//oY5LDVhsTDUUrCH4NEuIp0AtzLUpf1fgckCHlPmKKYAuG5k
         9WUOaNEr5eF1URrKgTryzspLIqDDKlZyXYvtB0l3Zujgp4GWkitM3sm9bjlfds+K23sp
         7DmevdfXcR+/LTSBm5GjGt7TSau/l9zUDoBKryhzzsXyR7LUYSvbGGvtCIKv8Dtjf9st
         Z1s5WWdjd28WMSxBX8TZIwS1K7ICl/Ia5DN2o4m4S4E3Gs3leT38mmdWAoH6acGCiyJx
         G0BQ==
X-Gm-Message-State: ABuFfojgU6ehjBe7TFWR1jrWG5B0Dm0M67E0PSR890aCqh6ghoZrlwPs
        Fq7vN3d9Em1j5h4OXyR8Ig==
X-Google-Smtp-Source: ACcGV61MzlZi3iQRLpMmQHVBTE7nhJmO11Bw3XKc9sfFOSgS8ucwCaYRpUnxDSaZTv712UfW34Doxg==
X-Received: by 2002:ac8:1c1a:: with SMTP id a26-v6mr1109727qtk.16.1538571770572;
        Wed, 03 Oct 2018 06:02:50 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h4-v6sm490447qkg.95.2018.10.03.06.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 06:02:50 -0700 (PDT)
Date:   Wed, 3 Oct 2018 09:02:44 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, m.mizuma@jp.fujitsu.com,
        bhe@redhat.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] ACPI/NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20181003130243.xxntr2yuesc7mnc3@gabell>
References: <20181001140843.26137-3-msys.mizuma@gmail.com>
 <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
 <20181003123402.GA15494@hirez.programming.kicks-ass.net>
 <20181003124814.GA4227@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003124814.GA4227@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 02:48:14PM +0200, Borislav Petkov wrote:
> On Wed, Oct 03, 2018 at 02:34:02PM +0200, Peter Zijlstra wrote:
> > 
> > Subject: ACPI/NUMA: Fix KASLR build error
> > 
> > There is no point in trying to compile KASLR specific code when there is
> > no KASLR.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> Yeah, Peter and I were just talking on IRC and he gave me a much better
> idea how to fix this, see below. I'll run this through the *config builder and
> commit it if no complaints.

Hi Boris and Peter,

Thank you for the fix. It is great!

- Masa

> 
> ---
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Date: Wed, 3 Oct 2018 14:41:27 +0200
> Subject: [PATCH] ACPI/NUMA: Fix KASLR build error
> 
> There is no point in trying to compile KASLR specific code when there is
> no KASLR.
> 
>  [ bp: Move the whole crap into kaslr.c and make
>    rand_mem_physical_padding static. ]
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <m.mizuma@jp.fujitsu.com>
> Cc: <bhe@redhat.com>
> Cc: <torvalds@linux-foundation.org>
> Cc: <tglx@linutronix.de>
> Cc: <mingo@kernel.org>
> Cc: <hpa@zytor.com>
> Link: http://lkml.kernel.org/r/20181003123402.GA15494@hirez.programming.kicks-ass.net
> ---
>  arch/x86/include/asm/kaslr.h |  2 ++
>  arch/x86/include/asm/setup.h |  2 --
>  arch/x86/mm/kaslr.c          | 18 +++++++++++++++++-
>  drivers/acpi/numa.c          | 15 +++------------
>  4 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kaslr.h b/arch/x86/include/asm/kaslr.h
> index db7ba2feb947..95ef3fc01d12 100644
> --- a/arch/x86/include/asm/kaslr.h
> +++ b/arch/x86/include/asm/kaslr.h
> @@ -6,8 +6,10 @@ unsigned long kaslr_get_random_long(const char *purpose);
>  
>  #ifdef CONFIG_RANDOMIZE_MEMORY
>  void kernel_randomize_memory(void);
> +void kaslr_check_padding(void);
>  #else
>  static inline void kernel_randomize_memory(void) { }
> +static inline void kaslr_check_padding(void) { }
>  #endif /* CONFIG_RANDOMIZE_MEMORY */
>  
>  #endif
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index 65a5bf8f6aba..ae13bc974416 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -80,8 +80,6 @@ static inline unsigned long kaslr_offset(void)
>  	return (unsigned long)&_text - __START_KERNEL;
>  }
>  
> -extern int rand_mem_physical_padding;
> -
>  /*
>   * Do NOT EVER look at the BIOS memory size location.
>   * It does not work on many machines.
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 00cf4cae38f5..d58b7da0d55c 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -40,7 +40,7 @@
>   */
>  static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
>  
> -int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>  /*
>   * Memory regions randomized by KASLR (except modules that use a separate logic
>   * earlier during boot). The list is ordered based on virtual addresses. This
> @@ -70,6 +70,22 @@ static inline bool kaslr_memory_enabled(void)
>  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
>  
> +/*
> + * Check the padding size for KASLR is enough.
> + */
> +void kaslr_check_padding(void)
> +{
> +	u64 max_possible_phys, max_actual_phys, threshold;
> +
> +	max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
> +	max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
> +	threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
> +
> +	if (max_possible_phys > threshold)
> +		pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
> +			(max_possible_phys - max_actual_phys) >> 40);
> +}
> +
>  static int __init rand_mem_physical_padding_setup(char *str)
>  {
>  	int max_padding = (1 << (MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 3d69834c692f..4408e37600ef 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -32,7 +32,7 @@
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> -#include <asm/setup.h>
> +#include <asm/kaslr.h>
>  
>  static nodemask_t nodes_found_map = NODE_MASK_NONE;
>  
> @@ -436,7 +436,6 @@ acpi_table_parse_srat(enum acpi_srat_type id,
>  int __init acpi_numa_init(void)
>  {
>  	int cnt = 0;
> -	u64 max_possible_phys, max_actual_phys, threshold;
>  
>  	if (acpi_disabled)
>  		return -EINVAL;
> @@ -466,17 +465,9 @@ int __init acpi_numa_init(void)
>  		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>  					    acpi_parse_memory_affinity, 0);
>  
> -		/* check the padding size for KASLR is enough. */
> -		if (parsed_numa_memblks && kaslr_enabled()) {
> -			max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
> -			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
> -			threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
> +		if (parsed_numa_memblks)
> +			kaslr_check_padding();
>  
> -			if (max_possible_phys > threshold) {
> -				pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
> -				  (max_possible_phys - max_actual_phys) >> 40);
> -			}
> -		}
>  	}
>  
>  	/* SLIT: System Locality Information Table */
> -- 
> 2.19.0.271.gfe8321ec057f
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
