Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877C8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B1C20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 23:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1gGAmQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B1C20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbeHAAuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbeHAAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:50:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D88A220857;
        Tue, 31 Jul 2018 23:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533078462;
        bh=Tj0TTvsQu9cMxyiuTNiJ9tswUX7YWNLEs3Chc+rDRxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a1gGAmQRRLaibCQw1jxuJABok7OgCjZwgYtt5FL7ccF7+touSsALfIN0RjZhkhHhf
         7z1tPUY7rstgWOg9t3tJuzeL3P0BKmIiDTgYrA+RJFYuH9Uuwp4jZxZC2NY3miENjn
         sBRxhPOfg5thPBj5GsvGsmCXFUfMQzkt9MN9pwWc=
Date:   Tue, 31 Jul 2018 18:07:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     bhelgaas@google.com, hch@infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2] PCI: Unify pci and normal dma direction definition
Message-ID: <20180731230740.GP45322@bhelgaas-glaptop.roam.corp.google.com>
References: <1531878035-33147-1-git-send-email-shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531878035-33147-1-git-send-email-shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:40:35AM +0800, Shunyong Yang wrote:
> Current DMA direction definitions in pci-dma-compat.h and dma-direction.h
> are mirrored in value. Unifying them to enhance readability and avoid
> possible inconsistency.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>

Applied to pci/misc for v4.19, thanks!

> ---
> 
> v2:
>   Remove unnecessary comments and  braces according to Christoph's
>   comments.
> 
> ---
>  include/linux/dma-direction.h  | 6 ++----
>  include/linux/pci-dma-compat.h | 8 ++++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/dma-direction.h b/include/linux/dma-direction.h
> index 3649a031893a..9c96e30e6a0b 100644
> --- a/include/linux/dma-direction.h
> +++ b/include/linux/dma-direction.h
> @@ -1,14 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_DMA_DIRECTION_H
>  #define _LINUX_DMA_DIRECTION_H
> -/*
> - * These definitions mirror those in pci.h, so they can be used
> - * interchangeably with their PCI_ counterparts.
> - */
> +
>  enum dma_data_direction {
>  	DMA_BIDIRECTIONAL = 0,
>  	DMA_TO_DEVICE = 1,
>  	DMA_FROM_DEVICE = 2,
>  	DMA_NONE = 3,
>  };
> +
>  #endif
> diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> index 0dd1a3f7b309..c3f1b44ade29 100644
> --- a/include/linux/pci-dma-compat.h
> +++ b/include/linux/pci-dma-compat.h
> @@ -8,10 +8,10 @@
>  #include <linux/dma-mapping.h>
>  
>  /* This defines the direction arg to the DMA mapping routines. */
> -#define PCI_DMA_BIDIRECTIONAL	0
> -#define PCI_DMA_TODEVICE	1
> -#define PCI_DMA_FROMDEVICE	2
> -#define PCI_DMA_NONE		3
> +#define PCI_DMA_BIDIRECTIONAL	DMA_BIDIRECTIONAL
> +#define PCI_DMA_TODEVICE	DMA_TO_DEVICE
> +#define PCI_DMA_FROMDEVICE	DMA_FROM_DEVICE
> +#define PCI_DMA_NONE		DMA_NONE
>  
>  static inline void *
>  pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
> -- 
> 1.8.3.1
> 
