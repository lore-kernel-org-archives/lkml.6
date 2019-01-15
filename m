Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE69C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A4B20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE0UB8te"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388707AbfAOSKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:10:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35803 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfAOSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:10:16 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so4067593qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YL2pgUyMN7hjhGpRrj9zzSJNBGnDWKYhDv89yXzuMs=;
        b=AE0UB8tebDMN7dpME9/HmVCXVRfvu2ERg6doaiRJNTuo/JB5CNrXUI97nDF9A/qXAn
         goS4/qzEKERPzCNiWtDlgcH/pZI4OA1t5CnScOCF0hLntSoJ9W7GTPR1fTNrH3iebaDW
         FETSND2lZWrN0iiIGQqlfOe9ybdsjr+rozCT1oVKlBlVBjuice0eAlWCggo+OFXQDS0M
         /DLV76DYaLd1/QJls1wVjwP0rfkagwfoUbVmKrro4p1AAGUTJP4+YuAntlOrDW4rEp8I
         iyXqDefw1Y8Vv1AnJwxvrHKWSlc4uSENrIEyqclnHmXcSqDpSfnHcGybMH55AZTrBB6p
         eHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YL2pgUyMN7hjhGpRrj9zzSJNBGnDWKYhDv89yXzuMs=;
        b=VxwwRswdIfLCqlQVvHvIhHAeu0v3Rdqtgqb1HK4Vb7qmsx3j8VpEWabR5AKd6olvYJ
         Q8Xoom+kJodyHEB5xlg9XH0UjmxtksGEX7BkVk5oKRisCS0lBwqrq+xHZHRMavWACly4
         viyiZADePDSQIhwITFIE8aX6YZiRm4LuutYQX8q+aAm3UbdRN7Mh+0snLK5l3/kQEcFq
         16Wbq9ZEA6L3I6lHhygkZDjLXob5qPstNdaU2TVFIahKisOM9HKVGmWoc45oS98HWIHQ
         HS1hFc3Bk89M6CapalBepCwfxBjU/V2UTzy4Yi37cDELvFMwk3/4nghCx0HKUSZfnqsu
         lyGA==
X-Gm-Message-State: AJcUukcneAfqpYLk65hVL8y/VhPzfkgNapXA0NDXnqmlWD/JA0ScxH25
        nuDxGZpWMl5lHF6G7KNhPiiQ0WDXubdZ0wbZ4zzcyDFPreI=
X-Google-Smtp-Source: ALg8bN4xGusif56Q5F+jEPX/TNtdBqdh3+n2jSgkGN0MfnyI0zbnp7KCJI4zaL8aF7GX9o+MPuj4HYfEpiK9MxWt0LY=
X-Received: by 2002:ac8:7153:: with SMTP id h19mr3745136qtp.92.1547575813785;
 Tue, 15 Jan 2019 10:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com> <20190114220356.108916-3-ncrews@google.com>
In-Reply-To: <20190114220356.108916-3-ncrews@google.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 15 Jan 2019 19:10:02 +0100
Message-ID: <CAFqH_52Nzdo99EKnOPRb=eCmcK7nB5HHmfnGPe76k9AMneZa6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] platform/chrome: Add new driver for Wilco EC
To:     Nick Crews <ncrews@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Simon Glass <sjg@chromium.org>, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

The patch looks pretty good to me, just some minor comments below ...

Missatge de Nick Crews <ncrews@google.com> del dia dl., 14 de gen.
2019 a les 23:05:
>
> From: Duncan Laurie <dlaurie@google.com>
>
> This EC is an incompatible variant of the typical Chrome OS embedded
> controller.  It uses the same low-level communication and a similar
> protocol with some significant differences.  The EC firmware does
> not support the same mailbox commands so it is not registered as a
> cros_ec device type.
>
> Signed-off-by: Duncan Laurie <dlaurie@google.com>
> Signed-off-by: Nick Crews <ncrews@google.com>
> ---
>
> Changes in v2:
> - Removed COMPILE_TEST from Kconfig because inb()/outb()
> won't work on anything but X86
> - Moved everything to wilco_ec/ subdirectory
> - Moved header file to include/platform_data/
> so could be used by future sub-drivers
> - Tweaked mailbox()
> - Removed duplicate EC_MAILBOX_DATA_SIZE defs
> - Removed some error messages / converted to dbg()
>
>  drivers/platform/chrome/Kconfig            |   4 +-
>  drivers/platform/chrome/Makefile           |   2 +
>  drivers/platform/chrome/wilco_ec/Kconfig   |  24 +++
>  drivers/platform/chrome/wilco_ec/Makefile  |   4 +
>  drivers/platform/chrome/wilco_ec/core.c    |  99 +++++++++
>  drivers/platform/chrome/wilco_ec/mailbox.c | 237 +++++++++++++++++++++
>  include/linux/platform_data/wilco-ec.h     | 138 ++++++++++++
>  7 files changed, 507 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/chrome/wilco_ec/Kconfig
>  create mode 100644 drivers/platform/chrome/wilco_ec/Makefile
>  create mode 100644 drivers/platform/chrome/wilco_ec/core.c
>  create mode 100644 drivers/platform/chrome/wilco_ec/mailbox.c
>  create mode 100644 include/linux/platform_data/wilco-ec.h
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 16b1615958aa..bf889adfd4ef 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -49,6 +49,8 @@ config CHROMEOS_TBMC
>           To compile this driver as a module, choose M here: the
>           module will be called chromeos_tbmc.
>
> +source "drivers/platform/chrome/wilco_ec/Kconfig"
> +
>  config CROS_EC_CTL
>          tristate
>
> @@ -86,7 +88,7 @@ config CROS_EC_LPC
>
>  config CROS_EC_LPC_MEC
>         bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
> -       depends on CROS_EC_LPC
> +       depends on CROS_EC_LPC || WILCO_EC
>         default n
>         help
>           If you say Y here, a variant LPC protocol for the Microchip EC
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index cd591bf872bb..7242ee2b13c5 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -13,3 +13,5 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)        += cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              += cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)            += cros_ec_proto.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)   += cros_kbd_led_backlight.o
> +
> +obj-$(CONFIG_WILCO_EC)                 += wilco_ec/
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> new file mode 100644
> index 000000000000..f8e6c9e8c5cd
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -0,0 +1,24 @@
> +menuconfig WILCO_EC_PLATFORM
> +       bool "Platform support for Wilco Embedded Controller hardware"
> +       help
> +         Say Y here to get to see options for platform support for
> +         various Wilco EC features. This option alone does
> +         not add any kernel code.
> +
> +         If you say N, all options in this submenu will be skipped and disabled.
> +
> +if WILCO_EC_PLATFORM
> +
> +config WILCO_EC
> +       tristate "ChromeOS Wilco Embedded Controller"
> +       depends on ACPI && X86
> +       select CROS_EC_LPC_MEC
> +       help
> +         If you say Y here, you get support for talking to the ChromeOS
> +         Wilco EC over an eSPI bus. This uses a simple byte-level protocol
> +         with a checksum.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called wilco_ec.
> +
> +endif # WILCO_EC_PLATFORM
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> new file mode 100644
> index 000000000000..03b32301dc61
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +wilco_ec-objs                          := core.o mailbox.o
> +obj-$(CONFIG_WILCO_EC)                 += wilco_ec.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> new file mode 100644
> index 000000000000..2d1d8d3f9a94
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mailbox interface for Wilco Embedded Controller
> + *
> + * Copyright 2018 Google LLC
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/platform_device.h>
> +
> +#include "../cros_ec_lpc_mec.h"
> +
> +static struct resource *wilco_get_resource(struct platform_device *pdev,
> +                                          int index)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_IO, index);
> +       if (!res) {
> +               dev_dbg(dev, "couldn't find IO resource %d\n", index);
> +               return NULL;
return res; ?

> +       }
> +
> +       if (!devm_request_region(dev, res->start, resource_size(res),
> +                                dev_name(dev)))
> +               return NULL;
> +
> +       return res;

return devm_request_region(dev, res->start,
resource_size(res),dev_name(dev))); ?

> +}
> +
> +static int wilco_ec_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct wilco_ec_device *ec;
> +       int ret;

This variable is not used, you can remove it.

> +
> +       ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> +       if (!ec)
> +               return -ENOMEM;

nit: I like to see a blank line here

> +       platform_set_drvdata(pdev, ec);
> +       ec->dev = dev;
> +       mutex_init(&ec->mailbox_lock);
> +
> +       /* Largest data buffer size requirement is extended data response */
> +       ec->data_size = sizeof(struct wilco_ec_response) +
> +               EC_MAILBOX_DATA_SIZE_EXTENDED;
> +       ec->data_buffer = devm_kzalloc(dev, ec->data_size, GFP_KERNEL);
> +       if (!ec->data_buffer)
> +               return -ENOMEM;
> +
> +       /* Prepare access to IO regions provided by ACPI */
> +       ec->io_data = wilco_get_resource(pdev, 0);      /* Host Data */
> +       ec->io_command = wilco_get_resource(pdev, 1);   /* Host Command */
> +       ec->io_packet = wilco_get_resource(pdev, 2);    /* MEC EMI */
> +       if (!ec->io_data || !ec->io_command || !ec->io_packet)
> +               return -ENODEV;
> +
> +       /* Initialize cros_ec register interface for communication */
> +       cros_ec_lpc_mec_init(ec->io_packet->start,
> +                            ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
> +
> +       return 0;
> +}
> +
> +static int wilco_ec_remove(struct platform_device *pdev)
> +{
> +       /* Teardown cros_ec interface */
> +       cros_ec_lpc_mec_destroy();
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id wilco_ec_acpi_device_ids[] = {
> +       { "GOOG000C", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, wilco_ec_acpi_device_ids);
> +
> +static struct platform_driver wilco_ec_driver = {
> +       .driver = {
> +               .name = "wilco_ec",
> +               .acpi_match_table = wilco_ec_acpi_device_ids,
> +       },
> +       .probe = wilco_ec_probe,
> +       .remove = wilco_ec_remove,
> +};
> +
> +module_platform_driver(wilco_ec_driver);
> +
> +MODULE_AUTHOR("Nick Crews <ncrews@google.com>");
> +MODULE_AUTHOR("Duncan Laurie <dlaurie@chromium.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("ChromeOS Wilco Embedded Controller driver");
> +MODULE_ALIAS("platform:wilco-ec");
> diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
> new file mode 100644
> index 000000000000..221de0d020cf
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/mailbox.c
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Mailbox interface for Wilco Embedded Controller
> + *
> + * Copyright 2018 Google LLC
> + *
> + * The Wilco EC is similar to a typical ChromeOS embedded controller.
> + * It uses the same MEC based low-level communication and a similar
> + * protocol, but with some important differences.  The EC firmware does
> + * not support the same mailbox commands so it is not registered as a
> + * cros_ec device type.
> + *
> + * Most messages follow a standard format, but there are some exceptions
> + * and an interface is provided to do direct/raw transactions that do not
> + * make assumptions about byte placement.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/platform_device.h>
> +
> +#include "../cros_ec_lpc_mec.h"
> +
> +/* Version of mailbox interface */
> +#define EC_MAILBOX_VERSION             0
> +
> +/* Command to start mailbox transaction */
> +#define EC_MAILBOX_START_COMMAND       0xda
> +
> +/* Version of EC protocol */
> +#define EC_MAILBOX_PROTO_VERSION       3
> +
> +/* Number of header bytes to be counted as data bytes */
> +#define EC_MAILBOX_DATA_EXTRA          2
> +
> +/* Maximum timeout */
> +#define EC_MAILBOX_TIMEOUT             HZ
> +
> +/* EC response flags */
> +#define EC_CMDR_DATA           BIT(0)  /* Data ready for host to read */
> +#define EC_CMDR_PENDING                BIT(1)  /* Write pending to EC */
> +#define EC_CMDR_BUSY           BIT(2)  /* EC is busy processing a command */
> +#define EC_CMDR_CMD            BIT(3)  /* Last host write was a command */
> +
> +/**
> + * wilco_ec_response_timed_out() - Wait for EC response.
> + * @ec: EC device.
> + *
> + * Return: true if EC timed out, false if EC did not time out.
> + */
> +static bool wilco_ec_response_timed_out(struct wilco_ec_device *ec)
> +{
> +       unsigned long timeout = jiffies + EC_MAILBOX_TIMEOUT;
> +
> +       usleep_range(200, 300);
Is this sleep really needed here? The system will not respond in less
than 200us? What happens if you just remove this line?

> +       do {
> +               if (!(inb(ec->io_command->start) &
> +                     (EC_CMDR_PENDING | EC_CMDR_BUSY)))
> +                       return false;
> +               usleep_range(100, 200);
> +       } while (time_before(jiffies, timeout));
> +
> +       return true;
> +}
> +
> +/**
> + * wilco_ec_checksum() - Compute 8bit checksum over data range.

nit: 8-bit, to be coherent with the documentation with the previous patch

> + * @data: Data to checksum.
> + * @size: Number of bytes to checksum.
> + *
> + * Return: 8bit checksum of provided data.

nit: 8-bit, to be coherent with the documentation with the previous patch

> + */
> +static u8 wilco_ec_checksum(const void *data, size_t size)
> +{
> +       u8 *data_bytes = (u8 *)data;
> +       u8 checksum = 0;
> +       size_t i;
> +
> +       for (i = 0; i < size; i++)
> +               checksum += data_bytes[i];
> +
> +       return checksum;
> +}
> +
> +/**
> + * wilco_ec_prepare() - Prepare the request structure for the EC.
> + * @msg: EC message with request information.
> + * @rq: EC request structure to fill.
> + */
> +static void wilco_ec_prepare(struct wilco_ec_message *msg,
> +                            struct wilco_ec_request *rq)
> +{
> +       memset(rq, 0, sizeof(*rq));
> +
> +       /* Handle messages without trimming bytes from the request */
> +       if (msg->request_size && msg->flags & WILCO_EC_FLAG_RAW_REQUEST) {
> +               rq->reserved_raw = *(u8 *)msg->request_data;
> +               msg->request_size--;
> +               memmove(msg->request_data, msg->request_data + 1,
> +                       msg->request_size);
> +       }
> +
> +       /* Fill in request packet */
> +       rq->struct_version = EC_MAILBOX_PROTO_VERSION;
> +       rq->mailbox_id = msg->type;
> +       rq->mailbox_version = EC_MAILBOX_VERSION;
> +       rq->data_size = msg->request_size + EC_MAILBOX_DATA_EXTRA;
> +       rq->command = msg->command;
> +
> +       /* Checksum header and data */
> +       rq->checksum = wilco_ec_checksum(rq, sizeof(*rq));
> +       rq->checksum += wilco_ec_checksum(msg->request_data, msg->request_size);
> +       rq->checksum = -rq->checksum;
> +}
> +
> +/**
> + * wilco_ec_transfer() - Perform actual data transfer.
> + * @ec: EC device.
> + * @msg: EC message data for request and response.
> + * @rq: Filled in request structure
> + *
> + * Context: ec->mailbox_lock should be held while using this function.
> + * Return: number of bytes received or negative error code on failure.
> + */
> +int wilco_ec_transfer(struct wilco_ec_device *ec, struct wilco_ec_message *msg,
> +                     struct wilco_ec_request *rq)
> +{
> +       struct wilco_ec_response *rs;
> +       u8 checksum;
> +       u8 flag;
> +       size_t size;
> +
> +       /* Write request header, then data */
> +       cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, 0, sizeof(*rq), (u8 *)rq);
> +       cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, sizeof(*rq), msg->request_size,
> +                                msg->request_data);
> +
> +       /* Start the command */
> +       outb(EC_MAILBOX_START_COMMAND, ec->io_command->start);
> +
> +       /* Wait for it to complete */
> +       if (wilco_ec_response_timed_out(ec)) {
> +               dev_dbg(ec->dev, "response timed out\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       /* For some commands (eg shutdown) the EC will not respond, that's OK */
> +       if (msg->flags & WILCO_EC_FLAG_NO_RESPONSE) {
> +               dev_dbg(ec->dev, "EC does not respond to this command\n");
> +               return 0;
> +       }
> +
> +       /* Check result */
> +       flag = inb(ec->io_data->start);
> +       if (flag) {
> +               dev_dbg(ec->dev, "bad response: 0x%02x\n", flag);
> +               return -EIO;
> +       }
> +
> +       if (msg->flags & WILCO_EC_FLAG_EXTENDED_DATA)
> +               size = EC_MAILBOX_DATA_SIZE_EXTENDED;
> +       else
> +               size = EC_MAILBOX_DATA_SIZE;
> +
> +       /* Read back response */
> +       rs = ec->data_buffer;
> +       checksum = cros_ec_lpc_io_bytes_mec(MEC_IO_READ, 0,
> +                                           sizeof(*rs) + size, (u8 *)rs);
> +       if (checksum) {
> +               dev_dbg(ec->dev, "bad packet checksum 0x%02x\n", rs->checksum);
> +               return -EBADMSG;
> +       }
> +
> +       /* Check that the EC reported success */
> +       msg->result = rs->result;
> +       if (msg->result) {
> +               dev_dbg(ec->dev, "bad response: 0x%02x\n", msg->result);
> +               return -EBADMSG;
> +       }
> +
> +       /* Check the returned data size, skipping the header */
> +       if (rs->data_size != size) {
> +               dev_dbg(ec->dev, "unexpected packet size (%u != %zu)",
> +                       rs->data_size, size);
> +               return -EMSGSIZE;
> +       }
> +
> +       /* Skip 1 response data byte unless specified */
> +       size = (msg->flags & WILCO_EC_FLAG_RAW_RESPONSE) ? 0 : 1;
> +       if ((ssize_t) rs->data_size - size < msg->response_size) {
> +               dev_dbg(ec->dev, "response data too short (%zd < %zu)",
> +                       (ssize_t) rs->data_size - size, msg->response_size);
> +               return -EMSGSIZE;
> +       }
> +
> +       /* Ignore response data bytes as requested */
> +       memcpy(msg->response_data, rs->data + size, msg->response_size);
> +
> +       /* Return actual amount of data received */
> +       return msg->response_size;
> +}
> +
> +/**
> + * wilco_ec_mailbox() - Send EC request and receive EC response.
> + * @ec: EC device.
> + * @msg: EC message data for request and response.
> + *
> + * On entry msg->type, msg->flags, msg->command, msg->request_size,
> + * msg->response_size, and msg->request_data should all be filled in.
> + *
> + * On exit msg->result and msg->response_data will be filled.
> + *
> + * Return: number of bytes received or negative error code on failure.
> + */
> +int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
> +{
> +       struct wilco_ec_request *rq;
> +       int ret;
> +
> +       dev_dbg(ec->dev, "cmd=%02x type=%04x flags=%02x rslen=%zu rqlen=%zu\n",
> +               msg->command, msg->type, msg->flags, msg->response_size,
> +               msg->request_size);
> +
> +       /* Prepare request packet */
> +       rq = ec->data_buffer;
> +       wilco_ec_prepare(msg, rq);
> +
> +       mutex_lock(&ec->mailbox_lock);
> +       ret = wilco_ec_transfer(ec, msg, rq);
> +       mutex_unlock(&ec->mailbox_lock);
> +
> +       return ret;
> +
> +}
> +EXPORT_SYMBOL_GPL(wilco_ec_mailbox);
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> new file mode 100644
> index 000000000000..5477b8802f81
> --- /dev/null
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * ChromeOS Wilco Embedded Controller
> + *
> + * Copyright 2018 Google LLC
> + */
> +
> +#ifndef WILCO_EC_H
> +#define WILCO_EC_H
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +
> +#define WILCO_EC_FLAG_NO_RESPONSE      BIT(0) /* EC does not respond */
> +#define WILCO_EC_FLAG_EXTENDED_DATA    BIT(1) /* EC returns 256 data bytes */
> +#define WILCO_EC_FLAG_RAW_REQUEST      BIT(2) /* Do not trim request data */
> +#define WILCO_EC_FLAG_RAW_RESPONSE     BIT(3) /* Do not trim response data */
> +#define WILCO_EC_FLAG_RAW              (WILCO_EC_FLAG_RAW_REQUEST | \
> +                                        WILCO_EC_FLAG_RAW_RESPONSE)
> +
> +/* Normal commands have a maximum 32 bytes of data */
> +#define EC_MAILBOX_DATA_SIZE           32
> +
> +/* Extended commands have 256 bytes of response data */
> +#define EC_MAILBOX_DATA_SIZE_EXTENDED  256
> +
> +/**
> + * struct wilco_ec_device - Wilco Embedded Controller handle.
> + * @dev: Device handle.
> + * @mailbox_lock: Mutex to ensure one mailbox command at a time.
> + * @io_command: I/O port for mailbox command.  Provided by ACPI.
> + * @io_data: I/O port for mailbox data.  Provided by ACPI.
> + * @io_packet: I/O port for mailbox packet data.  Provided by ACPI.
> + * @data_buffer: Buffer used for EC communication.  The same buffer
> + *               is used to hold the request and the response.
> + * @data_size: Size of the data buffer used for EC communication.
> + */
> +struct wilco_ec_device {
> +       struct device *dev;
> +       struct mutex mailbox_lock;
> +       struct resource *io_command;
> +       struct resource *io_data;
> +       struct resource *io_packet;
> +       void *data_buffer;
> +       size_t data_size;
> +};
> +
> +/**
> + * enum wilco_ec_msg_type - Message type to select a set of command codes.
> + * @WILCO_EC_MSG_LEGACY: Legacy EC messages for standard EC behavior.
> + * @WILCO_EC_MSG_PROPERTY: Get/Set/Sync EC controlled NVRAM property.
> + * @WILCO_EC_MSG_TELEMETRY: Telemetry data provided by the EC.
> + */
> +enum wilco_ec_msg_type {
> +       WILCO_EC_MSG_LEGACY = 0x00f0,
> +       WILCO_EC_MSG_PROPERTY = 0x00f2,
> +       WILCO_EC_MSG_TELEMETRY = 0x00f5,
> +};
> +
> +/**
> + * struct wilco_ec_message - Request and response message.
> + * @type: Mailbox message type.
> + * @flags: Message flags.
> + * @command: Mailbox command code.
> + * @result: Result code from the EC.  Non-zero indicates an error.
> + * @request_size: Number of bytes to send to the EC.
> + * @request_data: Buffer containing the request data.
> + * @response_size: Number of bytes expected from the EC.
> + *                 This is 32 by default and 256 if the flag
> + *                 is set for %WILCO_EC_FLAG_EXTENDED_DATA
> + * @response_data: Buffer containing the response data, should be
> + *                 response_size bytes and allocated by caller.
> + */
> +struct wilco_ec_message {
> +       enum wilco_ec_msg_type type;
> +       u8 flags;
> +       u8 command;
> +       u8 result;
> +       size_t request_size;
> +       void *request_data;
> +       size_t response_size;
> +       void *response_data;
> +};
> +
> +/**
> + * struct wilco_ec_request - Mailbox request message format.
> + * @struct_version: Should be %EC_MAILBOX_PROTO_VERSION
> + * @checksum: Sum of all bytes must be 0.
> + * @mailbox_id: Mailbox identifier, specifies the command set.
> + * @mailbox_version: Mailbox interface version %EC_MAILBOX_VERSION
> + * @reserved: Set to zero.
> + * @data_size: Length of request, data + last 2 bytes of the header.
> + * @command: Mailbox command code, unique for each mailbox_id set.
> + * @reserved_raw: Set to zero for most commands, but is used by
> + *                some command types and for raw commands.
> + */
> +struct wilco_ec_request {
> +       u8 struct_version;
> +       u8 checksum;
> +       u16 mailbox_id;
> +       u8 mailbox_version;
> +       u8 reserved;
> +       u16 data_size;
> +       u8 command;
> +       u8 reserved_raw;
> +} __packed;
> +
> +/**
> + * struct wilco_ec_response - Mailbox response message format.
> + * @struct_version: Should be %EC_MAILBOX_PROTO_VERSION
> + * @checksum: Sum of all bytes must be 0.
> + * @result: Result code from the EC.  Non-zero indicates an error.
> + * @data_size: Length of the response data buffer.
> + * @reserved: Set to zero.
> + * @mbox0: EC returned data at offset 0 is unused (always 0) so this byte
> + *         is treated as part of the header instead of the data.
> + * @data: Response data buffer.  Max size is %EC_MAILBOX_DATA_SIZE_EXTENDED.
> + */
> +struct wilco_ec_response {
> +       u8 struct_version;
> +       u8 checksum;
> +       u16 result;
> +       u16 data_size;
> +       u8 reserved[2];
> +       u8 mbox0;
> +       u8 data[0];
> +} __packed;
> +
> +/**
> + * wilco_ec_mailbox() - Send request to the EC and receive the response.
> + * @ec: Wilco EC device.
> + * @msg: Wilco EC message.
> + *
> + * Return: Number of bytes received or negative error code on failure.
> + */
> +int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
> +
> +#endif /* WILCO_EC_H */
> --
> 2.20.1.97.g81188d93c3-goog
>

Thanks,
 Enric
