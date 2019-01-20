Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F2C7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A25520861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+CF+9Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfATQ2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:28:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45771 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfATQ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:28:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so13772554lfa.12;
        Sun, 20 Jan 2019 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2zeLJaZ4n1WQI+SD7IrLf8g19G1ClUe9M8YddGgYayE=;
        b=k+CF+9KhVTO05PRScpyt9Wp1xQkKGY2wIGdbEqVCoG3wSeZXeLt0YFWG5aB8CzFO+H
         oPwT9jtZSLfA+vL28dOGRU5XdRqw3IJmXrHXX8sWtacOViFMhRo/qLmxh66WEtF4wgIt
         TZOTXENA5U1qU/qzgpC+IwK5aaHPywtjuoD6d/84iZB1Aq9zedPLxKxVD1yq9yEY+Vsa
         SF+yGQPSGfB1J/gWmlAotOhEbiwD6prAdIBQH6YVJpmrgc45ZCr7RWp/0fXqpk/X4GfY
         qLJXrtVlGWIR+HdBkjwWbs4rJus/UnyMVjc8OEkq0IRT9KP5H3Y/wI8TC//dOclt8SDo
         IiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2zeLJaZ4n1WQI+SD7IrLf8g19G1ClUe9M8YddGgYayE=;
        b=qLordlKPPo5Nm1deaSuOsbWLtn8pPIIIQULVp1HwGBOWnn6c8LtqeVYdIRd16yUzC8
         eE23aRtHDMnyGR6Wioq1aBOSYvrbgUm0mqvsiRCJzyG6lmOa0D0FXNnZbg+gqTUtqZKU
         p39t3nJ5w3+FFWvxFGZsJcu6EnERUvZKZtHTo2xCnQeqYbQopjZiyADlO+pDyNErDMdd
         IOifnXwNXZPDbyAclExn1sDBhEYShYUJZrpYM01OYp3EfjrnZMSxSPSGV4jWYTvRiIks
         yuzxkAlCuJ3hVpevPKs4u1LdAy/RdZqAV+UvKqXOZqzKaqIyb9AdTjyBXWF9kWl6belN
         Txmw==
X-Gm-Message-State: AJcUukecCNYxcALPCnQa7+Oe16+2mwmf5vkDHqFlZwLzhb3J/mTBN8Ei
        zKkPzn/f3Ps7mJHCDF70o2cwbLCh
X-Google-Smtp-Source: ALg8bN4328O6qWJ0U4VfgiJH4SPdhMpJuW/8CRaSvx28VCzVKokS5q5JvOGDnFJzzfdtk7Ea9E9X+w==
X-Received: by 2002:a19:df41:: with SMTP id q1mr17222481lfj.25.1548001698849;
        Sun, 20 Jan 2019 08:28:18 -0800 (PST)
Received: from [192.168.1.18] (bdu110.neoplus.adsl.tpnet.pl. [83.28.6.110])
        by smtp.gmail.com with ESMTPSA id 12-v6sm1763896ljf.96.2019.01.20.08.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 08:28:18 -0800 (PST)
Subject: Re: [PATCH 05/13] dt-bindings: leds: add DT bindings for max77650
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
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-6-brgl@bgdev.pl>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <86aebe51-1279-0bb6-05ca-8d7c27790681@gmail.com>
Date:   Sun, 20 Jan 2019 17:28:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118134244.22253-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

Thank you for the patch.

On 1/18/19 2:42 PM, Bartosz Golaszewski wrote:
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
> index 000000000000..822b8893bc20
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
> +- compatible:		Must be "maxim,max77650-leds"
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
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led0 {

s/led0/led@0/

> +			reg = <0>;
> +			label = "max77650:blue:usr0";
> +		};
> +
> +		led1 {

s/led1/led@1/

> +			reg = <1>;
> +			label = "max77650:red:usr1";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led2 {

s/led2/led@2/

> +			reg = <2>;
> +			label = "max77650:green:usr2";
> +		};

Please remove "max77650:" from labels and add it in the driver.

> +	};
> 

-- 
Best regards,
Jacek Anaszewski
