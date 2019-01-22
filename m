Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF07C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CCD20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgQUtxXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfAVLs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:48:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34995 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfAVLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:48:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so27228226qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 03:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNYcQBWTOjGAU0bh5fMGQxGBTT1E6BwdznqZsF67B4s=;
        b=IgQUtxXiGXyHIagxlRYCjx2MUtyxGoITlUG7KfPCfz8fDH2+KOr70xSTm8uZ/diYV/
         8EW1VQpxevH4oYnpdyPYv4+ZsKl0hp/3nrGOTsUhUnoh/doeZngb4LLyGu4ZhXFD5rEh
         Z4TatrgRHPOS5qjM1SMJdKQnpMXkc+6EuYV8ngRQ1toutraJr/sUVbE3tP7opOmFfGsm
         vMvhSu1S6LSxCfhvdr9hYkn1a0Tm5pgUHzveBQLuiX/mDc/eSlMHfmFFRhg//cfNnSFd
         OTLaDT0Ly7BtxYR187QOpiKRhNXrx9LG0PBR6HAk6svo3njj96Fx5ICH5RPHrk7rrUqP
         FkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNYcQBWTOjGAU0bh5fMGQxGBTT1E6BwdznqZsF67B4s=;
        b=HLiDN+8aVx2CCbvu0X2gOphNDiM6jRjE1dUCU+yOi13a377PfUK6AUc+INYLSzopSa
         R+zKvln1/PgIj55p2oKt6hE5J1D112S25MW9HKRgeBOEw0BYWuWP4K7A2Ata0Yc0Vc2X
         uTYGd3DAQB8jS6d03KE0EWKrnFNzJ/q7Wf83y75HOB/85nVJfXGk2aCNXSOgiXitr7yz
         SHiqAxAB7Z6kSYRjK6mfQdZcuch/4ZUIkPM3vJUOs1zzgCmzUJrRM+ej2H3L3R1ptv25
         uazYsDSmmpz4q8NiUkri5ztkhyDd2NHXwrcSlU7bWRZn+Bqc/RjzPzJqvnNw7qnNPTBx
         +USQ==
X-Gm-Message-State: AJcUukdzh0x5507Q8Nj1z6dZRoLme2vtTXy76skfqMx3x/3/cdd/WMYj
        Y3kjKmSB4Hcq50AY7Bg+p8vbCtCjwr8TtuRbMc4=
X-Google-Smtp-Source: ALg8bN6GpGSEyKvqeT2NhSf+WbozzpXcV/JH+U8JpaN2el6CulKyw4W9JLmBuQTV7XrRvAuIAwZZBnbRtQWIBUT2pX4=
X-Received: by 2002:a0c:a8e3:: with SMTP id h35mr28609529qvc.92.1548157703823;
 Tue, 22 Jan 2019 03:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20190119001422.48186-1-ncrews@chromium.org> <20190119001422.48186-4-ncrews@chromium.org>
In-Reply-To: <20190119001422.48186-4-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 22 Jan 2019 12:48:12 +0100
Message-ID: <CAFqH_51Ee_6C9Zzz70VfvbObFtB1ORRdt_PfdBrmO4XFQR+Ehg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] platform/chrome: Add support for raw commands in debugfs
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Simon Glass <sjg@chromium.org>,
        Daniel Kurtz <djkurtz@google.com>, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Why not create a module_platform_driver for this? So you have a kernel
module that you can load and unload for debug purposes instead of
add/remove the functionality at build time.

Missatge de Nick Crews <ncrews@chromium.org> del dia ds., 19 de gen.
2019 a les 1:18:
>
> From: Duncan Laurie <dlaurie@google.com>
>
> Add a debugfs attribute that allows sending raw commands to the EC.
> This is useful for development and debug but should not be enabled
> in a production environment.
>
> Turn the keyboard global mic mute led on
> > echo 00 f2 01 76 06 00 00 01 01 > /sys/kernel/debug/wilco_ec/raw
> Turn the keyboard global mic mute led off
> > echo 00 f2 01 76 06 00 00 01 00 > /sys/kernel/debug/wilco_ec/raw
> Get the EC firmware build date
> First send the request command
> > echo 00 f0 38 00 03 00 > raw
> Then read the result. "12/21/18" is in the middle of the response
> > cat raw
> 00 31 32 2f 32 31 2f 31 38 00 00 0f 01 00 01 00  .12/21/18.......
>
> Signed-off-by: Duncan Laurie <dlaurie@google.com>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>
> Changes in v3:
> - Move the attribute to the debugfs system
> - Move the implementation to debugfs.c
> - Improve the raw hex parsing
> - Encapsulate global variables in one object
> - Add safety check when passing less than 3 bytes
> - Move documentation to debugfs-wilco-ec
>
> Changes in v2:
> - Add sysfs documentation
> - rm duplicate EC_MAILBOX_DATA_SIZE defs
> - Make docstrings follow kernel style
> - Fix tags in commit msg
> - Move Kconfig to subdirectory
> - Reading raw now includes ASCII translation
>
>  Documentation/ABI/testing/debugfs-wilco-ec |  23 +++
>  drivers/platform/chrome/wilco_ec/Kconfig   |   9 +
>  drivers/platform/chrome/wilco_ec/Makefile  |   2 +-
>  drivers/platform/chrome/wilco_ec/core.c    |  17 ++
>  drivers/platform/chrome/wilco_ec/debugfs.c | 218 +++++++++++++++++++++
>  include/linux/platform_data/wilco-ec.h     |   3 +
>  6 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
>  create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c
>
> diff --git a/Documentation/ABI/testing/debugfs-wilco-ec b/Documentation/ABI/testing/debugfs-wilco-ec
> new file mode 100644
> index 000000000000..90bc3fe08dff
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-wilco-ec
> @@ -0,0 +1,23 @@
> +What:          /sys/kernel/debug/wilco_ec/raw
> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Write and read raw mailbox commands to the EC.
> +
> +               For writing:
> +               Bytes 0-1 indicate the message type:
> +                       00 F0 = Execute Legacy Command
> +                       00 F2 = Read/Write NVRAM Property
> +               Byte 2 provides the command code
> +               Bytes 3+ consist of the data passed in the request
> +
> +               Example:
> +               // Request EC info type 3 (EC firmware build date)
> +               $ echo 00 f0 38 00 03 00 > raw
> +               // View the result. The decoded ASCII result "12/21/18" is
> +               // included after the raw hex.
> +               $ cat raw
> +               00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
> +
> +               At least three bytes are required, for the msg type and command,
> +               with additional bytes optional for additional data.
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index f8e6c9e8c5cd..0bd84c98b79b 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -21,4 +21,13 @@ config WILCO_EC
>           To compile this driver as a module, choose M here: the
>           module will be called wilco_ec.
>
> +config WILCO_EC_SYSFS_RAW

s/SYSFS/DEBUGFS/

> +       bool "Enable raw access to EC via sysfs"

s/sysfs/debugfs/

> +       depends on WILCO_EC
> +       help
> +         If you say Y here, you get support for sending raw commands to
> +         the Wilco EC via sysfs.  These commands do not do any byte

s/sysfs/debugfs/

> +         manipulation and allow for testing arbitrary commands.  This
> +         interface is intended for debug only and is disabled by default.
> +
>  endif # WILCO_EC_PLATFORM
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> index 03b32301dc61..86d0457d85ea 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -wilco_ec-objs                          := core.o mailbox.o
> +wilco_ec-objs                          := core.o mailbox.o debugfs.o
>  obj-$(CONFIG_WILCO_EC)                 += wilco_ec.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index 13fe21dd235a..749fd6a36057 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -34,6 +34,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct wilco_ec_device *ec;
> +       int ret;
>
>         ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
>         if (!ec)
> @@ -61,11 +62,27 @@ static int wilco_ec_probe(struct platform_device *pdev)
>         cros_ec_lpc_mec_init(ec->io_packet->start,
>                              ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
>
> +       /* add debugfs attributes */
> +       ret = wilco_ec_debugfs_init(ec);
> +       if (ret) {
> +               dev_err(dev, "Failed to create debugfs attributes\n");
> +               goto destroy_mec;
> +       }
> +
>         return 0;
> +
> +destroy_mec:
> +       cros_ec_lpc_mec_destroy();
> +       return ret;
>  }
>
>  static int wilco_ec_remove(struct platform_device *pdev)
>  {
> +       struct wilco_ec_device *ec = platform_get_drvdata(pdev);
> +
> +       /* remove debugfs attributes */
> +       wilco_ec_debugfs_remove(ec);
> +
>         /* Teardown cros_ec interface */
>         cros_ec_lpc_mec_destroy();
>
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> new file mode 100644
> index 000000000000..46b0bf3fdf39
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * debugfs attributes for Wilco EC
> + *
> + * Copyright 2019 Google LLC
> + *
> + * There is only one attribute used for debugging, called raw.
> + * You can write a hexadecimal sentence to raw, and that series of bytes
> + * will be sent to the EC. Then, you can read the bytes of response
> + * by reading from raw.
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/debugfs.h>
> +#include <linux/fs.h>
> +#include <linux/platform_data/wilco-ec.h>
> +
> +#ifdef CONFIG_WILCO_EC_SYSFS_RAW
> +
> +#define FORMATTED_BUFFER_SIZE (EC_MAILBOX_DATA_SIZE_EXTENDED * 4)
> +
> +struct wilco_ec_debugfs {
> +       struct wilco_ec_device *ec;
> +       struct dentry *dir;
> +       size_t response_size;
> +       u8 raw_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
> +       u8 formatted_data[FORMATTED_BUFFER_SIZE];
> +};
> +
> +static struct wilco_ec_debugfs *debug_info;
> +
> +/**
> + * parse_hex_sentence() - Convert a ascii hex representation into byte array
> + * @in: Input buffer of ascii
> + * @isize: Length of input buffer
> + * @out: Output buffer
> + * @osize: Length of output buffer, e.g. max number of bytes to parse
> + *
> + * If an individual "word" within the hex sentence is longer than MAX_WORD_SIZE,
> + * then the sentence is illegal.
> + *
> + * Return: Number of bytes parsed, or negative error code on failure
> + */
> +static int parse_hex_sentence(const char *in, int isize, u8 *out, int osize)
> +{
> +       int n_parsed = 0;
> +       int word_start = 0;
> +       int word_end;
> +       int word_len;
> +       /* Temp buffer for holding a "word" of chars that represents one byte */
> +       const static int MAX_WORD_SIZE = 16;
> +       char tmp[MAX_WORD_SIZE+1];
> +       u8 byte;
> +
> +       while (word_start < isize && n_parsed < osize) {
> +               /* Find the start of the next word */
> +               while (word_start < isize && isspace(in[word_start]))
> +                       word_start++;
> +                /* reached the end of the input before next word? */
> +               if (word_start >= isize)
> +                       break;
> +
> +               /* Find the end of this word */
> +               word_end = word_start;
> +               while (word_end < isize && !isspace(in[word_end]))
> +                       word_end++;
> +
> +               /* Copy to a tmp NULL terminated string */
> +               word_len = word_end - word_start;
> +               if (word_len > MAX_WORD_SIZE)
> +                       return -EINVAL;
> +               memcpy(tmp, in + word_start, word_len);
> +               tmp[word_len] = '\0';
> +
> +               /*
> +                * Convert from hex string, place in output. If fails to parse,
> +                * just return -EINVAL because specific error code is only
> +                * relevant for this one word, returning it would be confusing.
> +                */
> +               if (kstrtou8(tmp, 16, &byte))
> +                       return -EINVAL;
> +               out[n_parsed++] = byte;
> +
> +               word_start = word_end;
> +       }
> +       return n_parsed;
> +}
> +
> +#define CMDS_AND_DATA_SIZE ((EC_MAILBOX_DATA_SIZE) + 3)
> +
> +static ssize_t raw_write(struct file *file, const char __user *user_buf,
> +                        size_t count, loff_t *ppos)
> +{
> +       char *buf = debug_info->formatted_data;
> +       struct wilco_ec_message msg;
> +       u8 request_data[CMDS_AND_DATA_SIZE];
> +       ssize_t kcount;
> +       int ret;
> +
> +       if (count > FORMATTED_BUFFER_SIZE)
> +               return -EINVAL;
> +
> +       kcount = simple_write_to_buffer(buf, FORMATTED_BUFFER_SIZE, ppos,
> +                                       user_buf, count);
> +       if (kcount < 0)
> +               return kcount;
> +
> +       ret = parse_hex_sentence(buf, kcount, request_data, CMDS_AND_DATA_SIZE);
> +       if (ret < 0)
> +               return ret;
> +       /* Need at least three bytes for type and command */
> +       if (ret < 3)
> +               return -EINVAL;
> +
> +       /* Clear response data buffer */
> +       memset(debug_info->raw_data, '\0', EC_MAILBOX_DATA_SIZE_EXTENDED);
> +
> +       msg.type = request_data[0] << 8 | request_data[1];
> +       msg.flags = WILCO_EC_FLAG_RAW;
> +       msg.command = request_data[2];
> +       msg.request_data = ret > 3 ? request_data + 3 : NULL;
> +       msg.request_size = ret - 3;
> +       msg.response_data = debug_info->raw_data;
> +       msg.response_size = EC_MAILBOX_DATA_SIZE;
> +
> +       /* Telemetry commands use extended response data */
> +       if (msg.type == WILCO_EC_MSG_TELEMETRY) {
> +               msg.flags |= WILCO_EC_FLAG_EXTENDED_DATA;
> +               msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
> +       }
> +
> +       ret = wilco_ec_mailbox(debug_info->ec, &msg);
> +       if (ret < 0)
> +               return ret;
> +       debug_info->response_size = ret;
> +
> +       return count;
> +}
> +
> +/**
> + * wilco_ec_raw_show() - Show result from previous call to raw_store()
> + * @dev: Device representing the EC
> + * @attr: The attribute in question
> + * @buf: Output buffer to be filled
> + *
> + * Example usage:
> + *     // Call raw_store(), read EC info type 3 (EC firmware build date)
> + *     # echo 00 f0 38 00 03 00 > raw
> + *     // Call this function, view the result. The decoded ASCII result
> + *     // "12/21/18" is included after the raw hex.
> + *     # cat raw
> + *     00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8.../.
> + *
> + * Return: Number of bytes written to output, negative error code on failure
> + */
> +static ssize_t raw_read(struct file *file, char __user *user_buf, size_t count,
> +                       loff_t *ppos)
> +{
> +       int fmt_len = 0;
> +
> +       if (debug_info->response_size) {
> +               fmt_len = hex_dump_to_buffer(debug_info->raw_data,
> +                                            debug_info->response_size,
> +                                            16, 1, debug_info->formatted_data,
> +                                            FORMATTED_BUFFER_SIZE, true);
> +               /* Only return response the first time it is read */
> +               debug_info->response_size = 0;
> +       }
> +
> +       return simple_read_from_buffer(user_buf, count, ppos,
> +                                      debug_info->formatted_data, fmt_len);
> +}
> +
> +static const struct file_operations fops_raw = {
> +       .owner = THIS_MODULE,
> +       .read = raw_read,
> +       .write = raw_write,
> +       .llseek = no_llseek,
> +};
> +
> +int wilco_ec_debugfs_init(struct wilco_ec_device *ec)
> +{
> +       debug_info = devm_kzalloc(ec->dev, sizeof(*debug_info), GFP_KERNEL);
> +       if (!debug_info)
> +               return -ENOMEM;

Add an empty line here.

> +       debug_info->ec = ec;
> +
> +       debug_info->dir = debugfs_create_dir("wilco_ec", NULL);
> +       if (!debug_info->dir)
> +               return -ENOMEM;
> +
> +       if (!debugfs_create_file("raw", 0644, debug_info->dir,
> +                                NULL, &fops_raw)) {
> +               debugfs_remove_recursive(debug_info->dir);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +void wilco_ec_debugfs_remove(struct wilco_ec_device *ec)
> +{
> +       if (debug_info) {
> +               debugfs_remove_recursive(debug_info->dir);
> +               devm_kfree(ec->dev, debug_info); /* needed? */

If you create a module_platform_driver that won't be needed, no.

> +       }
> +}
> +
> +#else /* CONFIG_WILCO_EC_SYSFS_RAW */
> +
> +int wilco_ec_debugfs_init(struct wilco_ec_device *ec)
> +{
> +       return 0;
> +}
> +
> +void wilco_ec_debugfs_remove(struct wilco_ec_device *ec) {}
> +
> +#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> index 5477b8802f81..3298eabe73bc 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -135,4 +135,7 @@ struct wilco_ec_response {
>   */
>  int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
>
> +int wilco_ec_debugfs_init(struct wilco_ec_device *ec);
> +void wilco_ec_debugfs_remove(struct wilco_ec_device *ec);
> +
>  #endif /* WILCO_EC_H */
> --
> 2.20.1.321.g9e740568ce-goog
>
