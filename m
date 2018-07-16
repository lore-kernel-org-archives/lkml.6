Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E522ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A020863
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rs3VZYzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8A020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeGPOEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:04:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40007 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeGPOEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:04:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so29977382edq.7;
        Mon, 16 Jul 2018 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zj6IWLpDadCIycG2bxXELT1MALg6sQaNACe2eKV9Tq8=;
        b=rs3VZYzgjtujYks2gJtLvVD3nNt2iF6y5qBPmq4h8eAivagUOBSuxbTyrCCGzC2ic8
         b8LMRfacL40tvchOK+CG1D+KkanmW6SsGGUh1oAkjj0O8i0hANRQvUQNC6azaQKIZef6
         Kqv/8yrU2nc4AR5lQ3FnnSxbAV5zbHNrTf3+xLxMcim+ffLlD+64wS7iAdY9Ub7o7bu2
         j8GVNnxUG4X+GG40dvTUChjNwE2z/2SpTw1bLF8jRnrGm7RNZqICx3wI6ahB0kj/6VPC
         sk2jpZTDojMiSbtmx1+4f0BWFo7DAo0eSpShHHKsm+3cdwGcMdA8uEE69nnAysQCDZU+
         AE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Zj6IWLpDadCIycG2bxXELT1MALg6sQaNACe2eKV9Tq8=;
        b=Wyg9NWOsqJW1rTa5HLoJozfzII7j7lAZDRdKgzMmhR+Q0N5RfMVW/zaRXvyGp8xNK8
         2fbqG28MH6G6EcDCGzhwwcKlcvdH1D2ZZ6B2REq0NORbu0EtIL8mP2D5BCrHysgaDvAz
         XTKyHLyPFwXS4q2DUcGAe+eSHuFmLft770a3NumhBru57doE8WoTbfz+bJ0Nfv3QsrGw
         yyE2lSFj2eE58ie0FnZghvpKKNBXdciFeyxbeYElykcvgAIiomKrbwFi7R/8FCU8y80g
         at9nIGtiI7wiZ/8EN6J3+v7cediNj6xiHOPCxeDWYrTdR/EHEKt/Ncl5Q1sNQ9zlz4dT
         47Fw==
X-Gm-Message-State: AOUpUlFt+NNeJsBvLzL4/ESGKfs1GKgBSF0lq0+NZ+VMI9VGil5Xr7jc
        EO8nY2OhTKyUCRGZfx2EL4Y=
X-Google-Smtp-Source: AAOMgpetmJkK0NQ12cBd70qCGEuSIuyHhnASy5QnrEisUbDX5f+jiy+/RPPP5RW2e5lxlmFhLBorRg==
X-Received: by 2002:aa7:c4cf:: with SMTP id p15-v6mr17631034edr.240.1531748212720;
        Mon, 16 Jul 2018 06:36:52 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id y89-v6sm14682905edy.80.2018.07.16.06.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:36:51 -0700 (PDT)
Subject: Re: [PATCH 6/7] arm64: dts: mt7622: use gpio-ranges to pinctrl device
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
 <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <76cde153-74db-101d-84a1-a0a7da679daf@gmail.com>
Date:   Mon, 16 Jul 2018 15:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e0483accc1e82280492a2f68a90959232ba868f6.1529639050.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/06/18 05:49, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Using gpio-ranges property represent which GPIOs correspond to which pins
> on MT7622 pin controllers. For details, we can see section 2.1 of
> Documentation/devicetree/bindings/gpio/gpio.txt to know how to bind pinctrl
> and gpio drivers via the "gpio-ranges" property.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

pushed now to v4.18-next/dts64

Thanks

> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index e2c5450..50cb56c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -291,6 +291,7 @@
>  		reg-names = "base", "eint";
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		gpio-ranges = <&pio 0 0 103>;
>  		interrupt-controller;
>  		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
> 
