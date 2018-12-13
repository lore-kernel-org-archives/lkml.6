Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E655C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276E020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="MGRRmw9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276E020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeLMKlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:41:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38673 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbeLMKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:41:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so890115plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JN2+b77EC0oN1aqMgMvWFwxhb7UGD5959tUtHmpF8Kg=;
        b=MGRRmw9cS59Q8fTjmVxucW0pUPrsLxgk61saF568HMab1V75TvKaAjXWHc9ZW6H1qI
         rzcxvv2IW7pVtuBXh3vUL6cxKKY54xG/oIveTXy5KIf4LTHUHkPAy3voTROKh98YybyA
         rCrTgZQ8cJ7/D5ATrUs1W603r2iMlaNMGOu8qDe6sHQI8QjeHip3+WwWqQ6dtUzhVXUD
         GNVHBTWai+oYo5GSl2OLxVZgAEj3l2IAQc2VEvl/9Kmsl2Zg8ZrxwHThYZlLuBunhJR5
         Izuf+4gh7/loPynm+YqTjSFBDnq0htWVhgJiVYY6nzeJiEoCt/qiC3iB8KFyyItpINQP
         ElHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JN2+b77EC0oN1aqMgMvWFwxhb7UGD5959tUtHmpF8Kg=;
        b=Uc/WMXFSvh1YY5mosN21uFDFtYMLOUC9t/vbyCNvC0HOM9HdIoyIG/bZA/tlEsdV+Z
         pE7mfmh2/XWg574zYn/xIs+A49zAoBS3igQLl5dUIjjb2dBD6mVXgun2PaTXzoVl6zXq
         vkHMafwIXbOXhkMMOo9En7hvTQtL1JfODpKBzTaRjlP/O6ncuTbmpBIrLDcn3pltK+tX
         MP5BoWVQcbW55ddKOj3mHB6F1gUSCfUfwRGbHGe7qsL4mDficRWwyj4DprCM/W1WjLJ/
         agSHHMHGodCDRULJ7Npz3GX4y2YcbxdZUtLR8dG2U/TkxnhBxOCg/vIJVHfIlzwOlBNY
         j5cg==
X-Gm-Message-State: AA+aEWbRSXwTi1f505uNPADBc7ZEdnEBULonZdeBpWcceHTRybmMG8r/
        ysjE6hLmoyOVk6pRUVaSqYF33Q==
X-Google-Smtp-Source: AFSGD/WCFRrByCu/h3RwMLZZwrDYHglOVRhSHQQz533VJM0bEtxGwrh1ImqmqRIjffPu1kgWsFD6qw==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60mr23105327plc.211.1544697713290;
        Thu, 13 Dec 2018 02:41:53 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id q5sm3210949pfi.165.2018.12.13.02.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 02:41:52 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8E89B300258; Thu, 13 Dec 2018 13:41:47 +0300 (+03)
Date:   Thu, 13 Dec 2018 13:41:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH v3] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181213104147.ud2lngxn5avri2zm@kshutemo-mobl1>
References: <20181212155055.1269-1-mhocko@kernel.org>
 <20181213092221.27270-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213092221.27270-1-mhocko@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:22:21AM +0100, Michal Hocko wrote:
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
> essentially ABBA deadlock:
>                                         lock_page(A)
>                                         SetPageWriteback(A)
>                                         unlock_page(A)
> lock_page(B)
>                                         lock_page(B)
> pte_alloc_pne
>   shrink_page_list
>     wait_on_page_writeback(A)
>                                         SetPageWriteback(B)
>                                         unlock_page(B)
> 
>                                         # flush A, B to clear the writeback
> 
> This accumulating of more pages to flush is used by several filesystems
> to generate a more optimal IO patterns.
> 
> Waiting for the writeback in legacy memcg controller is a workaround
> for pre-mature OOM killer invocations because there is no dirty IO
> throttling available for the controller. There is no easy way around
> that unfortunately. Therefore fix this specific issue by pre-allocating
> the page table outside of the page lock. We have that handy
> infrastructure for that already so simply reuse the fault-around pattern
> which already does this.
> 
> There are probably other hidden __GFP_ACCOUNT | GFP_KERNEL allocations
> from under a fs page locked but they should be really rare. I am not
> aware of a better solution unfortunately.
> 
> Reported-and-Debugged-by: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: stable
> Fixes: c3b94f44fcb0 ("memcg: further prevent OOM with too many dirty pages")
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Will you take care about converting vmf_insert_* to use the pre-allocated
page table?

-- 
 Kirill A. Shutemov
