Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C46C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9253C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP/SNMvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9253C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeKVDQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKVDQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:16:25 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D5C7214DB;
        Wed, 21 Nov 2018 16:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542818474;
        bh=8HAVXbpwqElnGVGxsl2oSWN+s8BG3HTpeSx+mjUn6b8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WP/SNMvPMBqfnFd4sqcqNLLfNxUQz4tPe3kdpEDXhXgTo2bwN7d85hFHEXJ2mEkkd
         eRyNLdephY0fKdF+pJamwYllGHW0csqUWbW7s1+Syo8VojTHPO8lZXTav5xuz8YjrN
         DgHSNXQY7cWqT53e7QFs9lY73d8RWmOKOSD3RM3Y=
Received: by mail-qt1-f180.google.com with SMTP id e5so4501547qtr.12;
        Wed, 21 Nov 2018 08:41:14 -0800 (PST)
X-Gm-Message-State: AA+aEWbkBqTjS8pKgKHu0J+2EBr5izmyu3F9yogcu0P1oZQGcr97q7lL
        qXz7kiRelDz1IvJeeAXxET2ugmeqGsaTN6VZqQ==
X-Google-Smtp-Source: AJdET5fDIxypLub9Xzo/Ec3DfCgOREyCF0dY9Gspns4jxiGfqPAHO30u9E2jAJrk8K43/x+/5ZBOPDwplwV5mfeTFaI=
X-Received: by 2002:ac8:173d:: with SMTP id w58mr6535327qtj.76.1542818473412;
 Wed, 21 Nov 2018 08:41:13 -0800 (PST)
MIME-Version: 1.0
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro> <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
In-Reply-To: <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Nov 2018 10:41:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
Message-ID: <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
To:     radu_nicolae.pirea@upb.ro
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.co>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 5:29 AM Radu Pirea <radu_nicolae.pirea@upb.ro> wrote:
>
> The bindings for DMA are now common for both drivers of the USART
> IP.
>
> The node given as an example for USART in SPI mode has been updated in
> order to include DMA bindings.
>
> Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
> ---
>  .../devicetree/bindings/mfd/atmel-usart.txt       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> index 7f0cd72f47d2..8ad008175343 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> @@ -17,17 +17,19 @@ Required properties for USART in SPI mode:
>  - cs-gpios: chipselects (internal cs not supported)
>  - atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
>
> +Optional properties in serial and SPI mode:
> +- dma bindings for dma transfer:
> +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> +               Refer to dma.txt and atmel-dma.txt for details.
> +       - dma-names: "rx" for RX channel, "tx" for TX channel.

> +               dma-names = "tx", "rx";

The dma-names should have a defined order.

Rob
