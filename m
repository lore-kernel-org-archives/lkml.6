Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE04C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B8D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 10:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6rS/eVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfASKZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 05:25:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57540 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfASKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 05:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3pEYCOCAcVVVJKPSNVrag6u68LCNmc4u9dVSsWTGz4Y=; b=E6rS/eVK8Xk0tAbAXs8I8YZnQ
        N0m9UuZ0C/5vRbdXcrdAAlcF29uGsOjgpT2m7wtOsJ9yJcvpxcfAaaCN9A8jm699fTjeB419Xi3nx
        X7dotqTAQewzN6bzYnkSpdTXpRnTju47kbb/HWTwn2EbNOYqhssP4Zo+mqs3zsJJTuSI7hmRIyQOv
        AA+tRY25qzJQM/wPZs9TvfKFpw6ySpMDbSauExn19yDb05lnN9fencuji08R7FlWer6BR9gdcH41q
        kZ7e8IQpeh5Om4Zg3WGui0nX31l7jTCHLuGMXtcReXXE8e86AKYikshycZe6r0Pp96fNZ0AFEsQJj
        7vlaXoOSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gknod-0005ut-5x; Sat, 19 Jan 2019 10:25:27 +0000
Date:   Sat, 19 Jan 2019 02:25:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Liam Mark <lmark@codeaurora.org>
Cc:     labbott@redhat.com, sumit.semwal@linaro.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, afd@ti.com, john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
Message-ID: <20190119102527.GA17723@infradead.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 10:37:46AM -0800, Liam Mark wrote:
> Add support for configuring dma mapping attributes when mapping
> and unmapping memory through dma_buf_map_attachment and
> dma_buf_unmap_attachment.
> 
> Signed-off-by: Liam Mark <lmark@codeaurora.org>

And who is going to decide which ones to pass?  And who documents
which ones are safe?

I'd much rather have explicit, well documented dma-buf flags that
might get translated to the DMA API flags, which are not error checked,
not very well documented and way to easy to get wrong.
