Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E594EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9504323C23
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9504323C23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754233AbeGEUm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:42:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42350 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeGEUmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:42:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so19397432oib.9;
        Thu, 05 Jul 2018 13:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JwCAj5rk0enXwhklX1tMpVuDH6p7ds4aq4nQG3J61gI=;
        b=IUdI1FYYGXX3169otxFGa1l4Xmo/Z8ofksq8ns14Ly3kmVrKN4HZiBI/OsnUq5gFLx
         ILmUjrOuc7mD9AoSfVcgYMK4l6z/1kE8ss35XQwth69sgYJmM/8WiPhpZuL9U0EyD7Rk
         H5W+6iMyVr8NLCSlcnAo5bpxFDuNMCm64dHw7obXfyGpbLdcMcsNiYoKdEBNvrpefDQc
         1TUrE6U4oO42WrplTndr7oV9QbthhlRUSgOhKBZsEzGLP1BOeD4XwyqT9IM/nyVA/H9E
         Ndo2Vb7n4YDM8LupO4wSSWazF18oDW6nZ7o327hOWXAr3E6siIDBOjvuG3wbnzu10Ksj
         kHDw==
X-Gm-Message-State: APt69E1V67S2TxHOscU3p8YbSzL8OygaFvAUUyKdMKUNySU8KezpIYWL
        tO47AcxFt+uxuKiZv3DqQQ==
X-Google-Smtp-Source: AAOMgpcnRZQSX07ELKsEuqQcrzritGFNNRIL+P8QMCGUBNf7V3e8zl56WL2VzUaD/7E/jk/YAF7nKA==
X-Received: by 2002:aca:a8cc:: with SMTP id r195-v6mr8020934oie.212.1530823373806;
        Thu, 05 Jul 2018 13:42:53 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e202-v6sm11118119oih.8.2018.07.05.13.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 13:42:53 -0700 (PDT)
Date:   Thu, 5 Jul 2018 14:42:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180705204250.GA30484@rob-hp-laptop>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
 <20180705165515.13340-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705165515.13340-2-bgodavar@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:25:09PM +0530, Balakrishna Godavarthi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v9:
>     * updated with latest reg handle and names.
>     * updated max-speed definition. 
> 
> Changes in v8:
>     * Separated the optional entries between two chips
> 
> Changes in v7:
>     * no change.
> 
> Changes in v6:
> 
>     * Changed the oper-speed to max-speed.
> 
> Changes in v5:
> 
>     * Added entry for oper-speed and init-speed.
> 
> ---
>  .../bindings/net/qualcomm-bluetooth.txt       | 28 +++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a53cc29..ced58575e2b8 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -10,12 +10,22 @@ device the slave device is attached to.
>  Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
> +   * "qcom,wcn3990-bt"
> +
> +Optional properties for compatible string qcom,qca6174-bt:
>  
> -Optional properties:
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>  
> -Example:
> +Optional properties for compatible string qcom,wcn3990-bt:
> +
> + - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
> + - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
> + - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
> + - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
> + - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
> +
> +Examples:
>  
>  serial@7570000 {
>  	label = "BT-UART";
> @@ -28,3 +38,17 @@ serial@7570000 {
>  		clocks = <&divclk4>;
>  	};
>  };
> +
> +serial@898000 {
> +	label = "BT-UART";

label is generally intended for when you need to identify the physical 
connector which wouldn't apply here.

> +	status = "okay";

Don't show status in examples.

> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxosupply = <&vreg_l7a_1p8>;

Typo.

With those fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
