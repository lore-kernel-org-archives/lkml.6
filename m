Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4FEC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDDC2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7JNa+wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAWWmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:42:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43615 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWWmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:42:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so4355904qtj.10;
        Wed, 23 Jan 2019 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtw35fzoCWJZMNYi2kHXU61hy4Em9R6frK8TumrtYAI=;
        b=a7JNa+wLMu0MYPtIP9nc7/Ut7ZYUC+emZs1kiOrY/C7rJJUCNBHebbztcrGfCVHyvX
         mRzn9Af9yKwtX0U8HHSv6bnxQgyDs3VWhf6PN3L/VP2fJZyNFgyxL4AGETN+34wdbtFP
         +ViJG1Nvq9ADSOB6WieWIHAATbhvaJkN8eB8Jjry6DVC1YgX7ntGtp9loaX1z2rakVMM
         5/BY1SK6CU8DPyUoAruJrZO++zVcQARIQBfQmkIfUzfvsm+L6eIbC6TkcxhGcELX9URO
         volDXRgeuCyYC3QqF/fKFIG2uAdh4UfGn6/hIjwhJB2ifCSbRNGI2h98dQpVBOCDbRpg
         8zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtw35fzoCWJZMNYi2kHXU61hy4Em9R6frK8TumrtYAI=;
        b=E1uGnP62LnyKrIkdQbSxQShEY7LGknj6uFD/B2i3iKinW3wkqD716nSxob6rO9aTe1
         PFwB5wieR/WuAKSjQ86lNNjDsyI6u5YAUsYtwlFqnRyCt7bo2UuRrP7iYcyPmZhKuWmL
         7zFqJn5EPJ2McxMeVzGwJ99AdBwnhcOXCPZu3D9IRUA/5ixKBqQCQR/9R0xW0H93vK+i
         c0/55DnOq2gnIgxWqqHjThI/pUoBBTiisaP8NSjroNBk2vr/W1aQxcG8fmtOJn4NUKFv
         BwbqC9OjkqEAdf4ExYSsi52QIycmQtWd7Mzp6AKyr1Zl48KPYv/dlxjcnzucs3FbjL+s
         aXBg==
X-Gm-Message-State: AJcUukf6l0B0hoL8Qm0pzJjjAfnxzcncRAcjLks6qj0t/EFPc0EEtV8D
        3J/ZT5b+QNoNuE0CjknT1mlxp8nVpwNrzTKJa74=
X-Google-Smtp-Source: ALg8bN7arrluHcfPSeFmp//WeKXW3W6/yAqzoyas5z+kaafE1qES+OmH+Zvtip1pX+TP7VoQ8yjkc3d2e9pWLockVbA=
X-Received: by 2002:ac8:2585:: with SMTP id e5mr4414767qte.233.1548283339174;
 Wed, 23 Jan 2019 14:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20190123183325.92946-1-ncrews@chromium.org> <20190123183325.92946-4-ncrews@chromium.org>
In-Reply-To: <20190123183325.92946-4-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 23 Jan 2019 23:42:08 +0100
Message-ID: <CAFqH_51-YT7FKO7VDY9-ZfcfAGR24dCF25X+UNQW5TMfY2eEVg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] platform/chrome: Add support for raw commands in debugfs
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-input@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Missatge de Nick Crews <ncrews@chromium.org> del dia dc., 23 de gen.
2019 a les 19:38:
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

That won't be a real example, right? Would be better remove it?

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
> Changes in v4:
> - Change debugfs driver to be a separate module
> - Change me email to @chromium.org from @google.com
> - Change CONFIG_WILCO_EC_SYSFS_RAW to
>   CONFIG_WILCO_EC_DEBUGFS
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
>  drivers/platform/chrome/wilco_ec/Makefile  |   2 +
>  drivers/platform/chrome/wilco_ec/core.c    |  20 ++
>  drivers/platform/chrome/wilco_ec/debugfs.c | 226 +++++++++++++++++++++
>  5 files changed, 280 insertions(+)
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
> index 20945a301ec6..56b871510c4d 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -9,3 +9,12 @@ config WILCO_EC
>
>           To compile this driver as a module, choose M here: the
>           module will be called wilco_ec.
> +
> +config WILCO_EC_DEBUGFS
> +       tristate "Enable raw access to EC via debugfs"
> +       depends on WILCO_EC
> +       help
> +         If you say Y here, you get support for sending raw commands to
> +         the Wilco EC via debugfs.  These commands do not do any byte
> +         manipulation and allow for testing arbitrary commands.  This
> +         interface is intended for debug only and is disabled by default.
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> index 03b32301dc61..063e7fb4ea17 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -2,3 +2,5 @@
>
>  wilco_ec-objs                          := core.o mailbox.o
>  obj-$(CONFIG_WILCO_EC)                 += wilco_ec.o
> +wilco_ec_debugfs-objs                  := debugfs.o
> +obj-$(CONFIG_WILCO_EC_DEBUGFS)         += wilco_ec_debugfs.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index 7dcb3bde132a..e036d88b6dd8 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -44,6 +44,8 @@ static int wilco_ec_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct wilco_ec_device *ec;
> +       struct platform_device *child_pdev;
> +       int ret;
>
>         ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
>         if (!ec)
> @@ -71,7 +73,25 @@ static int wilco_ec_probe(struct platform_device *pdev)
>         cros_ec_lpc_mec_init(ec->io_packet->start,
>                              ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
>
> +       /*
> +        * Register a debugfs platform device that will get picked up by the
> +        * debugfs driver. This platform device will get freed when its parent
> +        * device dev is unregistered.
> +        */
> +       child_pdev = platform_device_register_data(dev, "wilco-ec-debugfs",
> +                                                  PLATFORM_DEVID_AUTO,
> +                                                  NULL, 0);
> +       if (IS_ERR(child_pdev)) {
> +               dev_err(dev, "Failed to create debugfs platform device\n");
> +               ret = PTR_ERR(child_pdev);
> +               goto destroy_mec;

I don't think makes sense destroy the wilco-ec if for some reason the
debugfs interface driver fails (unlikely). Your driver should have the
same behaviour without depending on the debugfs part ...

> +       }
> +
>         return 0;
> +
> +destroy_mec:
> +       cros_ec_lpc_mec_destroy();
> +       return ret;

... and then you can remove this error cleanup for now.

>  }
>
>  static int wilco_ec_remove(struct platform_device *pdev)
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> new file mode 100644
> index 000000000000..6c12cd093209
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -0,0 +1,226 @@
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
> +#include <linux/module.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "wilco-ec-debugfs"
> +
> +/* The 256 raw bytes will take up more space when represented as a hex string */
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
> + * An valid input is a series of ascii hexadecimal numbers, separated by spaces.
> + * An example valid input is
> + * "   00 f2 0    000076 6 0  ff"
> + *
> + * If an individual "word" within the hex sentence is longer than MAX_WORD_SIZE,
> + * then the sentence is illegal, and parsing will fail.
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

spaces around +
[my first filter is run checkpatch.pl --strict :) ]

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
> +/* The message type takes up two bytes and the command takes a byte */
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

If you want to have the function documentation (see comment below)

s/wilco_ec_raw_show/wilco_ec_raw_read/

and

s/raw_store/wilco_ec_raw_write/

> + * @dev: Device representing the EC
> + * @attr: The attribute in question
> + * @buf: Output buffer to be filled
> + *

Note that the documentation doesn't match with current function. You
can either, fix the documentation and also document wilco_ec_raw_write
or just remove that documentation. For me it is clear what read/write
means, It might make sense for the examples, but it is also documented
in the debugfs-wilco-ec file (sometimes duplicating the info is a
source of mismatches).

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

s/raw_read/wilco_ec_raw_read/

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

s/raw_read/wilco_ec_raw_read/

> +       .write = raw_write,

s/raw_write/wilco_ec_raw_write/

> +       .llseek = no_llseek,
> +};
> +
> +static int wilco_ec_debugfs_probe(struct platform_device *pdev)
> +{
> +       /*
> +        * Ignore all errors, if there's a problem then we're already on fire:
> +        * www.mail-archive.com/linux-kernel@vger.kernel.org/msg1906997.html
> +        */

I'd prefer if you remove this comment, as is not really true (see
below) and likely this will end on a broken link in the future.

> +       struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
> +
> +       debug_info = devm_kzalloc(&pdev->dev, sizeof(*debug_info), GFP_KERNEL);

Oh, you should check the return value of devm_kzalloc, which would
cause a NULL pointer dereference in a OOM situation. It's only for the
debugfs calls that you should not have to check the error.

> +       debug_info->ec = ec;
> +       debug_info->dir = debugfs_create_dir("wilco_ec", NULL);
> +       debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
> +
> +       return 0;
> +}
> +
> +static int wilco_ec_debugfs_remove(struct platform_device *pdev)
> +{
> +       if (debug_info)

It is possible to have debug_info not allocated at this point? I think
that now you can remove this check

> +               debugfs_remove_recursive(debug_info->dir);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver wilco_ec_debugfs_driver = {
> +       .driver = {
> +               .name = DRV_NAME,
> +       },
> +       .probe = wilco_ec_debugfs_probe,
> +       .remove = wilco_ec_debugfs_remove,
> +};
> +
> +module_platform_driver(wilco_ec_debugfs_driver);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Wilco EC debugfs driver");
> --
> 2.20.1.321.g9e740568ce-goog
>

After solving these comments I think you can add my

Acked-for-chrome-platform-by: Enric Balletbo i Serra
<enric.balletbo@collabora.com>

Thanks,
 Enric
