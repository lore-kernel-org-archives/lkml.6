Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2640B206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="av/L6HRW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2640B206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeGQTI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:08:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49416 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbeGQTIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5xqV5Q+eA1wqQnyJNtE/ynk+9r9rqUWGPe61Xnmw9iw=; b=av/L6HRWy8X9enCwLEKxJwt3M
        7xG/+tdEZLUq1ISu2QtwF5cplpyDPV1OqzAlZXjWNKU7lYx1MqrWCjqcbolRIsLwLkcYittcDQVc2
        v9NKEuoib6sKPOnJsCPoyBewvBv2FLsH8RQo8oJvS1Xg8oiUDA2tU+PlqKF2g3L76YNBFP+BdhrvJ
        j++pZp4rSyT4vrJJf+PrVJPBB/kyWMEV+zYz6j1xIXkC3Ln7msXrfVSxHuWn7Fq3Cbgh6O0QwX8We
        MFML38qXxftN/LqTMO8PoZTF8+n4hQFwtZdwSnhOQfIMUyPC4OMSfRGC49EL9ha1FcOC3pXjL642t
        pfaZICplw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffUoH-0002pe-0T; Tue, 17 Jul 2018 18:34:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 737E320275F37; Tue, 17 Jul 2018 20:34:50 +0200 (CEST)
Date:   Tue, 17 Jul 2018 20:34:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     matt@codeblueprint.co.uk, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, gregkh@linuxfoundation.org,
        pkondeti@codeaurora.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] stop_machine: Disable preemption after queueing
 stopper threads
Message-ID: <20180717183450.GL2494@hirez.programming.kicks-ass.net>
References: <1531845017-19935-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531845017-19935-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:30:17AM -0700, Isaac J. Manjarres wrote:
> After cpu_stop_queue_two_works() queues the cpu_stop works
> for the stopper threads, it releases the locks held for
> both threads, which enables preemption, which allows the
> following race condition to occur:


Does not apply because an earlier version is already applied.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/kernel/stop_machine.c?id=9fb8d5dc4b649dd190e1af4ead670753e71bf907

if there still is a problem, please send a new patch that describes the
remaining problem.
