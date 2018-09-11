Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7F1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6022086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tx94rUYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6022086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeIKQ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:29:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e9xfoOLqOnvcTwZlQZ3I1s2DTmiBZGXlszgdC6AFc44=; b=tx94rUYuYLOdPbZubP7MKSkPG
        xKlzy4U+2yYRo6QcbfLkvdgxCjQB4vfmxoOPaeie83zOsvnMCrmFpoHr8H0KeD+4d2V2CiALnKNIV
        y/QLwtQyIY3ZuXc7YUnNTb9t3L/bs63+bo9H2PNq8XU8bf0mfEs4YMx+Ui9hOVS/Pq0XF2Ut73CMp
        D5VJd2c4IGxDO5SUBDc1Hdj/G0mLkYzVVEnSsDjacuQ/xlRenPoCfGoXzSUvCZlKLsP9KYkNhKH2Z
        q5aBZB6kRsvRInzspkqSA8+P1YAqngMOXiw9wyJ7ycDwHJGfgPbKCWdjsH4CLr2H0+AR5do9XPmjg
        raSs5Pm0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzgsM-0003lM-9M; Tue, 11 Sep 2018 11:30:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9F132057F82E; Tue, 11 Sep 2018 13:30:31 +0200 (CEST)
Date:   Tue, 11 Sep 2018 13:30:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Remove setting task's se->runnable_weight
 during PELT update
Message-ID: <20180911113031.GP24106@hirez.programming.kicks-ass.net>
References: <20180803140538.1178-1-dietmar.eggemann@arm.com>
 <bf1ed7b3-e67f-fbf0-a32f-ad5d7dfa5731@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1ed7b3-e67f-fbf0-a32f-ad5d7dfa5731@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:49:05PM -0700, Dietmar Eggemann wrote:
> 
> Is there anything else I should do for this patch ?

This. Got it now, thanks!
