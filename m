Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3497254D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPydISIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3497254D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbeGBOkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:40:01 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40063 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbeGBOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:39:59 -0400
Received: by mail-yb0-f195.google.com with SMTP id y11-v6so1674902ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz+zrhtO+HnFRVhX/Y2N4vXWHWV9bJFd3IIgjIJEiYk=;
        b=wPydISISGtE3A2kCaZ++vxncI/Ig/9UyWqFxuMDA4HTM9HgXqKXZHFwli18MDbrVqk
         HBbcdNQ6n2uTc3uumNYr2WxkfqxuWH3Detzn/xGzW/GGHMorZ5fK7ztMp04J7Y0DjtYD
         1AdWF8X+Q8oCWFirNLJGH4igyuNTvTNZCpAjcpy7rwZowh/UzWp6Xf1aqIbMJ/8nxzr4
         ASs276CFAu9c98fPZiXxs9GMmTbHNBjOTn/+GfSgR5UF/5CaD/1LRlMKP++Fw7i1ljt6
         L9oDXH19hTpiShCUlzukok5Rc1nE5YV128ZSP1AtK8YtkLHDLtanaChSQvnF/rk3+O1h
         InNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz+zrhtO+HnFRVhX/Y2N4vXWHWV9bJFd3IIgjIJEiYk=;
        b=Un4DwCOvdzNTL5n/36UIPcfLe2moejNtSR/kuMjdsJXT48ZZQ+Fu64nlO7REq/Kniw
         PQPKI3J4Ql3mE9h3OdAA+5nAHneegZ/0Z0lWeyatCYzirr24wl6GJNmitg7Os9IgvLeK
         2J0MJ8c1oApXex+IM0TzJbAz+3hSsS6TwL3lf0zOFpQWvB9RWYwGx26hPe/SIOdX41vG
         8h9IliHS8Ih2I298WeGyiuUj6U4NaFKViUCqEreKym4yxCa818BXPyPRXgmTmz28InbI
         U1CmKheApnd+JMmElDhD3t1IPghX/wyYlEH9DhWn+akGVbBVsFaGJ/+qi+ln/IushhUF
         FEjg==
X-Gm-Message-State: APt69E0sAGwKO7EDlCNl+ErNMMzwhGaoTdh00U5VGHiTg2isdH395I3/
        hIL+p1ncC/Y4e7wxyo8H3UHMPXMLxBgZWbHcKBMRkQ==
X-Google-Smtp-Source: ADUXVKKPx5EHqoPXEFFQIednj5im4xUb37dAu+UuSo+QBR3m9kKeJ+tBpM7rrd9ZHZneShPo6KncTHW3u1KgIy7C+x4=
X-Received: by 2002:a25:9802:: with SMTP id a2-v6mr12776956ybo.320.1530542397151;
 Mon, 02 Jul 2018 07:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180702102201.13461-1-enric.balletbo@collabora.com> <20180702102201.13461-2-enric.balletbo@collabora.com>
In-Reply-To: <20180702102201.13461-2-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 2 Jul 2018 07:39:45 -0700
Message-ID: <CABXOdTcWnCTbn4NTmyZY53asOVXB47Uc2PNV4WC-kwbXU5tj3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: Move cros-ec transport drivers to drivers/platform.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>, kgene@kernel.org,
        krzk@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 3:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> There are some cros-ec transport drivers (I2C, SPI) living in MFD, while
> others (LPC) living in drivers/platform. The transport drivers are more
> platform specific. So, move the I2C and SPI transport drivers to the
> platform/chrome directory. The patch also removes the MFD_ prefix of
> their Kconfig symbols.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/mfd/Kconfig                           | 20 -------------------
>  drivers/mfd/Makefile                          |  2 --
>  drivers/platform/chrome/Kconfig               | 20 +++++++++++++++++++
>  drivers/platform/chrome/Makefile              |  2 ++
>  .../{mfd => platform/chrome}/cros_ec_i2c.c    |  0
>  .../{mfd => platform/chrome}/cros_ec_spi.c    |  0
>  6 files changed, 22 insertions(+), 22 deletions(-)
>  rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
>  rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..013458e728dc 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -202,26 +202,6 @@ config MFD_CROS_EC
>           You also need to enable the driver for the bus you are using. The
>           protocol for talking to the EC is defined by the bus driver.
>
> -config MFD_CROS_EC_I2C
> -       tristate "ChromeOS Embedded Controller (I2C)"
> -       depends on MFD_CROS_EC && I2C
> -
> -       help
> -         If you say Y here, you get support for talking to the ChromeOS
> -         EC through an I2C bus. This uses a simple byte-level protocol with
> -         a checksum. Failing accesses will be retried three times to
> -         improve reliability.
> -
> -config MFD_CROS_EC_SPI
> -       tristate "ChromeOS Embedded Controller (SPI)"
> -       depends on MFD_CROS_EC && SPI
> -
> -       ---help---
> -         If you say Y here, you get support for talking to the ChromeOS EC
> -         through a SPI bus, using a byte-level protocol. Since the EC's
> -         response time cannot be guaranteed, we support ignoring
> -         'pre-amble' bytes before the response actually starts.
> -
>  config MFD_CROS_EC_CHARDEV
>          tristate "Chrome OS Embedded Controller userspace device interface"
>          depends on MFD_CROS_EC
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e9fd20dba18d..d13e859d7c1e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -14,8 +14,6 @@ obj-$(CONFIG_MFD_BCM590XX)    += bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)    += bd9571mwv.o
>  cros_ec_core-objs              := cros_ec.o
>  obj-$(CONFIG_MFD_CROS_EC)      += cros_ec_core.o
> -obj-$(CONFIG_MFD_CROS_EC_I2C)  += cros_ec_i2c.o
> -obj-$(CONFIG_MFD_CROS_EC_SPI)  += cros_ec_spi.o
>  obj-$(CONFIG_MFD_CROS_EC_CHARDEV) += cros_ec_dev.o
>  obj-$(CONFIG_MFD_EXYNOS_LPASS) += exynos-lpass.o
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index cb0df9eb3e0f..16b1615958aa 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -52,6 +52,26 @@ config CHROMEOS_TBMC
>  config CROS_EC_CTL
>          tristate
>
> +config CROS_EC_I2C
> +       tristate "ChromeOS Embedded Controller (I2C)"
> +       depends on MFD_CROS_EC && I2C
> +
> +       help
> +         If you say Y here, you get support for talking to the ChromeOS
> +         EC through an I2C bus. This uses a simple byte-level protocol with
> +         a checksum. Failing accesses will be retried three times to
> +         improve reliability.
> +
> +config CROS_EC_SPI
> +       tristate "ChromeOS Embedded Controller (SPI)"
> +       depends on MFD_CROS_EC && SPI
> +
> +       ---help---
> +         If you say Y here, you get support for talking to the ChromeOS EC
> +         through a SPI bus, using a byte-level protocol. Since the EC's
> +         response time cannot be guaranteed, we support ignoring
> +         'pre-amble' bytes before the response actually starts.
> +
>  config CROS_EC_LPC
>          tristate "ChromeOS Embedded Controller (LPC)"
>          depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index e44c37a63fa9..cd591bf872bb 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -6,6 +6,8 @@ obj-$(CONFIG_CHROMEOS_TBMC)             += chromeos_tbmc.o
>  cros_ec_ctl-objs                       := cros_ec_sysfs.o cros_ec_lightbar.o \
>                                            cros_ec_vbc.o cros_ec_debugfs.o
>  obj-$(CONFIG_CROS_EC_CTL)              += cros_ec_ctl.o
> +obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
> +obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
>  cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_reg.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) += cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
> diff --git a/drivers/mfd/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> similarity index 100%
> rename from drivers/mfd/cros_ec_i2c.c
> rename to drivers/platform/chrome/cros_ec_i2c.c
> diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> similarity index 100%
> rename from drivers/mfd/cros_ec_spi.c
> rename to drivers/platform/chrome/cros_ec_spi.c
> --
> 2.18.0
>
