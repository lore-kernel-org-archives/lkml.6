Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD65EA400E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C792124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TTdwuBEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C792124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeGLSDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:03:09 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:32772 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeGLSDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:03:08 -0400
Received: by mail-wr1-f49.google.com with SMTP id g6-v6so13656910wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=szhr23pVXJblGUH93JYkIdBsdDtF5QaxckiOSOlZbbY=;
        b=TTdwuBEzdseNgDcGUQYsxsRJO2Rr0h4fLEjqOhAGvN8aXUxmtXYlFoVdugrOsVd1WK
         clmIR3lZB6fbtORsjaZ+145BfivsQjOReT7B8vl/VK9dj3n3vfzp28Eqam7wUGOSix5b
         CmSkNZWj3i3Ais2odBfa65VM43K6WZHnJMHh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=szhr23pVXJblGUH93JYkIdBsdDtF5QaxckiOSOlZbbY=;
        b=JyYT72Gmh67436gsHHTpFbh3mcTK4n+R7hkBciPDjaJFmnhwhRYk27x2rc8hsydjE0
         UgEGtTnCBiLZrh10lq2HOVZUjpoYOAL5YbVBMe/6vqY9zFhqTOoxSd9Dv4VI4f19Y/1W
         a8aZv6q85fH475cC/CpKnwkrj5c+GqxN1S4uSsEFcYYuXdIa+a0Y7XbBHUeO8LduQ/Kl
         NbbgWA2mmPsZnA5JCtYx8I7YqDcpd4tFwDAnD4Ukrvg4alOQBwYjlKUMHtJo66LuW5tK
         LwWoIyRBExqycA6CmlMQnmpnsh3sn0EfzIMBCD/vX5gIieDA7W/b/7Go+Er723LYNBgP
         1faw==
X-Gm-Message-State: AOUpUlE+gXtUGCnlI6D843LkdSP4dSyeBGi+DoIvryFnqa5Zh08JU0Jv
        PnyChZ2id0TMlTdEA2OzcUrFtg==
X-Google-Smtp-Source: AAOMgpehArnUWY78QrlJHOVEYeHRDozv0gqV2kjqOiTE0V3xbyqwnXuzLWm7ijkbpKBrrogtKhkrFg==
X-Received: by 2002:adf:ed41:: with SMTP id u1-v6mr2385285wro.262.1531417951169;
        Thu, 12 Jul 2018 10:52:31 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id 65-v6sm7457850wmk.46.2018.07.12.10.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 10:52:30 -0700 (PDT)
Date:   Thu, 12 Jul 2018 19:52:28 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712175228.GB3533@andrea>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems reasonable to ask people to learn that locks have stronger
> ordering guarantees than RMW atomics do.  Maybe not the greatest
> situation in the world, but one I think we could live with.

Yeah, this was one of my main objections.


> > Hence my proposal to strenghten rmw-acquire, because that is the basic
> > primitive used to implement lock.
> 
> That was essentially what the v2 patch did.  (And my reasoning was
> basically the same as what you have just outlined.  There was one
> additional element: smp_store_release() is already strong enough for
> TSO; the acquire is what needs to be stronger in the memory model.)

Mmh? see my comments to v2 (and your reply, in part., the part "At
least, it's not a valid general-purpose implementation".).


> > Another, and I like this proposal least, is to introduce a new barrier
> > to make this all work.
> 
> This apparently boils down to two questions:
> 
> 	Should spin_lock/spin_unlock be RCsc?
> 
> 	Should rmw-acquire be strong enough so that smp_store_release + 
> 	rmw-acquire is RCtso?
> 
> If both answers are No, we end up with the v3 patch.  If the first
> answer is No and the second is Yes, we end up with the v2 patch.  The
> problem is that different people seem to want differing answers.

Again, maybe you're confonding v2 with v1?

  Andrea


> 
> (The implicit third question, "Should spin_lock/spin_unlock be RCtso?",
> seems to be pretty well settled at this point -- by Peter's and Will's
> vociferousness if nothing else -- despite Andrea's reservations.  
> However I admit it would be nice to have one or two examples showing
> that the kernel really needs this.)
> 
> Alan
> 
