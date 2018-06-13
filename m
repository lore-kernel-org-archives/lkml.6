Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0B40C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B184208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdDBvB6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B184208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934940AbeFMI2P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:28:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39482 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFMI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:28:13 -0400
Received: by mail-io0-f195.google.com with SMTP id f1-v6so2561242ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vc/i/AStmo3DGi6ZL6Ca59tVZ1HFO5WT16lYw7Izu28=;
        b=NdDBvB6MJ0oOGSUFvyMzXp6bVv2AXkd757dC2UTOYqmy+om6YTCGoQUpwRK7NzdVuT
         9gUpBUNL7cjLoQW66W/vZZb8iH5NSqe321tLbAwWT4jtZ/vATsoAshv1rLALSSDJSJ2B
         gDjy0UrXCY4to1QD4PdqQdUAp8wVMWVGzMGnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vc/i/AStmo3DGi6ZL6Ca59tVZ1HFO5WT16lYw7Izu28=;
        b=uRde2/Gat1YCZywBvBSXpWKZCyXFV+rRZD8zL9EreYHf521uuNqOvG4xlC2nUyrmpO
         Tk1LEV0zUlbVzpDTkyPBeMpJMltY6/i5SPPUEKFaPY7UpyaNGwPQT3uYmmB4qByNVlsH
         g0TN0pLNFUyZNiqcrsudEP1zhN5KIFZiu6mjT9RGnpezQo/3NBsQAww+W39x750VdjcD
         fFMAIuHEKOwF92e8Hy2rM/gfegc2XVqbcROK7V7Oq4e/+6gJNQRZUqfwEJHr76JrMN0r
         RT4F4aKWakHAxCK/2XaT35eMYSxTgJu/VVGpSXxxzxLCIe7szEFLkCBBaZrHuKBesvtH
         tMgQ==
X-Gm-Message-State: APt69E20Y3aUw2B18nUUTRc9sxglT8EEbL++y1phoQtf0Anzzp2uJyy3
        uk12s2oo76otAwMB1dtp4N0ZyDGYGbkkxS7ikHIq1A==
X-Google-Smtp-Source: ADUXVKKR64XDmnv9n3D7uIBVuot0szn+bB7fxw8zO4rpB6GQcdWsxHNHLv58WSOkn+NXns5VwQ7Q04xPfD/osbWvt8U=
X-Received: by 2002:a6b:c986:: with SMTP id z128-v6mr3897489iof.266.1528878492373;
 Wed, 13 Jun 2018 01:28:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c054:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:28:11
 -0700 (PDT)
In-Reply-To: <1692795.7GA92aXxMT@aspire.rjw.lan>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
 <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
 <1692795.7GA92aXxMT@aspire.rjw.lan>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jun 2018 10:28:11 +0200
Message-ID: <CAPDyKFqEKAfCC3Zp9v4f8xKJ64qt6vvtnzC+jia5SGTEg3x9tg@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] PM / core: Fix supplier device runtime PM usage counter imbalance
>
> If a device link is added via device_link_add() by the driver of the
> link's consumer device, the supplier's runtime PM usage counter is
> going to be dropped by the pm_runtime_put_suppliers() call in
> driver_probe_device().  However, in that case it is not incremented
> unless the supplier driver is already present and the link is not
> stateless.  That leads to a runtime PM usage counter imbalance for
> the supplier device in a few cases.
>
> To prevent that from happening, bump up the supplier runtime
> PM usage counter in device_link_add() for all links with the
> DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
> time.  Use pm_runtime_get_noresume() for that as the callers of
> device_link_add() who want the supplier to be resumed by it are
> expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
> additionally resume the supplier if the link is added during
> consumer driver probe to retain the existing behavior for the
> callers depending on it.
>
> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/core.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -216,6 +216,13 @@ struct device_link *device_link_add(stru
>                         link->rpm_active = true;
>                 }
>                 pm_runtime_new_link(consumer);
> +               /*
> +                * If the link is being added by the consumer driver at probe
> +                * time, balance the decrementation of the supplier's runtime PM
> +                * usage counter after consumer probe in driver_probe_device().
> +                */
> +               if (consumer->links.status == DL_DEV_PROBING)
> +                       pm_runtime_get_noresume(supplier);
>         }
>         get_device(supplier);
>         link->supplier = supplier;
> @@ -235,12 +242,12 @@ struct device_link *device_link_add(stru
>                         switch (consumer->links.status) {
>                         case DL_DEV_PROBING:
>                                 /*
> -                                * Balance the decrementation of the supplier's
> -                                * runtime PM usage counter after consumer probe
> -                                * in driver_probe_device().
> +                                * Some callers expect the link creation during
> +                                * consumer driver probe to resume the supplier
> +                                * even without DL_FLAG_RPM_ACTIVE.
>                                  */
>                                 if (flags & DL_FLAG_PM_RUNTIME)
> -                                       pm_runtime_get_sync(supplier);
> +                                       pm_runtime_resume(supplier);
>
>                                 link->status = DL_STATE_CONSUMER_PROBE;
>                                 break;
>
