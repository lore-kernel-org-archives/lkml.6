Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466D0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002F620866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002F620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeIKBFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:05:40 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41369 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIKBFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:05:40 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so42694230oiw.8;
        Mon, 10 Sep 2018 13:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OJHugWp3ksLOc2/gKI6bAw4wN4COKIjY0fXobxXKc4w=;
        b=E77bEM/YbV8CF3riQjj9Bm2+PUtLwn4FCPT7W5O+Pq8pUSTI0BRx9jTRDSogTbzgwO
         FLArAwtgiO+WMu/dG7I6bCL5Ije0tNwBEADx89h8+rbqsbBjO9IwoAsy8etPjmfy0hQl
         7TLCv3gkLSqQwz44rTd4/jE+kUzjxRTz2ovRaUx4fJLFS3NXbiqz9aHeGM9CMQxC5Rsm
         fKTk5Jki/rnJwHGeWRNFGqL08IR05D7Icm6VxNsV0b1CLWv0BVLHKxCllUxV929kd/1h
         fB6r9fWfrxf/Z/tPgbvg3i5trxX1/gOndI29k3jplWwyuHrepfwTD0z/oxwo4NiCmH2w
         KPrQ==
X-Gm-Message-State: APzg51AwjYld+XAHmHsA5NKz0aSYhZ9xaXww71qI5uOSRB4lK1FFjl61
        WjX90FmcnXaJRY2SBX72aQ==
X-Google-Smtp-Source: ANB0Vdbf6X46VnB8BKBTyDI6Z3G5mUuDtmHm1PTaZtLSyg4fL5Nf3jcVECZGBHfjIbtBCv+e9bsgVw==
X-Received: by 2002:aca:1802:: with SMTP id h2-v6mr23108448oih.353.1536610196271;
        Mon, 10 Sep 2018 13:09:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i132-v6sm25148001oif.20.2018.09.10.13.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:09:55 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:09:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: gyro: add device tree support for fxas21002c
Message-ID: <20180910200955.GA27927@bogus>
References: <20180904200434.10442-1-afonsobordado@az8.co>
 <20180904200434.10442-2-afonsobordado@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904200434.10442-2-afonsobordado@az8.co>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:04:32PM +0100, Afonso Bordado wrote:
> This patch adds device tree support for the fxas21002c driver, including
> bindings.
> 
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 35 +++++++++++++++++++

Please split bindings to separate patch.

>  drivers/iio/gyro/fxas21002c.c                 | 10 +++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> new file mode 100644
> index 000000000000..5f02cfa5ac82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> @@ -0,0 +1,35 @@
> +* Freescale FXAS21002C Digital Angular Rate Gyroscope
> +
> +Required properties:
> +
> +  - compatible: must be "fsl,fxas21002c"
> +  - reg : the I2C address of the sensor
> +
> +Optional properties:
> +
> +  - interrupt-parent	: phandle to the parent interrupt controller.
> +			  see interrupt-controller/interrupts.txt

This is implied, so drop it.

> +  - interrupts		: The first interrupt listed must be the one
> +			  connected to the INT1 pin, the second interrupt
> +			  listed must be the one connected to the INT2 pin.
> +			  The interrupts can be triggered on rising or falling
> +			  edges alike.
> +			  see interrupt-controller/interrupts.txt
> +  - vdd-supply 		: The main voltage regulator
> +  - iovdd-supply 	: The IO voltage regulator

Some space before tab on these 2 lines.

> +			  see regulator/regulator.txt
> +  - reset-gpios		: GPIO used to reset the device.
> +			  see gpio/gpio.txt.
> +  - mount-matrix	: see iio/mount-matrix.txt
> +
> +Example:
> +gyroscope@20 {
> +	compatible = "fsl,fxas21002c";
> +	reg = <0x20>;
> +	reset-gpios = <&gpio0 2 0>;
> +	vdd-supply = <&vref>;
> +	iovdd-supply = <&vref2>;
> +	interrupt-parent = <&foo>;
> +	interrupts = <0 IRQ_TYPE_EDGE_RISING>,
> +		     <1 (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)>;
> +};
> diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
> index 1668e6f3fe11..18b1f500dd3e 100644
> --- a/drivers/iio/gyro/fxas21002c.c
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -8,7 +8,6 @@
>   * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
>   * TODO:
>   *        ODR / Scale Support
> - *        Devicetree
>   *        Power management
>   *        GPIO Reset
>   *        Power supplies
> @@ -350,6 +349,14 @@ static int fxas21002c_probe(struct i2c_client *client,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id fxas21002c_of_ids[] = {
> +	{.compatible = "fsl,fxas21002c"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, fxas21002c_of_ids);
> +#endif
> +
>  static const struct i2c_device_id fxas21002c_id[] = {
>  	{"fxas21002c", ID_FXAS21002C},
>  	{}
> @@ -360,6 +367,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
>  static struct i2c_driver fxas21002c_driver = {
>  	.driver = {
>  		.name = FXAS21002C_DRV_NAME,
> +		.of_match_table = of_match_ptr(fxas21002c_of_ids),
>  	},
>  	.probe		= fxas21002c_probe,
>  	.id_table	= fxas21002c_id,
> -- 
> 2.18.0
> 
> 
