Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF23C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA0121522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfwa5jrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA0121522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbeISXyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:54:53 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45762 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeISXyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:54:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id l2-v6so844654qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m5V+wQp3beiXYJCPtOIf+Bk/8Yj6ywHQBU8Bjt2ERSA=;
        b=gfwa5jrglLoa5fuY1QGoPDUJMIbbgDSrETh/4mpH4KsyTU67QL3eRANgoIMarXrnVs
         V2bGuF+uKyPp7/EkGzjEU4iDByLEXSjeVvtVAX0gSKGUUBQH10kI35LiDQFRFDjOzbFC
         8dY9ep10w5N8xGsDSAD5sSnFN75phkeLT1KA7yWpb+BTDt93HUosROrHXSiKp6uwwOiW
         O7/mamNTfwMPtvfrE50hreLR3iK1P5SsoBN0ZtKQqDjx9WGZxJgUxDnoozz19AFA6gOZ
         BMtbF6GoKxp/hUTXp1Cwmnv7gTjKHfvfS7YczJ2QqRWfBhqmLKLsutevjVRUEE5ry7t7
         18eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m5V+wQp3beiXYJCPtOIf+Bk/8Yj6ywHQBU8Bjt2ERSA=;
        b=HBCWptIg84rf0jfVuwbNRa1RyJK65PdRKOCVU4li7OgHI2GYF7xiqqE6K+GgU6kQMX
         n7AtemwVCGo4cWznP5TAo3czy5v//bP6J088WKbkLISAf/H09eK8IaELBmoUgIyjI723
         Oix5ZvsiK0E/8rZIBoQbiKsBpG6FRJ8wMF0TAt0/mDloWGQcOpPuv1F3Bj4WryG8tH1N
         bp1XBBIPbr9wy9GZ9bo/J/o4UBd2wo99DWVCuBcC4I9d7nY0DWiHP2rWqiM8LxZ9qcVc
         tbpjTnj8Uk2kgHfUjQeUfngXMWWYUShp9KTYPN/WPVim7fv67zzd0N6pQTKbXn7KYYqf
         PiyQ==
X-Gm-Message-State: APzg51Aihjx9V8Sh8pg2YT007Fe1LCXdGB9JnDqpO4JxZpCy0qbV66bH
        9apVxwMjgzs+b8aGJ3Rxrw==
X-Google-Smtp-Source: ANB0VdYq+ojwXnrGLp0TylTa5IDYdCTmvmjudMYhN69yYBvF26mCnqCXv9RCQM0oGjLuY5DMSHcE3Q==
X-Received: by 2002:ac8:25c4:: with SMTP id f4-v6mr24312937qtf.227.1537380945752;
        Wed, 19 Sep 2018 11:15:45 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c21-v6sm11327718qtj.22.2018.09.19.11.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 11:15:44 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:15:42 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] mm: zero remaining unavailable struct pages
Message-ID: <20180919181540.gflxwl3sp2cxqhoe@gabell>
References: <20180823182513.8801-1-msys.mizuma@gmail.com>
 <20180823182513.8801-2-msys.mizuma@gmail.com>
 <7c773dec-ded0-7a1e-b3ad-6c6826851015@microsoft.com>
 <484388a7-1e75-0782-fdfb-20345e1bda0d@gmail.com>
 <20180831025536.GA29753@hori1.linux.bs1.fc.nec.co.jp>
 <20180917132605.eln6tlc6hf7vfjy2@gabell>
 <20180919015440.GA2581@hori1.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919015440.GA2581@hori1.linux.bs1.fc.nec.co.jp>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:54:40AM +0000, Naoya Horiguchi wrote:
> On Mon, Sep 17, 2018 at 09:26:07AM -0400, Masayoshi Mizuma wrote:
> > On Fri, Aug 31, 2018 at 02:55:36AM +0000, Naoya Horiguchi wrote:
> > > On Wed, Aug 29, 2018 at 11:16:30AM -0400, Masayoshi Mizuma wrote:
> > > > Hi Horiguchi-san and Pavel
> > > > 
> > > > Thank you for your comments!
> > > > The Pavel's additional patch looks good to me, so I will add it to this series.
> > > > 
> > > > However, unfortunately, the movable_node option has something wrong yet...
> > > > When I offline the memory which belongs to movable zone, I got the following
> > > > warning. I'm trying to debug it.
> > > > 
> > > > I try to describe the issue as following. 
> > > > If you have any comments, please let me know.
> > > > 
> > > > WARNING: CPU: 156 PID: 25611 at mm/page_alloc.c:7730 has_unmovable_pages+0x1bf/0x200
> > > > RIP: 0010:has_unmovable_pages+0x1bf/0x200
> > > > ...
> > > > Call Trace:
> > > >  is_mem_section_removable+0xd3/0x160
> > > >  show_mem_removable+0x8e/0xb0
> > > >  dev_attr_show+0x1c/0x50
> > > >  sysfs_kf_seq_show+0xb3/0x110
> > > >  seq_read+0xee/0x480
> > > >  __vfs_read+0x36/0x190
> > > >  vfs_read+0x89/0x130
> > > >  ksys_read+0x52/0xc0
> > > >  do_syscall_64+0x5b/0x180
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > RIP: 0033:0x7fe7b7823f70
> > > > ...
> > > > 
> > > > I added a printk to catch the unmovable page.
> > > > ---
> > > > @@ -7713,8 +7719,12 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
> > > >                  * is set to both of a memory hole page and a _used_ kernel
> > > >                  * page at boot.
> > > >                  */
> > > > -               if (found > count)
> > > > +               if (found > count) {
> > > > +                       pr_info("DEBUG: %s zone: %lx page: %lx pfn: %lx flags: %lx found: %ld count: %ld \n",
> > > > +                               __func__, zone, page, page_to_pfn(page), page->flags, found, count);
> > > >                         goto unmovable;
> > > > +               }
> > > > ---
> > > > 
> > > > Then I got the following. The page (PFN: 0x1c0ff130d) flag is 
> > > > 0xdfffffc0040048 (uptodate|active|swapbacked)
> > > > 
> > > > ---
> > > > DEBUG: has_unmovable_pages zone: 0xffff8c0ffff80380 page: 0xffffea703fc4c340 pfn: 0x1c0ff130d flags: 0xdfffffc0040048 found: 1 count: 0 
> > > > ---
> > > > 
> > > > And I got the owner from /sys/kernel/debug/page_owner.
> > > > 
> > > > Page allocated via order 0, mask 0x6280ca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO)
> > > > PFN 7532909325 type Movable Block 14712713 type Movable Flags 0xdfffffc0040048(uptodate|active|swapbacked)
> > > >  __alloc_pages_nodemask+0xfc/0x270
> > > >  alloc_pages_vma+0x7c/0x1e0
> > > >  handle_pte_fault+0x399/0xe50
> > > >  __handle_mm_fault+0x38e/0x520
> > > >  handle_mm_fault+0xdc/0x210
> > > >  __do_page_fault+0x243/0x4c0
> > > >  do_page_fault+0x31/0x130
> > > >  page_fault+0x1e/0x30
> > > > 
> > > > The page is allocated as anonymous page via page fault.
> > > > I'm not sure, but lru flag should be added to the page...?
> > > 
> > > There is a small window of no PageLRU flag just after page allocation
> > > until the page is linked to some LRU list.
> > > This kind of unmovability is transient, so retrying can work.
> > > 
> > > I guess that this warning seems to be visible since commit 15c30bc09085
> > > ("mm, memory_hotplug: make has_unmovable_pages more robust")
> > > which turned off the optimization based on the assumption that pages
> > > under ZONE_MOVABLE are always movable.
> > > I think that it helps developers find the issue that permanently
> > > unmovable pages are accidentally located in ZONE_MOVABLE zone.
> > > But even ZONE_MOVABLE zone could have transiently unmovable pages,
> > > so the reported warning seems to me a false charge and should be avoided.
> > > Doing lru_add_drain_all()/drain_all_pages() before has_unmovable_pages()
> > > might be helpful?
> > 
> > Thanks you for your proposal! And sorry for delayed responce.
> > 
> > lru_add_drain_all()/drain_all_pages() might be helpful, but it 
> > seems that the window is not very small because I tried to do
> > offline some times, and every offline failed...
> 
> OK, so this doesn't work, thank you for trying.
> 
> > 
> > I have another idea. I found that if the page is belonged to
> > Movable zone and it has Uptodate flag, the page will go lru
> > soon, so I think we can pass the page.
> > Does the idea make sence? As far as I tested it, it works well.
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 52d9efe8c9fb..ecf87bec8ac6 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7758,6 +7758,9 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
> >                 if (__PageMovable(page))
> >                         continue;
> > 
> > +               if ((zone_idx(zone) == ZONE_MOVABLE) && PageUptodate(page))
> > +                       continue;
> > +
> 
> We have many call sites calling SetPageUptodate (many are from filesystems,)
> so I'm concerned that some caller might set PageUptodate on non-LRU pages.
> Could you explain a little more how/why this check is a clear separation b/w
> movable pages and unmovable pages?
> (Filesystem metadata is never allocated from ZONE_MOVABLE?)

Thanks, this is a good question.
As far as I can see, the caller which gets pages from movable zone
sets PageUptodate, or the page goes lru soon. But, yes, that is not
guranteed, so we should not use the check...

I have rethinked this. We may not need the Uptodate flag checking
here because ZONE_MOVABLE has movable pages only basically and the
addtional checkings are done here.

Or, PAGE_MAPPING_MOVABLE should be set in the mapping when
the movable page is allocated.

Thanks,
Masa
