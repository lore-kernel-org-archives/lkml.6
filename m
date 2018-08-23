Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2D1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217C72098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdUzr/9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217C72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeHWEP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:15:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34938 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWEP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:15:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id z4-v6so1700702pgv.2;
        Wed, 22 Aug 2018 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0pKP9zggLNjppmnzNPB77dk5Ydk2Nvf2pdWUSPmuYqA=;
        b=JdUzr/9k/8yM5UOPfXygVqkLNQSLQv5zTFI2tP2iUjL4KbQ5KFL+f2e64krodB6Irm
         +jTQQNMppO/qANvbddg4oOZcbWCM7oBhWvRW61dr77zCHPllox3NX8cE3XScv47C4edB
         HGzdmzqlkwAtQYXn1PZuCgqD+mfd6Ez1ynLiG/Mhp/HcI2u62oly/oq6JhpAB89PVR86
         Hvo2XpkbiTdb1OSJw1Zoh6goS/aOAP8LHwzq96WbNw1wFnzUSuNiTvtB25N75JVCc80S
         54mCiVfVp1erMPbOg0v/H8ljdZa9OewNeUxt7LbkaAv1uLsUOb51OHXZJGZHS1mjCLb8
         +zzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0pKP9zggLNjppmnzNPB77dk5Ydk2Nvf2pdWUSPmuYqA=;
        b=H6S4pmwhvE/T8NBjeK2ZmiOI4tHSJO1mZDV7Vkq+kj8z1PB3TcNZ8opAemFt+lvDT+
         ArIdQhJJTb3/eC8J3sYGpQ33IGhGtj+0mSiAVxk5/1uYnMrObybLgYMQqu0LamKtwWWG
         jGw1uk+ew+4h800Dx7GyrUDRmzDyWd6pOgLMfNYDvbOyuyjkdIYQD/moyjn/NsmpgEMw
         7A/5yZ0dcdMT8Yy5kYFRy04Xmt63BSrl00Fe7JyasVjaL4fEzTJ0/sNgVbu1L1swCDmJ
         nHu4qFpsSdOE6wjE/PvbrazhIYMQIf3yaWEuMNE8nOjs+0d0tD00pBBnMaMJtBh7J11X
         bGtQ==
X-Gm-Message-State: APzg51B01kcAqAaRJSYvdHA+eeoCARLqVM0CEwESXE4rWidt+UuWUR5V
        upwE10ooclYfeksZfAcCCTw=
X-Google-Smtp-Source: ANB0VdZXpII0Xv+QpfJUr4RkrNB5TtiDzHEXlnWJyJNUHxkBABSi0HPC4uc7BR52CRFm+qC6eD3UdA==
X-Received: by 2002:a63:cf4a:: with SMTP id b10-v6mr3738078pgj.235.1534985332030;
        Wed, 22 Aug 2018 17:48:52 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k1-v6sm3502958pfi.62.2018.08.22.17.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 17:48:50 -0700 (PDT)
Date:   Wed, 22 Aug 2018 17:48:48 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@bootlin.com,
        Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Franklin S Cooper Jr <fcooper@ti.com>
Subject: Re: [PATCH v4 1/3] Input: edt-ft5x06 - Add support for regulator
Message-ID: <20180823004848.GA200828@dtor-ws>
References: <20180725073410.730-1-mylene.josserand@bootlin.com>
 <20180725073410.730-2-mylene.josserand@bootlin.com>
 <20180726004732.GD80336@dtor-ws>
 <20180807085944.337bf20b@dell-desktop.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807085944.337bf20b@dell-desktop.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:59:44AM +0200, Mylène Josserand wrote:
> Hello Dmitry,
> 
> Thank you again for the review.
> 
> On Wed, 25 Jul 2018 17:47:32 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Mylène,
> > 
> > On Wed, Jul 25, 2018 at 09:34:08AM +0200, Mylène Josserand wrote:
> > > Add the support of regulator to use it as VCC source.
> > > 
> > > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
> > >  drivers/input/touchscreen/edt-ft5x06.c             | 43 ++++++++++++++++++++++
> > >  2 files changed, 44 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > index 025cf8c9324a..48e975b9c1aa 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > @@ -30,6 +30,7 @@ Required properties:
> > >  Optional properties:
> > >   - reset-gpios: GPIO specification for the RESET input
> > >   - wake-gpios:  GPIO specification for the WAKE input
> > > + - vcc-supply:  Regulator that supplies the touchscreen
> > >  
> > >   - pinctrl-names: should be "default"
> > >   - pinctrl-0:   a phandle pointing to the pin settings for the
> > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > > index 1e18ca0d1b4e..dcde719094f7 100644
> > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > @@ -39,6 +39,7 @@
> > >  #include <linux/input/mt.h>
> > >  #include <linux/input/touchscreen.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/regulator/consumer.h>
> > >  
> > >  #define WORK_REGISTER_THRESHOLD		0x00
> > >  #define WORK_REGISTER_REPORT_RATE	0x08
> > > @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
> > >  	struct touchscreen_properties prop;
> > >  	u16 num_x;
> > >  	u16 num_y;
> > > +	struct regulator *vcc;
> > >  
> > >  	struct gpio_desc *reset_gpio;
> > >  	struct gpio_desc *wake_gpio;
> > > @@ -963,6 +965,13 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
> > >  	}
> > >  }
> > >  
> > > +static void edt_ft5x06_disable_regulator(void *arg)
> > > +{
> > > +	struct edt_ft5x06_ts_data *data = arg;
> > > +
> > > +	regulator_disable(data->vcc);
> > > +}
> > > +
> > >  static int edt_ft5x06_ts_probe(struct i2c_client *client,
> > >  					 const struct i2c_device_id *id)
> > >  {
> > > @@ -991,6 +1000,28 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> > >  
> > >  	tsdata->max_support_points = chip_data->max_support_points;
> > >  
> > > +	tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> > > +	if (IS_ERR(tsdata->vcc)) {
> > > +		error = PTR_ERR(tsdata->vcc);
> > > +		if (error != -EPROBE_DEFER)
> > > +			dev_err(&client->dev, "failed to request regulator: %d\n",
> > > +				error);
> > > +		return error;
> > > +	}
> > > +
> > > +	error = regulator_enable(tsdata->vcc);
> > > +	if (error < 0) {
> > > +		dev_err(&client->dev, "failed to enable vcc: %d\n",
> > > +			error);
> > > +		return error;
> > > +	}  
> > 
> > It is better to put the chip into reset and then power up the regulatori
> > and take it out of the reset, rather than power up and then toggle reset
> > on and off.
> 
> okay, thanks, I will update it.
> 
> > 
> > > +
> > > +	error = devm_add_action_or_reset(&client->dev,
> > > +					 edt_ft5x06_disable_regulator,
> > > +					 tsdata);
> > > +	if (error)
> > > +		return error;
> > > +
> > >  	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
> > >  						     "reset", GPIOD_OUT_HIGH);
> > >  	if (IS_ERR(tsdata->reset_gpio)) {
> > > @@ -1120,9 +1151,12 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
> > >  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> > >  {
> > >  	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> > >  
> > >  	if (device_may_wakeup(dev))
> > >  		enable_irq_wake(client->irq);
> > > +	else
> > > +		regulator_disable(tsdata->vcc);
> > >  
> > >  	return 0;
> > >  }
> > > @@ -1130,9 +1164,18 @@ static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> > >  static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
> > >  {
> > >  	struct i2c_client *client = to_i2c_client(dev);
> > > +	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> > > +	int ret;
> > >  
> > >  	if (device_may_wakeup(dev))
> > >  		disable_irq_wake(client->irq);
> > > +	else {
> > > +		ret = regulator_enable(tsdata->vcc);
> > > +		if (ret < 0) {
> > > +			dev_err(dev, "failed to enable vcc: %d\n", ret);
> > > +			return ret;
> > > +		}
> > > +	}  
> > 
> > I believe I mentioned in other review that once you powered up the
> > device, you need to restore its settings, include switching to factory
> > mode, if it was in factory mode, and restoring threshold/gain/offset
> > settings.
> 
> Yes, I will update the driver with that but as I told you in a previous
> mail, I can't test the suspend/resume :(

I wonder if Simon or Lothar or Franklin could help us with it (CCed). If
not, then we'll have to go by review only.

Thanks.

-- 
Dmitry
