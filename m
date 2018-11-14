Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E4BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D114B21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D114B21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbeKODYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:24:05 -0500
Received: from shell.v3.sk ([90.176.6.54]:46227 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbeKODYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:24:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DF744467FF;
        Wed, 14 Nov 2018 18:19:56 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lPgKcWYNcqGK; Wed, 14 Nov 2018 18:19:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 94DE5468E8;
        Wed, 14 Nov 2018 18:19:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9EeXSimEJQKO; Wed, 14 Nov 2018 18:19:52 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 69CDD467FF;
        Wed, 14 Nov 2018 18:19:51 +0100 (CET)
Message-ID: <0ddafe2451f1bea019e529035ef27dc886c1cb3c.camel@v3.sk>
Subject: Re: [PATCH 14/15] power: supply: olpc_battery: Avoid using
 platform_info
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Date:   Wed, 14 Nov 2018 18:19:50 +0100
In-Reply-To: <CAHp75VcQVv-WToo-Lf1uUG0YOhusDqRN3x6HAGt-ccSbp5B+xg@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-15-lkundrak@v3.sk>
         <CAHp75VcQVv-WToo-Lf1uUG0YOhusDqRN3x6HAGt-ccSbp5B+xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 16:50 +0300, Andy Shevchenko wrote:
> On Wed, Oct 10, 2018 at 8:24 PM Lubomir Rintel <lkundrak@v3.sk>
> wrote:
> > This wouldn't work on the DT-based ARM platform. Let's read the EC
> > version
> > directly from the EC driver instead.
> > 
> > This makes the driver no longer x86 specific.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/power/supply/Kconfig        |  2 +-
> >  drivers/power/supply/olpc_battery.c | 35 +++++++++++++++++++++--
> > ------
> >  2 files changed, 27 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/power/supply/Kconfig
> > b/drivers/power/supply/Kconfig
> > index ff6dab0bf0dd..f0361e4dd457 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -151,7 +151,7 @@ config BATTERY_PMU
> > 
> >  config BATTERY_OLPC
> >         tristate "One Laptop Per Child battery"
> > -       depends on X86_32 && OLPC
> > +       depends on OLPC
> >         help
> >           Say Y to enable support for the battery on the OLPC
> > laptop.
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c
> > b/drivers/power/supply/olpc_battery.c
> > index 2a2d7cc995f0..dde9863e5c4a 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -20,8 +20,6 @@
> >  #include <linux/sched.h>
> >  #include <linux/olpc-ec.h>
> >  #include <linux/of.h>
> 
> Btw, Kconfig might miss
> depends on OF
> part.

But will it? I thought this header can be included regardless,
providing stubs that always fail instead of actual OF functionality.

It just wouldn't be too useful apart for compile-testing things.

Apart from that, CONFIG_OLPC drags in CONFIG_OF, so we're always
getting CONFIG_OF transitively.

> 
> > -#include <asm/olpc.h>
> > -
> > 
> >  #define EC_BAT_VOLTAGE 0x10    /*
> > uint16_t,    *9.76/32,    mV   */
> >  #define EC_BAT_CURRENT 0x11    /* int16_t,     *15.625/120,
> > mA   */
> > @@ -57,6 +55,7 @@ struct olpc_battery_data {
> >         struct power_supply *olpc_ac;
> >         struct power_supply *olpc_bat;
> >         char bat_serial[17];
> > +       int new_proto;
> >  };
> > 
> >  /*****************************************************************
> > ****
> > @@ -100,7 +99,7 @@ static const struct power_supply_desc
> > olpc_ac_desc = {
> >  static int olpc_bat_get_status(struct olpc_battery_data *data,
> >                 union power_supply_propval *val, uint8_t ec_byte)
> >  {
> > -       if (olpc_platform_info.ecver > 0x44) {
> > +       if (data->new_proto) {
> >                 if (ec_byte & (BAT_STAT_CHARGING |
> > BAT_STAT_TRICKLE))
> >                         val->intval = POWER_SUPPLY_STATUS_CHARGING;
> >                 else if (ec_byte & BAT_STAT_DISCHARGING)
> > @@ -608,14 +607,32 @@ static int olpc_battery_probe(struct
> > platform_device *pdev)
> >         struct power_supply_config psy_cfg = {};
> >         struct olpc_battery_data *data;
> >         uint8_t status;
> > +       unsigned char ecver[1];
> 
> isn't it simple
>  uint8_t ecver;
> ?

Yes, it's probably going to be nicer that way.

> 
> > +       int ret;
> > +
> > +       data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return -ENOMEM;
> > +       platform_set_drvdata(pdev, data);
> > +
> > +       /* See if the EC is already there and get the EC revision
> > */
> > +       ret = olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, ecver,
> > ARRAY_SIZE(ecver));
> > +       if (ret) {
> > +               if (ret == -ENODEV)
> > +                       return -EPROBE_DEFER;
> 
> Yeah, exactly a question I asked somewhere in the first part of the
> series.
> 
> > +               return ret;
> > +       }
> > 
> > -       /*
> > -        * We've seen a number of EC protocol changes; this driver
> > requires
> > -        * the latest EC protocol, supported by 0x44 and above.
> > -        */
> > -       if (olpc_platform_info.ecver < 0x44) {
> > +       if (ecver[0] > 0x44) {
> > +               /* XO 1 or 1.5 with a new EC firmware. */
> > +               data->new_proto = 1;
> > +       } else if (ecver[0] < 0x44) {
> > +               /*
> > +                * We've seen a number of EC protocol changes; this
> > driver
> > +                * requires the latest EC protocol, supported by
> > 0x44 and above.
> > +                */
> >                 printk(KERN_NOTICE "OLPC EC version 0x%02x too old
> > for "
> > -                       "battery driver.\n",
> > olpc_platform_info.ecver);
> > +                       "battery driver.\n", ecver[0]);
> >                 return -ENXIO;
> >         }
> > 
> > --
> > 2.19.0
> > 

Thanks,
Lubo

