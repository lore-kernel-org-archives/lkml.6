Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9CEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA48D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SOjXwZ/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA48D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388531AbeGXTRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:17:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388403AbeGXTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3/qR2/s/jkp/x+UEP9487SNsdXRODOQeXau8SvMn+SU=; b=SOjXwZ/j845v1dC4awFyxKiX2
        35EzP/JrgdQjSFEwQOWeKCPSSAFB8tNSgD42R/X2niFymtdNDD3kHi6Cg7dWTVnfCeWItyTpgwnD8
        BmC4RlvKx5RDARB3Dx6YfjEN4FKYRxW3tKaKLBYsv76qZY1BQAIru4Nz58yAJXX2OcnHe5r7KiyJf
        NZ5qE9L6txirSmVVQWQ1GpCHH1aX0DGGb3lIX3vPMT8+lH57geU+raVqQ9NK3/OGG9/9ETGjIu4yQ
        YdxexskzWwo4n4/2qC09dJ1vRDbs5CwcBNtMTYrMS76QN3MT2SghLVrhm1ES9tla1C3QOBKPcia/m
        CdTUz4k5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi1kA-0002Gr-KN; Tue, 24 Jul 2018 18:09:06 +0000
Date:   Tue, 24 Jul 2018 11:09:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux@armlinux.org.uk, matthias.bgg@gmail.com,
        vladimir.murzin@arm.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, robin.murphy@arm.com, treding@nvidia.com,
        zhongjiang@huawei.com
Subject: Re: [PATCH] ARM: dma-mapping: always clear allocated buffers
Message-ID: <20180724180906.GA8240@infradead.org>
References: <20180724140435.17112-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724140435.17112-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:04:35PM +0800, YueHaibing wrote:
> Sean Wang report dma_zalloc_coherent doesn't work as expect on his
> armv7,the allocated mem is not zeroed.The reason is __alloc_from_pool
> doesn't honor __GFP_ZERO.

Please explain the "why" a little more.  All the explanations are in
the referenced arm64 commit and should be mentioned here as well.
