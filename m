Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03C0C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2E12145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ByaQCTst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2E12145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeLACTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:19:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeLACTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5dr3kw+IGlBArSe9n7STxt9hVA4gDY0GdtJ7tYHfCKg=; b=ByaQCTstj4RmpUXHKx6j8s8DG
        u4GN3k7pRyxWCLLRhL9VDzMh3LSR3Z93Vxkgf5eyLZ+HZTEFhZjLu1lwdON64wNvPa+WPseA4I3/N
        tstP9S1ltXD9larr91/6uLN9MaFYzpP4jScUHApL1Yqrw84jRbMopQ+b3BuK1cDaR0DSX5T2hwyA/
        a/7iB6LUAdVMCEYBGh1ALMxwsHlsSJ8T4KQHpNpVzT6uqrUGL1ICvrqk692oOlxjGFK8Mclou1qdh
        mxSmZupg/dHyA+5iA0DagqHLE5DVc5TcnhHbkLywFVnp3xfjft7UOecj6UqhBAwlTQppWK0Robr7e
        o+LBvFk5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSkQb-0001vI-TY; Fri, 30 Nov 2018 15:10:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4AF72029FD58; Fri, 30 Nov 2018 16:09:59 +0100 (CET)
Date:   Fri, 30 Nov 2018 16:09:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "StDenis, Tom" <Tom.StDenis@amd.com>
Cc:     "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/4] x86/mm/cpa: Fix cpa-array TLB invalidation
Message-ID: <20181130150959.GA11614@hirez.programming.kicks-ass.net>
References: <20181130134455.490139778@infradead.org>
 <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e4cb48-1952-fb61-bd2b-db9efe3b5f1a@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:52:26PM +0000, StDenis, Tom wrote:
> Hi Peter,
> 
> Unfortunately I can't apply this on top of our drm-next the first patch 
> fails.

Against what tree would you like the patches? rebasing should not be
hard I think.
