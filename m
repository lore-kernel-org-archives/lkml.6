Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE56ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDA52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRzmHeov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDA52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeGRRAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:00:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34712 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbeGRRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:00:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so4633262ljk.1;
        Wed, 18 Jul 2018 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsGy85DGvKFCn1Dke+H0Q6oaO5iRas06Ccb+uEnxvUk=;
        b=MRzmHeovsSudWiV4Up89hdMROWv/+LOVbOv9vt+BneL+GV7CFqioeN2TNOj9IMPWqj
         0DVhETHS6jukDpW8CZKQInwUnOtaKB3hsEFCRd6EefwTl79b2o3Q7qvJUehbKGKeIVr4
         NzGl7q/Xo89Q0YruMdRskcM77Sq6JflC1SxkPFfAseqWxkBDk5rIM5x3fMo/asUoP2Sm
         e4njoqnUJ9Np4wWjokiIO9zjWsYGE7DXD+GMLZpz3zACVgohZqfeyw/Gmv6ch5vV7LIl
         Ykev9izjp8y4T7Jqob8c6+nOJKbGHHFOwz89oJNuHR0lPl0AJya90aY2xEHwg2HeYOya
         pK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WsGy85DGvKFCn1Dke+H0Q6oaO5iRas06Ccb+uEnxvUk=;
        b=aBaLIgkt86xSNKk8Xwmm5J2puBzkh37hvrccYqnCFFo80ypR0di0ZKCCSlAQAwpke6
         JmE06gSo+1NFO5wNdw6LId3NtPbcijpgEAlNVOblRZ4zEP9PV5DHBZk5vugonlsy0WdK
         j0dFEFnAih4/RGkpiuL4A7XPwI34Cv38VFnYgGPwaRJS0LhdFca81mFtFyXmKt8HdBij
         rCEr0ZqrkgC8wJnNRJE6jhEohuGxW6/1cTWLQ72CTzxhl3HuMVSlbOhaN6yPhGOKaGoM
         EtG85z/mDIiDvtXRRBis+/YBX/Q9tfddMZlqAG4WBor8WU0NFCUQYMki5TzxJdVugLnT
         A1ng==
X-Gm-Message-State: AOUpUlHjPKP2Nxtfofmq/5eZWaK9GoRdLRO61LLmyl9xQSG4PgaGczq3
        9YuMmJ5T/RkqjakQKQqVDHI=
X-Google-Smtp-Source: AAOMgpfqgAk2z7dsL82DHEqFxVzwqGAC64m//1Bsa6w74cI7YtvrWYG0PtqiXeTNPogNIQQxnCBQVw==
X-Received: by 2002:a2e:6505:: with SMTP id z5-v6mr4906611ljb.62.1531930892812;
        Wed, 18 Jul 2018 09:21:32 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.gmail.com with ESMTPSA id f10-v6sm678966ljf.64.2018.07.18.09.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:21:32 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Nick Dyer <nick@shmanahar.org>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: atmel_mxt_ts: Add support for  optional regulators.
Date:   Wed, 18 Jul 2018 18:21:30 +0200
Message-ID: <2353752.vfvcsHJLR6@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.15.0-24-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180717210005.GA21416@hairyalien>
References: <1531851386-17840-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <1531851386-17840-2-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180717210005.GA21416@hairyalien>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 17, 2018 10:00:05 PM CEST Nick Dyer wrote:
> On Tue, Jul 17, 2018 at 08:16:25PM +0200, Pawe=C5=82 Chmiel wrote:
> > This patch adds optional regulators, which can be used to power
> > up touchscreen. After enabling regulators, we need to wait 150msec.
> > This value is taken from official driver.
> >=20
> > It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v1:
> >   - Enable regulators only if reset_gpio is present.
> >   - Switch from devm_regulator_get_optional to devm_regulator_get
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 46 ++++++++++++++++++++++++=
++++++--
> >  1 file changed, 44 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/t=
ouchscreen/atmel_mxt_ts.c
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
> > =20
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
> > =20
> >  	/* Cached parameters from object table */
> >  	u16 T5_address;
> > @@ -3076,6 +3079,22 @@ static int mxt_probe(struct i2c_client *client, =
const struct i2c_device_id *id)
> >  		return error;
> >  	}
> > =20
> > +	data->vdd_reg =3D devm_regulator_get(&client->dev, "vdd");
> > +	if (IS_ERR(data->vdd_reg)) {
> > +		error =3D PTR_ERR(data->vdd_reg);
> > +		dev_err(&client->dev, "Failed to get vdd regulator: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> > +	data->avdd_reg =3D devm_regulator_get(&client->dev, "avdd");
> > +	if (IS_ERR(data->avdd_reg)) {
> > +		error =3D PTR_ERR(data->avdd_reg);
> > +		dev_err(&client->dev, "Failed to get avdd regulator: %d\n",
> > +			error);
> > +		return error;
> > +	}
> > +
> >  	error =3D devm_request_threaded_irq(&client->dev, client->irq,
> >  					  NULL, mxt_interrupt, IRQF_ONESHOT,
> >  					  client->name, data);
> > @@ -3087,7 +3106,26 @@ static int mxt_probe(struct i2c_client *client, =
const struct i2c_device_id *id)
> >  	disable_irq(client->irq);
> > =20
> >  	if (data->reset_gpio) {
> > -		msleep(MXT_RESET_GPIO_TIME);
> > +		error =3D regulator_enable(data->vdd_reg);
> > +		if (error) {
> > +			dev_err(&client->dev, "Failed to enable vdd regulator: %d\n",
> > +				error);
> > +			return error;
> > +		}
> > +
> > +		error =3D regulator_enable(data->avdd_reg);
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
>=20
> Hi Pawel-
>=20
> I see you've borrowed some of the logic from the patch I wrote a while
> back (see https://github.com/ndyer/linux/commit/8e9687e41ed062 )
Actually, i was looking at https://github.com/atmel-maxtouch/linux/blob/max=
touch-v3.14/drivers/input/touchscreen/atmel_mxt_ts.c (and didn't saw Your p=
atch till now).
Are You going to submit it? (it has more functionalities - for example susp=
end mode read from device tree).
>=20
> The correct behaviour according to Atmel should be:
>=20
> * Make RESET zero
> * Bring up regulators
> * Wait for a period to settle (150 msec)
> * Release RESET
> * Wait for 100 msec whilst device gets through bootloader
> * Wait for CHG line assert before reading info block
>=20
> I can't see the first and last steps in your patch at present.
About first step - reset_gpio is readed by using devm_gpiod_get_optional wi=
th GPIOD_OUT_LOW flag, so i think (but might be wrong)  that we don't need =
to set this gpio value again to 0 before enabling regulators,
since currently only place where reset_gpio is used is in driver probe (in =
Your patch it is used in other cases/places - for example in mxt_start/stop=
, when we enable regulators).
About missing wait after releasing reset, shouldn't this be separate patch =
(since currently driver is not doing it)? I can prepare it and send with ot=
her in next version.

Thanks for feedback
>=20
> The only downside with this approach is that there are a lot of
> delays during driver probe, but I believe the asynchronous probe stuff
> that's landed since I wrote the original patch should address that.
>=20
> cheers
>=20
> Nick
>=20
> >  	}
> > @@ -3116,6 +3154,10 @@ static int mxt_remove(struct i2c_client *client)
> >  	struct mxt_data *data =3D i2c_get_clientdata(client);
> > =20
> >  	disable_irq(data->irq);
> > +	if (data->reset_gpio) {
> > +		regulator_disable(data->avdd_reg);
> > +		regulator_disable(data->vdd_reg);
> > +	}
> >  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
> >  	mxt_free_input_device(data);
> >  	mxt_free_object_table(data);
>=20


