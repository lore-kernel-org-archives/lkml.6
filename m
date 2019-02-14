Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A951BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69670222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQj5ivsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393492AbfBNKA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:00:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44597 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388650AbfBNKAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:00:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id v16so5725925wrn.11;
        Thu, 14 Feb 2019 02:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XN6xUCS+tZmGQkSmGy6ryJ1Zi47H6ia5G0Vkj8uZJkU=;
        b=bQj5ivsmZHdmK+/W3Cc5ieUJs/rugU/1ses5dj88GO5K4/VWj99r5GAaHrhQrL/fy0
         vAyoLuJkHySSOIMkZBJF3ITY2jyz21UXd08zp1hCFIX2A3qFG7JTtKFESvzj99E4AHlX
         9mNt0uSm9t6IFWt0IonKUqia7LHnNcmeYBgBynSdsYYnTnuLxpUFr4tdAtrIZJb9qpWo
         I2QKpNOAzoZpKoUFqTPWQj5FuXmw3C7xrVbx+s9zq/CV0bcEBR3uqx0ad8iwSVGg6PkP
         0Gd/xCV1Jps1TddnSMeq4VYXzWAqd/hvWs8E9e9Kc9/xRDQ1YrBnovhYPVm/fjv6kQof
         WZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XN6xUCS+tZmGQkSmGy6ryJ1Zi47H6ia5G0Vkj8uZJkU=;
        b=RALz9Y9QglOv077r+t4twYehRJkA+yWJSZ1irLdDmel1xobnw4evGCQ3Zk0OIPt22b
         V3aTjRkNnTLk5+lTtzK2jzcAd/gC8ftjCpNC8GuU6or7W+CB0Y1qd3iaN82l6nO0OlTq
         vrY99aBGzWYW4JyLzOdatsiz8XYDt+0YVjt1nlS9E76pVP8y0OnAX9nX0Oe60lU0Gczz
         xT/NRlIN50tZlWRTILknCIduNotdqsknjLaV/XODgY+Ja3Y2uW4nk1a+2BcivqMpuN8S
         TcABxZkmtOaBzYnqZLqDO9aDxuiPsSk+VZyNKhfNMzJ+b27Ez6QCRxvLFxoCR+VJc9c/
         iRCg==
X-Gm-Message-State: AHQUAub80UkHcjqxOsK8nJvIYQ89DRXZRWuv7Cdad01stoMGwZFb4MZL
        Rzl6RMy6kjRYIR0hc0Ojzfo=
X-Google-Smtp-Source: AHgI3IZHymyK33Jq1slZmcUXBX2W9bJzMFWZlQ1sJwTUvtpyybwojShoCMomxNHxC7VI/f5exxHUZw==
X-Received: by 2002:adf:ee8e:: with SMTP id b14mr2047002wro.71.1550138422919;
        Thu, 14 Feb 2019 02:00:22 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id t14sm1713142wrr.49.2019.02.14.02.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:00:22 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:00:19 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] gnss: add driver for mediatek receivers
Message-ID: <20190214100019.GA4197@Red>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550070569-18588-5-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:09:29PM +0100, Loys Ollivier wrote:
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
> v4:
> No changes
> 
> v3:
> Sorted the Kconfig and Makefile
> Retained the original Copyright
> Removed "mediatek,mt3339" compatible.
> 
> v2: 
> Renamed from gtop/Globaltop to mtk/Mediatek.
> Added "mediatek,mt3339" compatible.
> 
>  drivers/gnss/Kconfig  |  13 +++++
>  drivers/gnss/Makefile |   3 +
>  drivers/gnss/mtk.c    | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 168 insertions(+)
>  create mode 100644 drivers/gnss/mtk.c
> 
> diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> index 6abc88514512..6d8c8027e1cd 100644
> --- a/drivers/gnss/Kconfig
> +++ b/drivers/gnss/Kconfig
> @@ -15,6 +15,19 @@ if GNSS
>  config GNSS_SERIAL
>  	tristate
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
> +
>  config GNSS_SIRF_SERIAL
>  	tristate "SiRFstar GNSS receiver support"
>  	depends on SERIAL_DEV_BUS
> diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
> index 5cf0ebe0330a..451f11401ecc 100644
> --- a/drivers/gnss/Makefile
> +++ b/drivers/gnss/Makefile
> @@ -9,6 +9,9 @@ gnss-y := core.o
>  obj-$(CONFIG_GNSS_SERIAL)		+= gnss-serial.o
>  gnss-serial-y := serial.o
>  
> +obj-$(CONFIG_GNSS_MTK_SERIAL)		+= gnss-mtk.o
> +gnss-mtk-y := mtk.o
> +
>  obj-$(CONFIG_GNSS_SIRF_SERIAL)		+= gnss-sirf.o
>  gnss-sirf-y := sirf.o
>  
> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
> new file mode 100644
> index 000000000000..a5aad08fb9d7
> --- /dev/null
> +++ b/drivers/gnss/mtk.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mediatek GNSS receiver driver
> + *
> + * Copyright (C) 2018 Johan Hovold <johan@kernel.org>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/gnss.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
> +
> +#include "serial.h"
> +
> +struct mtk_data {
> +	struct regulator *v_bckp;
> +	struct regulator *vcc;
> +};
> +
> +static int mtk_set_active(struct gnss_serial *gserial)
> +{
> +	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
> +	int ret;
> +
> +	ret = regulator_enable(data->vcc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

Hello

This could be simplified to return regulator_enable(data->vcc);
Furthermore, after this simplification, the function seems useless.

Same comment for mtk_set_standby()

Regards

