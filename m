Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F0C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B06620863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8isa3I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfBHSdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:33:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33701 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfBHSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:33:42 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2so3649179edi.0;
        Fri, 08 Feb 2019 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rbW32i6xkLu+++SjXjekMDgoMGuFmUvPdw902iD4MI=;
        b=K8isa3I2DUXjhioKhL9ZzFT/bRmWDq1L6q7GSeLwJ5yfjcvIFtZt3pinCruHHb/JpF
         C7q+ComXYc2vG57CaodQFe8+5vr3ccfQ9VolHg1AMjdT5RvL3C2FRPX3ZXsgLyfskAHA
         lhb23wdSe3LB3IuxPm/3C3lyFY5ACz3ymkHDy7JsF6CaLB9O3wfP+Q4txY2vn/bKsA/C
         ZyINtXdsAT6vWfdrqvBMkns2foPixHj7Fv8Blraurq6ORgpQnpuHGxktudyhk1F4U0Vl
         +F28ga9I0S/LkVTbA3tcbLmusyBCqxyeUeOHb047E2HMMjjj8tmEcliz6sRFTnxuitit
         kskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5rbW32i6xkLu+++SjXjekMDgoMGuFmUvPdw902iD4MI=;
        b=VqRyKQnzF/rzykY/M9AEDAj5TBIZJ4O//ULA0mLsHTQMv5ZC2yxGTlOj1d0KBLo2cV
         4N1vDD1U4sM1W2IY3RJa/xxb/9WJu+ByuquqhuXloXK3yQ+YOk6UPsIqwqDDa7XNopYO
         mcFI235pR02yvZ1ueKy1vG4WxVPpH1o7Qq7cxbpih7rBrl1vGZYEig/jIJo5RCpiO3Qe
         iDpJ1qEHakD9XBqJRGUpQkRnARTJ2/QEjqLXvCMq4MzChdVfqL4+30Mw3iL/REifzGdm
         akmudwlSewB1C9WZW2U3Xk+hf/0CMQHkZ3jbBJhc7FlSTyiwD9W30fs/lfK8dhbgmE+R
         XY4g==
X-Gm-Message-State: AHQUAubqOQa1Qi7oPK5pRrGKP8eUfyXCihKxctFfNcoZ0gfni4dug+hi
        7NGBcYlcqLTKLfo+LgbRaznw74F/FEY=
X-Google-Smtp-Source: AHgI3IZacNopyp8mxiLOSZ9WksPYd9MgEBLsReQojAr3F9VuyOC62kwbIhrPiS/JjktDPfOqrLm5Zg==
X-Received: by 2002:a50:a086:: with SMTP id 6mr17629043edo.88.1549650818756;
        Fri, 08 Feb 2019 10:33:38 -0800 (PST)
Received: from ziggy.stardust ([2a00:23c5:318d:1d00:295e:b5f9:da4c:df23])
        by smtp.gmail.com with ESMTPSA id a4sm623203eje.66.2019.02.08.10.33.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:33:37 -0800 (PST)
Subject: Re: [PATCH v4 10/12] dt-bindings: soc: Add MT8183 power dt-bindings
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-12-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <831a5728-de2d-b777-56b6-1fdcb9c7ed49@gmail.com>
Date:   Fri, 8 Feb 2019 19:33:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190201083016.25856-12-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2019 09:30, Weiyi Lu wrote:
> Add power dt-bindings for MT8183.
> 

Sorry didn't see this when reviewing the driver.
Please add real commit message, explaining what the changes are.

> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/scpsys.txt          | 14 ++++++++++
>  include/dt-bindings/power/mt8183-power.h      | 26 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8183-power.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index d6fe16f094af..b4728ce81c43 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -14,6 +14,7 @@ power/power_domain.txt. It provides the power domains defined in
>  - include/dt-bindings/power/mt2701-power.h
>  - include/dt-bindings/power/mt2712-power.h
>  - include/dt-bindings/power/mt7622-power.h
> +- include/dt-bindings/power/mt8183-power.h
>  
>  Required properties:
>  - compatible: Should be one of:
> @@ -24,18 +25,31 @@ Required properties:
>  	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
>  	- "mediatek,mt7623a-scpsys": For MT7623A SoC
>  	- "mediatek,mt8173-scpsys"
> +	- "mediatek,mt8183-scpsys"
>  - #power-domain-cells: Must be 1
>  - reg: Address range of the SCPSYS unit
>  - infracfg: must contain a phandle to the infracfg controller
>  - clock, clock-names: clocks according to the common clock binding.
>                        These are clocks which hardware needs to be
>                        enabled before enabling certain power domains.
> +                      The new clock type "BASIC" belongs to the type above.
> +                      As to the new clock type "SUBSYS" needs to be
> +                      enabled before releasing bus protection.
>  	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
>  	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
>  	Required clocks for MT6797: "mm", "mfg", "vdec"
>  	Required clocks for MT7622: "hif_sel"
>  	Required clocks for MT7622A: "ethif"
>  	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
> +	Required clocks for MT8183: BASIC: "audio", "mfg", "mm", "cam", "isp",
> +					   "vpu", "vpu1", "vpu2", "vpu3"
> +				    SUBSYS: "mm-0", "mm-1", "mm-2", "mm-3",
> +					    "mm-4", "mm-5", "mm-6", "mm-7",
> +					    "mm-8", "mm-9", "isp-0", "isp-1",
> +					    "cam-0", "cam-1", "cam-2", "cam-3",
> +					    "cam-4", "cam-5", "cam-6", "vpu-0",
> +					    "vpu-1", "vpu-2", "vpu-3", "vpu-4",
> +					    "vpu-5"
>  
>  Optional properties:
>  - vdec-supply: Power supply for the vdec power domain
> diff --git a/include/dt-bindings/power/mt8183-power.h b/include/dt-bindings/power/mt8183-power.h
> new file mode 100644
> index 000000000000..5c0c8c7e3cd0
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8183-power.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
> +#define _DT_BINDINGS_POWER_MT8183_POWER_H
> +
> +#define MT8183_POWER_DOMAIN_AUDIO	0
> +#define MT8183_POWER_DOMAIN_CONN	1
> +#define MT8183_POWER_DOMAIN_MFG_ASYNC	2
> +#define MT8183_POWER_DOMAIN_MFG		3
> +#define MT8183_POWER_DOMAIN_MFG_CORE0	4
> +#define MT8183_POWER_DOMAIN_MFG_CORE1	5
> +#define MT8183_POWER_DOMAIN_MFG_2D	6
> +#define MT8183_POWER_DOMAIN_DISP	7
> +#define MT8183_POWER_DOMAIN_CAM		8
> +#define MT8183_POWER_DOMAIN_ISP		9
> +#define MT8183_POWER_DOMAIN_VDEC	10
> +#define MT8183_POWER_DOMAIN_VENC	11
> +#define MT8183_POWER_DOMAIN_VPU_TOP	12
> +#define MT8183_POWER_DOMAIN_VPU_CORE0	13
> +#define MT8183_POWER_DOMAIN_VPU_CORE1	14
> +
> +#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
> 
