Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E4C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3947C2151B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIWDcb+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3947C2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbeLGMXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:23:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeLGMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/4050RJZ3ZRCIBeMH6TNAVzCe1ETGUltagtuANsuxjg=; b=iIWDcb+ROB5eHVosX23lMimXx
        b3xedtW/eXHl1ZIOMSr9Oy9cC/dAC6BMR5dlAyHgwGx2QwEmnq3ENXhQEhpw6o9BOMnMdsemkesnc
        jtWtI5tOC5vBUvtjeIdJD1TTM0a5l+zsX5G3NZKKS+UlcO39N6IdEP0p6G0ah0ljCad8GJvtzV1Gx
        +GhvECcxJha5vsTLjTUbDK+gdFkJw/dm9fzVZCaUZDcA7pYIktMq61QVg9gYuBrDsytPF+4wgDLSC
        0OxVfymEE9XcmFn83XUDY6udXQVdxhcwnLNGHt08eymyRpop0oewh5LZrso3iPPGnjPZWVEVozQPg
        763pWYoWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVFAI-0000xQ-Md; Fri, 07 Dec 2018 12:23:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C3002075BE77; Fri,  7 Dec 2018 13:23:29 +0100 (CET)
Date:   Fri, 7 Dec 2018 13:23:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] locking/lockdep: Add support for dynamic keys
Message-ID: <20181207122329.GA5289@hirez.programming.kicks-ass.net>
References: <20181207011148.251812-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207011148.251812-1-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

I took the first 15 patches for now to shrink the series.

I think the rest wants a little more work.
