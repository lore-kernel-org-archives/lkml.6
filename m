Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258E6C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03B32146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMv6g9jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03B32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeK3KiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:38:19 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44677 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3KiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:38:19 -0500
Received: by mail-yb1-f193.google.com with SMTP id p144-v6so1486149yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gt4EoF2vOiJh9ZsMeL183fii719T/cymB9v4xfBeHo0=;
        b=NMv6g9jRK4Sl/TiCwbpBviZgwGkKl22YtisBw74TyCX9Ux8GM1Rub4iRQg/ssEPwH6
         +YRXQuSd/CjW/HP7RtzSSsHY2GN5ixbS26OWUmsYQ7TQ+2VLxXNYJvamOI9it7WAtUpE
         SyLdKnclzli+h6MLSI+Y9TWhJnx85+4CHb28AV9ix1qgCSqVbiGr1DPNnPOSDqW2jZ1O
         Cn0tQjCzQtDqaoguAxlsD0RCyZTzFCwmiTS5ryMMi7ET43u6/31+3P51FMqhUNWgygON
         INf4iDywcS8jHENr/97TC9ul83zK4df6g2lNbZSJC0dC+ne4YiPP7LNbAcsMWnKa1Wa8
         Na1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gt4EoF2vOiJh9ZsMeL183fii719T/cymB9v4xfBeHo0=;
        b=PdCUHVd8TF/lruOQv40rz7Pr5QLEPaVPXCx6Hw+mH7UqU0wYiu4kTMEG9DcXkRRlw6
         8ciINy1D+WXJ30ho3bv5TOLJCb2k7/5qPacMjTZOQoI7rMQ4gaDUxkGbxDQyUoKZv/Q6
         dQAKig0Lify3+eFJsE1X0teYUjLAVZ5N6BPURsCAPffFi1yrfg7X6xz7zVhwPHW0mEz3
         9B+TJCx09fGYCyja1ph40F7Hz5pCjc7i7K4/FMKOgDQaFWhLTmU64QPu3vJCkPAAOIHx
         NL05Mtaib7mpM4fcGZSyCjsr/8N5NW4Uul0mHCCdKiMKxtUnyRfTUVXt4cbcQLbBrD/q
         nE/w==
X-Gm-Message-State: AA+aEWZYs9tiJoT5/G3Njq+B2wxbGj7gKG419filRS7UvYI+DHrcNniD
        DSv3e5f0X6PhSbFg/O+3vvKtycfebpBux+No1GuyXw==
X-Google-Smtp-Source: AFSGD/WyEOEnsPhYMuHUA122g1boiBx2gd7eZtzBn2UDIHAfHFtA1GjfmEwYeBJl+9jPnVneqyW/msk4VJDlc8dmzxg=
X-Received: by 2002:a25:b947:: with SMTP id s7-v6mr3477406ybm.282.1543534265230;
 Thu, 29 Nov 2018 15:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20181127121849.23975-1-enric.balletbo@collabora.com> <20181127121849.23975-2-enric.balletbo@collabora.com>
In-Reply-To: <20181127121849.23975-2-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 29 Nov 2018 15:30:54 -0800
Message-ID: <CABXOdTe0-0rVGcSc9pczkTVTQuZxbuG1hXOJXrXs1sfVgQ4W3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] mfd / platform: cros_ec: use devm_mfd_add_devices.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 4:18 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Use devm_mfd_add_devices() for adding cros-ec core MFD child devices. This
> reduces the need of remove callback from platform/chrome for removing the
> MFD child devices.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Removed cros_ec_remove from include file.
>
> Changes in v2:
> - Use devm only for the cros-ec core.
>
>  drivers/mfd/cros_ec.c                 | 14 +++-----------
>  drivers/mfd/cros_ec_dev.c             |  1 +
>  drivers/platform/chrome/cros_ec_i2c.c | 10 ----------
>  drivers/platform/chrome/cros_ec_lpc.c |  4 ----
>  drivers/platform/chrome/cros_ec_spi.c | 11 -----------
>  include/linux/mfd/cros_ec.h           | 10 ----------
>  6 files changed, 4 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index fe6f83766144..6acfe036d522 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -129,8 +129,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 }
>         }
>
> -       err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell, 1,
> -                             NULL, ec_dev->irq, NULL);
> +       err = devm_mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_cell,
> +                                  1, NULL, ec_dev->irq, NULL);
>         if (err) {
>                 dev_err(dev,
>                         "Failed to register Embedded Controller subdevice %d\n",
> @@ -147,7 +147,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                  * - the EC is responsive at init time (it is not true for a
>                  *   sensor hub.
>                  */
> -               err = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
> +               err = devm_mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO,
>                                       &ec_pd_cell, 1, NULL, ec_dev->irq, NULL);
>                 if (err) {
>                         dev_err(dev,
> @@ -181,14 +181,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  }
>  EXPORT_SYMBOL(cros_ec_register);
>
> -int cros_ec_remove(struct cros_ec_device *ec_dev)
> -{
> -       mfd_remove_devices(ec_dev->dev);
> -
> -       return 0;
> -}
> -EXPORT_SYMBOL(cros_ec_remove);
> -
>  #ifdef CONFIG_PM_SLEEP
>  int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  {
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 8f9d6964173e..ff788d3e6d5f 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -493,6 +493,7 @@ static int ec_device_remove(struct platform_device *pdev)
>
>         cros_ec_debugfs_remove(ec);
>
> +       mfd_remove_devices(ec->dev);
>         cdev_del(&ec->cdev);
>         device_unregister(&ec->class_dev);
>         return 0;
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index ef9b4763356f..9a009eaa4ada 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -317,15 +317,6 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
>         return 0;
>  }
>
> -static int cros_ec_i2c_remove(struct i2c_client *client)
> -{
> -       struct cros_ec_device *ec_dev = i2c_get_clientdata(client);
> -
> -       cros_ec_remove(ec_dev);
> -
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int cros_ec_i2c_suspend(struct device *dev)
>  {
> @@ -376,7 +367,6 @@ static struct i2c_driver cros_ec_driver = {
>                 .pm     = &cros_ec_i2c_pm_ops,
>         },
>         .probe          = cros_ec_i2c_probe,
> -       .remove         = cros_ec_i2c_remove,
>         .id_table       = cros_ec_i2c_id,
>  };
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index e1b75775cd4a..14684a56e40f 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -327,7 +327,6 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>
>  static int cros_ec_lpc_remove(struct platform_device *pdev)
>  {
> -       struct cros_ec_device *ec_dev;
>         struct acpi_device *adev;
>
>         adev = ACPI_COMPANION(&pdev->dev);
> @@ -335,9 +334,6 @@ static int cros_ec_lpc_remove(struct platform_device *pdev)
>                 acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
>                                            cros_ec_lpc_acpi_notify);
>
> -       ec_dev = platform_get_drvdata(pdev);
> -       cros_ec_remove(ec_dev);
> -
>         return 0;
>  }
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 2060d1483043..6cfbc2835beb 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -685,16 +685,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>         return 0;
>  }
>
> -static int cros_ec_spi_remove(struct spi_device *spi)
> -{
> -       struct cros_ec_device *ec_dev;
> -
> -       ec_dev = spi_get_drvdata(spi);
> -       cros_ec_remove(ec_dev);
> -
> -       return 0;
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int cros_ec_spi_suspend(struct device *dev)
>  {
> @@ -733,7 +723,6 @@ static struct spi_driver cros_ec_driver_spi = {
>                 .pm     = &cros_ec_spi_pm_ops,
>         },
>         .probe          = cros_ec_spi_probe,
> -       .remove         = cros_ec_spi_remove,
>         .id_table       = cros_ec_spi_id,
>  };
>
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index e44e3ec8a9c7..706dd724de52 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -281,16 +281,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>                             struct cros_ec_command *msg);
>
> -/**
> - * cros_ec_remove() - Remove a ChromeOS EC.
> - * @ec_dev: Device to register.
> - *
> - * Call this to deregister a ChromeOS EC, then clean up any private data.
> - *
> - * Return: 0 on success or negative error code.
> - */
> -int cros_ec_remove(struct cros_ec_device *ec_dev);
> -
>  /**
>   * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
>   * @ec_dev: Device to register.
> --
> 2.19.1
>
