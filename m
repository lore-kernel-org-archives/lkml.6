Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B368E2147E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B368E2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933672AbeGCQPs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:15:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932440AbeGCQPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:15:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2C5B7A9;
        Tue,  3 Jul 2018 09:15:45 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DDEC3F5BA;
        Tue,  3 Jul 2018 09:15:41 -0700 (PDT)
Subject: Re: [PATCH 6/7 v5] bus: fsl-mc: set coherent dma mask for devices on
 fsl-mc bus
To:     Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com
Cc:     hch@lst.de, joro@8bytes.org, m.szyprowski@samsung.com,
        shawnguo@kernel.org, frowand.list@gmail.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <1526824191-7000-7-git-send-email-nipun.gupta@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <79ac0aab-9620-b6ed-f3ee-0553a733a044@arm.com>
Date:   Tue, 3 Jul 2018 17:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526824191-7000-7-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/18 14:49, Nipun Gupta wrote:
> of_dma_configure() API expects coherent_dma_mask to be correctly
> set in the devices. This patch does the needful.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index fa43c7d..624828b 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -627,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>   		mc_dev->icid = parent_mc_dev->icid;
>   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
>   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
>   		dev_set_msi_domain(&mc_dev->dev,
>   				   dev_get_msi_domain(&parent_mc_dev->dev));
>   	}
> 
