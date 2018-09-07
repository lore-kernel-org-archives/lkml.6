Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3460AC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21FF20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WU74o4YH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21FF20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbeIGRXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:23:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeIGRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gj6ING5DZsZIPCTxNA2w1QSRTXRuP/N6wfki6Phem5Q=; b=WU74o4YHLPjiws9JmIghucD9h
        fJbfnVUIluwi2KCdCmFW1nocjw/F3ZRoA8kBZkraoMkFJbZR547UBAP96tLgHwzMmltdQApnRTSI7
        e11ukJBhOqvgzAxJaUna31cakVk7vUa5pQ0YhHqhhvK7eE30SRpFqloZpfwUV/kMDEzJihqPNf751
        p2I8imI8CeyH2KGf6E08BE8ty8sq4+45bwAWOI09vi0Onmj6qd8BC83d65szSLSvsmMBLmTnSqCbx
        TnujLU2IMu5Y87StiFJI23b/H3C/8n1+Z+I7oDJFcwUySmYEDd0rxe9IVAb34/2fzXsySqw974tj8
        69uniEJtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyG69-00021J-IV; Fri, 07 Sep 2018 12:42:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BA8E205937FE; Fri,  7 Sep 2018 14:42:52 +0200 (CEST)
Date:   Fri, 7 Sep 2018 14:42:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] sched/topology: remove smt_gain
Message-ID: <20180907124252.GM24082@hirez.programming.kicks-ass.net>
References: <1535548752-4434-1-git-send-email-vincent.guittot@linaro.org>
 <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
 <ca95124f-db09-c38f-d96a-5240bfe8c024@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca95124f-db09-c38f-d96a-5240bfe8c024@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:08:38PM +0100, Qais Yousef wrote:
> It was hard to track the history of this and *why* it's needed.

Yeah, my bad..

So at some point I wanted to do dynamic capacity and dynamic smt gain by
using the x86 APERF/MPERF stuff. But it never quite worked and we got
stuck with the remnants.
