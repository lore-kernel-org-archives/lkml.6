Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFAEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8006D2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2FaymF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8006D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbeKQJ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:58:44 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51757 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeKQJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:58:43 -0500
Received: by mail-it1-f193.google.com with SMTP id x19so385619itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 15:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WfirLP2JaXJueajChZWi9SQkQRfAreKWGcmJCOSbvFs=;
        b=K2FaymF9pnp85ejAf1Xp3BoAuxWSKKJmctLYa41NUUbqemudTzsHszBHcKhPtx2RE/
         Fx2GhHC/FS1VPu2KMjWnvg7aNYoBW88QCW9qQXxe0gzB6UxWK6kusJBMjWsA21r2dXMr
         Fo1IgM4ZUl5ezyM/K4K8Nqi6HX0/hK0iQtmky/P1QqzRICMz105PeEO8K0imca4pbNWV
         dIDHjIk04XNDZieT21zIFZ8iys/zQwHdy6yk2hhiIevTbs6pvSMzgSVG2LC7IaWf8HH7
         NpOQVnuVCD5LZEo5OxjRwUEbWhKt7PQKUAY16oLCQYrC/KaZY54K12bw5eslbDvDPvbI
         JppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WfirLP2JaXJueajChZWi9SQkQRfAreKWGcmJCOSbvFs=;
        b=mc0fkhZUlxTDHe6VuAxLx6MQ8KCHQUrTIVIzI2BcK+UVIVI68m2kuxyNg0dSAhoDqb
         LqxreGPz03ZTiNYm6Vb6nHHMIenEQsRr/+c96hTzzU6OG7HUA/kgdJSZgyO6KbZZ/ykC
         cC6JT8H2w9Q5/NL7wvNT1pvD2Fg8Ot1u215Im+xJU6QKgWn8Jq0GNcR7EDdq+DKfAMX4
         9ppGqhVN9EZEWyyLfKOU/ecQSDKvzhRxqTOpobCmK+U6Mf0Qhk2ZII38Dxw52zIwU1kc
         VUjI+d1UaHqyLYEouiZZBGgzcXV/MzlBLFVrH0AHY14OGkowcYydCz+UAQM3zDO4ueJP
         WRQg==
X-Gm-Message-State: AGRZ1gJzla6T90SMZM1WjRLZdF+RtIJ5BBM5vZ3Z1Ug5+3+3bYM8y+ad
        pIwtGp7uGe6t5ynA5bd6VkegRbOjTV0Ht2rfknw9WQ==
X-Google-Smtp-Source: AFSGD/XNS+GdWT7gDjG5kwzrrUgSt0BW5r5qI2CX3Tww/Y/fwXJSBJb9eBAJiKuGkLHJNF2Q2sWW/tj7Hs/q4zbZ+Yo=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr347885ite.12.1542411857299;
 Fri, 16 Nov 2018 15:44:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 15:43:56
 -0800 (PST)
In-Reply-To: <20181113152941.cc328e48d5c0c2f366f5db83@linux-foundation.org>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz> <20181113094305.GM15120@dhcp22.suse.cz>
 <20181113152941.cc328e48d5c0c2f366f5db83@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 15:43:56 -0800
Message-ID: <CACT4Y+ZD-oLa50qHRUPG217b50PD5saQGTRUF84VXTURXC41Rg@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Kyungtae Kim <kt0755@gmail.com>,
        pavel.tatashin@microsoft.com, Vlastimil Babka <vbabka@suse.cz>,
        osalvador@suse.de, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        aaron.lu@intel.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        alexander.h.duyck@linux.intel.com,
        Mel Gorman <mgorman@techsingularity.net>,
        lifeasageek@gmail.com, "Dae R. Jeong" <threeearcat@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 3:29 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 13 Nov 2018 10:43:05 +0100 Michal Hocko <mhocko@kernel.org> wrote:
>
>> From: Michal Hocko <mhocko@suse.com>
>> Date: Fri, 9 Nov 2018 09:35:29 +0100
>> Subject: [PATCH] mm, page_alloc: check for max order in hot path
>>
>> Konstantin has noticed that kvmalloc might trigger the following warning
>> [Thu Nov  1 08:43:56 2018] WARNING: CPU: 0 PID: 6676 at mm/vmstat.c:986 __fragmentation_index+0x54/0x60
>
> um, wait...
>
>> [...]
>> [Thu Nov  1 08:43:56 2018] Call Trace:
>> [Thu Nov  1 08:43:56 2018]  fragmentation_index+0x76/0x90
>> [Thu Nov  1 08:43:56 2018]  compaction_suitable+0x4f/0xf0
>> [Thu Nov  1 08:43:56 2018]  shrink_node+0x295/0x310
>> [Thu Nov  1 08:43:56 2018]  node_reclaim+0x205/0x250
>> [Thu Nov  1 08:43:56 2018]  get_page_from_freelist+0x649/0xad0
>> [Thu Nov  1 08:43:56 2018]  ? get_page_from_freelist+0x2d4/0xad0
>> [Thu Nov  1 08:43:56 2018]  ? release_sock+0x19/0x90
>> [Thu Nov  1 08:43:56 2018]  ? do_ipv6_setsockopt.isra.5+0x10da/0x1290
>> [Thu Nov  1 08:43:56 2018]  __alloc_pages_nodemask+0x12a/0x2a0
>> [Thu Nov  1 08:43:56 2018]  kmalloc_large_node+0x47/0x90
>> [Thu Nov  1 08:43:56 2018]  __kmalloc_node+0x22b/0x2e0
>> [Thu Nov  1 08:43:56 2018]  kvmalloc_node+0x3e/0x70
>> [Thu Nov  1 08:43:56 2018]  xt_alloc_table_info+0x3a/0x80 [x_tables]
>> [Thu Nov  1 08:43:56 2018]  do_ip6t_set_ctl+0xcd/0x1c0 [ip6_tables]
>> [Thu Nov  1 08:43:56 2018]  nf_setsockopt+0x44/0x60
>> [Thu Nov  1 08:43:56 2018]  SyS_setsockopt+0x6f/0xc0
>> [Thu Nov  1 08:43:56 2018]  do_syscall_64+0x67/0x120
>> [Thu Nov  1 08:43:56 2018]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
>
> If kvalloc_node() is going to call kmalloc() without checking for a
> huge allocation request then surely it should set __GFP_NOWARN.


kmalloc won't warn about large allocations after "mm: don't warn about
large allocations for slab":
https://lkml.org/lkml/2018/9/27/1156
It will just return NULL. That was already the case for slub.


> And it
> shouldn't bother at all if size > KMALLOC_MAX_SIZE, surely?  So
> something like
>
> --- a/mm/util.c~a
> +++ a/mm/util.c
> @@ -393,11 +393,16 @@ void *kvmalloc_node(size_t size, gfp_t f
>         void *ret;
>
>         /*
> -        * vmalloc uses GFP_KERNEL for some internal allocations (e.g page tables)
> -        * so the given set of flags has to be compatible.
> +        * vmalloc uses GFP_KERNEL for some internal allocations (e.g page
> +        * tables) so the given set of flags has to be compatible.
>          */
> -       if ((flags & GFP_KERNEL) != GFP_KERNEL)
> +       if ((flags & GFP_KERNEL) != GFP_KERNEL) {
> +               if (size > KMALLOC_MAX_SIZE)
> +                       return NULL;
> +               if (size > PAGE_SIZE)
> +                       flags |= __GFP_NOWARN;
>                 return kmalloc_node(size, flags, node);
> +       }
>
>         /*
>          * We want to attempt a large physically contiguous block first because
>
>
>> the problem is that we only check for an out of bound order in the slow
>> path and the node reclaim might happen from the fast path already. This
>> is fixable by making sure that kvmalloc doesn't ever use kmalloc for
>> requests that are larger than KMALLOC_MAX_SIZE but this also shows that
>> the code is rather fragile. A recent UBSAN report just underlines that
>> by the following report
>>
>>  UBSAN: Undefined behaviour in mm/page_alloc.c:3117:19
>>  shift exponent 51 is too large for 32-bit type 'int'
>>  CPU: 0 PID: 6520 Comm: syz-executor1 Not tainted 4.19.0-rc2 #1
>>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>>  Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0xd2/0x148 lib/dump_stack.c:113
>>   ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
>>   __ubsan_handle_shift_out_of_bounds+0x2b6/0x30b lib/ubsan.c:425
>>   __zone_watermark_ok+0x2c7/0x400 mm/page_alloc.c:3117
>>   zone_watermark_fast mm/page_alloc.c:3216 [inline]
>>   get_page_from_freelist+0xc49/0x44c0 mm/page_alloc.c:3300
>>   __alloc_pages_nodemask+0x21e/0x640 mm/page_alloc.c:4370
>>   alloc_pages_current+0xcc/0x210 mm/mempolicy.c:2093
>>   alloc_pages include/linux/gfp.h:509 [inline]
>>   __get_free_pages+0x12/0x60 mm/page_alloc.c:4414
>>   dma_mem_alloc+0x36/0x50 arch/x86/include/asm/floppy.h:156
>>   raw_cmd_copyin drivers/block/floppy.c:3159 [inline]
>>   raw_cmd_ioctl drivers/block/floppy.c:3206 [inline]
>>   fd_locked_ioctl+0xa00/0x2c10 drivers/block/floppy.c:3544
>>   fd_ioctl+0x40/0x60 drivers/block/floppy.c:3571
>>   __blkdev_driver_ioctl block/ioctl.c:303 [inline]
>>   blkdev_ioctl+0xb3c/0x1a30 block/ioctl.c:601
>>   block_ioctl+0x105/0x150 fs/block_dev.c:1883
>>   vfs_ioctl fs/ioctl.c:46 [inline]
>>   do_vfs_ioctl+0x1c0/0x1150 fs/ioctl.c:687
>>   ksys_ioctl+0x9e/0xb0 fs/ioctl.c:702
>>   __do_sys_ioctl fs/ioctl.c:709 [inline]
>>   __se_sys_ioctl fs/ioctl.c:707 [inline]
>>   __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:707
>>   do_syscall_64+0xc4/0x510 arch/x86/entry/common.c:290
>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> And we could fix this in the floppy driver.
>
>> Note that this is not a kvmalloc path. It is just that the fast path
>> really depends on having sanitzed order as well. Therefore move the
>> order check to the fast path.
>
> But do we really need to do this?  Are there any other known potential
> callsites?
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
