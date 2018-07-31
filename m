Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3544EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E328A20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb/Guv/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E328A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeGaSjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731845AbeGaSjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:39:00 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4ED720841;
        Tue, 31 Jul 2018 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533056268;
        bh=6WOIFVuWCA8o9PsKa1zKJ3O0uZT0gtEOYXmRJ9WarAc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Eb/Guv/W9oyhPSe9+/+P3hVHfxtJDT8UcHfL5Ss24uKY+Ozz+e9PVVtQlPvRTUOoW
         yweHFS9i7JAtaumK2crnKcbNSBhpwgpoLMxeYC78gM2nlWcSFO9QmJ4nHA5nmzMDc+
         Pxrvj4ezW6pdSK2ZFek2QNam8i5Yr/RbkYxAtWzE=
Received: by mail-wr1-f49.google.com with SMTP id h9-v6so17417842wro.3;
        Tue, 31 Jul 2018 09:57:48 -0700 (PDT)
X-Gm-Message-State: AOUpUlF/Y05Z6eNy52GJ1Lr0ZPiUg4iFdWbtnSM95YtTGD+tKREULttN
        9kfmw4H9nUJB2Y2xEajbcARMFr6Dj51wOwdz1dw=
X-Google-Smtp-Source: AAOMgped/7BPEENwh+2ocQ6kNTpr5bmqAThW5gwGqqht4DJYe3APv+vL9euH2/VJeqerBSzpJXv/nP+Bi5pIQbilC/0=
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr22225895wre.12.1533056267157;
 Tue, 31 Jul 2018 09:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 09:57:46
 -0700 (PDT)
In-Reply-To: <20180731164316.32696-2-angus@akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca> <20180731164316.32696-2-angus@akkea.ca>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 31 Jul 2018 18:57:46 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeaNpdPbhJuc5FcPKdCq_FPr70_PCSuNMmZ5wJAhBXvmQ@mail.gmail.com>
Message-ID: <CAJKOXPeaNpdPbhJuc5FcPKdCq_FPr70_PCSuNMmZ5wJAhBXvmQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] power: bq25890_charger.c: Add debugging output of
 failed initialization
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 18:43, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> To ease adding a new part variant some debugging is handy.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

You missed my tag - I already reviewed it. Unless you change
something, the tag should be added to commit msg:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Krzysztof

> ---
>  drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 8e2c41ded171..7f0b3a46c50c 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -608,30 +608,40 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>         };
>
>         ret = bq25890_chip_reset(bq);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Reset failed %d\n", ret);
>                 return ret;
> +       };
>
>         /* disable watchdog */
>         ret = bq25890_field_write(bq, F_WD, 0);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Disabling watchdog failed %d\n", ret);
>                 return ret;
> +       };
>
>         /* initialize currents/voltages and other parameters */
>         for (i = 0; i < ARRAY_SIZE(init_data); i++) {
>                 ret = bq25890_field_write(bq, init_data[i].id,
>                                           init_data[i].value);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       dev_dbg(bq->dev, "Writing init data failed %d\n", ret);
>                         return ret;
> +               };
>         }
>
>         /* Configure ADC for continuous conversions. This does not enable it. */
>         ret = bq25890_field_write(bq, F_CONV_RATE, 1);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
>                 return ret;
> +       };
>
>         ret = bq25890_get_chip_state(bq, &state);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Get state failed %d\n", ret);
>                 return ret;
> +       };
>
>         mutex_lock(&bq->lock);
>         bq->state = state;
> @@ -767,6 +777,9 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
>                         if (props[i].optional)
>                                 continue;
>
> +                       dev_err(bq->dev, "Unable to read property %d %s\n", ret,
> +                               props[i].name);
> +
>                         return ret;
>                 }
>
> --
> 2.17.1
>
