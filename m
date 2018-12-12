Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCCDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCEC2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="AGYFzHBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCEC2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeLLJm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:42:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39909 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeLLJm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:42:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so8355347pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 01:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qa3ZXcGyRZ87CWcpLbXBvVxbs96EU+L0eUhnAJPXg34=;
        b=AGYFzHBY3gjjefzh5O/zFswIbw9uknMd9piiWU1Y1QtZGQzwMgsdUTtRO8Or/shp5v
         i2+9CzSha0CnM5g9mbK1wGiyzyYgv2papylOLpK58miaZQ4ltscOXVVT/hxXeyO3lsBh
         DEwFBUjmn1UzMkFUlvD9njYFteh/Qi/7Ge2J0Vw3fWs208yN8Ko/nFs497S34OyZIHvS
         VzifQ4j82GDa7xPO3jIwV8Elqu7Vsp9CCE0NxTq+ByaIALbyJnIEztnMGhk37xYCmeT7
         OJexFcG45bZhQQPLMd91HEnl/2iMgzG/fudJz31k6TVS0S4bQAcusJ8tNRmdjN+VcN4I
         EJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qa3ZXcGyRZ87CWcpLbXBvVxbs96EU+L0eUhnAJPXg34=;
        b=mV0gmBDZ+9+/jIQhomMYm4ZEhS8L8yQhnE3s/FWtq2yar/WjhfXeKt0bh27CiVpKRa
         g4IpbhH9xjjEFo5+12VHK65sczCvovQ0kBpvsAs/DxVtnHJYcTI9MAGDusOPHZu1xo1K
         UC1KA0nXLD2xydieyt7MxSuaizCWl829CUrD/Pv+8a8a83DLkN0LyYkdl77HRVWJNTC4
         +9ppMV+fqi65uTLmB2H32mxmBbenyyWciIc48E6UOQ4RNHHj3I77Lqh24v4ghtgUbmoe
         l44JVi2+VAwK5rT7g8Qqecv2k9qHtWyVEAJOgxVrNv6/Crx+/bdRsPlhIxzJkEcfnCb4
         ZlKQ==
X-Gm-Message-State: AA+aEWaJEjfm8MxpjyUSE0escGFuetnvX27HEvoC+DiiwLe7AbhG3UMx
        zPKi6RSws1+z6luaBwflYLdMrw==
X-Google-Smtp-Source: AFSGD/WuNfgLv/afjtWRiRCPOHplcgnduyGfTJocJfIAS4CcEfTAuyKRgEvf6I0nS9FoYdSTuQJsZg==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr19104349plq.84.1544607775316;
        Wed, 12 Dec 2018 01:42:55 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id t87sm59106208pfk.122.2018.12.12.01.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 01:42:54 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id B50E4300256; Wed, 12 Dec 2018 12:42:49 +0300 (+03)
Date:   Wed, 12 Dec 2018 12:42:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Liu Bo <bo.liu@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm, memcg: fix reclaim deadlock with writeback
Message-ID: <20181212094249.cw4xjrdchqsp2tkt@kshutemo-mobl1>
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

Side node:

Do we have PG_writeback vs. PG_locked ordering documentated somewhere?

IIUC, the trace from task2 suggests that we must not wait for writeback
on the locked page.

But that not what I see for many wait_on_page_writeback() users: it usally
called with the page locked. I see it for truncate, shmem, swapfile,
splice...

Maybe the problem is within task2 codepath after all?

-- 
 Kirill A. Shutemov
