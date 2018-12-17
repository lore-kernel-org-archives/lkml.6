Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E74A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf2ppd8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbeLQPul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:50:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41794 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLQPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:50:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so7567689qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=chorks1ja5fj3TR3R+jgLkI0SM9j4UW5VV1N/YEMfd8=;
        b=lf2ppd8Z6ePXTOzu/rU1oLiXZZ6LrNUX8QjNNmkFTDWTAg1Dm+cT3SeryU2LV17EJb
         x+cWlkTBWdhXG5krpGMh8tCcInqlyHSB2roZOzRGVmW6C2UK4XVn9oSbvbaX4HNOcekO
         pM8AaCEmI5M+Nn4XcIwLz07byrjuQ9Z7xxDuaV9ETvuuNm5Zgj6yUxJ8wDaiFsM6qbBV
         otDkgx5s6dzlCrvIU/shazImCUjXuPgcJCHolUllP8y5DNxmrBDm12EeP6VVlniJBaot
         HvYD6t7pVB0we4PzcDvgBvXNHX5KQaw32yuOVvLHo0h1u9nOTyX+8/hu2UJZ2DTXR9RA
         l8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=chorks1ja5fj3TR3R+jgLkI0SM9j4UW5VV1N/YEMfd8=;
        b=fyAeW0FA+8A8sX5QfSnQ11PUuIgrfavRvk6H6TFzB7gf/uLFQtj29PW1JD45b4n0kh
         mbDHbHXFsBm4SlVaj2rFm8VwJxafY0OCRpdxZsGBZZjSJu5lAfL6IHkQIURObxVJ8RBp
         6S3cZv4RhAjFBnFds6o61qgZdo3QsPMJsVCxcT4qM113GnhXdCqHuWKrLYMhwQu9jtDi
         9glKpq4I9UDmxN1A12Fnb9YUcLfbVPawP6oCmnxJ0HZYoZPxP7vXFBpk/ihDsJ6r2uTU
         X4IZDpxo4A0JJDKcHubbol+cwKxRVAn+dHHSKd6dFJaz16n/s39PVu+AkMf1U5J3stB2
         7egg==
X-Gm-Message-State: AA+aEWbNqapKhED8umX79OoPXAow5F3JyziiMA3YYqjMUpxh+I78T2E/
        4Oi3vFmYljrYLf4zNVTJrGbO60wyItrAyJdcXXo=
X-Google-Smtp-Source: AFSGD/UThi/TZTBxuljuR4U9I0uRpuyMJnbMvbQz/+zAg6i9XZZ+kQJZjPFfWKl5qctLn8ca2Buw0hXzKpr3O8v1LW4=
X-Received: by 2002:a37:cf9b:: with SMTP id v27mr12532904qkl.160.1545061838601;
 Mon, 17 Dec 2018 07:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com> <20181215001843.62404-3-ncrews@google.com>
In-Reply-To: <20181215001843.62404-3-ncrews@google.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 17 Dec 2018 16:50:27 +0100
Message-ID: <CAFqH_52pY-FKfW=nfh6iLc8-sf1wQHQVi4gL8f5Ws9=mGkbmKA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] CHROMIUM: wilco_ec: Add new driver for Wilco EC
To:     Nick Crews <ncrews@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@google.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Many thanks for sending this upstream. Adding Guenter as also might be
interested, and some minor comments below.

Missatge de Nick Crews <ncrews@google.com> del dia ds., 15 de des.
2018 a les 1:22:
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
>  drivers/platform/chrome/Kconfig            |  14 +-
>  drivers/platform/chrome/Makefile           |   3 +
>  drivers/platform/chrome/wilco_ec.h         |  97 +++++
>  drivers/platform/chrome/wilco_ec_mailbox.c | 395 +++++++++++++++++++++
>  4 files changed, 508 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/chrome/wilco_ec.h
>  create mode 100644 drivers/platform/chrome/wilco_ec_mailbox.c
>
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kc=
onfig
> index 16b1615958aa..4168d5e6bedc 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -49,6 +49,18 @@ config CHROMEOS_TBMC
>           To compile this driver as a module, choose M here: the
>           module will be called chromeos_tbmc.
>
> +config WILCO_EC
> +       tristate "ChromeOS Wilco Embedded Controller"
> +       depends on ACPI && (X86 || COMPILE_TEST)
> +       select CROS_EC_LPC_MEC
> +       help
> +         If you say Y here, you get support for talking to the Chrome OS

s/Chrome OS/ChromeOS/ like you did in the config description. For
coherence try to use the same form.

> +         Wilco EC over an eSPI bus. This uses a simple byte-level protoc=
ol
> +         with a checksum.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called wilco_ec.
> +
>  config CROS_EC_CTL
>          tristate
>
> @@ -86,7 +98,7 @@ config CROS_EC_LPC
>
>  config CROS_EC_LPC_MEC
>         bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant=
"
> -       depends on CROS_EC_LPC
> +       depends on CROS_EC_LPC || WILCO_EC
>         default n
>         help
>           If you say Y here, a variant LPC protocol for the Microchip EC
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/M=
akefile
> index cd591bf872bb..b132ba5b3e3d 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -12,4 +12,7 @@ cros_ec_lpcs-objs                     :=3D cros_ec_lpc.=
o cros_ec_lpc_reg.o
>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) +=3D cros_ec_lpc_mec.o
>  obj-$(CONFIG_CROS_EC_LPC)              +=3D cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)            +=3D cros_ec_proto.o
> +

Unrelated change.

>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)   +=3D cros_kbd_led_backlight.o
> +wilco_ec-objs                          :=3D wilco_ec_mailbox.o
> +obj-$(CONFIG_WILCO_EC)                 +=3D wilco_ec.o
> diff --git a/drivers/platform/chrome/wilco_ec.h b/drivers/platform/chrome=
/wilco_ec.h
> new file mode 100644
> index 000000000000..ba16fcff87c4
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * wilco_ec - Chrome OS Wilco Embedded Controller

Remove 'wilco_ec -' and s/Chrome OS/ChromeOS/

> + *
> + * Copyright 2018 Google LLC
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

You already added the SPDX-identifier so can remove the license boiler-plat=
e.


> + */
> +
> +#ifndef WILCO_EC_H
> +#define WILCO_EC_H
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +
> +#define WILCO_EC_FLAG_NO_RESPONSE      BIT(0) /* EC does not respond */
> +#define WILCO_EC_FLAG_EXTENDED_DATA    BIT(1) /* EC returns 256 data byt=
es */
> +#define WILCO_EC_FLAG_RAW_REQUEST      BIT(2) /* Do not trim request dat=
a */
> +#define WILCO_EC_FLAG_RAW_RESPONSE     BIT(3) /* Do not trim response da=
ta */
> +#define WILCO_EC_FLAG_RAW              (WILCO_EC_FLAG_RAW_REQUEST | \
> +                                        WILCO_EC_FLAG_RAW_RESPONSE)
> +
> +/**
> + * enum wilco_ec_msg_type - Message type to select a set of command code=
s.
> + * @WILCO_EC_MSG_LEGACY: Legacy EC messages for standard EC behavior.
> + * @WILCO_EC_MSG_PROPERTY: Get/Set/Sync EC controlled NVRAM property.
> + * @WILCO_EC_MSG_TELEMETRY: Telemetry data provided by the EC.
> + */
> +enum wilco_ec_msg_type {
> +       WILCO_EC_MSG_LEGACY =3D 0x00f0,
> +       WILCO_EC_MSG_PROPERTY =3D 0x00f2,
> +       WILCO_EC_MSG_TELEMETRY =3D 0x00f5,
> +};

I think that this is not used for now, remove and introduce it when you use=
 it.

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
> + * wilco_ec_mailbox() - Send request to the EC and receive the response.
> + * @ec: Wilco EC device.
> + * @msg: Wilco EC message.
> + *
> + * Return: Number of bytes received or negative error code on failure.
> + */
> +int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message=
 *msg);
> +
> +#endif /* WILCO_EC_H */
> diff --git a/drivers/platform/chrome/wilco_ec_mailbox.c b/drivers/platfor=
m/chrome/wilco_ec_mailbox.c
> new file mode 100644
> index 000000000000..6613c18c2a82
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec_mailbox.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * wilco_ec_mailbox - Mailbox interface for Wilco Embedded Controller

Remove 'wilco_ec_mailbox -'

> + *
> + * Copyright 2018 Google LLC
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Remove the license boiler-plate.

> + */
> +
> +/*
> + * The Wilco EC is similar to a typical Chrome OS embedded controller.
> + * It uses the same MEC based low-level communication and a similar
> + * protocol, but with some important differences.  The EC firmware does
> + * not support the same mailbox commands so it is not registered as a
> + * cros_ec device type.
> + *
> + * Most messages follow a standard format, but there are some exceptions
> + * and an interface is provided to do direct/raw transactions that do no=
t
> + * make assumptions about byte placement.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/mfd/cros_ec_lpc_mec.h>

This file does not exists.

#include "cros_ec_lpc_mec.h" ?

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include "wilco_ec.h"
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
> +/* Normal commands have a maximum 32 bytes of data */
> +#define EC_MAILBOX_DATA_SIZE           32
> +
> +/* Extended commands have 256 bytes of response data */
> +#define EC_MAILBOX_DATA_SIZE_EXTENDED  256
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
> +#define EC_CMDR_BUSY           BIT(2)  /* EC is busy processing a comman=
d */
> +#define EC_CMDR_CMD            BIT(3)  /* Last host write was a command =
*/
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
> + * @mbox0: EC returned data at offset 0 is unused (always 0) so this byt=
e
> + *         is treated as part of the header instead of the data.
> + * @data: Response data buffer.  Max size is %EC_MAILBOX_DATA_SIZE_EXTEN=
DED.
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
> + * wilco_ec_response_timed_out() - Wait for EC response.
> + * @ec: EC device.
> + *
> + * Return: true if EC timed out, false if EC did not time out.
> + */
> +static bool wilco_ec_response_timed_out(struct wilco_ec_device *ec)
> +{
> +       unsigned long timeout =3D jiffies + EC_MAILBOX_TIMEOUT;
> +
> +       usleep_range(200, 300);
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
> + * @data: Data to checksum.
> + * @size: Number of bytes to checksum.
> + *
> + * Return: 8bit checksum of provided data.
> + */
> +static u8 wilco_ec_checksum(const void *data, size_t size)
> +{
> +       u8 *data_bytes =3D (u8 *)data;
> +       u8 checksum =3D 0;
> +       size_t i;
> +
> +       for (i =3D 0; i < size; i++)
> +               checksum +=3D data_bytes[i];
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
> +       if (msg->request_size && msg->flags & WILCO_EC_FLAG_RAW_REQUEST) =
{
> +               rq->reserved_raw =3D *(u8 *)msg->request_data;
> +               msg->request_size--;
> +               memmove(msg->request_data, msg->request_data + 1,
> +                       msg->request_size);
> +       }
> +
> +       /* Fill in request packet */
> +       rq->struct_version =3D EC_MAILBOX_PROTO_VERSION;
> +       rq->mailbox_id =3D msg->type;
> +       rq->mailbox_version =3D EC_MAILBOX_VERSION;
> +       rq->data_size =3D msg->request_size + EC_MAILBOX_DATA_EXTRA;
> +       rq->command =3D msg->command;
> +
> +       /* Checksum header and data */
> +       rq->checksum =3D wilco_ec_checksum(rq, sizeof(*rq));
> +       rq->checksum +=3D wilco_ec_checksum(msg->request_data, msg->reque=
st_size);
> +       rq->checksum =3D -rq->checksum;
> +}
> +
> +/**
> + * wilco_ec_transfer() - Send EC request and receive EC response.
> + * @ec: EC device.
> + * @msg: EC message data for request and response.
> + *
> + * Return: 0 for success or negative error code on failure.
> + */
> +static int wilco_ec_transfer(struct wilco_ec_device *ec,
> +                            struct wilco_ec_message *msg)
> +{
> +       struct wilco_ec_request *rq;
> +       struct wilco_ec_response *rs;
> +       u8 checksum;
> +       size_t size;
> +
> +       /* Prepare request packet */
> +       rq =3D ec->data_buffer;
> +       wilco_ec_prepare(msg, rq);
> +
> +       /* Write request header */
> +       cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, 0, sizeof(*rq), (u8 *)rq);
> +
> +       /* Write request data */
> +       cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, sizeof(*rq), msg->request_=
size,
> +                                msg->request_data);
> +
> +       /* Start the command */
> +       outb(EC_MAILBOX_START_COMMAND, ec->io_command->start);
> +
> +       /* Wait for it to complete */
> +       if (wilco_ec_response_timed_out(ec)) {
> +               dev_err(ec->dev, "response timed out\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       /* Some commands will put the EC into a state where it cannot res=
pond */
> +       if (msg->flags & WILCO_EC_FLAG_NO_RESPONSE) {
> +               dev_dbg(ec->dev, "EC does not respond to this command\n")=
;
> +               return 0;
> +       }
> +
> +       /* Check result */
> +       msg->result =3D inb(ec->io_data->start);
> +       if (msg->result) {
> +               dev_err(ec->dev, "bad response: 0x%02x\n", msg->result);
> +               return -EIO;
> +       }
> +
> +       if (msg->flags & WILCO_EC_FLAG_EXTENDED_DATA) {
> +               /* Extended commands return 256 bytes of data */
> +               size =3D EC_MAILBOX_DATA_SIZE_EXTENDED;
> +       } else {
> +               /* Otherwise EC commands return 32 bytes of data */
> +               size =3D EC_MAILBOX_DATA_SIZE;
> +       }
> +
> +       /* Read back response */
> +       rs =3D ec->data_buffer;
> +       checksum =3D cros_ec_lpc_io_bytes_mec(MEC_IO_READ, 0,
> +                                           sizeof(*rs) + size, (u8 *)rs)=
;
> +       if (checksum) {
> +               dev_err(ec->dev, "bad packet checksum 0x%02x\n", rs->chec=
ksum);
> +               return -EBADMSG;
> +       }
> +       msg->result =3D rs->result;
> +
> +       /* Check the returned data size, skipping the header */
> +       if (rs->data_size !=3D size) {
> +               dev_err(ec->dev, "unexpected packet size (%u !=3D %zu)",
> +                       rs->data_size, size);
> +               return -EMSGSIZE;
> +       }
> +
> +       /* Skip 1 response data byte unless specified */
> +       size =3D (msg->flags & WILCO_EC_FLAG_RAW_RESPONSE) ? 0 : 1;
> +
> +       if (msg->response_size > rs->data_size - size) {
> +               dev_err(ec->dev, "response data too short (%u > %zu)",

Fix the following compiler warning:

warning: format =E2=80=98%u=E2=80=99 expects argument of type =E2=80=98unsi=
gned int=E2=80=99, but
argument 3 has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98l
ong unsigned int=E2=80=99} [-Wformat=3D]

> +                       rs->data_size - size, msg->response_size);
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
> +int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message=
 *msg)
> +{
> +       size_t size =3D EC_MAILBOX_DATA_SIZE;
> +       int ret;
> +
> +       dev_dbg(ec->dev, "cmd=3D%02x type=3D%04x flags=3D%02x rslen=3D%d =
rqlen=3D%d\n",
> +               msg->command, msg->type, msg->flags, msg->response_size,
> +               msg->request_size);
> +

warning: format =E2=80=98%d=E2=80=99 expects argument of type =E2=80=98int=
=E2=80=99, but argument 7
has type =E2=80=98size_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99}=
 [-Wformat=3D]

> +       if (msg->request_size > size) {
> +               dev_err(ec->dev, "provided request too large: %zu > %zu\n=
",
> +                       msg->request_size, size);
> +               return -EINVAL;
> +       }
> +
> +       /* Check for extended size on response data if flag is set */
> +       if (msg->flags & WILCO_EC_FLAG_EXTENDED_DATA)
> +               size =3D EC_MAILBOX_DATA_SIZE_EXTENDED;
> +
> +       if (msg->response_size > size) {
> +               dev_err(ec->dev, "expected response too large: %zu > %zu\=
n",
> +                       msg->response_size, size);
> +               return -EINVAL;
> +       }
> +       if (msg->request_size && !msg->request_data) {
> +               dev_err(ec->dev, "request data missing\n");
> +               return -EINVAL;
> +       }
> +       if (msg->response_size && !msg->response_data) {
> +               dev_err(ec->dev, "response data missing\n");
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&ec->mailbox_lock);
> +
> +       ret =3D wilco_ec_transfer(ec, msg);
> +       if (ret >=3D 0 && msg->result)
> +               ret =3D -EBADMSG;
> +
> +       mutex_unlock(&ec->mailbox_lock);
> +
> +       return ret;
> +}
> +
> +static struct resource *wilco_get_resource(struct platform_device *pdev,
> +                                          int index)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct resource *res;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_IO, index);
> +       if (!res) {
> +               dev_err(dev, "couldn't find IO resource %d\n", index);
> +               return NULL;
> +       }
> +
> +       if (!devm_request_region(dev, res->start, resource_size(res),
> +                                dev_name(dev))) {
> +               dev_err(dev, "couldn't reserve IO region %d\n", index);
> +               return NULL;
> +       }
> +
> +       return res;
> +}
> +
> +static int wilco_ec_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct wilco_ec_device *ec;
> +
> +       ec =3D devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> +       if (!ec)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, ec);
> +       ec->dev =3D dev;
> +       mutex_init(&ec->mailbox_lock);
> +
> +       /* Largest data buffer size requirement is extended data response=
 */
> +       ec->data_size =3D sizeof(struct wilco_ec_response) +
> +               EC_MAILBOX_DATA_SIZE_EXTENDED;
> +       ec->data_buffer =3D devm_kzalloc(dev, ec->data_size, GFP_KERNEL);
> +       if (!ec->data_buffer)
> +               return -ENOMEM;
> +
> +       /* Prepare access to IO regions provided by ACPI */
> +       ec->io_data =3D wilco_get_resource(pdev, 0);      /* Host Data */
> +       ec->io_command =3D wilco_get_resource(pdev, 1);   /* Host Command=
 */
> +       ec->io_packet =3D wilco_get_resource(pdev, 2);    /* MEC EMI */
> +       if (!ec->io_data || !ec->io_command || !ec->io_packet)
> +               return -ENODEV;
> +
> +       /* Initialize cros_ec register interface for communication */
> +       cros_ec_lpc_mec_init(ec->io_packet->start,
> +                            ec->io_packet->start + EC_MAILBOX_DATA_SIZE)=
;
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
> +static const struct acpi_device_id wilco_ec_acpi_device_ids[] =3D {
> +       { "GOOG000C", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, wilco_ec_acpi_device_ids);
> +
> +static struct platform_driver wilco_ec_driver =3D {
> +       .driver =3D {
> +               .name =3D "wilco_ec",
> +               .acpi_match_table =3D wilco_ec_acpi_device_ids,
> +       },
> +       .probe =3D wilco_ec_probe,
> +       .remove =3D wilco_ec_remove,
> +};
> +
> +module_platform_driver(wilco_ec_driver);
> +
> +MODULE_AUTHOR("Duncan Laurie <dlaurie@chromium.org>");
> +MODULE_LICENSE("GPL");

License mismatch, according to the SPDX identifier you want GPL v2 here.

> +MODULE_DESCRIPTION("Chrome OS Wilco Embedded Controller driver");

s/Chrome OS/ChromeOS/

> +MODULE_ALIAS("platform:wilco-ec");
> --
> 2.20.0.405.gbc1bbc6f85-goog
>

Thanks,
  Enric
