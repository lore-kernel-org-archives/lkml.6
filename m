Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEA1C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06920846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBiY2IwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF06920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeGZITS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeGZITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:19:17 -0400
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EC420846;
        Thu, 26 Jul 2018 07:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532588632;
        bh=zhhMs6A9+u3ACO8rbpZKOocdPcfJLgNhJ2BakJGRyVI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GBiY2IwIFXa7nCyG9G9gp2zXh91M5iGxDlUeTbwmtRnWv01lDDJiLCyF93DHfBpxv
         AMY1r/IqmusL6J9toXxdjV2JqGEPPPUMply6k84SvFn8QcLzR54UmbL4KO5cEjOM9o
         MKZktLKTXZyob82v+jUZSh+4gxbVE8fdX+qpqSps=
Received: by mail-wm0-f48.google.com with SMTP id s12-v6so849963wmc.0;
        Thu, 26 Jul 2018 00:03:52 -0700 (PDT)
X-Gm-Message-State: AOUpUlFqaBINXkFNvsHXbuKDB2hWgzRFCLifbMWikxTEkM/kOWHa16ty
        UAK2TTHLJUu19IqsNUFRBoO+GxAvNHAp7JwsjOk=
X-Google-Smtp-Source: AAOMgpfUAHVouzOKzfOwm1ea/Z3405OIvzvgcUvT2l3N5qzeNlP1CnrpQGYRYSmG53Y7PO7+o2tDO4RZxOgQDjccifg=
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr642145wmd.135.1532588631024;
 Thu, 26 Jul 2018 00:03:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 00:03:50
 -0700 (PDT)
In-Reply-To: <20180725194630.10414-5-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-5-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 26 Jul 2018 09:03:50 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc1amTiPKNU02OruOpw+GA6DrZgv1+HhqZ14OZYpA2-YA@mail.gmail.com>
Message-ID: <CAJKOXPc1amTiPKNU02OruOpw+GA6DrZgv1+HhqZ14OZYpA2-YA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] power: bq25890_charger.c: Read back the current
 battery voltage
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> The part has the capability of reading the current battery voltage
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index f4cf2987996b..60ccd6c2b7ad 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -464,6 +464,20 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>                 val->intval = bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
>                 break;
>
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               if (!state.online) {
> +                       val->intval = 0;
> +                       break;
> +               }

You use state from cached value (from last interrupt) but the voltage
is read directly from registers. The driver follows this convention in
few other places so maybe it is okay. It depends how accurately the
interrupts are generated - on every change? IOW, is always guaranteed
that state will be consistent with values read below?

Best regards,
Krzysztof

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
> @@ -672,6 +686,7 @@ static enum power_supply_property bq25890_power_supply_props[] = {
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>         POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
>
>  static char *bq25890_charger_supplied_to[] = {
> --
> 2.17.1
>
