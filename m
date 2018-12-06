Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0CC208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="tWNkkaU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0CC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbeLFST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:19:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44620 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLFST6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:19:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so489383pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kmQWjoh3kxe3DvswB4NbjL0kGdShPoCpZpw31DKhVKQ=;
        b=tWNkkaU4cMcgvEDFd3uNmGxw+NmYQz5htmdl/zdY9cYDtLCG/3OmxnrFO87acLyvTa
         q6sz01e+IO1VTAOpfQzv6dyhj5qxxYOxl1v09/2Zjmj90eiQrpRJ9MNgqqwCK/a+5xJU
         sVq3NYDTvwxx8zo8118PLtU8Xg4VbLbMumi5/py7MKuwSvbxSe4GKPkLN57UOFiq2Vun
         2lanR8MkQNBfpImphISM5ShMPRrBnHwGYzAsaQlspmU7m/pNs/BJVHrNgUhg7bYNeMN7
         tbnhDvqq8H16jEJ9UonqvQJhTfcJcQt5psyP84LolTtug7dTTycxgK58oSQ//zsKcRBz
         mu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kmQWjoh3kxe3DvswB4NbjL0kGdShPoCpZpw31DKhVKQ=;
        b=F3iUmuafAFpqCoJnStNen6p2Gy1cjc7rCgqo5MyOAmC+fvQVIur4FnoDVuLyLwgwmF
         uf78jcYq6kYFBM/wzD1EVvCNczu8rXPvA/wqb2nLEx/JRFFzme4MZBxo7m/qUf47ktf0
         LADCQuw2LCAl1k3Zk/IYNVeb5mEdGWVOXk7yrzwzhgy8P5MwI1c5K4hFoGxxud2EV8YQ
         d2n2/VWCkWW5Ut2XP5Lk/DcQe6FwVncc8XgVG9v3bK2SDwkXrHLpV/7as2ueWNldeLrN
         Abe9g+plFnvXXvTMKaUKf3raPH2pe7Z5rigR3Krgo119vSMck8qEDtDRbs9iyWDaoZli
         bkmQ==
X-Gm-Message-State: AA+aEWb7itNAXY9ds7OPb4heCM4ghk6M9QI9N+JJCHiLiocT+PVnfYng
        GEoRCvha//9IfmWpZgcjORPXmQ==
X-Google-Smtp-Source: AFSGD/VOerhBhi+56IiTlRnxOHOWe3kOHD1SZ1W9XMkefhe5ZR8jK1HDvU68dusD+8N8JtaPAXc6tQ==
X-Received: by 2002:a62:31c1:: with SMTP id x184mr30396773pfx.204.1544120396793;
        Thu, 06 Dec 2018 10:19:56 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:7ead])
        by smtp.gmail.com with ESMTPSA id e23sm1244630pfh.68.2018.12.06.10.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 10:19:56 -0800 (PST)
Date:   Thu, 6 Dec 2018 10:19:54 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     mingo@redhat.com, peterz@infradead.org, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH v3 01/10] sched: Provide sparsemask, a reduced contention
 bitmap
Message-ID: <20181206181954.GG11220@vader>
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-2-git-send-email-steven.sistare@oracle.com>
 <7a3e87ac-db63-27c5-8490-2330637e59b1@oracle.com>
 <20181128011904.GR846@vader>
 <10d4b797-bb35-c93a-0514-1aaf738162a9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d4b797-bb35-c93a-0514-1aaf738162a9@oracle.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:07:46AM -0500, Steven Sistare wrote:
> On 11/27/2018 8:19 PM, Omar Sandoval wrote:
> > On Tue, Nov 27, 2018 at 10:16:56AM -0500, Steven Sistare wrote:
> >> On 11/9/2018 7:50 AM, Steve Sistare wrote:
> >>> From: Steve Sistare <steve.sistare@oracle.com>
> >>>
> >>> Provide struct sparsemask and functions to manipulate it.  A sparsemask is
> >>> a sparse bitmap.  It reduces cache contention vs the usual bitmap when many
> >>> threads concurrently set, clear, and visit elements, by reducing the number
> >>> of significant bits per cacheline.  For each 64 byte chunk of the mask,
> >>> only the first K bits of the first word are used, and the remaining bits
> >>> are ignored, where K is a creation time parameter.  Thus a sparsemask that
> >>> can represent a set of N elements is approximately (N/K * 64) bytes in
> >>> size.
> >>>
> >>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >>> ---
> >>>  include/linux/sparsemask.h | 260 +++++++++++++++++++++++++++++++++++++++++++++
> >>>  lib/Makefile               |   2 +-
> >>>  lib/sparsemask.c           | 142 +++++++++++++++++++++++++
> >>>  3 files changed, 403 insertions(+), 1 deletion(-)
> >>>  create mode 100644 include/linux/sparsemask.h
> >>>  create mode 100644 lib/sparsemask.c
> >>
> >> Hi Peter and Ingo,
> >>   I need your opinion: would you prefer that I keep the new sparsemask type, 
> >> or fold it into the existing sbitmap type?  There is some overlap between the 
> >> two, but mostly in trivial one line functions. The main differences are:
> > 
> > Adding Jens and myself.
> > 
> >>   * sparsemask defines iterators that allow an inline loop body, like cpumask,
> >>   whereas the sbitmap iterator forces us to define a callback function for
> >>   the body, which is awkward.
> >>
> >>   * sparsemask is slightly more efficient.  The struct and variable length
> >>   bitmap are allocated contiguously,
> > 
> > That just means you have the pointer indirection elsewhere :) The users
> > of sbitmap embed it in whatever structure they have.
>  
> Yes, the sparsemask can be embedded in one place, but in my use case I also cache
> pointers to the mask from elsewhere, and those sites incur the cost of 2 indirections
> to perform bitmap operations.
> 
> >>   and sbitmap uses an extra field "depth"
> >>   per bitmap cacheline.
> > 
> > The depth field is memory which would otherwise be unused, and it's only
> > used for sbitmap_get(), so it doesn't have any cost if you're using it
> > like a cpumask.
> > 
> >>   * The order of arguments is different for the sparsemask accessors and
> >>   sbitmap accessors.  sparsemask mimics cpumask which is used extensively
> >>   in the sched code.
> >>
> >>   * Much of the sbitmap code supports queueing, sleeping, and waking on bit
> >>   allocation, which is N/A for scheduler load load balancing.  However, we
> >>   can call the basic functions which do not use queueing.
> >>
> >> I could add the sparsemask iterators to sbitmap (90 lines), and define
> >> a thin layer to change the argument order to mimic cpumask, but that
> >> essentially recreates sparsemask.
> > 
> > We only use sbitmap_for_each_set() in a few places. Maybe a for_each()
> > style macro would be cleaner for those users, too, in which case I
> > wouldn't be opposed to changing it. The cpumask argument order thing is
> > a annoying, though.
> > 
> >> Also, pushing sparsemask into sbitmap would limit our freedom to evolve the
> >> type to meet the future needs of sched, as sbitmap has its own maintainer,
> >> and is used by drivers, so changes to its API and ABI will be frowned upon.
> > 
> > It's a generic data structure, so of course Jens and I have no problem
> > with changing it to meet more needs :) Personally, I'd prefer to only
> > have one datastructure for this, but I suppose it depends on whether
> > Peter and Ingo think the argument order is important enough.
> 
> The argument order is a minor thing, not a blocker to adoption, but efficiency 
> is important in the core scheduler code.  I actually did the work to write a
> for_each macro with inline body to sbitmap, and converted my patches to use sbitmap.
> But then I noticed your very recent patch adding the cleared word to each cacheline, 
> which must be loaded and ANDed with each bitset word in the for_each traversal,
> adding more overhead which we don't need for the scheduler use case, on top of the
> extra indirection noted above. You might add more such things in the future (a
> "deferred set" word?) to support the needs of the block drivers who are the 
> intended clients of sbitmap.
> 
> Your sbitmap is more than a simple bitmap abstraction, and for the scheduler we
> just need simple.  Therefore, I propose to trim sparsemask to the bare minimum,
> and move it to kernel/sched for use 
> by sched only.
>   It was 400 lines, but will
> be 200, and 80 of those are comments.
> 
> If anyone objects, please speak now.

Yes, after the recent changes, I think it's reasonable to have a
separate implementation for sched.
