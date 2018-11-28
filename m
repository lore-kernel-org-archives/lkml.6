Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0886BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAAC20851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="nZFZzKRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAAC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeK1MSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:18:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45850 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeK1MSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:18:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so16484066plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 17:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BpfgkUNrRroczuw1GG3+bTnZzaoQRodz65Oal2/wuys=;
        b=nZFZzKRzCqT2wl+PXKM+ZP0a7tdSxxXdlZfFeGVEokdMKNWwAWT3qwshqD0Ci62h9b
         BdlZYjJXCrZ7tzKv1bQ+bXXF+dCQrbvhA9kVdnaafJe6BWPJ7GfJYFyDYPB4hwMgu2jP
         pN+NwdocPwugGi39rCa58oKzEMb0hkzs1NOo1p6dTKTzcupFYylpMMveHRj36RTjQKRW
         /mCeNHkzTTkmaXHVMMJtNe9I+s2xuaL4DMJ3Kd1ibaJmODDxHWslsuBRPfAJVzJ7M6Du
         phV+3c8yEbF6uIXheiYYZOvkU6H+xZ70chh8FRf9+I9G1QIXwW10bhSzY5wxeLk0ILc5
         2ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BpfgkUNrRroczuw1GG3+bTnZzaoQRodz65Oal2/wuys=;
        b=lLv6WsHQ40SoNhu8+VuwAZt6YXolWXZAQWrz41tRTMZrLzefkXkd8MH1PykcsfCWvN
         SgstfyTb3lXg4deghMQ0+15QD4kiHS6jvdSTUmyUl63GJfjR77LFFyWwSh7h+TZNEI6s
         eHz/jC6luYyccCQDoHBTSFXtQG8ebxxorbW4Nw4kpIcI9VXNMfNEqeKwVQWzPFg2jC65
         Ez1Q+2WVV8ucXmT9jfFk6ZWVy9nAZpWrwZZb2ZDwC8FFiZZfcLWZAQ/P6JeXyXu9TISL
         cjE3g6m+N0ftOULLoWqqQDxJ/A9DfsbtBCDc1+/YCiS/7jMsR9ZtoR4EnSRQZW4Xi8zJ
         GcWg==
X-Gm-Message-State: AA+aEWZRJtDXrFauqrfsEpL5TRsI2UFjhVMo69xFxfD1V+1yVFuKfs4C
        0Ko/B8iAphTwAcwB7Cld07Y9KQ==
X-Google-Smtp-Source: AFSGD/V3qjtyn+cqBIilSlUGzty/nw5c4DXhfM8qteCVdIWCzKi2Jwe/cJwYcME84kJctlvqXGjJ0A==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr34108149plr.207.1543367946884;
        Tue, 27 Nov 2018 17:19:06 -0800 (PST)
Received: from vader ([2620:10d:c090:200::5:71bd])
        by smtp.gmail.com with ESMTPSA id m67sm12842680pfb.25.2018.11.27.17.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 17:19:06 -0800 (PST)
Date:   Tue, 27 Nov 2018 17:19:04 -0800
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
Message-ID: <20181128011904.GR846@vader>
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-2-git-send-email-steven.sistare@oracle.com>
 <7a3e87ac-db63-27c5-8490-2330637e59b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3e87ac-db63-27c5-8490-2330637e59b1@oracle.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:16:56AM -0500, Steven Sistare wrote:
> On 11/9/2018 7:50 AM, Steve Sistare wrote:
> > From: Steve Sistare <steve.sistare@oracle.com>
> > 
> > Provide struct sparsemask and functions to manipulate it.  A sparsemask is
> > a sparse bitmap.  It reduces cache contention vs the usual bitmap when many
> > threads concurrently set, clear, and visit elements, by reducing the number
> > of significant bits per cacheline.  For each 64 byte chunk of the mask,
> > only the first K bits of the first word are used, and the remaining bits
> > are ignored, where K is a creation time parameter.  Thus a sparsemask that
> > can represent a set of N elements is approximately (N/K * 64) bytes in
> > size.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >  include/linux/sparsemask.h | 260 +++++++++++++++++++++++++++++++++++++++++++++
> >  lib/Makefile               |   2 +-
> >  lib/sparsemask.c           | 142 +++++++++++++++++++++++++
> >  3 files changed, 403 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/sparsemask.h
> >  create mode 100644 lib/sparsemask.c
> 
> Hi Peter and Ingo,
>   I need your opinion: would you prefer that I keep the new sparsemask type, 
> or fold it into the existing sbitmap type?  There is some overlap between the 
> two, but mostly in trivial one line functions. The main differences are:

Adding Jens and myself.

>   * sparsemask defines iterators that allow an inline loop body, like cpumask,
>   whereas the sbitmap iterator forces us to define a callback function for
>   the body, which is awkward.
>
>   * sparsemask is slightly more efficient.  The struct and variable length
>   bitmap are allocated contiguously,

That just means you have the pointer indirection elsewhere :) The users
of sbitmap embed it in whatever structure they have.

>   and sbitmap uses an extra field "depth"
>   per bitmap cacheline.

The depth field is memory which would otherwise be unused, and it's only
used for sbitmap_get(), so it doesn't have any cost if you're using it
like a cpumask.

>   * The order of arguments is different for the sparsemask accessors and
>   sbitmap accessors.  sparsemask mimics cpumask which is used extensively
>   in the sched code.
> 
>   * Much of the sbitmap code supports queueing, sleeping, and waking on bit
>   allocation, which is N/A for scheduler load load balancing.  However, we
>   can call the basic functions which do not use queueing.
> 
> I could add the sparsemask iterators to sbitmap (90 lines), and define
> a thin layer to change the argument order to mimic cpumask, but that
> essentially recreates sparsemask.

We only use sbitmap_for_each_set() in a few places. Maybe a for_each()
style macro would be cleaner for those users, too, in which case I
wouldn't be opposed to changing it. The cpumask argument order thing is
a annoying, though.

> Also, pushing sparsemask into sbitmap would limit our freedom to evolve the
> type to meet the future needs of sched, as sbitmap has its own maintainer,
> and is used by drivers, so changes to its API and ABI will be frowned upon.

It's a generic data structure, so of course Jens and I have no problem
with changing it to meet more needs :) Personally, I'd prefer to only
have one datastructure for this, but I suppose it depends on whether
Peter and Ingo think the argument order is important enough.

> FWIW, here is the amount of code involved:
> 
> include/linux/sbitmap.h
>   250 lines basic operations
>   284 lines for queueing
>   ---
>   534 lines total
> 
> lib/sbitmap.c
>   201 lines basic operations
>   380 lines for queueing
>   ---
>   581 lines total
> 
> include/linux/sparsemask.h
>   260 lines total
>   https://lkml.org/lkml/2018/11/9/1176
> 
> lib/sparsemask.c
>   142 lines total
>   https://lkml.org/lkml/2018/11/9/1176
> 
> - Steve
