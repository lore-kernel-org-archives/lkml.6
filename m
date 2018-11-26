Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDD1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEBA2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex5d8S6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEBA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeK0Biv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:38:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeK0Biv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:38:51 -0500
Received: from localhost (unknown [122.178.235.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74B420817;
        Mon, 26 Nov 2018 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543243471;
        bh=9dQ/l7zGD/mc2KA5oLf6Fke/83EoVDFjqXXzkPhFAvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ex5d8S6NdEXcP7u1gS7/OBBgXEXMjZIQA+lBhjof+ZaIDksilHTWiGx+JVmIHccqq
         4rqd4ADqPme6A1ENpA66A2DAQrywZ4SwxMCHNvB6tvjowoomqJgp+fPBQpYTCOJe40
         b1kEvACZdyyl3AQQQ7L9W+e3csY7/J1A6Z9CRd/8=
Date:   Mon, 26 Nov 2018 20:14:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device
 node
Message-ID: <20181126144422.GU3175@vkoul-mobl.Dlink>
References: <20181126142133.16966-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126142133.16966-1-govinds@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Govind,

On 26-11-18, 19:51, Govind Singh wrote:
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on qcs404 soc.
> Optional clock and regulator controls are not yet available in
> upstream, hence add them once available.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 9ca4f061ecc5..1a401a32d4a1 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -958,6 +958,25 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		wifi: wifi@0A000000 {

Please remove leading 0 from node

> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0x0A000000 0x800000>;
> +			reg-names = "membase";
> +			memory-region = <&wlan_msa_mem>;
> +			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  
>  	timer {

This file is sorted alphabetically and reg values. So this should be
between blsp1_uart2 and intc node, can you please change that

Also please compile this with W=12

Lastly, I am not sure, but should the wifi node be always enabled?
Should it not be enabled in the board dts file? Bjorn..?

Thanks
-- 
~Vinod
