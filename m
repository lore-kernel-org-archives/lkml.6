Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94406C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461102085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGzKgCYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461102085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbeKFGgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:36:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wga7tJT24r08yP8QvZtP8mE7GPuKoMcZJvCYZjiA738=; b=HGzKgCYl9MNG3DHHoSm/Xkh6+
        FfThE+8HyBxKlM1xrQEluBPyToqkKpC0UFYNdDX2xBrhqiwDjCl/u2psLlREN+WTpaiOk/NnJtv0H
        i057iEL3tEbtRA1ep3a6g8y3vdwVgjxEsPSeNk5rhNLFnm7tp6sZ8u6WsygptspoVPtegwQufxFPT
        PZhhf4KxiwIygOQzE+TFJlANJnHnx653vmtozvRFSjvkRsEh4YMXH+I8MfZaZ+yUO2Qh/j00iSWuQ
        4ZvVZWzNrTeFBg6ryeH0hBxBH5g6u6OXGWQFouUWlcvKGVRLawo1pLH2Mq2YlYr4xSZJiLsUbHqd7
        pGwdNlMnw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJmD1-0002mf-Py; Mon, 05 Nov 2018 21:14:56 +0000
Date:   Mon, 5 Nov 2018 13:14:55 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Oded Gabbay <oded.gabbay@amd.com>
Subject: Re: [PATCH] mm/mmu_notifier: rename mmu_notifier_synchronize() to
 <...>_barrier()
Message-ID: <20181105211455.GB3074@bombadil.infradead.org>
References: <20181105192955.26305-1-sean.j.christopherson@intel.com>
 <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121833.200d5b53300a7ef4df7d349d@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:18:33PM -0800, Andrew Morton wrote:
> > +++ b/mm/mmu_notifier.c
> 
> But as it has no callers, why retain it?

... and this patch missed the declaration of mmu_notifier_synchronize
in include/linux/mmu_notifier.h (whether we delete it or rename it,
that mention of it needs to be fixed)
