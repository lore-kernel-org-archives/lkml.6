Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E209C216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V1R9PqrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E209C216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeI0WGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:06:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0WGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1zBh5mEOQ9Sv2VGO+pxtSOFZXimR6h4G5AnCYfbyTgg=; b=V1R9PqrGZHF3G+AZeUiNZ/5fy
        LkIz9JANZv7ShalJTnJQPx2AUnlMRFLqzmlHZQMYSfeCGD9hrlI9QVzKC3xWOiIz2LkW9AkHEHqdB
        /2rjlKSqJIj4/NR79zLXkuSpXdbJh3YIqpZ81iV9sgAiuX3lesRaVsLNeutXWldUm+6Yc+8ER4/ZK
        LipmNflAnXXHSW5r535MMV1fQyBtvhcaPgBpKYhTabdeLM3cJWRB0ttKpY2jWX/wAzh2rh4Avxk4J
        eCw3PMA0MvUUAl/MnYqEL8X2MdSoUKqoiZ5bONAW+UIh5CBFEOAEqpRq9LZ3cL0DmZ+bbwuJKQYop
        jsQvvLrMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5YVp-0006Hv-Hm; Thu, 27 Sep 2018 15:47:33 +0000
Date:   Thu, 27 Sep 2018 08:47:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 07/33] csky: MMU and page table management
Message-ID: <20180927154733.GA15985@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <ed7dcac1e0f3a858fa75735fa881818bc4ab1468.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7dcac1e0f3a858fa75735fa881818bc4ab1468.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void *csky_dma_alloc_atomic(
> +	struct device *dev,
> +	size_t size,
> +	dma_addr_t *dma_handle
> +	)

Can you please use normal kernel coding style?  Closing brace on the
same line, either two tab indents for the arguments or align them to the
first argument:

static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
		dma_addr_t *dma_handle)

or:

static void *csky_dma_alloc_atomic(struct device *dev, size_t size,
				   dma_addr_t *dma_handle)

> +	if (DMA_ATTR_NON_CONSISTENT & attrs)
> +		BUG();

Please don't bug on unknown attributs, they can be safely ignored.

> +void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
> +			      size_t size, enum dma_data_direction dir)
> +{
> +	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +	unsigned long offset = paddr & ~PAGE_MASK;
> +	unsigned long vaddr;
> +
> +	if (PageHighMem(page))
> +		vaddr = (unsigned long) kmap_atomic(page);

This isn't going to work as the size might be larger than PAGE_SIZE.
