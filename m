Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeBWQ2A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:28:00 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:46761 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeBWQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:27:57 -0500
X-Google-Smtp-Source: AG47ELsc8gUFwB0nVqyuRgntez5fW9IC+4Noh8C4z+8h4XRVwoPWTYvxRlG3IpTvqhHBwCe8BerfblVhbzHhcA4fvSY=
MIME-Version: 1.0
In-Reply-To: <20180223151122.11567-4-enric.balletbo@collabora.com>
References: <20180223151122.11567-1-enric.balletbo@collabora.com> <20180223151122.11567-4-enric.balletbo@collabora.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 23 Feb 2018 18:27:56 +0200
Message-ID: <CAHp75Vf1bcOPxDKS08ExrDTj9thTxyYLY=UE3ch9s7wX_iJhDw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] mfd: cros_ec_i2c: moving the system sleep pm ops
 to late
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 5:11 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Joseph Lo <josephl@nvidia.com>
>
> The cros_ec_i2c driver is still active after it had suspended or before it
> resumes. Besides that, it also tried to transfer data even after the I2C
> host had been suspended. This will lead the system to crash.
>
> During the test, we also observe that the EC needs to be resumed earlier
> due to some status polling from the EC FW (e.g. battery status). So we
> move the PM ops to late stage to make it work normally.

> -static SIMPLE_DEV_PM_OPS(cros_ec_i2c_pm_ops, cros_ec_i2c_suspend,
> -                         cros_ec_i2c_resume);

> +const struct dev_pm_ops cros_ec_i2c_pm_ops = {
> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_i2c_suspend, cros_ec_i2c_resume)
> +};


Why static disappeared?

-- 
With Best Regards,
Andy Shevchenko
