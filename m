Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeCQFbP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 01:31:15 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:40753 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeCQFbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 01:31:14 -0400
X-Google-Smtp-Source: AG47ELsRR2V/SsFjL18F040KvOdS6/UfQ7/wFUZvQuKjYj48ra2eJTzzMZVLGZKQln6eLQ9ZpfcZiy2w27zxTTXk3SI=
MIME-Version: 1.0
References: <20180221170748.27505-1-enric.balletbo@collabora.com>
 <20180221170748.27505-7-enric.balletbo@collabora.com> <20180307162846.6he3rtvtzkvuwpem@dell>
In-Reply-To: <20180307162846.6he3rtvtzkvuwpem@dell>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Sat, 17 Mar 2018 05:31:01 +0000
Message-ID: <CAMHSBOXaVhxURFvDZYojL1bpYh0ixv-u9=6s2KX1BAigRtoAOw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] platform/chrome: mfd/cros_ec_dev: Add sysfs entry
 to set keyboard wake lid angle
To: Lee Jones <lee.jones@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2H5VRgT019594

On Wed, Mar 7, 2018 at 8:28 AM Lee Jones <lee.jones@linaro.org> wrote:

> On Wed, 21 Feb 2018, Enric Balletbo i Serra wrote:

> > From: Gwendal Grignou <gwendal@chromium.org>
> >
> > This adds a sysfs attribute (/sys/class/chromeos/cros_ec/kb_wake_angle)
> > used to set and get the keyboard wake lid angle. This attribute is
> > present only if 2 accelerometers are controlled by the EC.
> >
> > This patch also moves the cros_ec features check before the device is
> > added so the features map obtained from the EC is ready on time.

Enric,

I found an error in the patch. During the merge, the code that set
has_kb_wake_angle in cros_ec_sensors_register() has been lost. I uploaded a
change (that also remove call for a non-existent cros-ec-angle platform
driver) at https://chromium-review.googlesource.com/#/c/866106.

Gwendal.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > Changes since v1:
> > - Suggested by Andy Shevchenko:
> >   - Use the previous defined to_cros_ec_dev
> >   - Use one line when fits in 80 characters.
> >   - Use DEVICE_ATTR_RW variant.
> >
> >  drivers/platform/chrome/cros_ec_sysfs.c | 81
+++++++++++++++++++++++++++++++++

> >  drivers/mfd/cros_ec_dev.c               | 19 ++++----
> >  include/linux/mfd/cros_ec.h             |  1 +

> Please send me a PR with this patch contained.

> Acked-by: Lee Jones <lee.jones@linaro.org>

> --
> Lee Jones
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
