Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3DEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D18B208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 22:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk3f+xuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D18B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeHWCUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 22:20:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42515 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeHWCUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 22:20:13 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so4131823qto.9;
        Wed, 22 Aug 2018 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QfAGJQEz8m1HCXhtiyg3YXes62pxJO63Alv8xE3ihzU=;
        b=jk3f+xuDcI6GQ3CUV70pnFsFG0Fn618O9DtwL2QdG7P3a73gEZJolayxP53EXWuMlu
         j1RKTNmEDNAjOpVioHag2C7/6rpcCqNRGWStMY/tB82OXhRw13XCFU9ogj31GzwbM4Qf
         hMFb82ZrZOzlDtbpbSVmt6yXvN3WXUghnE0gyV+8HA3clS0pGoWc7agnPA7gCztZGDAY
         UgN1/M8SSzThNV3c9LZqwKyn7CIpUbLZesLQIyqJJ2OOB0CdRhIT2D3wIoODUcaG9d2E
         Vwk8RaXIPbb2sPEGIFa9Mc2/U11/B9hlHZFeUrWHLPHeOSsWbU3B70GMQPC+T4hjcmt3
         Lg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QfAGJQEz8m1HCXhtiyg3YXes62pxJO63Alv8xE3ihzU=;
        b=GRHcs5ZU3TB4fYkIGFqm24npHLcMf9Vq7JefNCmv8hIkUpG9z44vpEOoIBj27p+9q1
         CeRq/SmEsEAzNkhn3QH8YMnK5kCdsfK1kTF6/rXluknfU+GZsf0rr+efKRU8DVynVVq3
         klm8ZsTwiNjRMRq3sMXojFC5unaNbCmt4BCbSi9GPLEE/llxoS9R2GvRDf8f195nXm/9
         mxRLIaXg0LbL088hcCJKfswsX8uKl9kKNaAD4dovnvSpbCrzV0RPBXVq0o7S/A+iEDms
         NbPS4DHiC83z/yckSrh6kn2jSt66vtu3TO/u1FKYgYQ9eaApUmFksL1Xz/aiIDBY7LO5
         GXug==
X-Gm-Message-State: AOUpUlGwyu95sB8S/4LBuKgQyVE7Gl3Rr/80Fc4JHNVln1ThgPOGSSbe
        C4NohZ6z2KmPgf+gn3MOsxc=
X-Google-Smtp-Source: AA+uWPwWMdvq88HcZAYaoQi8BW5lwdmDZ6vfi8Rrv2yJ7p2bRMc8gRlaEBAsWio2pn2WwnIjPRxurQ==
X-Received: by 2002:a0c:b24c:: with SMTP id k12-v6mr52977840qve.152.1534978404158;
        Wed, 22 Aug 2018 15:53:24 -0700 (PDT)
Received: from gandalf.middle.earth.net (pool-173-48-42-19.bstnma.fios.verizon.net. [173.48.42.19])
        by smtp.gmail.com with ESMTPSA id f53-v6sm2014854qtk.40.2018.08.22.15.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 15:53:23 -0700 (PDT)
From:   "George G. Davis" <ggdavisiv@gmail.com>
X-Google-Original-From: "George G. Davis" <george_davis@mentor.com>
Date:   Wed, 22 Aug 2018 18:53:21 -0400
To:     Nick Dyer <nick@shmanahar.org>
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] Input: atmel_mxt_ts: Add support for  optional
 regulators.
Message-ID: <20180822225321.GA1364@gandalf.middle.earth.net>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1531851386-17840-2-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <20180717210005.GA21416@hairyalien>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180717210005.GA21416@hairyalien>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

On Tue, Jul 17, 2018 at 10:00:05PM +0100, Nick Dyer wrote:
> On Tue, Jul 17, 2018 at 08:16:25PM +0200, Paweł Chmiel wrote:
> > This patch adds optional regulators, which can be used to power
> > up touchscreen. After enabling regulators, we need to wait 150msec.
> > This value is taken from official driver.
> > 
> > It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> > 
> > Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v1:
> >   - Enable regulators only if reset_gpio is present.
> >   - Switch from devm_regulator_get_optional to devm_regulator_get
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 46 ++++++++++++++++++++++++++++++--
> >  1 file changed, 44 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 54fe190fd4bc..005f0fee9fc8 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/of.h>
> >  #include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/property.h>
> > @@ -194,10 +195,10 @@ enum t100_type {
> >  
> >  /* Delay times */
> >  #define MXT_BACKUP_TIME		50	/* msec */
> > -#define MXT_RESET_GPIO_TIME	20	/* msec */
> >  #define MXT_RESET_INVALID_CHG	100	/* msec */
> >  #define MXT_RESET_TIME		200	/* msec */
> >  #define MXT_RESET_TIMEOUT	3000	/* msec */
> > +#define MXT_REGULATOR_DELAY	150	/* msec */
> >  #define MXT_CRC_TIMEOUT		1000	/* msec */
> >  #define MXT_FW_RESET_TIME	3000	/* msec */
> >  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> > @@ -310,6 +311,8 @@ struct mxt_data {
> >  	struct t7_config t7_cfg;
> >  	struct mxt_dbg dbg;
> >  	struct gpio_desc *reset_gpio;
> > +	struct regulator *vdd_reg;
> > +	struct regulator *avdd_reg;
> >  
> >  	/* Cached parameters from object table */
> >  	u16 T5_address;
> > @@ -3076,6 +3079,22 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  		return error;
> >  	}
> >  
> > +	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> > +	if (IS_ERR(data->vdd_reg)) {
> > +		error = PTR_ERR(data->vdd_reg);
> > +		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> > +	data->avdd_reg = devm_regulator_get(&client->dev, "avdd");
> > +	if (IS_ERR(data->avdd_reg)) {
> > +		error = PTR_ERR(data->avdd_reg);
> > +		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> >  	error = devm_request_threaded_irq(&client->dev, client->irq,
> >  					  NULL, mxt_interrupt, IRQF_ONESHOT,
> >  					  client->name, data);
> > @@ -3087,7 +3106,26 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  	disable_irq(client->irq);
> >  
> >  	if (data->reset_gpio) {
> > -		msleep(MXT_RESET_GPIO_TIME);
> > +		error = regulator_enable(data->vdd_reg);
> > +		if (error) {
> > +			dev_err(&client->dev, "Failed to enable vdd regulator: %d\n",
> > +				error);
> > +			return error;
> > +		}
> > +
> > +		error = regulator_enable(data->avdd_reg);
> > +		if (error) {
> > +			dev_err(&client->dev, "Failed to enable avdd regulator: %d\n",
> > +				error);
> > +			return error;
> > +		}
> > +
> > +		/*
> > +		 * According to maXTouch power sequencing specification, RESET line
> > +		 * must be kept low until some time after regulators come up to
> > +		 * voltage
> > +		 */
> > +		msleep(MXT_REGULATOR_DELAY);
> >  		gpiod_set_value(data->reset_gpio, 1);
> >  		msleep(MXT_RESET_INVALID_CHG);
> 
> Hi Pawel-
> 
> I see you've borrowed some of the logic from the patch I wrote a while
> back (see https://github.com/ndyer/linux/commit/8e9687e41ed062 )

I'm actually quite interested in your work and notice that it has
languished for some time now. If you have rebased any of your earlier
work to more recent kernel versions, I'd be happy to assist with testing
and review.

--
Regards,
George

> The correct behaviour according to Atmel should be:
> 
> * Make RESET zero
> * Bring up regulators
> * Wait for a period to settle (150 msec)
> * Release RESET
> * Wait for 100 msec whilst device gets through bootloader
> * Wait for CHG line assert before reading info block
> 
> I can't see the first and last steps in your patch at present.
> 
> The only downside with this approach is that there are a lot of
> delays during driver probe, but I believe the asynchronous probe stuff
> that's landed since I wrote the original patch should address that.
> 
> cheers
> 
> Nick
> 
> >  	}
> > @@ -3116,6 +3154,10 @@ static int mxt_remove(struct i2c_client *client)
> >  	struct mxt_data *data = i2c_get_clientdata(client);
> >  
> >  	disable_irq(data->irq);
> > +	if (data->reset_gpio) {
> > +		regulator_disable(data->avdd_reg);
> > +		regulator_disable(data->vdd_reg);
> > +	}
> >  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
> >  	mxt_free_input_device(data);
> >  	mxt_free_object_table(data);
> > -- 
> > 2.7.4
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
