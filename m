Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746A3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A83C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knTE9Yww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A83C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbeGWXm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:42:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37534 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbeGWXmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:42:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so1383188pgq.4;
        Mon, 23 Jul 2018 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sfUUXdvv9Tptx8To/hQ1ZTMBxIfZR+K5Z64QP0FmQPo=;
        b=knTE9YwwmPPUhRm80Hw/8H9kFzyUIwlTySngRlohGeo7gPwuAC5Jg2xUj7lSvZGYNa
         tlHsLK99T/ZYg0sad5RiRsE5T8O0wX1QYeqDT04KZb5ubWlCaR+6yfgVkA3ujp26cpji
         t7oC62yu9Q4Sp9EfxbRp3b2uNLjrRFwo9fgMNw2fndkg8y6zcR5vv/YHDnMhAd+1setf
         +Q93/Iv4CPzFIZwFxzNCLETHv3KDPfklU4PMw9l+b7b7VqGc9GdqxdCbpIkoE9kKVXFY
         TXGU/TEqlhqzb/FKc9S4EX+ee2Nu8og2aHFVc++KuCnoilq88KCSfqvo8del2x+yE89c
         VEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sfUUXdvv9Tptx8To/hQ1ZTMBxIfZR+K5Z64QP0FmQPo=;
        b=mWmEvNcc73UW9mh1Iy/NekAT9yMOyRGbNwt42CmptQhvje0R6q5xVQEITO99qVXcQm
         DXdjeTZQK3PEuI3vu1Eioc64sjXfHkosvr2KJdlJcdZLv2kTKo14qUU7zn30IVlOLVss
         DyJ3swXAwjxPE4PlNM4SVte3qk0Bq38/Qv+gEtRzQWfeBwHrnEyTr8BzFW5H5OiasOuv
         B1fPTpW+rNgRZqrXComxKLSiYKzMZ6BV+QOgm3BEIi8bXCTiNNmknTiEm49ULvj4m+J2
         wCz5kl518BJBP3PUrfjxT9kKRst4i7U/MvxJId224Y93vLOhWUH4Dlgm6/08L+jJiGRu
         8PkA==
X-Gm-Message-State: AOUpUlFKW3I4CE2vDOVttJPNNUGUmZH11bKW7o4GkpdBsGJlR2NnN66S
        k+TRA1qjR9cre/SKj0fzd9w=
X-Google-Smtp-Source: AAOMgpcw28oy7VUptYBCC1AHVqrm4xO2Z25YRAQJwuC760+ZaZFdMj0I9McnwujmvKUIDyMnzwOx7A==
X-Received: by 2002:a65:4545:: with SMTP id x5-v6mr13877755pgr.4.1532385570114;
        Mon, 23 Jul 2018 15:39:30 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id z10-v6sm14204864pgc.9.2018.07.23.15.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:39:28 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:39:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180723223926.GL100814@dtor-ws>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
 <20180718182719.29663-2-mylene.josserand@bootlin.com>
 <20180718224645.ns7nvqxvqc6huxcz@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718224645.ns7nvqxvqc6huxcz@core>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:46:45AM +0200, Ondřej Jirman wrote:
> Hello Mylène,
> 
> On Wed, Jul 18, 2018 at 08:27:17PM +0200, Mylène Josserand wrote:
> > Add the support of regulator to use it as VCC source.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ---
> >  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
> >  drivers/input/touchscreen/edt-ft5x06.c             | 29 ++++++++++++++++++++++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > index 025cf8c9324a..48e975b9c1aa 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > @@ -30,6 +30,7 @@ Required properties:
> >  Optional properties:
> >   - reset-gpios: GPIO specification for the RESET input
> >   - wake-gpios:  GPIO specification for the WAKE input
> > + - vcc-supply:  Regulator that supplies the touchscreen
> >  
> >   - pinctrl-names: should be "default"
> >   - pinctrl-0:   a phandle pointing to the pin settings for the
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > index 1e18ca0d1b4e..aa94494b06b5 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/input/mt.h>
> >  #include <linux/input/touchscreen.h>
> >  #include <linux/of_device.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #define WORK_REGISTER_THRESHOLD		0x00
> >  #define WORK_REGISTER_REPORT_RATE	0x08
> > @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
> >  	struct touchscreen_properties prop;
> >  	u16 num_x;
> >  	u16 num_y;
> > +	struct regulator *vcc;
> >  
> >  	struct gpio_desc *reset_gpio;
> >  	struct gpio_desc *wake_gpio;
> > @@ -991,6 +993,22 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> >  
> >  	tsdata->max_support_points = chip_data->max_support_points;
> >  
> > +	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> > +	if (IS_ERR(tsdata->vcc)) {
> > +		error = PTR_ERR(tsdata->vcc);
> > +		if (error != -EPROBE_DEFER)
> > +			dev_err(&client->dev, "failed to request regulator: %d\n",
> > +				error);
> > +		return error;
> > +	}
> > +
> > +	error = regulator_enable(tsdata->vcc);
> > +	if (error < 0) {
> > +		dev_err(&client->dev, "failed to enable vcc: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> >  	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
> >  						     "reset", GPIOD_OUT_HIGH);
> >  	if (IS_ERR(tsdata->reset_gpio)) {

You need to disable regulator here. We do not have
devm_regulator_enable() (and Mark had some concerns about mixing managed
and unmanaged APIs for regulators so we can't simply introduce it),
so I'd recommend using devm_add_action_or_reset() and iunstall custom
action to turn off regulator.

> > @@ -1120,20 +1138,31 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
> >  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> >  {
> >  	struct i2c_client *client = to_i2c_client(dev);
> > +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> >  
> >  	if (device_may_wakeup(dev))
> >  		enable_irq_wake(client->irq);
> >  
> > +	regulator_disable(tsdata->vcc);
> > +
> 
> How will the touchscreen wakeup the system with interrupt if you power it off
> on suspend? Perhaps guard this with device_may_wakeup() too? 

Exactly, it should be in an "else" branch.

Thanks.

-- 
Dmitry
