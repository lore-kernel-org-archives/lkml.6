Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480A4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47A52154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47A52154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389205AbeIULKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeIULKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:10:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DDD4C04AC58;
        Fri, 21 Sep 2018 05:23:31 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92A4E26352;
        Fri, 21 Sep 2018 05:23:30 +0000 (UTC)
Date:   Fri, 21 Sep 2018 13:23:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        x86@kernel.org, thgarnie@google.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH v2 3/3] x86/doc/kaslr.txt: Create a separate part of
 document abourt KASLR at the end of file
Message-ID: <20180921052327.GA32486@MiWiFi-R3L-srv>
References: <20180921020550.13095-1-bhe@redhat.com>
 <20180921020550.13095-4-bhe@redhat.com>
 <20180921032157.GT2555@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921032157.GT2555@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 21 Sep 2018 05:23:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/18 at 11:21am, Baoquan He wrote:
> Take the original content as the first part to only list static mm layout
> tables in non-KASLR case. Then add KASLR document at the end.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/x86/x86_64/mm.txt | 62 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
> index fc1da95e629d..58187614c7ca 100644
> --- a/Documentation/x86/x86_64/mm.txt
> +++ b/Documentation/x86/x86_64/mm.txt
> @@ -1,4 +1,6 @@
>  
> +MM layout in non-KASLR case:
> +
>  Virtual memory map with 4 level page tables:
>  
>  0000000000000000 - 00007fffffffffff (=47 bits, 128 TB) user space, different per mm
> @@ -12,7 +14,6 @@ ffffea0000000000 - ffffeaffffffffff (=40 bits, 1 TB) virtual memory map (vmemmap
>  ffffeb0000000000 - ffffebffffffffff (=40 bits, 1 TB) unused hole
>  ffffec0000000000 - fffffbffffffffff (=44 bits, 16 TB) kasan shadow memory
>  fffffc0000000000 - fffffdffffffffff (=41 bits, 2 TB) unused hole
> -				    vaddr_end for KASLR
>  fffffe0000000000 - fffffe7fffffffff (=39 bits, 512 GB) cpu_entry_area mapping
>  fffffe8000000000 - fffffeffffffffff (=39 bits, 512 GB) LDT remap for PTI
>  ffffff0000000000 - ffffff7fffffffff (=39 bits, 512 GB) %esp fixup stacks
> @@ -38,7 +39,6 @@ ffd4000000000000 - ffd5ffffffffffff (=49 bits, 512 TB) virtual memory map (vmemm
>  ffd6000000000000 - ffdeffffffffffff (~51 bits, 2304 TB) unused hole
>  ffdf000000000000 - fffffdffffffffff (~53 bits, ~8 PB) kasan shadow memory
>  fffffc0000000000 - fffffdffffffffff (=41 bits, 2 TB) unused hole
> -				    vaddr_end for KASLR
>  fffffe0000000000 - fffffe7fffffffff (=39 bits, 512 GB) cpu_entry_area mapping
>  fffffe8000000000 - fffffeffffffffff (=39 bits, 512 GB) unused hole
>  ffffff0000000000 - ffffff7fffffffff (=39 bits, 512 GB) %esp fixup stacks
> @@ -70,10 +70,56 @@ memory window (this size is arbitrary, it can be raised later if needed).
>  The mappings are not part of any other kernel PGD and are only available
>  during EFI runtime calls.
>  
> -Note that if CONFIG_RANDOMIZE_MEMORY is enabled, the direct mapping of all
> -physical memory, vmalloc/ioremap space and virtual memory map are randomized.
> -Their order is preserved but their base will be offset early at boot time.
> +KASLR
> +=========================================================================
> +
> +Kernel Adress Space Layout Randomization (KASLR) consists of two parts
> +which work together to enhance the security of the Linux kernel:
> +
> + - Kernel text KASLR
> + - Memory region KASLR
> +
> +Kernel text KASLR
> +-----------------
> +The physical address and virtual address of kernel text itself are
> +randomized to a different position separately. The physical address of
> +the kernel can be anywhere under 64TB, while the virtual address of the
				    ~~~ in 4-level paging mode
> +kernel is restricted between [0xffffffff80000000, ffffffffbfffffff],
> +the 1GB space.
> +
> +ffffffff80000000 - ffffffffbfffffff (1 GB)  kernel text mapping, from phys 0
> +ffffffffc0000000 - fffffffffeffffff (1520 MB) module mapping space
					1 GB too, will repost.
> +
> +Note: The kernel text KASLR uses 1 GB space to randomize the position of
> +kernel image, and it's defalutly enabled. If KASLR config option
> +CONFIG_RANDOMIZE_BASE is not enabled, the space for kernel image will be
> +shrink to 512 MB, increase the size of modules area to 1.5 GB.
> +
> +Memory region KASLR
> +-------------------
> +If CONFIG_RANDOMIZE_MEMORY is enabled, the below three memory regions
> +are randomized. Their order is preserved but their base will be offset
> +early at boot time.
> +
> +   - direct mapping region
> +   - vmalloc region
> +   - vmemmap region
> +
> +The KASLR address range must not overlap with anything except the KASAN
> +shadow area, which is correct as KASAN disables KASLR.
> +
> +So from the original starting address of the direct mapping region for physical
> +RAM to the starting address of the cpu_entry_area mapping region, namely
> +[0xffff880000000000 - 0xfffffdffffffffff], the scope of 118 TB in all is
> +the virtual address space where memory region KASLR can be allowed to move
> +those memory regions around. After KASLR manipulation is done, their layout
> +looks like:
>  
> -Be very careful vs. KASLR when changing anything here. The KASLR address
> -range must not overlap with anything except the KASAN shadow area, which is
> -correct as KASAN disables KASLR.
> +Name            Starting address        Size                                         Aligned
> +-----------------------------------------------------------------------------------------------
> +direct mapping  page_offset_base        [actual size of system RAM + 10 TB padding]  1 GB
> +*guard hole     random                  random                                       1 GB
> +vmalloc         vmalloc_base            32 TB                                        1 GB
> +*guard hole     random                  random                                       1 GB
> +vmemmap         vmemmap_base            1 TB                                         1 GB
> +*guard hole     random                  random                                       1 GB
> -- 
> 2.13.6
> 
