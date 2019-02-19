Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48330C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0136E2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx0xzSml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfBSQEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:04:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45997 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfBSQEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:04:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so1911882qkb.12;
        Tue, 19 Feb 2019 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLr6xH+OrrQ+36+8tkrMUBedy4v0/54r6u4Qhmo9I+0=;
        b=sx0xzSmlrLmmqyfFEAmlURpC7UyP9x8RuJ5auIsyUhIuzwpeQq9UhvwFhh3tz31h8P
         GsIFe1f//7F+Uha+AyUsQwD9E66OvR0AYya8VUu11nRdrZYBKKJBFWHexnCg1WFQZbgs
         CJHkRHzTdgfUAjNn/j6bgOH5el6OBGuQWdzp2S5+VUURnb9a7lK8jI8vl4eeC/HX0MSs
         ScmUw3WNTojByS1WhZWPgV59XnrTL0mgUJTC2rHWx49Tp2Y84FaMnBRXQmQ36mv673RY
         HaALYvYk6yEj7GyHURvZYssX6/vTTsDL/5intlQkqT8rQlwumRKEuUFVvFCNddwiCDS9
         qkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLr6xH+OrrQ+36+8tkrMUBedy4v0/54r6u4Qhmo9I+0=;
        b=SDrfGfcyzyu2IkLiXDmOcnlXkkkseNy5V9mxPA82ZqRPhHOg5uLppYpB96UV9POJOl
         RgjWLATbCVd9soAyWblU1Te8UpyKNXaf39C3NtJugk4Rj0oWvmtaqgmI56UkvuuX+/Ym
         jRMmNfhwcpCSr+juAP5Bi461pn5IneP5mzE0UqYXmtisomLvaqSbGM3v/KexNofa/uDo
         ooyXNr8KZg875fJm/k8w59bH4Lcw5drLBlM/uvtDXrmr+cfywy6FDHz9fy+/LIvlJChx
         h+zpeORUUboRrf7wfqJUcJdI1fkL4+nxrHjwNlzssfh7f2RdUN74aMkjbL+wDqjKI+Jy
         pFrA==
X-Gm-Message-State: AHQUAuaSEWH+Lx+JdNpFjv8KD00ze/WLFvWG+nM/wJu8kEzih58qakfc
        UA1Ngh/ZKSvhQ1EYBqwOaTqBRvy4ghOPHTWFuNk=
X-Google-Smtp-Source: AHgI3IakhwrabbIT7c5A3KpHWCVxUCe5WWUvhvtzMXtHiHwfzGyEd6Nue1ATEgoDFCdC6Mi9jwV5R8CJKyi8h9FfQyA=
X-Received: by 2002:a37:b12:: with SMTP id 18mr1264511qkl.125.1550592258017;
 Tue, 19 Feb 2019 08:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20190123183325.92946-1-ncrews@chromium.org> <20190123183325.92946-6-ncrews@chromium.org>
In-Reply-To: <20190123183325.92946-6-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 19 Feb 2019 17:04:06 +0100
Message-ID: <CAFqH_509sadtsnN9zH=Z_uFv-sKLbo1gSDK6LbsuaCSdym2bNw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] platform/chrome: Add sysfs attributes
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
> Add some sample sysfs attributes for the Wilco EC that show how
> the mailbox interface works. "Legacy" attributes are those that
> existed in the EC before it was adapted to ChromeOS.
>
> > cat /sys/bus/platform/devices/GOOG000C\:00/version
> Label        : 99.99.99
> SVN Revision : 738ed.99
> Model Number : 08;8
> Build Date   : 08/30/18
>

Note that example is not correct with the new attributes.

> Signed-off-by: Duncan Laurie <dlaurie@google.com>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>
> Changes in v4:
> - Move "Add RTC driver" before "Add sysfs attributes" so that
>   it could get accepted earlier, since it is less contentious
>
> Changes in v3:
> - explicitly define toplevel_groups from the start,
> so adding telem later makes sense
> - Break version attribute into individual attributes
> - rm unused WILCO_EC_ATTR_RW macro
> - Moved some #defines from legacy.h to legacy.c
>
> Changes in v2:
> - Remove license boiler plate
> - Remove "wilco_ec_sysfs -" docstring prefix
> - Fix accidental Makefile deletion
> - Add documentation for sysfs entries
> - Change "enable ? 0 : 1" to "!enable"
> - No longer override error code from sysfs_init()
> - Put attributes in the legacy file to begin with, don't move later
> - Remove duplicate error messages when init()ing sysfs
>
>  .../ABI/testing/sysfs-platform-wilco-ec       |  42 +++++++
>  drivers/platform/chrome/wilco_ec/Makefile     |   2 +-
>  drivers/platform/chrome/wilco_ec/core.c       |  12 ++
>  drivers/platform/chrome/wilco_ec/legacy.c     | 103 ++++++++++++++++++
>  drivers/platform/chrome/wilco_ec/legacy.h     |  79 ++++++++++++++
>  drivers/platform/chrome/wilco_ec/sysfs.c      |  79 ++++++++++++++
>  include/linux/platform_data/wilco-ec.h        |  14 +++
>  7 files changed, 330 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-wilco-ec
>  create mode 100644 drivers/platform/chrome/wilco_ec/legacy.c
>  create mode 100644 drivers/platform/chrome/wilco_ec/legacy.h
>  create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-wilco-ec b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> new file mode 100644
> index 000000000000..fd2400844470
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-wilco-ec
> @@ -0,0 +1,42 @@
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version_label
> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Display Wilco Embedded Controller firmware version label.
> +               Output will a version string be similar to the example below:
> +               95.00.06
> +
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version_svn_revision

nit: don't know why but svn always reminds me to subversion ... I see
that you always add the prefix version_, I assume this is to maintain
in some way the old directory structure but we cleaned a lot the
number of sysfs attributes, so makes sense always add the prefix
version_? On some cases looks weird to me. Why not just 'revision'
it's short an clear.

> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Display Wilco Embedded Controller SVN revision.
> +               Output will a version string be similar to the example below:
> +               5960a.06
> +
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version_model_number

nit: model_number?

> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Display Wilco Embedded Controller model number.
> +               Output will a version string be similar to the example below:
> +               08;8

Which format is this? DD/MM?

> +
> +What:          /sys/bus/platform/devices/GOOG000C\:00/version_build_date

nit: build_date?

> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Display Wilco Embedded Controller firmware build date.
> +               Output will a MM/DD/YY string.
> +

Should match with the above example

> +What:          /sys/bus/platform/devices/GOOG000C\:00/stealth_mode

I guess that this should go on a separate patch for now, please.

> +Date:          January 2019
> +KernelVersion: 4.19
> +Description:
> +               Turn stealth_mode on or off on EC. Stealth mode means that the
> +               various LEDs, the LCD backlight, and onboard speakers are turned
> +               off and remain off even if activated from the off state.
> +               External monitors connected to the system are not affected.
> +               In addition Wireless devices are turned off.
> +

I understand correctly that's a power management feature? What's the
use case from userspace point of view?

> +               Input should be parseable by kstrtobool().
> diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> index 063e7fb4ea17..b4dadf8b1a07 100644
> --- a/drivers/platform/chrome/wilco_ec/Makefile
> +++ b/drivers/platform/chrome/wilco_ec/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -wilco_ec-objs                          := core.o mailbox.o
> +wilco_ec-objs                          := core.o mailbox.o sysfs.o legacy.o
>  obj-$(CONFIG_WILCO_EC)                 += wilco_ec.o
>  wilco_ec_debugfs-objs                  := debugfs.o
>  obj-$(CONFIG_WILCO_EC_DEBUGFS)         += wilco_ec_debugfs.o
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index 7cfb047e2c89..1a1cd8e59f3f 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -101,6 +101,13 @@ static int wilco_ec_probe(struct platform_device *pdev)
>                 goto destroy_mec;
>         }
>
> +       /* Create sysfs attributes for userspace interaction */
> +       ret = wilco_ec_sysfs_init(ec);
> +       if (ret) {
> +               dev_err(dev, "Failed to create sysfs attributes\n");
> +               goto destroy_mec;
> +       }
> +
>         return 0;
>
>  destroy_mec:
> @@ -110,6 +117,11 @@ static int wilco_ec_probe(struct platform_device *pdev)
>
>  static int wilco_ec_remove(struct platform_device *pdev)
>  {
> +       struct wilco_ec_device *ec = platform_get_drvdata(pdev);
> +
> +       /* Remove sysfs attributes */
> +       wilco_ec_sysfs_remove(ec);
> +
>         /* Teardown cros_ec interface */
>         cros_ec_lpc_mec_destroy();
>
> diff --git a/drivers/platform/chrome/wilco_ec/legacy.c b/drivers/platform/chrome/wilco_ec/legacy.c
> new file mode 100644
> index 000000000000..f284088e70f4
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/legacy.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Legacy (non-Chrome-specific) sysfs attributes for Wilco EC
> + *
> + * Copyright 2018 Google LLC
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/device.h>
> +#include <linux/platform_data/wilco-ec.h>
> +
> +#include "legacy.h"
> +
> +#define EC_COMMAND_EC_INFO             0x38
> +#define EC_INFO_SIZE                   9
> +#define EC_COMMAND_STEALTH_MODE                0xfc
> +
> +#define VERSION_INDEX_LABEL            0
> +#define VERSION_INDEX_SVN_REVISION     1
> +#define VERSION_INDEX_MODEL_NUMBER     2
> +#define VERSION_INDEX_BUILD_DATE       3
> +
> +static ssize_t get_info(struct device *dev, char *buf, u8 index)
> +{
> +       struct wilco_ec_device *ec = dev_get_drvdata(dev);
> +       char result[EC_INFO_SIZE];
> +       struct wilco_ec_message msg = {
> +               .type = WILCO_EC_MSG_LEGACY,
> +               .command = EC_COMMAND_EC_INFO,
> +               .request_data = &index,
> +               .request_size = sizeof(index),
> +               .response_data = result,
> +               .response_size = EC_INFO_SIZE,
> +       };
> +       int ret;
> +
> +       ret = wilco_ec_mailbox(ec, &msg);
> +       if (ret < 0)
> +               return ret;
> +       if (ret != EC_INFO_SIZE)
> +               return -EBADMSG;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%s\n", result);
> +}
> +
> +ssize_t wilco_ec_version_label_show(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   char *buf)
> +{
> +       return get_info(dev, buf, VERSION_INDEX_LABEL);
> +}
> +
> +ssize_t wilco_ec_version_svn_revision_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       return get_info(dev, buf, VERSION_INDEX_SVN_REVISION);
> +}
> +
> +ssize_t wilco_ec_version_model_number_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       return get_info(dev, buf, VERSION_INDEX_MODEL_NUMBER);
> +}
> +
> +ssize_t wilco_ec_version_build_date_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf)
> +{
> +       return get_info(dev, buf, VERSION_INDEX_BUILD_DATE);
> +}
> +
> +ssize_t wilco_ec_stealth_mode_store(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   const char *buf, size_t count)
> +{
> +       struct wilco_ec_device *ec = dev_get_drvdata(dev);
> +       u8 param;
> +       struct wilco_ec_message msg = {
> +               .type = WILCO_EC_MSG_LEGACY,
> +               .command = EC_COMMAND_STEALTH_MODE,
> +               .request_data = &param,
> +               .request_size = sizeof(param),
> +       };
> +       int ret;
> +       bool enable;
> +
> +       ret = kstrtobool(buf, &enable);
> +       if (ret) {
> +               dev_err(dev, "Unable to parse '%s' to bool", buf);
> +               return ret;
> +       }
> +
> +       /* Invert input parameter, EC expects 0=on and 1=off */
> +       param = !enable;
> +
> +       ret = wilco_ec_mailbox(ec, &msg);
> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}
> diff --git a/drivers/platform/chrome/wilco_ec/legacy.h b/drivers/platform/chrome/wilco_ec/legacy.h
> new file mode 100644
> index 000000000000..a7f51dec4ccb
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/legacy.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Legacy (non-Chrome-specific) sysfs attributes for Wilco EC
> + *
> + * Copyright 2018 Google LLC
> + */
> +
> +#ifndef WILCO_EC_LEGACY_H
> +#define WILCO_EC_LEGACY_H
> +
> +#include <linux/device.h>
> +
> +/**
> + * wilco_ec_version_label_show() - Display Wilco EC version label
> + * @dev: The device underlying the struct wilco_ec_device
> + * @attr: The attribute being read from
> + * @buf: Output buffer to fill with the result
> + *
> + * Output will a version string be similar to the example below:
> + * 95.00.06
> + */
> +ssize_t wilco_ec_version_label_show(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   char *buf);
> +
> +/**
> + * wilco_ec_version_svn_revision_show() - Display Wilco EC SVN revision
> + * @dev: The device underlying the struct wilco_ec_device
> + * @attr: The attribute being read from
> + * @buf: Output buffer to fill with the result
> + *
> + * Output will a version string be similar to the example below:
> + * 5960a.06
> + */
> +ssize_t wilco_ec_version_svn_revision_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf);
> +
> +/**
> + * wilco_ec_version_model_number_show() - Display Wilco EC model number
> + * @dev: The device underlying the struct wilco_ec_device
> + * @attr: The attribute being read from
> + * @buf: Output buffer to fill with the result
> + *
> + * Output will a version string be similar to the example below:
> + * 08;8
> + */
> +ssize_t wilco_ec_version_model_number_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf);
> +
> +/**
> + * wilco_ec_version_build_date_show() - Display Wilco EC firmware build date
> + * @dev: The device underlying the struct wilco_ec_device
> + * @attr: The attribute being read from
> + * @buf: Output buffer to fill with the result
> + *
> + * Output will a MM/DD/YY string.
> + */
> +ssize_t wilco_ec_version_build_date_show(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        char *buf);
> +
> +
> +/**
> + * wilco_ec_stealth_mode_store() - Turn stealth_mode on or off on EC
> + * @dev: Device representing the EC
> + * @attr: The attribute in question
> + * @buf: Input buffer, should be parseable by kstrtobool(). Anything parsed to
> + *      True means enable stealth mode (turn off screen, etc)
> + * @count: Number of bytes in input buffer
> + *
> + * Return: Number of bytes consumed from input, negative error code on failure
> + */
> +ssize_t wilco_ec_stealth_mode_store(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   const char *buf, size_t count);
> +
> +#endif /* WILCO_EC_LEGACY_H */
> diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
> new file mode 100644
> index 000000000000..a885026e5d24
> --- /dev/null
> +++ b/drivers/platform/chrome/wilco_ec/sysfs.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sysfs attributes for Wilco Embedded Controller
> + *
> + * Copyright 2018 Google LLC
> + *
> + * The sysfs attributes appear under /sys/bus/platform/devices/GOOG000C\:00/
> + * To actually learn what each attribute does, read the corresponding _show() or
> + * _store() function source.
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/platform_device.h>
> +#include <linux/sysfs.h>
> +
> +#include "legacy.h"
> +
> +#define WILCO_EC_ATTR_RO(_name)                                                \
> +__ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
> +

This is only to add the wilco_ec_ prefix to the attributes, I'd prefer
you use the standard ATTR_ attibutes and just name the attributes
without the wilco_ec_ prefix.

> +#define WILCO_EC_ATTR_WO(_name)                                                \
> +__ATTR(_name, 0200, NULL, wilco_ec_##_name##_store)
> +

ditto

> +/* Make top-level attributes, which will live inside GOOG000C:00/ */
> +static struct device_attribute stealth_attr = WILCO_EC_ATTR_WO(stealth_mode);
> +static struct device_attribute version_label_attr =
> +                                       WILCO_EC_ATTR_RO(version_label);
> +static struct device_attribute version_svn_revision_attr =
> +                                       WILCO_EC_ATTR_RO(version_svn_revision);
> +static struct device_attribute version_model_number_attr =
> +                                       WILCO_EC_ATTR_RO(version_model_number);
> +static struct device_attribute version_build_date_attr =
> +                                       WILCO_EC_ATTR_RO(version_build_date);
> +static struct attribute *wilco_ec_toplevel_attrs[] = {
> +       &version_label_attr.attr,
> +       &version_svn_revision_attr.attr,
> +       &version_model_number_attr.attr,
> +       &version_build_date_attr.attr,
> +       &stealth_attr.attr,
> +       NULL
> +};
> +static const struct attribute_group wilco_ec_toplevel_group = {
> +       .attrs = wilco_ec_toplevel_attrs,
> +};
> +static const struct attribute_group *wilco_ec_toplevel_groups[] = {
> +       &wilco_ec_toplevel_group,
> +       NULL,
> +};
> +
> +/**
> + * wilco_ec_sysfs_init() - Initialize the sysfs directories and attributes
> + * @dev: The device representing the EC
> + *
> + * Creates the sysfs directory structure and populates it with all attributes.
> + * If there is a problem it will clean up the entire filesystem.
> + *
> + * Return 0 on success, -ENOMEM on failure creating directories or attibutes.
> + */
> +int wilco_ec_sysfs_init(struct wilco_ec_device *ec)
> +{
> +       struct device *dev = ec->dev;
> +       int ret;
> +
> +       /* add the top-level attributes */
> +       ret = sysfs_create_groups(&dev->kobj, wilco_ec_toplevel_groups);
> +       if (ret)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
> +{
> +       struct device *dev = ec->dev;
> +
> +       /* go upwards through the directory structure */
> +       sysfs_remove_groups(&dev->kobj, wilco_ec_toplevel_groups);
> +}
> diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
> index 5477b8802f81..7c6ab6de7239 100644
> --- a/include/linux/platform_data/wilco-ec.h
> +++ b/include/linux/platform_data/wilco-ec.h
> @@ -135,4 +135,18 @@ struct wilco_ec_response {
>   */
>  int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
>
> +/**
> + * wilco_ec_sysfs_init() - Create sysfs attributes.
> + * @ec: EC device.
> + *
> + * Return: 0 for success or negative error code on failure.
> + */
> +int wilco_ec_sysfs_init(struct wilco_ec_device *ec);
> +
> +/**
> + * wilco_ec_sysfs_remove() - Remove sysfs attributes.
> + * @ec: EC device.
> + */
> +void wilco_ec_sysfs_remove(struct wilco_ec_device *ec);
> +
>  #endif /* WILCO_EC_H */
> --
> 2.20.1.321.g9e740568ce-goog
>

Regards,
 Enric
