Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AA5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425C320C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTdudoF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425C320C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbeGQOg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:36:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeGQOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TIDdoTGPaUVmncM7hvaLO8ZVbsetoanGfGEf7vhFbKs=; b=kTdudoF+/7Z7/lWWHM21jhOW2
        GJmWJ7TiKlP0AuNF/n7aq6l0TecaoXew2V71GLHc3wolp4yom9wcSpXialvOnvodk4CbtLaq7+nwY
        qG5ckDAGDSSAbsf2aJ0lUvoZVDL3AU1/jt1T/eYnJvMZIcEy6/ytBdqefYpkG0S1PFMIXPpMl02To
        tkIRuV97KR3aXR6m8NtQC/HmbSbeBMTKHlBsb8WWj21fNdv/uV2D08f7jqDcIz87EonH3kHdyWbe1
        LRkSq3ZhQlxta9KhNKRwt8fmyJO8MS2V9kyl0ATT1Sb8kM9KH1T8+CjyuJLeOtudviw0884fnQdt2
        VGG3z1wTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffQZj-0006am-Ka; Tue, 17 Jul 2018 14:03:35 +0000
Date:   Tue, 17 Jul 2018 07:03:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] PCI: Unify pci and normal dma direction definition
Message-ID: <20180717140335.GA23500@infradead.org>
References: <1531463840-34651-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531463840-34651-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
> index 3649a031893a..9d52716e9218 100644
> --- a/include/linux/dma-direction.h
> +++ b/include/linux/dma-direction.h
> @@ -2,7 +2,7 @@
>  #ifndef _LINUX_DMA_DIRECTION_H
>  #define _LINUX_DMA_DIRECTION_H
>  /*
> - * These definitions mirror those in pci.h, so they can be used
> + * These definitions mirror those in pci-dma-compat.h, so they can be used
>   * interchangeably with their PCI_ counterparts.
>   */

I think we can just drop this comment anymore.

> +#define PCI_DMA_BIDIRECTIONAL	(DMA_BIDIRECTIONAL)
> +#define PCI_DMA_TODEVICE	(DMA_TO_DEVICE)
> +#define PCI_DMA_FROMDEVICE	(DMA_FROM_DEVICE)
> +#define PCI_DMA_NONE		(DMA_NONE)

No need for the braces.
