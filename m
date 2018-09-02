Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61552C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07B720856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 20:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGMP377N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07B720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeICBHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 21:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeICBHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 21:07:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5ED20837;
        Sun,  2 Sep 2018 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535921442;
        bh=SfuU+071arFGwsVUFVSh6C/1EqHzjMJmn3qPh71aCKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DGMP377Nc3mQwLZhCul1bK6zQy3LDxaF7amGEAGD1CKlIm4fvqup+wyXr6vnSC8eD
         dugG+Cmr4DbmWQkF1C/JFfc+9V4v+c60CCMyjfx8X4H8+HTxkGuHphOlEcgnjJKfQ5
         qF9d/6VSwJosDrgBsxqj1RaYHZ8xOpET4xBw10FY=
Date:   Sun, 2 Sep 2018 21:50:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: gyro: add device tree support for
 fxas21002c
Message-ID: <20180902215037.5892716d@archlinux>
In-Reply-To: <20180830211825.12202-2-afonsobordado@az8.co>
References: <20180830211825.12202-1-afonsobordado@az8.co>
        <20180830211825.12202-2-afonsobordado@az8.co>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 22:18:23 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

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
I can sort of see the logic in introducing these here, but they were
TODOs before this patch so probably nicer to push them back into patch 1.

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

