Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E121C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFF221473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0w7whLyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeLQWub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:50:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59112 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeLQWua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ewyNVfIQur5dYaPnBPCaCuzQ2dHgrMZzNkkb6MCSIxQ=; b=0w7whLyppnyCzu1paF1B2/tuq
        sA9+Sqikd5vWwFnDWR6iTSlLQwO3xClbfLeViWsViFel2HtWeFUbdkX+OdTSFBheWaGf6Wcg55qEI
        sq0Zr/ofhEJFTzkK+YpAv+fBZeYpXomyffG+Q6exz9k4Ywysh7gCYvzt5og9mtSjaULwsWmO7BOFZ
        ZIKvC7KwbHy8SmI2maS7J3M/YopkkNB5wbJ00NUzc64FV3FMTb6yB8DKCsfx74T9cRxKvXy8AvzEB
        0LF/RBXArU814VKuP6Vdy07oQkmeQccHkrTRBKoh18/2DEJQ0BDsQgTgjOIJUiNZr1e0KTFbfCYLZ
        CTCKHm87Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZ1iP-0004LK-8x; Mon, 17 Dec 2018 22:50:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16A9F20276AAC; Mon, 17 Dec 2018 23:50:20 +0100 (CET)
Date:   Mon, 17 Dec 2018 23:50:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/7] ARM: hacks for link-time optimization
Message-ID: <20181217225020.GA16520@hirez.programming.kicks-ass.net>
References: <20180220215954.4092811-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 10:59:47PM +0100, Arnd Bergmann wrote:
> Hi Nico, all,
> 
> I was playing with ARM link-time optimization handling earlier this
> month, and eventually got it to build cleanly with randconfig kernels,
> but ended up with a lot of ugly hacks to actually pull it off.

How are we dealing with the fact that LTO can break RCU in very subtle
and scary ways?

Do we have a compiler guy on board that has given us a compiler switch
that kills that optimization (and thereby guarantees that behaviour for
future compilers etc..) ?

Also see the thread here:

  https://lkml.kernel.org/r/20171116115810.GH9361@arm.com

(and yes, this is a fine example of how lore sucks for reading email)


