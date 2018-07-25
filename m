Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD0C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7270320882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xzzydahS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7270320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeGYLJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeGYLJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:09:38 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A442088E;
        Wed, 25 Jul 2018 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532512720;
        bh=8Fd9/JrmAfkPvDU3YCr18EBdzislEhZnL6j2lWeshnk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=xzzydahSIPk18yOGA+SfyqFG8YRxuuK62dtjxdCb1wHGTtuPj2zfn0Y0GMYoiR/hA
         5wm6e3HoKb67gqcAlqxLnB9TPkHow+fd+DqxHqKI2Plv1/d0NyhYEokvZIzKnI4rjS
         Vmogdg5NKJkCU1tbOzfDC+fI9NZmvpQfRtv2p72I=
Received: by mail-wm0-f45.google.com with SMTP id y9-v6so4550690wma.5;
        Wed, 25 Jul 2018 02:58:39 -0700 (PDT)
X-Gm-Message-State: AOUpUlHR5o8BrUG8i6DwJ7eDXXuL0n66YJ8fTyk+fsKqrYCG1d8YcaRF
        OamGfn+9n27oGh92Yvt/qVpZAvKnnqmOMowMs7s=
X-Google-Smtp-Source: AAOMgpcKCRAeLCX/zfM7Hb89SyRRNVUAHlvTTv+NxyDR2+0IahYFhUnws8VWQ9snHh/NA4XbNxBJYvXE7xLz4rOYk24=
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr4499206wmm.117.1532512718266;
 Wed, 25 Jul 2018 02:58:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 02:58:37
 -0700 (PDT)
In-Reply-To: <20180723135117.2090-1-angus@akkea.ca>
References: <20180723135117.2090-1-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 25 Jul 2018 11:58:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Message-ID: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
Subject: Re: [PATCH] bq25890_charger.c : add the BQ25896 part
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus.ainslie@puri.sm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July 2018 at 15:51, Angus Ainslie <angus@akkea.ca> wrote:
> Add some debugging to be able to check the proper initialization
> of the BQ25896 part.

Hi,

This should be split into separate patchset. Do not mix two features
in one commit.

> Enable the BQ25896 part.
>
> Add 2 new parameters "voltage_now" and "model_name".
>
> Signed-off-by: Angus Ainslie <angus.ainslie@puri.sm>

Your signed-off-by does not match From address.

> ---
>  drivers/power/supply/bq25890_charger.c | 68 ++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 8e2c41ded171..32cdae15ce40 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -32,6 +32,7 @@
>  #define BQ25890_IRQ_PIN                        "bq25890_irq"
>
>  #define BQ25890_ID                     3
> +#define BQ25896_ID                     0
>
>  enum bq25890_fields {
>         F_EN_HIZ, F_EN_ILIM, F_IILIM,                                /* Reg00 */
> @@ -153,8 +154,8 @@ static const struct reg_field bq25890_reg_fields[] = {
>         [F_CONV_RATE]           = REG_FIELD(0x02, 6, 6),
>         [F_BOOSTF]              = REG_FIELD(0x02, 5, 5),
>         [F_ICO_EN]              = REG_FIELD(0x02, 4, 4),
> -       [F_HVDCP_EN]            = REG_FIELD(0x02, 3, 3),
> -       [F_MAXC_EN]             = REG_FIELD(0x02, 2, 2),
> +       [F_HVDCP_EN]            = REG_FIELD(0x02, 3, 3),  // reserved on BQ25896
> +       [F_MAXC_EN]             = REG_FIELD(0x02, 2, 2),  // reserved on BQ25896
>         [F_FORCE_DPM]           = REG_FIELD(0x02, 1, 1),
>         [F_AUTO_DPDM_EN]        = REG_FIELD(0x02, 0, 0),
>         /* REG03 */
> @@ -163,6 +164,7 @@ static const struct reg_field bq25890_reg_fields[] = {
>         [F_OTG_CFG]             = REG_FIELD(0x03, 5, 5),
>         [F_CHG_CFG]             = REG_FIELD(0x03, 4, 4),
>         [F_SYSVMIN]             = REG_FIELD(0x03, 1, 3),
> +       /* MIN_VBAT_SEL on BQ25896 */
>         /* REG04 */
>         [F_PUMPX_EN]            = REG_FIELD(0x04, 7, 7),
>         [F_ICHG]                = REG_FIELD(0x04, 0, 6),
> @@ -181,7 +183,7 @@ static const struct reg_field bq25890_reg_fields[] = {
>         [F_CHG_TMR]             = REG_FIELD(0x07, 1, 2),
>         [F_JEITA_ISET]          = REG_FIELD(0x07, 0, 0),
>         /* REG08 */
> -       [F_BATCMP]              = REG_FIELD(0x08, 6, 7),
> +       [F_BATCMP]              = REG_FIELD(0x08, 6, 7), // 5-7 on BQ25896

So this field is different on BQ25896...

>         [F_VCLAMP]              = REG_FIELD(0x08, 2, 4),
>         [F_TREG]                = REG_FIELD(0x08, 0, 1),
>         /* REG09 */
> @@ -195,12 +197,13 @@ static const struct reg_field bq25890_reg_fields[] = {
>         [F_PUMPX_DN]            = REG_FIELD(0x09, 0, 0),
>         /* REG0A */
>         [F_BOOSTV]              = REG_FIELD(0x0A, 4, 7),
> +       /* PFM_OTG_DIS 3 on BQ25896 */
>         [F_BOOSTI]              = REG_FIELD(0x0A, 0, 2),
>         /* REG0B */
>         [F_VBUS_STAT]           = REG_FIELD(0x0B, 5, 7),
>         [F_CHG_STAT]            = REG_FIELD(0x0B, 3, 4),
>         [F_PG_STAT]             = REG_FIELD(0x0B, 2, 2),
> -       [F_SDP_STAT]            = REG_FIELD(0x0B, 1, 1),
> +       [F_SDP_STAT]            = REG_FIELD(0x0B, 1, 1), // reserved on BQ25896
>         [F_VSYS_STAT]           = REG_FIELD(0x0B, 0, 0),
>         /* REG0C */
>         [F_WD_FAULT]            = REG_FIELD(0x0C, 7, 7),
> @@ -401,6 +404,18 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>                 val->strval = BQ25890_MANUFACTURER;
>                 break;
>
> +       case POWER_SUPPLY_PROP_MODEL_NAME:
> +               bq->chip_id = bq25890_field_read(bq, F_PN);

Why do you need to read it again?

> +
> +               if (bq->chip_id == BQ25890_ID)
> +                       val->strval = "BQ25890";
> +               else if (bq->chip_id == BQ25896_ID)
> +                       val->strval = "BQ25896";
> +               else
> +                       val->strval = "UNKNOWN";
> +
> +               break;
> +
>         case POWER_SUPPLY_PROP_ONLINE:
>                 val->intval = state.online;
>                 break;
> @@ -453,6 +468,20 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>                 val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
>                 break;
>
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               if (!state.online) {
> +                       val->intval = 0;
> +                       break;
> +               }

This looks like unrelated change. Please split it.

> +
> +               ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
> +               val->intval = 2304000 + ret * 20000;
> +               break;
> +
>         default:
>                 return -EINVAL;
>         }
> @@ -608,30 +637,43 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>         };
>
>         ret = bq25890_chip_reset(bq);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "BQ259x reset failed %d\n", ret);

"BQ259x" prefix is not needed.

>                 return ret;
> +       }
>
>         /* disable watchdog */
>         ret = bq25890_field_write(bq, F_WD, 0);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "disabling watchdog failed %d\n", ret );

1. Run checkpatch to point coding style issues and fix them.
2. Start string with capital letter.

>                 return ret;
> +       }
>
>         /* initialize currents/voltages and other parameters */
>         for (i = 0; i < ARRAY_SIZE(init_data); i++) {
>                 ret = bq25890_field_write(bq, init_data[i].id,
>                                           init_data[i].value);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       dev_dbg(bq->dev, "writing init data failed %d\n",
> +                               ret);

Start string with capital letter.

>                         return ret;
> +               }
>         }
>
>         /* Configure ADC for continuous conversions. This does not enable it. */
>         ret = bq25890_field_write(bq, F_CONV_RATE, 1);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Config ADC failed %d\n",
> +                       ret);

Line break looks unneeded. Run checkpatch.

>                 return ret;
> +       }
>
>         ret = bq25890_get_chip_state(bq, &state);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "BQ2589x get state failed %d\n",
> +                       ret);

Prefix is not needed.

>                 return ret;
> +       }
>
>         mutex_lock(&bq->lock);
>         bq->state = state;
> @@ -644,12 +686,14 @@ static enum power_supply_property bq25890_power_supply_props[] = {
>         POWER_SUPPLY_PROP_MANUFACTURER,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_HEALTH,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
>
>  static char *bq25890_charger_supplied_to[] = {
> @@ -767,6 +811,9 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
>                         if (props[i].optional)
>                                 continue;
>
> +                       printk( KERN_ERR "unable to read property %d %s\n", ret
> +                               , props[i].name );

Remove it. And again - run checkpatch.

> +
>                         return ret;
>                 }
>
> @@ -840,7 +887,7 @@ static int bq25890_probe(struct i2c_client *client,
>                 return bq->chip_id;
>         }
>
> -       if (bq->chip_id != BQ25890_ID) {
> +       if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25896_ID)) {
>                 dev_err(dev, "Chip with ID=%d, not supported!\n", bq->chip_id);
>                 return -ENODEV;
>         }
> @@ -966,6 +1013,7 @@ MODULE_DEVICE_TABLE(i2c, bq25890_i2c_ids);
>
>  static const struct of_device_id bq25890_of_match[] = {
>         { .compatible = "ti,bq25890", },
> +       { .compatible = "ti,bq25896", },

Document the compatible. If you run checkpatch.... it would point it.

Best regards,
Krzysztof
