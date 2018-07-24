Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC1BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15FA20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15FA20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbeGXOaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:30:22 -0400
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:38704 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388297AbeGXOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:30:21 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2001:1bc8:1a6:d3d5::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id D79B3634C7F;
        Tue, 24 Jul 2018 16:23:51 +0300 (EEST)
Received: from sakke by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1fhxI7-0008Ow-Kv; Tue, 24 Jul 2018 16:23:51 +0300
Date:   Tue, 24 Jul 2018 16:23:51 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] media: i2c: Add driver for Aptina MT9V111
Message-ID: <20180724132351.dvxgbd6o6ch2nium@valkosipuli.retiisi.org.uk>
References: <1528730253-25135-1-git-send-email-jacopo+renesas@jmondi.org>
 <1528730253-25135-3-git-send-email-jacopo+renesas@jmondi.org>
 <20180723142835.xl6qrj35lcv2e3vg@valkosipuli.retiisi.org.uk>
 <20180724130845.GM6784@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724130845.GM6784@w540>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Jul 24, 2018 at 03:08:45PM +0200, jacopo mondi wrote:
> > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > index 341452f..0bd867d 100644
> > > --- a/drivers/media/i2c/Kconfig
> > > +++ b/drivers/media/i2c/Kconfig
> > > @@ -841,6 +841,18 @@ config VIDEO_MT9V032
> > >  	  This is a Video4Linux2 sensor-level driver for the Micron
> > >  	  MT9V032 752x480 CMOS sensor.
> > >
> > > +config VIDEO_MT9V111
> > > +	tristate "Aptina MT9V111 sensor support"
> > > +	depends on I2C && VIDEO_V4L2
> > > +	depends on MEDIA_CAMERA_SUPPORT
> > > +	depends on OF
> >
> > Why OF? I see no effective OF dependencies in the driver.
> >
> 
> Isn't the driver probing through OF?

It may, but the driver is otherwise not technically limited to OF. ACPI
could be used as well, for instance.

> 
> > > +	help
> > > +	  This is a Video4Linux2 sensor-level driver for the Aptina/Micron
> 
> I'll change sensor-level to sensor, has you've been doing lately on
> all other Kconfig entries

Ack.

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi
