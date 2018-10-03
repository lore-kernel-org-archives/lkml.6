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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B9920835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrGt+L+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B9920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeJCRq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:46:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45532 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCRq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:46:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id v198-v6so2067834ywg.12;
        Wed, 03 Oct 2018 03:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hVgTVLPLQ95zQp3Kzlm2QHcimzI+u+uVxpV2IFZrKQw=;
        b=jrGt+L+uBcRX2XFxFbK8EtGG4tHnbXBVeV3KOq26dt7Sw0VL9+LmRYb88GQAc+cbKN
         28PhBunkG9YWYNigEG/O3DkhVdNMH7b2s1TdsGjzZnvT5tohJLD/lBY+YFK8zIGfZQ1M
         xc3upw0jfHcyXiFAooLnBC8ImAAFu7r0ncCLiXs+EVQM7XsSFtCExgyfwc5y6+t3OPxe
         /MRz6RE6ly5HwDmMg64x1viOxQ5l3ALGaLMPtKzxm+38NfXijjTydaJFMMX3upFTd+wB
         ChKo+5EBwzPvJizQOPVG/16BLbNe9Td2vemK5lDkuM/NX4dJ0wE4HzDtc5X4rL5nnPcE
         2U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hVgTVLPLQ95zQp3Kzlm2QHcimzI+u+uVxpV2IFZrKQw=;
        b=kq+uoIhOmZjtoqB4LgX12U87bIYf5sJPZXQqIlEquW8gYqODfilyEx+5KkUNeE0LMA
         VxIJ2BmtIOFtKUIIzV3HXeIEJ2hEyH/DhkZu27nwlOZOExogXFgn5MWgGNU23+427Uhi
         MLUpho9HKALO6OMQW9s8gl7OoLaqcJy3kxOk8DOCOTqZInrZO4XZCLXQCL2LtgVqQhnA
         9C5LZjoBO0S/L+eOSwIoVHpU/Un0cOEOTflQ61ZHAER2tE/sVB/6AHnBLDdoajfx7Co+
         cd3qLeVv6PYI49Y7mEipA/7Yo6HT30HlmgeEG7QEtKmJZ70t+5nxh6otgFMxb56DJZV2
         0MBQ==
X-Gm-Message-State: ABuFfoi02UAsSbm0v9LAB2mzJ/knTNdKTjB8ZUdSKij6+VVgJp8XGe8A
        sXLuVXVINAdaULoVbkekAg==
X-Google-Smtp-Source: ACcGV60H7YdrtFdBoeOhW9mfLJdeGZVXqjoY1rpYfRT4b2Z0qgV2JEh9Kng2DezGZ65oz+H3ZFMiew==
X-Received: by 2002:a81:c85:: with SMTP id 127-v6mr423225ywm.364.1538564315883;
        Wed, 03 Oct 2018 03:58:35 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id p185-v6sm363653ywc.14.2018.10.03.03.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 03:58:35 -0700 (PDT)
Date:   Wed, 3 Oct 2018 06:58:29 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     tip-bot for Masayoshi Mizuma <tipbot@zytor.com>
Cc:     linux-tip-commits@vger.kernel.org, m.mizuma@jp.fujitsu.com,
        bhe@redhat.com, bp@alien8.de, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org
Subject: Re: [tip:x86/boot] ACPI/NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20181003105828.oh7qirvadsva372b@gabell>
References: <20181001140843.26137-3-msys.mizuma@gmail.com>
 <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH] Fix for build error if CONFIG_RANDOMIZE_BASE is not defined.

Fix the following build error.

  ld: drivers/acpi/numa.o: in function `acpi_numa_init':
  drivers/acpi/numa.c:473: undefined reference to `rand_mem_physical_padding'
  make: *** [Makefile:1030: vmlinux] Error 1

- Add get_rand_mem_physical_padding() which returns
  rand_mem_physical_padding or 0 if
  CONFIG_RANDOMIZE_MEMORY is not defined.
- Make rand_mem_physical_padding static

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/include/asm/setup.h | 9 ++++++++-
 arch/x86/mm/kaslr.c          | 9 +++++++--
 drivers/acpi/numa.c          | 3 ++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 65a5bf8..1765a15 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -80,7 +80,14 @@ static inline unsigned long kaslr_offset(void)
 	return (unsigned long)&_text - __START_KERNEL;
 }

-extern int rand_mem_physical_padding;
+#ifdef CONFIG_RANDOMIZE_MEMORY
+extern inline int __init get_rand_mem_physical_padding(void);
+#else
+static inline int __init get_rand_mem_physical_padding(void)
+{
+	return 0;
+}
+#endif

 /*
  * Do NOT EVER look at the BIOS memory size location.
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 00cf4ca..eb47f05 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,7 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;

-int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+static int rand_mem_physical_padding __initdata = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -70,6 +70,11 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }

+inline int __init get_rand_mem_physical_padding(void)
+{
+	return rand_mem_physical_padding;
+}
+
 static int __init rand_mem_physical_padding_setup(char *str)
 {
 	int max_padding = (1 << (MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;
@@ -117,7 +122,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		rand_mem_physical_padding;
+		get_rand_mem_physical_padding();

 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 3d69834..303b024 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -470,7 +470,8 @@ int __init acpi_numa_init(void)
 		if (parsed_numa_memblks && kaslr_enabled()) {
 			max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
 			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
-			threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
+			threshold = max_actual_phys +
+				((u64)get_rand_mem_physical_padding() << 40);

 			if (max_possible_phys > threshold) {
 				pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
--
2.18.0


On Tue, Oct 02, 2018 at 03:18:41AM -0700, tip-bot for Masayoshi Mizuma wrote:
> Commit-ID:  3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41
> Gitweb:     https://git.kernel.org/tip/3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41
> Author:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> AuthorDate: Mon, 1 Oct 2018 10:08:42 -0400
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 2 Oct 2018 11:47:21 +0200
> 
> ACPI/NUMA: Add warning message if the padding size for KASLR is not enough
> 
> Add warning message if the padding size for KASLR,
> rand_mem_physical_padding, is not enough. The message also
> says the suitable padding size.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: http://lkml.kernel.org/r/20181001140843.26137-3-msys.mizuma@gmail.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/setup.h |  2 ++
>  drivers/acpi/numa.c          | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index ae13bc974416..65a5bf8f6aba 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -80,6 +80,8 @@ static inline unsigned long kaslr_offset(void)
>  	return (unsigned long)&_text - __START_KERNEL;
>  }
>  
> +extern int rand_mem_physical_padding;
> +
>  /*
>   * Do NOT EVER look at the BIOS memory size location.
>   * It does not work on many machines.
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 85167603b9c9..3d69834c692f 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -32,6 +32,7 @@
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> +#include <asm/setup.h>
>  
>  static nodemask_t nodes_found_map = NODE_MASK_NONE;
>  
> @@ -435,6 +436,7 @@ acpi_table_parse_srat(enum acpi_srat_type id,
>  int __init acpi_numa_init(void)
>  {
>  	int cnt = 0;
> +	u64 max_possible_phys, max_actual_phys, threshold;
>  
>  	if (acpi_disabled)
>  		return -EINVAL;
> @@ -463,6 +465,18 @@ int __init acpi_numa_init(void)
>  
>  		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>  					    acpi_parse_memory_affinity, 0);
> +
> +		/* check the padding size for KASLR is enough. */
> +		if (parsed_numa_memblks && kaslr_enabled()) {
> +			max_actual_phys = roundup(PFN_PHYS(max_pfn), 1ULL << 40);
> +			max_possible_phys = roundup(PFN_PHYS(max_possible_pfn), 1ULL << 40);
> +			threshold = max_actual_phys + ((u64)rand_mem_physical_padding << 40);
> +
> +			if (max_possible_phys > threshold) {
> +				pr_warn("Set 'rand_mem_physical_padding=%llu' to avoid memory hotadd failure.\n",
> +				  (max_possible_phys - max_actual_phys) >> 40);
> +			}
> +		}
>  	}
>  
>  	/* SLIT: System Locality Information Table */
