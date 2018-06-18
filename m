Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EDCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8A020874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DftEAdYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8A020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754934AbeFRGfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:35:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35338 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeFRGfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:35:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id l10-v6so15501338wrn.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RYCeT4CMy0nsH01q1weMV4kQ4UWY5XFUALTlmnSzlOs=;
        b=DftEAdYPMDQ2WfyGiKkIQX82RRQPM1ZOtWeFI3hUue74+CbHtPKVtVloQbbD6YiyZO
         vq8nG7PqE+Hi3/YRqmmpMlqEH73seP6kpG2K1Rv1IkAn08rDjWhx+XeCp5VXuktt/TtL
         DqKRBJJV3uruyWpvSU0wWjX576O2JJQiC91mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RYCeT4CMy0nsH01q1weMV4kQ4UWY5XFUALTlmnSzlOs=;
        b=ZueoIFFM6aXvqsyimNTZw918qfoVNprg+/Ue70WoxtM7zSwxF6EidpA/gqMJjyDAnJ
         r/ARyAqJcNBltdYFwXdyk8mHy3oElf67kNtKzp6FOoo95VleAX4Mo8zm1l755RXf9PDa
         PumKmerjm8n4Fek/uRL4JTUmHzfH+hhDV8byFE8RJ4ge4SvNK64RN2VoJnlQTBcm7V4y
         e9AyEbQbUBG7eGQg6xjhUXOLyDvEn+Tx6smVf2M60FkaVooQ+Y+kBywLjTd/qXqxUyNY
         cftkIXfOgqDH+eTZhdXCyLZU4HNP53OzpRNUfxWd39bcPfXvhSMBMgCKnAKXiMUCQDIs
         8xZA==
X-Gm-Message-State: APt69E3SZwkqJPaPZT9OtizDjlEoYTWK/swo1irbZJRcVuI/x4lNnktk
        /PB22/huLdb3F8az46WdlPeOkA==
X-Google-Smtp-Source: ADUXVKLqdyiU1PPpUTRYRyovn34mVuXc8QnsD+zWbI33kpH7vmWRvIDq/6raiatQTx7WTXa4zmpKCA==
X-Received: by 2002:adf:9634:: with SMTP id b49-v6mr9121891wra.253.1529303736436;
        Sun, 17 Jun 2018 23:35:36 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id t1-v6sm6176676wmt.40.2018.06.17.23.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:35:35 -0700 (PDT)
Date:   Mon, 18 Jun 2018 07:35:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enrico Granata <egranata@google.com>
Cc:     linux-kernel@vger.kernel.org, egranata@chromium.org,
        bleung@chromium.org, olof@lixom.net, gwendal@chromium.org
Subject: Re: [PATCH v3] cros_ec: cleanup dependency chain for cros_ec modules
Message-ID: <20180618063534.GG31141@dell>
References: <CAMHSBOUtysO1Mj6stn1_wQ95s7mH5LuKD_Yd-4YZr7m7rCDkSQ@mail.gmail.com>
 <20180605004354.247410-1-egranata@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180605004354.247410-1-egranata@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Jun 2018, Enrico Granata wrote:

> From: Enrico Granata <egranata@chromium.org>
> 
> If one builds the Chrome EC support as modules, there is no explicit
> dependency chain amongst the several modules (LPC, CHARDEV, CORE, ...)
> 
> This makes it possible - for instance - to rmmod cros_ec_core, even though
> cros_ec_dev actively uses it for data transport to the EC chip.
> 
> This commit makes two changes in an attempt to address this:
> a) moves cros_ec_proto.c as part of the CORE module; this removes the
>    possibility of unloading cros_ec_core while cros_ec_dev is using it;
> b) enables cros_ec_core to explicitly register a runtime dependency on
>    the kernel module that is using its cmd and pkt transfer functions
> 
> Series-to: LKML <linux-kernel@vger.kernel.org>
> Series-cc: gwendal@google.com
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> ---
>  drivers/mfd/Kconfig                              |  1 -
>  drivers/mfd/Makefile                             |  2 +-
>  drivers/mfd/cros_ec.c                            | 18 ++++++++++++++++--
>  drivers/mfd/cros_ec_i2c.c                        |  1 +
>  drivers/{platform/chrome => mfd}/cros_ec_proto.c |  0
>  drivers/mfd/cros_ec_spi.c                        |  1 +
>  drivers/platform/chrome/Kconfig                  |  5 -----
>  drivers/platform/chrome/Makefile                 |  1 -
>  drivers/platform/chrome/cros_ec_lpc.c            |  1 +
>  include/linux/mfd/cros_ec.h                      |  2 ++
>  10 files changed, 22 insertions(+), 10 deletions(-)
>  rename drivers/{platform/chrome => mfd}/cros_ec_proto.c (100%)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..a8daa2072ae6 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -194,7 +194,6 @@ config MFD_CROS_EC
>  	tristate "ChromeOS Embedded Controller"
>  	select MFD_CORE
>  	select CHROME_PLATFORMS
> -	select CROS_EC_PROTO
>  	depends on X86 || ARM || ARM64 || COMPILE_TEST
>  	help
>  	  If you say Y here you get support for the ChromeOS Embedded
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index d9d2cf0d32ef..20537bd27695 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
>  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
> -cros_ec_core-objs		:= cros_ec.o
> +cros_ec_core-objs		:= cros_ec.o cros_ec_proto.o
>  cros_ec_core-$(CONFIG_ACPI)	+= cros_ec_acpi_gpe.o
>  obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
>  obj-$(CONFIG_MFD_CROS_EC_I2C)	+= cros_ec_i2c.o
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index d61024141e2b..9660dc0fc079 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -168,8 +168,19 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  	 */
>  	err = cros_ec_sleep_event(ec_dev, 0);
>  	if (err < 0)
> -		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
> -			err);
> +		dev_dbg(dev, "Error %d clearing sleep event to ec", err);

This change is unrelated to the patch.

> +	if (ec_dev->xfer_fcn_owner != NULL) {

if (ec_dev->xfer_fcn_owner) ?

> +		err = try_module_get(ec_dev->xfer_fcn_owner);
> +		if (err < 0) {

This logic is wrong.  try_module_get() returns a bool.

> +			dev_err(dev, "Error %d acquiring transfer module", err);
> +			return err;
> +		}
> +		dev_info(dev, "Transfer module %p get successfully",
> +			 ec_dev->xfer_fcn_owner);
> +	} else {
> +		dev_warn(dev, "No transfer module registered");
> +	}
>  
>  	dev_info(dev, "Chrome EC device registered\n");
>  
> @@ -193,6 +204,9 @@ int cros_ec_remove(struct cros_ec_device *ec_dev)
>  	if (ec_dev->irq)
>  		free_irq(ec_dev->irq, ec_dev);
>  
> +	if (ec_dev->xfer_fcn_owner != NULL)

As above.

> +		module_put(ec_dev->xfer_fcn_owner);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(cros_ec_remove);
> diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/mfd/cros_ec_i2c.c
> index 9f70de1e4c70..72b0473eb868 100644
> --- a/drivers/mfd/cros_ec_i2c.c
> +++ b/drivers/mfd/cros_ec_i2c.c
> @@ -302,6 +302,7 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
>  	ec_dev->irq = client->irq;
>  	ec_dev->cmd_xfer = cros_ec_cmd_xfer_i2c;
>  	ec_dev->pkt_xfer = cros_ec_pkt_xfer_i2c;
> +	ec_dev->xfer_fcn_owner = THIS_MODULE;
>  	ec_dev->phys_name = client->adapter->name;
>  	ec_dev->din_size = sizeof(struct ec_host_response_i2c) +
>  			   sizeof(struct ec_response_get_protocol_info);
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/mfd/cros_ec_proto.c
> similarity index 100%
> rename from drivers/platform/chrome/cros_ec_proto.c
> rename to drivers/mfd/cros_ec_proto.c
> diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
> index 2060d1483043..ce2849790b95 100644
> --- a/drivers/mfd/cros_ec_spi.c
> +++ b/drivers/mfd/cros_ec_spi.c
> @@ -666,6 +666,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>  	ec_dev->irq = spi->irq;
>  	ec_dev->cmd_xfer = cros_ec_cmd_xfer_spi;
>  	ec_dev->pkt_xfer = cros_ec_pkt_xfer_spi;
> +	ec_dev->xfer_fcn_owner = THIS_MODULE;
>  	ec_dev->phys_name = dev_name(&ec_spi->spi->dev);
>  	ec_dev->din_size = EC_MSG_PREAMBLE_COUNT +
>  			   sizeof(struct ec_host_response) +
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index e728a96cabfd..a050c9e8b506 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -65,11 +65,6 @@ config CROS_EC_LPC_MEC
>  	  If you have a ChromeOS Embedded Controller Microchip EC variant
>  	  choose Y here.
>  
> -config CROS_EC_PROTO
> -        bool
> -        help
> -          ChromeOS EC communication protocol helpers.
> -
>  config CROS_KBD_LED_BACKLIGHT
>  	tristate "Backlight LED support for Chrome OS keyboards"
>  	depends on LEDS_CLASS && ACPI
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index ff3b369911f0..0b5e26ca9c96 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -8,5 +8,4 @@ obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
>  cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
> -obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 3682e1539251..8f02b188bd3f 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -282,6 +282,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  	ec_dev->phys_name = dev_name(dev);
>  	ec_dev->cmd_xfer = cros_ec_cmd_xfer_lpc;
>  	ec_dev->pkt_xfer = cros_ec_pkt_xfer_lpc;
> +	ec_dev->xfer_fcn_owner = THIS_MODULE;
>  	ec_dev->cmd_readmem = cros_ec_lpc_readmem;
>  	ec_dev->din_size = sizeof(struct ec_host_response) +
>  			   sizeof(struct ec_response_get_protocol_info);
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 2d4e23c9ea0a..5239107e5091 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -18,6 +18,7 @@
>  
>  #include <linux/cdev.h>
>  #include <linux/device.h>
> +#include <linux/module.h>
>  #include <linux/notifier.h>
>  #include <linux/mfd/cros_ec_commands.h>
>  #include <linux/mutex.h>
> @@ -139,6 +140,7 @@ struct cros_ec_device {
>  	int dout_size;
>  	bool wake_enabled;
>  	bool suspended;
> +	struct module *xfer_fcn_owner;

Why do you have to introduce a new property?

Can't you just use THIS_MODULE in try_module_get()?

>  	int (*cmd_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);
>  	int (*pkt_xfer)(struct cros_ec_device *ec,

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
