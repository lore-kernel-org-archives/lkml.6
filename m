Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E542184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSFLzELa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbfA3T6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:58:34 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43705 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbfA3T6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:58:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so556242lff.10;
        Wed, 30 Jan 2019 11:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kOnrdBoDl+6QiotbwvFUKNpP9qP7se/5Kibtn2OpwJs=;
        b=gSFLzELaX7JoecUcnXJ6k2uRGKnMMgAr6qLItHkH8wSMzLN4f154vXIBUWiRVKPTcO
         jRr/iAsP5IZvmCMgrFKvXOKCpiJqXscOqloNgCfLKb739n1PtqjLrQ7jCnRsaVQvVbyi
         IgH7XYdl7j27jD8XutNPU/8DDyFBlsauhdC96MRUiYwwSoYgSkwGb6/LQs4wd47IdbHP
         /vk7CxMP62OZVgT7naL4uZvlH90uLspgws/zI73rQbDcB276GmK5yQrkGln7uGtKvlzV
         K0PrccaDHfuxekM2z08fBD2aMC+5Fx5Hq5MHnmQsKK2E4LnU3Mp6BXz28bDzn2Kd4Q8i
         xUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOnrdBoDl+6QiotbwvFUKNpP9qP7se/5Kibtn2OpwJs=;
        b=mZvcLqYqM4KR33fjlOaBWDOnSx1GUvqkO2RcNvfiz5bDHsIv2vX0SDNr5Rg54V/INZ
         2AzyVz//hEXhdL3lQPHStWT7vrvKF96LjjUJuCt69HwmzDXR487EP6K0qSC0aqfzTi0u
         2iMz6VDVSTrif1Y3iuUhzsW7lOVi8kQw7DGUfG2IOYY6zotwyuBHfXcXUwWWJdXdBW5f
         jJPHVZ2O4MtXMEJmTgsHm3v4jiA08uQiMXtO0ZZ2H3ZngxJ4bvl+RXATPMqDzGbr82/C
         GSC2Cu4mjpTh4bj36K5wDb6g2LdfBK9Api8EorfVQXCWsFtfdueOd4fAQ4Fte3roo4cl
         UZOg==
X-Gm-Message-State: AJcUukdpOYX7Rf5w8/mbP7Yo7UZdgzJPCUmhLSCss8/nQ5Cax7hEzFD9
        GIRIj0LrWH3izngFuUdlGg8=
X-Google-Smtp-Source: ALg8bN6QuktHhDq295BvGcBP/QJdwlD3UizASZcMk8qSPF+MhXae+nHmeLBN0C9Gv4A9Iww0gQT/1g==
X-Received: by 2002:a19:4cc3:: with SMTP id z186mr23983636lfa.37.1548878310234;
        Wed, 30 Jan 2019 11:58:30 -0800 (PST)
Received: from [192.168.1.18] (dks71.neoplus.adsl.tpnet.pl. [83.24.22.71])
        by smtp.gmail.com with ESMTPSA id c5-v6sm419825lja.62.2019.01.30.11.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:58:29 -0800 (PST)
Subject: Re: [PATCH v2 05/13] dt-bindings: leds: add DT bindings for max77650
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190129133545.1931-1-brgl@bgdev.pl>
 <20190129133545.1931-7-brgl@bgdev.pl>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <0c9e7c6c-d1c0-8acc-88cb-16b01f75e134@gmail.com>
Date:   Wed, 30 Jan 2019 20:58:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129133545.1931-7-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

Thank you for addressing my remarks.

On 1/29/19 2:35 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the LEDs module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
>   1 file changed, 57 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
> new file mode 100644
> index 000000000000..b2fac8e719a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
> @@ -0,0 +1,57 @@
> +LED driver for MAX77650 PMIC from Maxim Integrated.
> +
> +This module is part of the MAX77650 MFD device. For more details
> +see Documentation/devicetree/bindings/mfd/max77650.txt.
> +
> +The LED controller is represented as a sub-node of the PMIC node on
> +the device tree.
> +
> +This device has three current sinks.
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "maxim,max77650-led"
> +- #address-cells:	Must be <1>.
> +- #size-cells:		Must be <0>.
> +
> +Each LED is represented as a sub-node of the LED-controller node. Up to
> +three sub-nodes can be defined.
> +
> +Required properties of the sub-node:
> +------------------------------------
> +
> +- reg:			Must be <0>, <1> or <2>.
> +
> +Optional properties of the sub-node:
> +------------------------------------
> +
> +- label:		See Documentation/devicetree/bindings/leds/common.txt
> +- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
> +
> +For more details, please refer to the generic GPIO DT binding document
> +<devicetree/bindings/gpio/gpio.txt>.
> +
> +Example:
> +--------
> +
> +	leds {
> +		compatible = "maxim,max77650-leds";

s/leds/led/

With that:

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@0 {
> +			reg = <0>;
> +			label = "blue:usr0";
> +		};
> +
> +		led@1 {
> +			reg = <1>;
> +			label = "red:usr1";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led@2 {
> +			reg = <2>;
> +			label = "green:usr2";
> +		};
> +	};
> 

-- 
Best regards,
Jacek Anaszewski
