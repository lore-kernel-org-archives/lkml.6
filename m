Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCZU0Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:26:24 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41016 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeCZU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:26:22 -0400
X-Google-Smtp-Source: AG47ELsj1gO5gn6hsMFoRzM4Bkr4WPMAXpSTDJ6bs3Ji11oiVL0zs1Ipqloh9ztKIz6QpCNgn0VNVMp2KUTHt9gaupI=
MIME-Version: 1.0
References: <20180323174247.6680-1-enric.balletbo@collabora.com>
In-Reply-To: <20180323174247.6680-1-enric.balletbo@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Mon, 26 Mar 2018 20:26:11 +0000
Message-ID: <CAMHSBOXGeGC21i=Zf4d53cV6WioNdgbutEutuMLJxg2Q9OAWqQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] platform/chrome: cros_ec debugfs and sysfs updates
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, kernel@collabora.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:42 AM Enric Balletbo i Serra <
enric.balletbo@collabora.com> wrote:

> Hi,

> This is a four patchset that introduces some cros_ec debugfs and sysfs
> updates. This version is practically the same as version 3, it only
> fixes the issue pointed by Gwendal to only allocate one extra sensor
> intead of two.

> First patch was already sent [1] but did not receive feedback so I am
> resending it. Needs to go through platform/chrome tree and can be
> picked without dependencies.

> Patches 2 to 4 are cleanups of current code, basically is the
> implementation of the changes suggested by Andy Shevchenko on the first
> series. Again these must go through platform/chrome tree.

> In Patch 5 I added a missing define, so now this patch can be picked
> without any dependency, although now needs the ack from mfd and
> platform/chrome maintainer as touches both sub-systems.

> Finally, patch 6 was already sent [2] but now needed to be reworked due
> the split of the cros_ec_devs in two parts [3]. This patch touches
> platform/chrome and mfd so we will probably need an immutable branch.
> This version also include a fix found by Gwendal.

> Best regards,
>    Enric

> Changes in v4:
> - [6/6] Allocate only one extra sensor (Gwendal)

> Changes in v3:
> - [2/6] Add Reviewed-by Andy Shevchenko
> - [3/6] Add Reviewed-by Andy Shevchenko
> - [4/6] Add Reviewed-by Andy Shevchenko
> - [5/6] Add EC_USB_PD_MAX_PORTS define to avoid interdependencies.
> - [5/6] Add Reviewed-by Andy Shevchenko
> - [6/6] Add Reviewed-by Andy Shevchenko
> - [6/6] Fix the code that has_kb_wake_angle in cros_ec_sensors_register().

> Changes in v2:
> - [2/6] Add a new define to get the cros_ec_dev.
> - [3/6] Use DEVICE_ATTR variants.
> - [4/6] Use octal permissions.
> - [5/6] Drop unrelated changes.
> - [6/6] Use DEVICE_ATTR_RW variant.
> - [6/6] Use one line when fits in 80 characters.
> - [6/6] Use the previous defined to_cros_ec_dev

> Enric Balletbo i Serra (3):
>    platform/chrome: cros_ec_sysfs: introduce to_cros_ec_dev define.
>    platform/chrome: cros_ec_sysfs: use permission-specific DEVICE_ATTR
>      variants
>    platform/chrome: cros_ec_debugfs: Use octal permissions '0444'

> Gwendal Grignou (2):
>    platform/chrome: cros_ec_sysfs: Modify error handling
>    platform/chrome: mfd/cros_ec_dev: Add sysfs entry to set keyboard wake
>      lid angle

> Shawn Nematbakhsh (1):
>    platform/chrome: cros_ec_debugfs: Add PD port info to debugfs

>   drivers/mfd/cros_ec_dev.c                 |  31 +++----
>   drivers/platform/chrome/cros_ec_debugfs.c |  76 +++++++++++++++-
>   drivers/platform/chrome/cros_ec_sysfs.c   | 141
+++++++++++++++++++++---------
>   include/linux/mfd/cros_ec.h               |   2 +
>   include/linux/mfd/cros_ec_commands.h      |   3 +
>   5 files changed, 194 insertions(+), 59 deletions(-)

> --
> 2.16.2

The patchset looks good,
Tested-by: Gwendal Grignou <gwendal@chromium.org>
