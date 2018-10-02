Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C40DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E40E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E40E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeJBVtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:49:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbeJBVtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:49:07 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Vv44BM3WC-eU; Tue,  2 Oct 2018 17:05:16 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CC8F91EC021C;
        Tue,  2 Oct 2018 17:05:15 +0200 (CEST)
Date:   Tue, 2 Oct 2018 17:05:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     m.mizuma@jp.fujitsu.com
Cc:     bhe@redhat.com, torvalds@linux-foundation.org,
        msys.mizuma@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] ACPI/NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20181002150517.GA19822@zn.tnic>
References: <20181001140843.26137-3-msys.mizuma@gmail.com>
 <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-3b054ca88c4f4dd5f516a12d4b6d6bd0ae826f41@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Nope, not really:

ld: drivers/acpi/numa.o: in function `acpi_numa_init':
/home/boris/kernel/linux/drivers/acpi/numa.c:473: undefined reference to `rand_mem_physical_padding'
make: *** [Makefile:1030: vmlinux] Error 1

due to CONFIG_RANDOMIZE_MEMORY=n in my .config.

You need to add a fix ontop which adds a function
get_rand_mem_physical_padding() which is defined in CONFIG_RANDOMIZE_MEMORY=y
and outside returns 0.

And then make that rand_mem_physical_padding static and do not export it
to anything outside of kaslr.c but use the accessor.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
