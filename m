Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8988C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94924208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i2nR6vZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94924208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeFUIIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:08:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754065AbeFUIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pNhFKH+TuNqX4CcVxd82uyrWBzH60rko2lqR3Vcgqi0=; b=i2nR6vZpKOvA2zg0eIF0yDuJR
        epgR3CGH5hX55yZqlM2yB11q+NdhyLESnJ9K60Xgv6pMWA7JypRu3nAXlAJpBZcRysvOcpPKY5fRU
        Py1kan9WLXzQAJZipJBgqSUKq86ocrja5tPGAIdHq3hFp6zml/J/QIV14k3dwUVQa2XYdg+Tb1JLe
        VbgJvK2T4aW55LTY4kx+mXU7UzSLd8H4lRII+yjQ1ZjSzdoZTeZaHeeAi2qSCcdt5s0aqyC+CEu/B
        cle/fYlx5V3M6YAOeORDgPXZsah1Vebq4rTf0W3YT0FEYaEbKeCIimam0r50yAeocpmPObE84yacJ
        abxN0VV1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVudc-0006PQ-RZ; Thu, 21 Jun 2018 08:08:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B32E2029F1D5; Thu, 21 Jun 2018 10:08:14 +0200 (CEST)
Date:   Thu, 21 Jun 2018 10:08:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     bsegall@google.com, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched/fair: Fix bandwidth timer clock drift
 condition
Message-ID: <20180621080814.GQ2494@hirez.programming.kicks-ass.net>
References: <20180620101834.24455-1-xlpang@linux.alibaba.com>
 <xm26fu1hpf2b.fsf@bsegall-linux.svl.corp.google.com>
 <60638b2b-5044-3653-287b-738f254dbf92@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60638b2b-5044-3653-287b-738f254dbf92@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:56:56AM +0800, Xunlei Pang wrote:
> >> Fixes: 51f2176d74ac ("sched/fair: Fix unlocked reads of some cfs_b->quota/period")
> >> Cc: Ben Segall <bsegall@google.com>
> > 
> > Reviewed-By: Ben Segall <bsegall@google.com>
> 
> Thanks Ben :-)
> 
> Hi Peter, could you please have a look at them?

I grabbed them, thanks guys!

> 
> Cc stable@vger.kernel.org

For both or just the first?
