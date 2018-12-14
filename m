Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58947C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C24620656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjB9Lp5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbeLNPL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:11:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45074 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbeLNPLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:11:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so5162259ljd.12;
        Fri, 14 Dec 2018 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNlPMZAZPIWZF32M/ihviaB8zTluPGCOKOKo+dyUvAM=;
        b=mjB9Lp5kqnsUmxYtQZvb15h9sgkJgy6TZdMsMWHihWgCfSnGDWZFyNXxm0bBHpEHmM
         qy90FSq7ECtt/fKiuZxcCocxA1w3RNY9xWSySOYa9N4j6QonZ6krEgyR3t8Rx9s+cGdp
         qxrSFQIhXCzPz5WlRsNcEmdoyQvqmVZNiYLHjS6zzJ+TRTWTJM20WF6LRWyBYrXEi+eK
         CKTkq8V/8l+BEwM5de3VtyMrM5aWO45saOScV6lYNzRjirNg3FboMV2wzDDD7GDyGGoo
         4mqVVCASE8lqcq/IDxHPyogQufmpDQ5BNldaWxbdH93L9NgD9VORuKfW3gqDwkEjuDqz
         leHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNlPMZAZPIWZF32M/ihviaB8zTluPGCOKOKo+dyUvAM=;
        b=JVkiYSZvJpoxlwr2QZ15tJcBWT7Oq4/lREdof5u56XwIimnzS+fCL2HBUDlZDAXdez
         C5tGZklV/bGCLbX4gB2Wa+TW/TBBECkf65Kp1bO0DyR/eO/YKcSu7Q/IX2q3XNjU5F4y
         3SbEfMFaZR8rdLMOeRfqOkQUMDoIFVJ5CbCStxGdrzP9pPMo8r6LrKAh2ubWAlcGXm2m
         SFuS2ve0NT7kvDVB1Gz3Xp4VU3kbS7ds2Jajb6lffABqonMmCOJOHHBEMzAqs0VggMZK
         BJMUWWbenrDkeC7vTByZ/YPH0Gq6YR+LySp/FAblklNEPAOtbe5R6JiFwdKZXaMk8mIE
         rs+g==
X-Gm-Message-State: AA+aEWbYL/3ftr3f6QfItl/uALhR+uWra4IJVDNxoi69c3obtRC3X4r4
        Uk+v+T+ms21ySYwaLzEdHgQ=
X-Google-Smtp-Source: AFSGD/UCPi2PCZPzq4Z/8nuve/gAAat2LyaniOrBDpViVhgku6aL43hs14TyfMvv+srgWqjFkCJJ7A==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr2103269lji.144.1544800311896;
        Fri, 14 Dec 2018 07:11:51 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
        by smtp.gmail.com with ESMTPSA id q127-v6sm1021726ljq.45.2018.12.14.07.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 07:11:51 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] Input: atmel_mxt_ts: Add support for  optional regulators
Date:   Fri, 14 Dec 2018 16:11:49 +0100
Message-ID: <2132818.BxtBPRaDeS@acerlaptop>
In-Reply-To: <20181209042612.GD211094@dtor-ws>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com> <20181207142857.15818-2-pawel.mikolaj.chmiel@gmail.com> <20181209042612.GD211094@dtor-ws>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia niedziela, 9 grudnia 2018 05:26:12 CET Dmitry Torokhov pisze:
> On Fri, Dec 07, 2018 at 03:28:55PM +0100, Pawe=C5=82 Chmiel wrote:
> > This patch adds optional regulators, which can be used to power
> > up touchscreen. After enabling regulators, we need to wait 150msec.
> > This value is taken from official driver.
> >=20
> > It was tested on Samsung Galaxy i9000 (based on Samsung S5PV210 SOC).
> >=20
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v3:
> >   - Fix checkpatch issues
> >   - Drop sentence punctuation from subject of one of patches
> >=20
> > Changes from v2:
> >   - Move code enabling regulators into separate method,
> >     to make code more readable.
> >=20
> > Changes from v1:
> >   - Enable regulators only if reset_gpio is present.
> >   - Switch from devm_regulator_get_optional to devm_regulator_get
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 65 +++++++++++++++++++++---
> >  1 file changed, 59 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/t=
ouchscreen/atmel_mxt_ts.c
> > index d3aacd534e9c..1dc8ad0da5af 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/of.h>
> >  #include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <asm/unaligned.h>
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
> > @@ -323,6 +324,8 @@ struct mxt_data {
> >  	struct t7_config t7_cfg;
> >  	struct mxt_dbg dbg;
> >  	struct gpio_desc *reset_gpio;
> > +	struct regulator *vdd_reg;
> > +	struct regulator *avdd_reg;
> > =20
> >  	/* Cached parameters from object table */
> >  	u16 T5_address;
> > @@ -3038,6 +3041,38 @@ static const struct dmi_system_id chromebook_T9_=
suspend_dmi[] =3D {
> >  	{ }
> >  };
> > =20
> > +static int mxt_regulator_enable(struct mxt_data *data)
> > +{
> > +	int error;
> > +
> > +	if (data->reset_gpio) {
> > +		error =3D regulator_enable(data->vdd_reg);
> > +		if (error) {
> > +			dev_err(&data->client->dev,
> > +				"Failed to enable vdd regulator: %d\n", error);
> > +			return error;
> > +		}
> > +
> > +		error =3D regulator_enable(data->avdd_reg);
> > +		if (error) {
> > +			dev_err(&data->client->dev,
> > +				"Failed to enable avdd regulator: %d\n", error);
>=20
> This leaves vdd regulator enabled.
Will be fixed in v5 version (will be today)
Thanks for review.
>=20
> Thanks.
>=20
>=20




