Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4974020873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksP0+QdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4974020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeK1UDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:03:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34572 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeK1UDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:03:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so25465223wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pYPKx23m+3RIAQ/CZEOBUkvcYzaX0MjUaVr7exMZKeY=;
        b=ksP0+QdEHBWTOzlB7xkkrqu1rPSlnHClzWgTBfKtQi9V09sqIqT/1jLPI/gRacjLZV
         UBGiPc0dp4xAHb9E2gbdCi23MG1ezSyKN38dwnbLGxHMRmrvqjWETj1wK6ldnZxQ/W5l
         vvyRk1SS4gREAYvn5FL0Yu8NpOGqc8ec/eEWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pYPKx23m+3RIAQ/CZEOBUkvcYzaX0MjUaVr7exMZKeY=;
        b=f8vxLwJ7/WlFevYkImiB5cf90c0Q8SpX0U2pE0nrfe8kttHtTZmF6yBktfYL3jGi5X
         T77tms0amhM8qGCsfzRyh7jBR6QUKP4P6NyF22hdjb1CLuksAa9SU3Q4uIgDm3lu82Us
         x3rUyx+i2b8HI1lQbSVK1e4TbdaWpTnzkN4whLvKZzrRtUqKMS2LyC4+uXHNo9hR2X6i
         LlQfM06GHhRwRiRx9s0BgNP7hYQmPL+603Jchy7vGM/K2wIK1JniwpX0SDEOXSaAH15q
         0jri9tqGSc2DR0nbex+JWItvWXs5QJTEmXY3x6x/fFZ/ce8kBt/FN9OckgGI/mJWuClu
         cakA==
X-Gm-Message-State: AA+aEWbI9c7x5saiab+33ha9yZdJeGMatlmnheep3b3yBn9jzV8HCWJe
        tGyigo0+Rceb5L15ie1hQtOpRw==
X-Google-Smtp-Source: AFSGD/W4INxutTJvxidSVtO0kyrv2l5Ph8TVRqQRlNMlVWqz9III90AnmyL1ouxOASRkPlagD33Pbg==
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr31673900wro.218.1543395756472;
        Wed, 28 Nov 2018 01:02:36 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id s3sm492841wmj.23.2018.11.28.01.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:02:35 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:02:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 3/4] iio: adc: add STMPE ADC devicetree bindings
Message-ID: <20181128090233.GQ4272@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-3-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123142411.8921-3-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++++
>  .../bindings/input/touchscreen/stmpe.txt      | 60 ++++++++++++-------
>  .../devicetree/bindings/mfd/stmpe.txt         | 28 ++++++---
>  3 files changed, 80 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
[...]

> diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
> index c797c05cd3c2..d4408a417193 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -4,15 +4,29 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
>  keypad, touchscreen, adc, pwm, rotator.
>  
>  Required properties:
> - - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
> - - reg                          : I2C/SPI address of the device
> + - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
> + - reg				: I2C/SPI address of the device

Formatting changes should be completed in a separate patch.

Here they only serve to obscure the real changes you have made.

Please split the formatting changes out and re-submit.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
