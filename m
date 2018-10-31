Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CBA20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CxbEQTHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CBA20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbeJaViE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:38:04 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43795 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbeJaViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:38:04 -0400
Received: by mail-ua1-f68.google.com with SMTP id c89so5813742uac.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMvVZWAVIIu2zWcHQ0LhRmMltioQ2g2ES4VdOmjOn9w=;
        b=CxbEQTHcnhXyFblSb1jwc+3NPkVeok3IXEgnSV76l96Grwlmf7GECS0b6GaKVgkMAD
         UUtKLEr/rukNuTaBqUYJ6p2XPOXR47WL4y2VaXnc+Ktdaj80i8DlTmjfi7JjewkKABSF
         Gj+4nFRNQnsejCZGnu8HKDG+TwH1XsCw+4xRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMvVZWAVIIu2zWcHQ0LhRmMltioQ2g2ES4VdOmjOn9w=;
        b=tHvwJH2jDf9/Coq3oWASJnSL1iiSfjOqq2zutJhNHGvO+Ss+iZbM1fvJJRm3GCyjQ3
         C/FtZSwHLGcAOLn3SpeuXU3T3WKIEpiiqqd4V9AiYSTC/YMFWddGsBFUBahaoXSbQqeS
         jwZao96M7I5lZOWl8I8n2RhZxjN3aYTBNPNcPco8XPRG6UDXuO1N5cIMTa2QvcCcz7Ac
         RuIAJVzAIYXbEgySqwBdJrRDx/sko2VMubhGRFH61BV9NPpaBvDyWmlUxfsXxX0gLfj8
         wiYTd3xK6amIXKYEVz9TRfY+9CVjaFj/XH3wOddnRxDNsQmhvD8VsxKok+2edKYeqYL4
         NzkA==
X-Gm-Message-State: AGRZ1gJ+8jjpPN2DX9BuOswkPoga6T+e39lsHkmXfuPNeyZiTd08K217
        aEF6gZ1PmCgnMwNayokiY6ZYN1Lgx5gYZUzSRppQjw==
X-Google-Smtp-Source: AJdET5c/vsXsFIQ4YM58022nnZKM8OaH1fA39GaJgRljho0RsBRoWXlGdihdpIiyoOaaVx0oshSKWL/Fk9FtZ2UvfYA=
X-Received: by 2002:ab0:26cb:: with SMTP id b11mr1196815uap.112.1540989611651;
 Wed, 31 Oct 2018 05:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017155338epcas1p3a22cd0b22e757c3e51eb72ccee545478@epcas1p3.samsung.com>
 <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com> <1539791563-5959-5-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1539791563-5959-5-git-send-email-b.zolnierkie@samsung.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 31 Oct 2018 18:10:00 +0530
Message-ID: <CAHLCerNYO+srv4codxKqbOgtaUBr3WKV460jpry-Ppn1mf0Nug@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] thermal: separate sensor registration and
 enable+check operations
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -161,6 +161,11 @@ static int hwmon_thermal_add_sensor(struct device *dev,
>         if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
>                 return PTR_ERR(tzd);
>
> +       if (!IS_ERR(tzd)) {
> +               thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check(tzd);
> +       }
> +
>         return 0;
>  }
>  #else
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index c52d07c..d423b0f 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -647,6 +647,10 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
>                                                   &ntc_of_thermal_ops);
>         if (IS_ERR(tz))
>                 dev_dbg(dev, "Failed to register to thermal fw.\n");
> +       else {
> +               thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
> +               thermal_zone_device_check(tz);
> +       }

Use the negative check here as above to get rid of the 'else' statement?

>         return 0;
>  }
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 111d521..ad5c5d7 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -288,6 +288,10 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>                  */
>                 if (IS_ERR(z))
>                         devm_kfree(dev, zone);
> +               else {
> +                       thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
> +                       thermal_zone_device_check(z);
> +               }

Use the negative check here (!IS_ERR(z)) as above to get rid of the
'else' statement? The memory is allocated through devm_kzalloc so it
doesn't need to be explicitly freed.

>         }
>
>         return 0;
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 04d7147..ff67f72 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -659,6 +659,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>                                 PTR_ERR(info->tzd));
>                         return PTR_ERR(info->tzd);
>                 }
> +               if (!IS_ERR(info->tzd)) {
> +                       thermal_zone_set_mode(info->tzd,
> +                                             THERMAL_DEVICE_ENABLED);
> +                       thermal_zone_device_check(info->tzd);
> +               }
>         }
