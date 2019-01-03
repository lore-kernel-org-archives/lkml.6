Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4654F2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7u6/SLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbfACQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:05:58 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35606 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfACQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:05:58 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so37386971qtc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6X0CksTPfo6y4lLjNgC7li36DRnvY8pWJQkRD6Jh4/Y=;
        b=i7u6/SLBtvfm1xKi+H/JtfsFUrF+i2Y0Bk46aZqYTfHXzkvevCpJI7eOHdXetbkwGv
         Fcs1Xf5tY8VdgwNLBCe4TqOSL1kUgi7HbcSKWHhesUIptnt+xYxvTxn116dCFyoMKCwL
         nF1bQI7htfNT/p19TNJHtNhQZApsh1DDOzwE/iRHu9eGogLsX0x+XfCeBRxembpe39LY
         Hj35VwIZ106qwnqgrq0IHS7sP4h6N7rrR3iBDNiJStvLD5J3MjzAl8Tu3e7hldZefGHy
         sXx5hEE6TMP+Gu1DsE19+ellts13tM34SnbF3UR+C5lCBXoBqD+QHmJM1llgzp7r0pmN
         SdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6X0CksTPfo6y4lLjNgC7li36DRnvY8pWJQkRD6Jh4/Y=;
        b=d96UH/+4vQvCL7PzrDsydtiOXsQ/LVoe3BecI3a8moZn1r8dFS+HsPeK8taTGISvlJ
         KYYFdQy1dSY3DdU0hBJq4RaoxvDHuev5ow+QsHmBOJ2qFdJXuSY5W9t09AesnJD2jrul
         E/LvYe5yN0tIAHMwUpAaEJBM1a1zJkBgIZk8zhLS+WwTSIQZRaiTJF0kXB7b6dx1l+PG
         A2IjPPNX5nDgfFeEvZ8owELt58ny6DlIIBuj6krGENC0J0tRBgI149a5XRfdwgOIHunE
         k/37IYleI37/vFbF5zjYbHkJxe2Hb137s0tGQ/NJjZDdRHpA2ZgJSEQCZv30fTd4L2R+
         NQWw==
X-Gm-Message-State: AJcUukd5bvlZ5NVPSmy5pZZqEYxNGuMH3OUh04iCt0Eq2m4Sxa/aX3EG
        vlPJx/f1AOuvgRsPYlF6y0MsOOxKd9JKE3P2mtRTedaftn0=
X-Google-Smtp-Source: AFSGD/VHvCd6m62nwlbECEtRZbmaKy6w9FbY1ctDyiAm/08V+cFJR3qAoVqUkIkVZlWTvtlwPY3UTx1hui5wljHpX00=
X-Received: by 2002:ac8:2585:: with SMTP id e5mr46973326qte.233.1546531556441;
 Thu, 03 Jan 2019 08:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20181226075330.82462-1-pihsun@chromium.org> <20181226075330.82462-6-pihsun@chromium.org>
In-Reply-To: <20181226075330.82462-6-pihsun@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 3 Jan 2019 17:05:44 +0100
Message-ID: <CAFqH_52NcK932VYjbzTXCuiFip9Wed2UjtfTWs3aFH+6YqPNiQ@mail.gmail.com>
Subject: Re: [RFC,5/5] mfd: cros_ec: add EC host command support using rpmsg.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Many thanks for sending this. Please, add Guenter and me for next
versions, we are interested in it, thanks :)

Missatge de Pi-Hsun Shih <pihsun@chromium.org> del dia dc., 26 de des.
2018 a les 8:57:
>
> Add EC host command support through rpmsg.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c               |   9 ++
>  drivers/platform/chrome/Kconfig         |   8 ++
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/cros_ec_rpmsg.c | 164 ++++++++++++++++++++++++
>  include/linux/mfd/cros_ec.h             |   1 +
>  include/linux/mfd/cros_ec_commands.h    |   2 +
>  6 files changed, 185 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 2d0fee488c5aa8..67983853413d07 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -414,6 +414,15 @@ static int ec_device_probe(struct platform_device *pdev)
>         device_initialize(&ec->class_dev);
>         cdev_init(&ec->cdev, &fops);
>
> +       if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
> +               dev_info(dev, "SCP detected.\n");
> +               /*
> +                * Help userspace differentiating ECs from SCP,
> +                * regardless of the probing order.
> +                */
> +               ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
> +       }
> +

Why userspace should know that this is an SCP? From the userspace
point of view shouldn't be this transparent, we don't do distinctions
when the transport layer is i2c, spi or lpc, and I think that the
cros_ec_rpmsg driver is a cros-ec transport layer, like these. So, I
think that this is not needed.

>         /*
>          * Add the class device
>          * Link to the character device for creating the /dev entry
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 16b1615958aa2d..b03d68eb732177 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -72,6 +72,14 @@ config CROS_EC_SPI
>           response time cannot be guaranteed, we support ignoring
>           'pre-amble' bytes before the response actually starts.
>
> +config CROS_EC_RPMSG
> +       tristate "ChromeOS Embedded Controller (rpmsg)"
> +       depends on MFD_CROS_EC && RPMSG

I think that this driver is DT-only, && OF ?

> +       help
> +         If you say Y here, you get support for talking to the ChromeOS EC
> +         through rpmsg. This uses a simple byte-level protocol with a
> +         checksum.
> +
>  config CROS_EC_LPC
>          tristate "ChromeOS Embedded Controller (LPC)"
>          depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index cd591bf872bbe9..3e3190af2b50f4 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -8,6 +8,7 @@ cros_ec_ctl-objs                        := cros_ec_sysfs.o cros_ec_lightbar.o \
>  obj-$(CONFIG_CROS_EC_CTL)              += cros_ec_ctl.o
>  obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
> +obj-$(CONFIG_CROS_EC_RPMSG)            += cros_ec_rpmsg.o
>  cros_ec_lpcs-objs                      := cros_ec_lpc.o cros_ec_lpc_reg.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) += cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> new file mode 100644
> index 00000000000000..f123ca6d1c029c
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright 2018 Google LLC.
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/cros_ec.h>
> +#include <linux/mfd/cros_ec_commands.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/rpmsg.h>
> +#include <linux/slab.h>
> +
> +/**
> + * cros_ec_cmd_xfer_rpmsg - Transfer a message over rpmsg and receive the reply
> + *
> + * This is only used for old EC proto version, and is not supported for this
> + * driver.
> + *
> + * @ec_dev: ChromeOS EC device
> + * @ec_msg: Message to transfer
> + */
> +static int cros_ec_cmd_xfer_rpmsg(struct cros_ec_device *ec_dev,
> +                                 struct cros_ec_command *ec_msg)
> +{
> +       return -EINVAL;
> +}
> +
> +/**
> + * cros_ec_pkt_xfer_rpmsg - Transfer a packet over rpmsg and receive the reply
> + *
> + * @ec_dev: ChromeOS EC device
> + * @ec_msg: Message to transfer
> + */
> +static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
> +                                 struct cros_ec_command *ec_msg)
> +{
> +       struct ec_host_response *response;
> +       struct rpmsg_device *rpdev = ec_dev->priv;
> +       int len;
> +       u8 sum;
> +       int ret;
> +       int i;
> +
> +       ec_msg->result = 0;
> +       len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +       dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
> +
> +       // TODO: This currently relies on that mtk_rpmsg send actually blocks
> +       // until ack. Should do the wait here instead.

Use standard C style comments.

> +       ret = rpmsg_send(rpdev->ept, ec_dev->dout, len);
> +

Remove that empty  line.

> +       if (ret) {
> +               dev_err(ec_dev->dev, "rpmsg send failed\n");
> +               return ret;
> +       }
> +
> +       /* check response error code */
> +       response = (struct ec_host_response *)ec_dev->din;
> +       ec_msg->result = response->result;
> +
> +       ret = cros_ec_check_result(ec_dev, ec_msg);
> +       if (ret)
> +               goto exit;
> +
> +       if (response->data_len > ec_msg->insize) {
> +               dev_err(ec_dev->dev, "packet too long (%d bytes, expected %d)",
> +                       response->data_len, ec_msg->insize);
> +               ret = -EMSGSIZE;
> +               goto exit;
> +       }
> +
> +       /* copy response packet payload and compute checksum */
> +       memcpy(ec_msg->data, ec_dev->din + sizeof(*response),
> +              response->data_len);
> +
> +       sum = 0;
> +       for (i = 0; i < sizeof(*response) + response->data_len; i++)
> +               sum += ec_dev->din[i];
> +
> +       if (sum) {
> +               dev_err(ec_dev->dev, "bad packet checksum, calculated %x\n",
> +                       sum);
> +               ret = -EBADMSG;
> +               goto exit;
> +       }
> +
> +       ret = response->data_len;
> +exit:
> +       if (ec_msg->command == EC_CMD_REBOOT_EC)
> +               msleep(EC_REBOOT_DELAY_MS);

Can you explain why this sleep is needed?

> +
> +       return ret;
> +}
> +
> +static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> +                                 int len, void *priv, u32 src)
> +{
> +       struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
> +
> +       if (len > ec_dev->din_size) {
> +               dev_warn(ec_dev->dev,
> +                        "ipi received length %d > din_size, truncating", len);
> +               len = ec_dev->din_size;
> +       }
> +
> +       memcpy(ec_dev->din, data, len);
> +
> +       return 0;
> +}
> +
> +static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
> +{
> +       struct device *dev = &rpdev->dev;
> +
Remove that empty line

> +       struct cros_ec_device *ec_dev;
> +       int ret;
> +
> +       ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> +       if (!ec_dev)
> +               return -ENOMEM;
> +
> +       ec_dev->dev = dev;
> +       ec_dev->priv = rpdev;
> +       ec_dev->cmd_xfer = cros_ec_cmd_xfer_rpmsg;
> +       ec_dev->pkt_xfer = cros_ec_pkt_xfer_rpmsg;
> +       ec_dev->phys_name = dev_name(&rpdev->dev);
> +       ec_dev->din_size = sizeof(struct ec_host_response) +
> +                          sizeof(struct ec_response_get_protocol_info);
> +       ec_dev->dout_size = sizeof(struct ec_host_request);
> +       dev_set_drvdata(dev, ec_dev);
> +
> +       ret = cros_ec_register(ec_dev);
> +       if (ret)

I'd add an error message here

  dev_err(dev, "cannot register EC\n"

> +               return ret;
> +
> +       return 0;
> +}
> +
> +static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)

This function will not be needed after apply [1]. I would recommend
base your patches on top of [2]

[1] https://lkml.org/lkml/2018/12/12/672
[2] https://lkml.org/lkml/2018/12/12/679

> +{
> +       struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
> +
> +       cros_ec_remove(ec_dev);
> +}
> +

How this driver is instantiated?

I expect something like this here (like the other transport layers)

static const struct of_device_id cros_ec_rpmsg_of_match[] = {
        { .compatible = "google,cros-ec-rpmsg", },
        { }
};
MODULE_DEVICE_TABLE(of, cros_ec_rpmsg_of_match);

And the DT containing the compatible = "google,cros-ec-rpmsg" like the
other cros-ec transport layers.

> +static const struct rpmsg_device_id cros_ec_rpmsg_device_id[] = {
> +       { .name = "cros-ec-rpmsg", },
> +       { /* sentinel */ },

I got convinced that the '/* sentinel */' comment doesn't means
anything, so use { } only here, remove the comment and the last comma
(there is nothing to separate)
+      { }

> +};
> +
> +static struct rpmsg_driver cros_ec_driver_rpmsg = {
> +       .drv.name       = KBUILD_MODNAME,

And something like this here
        .drv = {
                .name   = "cros-ec-rpmsg",
                .of_match_table = cros_ec_rpmsg_of_match,
        },

> +       .id_table       = cros_ec_rpmsg_device_id,
> +       .probe          = cros_ec_rpmsg_probe,
> +       .remove         = cros_ec_rpmsg_remove,
> +       .callback       = cros_ec_rpmsg_callback,
> +};
> +
> +module_rpmsg_driver(cros_ec_driver_rpmsg);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index de8b588c8776da..fd297cf8f97295 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -24,6 +24,7 @@
>
>  #define CROS_EC_DEV_NAME "cros_ec"
>  #define CROS_EC_DEV_PD_NAME "cros_pd"
> +#define CROS_EC_DEV_SCP_NAME "cros_scp"

I think this definition is not needed.

>
>  /*
>   * The EC is unresponsive for a time after a reboot command.  Add a
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index fc91082d4c357b..3e5da6e93b2f42 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -856,6 +856,8 @@ enum ec_feature_code {
>         EC_FEATURE_RTC = 27,
>         /* EC supports CEC commands */
>         EC_FEATURE_CEC = 35,
> +       /* The MCU exposes a SCP */
> +       EC_FEATURE_SCP = 39,

Same here, I think this is not needed.
>  };
>
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> --
> 2.20.1.415.g653613c723-goog
>

Thanks,
  Enric
