Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDCCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161742084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="q4NA/2t3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161742084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeLKPPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:15:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37579 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLKPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:15:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so7271269pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvh4Y2Y9qxd+9vD6IT2b2y/Fz/0MmhVU4jsroMPbG/o=;
        b=q4NA/2t3nh4JQOtv7UO+AmH2AgDbMUzEjjc/SKZgE4CB0W3UXaX9qpKfua9ocBhDtl
         I6ibLmMiYEnW0HzRUrrlh4Cpw/xxVbbZ4kYUC6j1UFG0dkps08UJMjb5N3CDi9Jc17rR
         sy3PurmT9PnpkIoZXqxT27xaGebpDQCqLuIoTAVN2yRhrIXqxRTv9v+PXbh931K248r4
         NuO3tKuIAyVehkaN+Ad/kudfufaGEHe0sKMkQaLd6IMzAcHX411R07lkU9GE92lFlD/t
         tWNxuxXzhLf6eALTOkrXtFKzQYkA3CMwAx5A+fKPgaGpCsDZsaa0oV0P1dt9GOSoMRd4
         Dyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvh4Y2Y9qxd+9vD6IT2b2y/Fz/0MmhVU4jsroMPbG/o=;
        b=qFuMzTdDozjlZgLyD0hqR4MjO7RULby4XraKrNg481UyNo3WLKf4RRjxxThwGtUWLI
         J9gpUxWs1EZ1XkqBf2P4wjlH2hACWXd+/XuIh6czR36YFxJWYhmt4Rx6hFmecaOLZdWi
         DzaTqhMmWr+MQhg7grN9lgmJaopX/BunvTdeSC0Ed5Tcsxt95dSQPjIVtiyx2coVpFoR
         fQkwcDHnhEnse9XezOT0p64CBPLYd0z3Y5sg0SmC5Jw4oFqqzBxsYKjPzlqojAC7kiDx
         T/uSCgVHuue0e+y0JaBYJyU8zZ3XyBNF8i6E42vMmL+Clv3Fd6jthhvPVw1tg6Ux7ao9
         mRIA==
X-Gm-Message-State: AA+aEWagyG6Ehgerj78SAh3vj7YHykIfJ4b6braeUvu0GkYg9uZn2mzz
        uyGa+9DrJRHBB+4e1Whax5xJ8w==
X-Google-Smtp-Source: AFSGD/WSAjk9LSTK+s+vhP25Q9MZTVredjss+6zqbSVR+w8zHGIKjwYQjiEvVVkXj+5PsHkizdEaWQ==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr16932592pfe.130.1544541347740;
        Tue, 11 Dec 2018 07:15:47 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id m67sm23768880pfm.73.2018.12.11.07.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 07:15:46 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5A2E6300256; Tue, 11 Dec 2018 18:15:42 +0300 (+03)
Date:   Tue, 11 Dec 2018 18:15:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181211151542.2rjti4glj75honje@kshutemo-mobl1>
References: <20181211132645.31053-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211132645.31053-1-mhocko@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:26:45PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Liu Bo has experienced a deadlock between memcg (legacy) reclaim and the
> ext4 writeback
> task1:
> [<ffffffff811aaa52>] wait_on_page_bit+0x82/0xa0
> [<ffffffff811c5777>] shrink_page_list+0x907/0x960
> [<ffffffff811c6027>] shrink_inactive_list+0x2c7/0x680
> [<ffffffff811c6ba4>] shrink_node_memcg+0x404/0x830
> [<ffffffff811c70a8>] shrink_node+0xd8/0x300
> [<ffffffff811c73dd>] do_try_to_free_pages+0x10d/0x330
> [<ffffffff811c7865>] try_to_free_mem_cgroup_pages+0xd5/0x1b0
> [<ffffffff8122df2d>] try_charge+0x14d/0x720
> [<ffffffff812320cc>] memcg_kmem_charge_memcg+0x3c/0xa0
> [<ffffffff812321ae>] memcg_kmem_charge+0x7e/0xd0
> [<ffffffff811b68a8>] __alloc_pages_nodemask+0x178/0x260
> [<ffffffff8120bff5>] alloc_pages_current+0x95/0x140
> [<ffffffff81074247>] pte_alloc_one+0x17/0x40
> [<ffffffff811e34de>] __pte_alloc+0x1e/0x110
> [<ffffffffa06739de>] alloc_set_pte+0x5fe/0xc20
> [<ffffffff811e5d93>] do_fault+0x103/0x970
> [<ffffffff811e6e5e>] handle_mm_fault+0x61e/0xd10
> [<ffffffff8106ea02>] __do_page_fault+0x252/0x4d0
> [<ffffffff8106ecb0>] do_page_fault+0x30/0x80
> [<ffffffff8171bce8>] page_fault+0x28/0x30
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> task2:
> [<ffffffff811aadc6>] __lock_page+0x86/0xa0
> [<ffffffffa02f1e47>] mpage_prepare_extent_to_map+0x2e7/0x310 [ext4]
> [<ffffffffa08a2689>] ext4_writepages+0x479/0xd60
> [<ffffffff811bbede>] do_writepages+0x1e/0x30
> [<ffffffff812725e5>] __writeback_single_inode+0x45/0x320
> [<ffffffff81272de2>] writeback_sb_inodes+0x272/0x600
> [<ffffffff81273202>] __writeback_inodes_wb+0x92/0xc0
> [<ffffffff81273568>] wb_writeback+0x268/0x300
> [<ffffffff81273d24>] wb_workfn+0xb4/0x390
> [<ffffffff810a2f19>] process_one_work+0x189/0x420
> [<ffffffff810a31fe>] worker_thread+0x4e/0x4b0
> [<ffffffff810a9786>] kthread+0xe6/0x100
> [<ffffffff8171a9a1>] ret_from_fork+0x41/0x50
> [<ffffffffffffffff>] 0xffffffffffffffff
> 
> He adds
> : task1 is waiting for the PageWriteback bit of the page that task2 has
> : collected in mpd->io_submit->io_bio, and tasks2 is waiting for the LOCKED
> : bit the page which tasks1 has locked.
> 
> More precisely task1 is handling a page fault and it has a page locked
> while it charges a new page table to a memcg. That in turn hits a memory
> limit reclaim and the memcg reclaim for legacy controller is waiting on
> the writeback but that is never going to finish because the writeback
> itself is waiting for the page locked in the #PF path. So this is
> essentially ABBA deadlock.
> 
> Waiting for the writeback in legacy memcg controller is a workaround
> for pre-mature OOM killer invocations because there is no dirty IO
> throttling available for the controller. There is no easy way around
> that unfortunately. Therefore fix this specific issue by pre-allocating
> the page table outside of the page lock. We have that handy
> infrastructure for that already so simply reuse the fault-around pattern
> which already does this.
> 
> Reported-and-Debugged-by: Liu Bo <bo.liu@linux.alibaba.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> Hi,
> this has been originally reported here [1]. While it could get worked
> around in the fs, catching the allocation early sounds like a preferable
> approach. Liu Bo has noted that he is not able to reproduce this anymore
> because kmem accounting has been disabled in their workload but this
> should be quite straightforward to review.
> 
> There are probably other hidden __GFP_ACCOUNT | GFP_KERNEL allocations
> from under a fs page locked but they should be really rare. I am not
> aware of a better solution unfortunately.
> 
> I would appreciate if Kirril could have a look and double check I am not
> doing something stupid here.
> 
> Debugging lock_page deadlocks is an absolute PITA considering a lack of
> lockdep support so I would mark it for stable.
> 
> [1] http://lkml.kernel.org/r/1540858969-75803-1-git-send-email-bo.liu@linux.alibaba.com
>  mm/memory.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 4ad2d293ddc2..1a73d2d4659e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2993,6 +2993,17 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>  	struct vm_area_struct *vma = vmf->vma;
>  	vm_fault_t ret;
>  
> +	/*
> +	 * Preallocate pte before we take page_lock because this might lead to
> +	 * deadlocks for memcg reclaim which waits for pages under writeback.
> +	 */
> +	if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
> +		vmf->prealloc_pte = pte_alloc_one(vmf->vma->vm>mm, vmf->address);
> +		if (!vmf->prealloc_pte)
> +			return VM_FAULT_OOM;
> +		smp_wmb(); /* See comment in __pte_alloc() */
> +	}
> +
>  	ret = vma->vm_ops->fault(vmf);
>  	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
>  			    VM_FAULT_DONE_COW)))

Sorry, but I don't think it fixes anything. Just hides it a level deeper.

The trick with ->prealloc_pte works for faultaround because we can rely on
->map_pages() to not sleep and we know how it will setup page table entry.
Basically, core controls most of the path.

It's not the case with ->fault(). It is free to sleep and allocate
whatever it wants.

For instance, DAX page fault will setup page table entry on its own and
return VM_FAULT_NOPAGE. It uses vmf_insert_mixed() to setup the page table
and ignores your pre-allocated page table.

But it's just an example. The problem is that ->fault() is not bounded on
what it can do, unlike ->map_pages().

-- 
 Kirill A. Shutemov
