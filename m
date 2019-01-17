Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D820820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZrDnw6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfAQL6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:58:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40685 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfAQL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:58:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so753206wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 03:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ltGnCxcWg0Ap4FsMopVRb/SaOLjtiOKjd7M3xkCFCV4=;
        b=QZrDnw6f6/HAgutYsVDYjBe112BeTPj2zWjL6D3p3AtvCmy6FD2IXiIdvxgzBwy7fX
         HCzhlSuCq8ZlcHIH60w3p0shmQ46MxByiwQbk3xahnLoGnbQ+sRZR/kwvFeC96ox0VNq
         pcoI+yWFycvtE+oJTARr9i8Tg2ptJLUn1ZIeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ltGnCxcWg0Ap4FsMopVRb/SaOLjtiOKjd7M3xkCFCV4=;
        b=i2HLLUhhbUwYrR2YhJoaXCAn93ztvaEqVLdMsH7Wd6ytCRYfXctslVrzY1k5sRcxkO
         l4I1hJu0PMYuBZIo1zQpX5qbvhTZt9vd58KIatrBC1ojluSx40woHMfxGKt7Oe7W5/DL
         AxDQD9wykRNHUwdU0Tmcp8vyKQw2Tyu5VrSLwLNLiEME6WdR/iva/WHOswlejRMtLQ7f
         aYAp8WmpUYriK9TdhSDu5p3DdfVZg5Wu52ZQpBPFjaMHCR53LRQzik70EvAqAknem0Hu
         /moDwy6P6MtH3++tuENDI2YsdFMqQuwRDA3wfx1VrhkqYP7n4e6zB5dEfJuCTNScnWWx
         SHJw==
X-Gm-Message-State: AJcUukc/NLYkyIxCsIJUPkfP2RWJM27QMKzgUK8m7NuEthkfMXBqRZE8
        uk/fbemYGULt0rHtZe1vhMK/AQ==
X-Google-Smtp-Source: ALg8bN6q9Jly6ShQSpKbxeglTag1G7LNCDlRkQyALblhNBxA1GA10Ihh1QvbNB7+qc9F1b3TRijG3Q==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr11421498wmg.84.1547726287926;
        Thu, 17 Jan 2019 03:58:07 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id 143sm78008876wml.14.2019.01.17.03.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 03:58:07 -0800 (PST)
Subject: Re: [PATCH v3] arm64: dts: sdm845: add video nodes
To:     Malathi Gottam <mgottam@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
References: <1545292023-5489-1-git-send-email-mgottam@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <0ee6676f-f169-1ea1-506e-16e4097d1c04@linaro.org>
Date:   Thu, 17 Jan 2019 13:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545292023-5489-1-git-send-email-mgottam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On 12/20/18 9:47 AM, Malathi Gottam wrote:
> This adds video nodes to sdm845 based on the examples
> in the bindings.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Looks good to me:

Reviewed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0..ccd2b10 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -87,6 +87,11 @@
>  			reg = <0 0x86200000 0 0x2d00000>;
>  			no-map;
>  		};
> +
> +		venus_region: memory@95800000 {
> +			reg = <0x0 0x95800000 0x0 0x500000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> @@ -1403,5 +1408,35 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		video-codec@aa00000 {
> +			compatible = "qcom,sdm845-venus";
> +			reg = <0x0aa00000 0xff000>;
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +			power-domains = <&videocc VENUS_GDSC>;
> +			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> +				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
> +			clock-names = "core", "iface", "bus";
> +			iommus = <&apps_smmu 0x10a0 0x8>,
> +				 <&apps_smmu 0x10b0 0x0>;
> +			memory-region = <&venus_region>;
> +
> +			video-core0 {
> +				compatible = "venus-decoder";
> +				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> +				clock-names = "core", "bus";
> +				power-domains = <&videocc VCODEC0_GDSC>;
> +			};
> +
> +			video-core1 {
> +				compatible = "venus-encoder";
> +				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> +					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> +				clock-names = "core", "bus";
> +				power-domains = <&videocc VCODEC1_GDSC>;
> +			};
> +		};
>  	};
>  };
> 

-- 
regards,
Stan
