Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA07C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0743920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lvKIMKbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0743920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeIGQFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:05:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeIGQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HhTmHIhTmSOpd5/DampYt1tmeMC+FmuaaqFJG+d+ntw=; b=lvKIMKbJ94yuCXyFeezcIp//S
        4hV99XHd3QKulQPJA26sZV5ubAv583/2lj9aGqZlYI2QzlFTy1oRBSzLmOtYb9a6DL2KW3hFsx6Ka
        L2kbkjXpEvQ8CncVXl64+PmCZ6eNctRpTLE5s1Lgb2VdiZ5x8qYw7MCygov773NfmhLreDe+CunZk
        gJGreP0n+le01hzTu/weyVh+BlJ7/qia3K2ib71+6Htcx1cJ8LuHncw0SnSEpDM9HZXqxoJf2/GUS
        SsLG9tb7RpfJs4k0bS2spDWmPu2Xlrz8p+9s0+xSSogQhfJrwVKgt2cs3enn4gFt52Z6ftIG1Xi6h
        WwQ13UoAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyEsi-0001GJ-Ts; Fri, 07 Sep 2018 11:24:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30A552021030F; Fri,  7 Sep 2018 13:24:55 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:24:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/4] Follow-up fixes for v4.19-rc1 NUMA balancing
Message-ID: <20180907112455.GT24106@hirez.programming.kicks-ass.net>
References: <20180907101139.20760-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907101139.20760-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:11:35AM +0100, Mel Gorman wrote:
> Srikar had an automatic NUMA balancing series merged during the 4.19 window
> and there some issues I missed during review that this series addresses.
> 
> Patches 1-2 are simply removing redundant code and calculations that are
> never used.

I already have those queued, from Vincent:

  https://lkml.kernel.org/r/1535548752-4434-1-git-send-email-vincent.guittot@linaro.org
