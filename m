Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EB72075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCpusj6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EB72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIGXSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:18:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35777 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeIGXSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:18:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so15584502wmc.0;
        Fri, 07 Sep 2018 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qEMHnPTlNvnlt3Ot+1QoucvAEXas3scRTswoqXg0bNo=;
        b=SCpusj6xcSOQaKtmZKR/KpGqG1AhaCaebnIv/9CK0uuuVHIZ5uzfr5e2m2PyjBz984
         evQr14CILIUL5LILslXpv3biD6P1QJfaM3ogLv5V4RO9kF0lWw/D+/ySE2Cx/TOYGu1+
         tvkGwER1rTLH3UKg3EUPF0+cNZp6gdPyjDfnfEEI/NnLebTgwtZMpZ6CKvd2xNrPPA5O
         T6gw/Jqz/QPMm8/0gCrmSJym/O8jnTQIBE+izZpvG0033bmAnRjJoNA2OhXKZf1oSqNN
         qdHSU33UII/s2ogihYch3OqE+yKFWz3rKVUhhq31O7kIGpPOR5ZC9YfGeTGeAqOv3bAt
         CGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qEMHnPTlNvnlt3Ot+1QoucvAEXas3scRTswoqXg0bNo=;
        b=gZAxPnl3zxWDLeCTaMenMD0Td6p1w63uoTNhtjJE6ytPZDKhReV2WLtM2UhWjtxlU6
         FfqhYelshJlrtyponB01KTwrLNBuqMGLwl/S+rf+ltPI40qpuKa36u8nfgKp5OSmBD1b
         gpSqA55ZjdjN7Fq8ApP8S0fNq2u+T+6lPekOMnZZn3Pg397WLR8uZ7bWX2snZTyiN44K
         vs84gpRnvQeSUddd7Zni2K7CSmX4WuDK6+yd5I/UAnGcRfRsHQ2U5iFW3sbuvztXhC8R
         I1RYWsS28pvIZhzHxyLo0g3o3gb2Xx7IxEUhGSKHygDLGaxfAytd7DGUxStfeMLeZ/0X
         5Swg==
X-Gm-Message-State: APzg51DiSJISna/UtS7MMTr+0FVS8ezc8Vr2FjQBdDMK7wbywMsjdXan
        TsgBs9L1oChi16Sm8qIgAZ2/YA3SV/s=
X-Google-Smtp-Source: ANB0VdZvAuL+0VwRKVKz0kp/FWNmx05IfNOS5F9fxwdSPMJxy8ZYu7pGWSbKXTjl6gUb97xbKCmJ0A==
X-Received: by 2002:a1c:e581:: with SMTP id c123-v6mr6110483wmh.85.1536345364569;
        Fri, 07 Sep 2018 11:36:04 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id g17-v6sm6908043wmh.19.2018.09.07.11.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 11:36:03 -0700 (PDT)
Date:   Fri, 7 Sep 2018 11:36:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, mpatocka@redhat.com,
        pavel.tatashin@microsoft.com, will.deacon@arm.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "arm64: mm: always enable CONFIG_HOLES_IN_ZONE" has been
 added to the 4.9-stable tree
Message-ID: <20180907183601.GA28007@flashbox>
References: <1536325071252165@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536325071252165@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 02:57:51PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     arm64: mm: always enable CONFIG_HOLES_IN_ZONE
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      arm64-mm-always-enable-config_holes_in_zone.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> From f52bb98f5aded4c43e52f5ce19fb83f7261e9e73 Mon Sep 17 00:00:00 2001
> From: James Morse <james.morse@arm.com>
> Date: Thu, 30 Aug 2018 16:05:32 +0100
> Subject: arm64: mm: always enable CONFIG_HOLES_IN_ZONE
> 
> From: James Morse <james.morse@arm.com>
> 
> commit f52bb98f5aded4c43e52f5ce19fb83f7261e9e73 upstream.
> 
> Commit 6d526ee26ccd ("arm64: mm: enable CONFIG_HOLES_IN_ZONE for NUMA")
> only enabled HOLES_IN_ZONE for NUMA systems because the NUMA code was
> choking on the missing zone for nomap pages. This problem doesn't just
> apply to NUMA systems.
> 
> If the architecture doesn't set HAVE_ARCH_PFN_VALID, pfn_valid() will
> return true if the pfn is part of a valid sparsemem section.
> 
> When working with multiple pages, the mm code uses pfn_valid_within()
> to test each page it uses within the sparsemem section is valid. On
> most systems memory comes in MAX_ORDER_NR_PAGES chunks which all
> have valid/initialised struct pages. In this case pfn_valid_within()
> is optimised out.
> 
> Systems where this isn't true (e.g. due to nomap) should set
> HOLES_IN_ZONE and provide HAVE_ARCH_PFN_VALID so that mm tests each
> page as it works with it.
> 
> Currently non-NUMA arm64 systems can't enable HOLES_IN_ZONE, leading to
> a VM_BUG_ON():
> 
> | page:fffffdff802e1780 is uninitialized and poisoned
> | raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> | raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> | page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> | ------------[ cut here ]------------
> | kernel BUG at include/linux/mm.h:978!
> | Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [...]
> | CPU: 1 PID: 25236 Comm: dd Not tainted 4.18.0 #7
> | Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> | pstate: 40000085 (nZcv daIf -PAN -UAO)
> | pc : move_freepages_block+0x144/0x248
> | lr : move_freepages_block+0x144/0x248
> | sp : fffffe0071177680
> [...]
> | Process dd (pid: 25236, stack limit = 0x0000000094cc07fb)
> | Call trace:
> |  move_freepages_block+0x144/0x248
> |  steal_suitable_fallback+0x100/0x16c
> |  get_page_from_freelist+0x440/0xb20
> |  __alloc_pages_nodemask+0xe8/0x838
> |  new_slab+0xd4/0x418
> |  ___slab_alloc.constprop.27+0x380/0x4a8
> |  __slab_alloc.isra.21.constprop.26+0x24/0x34
> |  kmem_cache_alloc+0xa8/0x180
> |  alloc_buffer_head+0x1c/0x90
> |  alloc_page_buffers+0x68/0xb0
> |  create_empty_buffers+0x20/0x1ec
> |  create_page_buffers+0xb0/0xf0
> |  __block_write_begin_int+0xc4/0x564
> |  __block_write_begin+0x10/0x18
> |  block_write_begin+0x48/0xd0
> |  blkdev_write_begin+0x28/0x30
> |  generic_perform_write+0x98/0x16c
> |  __generic_file_write_iter+0x138/0x168
> |  blkdev_write_iter+0x80/0xf0
> |  __vfs_write+0xe4/0x10c
> |  vfs_write+0xb4/0x168
> |  ksys_write+0x44/0x88
> |  sys_write+0xc/0x14
> |  el0_svc_naked+0x30/0x34
> | Code: aa1303e0 90001a01 91296421 94008902 (d4210000)
> | ---[ end trace 1601ba47f6e883fe ]---
> 
> Remove the NUMA dependency.
> 
> Link: https://www.spinics.net/lists/arm-kernel/msg671851.html
> Cc: <stable@vger.kernel.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Tested-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/arm64/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -631,7 +631,6 @@ config HAVE_SETUP_PER_CPU_AREA
>  
>  config NEED_PER_CPU_EMBED_FIRST_CHUNK

Looks like git got confused here, this isn't HOLES_IN_ZONE.

Additionally, commit 6d526ee26ccd ("arm64: mm: enable
CONFIG_HOLES_IN_ZONE for NUMA") that introduced it to this file didn't
appear until 4.11 so this patch can be dropped from 4.9.

>  	def_bool y
> -	depends on NUMA
>  
>  source kernel/Kconfig.preempt
>  source kernel/Kconfig.hz
> 
> 
> Patches currently in stable-queue which might be from james.morse@arm.com are
> 
> queue-4.9/arm64-mm-always-enable-config_holes_in_zone.patch
