Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B858DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F5821476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow4tlwUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F5821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJSVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:51:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33447 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeJSVv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:51:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id q40-v6so38326717qte.0;
        Fri, 19 Oct 2018 06:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kgtK0jhSQJMW9aWoG5mJudkuR1Hku0qggHFw+A5Q1C8=;
        b=Ow4tlwULXZ7QadJ2yjVG+0toKdeOqhudC2WJMsoiDa+OgC7y2P1Bfy9zvOGY7KfZjH
         Lr6/OgKglPWfMhHo+qiQbt+k+Z+uMfx87jsDjPiqswAwvsuDknNwRKBQwGF/bruOZnvq
         Gc6puux9MX/LOAbkJzYvyJvziv5a5/SicBINtqxSKT4AUASMF3q+I/4fdEFfLsUH5WPD
         83hOih2L4SlfZimiI3y8RPLgnEzLhORMZWP30+y5b0X5KEmkFufHteX9TW8T8ypk83qh
         bKilVqCKb1apMEU4f7xWXkPBgU7JpteD5p4OYmSel5rnxMiN6G3z9S/Xfa6DttmVYYsT
         PMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kgtK0jhSQJMW9aWoG5mJudkuR1Hku0qggHFw+A5Q1C8=;
        b=P8pB+C8erYJD8MveYDGc06sd8WweR+dEG5jdtFYquKux9QLNTpKUie1SnFw8BgkD8m
         El7ngj1CCmfyGSlD2BKYlHJX0KYRgQ/nIu1pfQqG0kLqcFtr6uvIUGLLqMhRHbNdIO3W
         VBUnMQEwkEzVLp+Zjg6FBGIvfIILp7jJDVBQB4EO0p89edSgZp7vJMeD+q2fgAZbXbSM
         8XHf+ISOn4VNVEoBcJ7+EmQxi2zqp3UTSGo96ahRFl3ZfCe1Gepbe2AopAzjcsE1D59v
         g0DyCU8+ogn2rnGhdTqe+fZ/OhC/TBnh1QQAjgweSoUqiFKNSo5UF51LWlFQ0yihbHGh
         vdEQ==
X-Gm-Message-State: ABuFfojZ84MXFzItiODPWLNykpjdAVRy5a8eIOC984noWp9EaHRCSPAc
        VBbGkNzuN4j3xwEpp0N1e9XLErANX4if0rP5xcQ=
X-Google-Smtp-Source: ACcGV61qVc6AxdaSoitoI5uNjriWIN3sIcMXIM1a1f+WZfWOGa+TvWoDXRyOLVS7fz3et+gY4PnoascyZQTVg9clxho=
X-Received: by 2002:a0c:9578:: with SMTP id m53mr34341530qvm.138.1539956714563;
 Fri, 19 Oct 2018 06:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-13-lkundrak@v3.sk>
In-Reply-To: <20181010172300.317643-13-lkundrak@v3.sk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 16:45:03 +0300
Message-ID: <CAHp75VeEFK+47pz+he6Su630jnoGKPamhatuoXopS5Ee=LZtTg@mail.gmail.com>
Subject: Re: [PATCH 12/15] power: supply: olpc_battery: Use DT to get battery version
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quozl@laptop.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        devel@driverdev.osuosl.org, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Avoid using the x86 OLPC platform specific call to get the board
> version. It won't work on FDT-based ARM MMP2 platform.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
> index 5a97e42a3547..540d44bf536f 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -19,6 +19,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/sched.h>
>  #include <linux/olpc-ec.h>
> +#include <linux/of.h>
>  #include <asm/olpc.h>

Keep it sorted, otherwise the change is good!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
>
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_device *pdev)
>         olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>         if (IS_ERR(olpc_ac))
>                 return PTR_ERR(olpc_ac);
> -
> -       if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +       if (of_property_match_string(pdev->dev.of_node, "compatible",
> +                                       "olpc,xo1.5-battery") >= 0) {
> +               /* XO-1.5 */
>                 olpc_bat_desc.properties = olpc_xo15_bat_props;
>                 olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo15_bat_props);
> -       } else { /* XO-1 */
> +       } else {
> +               /* XO-1 */
>                 olpc_bat_desc.properties = olpc_xo1_bat_props;
>                 olpc_bat_desc.num_properties = ARRAY_SIZE(olpc_xo1_bat_props);
>         }
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device *pdev)
>
>  static const struct of_device_id olpc_battery_ids[] = {
>         { .compatible = "olpc,xo1-battery" },
> +       { .compatible = "olpc,xo1.5-battery" },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
