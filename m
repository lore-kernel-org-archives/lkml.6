Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF617C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7023621711
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 04:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpR4f+8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7023621711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeHCGp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:45:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36910 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeHCGpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:45:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id a26-v6so2567338pfo.4;
        Thu, 02 Aug 2018 21:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPx17pyTwH83a4kYwiR0LXQKXjyTj8DF1zf8QdAICBU=;
        b=tpR4f+8eVmngRWdNd5eQE5ArwIJLPTnYoEKSs8p+GA2s7buWwIDp4y1ZsmvcSwK9dx
         fEhdXpOgv/Wwd3cyrJLR1hV9hvo1Ptd1gdN9E63caTnice8IqVUwaNJzsD09pNSbPxU8
         4JtY4DxhRIOnJk4Te681X0DtYbIYaQOmFDIfG5AddGIAxU6iaN7adb5A7RVIGOkM8TAO
         FtqK0962wudwiH4LwZ0hdLNHepdtA8b8mwgN1DurFGECUnzL8FwbhJZzk8mxK1Y1F7AG
         xjclHGZY3gYswNWxS1QBD8UaUEq+8UkY20CNsQg4mhDuXbahhoD9CmkfzN9/fbky/JM2
         LodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPx17pyTwH83a4kYwiR0LXQKXjyTj8DF1zf8QdAICBU=;
        b=bJ26yoV5EIpgba7dgriQXyHgDZIXwmyARaTxKbbBO05+uMHGe/NtcmavDnXm8o8l4e
         baTdagfKgd2jCT7xXiPstR8kfZzJFUgW5DoHGpTujXUyyMpSgZYfHQq6+HswlWrXstJi
         POIvIQlUt44NFcOyZBuSkezNq2g0pLfX7RYEfzewRa9GiNGiOQX7QHML1yltBZM1Du5u
         o8iBtlk1yo0gWBGWidO5khZo+ypBgnlEib46u9S2WDy/Lkww9x1j8kwjTwvokyZKwRda
         dPRyzED8NDdBxS0lwlfJ3p4X7AJEOEZI4r3wzMeoaHxZqin+2k4IkCpRmbvSzXuedSar
         8qWQ==
X-Gm-Message-State: AOUpUlGkTbGN3iLq+bTUl8FX69b0poKykdJtQrRCbCAx16TXuB/wMKLP
        K5mpKKrj20CC/RaBDUQWGhk=
X-Google-Smtp-Source: AAOMgpd6woTyWtZAT4o15k3nlJcin+4LAZPi/YUgWU7R6aIo/FlUwt4VhvlGU/41eDJS8CikHEl86g==
X-Received: by 2002:a63:5815:: with SMTP id m21-v6mr2127700pgb.78.1533271887903;
        Thu, 02 Aug 2018 21:51:27 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:9465:817a:e0d1:934d])
        by smtp.gmail.com with ESMTPSA id k123-v6sm3536254pga.21.2018.08.02.21.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 21:51:26 -0700 (PDT)
Date:   Fri, 3 Aug 2018 13:51:21 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tino Lehnig <tino.lehnig@contabo.de>, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] zram: remove BD_CAP_SYNCHRONOUS_IO with writeback
 feature
Message-ID: <20180803045121.GC86818@rodete-desktop-imager.corp.google.com>
References: <20180802051112.86174-1-minchan@kernel.org>
 <20180802141304.d0589ddc5f8213429ab3b565@linux-foundation.org>
 <20180803023929.GA7500@jagdpanzerIV>
 <20180803030019.GB86818@rodete-desktop-imager.corp.google.com>
 <20180803041302.GB502@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803041302.GB502@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 01:13:02PM +0900, Sergey Senozhatsky wrote:
> Hi Minchan,
> 
> On (08/03/18 12:00), Minchan Kim wrote:
> > > 	"Device is so fast that asynchronous IO would be inefficient."
> > > 
> > > Which is not the reason why BDI_CAP_SYNCHRONOUS_IO is used by ZRAM.
> > > Probably, the comment needs to be updated as well.
> > 
> > I couldn't catch your point. Could you clarify a little bit more?
> > What do you want to correct for the comment?
> >
> > > Both SWP_SYNCHRONOUS_IO and BDI_CAP_SYNCHRONOUS_IO tend to pivot
> > > "efficiency" [looking at the comments], but in ZRAM's case the whole
> > > reason to use SYNC IO is a race condition and user-after-free that
> > > follows.
> > 
> > Actually, it's not whole reason. As I wrote down, without it, swap_readpage
> > waits the IO completion for a long time by blk_poll so it causes system
> > sluggish problem when device is slow(e.g., zram with backing device).
> 
> Sure, this is problem #1. But slow swap device probably doesn't do any
> irreversible harm to the system. Unlike use-after-free, which does. Thus
> use-after-free is a problem #0. BDI_CAP_SYNCHRONOUS_IO comment doesn't
> mention problem #0; it talks about problem #1 only. So, nothing serious,
> just wanted to point that out.
> 
> So we probably can make ZRAM always ASYNC when WB is enabled.
> 
> 
> Or... maybe we can make swap out to be SYNC and perform WB in background.
> In __zram_bvec_write() we can always write compressed object to zmalloc,
> even the huge ones.
> Things to note:
> a) even when WB is enabled we still allocate huge classes
> b) even when WB is enabled we still may use those huge classes (consider
>    a case when backing devices is full)
> 
> So huge classes are still there and we still use them. So let's use
> them?
> 
> For a huge object, after we stored it into zsmalloc, we can schedule a WB
> work, which would:
> a) write that particular object (page) to the backing device
> b) mark entry as WB entry
> c) remove object from zsmalloc, unlock necessary locks
> 
> So swap in should either see object in zsmalloc or on backing device.
> How does this sound?
> 
> And reading from a backing device can always be SYNC. Can it?
> Am I missing something?

AFAIK, onging writeback page couldn't freed so it was not writeabck problem.

What I'm tryig to fix is read part.
If we use swapcache, it shouldn't be a problem either because swapcache
has a reference count and we should wait PG_lock release before the freeing
from the swapcache so there is no race condition.

However, by the skip swapcache logic, we don't have a refcount any longer.

I think we can hold a new refcount in zram driver itself. With that, we
could get both benefits from writeback feature and skip swapcache.

However, I decided, at this moment, going this simple way for
stable-material to solve #0 and #1 problems at the same time.

Thanks. 


> 
> 	-ss
