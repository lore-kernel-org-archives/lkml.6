Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C5CC67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBF720882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Gv786I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBF720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeGZCBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:01:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38642 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeGZCBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:01:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so6374364pgq.5;
        Wed, 25 Jul 2018 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7+Zh5Op/5HAZULzSjVbvKmGeJRf5fpRCHw7QAKZSvgc=;
        b=I+Gv786IvV/ol3CfbVTx1WMqdjeZEe1gJRzBPjJSMk63nxit54D4Aebkxq4D7oLlTw
         PUefnu/MQiKZdkUX8grMWumCp0+2/PGzExWA8uegieppZF+apLI1OSpzqUBzZ72AuMxT
         un/wfCQ8FeBtuOc/1ju7MKJIM1m+XHLQwFPjuQUyoT/4mgx9G0ZMs3KcXt1laVCJDvKL
         /1WLpJeKHqP51WAAoomDeOzqi2N46HFoN6BQygKrtuHP7GMwvGvX3qisZi6JrrsWLFv0
         hjJNB15kaFG+7l0rokNnGc1+5dLC5P/vWNAmUAzyR5bSVt89gNKD+DSzdKbDc4q/2E7a
         yHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7+Zh5Op/5HAZULzSjVbvKmGeJRf5fpRCHw7QAKZSvgc=;
        b=h7VGAcC+FQRfJbXvcdCd3Qhh6mRmUEH+JX8d3ff0Lwni3sN5F+qewT2FKM+qpvWSlj
         EKIxPPcEDNndnVUdG4nlxHzKqZevmxjDI89Tyzk9zi0NiQw/zuzg2fhTIlG5txbEiut7
         BpLh2xP2aFcBUjajc29AtuU9vpok5L6yL6ADP9lqF3cJ0q+j3NEuE2raKOOQ4B94uvzR
         U9/lKKPykkQUJbH/Ix/BCU/3m7HBlHhnXIZNsNnHzmIZwRNdMzJqH5AaFhIlDUYqYleM
         QMQYkFs4Kj8v2/UTv2qotrArzCLkItA64fnULkzdy80eXfk+jhFG+5+Btyz7CA2xy4/u
         VKbw==
X-Gm-Message-State: AOUpUlGcesh98S4oWN7GB/oyGKWeGTYq6/nP13JZ2Ojqnek7QVRe9WJB
        ISdnnwgQ26OeoHtFmOxZChE=
X-Google-Smtp-Source: AAOMgpdEsOycFtqHrvzGMTEESkQPgy/9tN5P2TRVSpl+Q/N5Dm2qX+6Gmsf1uHC/W1LbPcdpNV/5RA==
X-Received: by 2002:a62:2744:: with SMTP id n65-v6mr24407252pfn.125.1532566055419;
        Wed, 25 Jul 2018 17:47:35 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id s14-v6sm22307945pfj.105.2018.07.25.17.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 17:47:34 -0700 (PDT)
Date:   Wed, 25 Jul 2018 17:47:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v4 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180726004732.GD80336@dtor-ws>
References: <20180725073410.730-1-mylene.josserand@bootlin.com>
 <20180725073410.730-2-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725073410.730-2-mylene.josserand@bootlin.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mylène,

On Wed, Jul 25, 2018 at 09:34:08AM +0200, Mylène Josserand wrote:
> Add the support of regulator to use it as VCC source.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
>  drivers/input/touchscreen/edt-ft5x06.c             | 43 ++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> index 025cf8c9324a..48e975b9c1aa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> @@ -30,6 +30,7 @@ Required properties:
>  Optional properties:
>   - reset-gpios: GPIO specification for the RESET input
>   - wake-gpios:  GPIO specification for the WAKE input
> + - vcc-supply:  Regulator that supplies the touchscreen
>  
>   - pinctrl-names: should be "default"
>   - pinctrl-0:   a phandle pointing to the pin settings for the
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 1e18ca0d1b4e..dcde719094f7 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -39,6 +39,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  #include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define WORK_REGISTER_THRESHOLD		0x00
>  #define WORK_REGISTER_REPORT_RATE	0x08
> @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
>  	struct touchscreen_properties prop;
>  	u16 num_x;
>  	u16 num_y;
> +	struct regulator *vcc;
>  
>  	struct gpio_desc *reset_gpio;
>  	struct gpio_desc *wake_gpio;
> @@ -963,6 +965,13 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
>  	}
>  }
>  
> +static void edt_ft5x06_disable_regulator(void *arg)
> +{
> +	struct edt_ft5x06_ts_data *data = arg;
> +
> +	regulator_disable(data->vcc);
> +}
> +
>  static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  					 const struct i2c_device_id *id)
>  {
> @@ -991,6 +1000,28 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  
>  	tsdata->max_support_points = chip_data->max_support_points;
>  
> +	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> +	if (IS_ERR(tsdata->vcc)) {
> +		error = PTR_ERR(tsdata->vcc);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev, "failed to request regulator: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	error = regulator_enable(tsdata->vcc);
> +	if (error < 0) {
> +		dev_err(&client->dev, "failed to enable vcc: %d\n",
> +			error);
> +		return error;
> +	}

It is better to put the chip into reset and then power up the regulatori
and take it out of the reset, rather than power up and then toggle reset
on and off.

> +
> +	error = devm_add_action_or_reset(&client->dev,
> +					 edt_ft5x06_disable_regulator,
> +					 tsdata);
> +	if (error)
> +		return error;
> +
>  	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
>  						     "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(tsdata->reset_gpio)) {
> @@ -1120,9 +1151,12 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
>  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
>  
>  	if (device_may_wakeup(dev))
>  		enable_irq_wake(client->irq);
> +	else
> +		regulator_disable(tsdata->vcc);
>  
>  	return 0;
>  }
> @@ -1130,9 +1164,18 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> +	int ret;
>  
>  	if (device_may_wakeup(dev))
>  		disable_irq_wake(client->irq);
> +	else {
> +		ret = regulator_enable(tsdata->vcc);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable vcc: %d\n", ret);
> +			return ret;
> +		}
> +	}

I believe I mentioned in other review that once you powered up the
device, you need to restore its settings, include switching to factory
mode, if it was in factory mode, and restoring threshold/gain/offset
settings.

Thanks.

-- 
Dmitry
