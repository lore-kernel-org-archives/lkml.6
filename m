Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD62C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3BD2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvcUVRBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3BD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH1Tgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:36:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45408 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1Tgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:36:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so1711943eda.12;
        Tue, 28 Aug 2018 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6scLo5QvXKw9KWomkNV5R5201be5jne89uP5ua45/Bk=;
        b=LvcUVRBtiJOjYmWAXUGEYz+ew3vz2Cb2IH90tOppuza8iUBl3MCxY152JFae1wruKU
         rkvfpCBY567+rX+2yrwaJOG3phMRzjoncVOSscBlri/Ei9HOI4mO/pWk6l3ht/kRA9Sc
         5I/FG7APbW6VD3D2elHpzNRPX31PPIj79ydf4xAmj4dfygMA1FWARq/IgC8s6pIhzxR9
         IRPE3qt5H3d5xI1rKO6U85rEWKqiwQGJLOFDLqQ3b93Vp4D9fpH1PcaZ57NzPbaYgWuH
         6MiMRYEl5A/Ypy8sD28T0FGv/wON8CqErMnO5Csh0k4CAZtY9qXMWXHLXMD/CS5inwzH
         beMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6scLo5QvXKw9KWomkNV5R5201be5jne89uP5ua45/Bk=;
        b=ViAXYENx/H237MUFgUJTjwfUbMnPUvD1GE3c4BuiALzGyC+4uZCCdKMmIQNGwWaUdc
         GZsLDwc7gWH7TQvo3VFk9kdfkETwZ7VRUOeQ8wG077JXPxujA6Z8KPIRV/yz1fi+iJ/i
         tzonNLyIyAN5YajCYmLDttOBTMtznl8RyORRE/624WX+y2WOfuMJCcQdh4i2s2umErVE
         gJGgxZz8uU7nFONY0zlU/O0iK6srdSAd5wh021GbXtPdyjU3wSBfDd806d6WXaZnKc/Z
         9x2iSuuEo7z4Q6jOykxpb/apMOSIsl5K0Rr0GPwmaXvqFG+eGHl4Y8CthAOWQdGicyyI
         C3bQ==
X-Gm-Message-State: APzg51DwNxmGDYAOLAgFwnU5qI7rPWb270E18UjsSdH5FcRL3J6Cfo+E
        07IVKKb+bSTAaX8Ucbzw/Xo=
X-Google-Smtp-Source: ANB0VdYGKiV/g2d8u26suIhpvOYxoylkwEBmbNh/pp0CfQRAGU2XLt/BgFz/PXkpkXUJFHoN6MiOdw==
X-Received: by 2002:a50:b158:: with SMTP id l24-v6mr3166595edd.31.1535471063464;
        Tue, 28 Aug 2018 08:44:23 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.99])
        by smtp.gmail.com with ESMTPSA id e25-v6sm763665edd.35.2018.08.28.08.44.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:44:22 -0700 (PDT)
Subject: Re: [PATCH 1/3] spis: mediatek: add bindings for Mediatek MT2712 soc
 platform
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mengqi.zhang@mediatek.com,
        yt.shen@mediatek.com
References: <1535437685-30230-1-git-send-email-leilk.liu@mediatek.com>
 <1535437685-30230-2-git-send-email-leilk.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <d91449a1-87f4-77e0-dd94-09e9989aaa7e@gmail.com>
Date:   Tue, 28 Aug 2018 17:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535437685-30230-2-git-send-email-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/08/18 08:28, Leilk Liu wrote:
> This patch adds a DT binding documentation for the MT2712 soc.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |   39 ++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

Do I understand correctly that mt6xxx, mt7xxx and mt8xxx SoCs have a totally
different architecture then mt27xx so they will need a totally different
binding. If not, then please rename the binding description file and the driver.

Regards,
Matthias

> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> new file mode 100644
> index 0000000..dcb8934
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> @@ -0,0 +1,39 @@
> +Binding for MTK SPI Slave controller
> +
> +Required properties:
> +- compatible: should be one of the following.
> +    - mediatek,mt2712-spi: for mt2712 platforms
> +
> +- reg: Address and length of the register set for the device
> +
> +- interrupts: Should contain spi interrupt
> +
> +- clocks: phandles to input clocks.
> +  The first should be one of the following. It's PLL.
> +   -  <&topckgen CLK_TOP_UNIVPLL1_D2>: specify parent clock 312MHZ.
> +				      It's the default one.
> +   -  <&topckgen CLK_TOP_UNIVPLL1_D4>: specify parent clock 156MHZ.
> +   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
> +   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
> +  The second should be <&topckgen CLK_TOP_SPISLV_SEL>. It's clock mux.
> +  The third is <&infracfg CLK_INFRA_AO_SPI1>. It's clock gate.
> +
> +- clock-names: shall be "parent-clk" for the parent clock, "sel-clk" for the
> +  muxes clock, and "spi-clk" for the clock gate.
> +
> +- spi-slave: Empty property indicating the SPI controller is used in slave mode.
> +
> +Example:
> +
> +- SoC Specific Portion:
> +spis: spi@10013000 {
> +	compatible = "mediatek,mt2712-spi-slave";
> +	reg = <0 0x10013000 0 0x100>;
> +	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
> +	clocks = <&topckgen CLK_TOP_UNIVPLL1_D2>,
> +		<&topckgen CLK_TOP_SPISLV_SEL>,
> +		<&infracfg CLK_INFRA_AO_SPI1>;
> +	clock-names = "parent-clk", "sel-clk", "spi-clk";
> +	spi-slave;
> +	status = "disabled";
> +};
> 
