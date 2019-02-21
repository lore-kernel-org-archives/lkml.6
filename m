Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B7420855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6CuFDWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfBUMGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:06:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39050 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfBUMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:06:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so9639032wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y9YS7duH8nu2lOgu/lWIOzf+fAy7Zade4MA4O6XG9zo=;
        b=R6CuFDWeL6iMnLISM8xodoa+skX+FGZE11t0xNl+vn0QplLmrna838VKHvQCT/kxUT
         7kYSNoFT3TaETKY8K7bF6C1W3E7zrhTkKJlxQsV2Qr1AGFN/MtnmtI9nZ3vyXODYUwgP
         ejrdCb5A8rSUT8zPhLrFTeYf6pzvZ1ZzIMBMSNBOKnuXe8DmzrUXhlieCfInDTJe/JmP
         7WxiMNDYC0S7gPPJ2a/KzI8LPZCVty5/PoolbAY6tZ9iY1Yvdrh4rKAPiCOvBWqOm/0f
         /hm14aOReSvIPd5cOFtU3l/mJ/tKynPGX7VfCUmdaHq4E0SXNAnofhNeAA8eyOBpv+DJ
         rLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9YS7duH8nu2lOgu/lWIOzf+fAy7Zade4MA4O6XG9zo=;
        b=AarnY1TI9XD6iCHx+SrCiaIbQ/Dv7cnljqIQ8HHHhHPbSxhB/KYXMmuyuQ9gO0d1YC
         KRD+sFQ6+6/5CUUvrzv8oAVASEE/RjsT3wCxj0why9lu3wXn3WKQ2PUKSlcVO/V4+pHV
         Q6Qyq2ujRrSrjogo2VjvxBAsMuDvulohVHEZqk1Ygp5E5Bf90olMdjf4ZeNAYScgCaBY
         KO9nw/d7kHK5ywyjhlX1BHmFYeN4Nuignmbx6r3d2muBhWtLx4KXRwyKjkUuL6HfhmuT
         hPISeQ4Fv5Ez2Pk/0c8pPg7MRPTwHJ7sk9sIBWZH/1dHxWd98deo7qyzYp7QGBgx48rM
         uyqw==
X-Gm-Message-State: AHQUAuadbn1Hm5RFBhBk2IOHGPWQsydQTXza49tmV2UIWjrRjkG47jok
        rAbrsCTdkdSk9V1VN29uNPDG/Q==
X-Google-Smtp-Source: AHgI3IaXK2VrqlVDnS6rDA8yfBBCGhPqZgWYD1kbbYyAgc+muxegsGsjWaJzfzhYl4mNOIkf5tt/4Q==
X-Received: by 2002:a1c:eb1a:: with SMTP id j26mr9827004wmh.127.1550750773241;
        Thu, 21 Feb 2019 04:06:13 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id c2sm14844892wrt.93.2019.02.21.04.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 04:06:12 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: drm/msm/a6xx: Document interconnect
 properties for GPU
To:     Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181220173026.3857-1-jcrouse@codeaurora.org>
 <20181220173026.3857-3-jcrouse@codeaurora.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <ff656778-04dc-df56-05eb-1b0bb3ceb29a@linaro.org>
Date:   Thu, 21 Feb 2019 14:06:09 +0200
MIME-Version: 1.0
In-Reply-To: <20181220173026.3857-3-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/18 19:30, Jordan Crouse wrote:
> Add documentation for the interconnect and interconnect-names bindings
> for the GPU node as detailed by bindings/interconnect/interconnect.txt.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 9c89f4fdb8ca..5b04393dcb15 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -20,6 +20,8 @@ Required properties:
>     - qcom,adreno-630.2
>  - iommus: optional phandle to an adreno iommu instance
>  - operating-points-v2: optional phandle to the OPP operating points
> +- interconnect: optional phandle to a interconnect provider.  See

Nit: s/interconnect:/interconnects:/
Nit: s/a interconnect/an interconnect/

> +  ../interconnect/interconnect.txt for details.
>  - qcom,gmu: For GMU attached devices a phandle to the GMU device that will
>    control the power for the GPU. Applicable targets:
>      - qcom,adreno-630.2
> @@ -68,6 +70,8 @@ Example a6xx (with GMU):
>  
>  		operating-points-v2 = <&gpu_opp_table>;
>  
> +		interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
> +
>  		qcom,gmu = <&gmu>;
>  	};
>  };
> 

Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks,
Georgi
