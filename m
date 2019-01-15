Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548AC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61AB20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9X0XsFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfAOAap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:30:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37717 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfAOAao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:30:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so814707oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cY5qkSo+FBWbzpSPmFbyKit6x9aaEJ7qpcF+mXhM/8A=;
        b=f9X0XsFwSnFvpgEBDPwvmGank2hyt9XvnaB00V1yEQGO8TsQcuEStaseEIc7eyTzU5
         SM7yHQ3ZkBZz02nU/o3IKgQqvGTagOxvReTBqFJ8EBNW7bz9cHwJDO8uB7Gb6djPcDMr
         DAhoIe8meUeURz6Ib5S0aGdcPaIToaYnF35cK1vnMuBffg4RkPsUvP2fPdjSeQhYzc5J
         d9yn3/3o4ovEHCh8sXwNeffGbbgFx0ge+11pKbVA9pCqRp/gxT+Z9SkM77U/VJ5ItDTe
         YATPvm270n4ks1ZBMAoyzos59/7YAu8PN1m5x/WIHjKoujqqO0eQdxtYNLGWhv6ACZG6
         5Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cY5qkSo+FBWbzpSPmFbyKit6x9aaEJ7qpcF+mXhM/8A=;
        b=VRwNySsNphy+4VO1q2JOgEkMI/DAKAKG0kLT9zt40hQVgRVSSgxwcfQmqzsU4gTZqw
         bE9n9EPdSqVNKfKZmgDYFNK/GExqx3SwzffFyiaSRPwTdPWnv6M1BIK9uAl1501kHq3m
         kRepS8wroFbD4/PX7hDOZ0wbg9IRwyNQHLoLrbjOWtNDkylRd4oN3DnX8zGH13KMNvzQ
         d4AYk+ylsLR20LZAvPqrTTMJlk6dUvg+NN88bpLYfwWcfJ1e5Iw8BDBxyIdWg98aTU2w
         g5o060sma+9bGzQjLLtFq9xqsrlSP1ULpIeR5Y/pYR08zVetyjE7qYc34irHiRYYpzQC
         8adQ==
X-Gm-Message-State: AJcUukfja7zGCA2QMu2krmvJCU2p/UFhqrPkSXmZg0lWtWqEZTkoHTYK
        H+WLBpaqx/VyteXx5kd1uEMy0SNswNUWckOD2lht2vajn1E=
X-Google-Smtp-Source: ALg8bN4uwotXthGqpKAz9IHRNVOYJpCXQ51GIDV9eKSF7sdNQQfpzhOgnrPvDDZR+VEsiGLqyybubU2wT2xYnzqvFMc=
X-Received: by 2002:aca:844:: with SMTP id 65mr539324oii.333.1547512243195;
 Mon, 14 Jan 2019 16:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com> <20190114220356.108916-6-ncrews@google.com>
 <20190114222551.GC2589@piout.net>
In-Reply-To: <20190114222551.GC2589@piout.net>
From:   Nick Crews <ncrews@google.com>
Date:   Mon, 14 Jan 2019 17:30:31 -0700
Message-ID: <CAHX4x864vZgToXsr=uLv2_oqr09AK7qpYrooYszuX6r3zHOyhg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] platform/chrome: rtc: Add RTC driver for Wilco EC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        sjg@chromium.org, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments Alexandre, I've responded to your comments
inline. I'll send out a new version of the patch in a bit

On Mon, Jan 14, 2019 at 3:26 PM -700 Alexandre Belloni wrote:
>
> Hello,
>
> On 14/01/2019 15:03:52-0700, Nick Crews wrote:
> > diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> > new file mode 100644
> > index 000000000000..d8ed791da82d
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-wilco-ec.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * RTC interface for Wilco Embedded Controller with R/W abilities
> > + *
> > + * Copyright 2018 Google LLC
> > + *
> > + * The corresponding platform device is typically registered in
> > + * drivers/platform/chrome/wilco_ec/core.c
> > + */
> > +
> > +#include <linux/bcd.h>
> > +#include <linux/err.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/wilco-ec.h>
> > +#include <linux/rtc.h>
> > +#include <linux/timekeeping.h>
> > +
> > +#define DRV_NAME "rtc-wilco-ec"
>
> Please get rid of that define.

Done in the new patch.

>
> > +int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> > +{
> > +     struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> > +     u8 param = EC_CMOS_TOD_READ;
> > +     struct ec_rtc_read rtc;
> > +     struct wilco_ec_message msg = {
> > +             .type = WILCO_EC_MSG_LEGACY,
> > +             .flags = WILCO_EC_FLAG_RAW_RESPONSE,
> > +             .command = EC_COMMAND_CMOS,
> > +             .request_data = &param,
> > +             .request_size = sizeof(param),
> > +             .response_data = &rtc,
> > +             .response_size = sizeof(rtc),
> > +     };
> > +     struct rtc_time calc_tm;
> > +     unsigned long time;
> > +     int ret;
> > +
> > +     ret = wilco_ec_mailbox(ec, &msg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     tm->tm_sec      = rtc.second;
> > +     tm->tm_min      = rtc.minute;
> > +     tm->tm_hour     = rtc.hour;
> > +     tm->tm_mday     = rtc.day;
> > +     /*
> > +      * The RTC stores the month value as 1-12 but the kernel expects 0-11,
> > +      * so ensure invalid/zero month value from RTC is not converted to -1.
>
> I'm pretty sure this is not necessary and will certainly make the core
> think the date is valid when it has obviously been corrupted.

OK, I'll get rid of the safety check and just do rtc.month -1.

>
> > +      */
> > +     tm->tm_mon      = rtc.month ? rtc.month - 1 : 0;
> > +     tm->tm_year     = rtc.year + (rtc.century * 100) - 1900;
> > +     tm->tm_yday     = rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> > +
> > +     /* Compute day of week */
> > +     rtc_tm_to_time(tm, &time);
> > +     rtc_time_to_tm(time, &calc_tm);
> > +     tm->tm_wday = calc_tm.tm_wday;
>
> Do you really need an accurate wday? There are no userspace applications
> that I know of that care and converting back and forth is quite
> expensive.
>

We probably don't, this RTC should only get used for very specific purposes,
and any userspace programs should be using a different RTC.

> > +
> > +     return 0;
> > +}
> > +
> > +int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
> > +{
> > +     struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> > +     struct ec_rtc_write rtc;
> > +     struct wilco_ec_message msg = {
> > +             .type = WILCO_EC_MSG_LEGACY,
> > +             .flags = WILCO_EC_FLAG_RAW_RESPONSE,
> > +             .command = EC_COMMAND_CMOS,
> > +             .request_data = &rtc,
> > +             .request_size = sizeof(rtc),
> > +     };
> > +     int year = tm->tm_year + 1900;
> > +     /* Convert from 0=Sunday to 0=Saturday for the EC */
> > +     int wday = tm->tm_wday == 6 ? 0 : tm->tm_wday + 1;
>
> I'm not sure how useful it is to set an accurate wday when the RTC is
> not able to give it back.
>

This is actually needed. The RTC on the EC controls battery charging
schedules and thus needs to know the day of the week, and this is the
way to do this.

> > +     int ret;
> > +
> > +     rtc.param       = EC_CMOS_TOD_WRITE;
> > +     rtc.century     = bin2bcd(year / 100);
> > +     rtc.year        = bin2bcd(year % 100);
> > +     rtc.month       = bin2bcd(tm->tm_mon + 1);
> > +     rtc.day         = bin2bcd(tm->tm_mday);
> > +     rtc.hour        = bin2bcd(tm->tm_hour);
> > +     rtc.minute      = bin2bcd(tm->tm_min);
> > +     rtc.second      = bin2bcd(tm->tm_sec);
> > +     rtc.weekday     = bin2bcd(wday);
> > +
> > +     ret = wilco_ec_mailbox(ec, &msg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct rtc_class_ops wilco_ec_rtc_ops = {
> > +     .read_time = wilco_ec_rtc_read,
> > +     .set_time = wilco_ec_rtc_write,
> > +};
> > +
> > +static int wilco_ec_rtc_probe(struct platform_device *pdev)
> > +{
> > +     struct rtc_device *rtc = devm_rtc_device_register(&pdev->dev,
> > +                                                       DRV_NAME,
> > +                                                       &wilco_ec_rtc_ops,
> > +                                                       THIS_MODULE);
>
> Please use devm_rtc_allocate_device() and set rtc->range_min and
> rtc->range_max before registering with rtc_register_device().
>

Thanks, will do this.

> > +     if (IS_ERR(rtc))
> > +             return PTR_ERR(rtc);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver wilco_ec_rtc_driver = {
> > +     .driver = {
> > +             .name = DRV_NAME,
> > +     },
> > +     .probe = wilco_ec_rtc_probe,
> > +};
> > +
> > +module_platform_driver(wilco_ec_rtc_driver);
> > +
> > +MODULE_ALIAS("platform:" DRV_NAME);
> > +MODULE_AUTHOR("Nick Crews <ncrews@google.com>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Wilco EC RTC driver");
> > --
> > 2.20.1.97.g81188d93c3-goog
> >
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Nick Crews
ncrews@google.com
