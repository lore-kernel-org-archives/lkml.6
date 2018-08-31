Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1529AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B2F2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICIwExSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B2F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeHaTwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:52:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42402 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbeHaTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:52:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id z11-v6so10321673lff.9;
        Fri, 31 Aug 2018 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ytFtLO5hv6qipovxQQb3Gyd1eldqDpAulvDbodojiw=;
        b=ICIwExSM/D5kMUsmk5AfGjHujygNgGs533WkSjlfwN5ZlDzrbhLD6oISma+PX/sSx1
         lOTzLENzPMXg7gQ8R72M6I9T0UYiVx1W0RRp7jscyU5BU4RIHge5/XKXVwwDSLUKgfDF
         8Ak+pBuFmxtLtmFugy/3ks6DZR01T41KNWRZDDOXUZMKozWYZCi9LhTD5FXB7g++qhRA
         t58X3e+xv5GLvKfk9Awvi1uN+2UyU0V0dIyBZiYMCBp6zr1eyK9PhGs3xqYP2/llW27i
         od70KoTynVmhFhfVxsvQ2B7abLXntXNWciApzQ15bFVoHcPHi/V9y12VINHxn+yp8bMi
         LPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ytFtLO5hv6qipovxQQb3Gyd1eldqDpAulvDbodojiw=;
        b=VGhd432Ptssee1+aBZ2dqGrZ8zYtI1PvAZ9O493d9l5+9xMDMpozDnXxs3EMFFtqbU
         usZuBMcLbHTkk73XN1m7/CVCoTfDV1N6EGHAagT8vDu+jUeWc12Ck9k1ZWAhSdGrTKCN
         aWf9oyWWhDdLLwrp/dnsz/7TvVTYyIt/E3TDRTjYkuf4aRGBHgs2cTMaNtzZdpjqXUIZ
         lrmf6jtIylbo4JYGDQ5lMcPNOOp7MaiB90BWTv4alxeWxUylLCLilBuClvVaV+jRkBWd
         /kJdikrwRZjE+GQMVNsvmchnEFfehTNpz4kfBWZDwPvXlbAN2EejqheH18XbVvdL1Khq
         /8Bg==
X-Gm-Message-State: APzg51DYOtBqnKRrN1Vop9ukO0xvnpxU+BWfcqFTzKfOh8cbme3y7dZd
        BO/Z9lOkf7o1vuTKvfxLEfk=
X-Google-Smtp-Source: ANB0Vdbr2AALO7MUoStV+XaEthw/WbBEp7Ud6e5NrSX6Rp9bAwO7OPvCtbs/2Ft6VByeKbsKDkmvug==
X-Received: by 2002:a19:5410:: with SMTP id i16-v6mr10689430lfb.122.1535730243591;
        Fri, 31 Aug 2018 08:44:03 -0700 (PDT)
Received: from localhost (89-70-31-6.dynamic.chello.pl. [89.70.31.6])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1867567lfi.23.2018.08.31.08.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:44:03 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:41:25 +0200
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: gyro: add device tree support for fxas21002c
Message-ID: <20180831154124.GB2679@arch>
References: <20180830211825.12202-1-afonsobordado@az8.co>
 <20180830211825.12202-2-afonsobordado@az8.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830211825.12202-2-afonsobordado@az8.co>
User-Agent: Mutt/1.6.2 (2016-07-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:18:23PM +0100, Afonso Bordado wrote:
> This patch adds device tree support for the fxas21002c driver, including
> bindings.
>
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> ---
>  .../bindings/iio/gyroscope/fsl,fxas21002c.txt | 35 +++++++++++++++++++
>  drivers/iio/gyro/fxas21002c.c                 | 13 ++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> new file mode 100644
> index 000000000000..2feda6da5566
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
> +  - interrupts		: The first interrupt listed must be the one
> +			  connected to the INT1 pin, the second interrupt
> +			  listed must be the one connected to the INT2 pin.
> +			  The interrupts can be triggered on rising or falling
> +			  edges alike.
> +			  see interrupt-controller/interrupts.txt
> +  - vdd-supply		: The main voltage regulator
> +  - iovdd-supply	: The IO voltage regulator
> +			  see regulator/regulator.txt
> +  - reset-gpios	: GPIO used to reset the device.
> +			  see gpio/gpio.txt.
> +  - mount-matrix	: see iio/mount-matrix.txt
> +
> +Example:
> +gyroscope@0 {

By convention if node has a reg value then the address should be
reflected in the node name as well. So i suggest renaming node to
gyroscope@20.

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
> index 261b73629544..7471e9b80010 100644
> --- a/drivers/iio/gyro/fxas21002c.c
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -8,8 +8,10 @@
>   * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
>   * TODO:
>   *        ODR / Scale Support
> - *        Devicetree
>   *        Power management
> + *        GPIO Reset
> + *        Power supplies
> + *        Mount Matrix
>   *        LowPass/HighPass Filters
>   *        Buffers
>   *        Interrupts
> @@ -345,6 +347,14 @@ static int fxas21002c_probe(struct i2c_client *client,
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
> @@ -355,6 +365,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
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
