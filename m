Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797EC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C83208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 23:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546557713;
	bh=jMX6hBn7lyEgk/xOHL3IQCbLi4Xk9tjufATanvk5uGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J03Do+LmcxAOA/sOEtrxGU9fEpEGPzjm2V674WKlzYqUfcCCY4nN1nlO+SzqT28RW
	 CNKeQRzlX/tAIYkyaEW9D9FwHc/uwpwpBvybzs9EkholYUsM3WxCKK8A88s/mkDxp+
	 bZPIaR2jICzzgGbb+c2M/txVAEj2lqUl5YrBevhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfACXVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 18:21:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42232 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfACXVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 18:21:52 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so28279775ioa.9;
        Thu, 03 Jan 2019 15:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t0GSUHJkdf7A98ACvSRb5N0KlJsjQDdljT+v5mzWcng=;
        b=k4dVlIbcak0MK/JIOBSNQsuguvUKmMpUMU3aYW2iYIAvWUUK3iitskXyuOfUWfAfR2
         vzpY2+p4ch7QIDqtvteoWPvoA424rmhJQlkroTRsCUqyI+X/pruSXufGTWH2AxUA6Rw8
         cB+lzQT8BKODdYK4yNVd1ycNm8lxgsTNfUK6LRO7FYfu4Gjondg5QhM0KcAn8Pa/EvWy
         xLNL4GbUlRWwaaL/etIAdxqwUT183aZb9viMYp0ZwU4Z2jroF1zle9xyF3GlozkSSlnq
         dlm1bFiJOWJdNJ77lo7g+UluRlbnNT9OwiGD89UPJ6waNn862HpjYn7H4tsaiIz5dGsh
         +biw==
X-Gm-Message-State: AJcUukdbzi+/izqn38257Law2ue86+621OHQxtZ8m/bHTD2NHfR8yRwx
        +Zi9aKNnmk4QbSzlnUKDag==
X-Google-Smtp-Source: ALg8bN7nGzB2+t8W/4kEM9c+6HojlLRCiPxYeSafGIb7MY6yUqAZBvlpojBV+l7ABQlR/Ae+nmWsGA==
X-Received: by 2002:a6b:5a14:: with SMTP id o20mr32580034iob.206.1546557710707;
        Thu, 03 Jan 2019 15:21:50 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id e141sm24917821itc.40.2019.01.03.15.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 15:21:50 -0800 (PST)
Date:   Thu, 3 Jan 2019 17:21:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     h00249924 <hutenghui@huawei.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liyuequan@hisilicon.com, cash.qianli@hisilicon.com,
        huangli295@hisilicon.com, hantanglei@huawei.com,
        wangyoulin1@hisilicon.com, ninggaoyu@hisilicon.com,
        hanxiaolong3@hisilicon.com,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] dmaengine: Extend the k3dma driver binding
Message-ID: <20190103232144.GA17431@bogus>
References: <1545978983-124360-1-git-send-email-hutenghui@huawei.com>
 <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545978983-124360-2-git-send-email-hutenghui@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 02:36:22PM +0800, h00249924 wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> Extend the k3dma driver binding to support hisi-asp hardware variants.
> 
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 33 ++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/k3dma.txt b/Documentation/devicetree/bindings/dma/k3dma.txt
> index 4945aea..cd21b82 100644
> --- a/Documentation/devicetree/bindings/dma/k3dma.txt
> +++ b/Documentation/devicetree/bindings/dma/k3dma.txt
> @@ -3,7 +3,9 @@
>  See dma.txt first
>  
>  Required properties:
> -- compatible: Should be "hisilicon,k3-dma-1.0"
> +- compatible: Must be one of
> +-		"hisilicon,k3-dma-1.0"
> +-		"hisilicon,hisi-pcm-asp-dma-1.0"
>  - reg: Should contain DMA registers location and length.
>  - interrupts: Should contain one interrupt shared by all channel
>  - #dma-cells: see dma.txt, should be 1, para number
> @@ -43,3 +45,32 @@ For example, i2c0 read channel request line is 18, while write channel use 19
>  			dma-names = "rx", "tx";
>  		};
>  
> +
> +
> +
> +Controller:

Why is a new example needed just for a new compatible string?

> +		asp_dmac: asp_dmac@E804B000 {
> +			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +			reg = <0x0 0xe804b000 0x0 0x1000>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +			dma-requests = <32>;
> +			dma-min-chan = <0>;
> +			dma-used-chans = <0xFFFE>;
> +			dma-share;
> +			interrupts = <0 216 4>;
> +			interrupt-names = "asp_dma_irq";
> +			status = "ok";
> +		};
> +
> +Client:
> +		i2s2: hisi_i2s {
> +			compatible = "hisilicon,hisi-i2s";
> +			reg = <0x0 0xe804f800 0x0 0x400>,
> +				<0x0 0xe804e000 0x0 0x400>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
> +			dmas = <&asp_dmac 18 &asp_dmac 19>;
> +			dma-names = "rx", "tx";
> +			#sound-dai-cells = <0>;
> +		};
> -- 
> 1.9.1
> 
