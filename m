Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeBZOs2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:48:28 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:47022 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbeBZOsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:48:24 -0500
X-Google-Smtp-Source: AG47ELtymGqDTzca8X2duO4mlOqM3WGVucj0IqlZcAJ6Gjpwh0g+6GYHJxWZqMSZxCM47UCHQ5+IBxZI4ZYROflswL4=
MIME-Version: 1.0
In-Reply-To: <20180226144118.24693-2-enric.balletbo@collabora.com>
References: <20180226144118.24693-1-enric.balletbo@collabora.com> <20180226144118.24693-2-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 16:48:23 +0200
Message-ID: <CAHp75VcervG-TWbt6t7q7505meXG=0E3hrO8pT-pc_=BJGqwpw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] thermal: core: introduce thermal zone
 device mode control
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, groeck@chromium.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        snanda@chromium.org, Len Brown <lenb@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 4:41 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:

> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c

>         if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
> -               result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
> +               mode = THERMAL_DEVICE_ENABLED;
>         else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
> -               result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
> +               mode = THERMAL_DEVICE_DISABLED;
>         else
> -               result = -EINVAL;
> +               return -EINVAL;

sysfs_match_string()?


-- 
With Best Regards,
Andy Shevchenko
