Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF141C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8212B2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlfD67jQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAYTXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:23:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54261 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYTXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:23:02 -0500
Received: by mail-it1-f195.google.com with SMTP id g85so12168882ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hslTYOs3ICnzj02MvNWO5ms7OjwDocGxzQQ3FsIOdBY=;
        b=QlfD67jQJDy3TeHcnDvGq3wnYl1j4gVoCd6faJgW1g/Qg5bAIL5y0H1dtcqxe2JkdD
         mPTwE50ruz8rofYC/YHNtYe7JWFEmsPiZvpsDFkkvSPSuK535E8C4e6KX87JCt2MWbt9
         qBWyKtC2POaCENSbW6D8oe9sHKrIURa18Jqlx0TRvqkSh0Wt2Lpwek5GKtTpPxYpWd9W
         mhVhaXgAFlOqR5Z6NSxwP0uCJxwyOySfgcZmyDCa1sBB1bWxXByvff9znllTXzIZ+ob4
         tbQD61fsvtMcUlwc31kgHfJnBRRNajvP7wdZgnyyJ1EAFyj2ZDUuI+zHc+BA19m49wQe
         40yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hslTYOs3ICnzj02MvNWO5ms7OjwDocGxzQQ3FsIOdBY=;
        b=mH1TGX1piFnjslOfXOTBIQMrYGpam8WfFtXTTwh1dI1mzXRJNFFQ/xuh/PgrgzFrZU
         7vw1hY4ulaLzqLrtce5JLETKqGKmsWJT0+/YEilByt4nuRHI/3gNf9GMfGIyLvOmCIMf
         uuW9qnELKDBOlElIxC24NFbg56KpY0geDr+8m/86Cf8KSD8e9M3dxdTD5wXdgSD51tdU
         gM7BzVrNsUyRmzR33PYJsIYp2cLd+W9trdDd5+nCvVUYwtKk+NbW9PR50z/NNmd//YIi
         XQOu5ptj4dFJHKm6oj2G/sBPlzjR5aMwUbXsPwgQkZXY+VW9WT48/IC978yFyJKr4YKF
         UFoQ==
X-Gm-Message-State: AJcUukdzR1/cpx15OxAkEdBNI50eNnneqMQqi4HmSgzm6J7w4EL2oPO7
        FdTOuDmCnlm9OllcASnLbjKMaNaLfB5n7Y/1WdM=
X-Google-Smtp-Source: ALg8bN4KmDif62cVnWzDReud+Sel6pA6fc3/rPyeFVEfv7DmYyluOOE4xjHZAbPDz8Ogx2B4aKWQb5LjfAuzkEJrjxY=
X-Received: by 2002:a24:2ed3:: with SMTP id i202mr4615497ita.89.1548444180755;
 Fri, 25 Jan 2019 11:23:00 -0800 (PST)
MIME-Version: 1.0
References: <1548422416-44786-1-git-send-email-feng.tang@intel.com>
In-Reply-To: <1548422416-44786-1-git-send-email-feng.tang@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 25 Jan 2019 11:22:49 -0800
Message-ID: <CAKgT0Ud6U2MUmf3ectnVKa2D1D+xmpz14PwUrg0w0QOJ6SpuOQ@mail.gmail.com>
Subject: Re: [RFC PATCH] async: Add cmdline option to specify drivers to be
 async probed
To:     Feng Tang <feng.tang@intel.com>, alexander.h.duyck@linux.intel.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:20 AM Feng Tang <feng.tang@intel.com> wrote:
>
> Asynchronous driver probing can help much on kerenl fastboot, and
> this option can provide a flexible way to optimize and quickly verify
> async driver probe.
>
> Also it will help in below cases:
> * Some driver actually covers several family of HWs, some of which
>   could use async probling while others don't. So we can't simply
>   turn on the PROBE_PREFER_ASYNCHRONOUS flag in driver, but use this
>   cmdline option, like igb driver discussed at
>   https://www.spinics.net/lists/netdev/msg545986.html
>
> * For SOC (System on Chip) with multiple spi or i2c controllers, most
>   of the slave spi/i2c devices will be assigned with fixed controller
>   number, which prevents these spi/i2c controller drivers to be async
>   probed. For plaforms not using these spi/i2c slave devices, they can
>   use this cmdline option to benefit from the async probing.
>
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>

Actually instead of using my personal email I would prefer if you used
"alexander.h.duyck@linux.intel.com".

> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  drivers/base/dd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af..1f257561 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -57,6 +57,10 @@ static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>  static struct dentry *deferred_devices;
>  static bool initcalls_done;
>
> +/* Save the async probe drivers' name from kernel cmdline */
> +#define ASYNC_DRV_NAMES_MAX_LEN        256
> +static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
> +
>  /*
>   * In some cases, like suspend to RAM or hibernation, It might be reasonable
>   * to prohibit probing of devices as it could be unsafe.
> @@ -674,8 +678,26 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
>         return ret;
>  }
>
> +static inline bool cmdline_requested_async_probing(const char *drv_name)
> +{
> +       return parse_option_str(async_probe_drv_names, drv_name);
> +}
> +
> +static int __init save_async_options(char *buf)
> +{
> +       if (strlen(buf) >= ASYNC_DRV_NAMES_MAX_LEN)
> +               printk(KERN_WARNING "Too long list for async_probe_drv_names!");
> +
> +       strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN - 1);
> +       return 0;
> +}
> +__setup("driver_async_probe=", save_async_options);
> +
>  bool driver_allows_async_probing(struct device_driver *drv)
>  {
> +       if (unlikely(cmdline_requested_async_probing(drv->name)))
> +               return true;
> +

Instead of placing it here it might make more sense to place it down
in the "default" case. This way we don't override a
PROBE_FORCE_SYNCHRONOUS if that is the probe type value used by the
driver.

>         switch (drv->probe_type) {
>         case PROBE_PREFER_ASYNCHRONOUS:
>                 return true;
> --
> 2.7.4
>
