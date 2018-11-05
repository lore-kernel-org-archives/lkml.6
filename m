Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F81EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031BC2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031BC2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeKFBH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:07:57 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48878 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729657AbeKFBH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:07:56 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1795514|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.DDtM7lv_1541432842;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.DDtM7lv_1541432842)
          by smtp.aliyun-inc.com(10.147.41.187);
          Mon, 05 Nov 2018 23:47:23 +0800
Date:   Mon, 5 Nov 2018 23:47:22 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] csky: don't select DMA_NONCOHERENT_OPS
Message-ID: <20181105154721.GA25126@guoren-Inspiron-7460>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-8-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 01:19:29PM +0100, Christoph Hellwig wrote:
> This option is gone past Linux 4.19.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/csky/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 8a30e006a845..c0cf8e948821 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -8,7 +8,6 @@ config CSKY
>  	select CLKSRC_MMIO
>  	select CLKSRC_OF
>  	select DMA_DIRECT_OPS
> -	select DMA_NONCOHERENT_OPS
>  	select DMA_REMAP
>  	select IRQ_DOMAIN
>  	select HANDLE_DOMAIN_IRQ
> -- 
> 2.19.1

Acked-by: Guo Ren <ren_guo@c-sky.com>
