Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73702C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B020883
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptEsMzx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4B020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeGIKeu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754433AbeGIKes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:34:48 -0400
Received: from localhost (unknown [106.201.46.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45E820877;
        Mon,  9 Jul 2018 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531132487;
        bh=NvsJbOfi0OGUIrRA8lk/gQr9i48ZCbiKw8ONuo9D80w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptEsMzx+D9/++JydTu2FdHh+X+XFmL5YC7GuJQeaAfSkdHu5CY4/JoeqDL6VBTZAq
         ScBuOIARKdLmkymuOXxTApCgcNyfyPUmOiBmYnomrTOMlYnQZ0VkfTBRAb0zQy9l8w
         QvhVbQ4wPqbwoK9nguUbKvDZcd3KI3KGL8KE1ous=
Date:   Mon, 9 Jul 2018 16:04:38 +0530
From:   Vinod <vkoul@kernel.org>
To:     Guodong Xu <guodong.xu@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dan.j.williams@intel.com,
        xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com,
        liyu65@hisilicon.com, suzhuangluan@hisilicon.com,
        xuhongtao8@hisilicon.com, zhongkaihua@huawei.com,
        xuezhiliang@hisilicon.com, xupeng7@huawei.com,
        sunliang10@huawei.com, fengbaopeng@hisilicon.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: k3dma: add optional property
 hisilicon,dma-min-chan
Message-ID: <20180709103438.GC22377@vkoul-mobl>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
 <20180706035521.13736-2-guodong.xu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706035521.13736-2-guodong.xu@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-18, 11:55, Guodong Xu wrote:
> From: Li Yu <liyu65@hisilicon.com>
> 
> Add optional property hisilicon,dma-min-chan for k3dma.
> 
> Signed-off-by: Li Yu <liyu65@hisilicon.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 4945aeac4dc4..f34202a80f3c 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -12,6 +12,11 @@ Required properties:
>  		have specific request line
>  - clocks: clock required
>  
> +Optional properties:
> +- hisilicon,dma-min-chan: the minimum DMA channel number which is usable
> +		Default value is 0, but in some platform it is
> +		configured 1, like in hi3660 platform
> +
>  Example:
>  
>  Controller:
> @@ -21,6 +26,7 @@ Controller:
>  			#dma-cells = <1>;
>  			dma-channels = <16>;
>  			dma-requests = <27>;
> +			hisilicon,dma-min-chan = <1>;

Am still expecting this to be a mask

-- 
~Vinod
