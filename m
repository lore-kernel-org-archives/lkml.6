Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D202C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1912921855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548408624;
	bh=bQCTF9AE8TpqkMsBx0VWWXwzzETq7P7yZq4tXN03O3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BzK3RBeUC5humUQTQecHZARKIWg7N5lUHkF6ZkyWSh7FghQ1SpOD9NIVD3E3jUSDp
	 H0jvzB8ZyRYtmm5GDkqHwgCqnhDFeDF7ZmNPjeBbUTB809H4XnuVUgQUMlp0qhfHmH
	 nDCCUc4nd1HERK6jFsQv2HoVfpCuigB7gnerkUoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfAYJaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:30:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42315 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfAYJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:30:21 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so6416121lfh.9;
        Fri, 25 Jan 2019 01:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1dF8hLUpMhjJtda9RcMAKA/Cd7XgQRPFWL4srruzhM=;
        b=OU+1np8UJBxhxtYA57uIxXM0GG5uUyNbiky2GC5GbGrc7/9JRjRU3DR/yxlOTNB74f
         igfFD6C4Cxptzr9xQd+87KdoVrpQHnMgD0PXS3ek08oTyHebiifJnz7zy+QOok5mMyWm
         5M9M9cAubW6yfsYk8PoBdaZ8KJ1webUyyKqVHL14L57J5kVytQFsBw5sxuajBtqVEokI
         5lu4ROBhiOYNjheuEvMDunStFJ3ETgg68Y8S5xEnKxlzLEVS3NNmE2AVH9qO+kcRq9to
         6L9dIlliE1o8gsizF1oKNRTnVVklXne+jhQDoW1BxB50vcez/XjmODTtoJuJdqrwSTb0
         nKHA==
X-Gm-Message-State: AJcUukeFr+ZKosdR1HY/hfV6UUhuzzqhTFpr72Ltw4hn17TCrT9C6QyM
        P5gratwb1vQi+yqHaYwB/40=
X-Google-Smtp-Source: ALg8bN7yEBGtS+JZv5a+QHP1LYATg1srUrpXJnCuKCLfo3JPjIapdTDxZE3cOiP76cl+EjOnXEFc3A==
X-Received: by 2002:a19:984:: with SMTP id 126mr8131773lfj.166.1548408618501;
        Fri, 25 Jan 2019 01:30:18 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f1sm1374318lfm.22.2019.01.25.01.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:30:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gmxoT-0001kS-1y; Fri, 25 Jan 2019 10:30:13 +0100
Date:   Fri, 25 Jan 2019 10:30:13 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 4/4] gnss: add driver for mediatek receivers
Message-ID: <20190125093013.GD3691@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-5-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547744074-28308-5-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:54:34PM +0100, Loys Ollivier wrote:
> Add driver for serial-connected Mediatek-based GNSS receivers.
> 
> These devices typically boot transmitting vendor specific NMEA output
> sequences. The serial port bit rate is read from the device tree
> "current-speed".
> 
> Note that the driver uses the generic GNSS serial implementation and
> therefore essentially only manages power abstracted into three power
> states: ACTIVE, STANDBY, and OFF.
> 
> For mediatek receivers with a main supply and no enable-gpios, this simply
> means that the main supply is disabled in STANDBY and OFF (the optional
> backup supply is kept enabled while the driver is bound).
>
> Note that the timepulse-support is left unimplemented.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2: 
> Renamed from gtop/Globaltop to mtk/Mediatek.
> Added "mediatek,mt3339" compatible.
> 
>  drivers/gnss/Kconfig  |  13 +++++
>  drivers/gnss/Makefile |   3 +
>  drivers/gnss/core.c   |   1 +
>  drivers/gnss/mtk.c    | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 170 insertions(+)
>  create mode 100644 drivers/gnss/mtk.c
> 
> diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> index 6abc88514512..51e6282d092a 100644
> --- a/drivers/gnss/Kconfig
> +++ b/drivers/gnss/Kconfig
> @@ -40,4 +40,17 @@ config GNSS_UBX_SERIAL
>  
>  	  If unsure, say N.
>  
> +config GNSS_MTK_SERIAL
> +	tristate "Mediatek GNSS receiver support"
> +	depends on SERIAL_DEV_BUS
> +	select GNSS_SERIAL
> +	help
> +	  Say Y here if you have a Mediatek-based GNSS receiver which uses a
> +	  serial interface.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called gnss-mtk.
> +
> +	  If unsure, say N.

Add before the SiRF entry too keep the entries sorted.

> +
>  endif # GNSS
> diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
> index 5cf0ebe0330a..43318375aa51 100644
> --- a/drivers/gnss/Makefile
> +++ b/drivers/gnss/Makefile
> @@ -14,3 +14,6 @@ gnss-sirf-y := sirf.o
>  
>  obj-$(CONFIG_GNSS_UBX_SERIAL)		+= gnss-ubx.o
>  gnss-ubx-y := ubx.o
> +
> +obj-$(CONFIG_GNSS_MTK_SERIAL)		+= gnss-mtk.o
> +gnss-mtk-y := mtk.o

Ditto.

> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> index 4291a0dd22aa..320cfca80d5f 100644
> --- a/drivers/gnss/core.c
> +++ b/drivers/gnss/core.c
> @@ -334,6 +334,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
>  	[GNSS_TYPE_NMEA]	= "NMEA",
>  	[GNSS_TYPE_SIRF]	= "SiRF",
>  	[GNSS_TYPE_UBX]		= "UBX",
> +	[GNSS_TYPE_MTK]		= "MTK",
>  };
>  
>  static const char *gnss_type_name(struct gnss_device *gdev)

So this should go in the previous patch.

> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
> new file mode 100644
> index 000000000000..c91d4d251098
> --- /dev/null
> +++ b/drivers/gnss/mtk.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek GNSS receiver driver
> + *
> + * Copyright (C) 2018 Loys Ollivier <lollivier@baylibre.com>

As this just a copy of the ubx driver with the "ubx" prefix replaced
with "mtk", you need to retain the original copyright statement.

I'm not even sure the search and replace work is copyrightable at all...

I see now why you wanted merge this with the ubx driver, but I still
think they should be kept apart for now. Maybe we can move common bits
into the generic implementation (library) when we get a third "copy".

The rest of the driver obviously looks fine. ;) Possibly with the
exception of the added mediatek compatible as mentioned before.

> +#ifdef CONFIG_OF
> +static const struct of_device_id mtk_of_match[] = {
> +	{ .compatible = "globaltop,pa6h" },
> +	{ .compatible = "mediatek,mt3339" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_of_match);
> +#endif
> +
> +static struct serdev_device_driver mtk_driver = {
> +	.driver	= {
> +		.name		= "gnss-mtk",
> +		.of_match_table	= of_match_ptr(mtk_of_match),
> +		.pm		= &gnss_serial_pm_ops,
> +	},
> +	.probe	= mtk_probe,
> +	.remove	= mtk_remove,
> +};
> +module_serdev_device_driver(mtk_driver);
> +
> +MODULE_AUTHOR("Loys Ollivier <lollivier@baylibre.com>");
> +MODULE_DESCRIPTION("Mediatek GNSS receiver driver");
> +MODULE_LICENSE("GPL v2");

Johan
