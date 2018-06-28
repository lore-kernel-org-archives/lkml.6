Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79911C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C4126F95
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOa+Nbua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C4126F95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753422AbeF1GAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbeF1GAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:00:43 -0400
Received: from localhost (unknown [106.201.104.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D354726F92;
        Thu, 28 Jun 2018 06:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530165642;
        bh=D+qj1EbeBpBPVIKgKh+i3GcDwtNeMstXoRWCjoZ17t0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOa+Nbua2d8TAYl18o9dDhQXVi20AdwxWAhQT4WmM8Q4Oq9wEZ5985wh3T+fAKUGy
         aYutG+aR6uS4j3kmGIbBbnUMHDZbyJRxpVfNidymlvGGeGQxKm73cRVwS+NVLwJRUC
         E+h4mIbVYcLSjYDfHFbm7TWArRHpsabgESGTcF64=
Date:   Thu, 28 Jun 2018 11:30:34 +0530
From:   Vinod <vkoul@kernel.org>
To:     Guodong Xu <guodong.xu@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dan.j.williams@intel.com,
        liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: k3dma: add optional property
 dma_min_chan
Message-ID: <20180628060034.GN22377@vkoul-mobl>
References: <20180622032416.20133-1-guodong.xu@linaro.org>
 <20180622032416.20133-2-guodong.xu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622032416.20133-2-guodong.xu@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-18, 11:24, Guodong Xu wrote:
> From: Li Yu <liyu65@hisilicon.com>
> 
> Add optional property dma_min_chan for k3dma.
> 
> Signed-off-by: Li Yu <liyu65@hisilicon.com>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 4945aeac4dc4..2fa1370c3173 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -12,6 +12,11 @@ Required properties:
>  		have specific request line
>  - clocks: clock required
>  
> +Optional properties:
> +- dma_min_chan: the minimum number of DMA channel which begin to use
> +		the default value is 0, but in some platform is

Sorry I don't understand this property, we already have dma-channels
which describes the channels in a controller. What is purpose of this ?

> +		configured 1, like hi3660 platform
> +
>  Example:
>  
>  Controller:
> @@ -21,6 +26,7 @@ Controller:
>  			#dma-cells = <1>;
>  			dma-channels = <16>;
>  			dma-requests = <27>;
> +			dma_min_chan = <1>;
>  			interrupts = <0 12 4>;
>  			clocks = <&pclk>;
>  		};
> -- 
> 2.17.1

-- 
~Vinod
