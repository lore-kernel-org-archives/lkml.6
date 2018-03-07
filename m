Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbeCGQHF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:07:05 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38809 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933479AbeCGQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:07:01 -0500
X-Google-Smtp-Source: AG47ELuF/g7KaNbHUvylgbYbiIJvWwer9draxkUkBUlA7maxQIQT6cOkqfJP+7pkrho724vsM+HpNQ==
Date: Wed, 7 Mar 2018 16:06:58 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: groeck@chromium.org, andy.shevchenko@gmail.com, kernel@collabora.com,
        gwendal@chromium.org, linux-kernel@vger.kernel.org,
        Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH v3 8/8] mfd: cros_ec_i2c: moving the system sleep pm ops
 to late
Message-ID: <20180307160658.eezwydvv44oruw32@dell>
References: <20180226102606.15093-1-enric.balletbo@collabora.com>
 <20180226102606.15093-9-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226102606.15093-9-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Enric Balletbo i Serra wrote:

> From: Joseph Lo <josephl@nvidia.com>
> 
> The cros_ec_i2c driver is still active after it had suspended or before it
> resumes. Besides that, it also tried to transfer data even after the I2C
> host had been suspended. This will lead the system to crash.
> 
> During the test, we also observe that the EC needs to be resumed earlier
> due to some status polling from the EC FW (e.g. battery status). So we
> move the PM ops to late stage to make it work normally.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Changes in v3:
> - [8/8] Add static to cros_ec_i2c_pm_ops.
> - [8/8] Add the Reviewed-by Andy Shevchenko.
> 
> Changes in v2:
> - [8/8] This patch is new in this series replacing [5/6] of v1.
> 
>  drivers/mfd/cros_ec_i2c.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
