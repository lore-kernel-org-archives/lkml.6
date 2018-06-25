Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEBFC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C1C257B4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JmxALotu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C1C257B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeFYK4b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:56:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50367 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755260AbeFYK41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:56:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so8721689wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 03:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ogIL3yb10eO2zBiNP7tMLo5NgpmJiRLveQpIw8LnwQ=;
        b=JmxALotuvuzgm79cZrw6w2bccRM9Ie0LwgV9ODrjKWtmYx46r3QkOKhySl0ZAHXoKj
         8pcRM/MmFo5tLJ+kBuJpq/V7eHwIV3DV+rZsSuYwvddHzlHwRTYCIpt2HRwtLMPAdPMC
         XaP544AFeoa9Z9iEfh2/L3HJcBh+beeVp/BEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ogIL3yb10eO2zBiNP7tMLo5NgpmJiRLveQpIw8LnwQ=;
        b=KKs+e68UJcferJB9Ex8akVPE5D3UpnhEZMeGGprsjHDXtJQAhOF/GoL1sfsLJryCx5
         qafcuqBBWkZLhL54x6M0yjvNRJvz62L5NYfB79kXNBcr4dg9ahoQMzbX2XFlGpBOcRAN
         Cku46bZbNUqXjmwboZemxHs/vCb+neR5QFIBxLTAsCj9P2HBlfN1iii29+sQB1etzLJD
         fWXhFaToMTFM4bSM/vluPV0Klgb7kW9eQMF6qLyGZAX/loqvctL5G5+YgE+flnp0PmLQ
         3hbVfLnoNBSK3U6Klmq+c4paOjffYs7ytqAmaRcSTZ6UPo2q+PtGTh0Qu208p9sinRZf
         qWCw==
X-Gm-Message-State: APt69E3EiHKoDgER3U3KXljEbTif5+or2RX6joj5LtxDuq0aAXXQHLLX
        TEgQR2Cn5AIKZ2LTSgOCrTLe8Q==
X-Google-Smtp-Source: ADUXVKJMulMyXeh6B3LsvyShgmmhkE4fURuXIBVDLCBNWDo8SCaetydDqB7rOA04CRWmBvwj3ejxLw==
X-Received: by 2002:a1c:470b:: with SMTP id u11-v6mr579642wma.49.1529924186181;
        Mon, 25 Jun 2018 03:56:26 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id q17-v6sm15149427wrs.5.2018.06.25.03.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 03:56:25 -0700 (PDT)
Date:   Mon, 25 Jun 2018 12:56:18 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180625105618.GA12676@andrea>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625095031.GX2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:50:31AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 11:17:38AM +0200, Andrea Parri wrote:
> > Both the implementation and the users' expectation [1] for the various
> > wakeup primitives have evolved over time, but the documentation has not
> > kept up with these changes: brings it into 2018.
> 
> I wanted to reply to this saying that I'm not aware of anything relying
> on this actually being a smp_mb() and that I've been treating it as an
> RELEASE.
> 
> But then I found my own comment that goes with smp_mb__after_spinlock(),
> which explains why we do in fact need the transitive thing if I'm not
> mistaken.

A concrete example being the store-buffering pattern reported in [1].


> 
> So yes, I suppose we're entirely suck with the full memory barrier
> semantics like that. But I still find it easier to think of it like a
> RELEASE that pairs with the ACQUIRE of waking up, such that the task
> is guaranteed to observe it's own wake condition.
> 
> And maybe that is the thing I'm missing here. These comments only state
> that it does in fact imply a full memory barrier, but do not explain
> why, should it?

"code (people) is relying on it" is really the only "why" I can think
of.  With this patch, that same/SB pattern is also reported in memory
-barriers.txt.  Other ideas?

  Andrea
