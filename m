Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeFDHpb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:45:31 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50599 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeFDHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:45:29 -0400
X-Google-Smtp-Source: ADUXVKJvufQAdDRsw5YsSJkk2TaflONwNpuwiOhJwJUDK7jfG5FLqkgc64T92pcMUfRDsSUsIW61eQ==
Date: Mon, 4 Jun 2018 08:45:26 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mfd: cros_ec_dev: Don't advertise junk features on
 failure
Message-ID: <20180604074526.GL25455@dell>
References: <20180531062343.243720-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180531062343.243720-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018, Stephen Boyd wrote:

> If the feature query fails during this driver's probe, we memset the
> features bits to 0, but then we continue to overwrite that with whatever
> junk we read back when the feature probing failed. In the case of a SPI
> device, it may be complete junk, causing the caller of this function to
> think certain features are present when they aren't. Don't copy over the
> bad message on failure so we can fail more gracefully.
> 
> Fixes: e4244ebddae2 ("platform/chrome: Introduce a new function to check EC features.")
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
