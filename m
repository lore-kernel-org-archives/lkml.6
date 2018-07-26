Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE365C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6089120883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4q1Iqc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6089120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeGZILc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbeGZILb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:11:31 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377A820883;
        Thu, 26 Jul 2018 06:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532588168;
        bh=ZZx/4NLV5G12zFGh2U5mBqPfuZz4NNI/bF0mhHcXBYo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=e4q1Iqc/OiseNmwr7Z9zuQgOhU1Ft0QAqfRiL/ORofQWSkdlS8Fq7ScQTA3+RYSwe
         dTksyHeee2iu5i0ZBTkbEJ2YDUq5ou1c11Gxp3xeKWF5MddLJyMK5VBuY+BqRoPKJM
         Uqt2yMl0bWgLMIgiu6XWrOYKncOpcBLkfhTrHcnI=
Received: by mail-wr1-f49.google.com with SMTP id v14-v6so548306wro.5;
        Wed, 25 Jul 2018 23:56:08 -0700 (PDT)
X-Gm-Message-State: AOUpUlHkwAz17AEDx80hDeJcDtGawJLOM4xjrSCu2ENuapL84lTplHOg
        qfV0NTtC+gdUTt1yPN0sgX/UtKDUVIYFDQ+PdDg=
X-Google-Smtp-Source: AAOMgpdys5pQnSj0fj2EkzvSrs9x7zn0zIOhM4Ioi5dNlIrjq+g2BGjeitv5NKAP/+l+BMHPoiiEMy1cooj4QC6P1Io=
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr500798wro.279.1532588166728;
 Wed, 25 Jul 2018 23:56:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 23:56:06
 -0700 (PDT)
In-Reply-To: <20180725194630.10414-4-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-4-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 26 Jul 2018 08:56:06 +0200
X-Gmail-Original-Message-ID: <CAJKOXPegncFR1zi6ugxuE1TCYNE1oWv4d_BqUHPfhTWtedE7Kw@mail.gmail.com>
Message-ID: <CAJKOXPegncFR1zi6ugxuE1TCYNE1oWv4d_BqUHPfhTWtedE7Kw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] power: bq25890_charger.c: Add the BQ25896 part
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> The BQ25896 is almost identical the the BQ25890

Please use full stop on sentences.

This patch (strip from other addons) nicely shows that driver does not
need to do anything more to support BQ25896. These two devices are
just compatible. You do not change behavior based on matching to
compatible,

Therefore you should not add new compatible but use old/existing one.
If you wish to notify users that they should use this driver, mention
in bindings that "ti,bq25896" compatible is for BQ2589x (BQ25890.
BQ25896) devices.

Best regards,
Krzysztof

>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../bindings/power/supply/bq25890.txt         |  1 +
>  drivers/power/supply/bq25890_charger.c        | 25 +++++++++++++++----
>  2 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> index c9dd17d142ad..e98312fe6e26 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> @@ -3,6 +3,7 @@ Binding for TI bq25890 Li-Ion Charger
>  Required properties:
>  - compatible: Should contain one of the following:
>      * "ti,bq25890"
> +    * "ti,bq25896"
>  - reg: integer, i2c address of the device.
>  - ti,battery-regulation-voltage: integer, maximum charging voltage (in uV);
>  - ti,charge-current: integer, maximum charging current (in uA);
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 641f7d779e2f..f4cf2987996b 100644
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
> @@ -399,6 +402,16 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>                 val->strval = BQ25890_MANUFACTURER;
>                 break;
>
> +       case POWER_SUPPLY_PROP_MODEL_NAME:
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
> @@ -650,6 +663,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>
>  static enum power_supply_property bq25890_power_supply_props[] = {
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_ONLINE,
>         POWER_SUPPLY_PROP_HEALTH,
> @@ -851,7 +865,7 @@ static int bq25890_probe(struct i2c_client *client,
>                 return bq->chip_id;
>         }
>
> -       if (bq->chip_id != BQ25890_ID) {
> +       if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25896_ID)) {
>                 dev_err(dev, "Chip with ID=%d, not supported!\n", bq->chip_id);
>                 return -ENODEV;
>         }
> @@ -977,6 +991,7 @@ MODULE_DEVICE_TABLE(i2c, bq25890_i2c_ids);
>
>  static const struct of_device_id bq25890_of_match[] = {
>         { .compatible = "ti,bq25890", },
> +       { .compatible = "ti,bq25896", },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, bq25890_of_match);
> --
> 2.17.1
>
