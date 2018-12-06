Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C868FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9115320868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IqDdwk/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9115320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeLFOKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:10:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeLFOKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:10:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S6wxYcwn8nzErOpmwysGXYkGriMB1H+xyWffEsZVZKI=; b=IqDdwk/Bg18rfBZuhCeNiywg5
        zbic5xO0OAFQKt5/QqnySDZWIyVWDVkYsfjCUW5qv/4bKhjG9LO+TmBEiw8/9H6GpU1v/NxTqFkDb
        /g/oVNRBukhvHo2owUbpILS6ANxnCT30g4rBl5pF3PsxfTkoD/XEIAQzp1lrWzsWCcRWwOmf3PL+3
        FgK2POm+CvD1l5kiqFGS2N/74zPzH9Ml37FXdcEpvCSnTkzisIAIW85rNwxrmutGsyApQCmtBt7aY
        bysXIqMtU25pzPqKLL8j0ggKC60tsZAHKrW3RowAuvu72ChSIrbnv82YLYMusCin0n7JpSUZHm6S/
        Bg53+rNOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUuLo-0008JA-AO; Thu, 06 Dec 2018 14:10:00 +0000
Date:   Thu, 6 Dec 2018 06:10:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/34] powerpc/dma: remove the unused ISA_DMA_THRESHOLD
 export
Message-ID: <20181206141000.GD29741@infradead.org>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-5-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Wed, Nov 14, 2018 at 09:22:44AM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/setup_32.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 81909600013a..07f7e6aaf104 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -59,7 +59,6 @@ unsigned long ISA_DMA_THRESHOLD;
>  unsigned int DMA_MODE_READ;
>  unsigned int DMA_MODE_WRITE;
>  
> -EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
>  EXPORT_SYMBOL(DMA_MODE_READ);
>  EXPORT_SYMBOL(DMA_MODE_WRITE);
>  
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
