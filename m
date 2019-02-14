Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C82222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g/ponYXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbfBNKTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:19:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBNKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c0kFHfZ84l6hN8EV9uyA/B2ofXSPwbG72w/+ZdCqcD0=; b=g/ponYXHA78ychLKY1mGZ/yXH
        nNrAmpYw5l8MP5O5jovQqausTg7/zPIrpVjKj0NgBA2PNNWAkq3ZcMTmBy+aJryDnCyg45pKk3yGb
        qO1cThnn8FBmxVhVMCU8/dR0Hb07aD2kbVfLwNj+t488P6To9vGFLC3fKlwS5eLKHp+aCYrE5yiGm
        9LaYfuRoFNu+CigGjCLNhqxxw2mPtWHX+agTqdObvVMQ8CRVBep/NYwKWigf2P+UK/PrLXLTXNXjJ
        h4LVW1lRheTqm/hwCHdmek6WPki+pwbP3O8oHcHyQP+V5/EQMU8pvqn64ksYtPihUrDrGYMTRU1nS
        RFNGYv3VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guE6n-0000h5-Qp; Thu, 14 Feb 2019 10:19:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DCEF20298375; Thu, 14 Feb 2019 11:19:07 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:19:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Zijiang <huang.zijiang@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn
Subject: Re: [PATCH] sched/core: Remove BUG_ON()
Message-ID: <20190214101907.GE32494@hirez.programming.kicks-ass.net>
References: <1550126557-28530-1-git-send-email-huang.zijiang@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550126557-28530-1-git-send-email-huang.zijiang@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 02:42:37PM +0800, Huang Zijiang wrote:
> pick_next_task is never return NULL because idle task
> will return when cpu is idle.

And to be sure it does; we have that BUG_ON :-)
