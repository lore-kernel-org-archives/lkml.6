Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA24C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A077F20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UbDVxqBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A077F20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeLLL6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:58:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37676 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeLLL6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:58:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so8245069pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F0yqHqwVMhLf2fO0JIAqrnhDtk1hFKxahaLZf09ddbY=;
        b=UbDVxqBTQB3EO/UJeAMI5U+XwS/qiWG8kaPLGo0X40hEax66eyGqP075FDicxEa/5k
         ci/alX7uR73hHPSP6dwPfV6daRDnG+71O5WI6bIOc/CeNINedpqyvDIWlmvzujvpM83c
         VLQPZ+VtA8lOxqMAgWy69LElPQPEJTX5+AMkyl8iU0F51f/nehULbFWl0HLTXUO0OZIt
         6rE3IsyQcB8D7DGdAUTk3KEKXkSTsqcC6qErhcdk/3sgtnifWciJ2nh+AtYeyg0Xf13j
         2J8/YLl8s64uOMjLup6YuWUwfhxgK6nBCJhJGyXVUGWxe13jy8Uz+aA9myS+tz9UP3Ic
         p2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F0yqHqwVMhLf2fO0JIAqrnhDtk1hFKxahaLZf09ddbY=;
        b=IeHCMKyW0afq8rrrFI4oyrNcoNXWn64lmTV5+yrC0UUuD6E/X8CGpMQIKqA337zjv/
         4rA7u/mgUZ3vTrdjsZAoOmvh45erUCHcRd2KAgjQOK1+GSPBbDs3bbfRU64g59FYZYTW
         5EYmGCZ6F8K7y+HEnnaHM4JRnGQL957OeR65MX5YU1aZp3GLo+qbPd9dCik0KwNwJG6S
         9tdSKaJIKS/dVdNevsGRfiV2FvoEfV3vGGnPIVOqYdCX3jT3yOW4Ofpj6umzKIzdBMj+
         1LdZBy8YVlgmZ0g6RK/jLL6sZWi/nLWmN/8RNyn+Da+Al/PvWTahHJe1bRDAuwj4Ukho
         RqgA==
X-Gm-Message-State: AA+aEWb/rlNgcbfaJB93Bm5DnpmPizBqV+Fcq3oixp5cNUr44X6XuRq/
        3WyvJ/V/uvR05RdRd8fwOTrRaQ==
X-Google-Smtp-Source: AFSGD/VcvvTmJ3N0IH7q+R7SXVYqnMDFuQF6XVpv/3KwzEHn28BYPkUsR+qnya93COgaJ0XAnlZ8Og==
X-Received: by 2002:a62:6503:: with SMTP id z3mr19376046pfb.169.1544615922691;
        Wed, 12 Dec 2018 03:58:42 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id p67sm33622268pfi.85.2018.12.12.03.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 03:58:41 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 33295300258; Wed, 12 Dec 2018 14:58:37 +0300 (+03)
Date:   Wed, 12 Dec 2018 14:58:37 +0300
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
Message-ID: <20181212115837.zragenml27av3fqm@kshutemo-mobl1>
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

Okay, I have spent some time on the issue and was not able to find a
better solution too. But I cannot say I like it.

I think we need to spend more time on making ->prealloc_pte useful: looks
like it would help to convert vmf_insert_* helpers to take struct vm_fault
* as input and propagate it down to pmd population point. Otherwise DAX
and drivers would alloacate the page table for nothing.

Have you considered if we need anything similar for anon path? Is it
possible to have similar deadlock with swaping rather than writeback?

-- 
 Kirill A. Shutemov
