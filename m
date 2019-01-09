Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F29BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A9C206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bD2b+gDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfAIWvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:51:47 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33819 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbfAIWvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:51:46 -0500
Received: by mail-yb1-f193.google.com with SMTP id w186so2786238ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/PELudoJ9+yusLyWAV/ORaSDQ7RbDfqH8OvQbS5ILw=;
        b=bD2b+gDcHCHp+Kl1aNcH3MGObexA4fX/zV8gbJjs37vDT3DCawzNgGAqBXlvk7qtDp
         2HXgfdeolfZtUt5dtwt3QmaKZrx+aB0Gj8cuFFS0sruSSUl7gyDtHTdHRuUTwMBW+3te
         PdMPr2Pb1cGtUKQrdPb0cY9hUvCtaIPEAsECOppZjEXnU9wDmroctWchPOv17ul2gspH
         CL+1MjECxVF1mB9X+CRy1pPGvOqBYzGFqSmpBZViSjd3/W1ysKwSyGmc2KTizbnX+/rJ
         DsCGFwvkMYEf87+gyj3dovhQC84AByDizo+iWMG6bqc5wTXq3oi4d7VoynPl8HKQxPNh
         KiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/PELudoJ9+yusLyWAV/ORaSDQ7RbDfqH8OvQbS5ILw=;
        b=LkEfnlJsskcTZMbhJPbmVE+GnaLDUeQox/Iheawc3yPPq2wBELSkmfph6YJ0IdVpJv
         1ke2K6QeczhaFEQk6LX7eXj84NXoLWreVXlTuJz69J2QErcaOzfWp3Z66DgQCZfEkgu3
         MxFuwFKlAEhoI712eXEJjU9yN0J8d6cslgdOA2HdI3fB4DTSLvZNYoW1ZwVqgv3S/RBd
         6NdFkwy9tHObvfonlLIw3ABtX0zTvInjfTjOVEFnYK2yB+Qodt/4pX2iLD+Ah7mqMEiv
         Nok2SaLkuXz6g3TiHD16a+4BNfUr+AgAyoLPHiYD+eRZtsWkanwSs0gAk5GyV9jcM90r
         W7yA==
X-Gm-Message-State: AJcUukeIsl4eRrVuptxBYzMDdabY7ht1+SLHp+yWn3Uf+Iotp3Lz7BHH
        LvJFEgIcx8w0ELxEOASWbr/iBg==
X-Google-Smtp-Source: ALg8bN43to+hXFHIVq9mhfwhgv4ve082evkLnurxYP12X3cJwNBMdwyGxi44c8Ipqrhf0AcAArbpXg==
X-Received: by 2002:a25:b81:: with SMTP id 123mr7438835ybl.335.1547074305397;
        Wed, 09 Jan 2019 14:51:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:f15b])
        by smtp.gmail.com with ESMTPSA id k64sm26253105ywc.56.2019.01.09.14.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 14:51:44 -0800 (PST)
Date:   Wed, 9 Jan 2019 17:51:43 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 0/5] mm: memcontrol: do memory reclaim when
 offlining
Message-ID: <20190109225143.GA22252@cmpxchg.org>
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190109193247.GA16319@cmpxchg.org>
 <d92912c7-511e-2ab5-39a6-38af3209fcaf@linux.alibaba.com>
 <20190109212334.GA18978@cmpxchg.org>
 <9de4bb4a-6bb7-e13a-0d9a-c1306e1b3e60@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de4bb4a-6bb7-e13a-0d9a-c1306e1b3e60@linux.alibaba.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 02:09:20PM -0800, Yang Shi wrote:
> On 1/9/19 1:23 PM, Johannes Weiner wrote:
> > On Wed, Jan 09, 2019 at 12:36:11PM -0800, Yang Shi wrote:
> > > As I mentioned above, if we know some page caches from some memcgs
> > > are referenced one-off and unlikely shared, why just keep them
> > > around to increase memory pressure?
> > It's just not clear to me that your scenarios are generic enough to
> > justify adding two interfaces that we have to maintain forever, and
> > that they couldn't be solved with existing mechanisms.
> > 
> > Please explain:
> > 
> > - Unmapped clean page cache isn't expensive to reclaim, certainly
> >    cheaper than the IO involved in new application startup. How could
> >    recycling clean cache be a prohibitive part of workload warmup?
> 
> It is nothing about recycling. Those page caches might be referenced by
> memcg just once, then nobody touch them until memory pressure is hit. And,
> they might be not accessed again at any time soon.

I meant recycling the page frames, not the cache in them. So the new
workload as it starts up needs to take those pages from the LRU list
instead of just the allocator freelist. While that's obviously not the
same cost, it's not clear why the difference would be prohibitive to
application startup especially since app startup tends to be dominated
by things like IO to fault in executables etc.

> > - Why you couldn't set memory.high or memory.max to 0 after the
> >    application quits and before you call rmdir on the cgroup
> 
> I recall I explained this in the review email for the first version. Set
> memory.high or memory.max to 0 would trigger direct reclaim which may stall
> the offline of memcg. But, we have "restarting the same name job" logic in
> our usecase (I'm not quite sure why they do so). Basically, it means to
> create memcg with the exact same name right after the old one is deleted,
> but may have different limit or other settings. The creation has to wait for
> rmdir is done.

This really needs a fix on your end. We cannot add new cgroup control
files because you cannot handle a delayed release in the cgroupfs
namespace while you're reclaiming associated memory. A simple serial
number would fix this.

Whether others have asked for this knob or not, these patches should
come with a solid case in the cover letter and changelogs that explain
why this ABI is necessary to solve a generic cgroup usecase. But it
sounds to me that setting the limit to 0 once the group is empty would
meet the functional requirement (use fork() if you don't want to wait)
of what you are trying to do.

I don't think the new interface bar is met here.
