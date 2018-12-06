Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F05C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268D720868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4KdAw0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268D720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeLFOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:10:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbeLFOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RYZXvbcvp5zvrTNSmLWilsUYWsV8BnhXPCPfnY8Lj5U=; b=i4KdAw0YssQo4vAyg0bDPKD0q
        NNVjoVwnGwZcMnLQUHOlkdHaYHQtmHEfDF9HuqSbgBmTF/OsayU7PY8I8WYVfCZm2SpkrAMl5H37g
        4ia9+LLNIvYIUfafdrOf1l9Ox56YFveDa9Dsk9H/Sgt35K6SAbYXIEnqWdCNxxZNnMzQM7t7Z0/2Q
        Lga37Wy/kc7oQHlFc1DbyyYyDOkckVVk7XmuFgfyyAUGGEqn0ZyfOdkI9ZoP1fWN7vMFe9ebuqcu6
        q5FrRMweNSRfiYRyUNTddQuTGbJYiD4qPCoqzop+/2pv664Ex2RbzkU/paMHvKksN2HW4LPQO3qS4
        ql1VpEy2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUuLj-0008Is-OR; Thu, 06 Dec 2018 14:09:55 +0000
Date:   Thu, 6 Dec 2018 06:09:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/34] powerpc/dma: remove the unused
 ARCH_HAS_DMA_MMAP_COHERENT define
Message-ID: <20181206140955.GC29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-4-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Wed, Nov 14, 2018 at 09:22:43AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/dma-mapping.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
> index 8fa394520af6..f2a4a7142b1e 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -112,7 +112,5 @@ extern int dma_set_mask(struct device *dev, u64 dma_mask);
>  
>  extern u64 __dma_get_required_mask(struct device *dev);
>  
> -#define ARCH_HAS_DMA_MMAP_COHERENT
> -
>  #endif /* __KERNEL__ */
>  #endif	/* _ASM_DMA_MAPPING_H */
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
