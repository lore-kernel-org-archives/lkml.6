Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41227ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33F720839
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH2PpzBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33F720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeGQQlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:41:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46445 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeGQQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:41:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id l16-v6so1233254lfc.13;
        Tue, 17 Jul 2018 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kMbL3pZFHw64cRFaldLcsAQ8wnft6+aFnRq3/HWgknA=;
        b=jH2PpzBwQyQnKtgFTvZqmR0aBUxeXKl/8rlcnGWuJFEg0sZQFCIFMmHrQ3rY+NHlCD
         UHFDt9wbRbLTjxdHixD+9t/hBUIXYHlBFFPGK3wRk8/m39zio2tjw0bwWNVksrxM982c
         RK/D3MzuHifi9LoExCjtJOxI/s6PPP3JiGZSO/EWDTs+UxJioXlOcBQoSJyrPu0iQk7t
         YBTg9f5izq07QMuN1ZpysgdEEn0lbhKiiqM3IxLjYY9GxsOLTc2gJ/y/99Dyr4tf4yc/
         dhUf+zm85rMk5vRHvtt2KUEZgiAoeKgwhKzF3Un1bn3w5Z70z8OjkvHb/MsBnkSuM8wR
         Fw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kMbL3pZFHw64cRFaldLcsAQ8wnft6+aFnRq3/HWgknA=;
        b=VccmUR45fXRhPkw49fzVJZCm2meuD7/Ji9BZaXbAvhSZMWEy2sSAakMO0ARteAOhIF
         IuHr7KPBjRWPnxT/DMg8S7vzJm7pSUgH8xX/xd8L7QnfspT4hBcyv2drCH9G0MQwp+FS
         Eyj/Ro6WROhYsLy7w1dTpIFukEEBUQmiHbM8ICSeVhZZuJviRrbJipvI74BJVn3x3CzF
         kBvlC1t/q8oDzQo8h3h/Cq94Y7KFQ3OTXwAkgbfxwAEi3HhQBxAO5uSCECVcNFWUCJKj
         AD8Ao7J/5/sKlYVTfSINq6vDY2nk2Zak3h3fa3/WjlWnnHYKwvAmWpkUy46wpvWbrj4D
         fglQ==
X-Gm-Message-State: AOUpUlFADYoXLv8l+83hMpSEL1KUHA4oxRdZxkul7Is28Fh4IMYK/2Zx
        2Fk7g4FceWsbeZcH5kdFotY=
X-Google-Smtp-Source: AAOMgpfpO6n4CZFf+BwclD7HwlwKSE5HzMmoJI6FfFl7VKDH9olGR0UJTO+Ly/2LMyrz5MlUcHAJ9Q==
X-Received: by 2002:a19:d54c:: with SMTP id m73-v6mr1611456lfg.27.1531843690932;
        Tue, 17 Jul 2018 09:08:10 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.gmail.com with ESMTPSA id 14-v6sm220816ljc.74.2018.07.17.09.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 09:08:10 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts: Add support for optional regulators.
Date:   Tue, 17 Jul 2018 18:08:09 +0200
Message-ID: <2367651.5rnNy4vni7@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.15.0-24-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180715102547.afu57hbjcbizn3kc@penguin>
References: <1531506608-24479-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1531506608-24479-2-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180715102547.afu57hbjcbizn3kc@penguin>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, July 15, 2018 10:25:47 AM CEST Dmitry Torokhov wrote:
> Hi Pawe=C5=82,
>=20
> On Fri, Jul 13, 2018 at 08:30:07PM +0200, Pawe=C5=82 Chmiel wrote:
> > This patch adds optional regulators, which can be used to power
> > up touchscreen. After enabling regulators, we need to wait 150msec.
> > This value is taken from official driver.
> >=20
> > It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 45 ++++++++++++++++++++++++=
++++++++
> >  1 file changed, 45 insertions(+)
> >=20
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/t=
ouchscreen/atmel_mxt_ts.c
> > index 54fe190fd4bc..a7625ec8fb9f 100644
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
> > @@ -198,6 +199,7 @@ enum t100_type {
> >  #define MXT_RESET_INVALID_CHG	100	/* msec */
> >  #define MXT_RESET_TIME		200	/* msec */
> >  #define MXT_RESET_TIMEOUT	3000	/* msec */
> > +#define MXT_REGULATOR_DELAY	150	/* msec */
> >  #define MXT_CRC_TIMEOUT		1000	/* msec */
> >  #define MXT_FW_RESET_TIME	3000	/* msec */
> >  #define MXT_FW_CHG_TIMEOUT	300	/* msec */
> > @@ -310,6 +312,8 @@ struct mxt_data {
> >  	struct t7_config t7_cfg;
> >  	struct mxt_dbg dbg;
> >  	struct gpio_desc *reset_gpio;
> > +	struct regulator *vdd_reg;
> > +	struct regulator *avdd_reg;
> > =20
> >  	/* Cached parameters from object table */
> >  	u16 T5_address;
> > @@ -3076,6 +3080,40 @@ static int mxt_probe(struct i2c_client *client, =
const struct i2c_device_id *id)
> >  		return error;
> >  	}
> > =20
> > +	data->vdd_reg =3D devm_regulator_get_optional(&client->dev, "vdd");
> > +	if (IS_ERR(data->vdd_reg)) {
> > +		error =3D PTR_ERR(data->vdd_reg);
> > +		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> > +	if (data->vdd_reg) {
> > +		error =3D regulator_enable(data->vdd_reg);
> > +		if (error) {
> > +			dev_err(&client->dev, "Failed to enable vdd regulator: %d\n",
> > +				error);
> > +			return error;
> > +		}
> > +	}
> > +
> > +	data->avdd_reg =3D devm_regulator_get_optional(&client->dev, "avdd");
> > +	if (IS_ERR(data->avdd_reg)) {
> > +		error =3D PTR_ERR(data->avdd_reg);
> > +		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> > +	if (data->avdd_reg) {
>=20
> devm_regulator_get_optional() does not return NULL for regulators
> not present in device tree, but rather -ENOENT, so this code is not
> correct; neither is the simple IS_ERR() check above.
>=20
> Moreover, the optional regulators should be used when there is a part of
> IP block that can be optionally powered up, but the device can work
> (with limited functionality) even when it is powered down. They should
> not be used in cases when supplies are mandatory (such as vdd/avdd) but
> may not be exposed to the kernel by the firmware.
>=20
> Simply use devm_regulator_get() and rely on the fact that on fully
> constrained system you will get a dummy regulator.
>=20
> > +		error =3D regulator_enable(data->avdd_reg);
> > +		if (error) {
> > +			dev_err(&client->dev, "Failed to enable avdd regulator: %d\n",
> > +				error);
> > +			return error;
> > +		}
> > +	}
> > +
> >  	error =3D devm_request_threaded_irq(&client->dev, client->irq,
> >  					  NULL, mxt_interrupt, IRQF_ONESHOT,
> >  					  client->name, data);
> > @@ -3086,6 +3124,9 @@ static int mxt_probe(struct i2c_client *client, c=
onst struct i2c_device_id *id)
> > =20
> >  	disable_irq(client->irq);
> > =20
> > +	if (!IS_ERR(data->vdd_reg) || !IS_ERR(data->avdd_reg))
> > +		msleep(MXT_REGULATOR_DELAY);
> > +
> >  	if (data->reset_gpio) {
>=20
> I think you should require that if regulators are exposed then reset
> gpio should also be present to ensure proper power up timings.

Thanks for comments. I'll prepare v2 version with those changes applied.
>=20
> >  		msleep(MXT_RESET_GPIO_TIME);
> >  		gpiod_set_value(data->reset_gpio, 1);
> > @@ -3116,6 +3157,10 @@ static int mxt_remove(struct i2c_client *client)
> >  	struct mxt_data *data =3D i2c_get_clientdata(client);
> > =20
> >  	disable_irq(data->irq);
> > +	if (!IS_ERR(data->avdd_reg))
> > +		regulator_disable(data->avdd_reg);
> > +	if (!IS_ERR(data->vdd_reg))
> > +		regulator_disable(data->vdd_reg);
> >  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
> >  	mxt_free_input_device(data);
> >  	mxt_free_object_table(data);
>=20
> Thanks.
>=20
>=20


