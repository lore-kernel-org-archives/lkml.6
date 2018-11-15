Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89593C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5104C2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5104C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbeKPEpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:45:47 -0500
Received: from shell.v3.sk ([90.176.6.54]:52244 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKPEpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:45:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C0CD74C35E;
        Thu, 15 Nov 2018 19:36:47 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id raIzwUPqoDly; Thu, 15 Nov 2018 19:36:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0434D4C37B;
        Thu, 15 Nov 2018 19:36:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GdJT7ZIrdELW; Thu, 15 Nov 2018 19:36:43 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C46B44C35E;
        Thu, 15 Nov 2018 19:36:42 +0100 (CET)
Message-ID: <e1de44148e06379b04c72f925a30fb0e346536eb.camel@v3.sk>
Subject: Re: [PATCH 12/15] power: supply: olpc_battery: Use DT to get
 battery version
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Date:   Thu, 15 Nov 2018 19:36:41 +0100
In-Reply-To: <20181104123710.GE23864@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
         <20181010172300.317643-13-lkundrak@v3.sk> <20181104123710.GE23864@amd>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 13:37 +0100, Pavel Machek wrote:
> On Wed 2018-10-10 19:22:57, Lubomir Rintel wrote:
> > Avoid using the x86 OLPC platform specific call to get the board
> > version. It won't work on FDT-based ARM MMP2 platform.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> AFAICT, this should go earlier in the series; first, add support in
> the code, then switch to new name in DTS.

I think it's all right this way: I'm not removing the old compatible
string -- functionality provided by one version of the battery is a
superset of the another.

Also, the older version of the driver with only the XO-1 compatible
string guesses the actual battery version by querying the board version
directly, so up to this patch things keep working the way they used to
regardless of the new compatible string.

Lubo

> 								Pavel
> 
> > ---
> >  drivers/power/supply/olpc_battery.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c
> > b/drivers/power/supply/olpc_battery.c
> > index 5a97e42a3547..540d44bf536f 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/jiffies.h>
> >  #include <linux/sched.h>
> >  #include <linux/olpc-ec.h>
> > +#include <linux/of.h>
> >  #include <asm/olpc.h>
> >  
> >  
> > @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct
> > platform_device *pdev)
> >  	olpc_ac = power_supply_register(&pdev->dev, &olpc_ac_desc,
> > NULL);
> >  	if (IS_ERR(olpc_ac))
> >  		return PTR_ERR(olpc_ac);
> > -
> > -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> > +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> > +					"olpc,xo1.5-battery") >= 0) {
> > +		/* XO-1.5 */
> >  		olpc_bat_desc.properties = olpc_xo15_bat_props;
> >  		olpc_bat_desc.num_properties =
> > ARRAY_SIZE(olpc_xo15_bat_props);
> > -	} else { /* XO-1 */
> > +	} else {
> > +		/* XO-1 */
> >  		olpc_bat_desc.properties = olpc_xo1_bat_props;
> >  		olpc_bat_desc.num_properties =
> > ARRAY_SIZE(olpc_xo1_bat_props);
> >  	}
> > @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct
> > platform_device *pdev)
> >  
> >  static const struct of_device_id olpc_battery_ids[] = {
> >  	{ .compatible = "olpc,xo1-battery" },
> > +	{ .compatible = "olpc,xo1.5-battery" },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, olpc_battery_ids);

