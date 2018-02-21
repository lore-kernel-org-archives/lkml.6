Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeBUTEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:04:31 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39288 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeBUTE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:04:29 -0500
X-Google-Smtp-Source: AH8x226sebC9N+3VrfmhNvrYth6IlGKzINaGd0ymWRv09NxUEwWkPgjSZJ96kK2khM8tZ0rlvsUwtdRn25JMDHcPK0Y=
MIME-Version: 1.0
In-Reply-To: <20180221170748.27505-3-enric.balletbo@collabora.com>
References: <20180221170748.27505-1-enric.balletbo@collabora.com> <20180221170748.27505-3-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2018 21:04:28 +0200
Message-ID: <CAHp75Vdc1E1g7AYzASRZRfvsRsGFE6OT0+hD82YTfxMcnhGRrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] platform/chrome: cros_ec_sysfs: introduce
 to_cros_ec_dev define.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 7:07 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Add a define to get the cros_ec_dev from device and use it.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes since v1:
> - New in this series. Suggested by Andy Shevchenko.

We have an established tag

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
>  drivers/platform/chrome/cros_ec_sysfs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index c03621e523a3..85bb9580439e 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -34,6 +34,8 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>
> +#define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
> +
>  /* Accessor functions */
>
>  static ssize_t show_ec_reboot(struct device *dev,
> @@ -70,8 +72,7 @@ static ssize_t store_ec_reboot(struct device *dev,
>         int got_cmd = 0, offset = 0;
>         int i;
>         int ret;
> -       struct cros_ec_dev *ec = container_of(dev,
> -                                             struct cros_ec_dev, class_dev);
> +       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>
>         msg = kmalloc(sizeof(*msg) + sizeof(*param), GFP_KERNEL);
>         if (!msg)
> @@ -132,8 +133,7 @@ static ssize_t show_ec_version(struct device *dev,
>         struct cros_ec_command *msg;
>         int ret;
>         int count = 0;
> -       struct cros_ec_dev *ec = container_of(dev,
> -                                             struct cros_ec_dev, class_dev);
> +       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>
>         msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
>         if (!msg)
> @@ -231,8 +231,7 @@ static ssize_t show_ec_flashinfo(struct device *dev,
>         struct ec_response_flash_info *resp;
>         struct cros_ec_command *msg;
>         int ret;
> -       struct cros_ec_dev *ec = container_of(dev,
> -                                             struct cros_ec_dev, class_dev);
> +       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>
>         msg = kmalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
>         if (!msg)
> --
> 2.16.1
>



-- 
With Best Regards,
Andy Shevchenko
