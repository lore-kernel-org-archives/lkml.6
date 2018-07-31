Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C1DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311D120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1X142xZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311D120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeGaSmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbeGaSmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:42:14 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6A1A20870;
        Tue, 31 Jul 2018 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533056462;
        bh=q+/hfQqA4wHUp/isFYhwXSslY5/E2B6IQJKqx9uPsFI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=U1X142xZvYN0hOna6Hts+X4XM8bN0U8v6lUzxFyzCQUffDbSoiBA0KQWMJhGpIJ4X
         ohSh3jslCN2h9bZgQ9RWJKTda8Zc50HRJ9nGD0mIFSDg4JsLK6vXWjssxxYrG0SAHf
         6s75JleBHwHr7lf3me3zjUCMdlQgU2DYYw8lEGwo=
Received: by mail-wm0-f48.google.com with SMTP id f21-v6so3880453wmc.5;
        Tue, 31 Jul 2018 10:01:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlH4/fEm3P812PbIdC816Kh/HT7pnjSOH1GHkRyhxZuhzmzgMPL1
        P6wdI4QvqGFDLKJghapiKKvvkiilXeeX1T0QOrE=
X-Google-Smtp-Source: AAOMgpfoH2augmy5Y+p17h/u4o15EkOcYIm5VHwdjSn25lAlsgRWgY8/QxL4FfY0bF/pMRnndnJvHb1XsdVogdhb8eY=
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr337761wmb.118.1533056460146;
 Tue, 31 Jul 2018 10:01:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 10:00:59
 -0700 (PDT)
In-Reply-To: <20180731164316.32696-4-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca> <20180731164316.32696-4-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Jul 2018 19:00:59 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd0Juz4YP=vaG1VY=3PxyKoOyWKD4EU4n+OSmOi1w6GFw@mail.gmail.com>
Message-ID: <CAJKOXPd0Juz4YP=vaG1VY=3PxyKoOyWKD4EU4n+OSmOi1w6GFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] power: bq25890_charger.c: Add the BQ25896 part
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 18:43, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> The BQ25896 is almost identical the the BQ25890.

s/the the/to the/

>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../bindings/power/supply/bq25890.txt         |  3 +++
>  drivers/power/supply/bq25890_charger.c        | 24 +++++++++++++++----
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> index c9dd17d142ad..ccb3a123ab57 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> @@ -1,5 +1,8 @@
>  Binding for TI bq25890 Li-Ion Charger
>
> +This driver will support the bq25896 and the bq25890. There are other parts

To me "other parts" in that context sounds unusual. Probably you
meant "other flavors" or "other devices from the same family".

With both changes:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> +in the same family but those have not been tested.
> +
>  Required properties:
>  - compatible: Should contain one of the following:
>      * "ti,bq25890"
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index ca61278e932e..23b39da07e56 100644
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
> @@ -396,6 +399,16 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
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
> @@ -647,6 +660,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>
>  static enum power_supply_property bq25890_power_supply_props[] = {
>         POWER_SUPPLY_PROP_MANUFACTURER,
> +       POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_ONLINE,
>         POWER_SUPPLY_PROP_HEALTH,
> @@ -848,7 +862,7 @@ static int bq25890_probe(struct i2c_client *client,
>                 return bq->chip_id;
>         }
>
> -       if (bq->chip_id != BQ25890_ID) {
> +       if ((bq->chip_id != BQ25890_ID) && (bq->chip_id != BQ25896_ID)) {
>                 dev_err(dev, "Chip with ID=%d, not supported!\n", bq->chip_id);
>                 return -ENODEV;
>         }
> --
> 2.17.1
>
