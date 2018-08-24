Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0795AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60942150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O8y71oUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60942150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeHXS2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:28:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbeHXS2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iGSWkShzxKmp4y9EgSFQrKQYvPJbUEcE97ALgc+NgjM=; b=O8y71oUb7QyMBvM2vzR4DqMYA
        Oy/Q9vYUuCKsuwVBvOdNnUVyRaXyuPeJavaXEpHqYF4elJE2alsJj2fUj1PfAuzgddE92ql2OxnD6
        1cGiQOmS4oupnnvnP4E88yST3xINhzYy+kD2QylcW/ydWDo2HVO1mszNfK5Kqvzs01hOp4TNbw0m7
        OL2dScKmm1Nn4uFaD4qkDm4XfwX2QE6CzIx3UxHg/ML6z/aiMlFkC57Kvmb46eqNJ50F5UVi4E9d7
        CJDqUJZcb6mnQbgCqpwD692Vx2topt5epMd58/PcV1uTSFPrRsQ6utlG65LPTLJT8UXfgArrW6QSd
        FUojVSGfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftDSr-0003t7-3n; Fri, 24 Aug 2018 14:53:29 +0000
Date:   Fri, 24 Aug 2018 07:53:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     murphyt7@tcd.ie
Cc:     leo.duran@amd.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
 context which is necessary for any custom drivers using the IOMMU API while
 holding a spinlock.
Message-ID: <20180824145328.GA7996@infradead.org>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:28:49PM +0000, murphyt7@tcd.ie wrote:
> From: Tom Murphy <murphyt7@tcd.ie>
> 
> ---
> 
> This patch allows the IOMMU API path in the AMD driver to be called from an atomic context.
> This is useful for anyone building a driver which needs to call the IOMMU API while holding a spinlock.

I don't think that is a good idea.  Please point to the code in the
driver and we can't probably find a better solution.
