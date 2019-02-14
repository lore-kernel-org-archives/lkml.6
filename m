Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F7EC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CF62177E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grH8GY4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406480AbfBNKNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:13:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36207 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBNKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:13:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id o59so4549057edb.3;
        Thu, 14 Feb 2019 02:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irOQpq6SSdLLp2C1XSsqHzjf0cBAFINoZcNuwI+nG+A=;
        b=grH8GY4LpRdrhzaGOWxcsDqsrcVFi9QVvwViKQeTDUzNTFD+0H4d5I2FeFg8nxCf0I
         fkTs5m+MF9Bm912LvX9lt0CmUAo1S8JzQQSu7g+LlT+kc/NSSkKN6mBAOTdsa0F4lN8h
         YAod1lQ6l7pt05lYrO6wJY19b9Eate/+lTdePoManhgiR2cQRnMp59uxD+iZp3BgIojc
         jx5rciQ86uQRz90H+U323chW3JxGGKkyCqzuMNiqeZW4bDjYEzjWuqwV/RBkaXzpx2R8
         kF52otq9f80h2a6/luJ0pjKeiK/YfLjVDFmMCDPAG8eaBlbvMPXWkgC40n/3z+2mbBTL
         ZgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=irOQpq6SSdLLp2C1XSsqHzjf0cBAFINoZcNuwI+nG+A=;
        b=dvWlG+0jHbE36CVOHgKbfZPz+EgZFJhgQt1l3PIO03nRCIHKpIqkpWFH5gkk0vV8uB
         AbS5CyRATEJkjpwO8Xe+1S3tECs6ngpZN9ZiYMT1lMhM6VCImVstBdm3Q2slvEJUDCof
         yS/DAYo/FD609V7T6Clj+s8Q0t7HFAvydcsolMxjFm/TLUIo0V7qCLecvUNu8Uy6rtoY
         0Gpx2pdA+C+0qieaR7/rY4y0rmSmyFMroza3F9onclonbwuoLAXoEfiPH9sB2fzPCNLs
         ftmePiMXdfNXLT24rqXpXPSXLsjsOKL+A5DIv+acSHmEENJqqDGa/bwTiijoO2yD5Zvs
         dCsg==
X-Gm-Message-State: AHQUAuYiu2Q54MwUQV1SU+/FubbL+FeDtk08aKyz5PcbZCxHo55QDgHk
        6PiRd4t66V9jFyFDo8Ta2Qw=
X-Google-Smtp-Source: AHgI3IbMLuE74aSJ+ucbD+73cwLHX9E6qN2C1hQCRlDkPPxYqXr144Einb06+ThuppRVLmYrzf3/6A==
X-Received: by 2002:a17:906:4058:: with SMTP id y24mr2172189ejj.230.1550139193140;
        Thu, 14 Feb 2019 02:13:13 -0800 (PST)
Received: from ziggy.stardust ([37.223.146.9])
        by smtp.gmail.com with ESMTPSA id x53sm550593edx.91.2019.02.14.02.13.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:13:11 -0800 (PST)
Subject: Re: [PATCH v10 3/3] dt-bindings: dma: uart: rename binding
To:     Long Cheng <long.cheng@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <f16c7833-71cd-c43f-392e-a18b9fef177d@gmail.com>
Date:   Thu, 14 Feb 2019 11:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2019 04:10, Long Cheng wrote:
> The filename matches mtk-uart-apdma.c.
> So using "mtk-uart-apdma.txt" should be better.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 --------------------
>  .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   33 ++++++++++++++++++++
>  2 files changed, 33 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
> deleted file mode 100644
> index 3fe0961..0000000
> --- a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -* Mediatek UART APDMA Controller
> -
> -Required properties:
> -- compatible should contain:
> -  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
> -  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> -
> -- reg: The base address of the APDMA register bank.> -
> -- interrupts: A single interrupt specifier.

One interrupt per dma-request, or 8 if no dma-requests property is present.

> -
> -- clocks : Must contain an entry for each entry in clock-names.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: The APDMA clock for register accesses> -
> -Examples:
> -
> -	apdma: dma-controller@11000380 {
> -		compatible = "mediatek,mt2712-uart-dma";
> -		reg = <0 0x11000380 0 0x400>;
> -		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&pericfg CLK_PERI_AP_DMA>;
> -		clock-names = "apdma";
> -		#dma-cells = <1>;
> -	};
> -
> diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> new file mode 100644
> index 0000000..3fe0961
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> @@ -0,0 +1,33 @@
> +* Mediatek UART APDMA Controller
> +
> +Required properties:
> +- compatible should contain:
> +  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
> +  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
> +
> +- reg: The base address of the APDMA register bank.
> +

There is one address needed for every dma-request or 8 if dma-requests property
is not present. As already mentioned in the driver review dma-requests property
is missing.

> +- interrupts: A single interrupt specifier.
> +
> +- clocks : Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: The APDMA clock for register accesses
> +

Missing option property dma-33bits (should be mtk,dma-33bits?).

> +Examples:
> +
> +	apdma: dma-controller@11000380 {
> +		compatible = "mediatek,mt2712-uart-dma";
> +		reg = <0 0x11000380 0 0x400>;

We are missing the io mem areas here, right?

Regards,
Matthias

> +		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_AP_DMA>;
> +		clock-names = "apdma";
> +		#dma-cells = <1>;
> +	};
> +
> 
