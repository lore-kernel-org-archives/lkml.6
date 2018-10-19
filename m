Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD2AECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01F321479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01F321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJSTH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:07:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35427 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeJSTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:07:56 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gDSXs-0000CA-F6; Fri, 19 Oct 2018 13:02:20 +0200
Message-ID: <1539946939.3688.58.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] media: mst3367: add support for mstar mst3367 HDMI
 RX
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, stoth@kernellabs.com,
        laurent.pinchart@ideasonboard.com, kernel@pengutronix.de,
        mchehab@kernel.org, davem@davemloft.net
Date:   Fri, 19 Oct 2018 13:02:19 +0200
In-Reply-To: <20181019105439.27796-2-m.grzeschik@pengutronix.de>
References: <20181019105439.27796-1-m.grzeschik@pengutronix.de>
         <20181019105439.27796-2-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 19.10.2018, 12:54 +0200 schrieb Michael Grzeschik:
> > From: Steven Toth <stoth@kernellabs.com>
> 
> This patch is based on the work of Steven Toth. He reverse engineered
> the driver by tracing the windows driver.
> 
> https://github.com/stoth68000/hdcapm/
> 
> > Signed-off-by: Steven Toth <stoth@kernellabs.com>
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  MAINTAINERS                 |    6 +
>  drivers/media/i2c/Kconfig   |   10 +
>  drivers/media/i2c/Makefile  |    1 +
>  drivers/media/i2c/mst3367.c | 1104 +++++++++++++++++++++++++++++++++++
>  include/media/i2c/mst3367.h |   29 +
>  5 files changed, 1150 insertions(+)
>  create mode 100644 drivers/media/i2c/mst3367.c
>  create mode 100644 include/media/i2c/mst3367.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 556f902b3766..9c69b7f9b2f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9787,6 +9787,12 @@ L:	linux-mtd@lists.infradead.org
> >  S:	Maintained
> >  F:	drivers/mtd/devices/docg3*
>  
> +MT9M032 APTINA SENSOR DRIVER
> > > +M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
> > +S:	Maintained
> > +F:	drivers/media/i2c/mst3367.c
> > +F:	include/media/i2c/mst3367.h

Das sollte nicht in diesem Patch landen, oder?

Gruß
Lucas
