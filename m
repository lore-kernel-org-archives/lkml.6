Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58474C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277C12173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfAGS0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:26:04 -0500
Received: from shell.v3.sk ([90.176.6.54]:44360 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbfAGS0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:26:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E73C3FFD7D;
        Mon,  7 Jan 2019 19:25:58 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wkQBFvO01pwA; Mon,  7 Jan 2019 19:25:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E1B35FFD7E;
        Mon,  7 Jan 2019 19:25:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LUdJIGp02hQm; Mon,  7 Jan 2019 19:25:53 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 43495FFD7D;
        Mon,  7 Jan 2019 19:25:53 +0100 (CET)
Message-ID: <4364d7c4dc1266ca45255cdad5ba40fb20a9bea3.camel@v3.sk>
Subject: Re: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get
 battery version
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
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
Date:   Mon, 07 Jan 2019 19:25:52 +0100
In-Reply-To: <20181205205459.bsumxn57hjjzvqaj@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
         <20181116162403.49854-14-lkundrak@v3.sk>
         <20181205205459.bsumxn57hjjzvqaj@earth.universe>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-05 at 21:54 +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Nov 16, 2018 at 05:23:59PM +0100, Lubomir Rintel wrote:
> > Avoid using the x86 OLPC platform specific call to get the board
> > version. It won't work on FDT-based ARM MMP2 platform.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I assume this patch cannot be applied to power-supply without patch
> 12 having been merged to avoid breaking XO1.5 devices temporarily?

That is true. What's the correct way to deal with a situation like
this? Just hold the patch until the other changes get in, perhaps via
linux-platform-drivers-x86.git? Or maybe this can go in together via
that tree along with the other patches?

Thanks
Lubo

> -- Sebastian
> 
> > Changes since v1:
> > - Sort the new include a bit higher
> > 
> >  drivers/power/supply/olpc_battery.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/olpc_battery.c
> > b/drivers/power/supply/olpc_battery.c
> > index 5a97e42a3547..5323987d9284 100644
> > --- a/drivers/power/supply/olpc_battery.c
> > +++ b/drivers/power/supply/olpc_battery.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/types.h>
> >  #include <linux/err.h>
> >  #include <linux/device.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/jiffies.h>
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
> > -- 
> > 2.19.1
> > 

