Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241D2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAD72083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7b/QIy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAD72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030534AbeFSVGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:06:21 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34635 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967240AbeFSVGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:06:20 -0400
Received: by mail-vk0-f66.google.com with SMTP id q135-v6so698715vkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+s2oMIa5ukvMX1ieXdmMnYD6Qfp1qu/Pn6JA/bACHHM=;
        b=A7b/QIy/YT/sEY+x8M3mTiyeo9zSh+e0OosjhpUQJKX/dZW+b3IiBeY241kBHX+aKU
         blEYLuRWbPPyLI7T2vr37RwdTr8B+T8yZ40+f4U4G03/ZE8WdG/ayCfBqKpzALDqTpE+
         3Z+EeJ/i1OanHYqxhwL0p7Et53ufivqqJM77b8bCeVQVl5xE+QPzYEIZkGurrrzSzdSl
         GljgmfAv6cIRiqs/1f+aRPhnSZP0Z4mtkgJlEP7hJmRElDM+XX4IRBxSJaXpEQLDhVIn
         b8PIrHlMb/6bz5mrMAf1zU8Il2oA1q9U5O8VAOkyJCm71r+7I3Qhk234EAl9ccrd8tTJ
         cUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+s2oMIa5ukvMX1ieXdmMnYD6Qfp1qu/Pn6JA/bACHHM=;
        b=qUIVQUmG+sNcfgguXwqxzmnM3curlZh2mAQYzwdGYJ2DKUY1GO8lLE4wRiYP4QIEDZ
         OlH5NosvH4vg/VVupU7d+yOoZJhKDSaZmlXbkVNMUdtCrl5azGDRwcqZwxgw49shaTo5
         UA6hMEL54j3h3g8NE9VYcE8ST29OAXKWilTKf7dCq5LfyQt2DSF+j8XJTX5xExOoszjC
         UAWyktZiQR7wmr6CeU9JLmnRuO+evI1QZXLlriX5MC5/M+jHGf4CsEwXk8+Vy9wfG32R
         4Yy0+mb8lDizQnJJvhgTHFC4ClAdDWmVx0mGBUfFCVX6b8LpoyOo4tTIeYVAnAdsDfLh
         fwKw==
X-Gm-Message-State: APt69E1rBlv+3Zup7HvHqIQdI2ScOiNZIQSvAgNw5s4Y3NbOOWJnn9Ct
        i4x+KAJPNnRwUJITkQ3vXfDgiAp46Ag4ANTXkO4=
X-Google-Smtp-Source: ADUXVKIW0AZqGY3tYg/H6roAOfX3qgKdYrkynFDdb1kFOVSf6Qje5FEq02Cj9KWv7ROzSzjVn3v6pUVKyLlSFYaSyH0=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr10730948vkd.187.1529442379783;
 Tue, 19 Jun 2018 14:06:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 14:06:19
 -0700 (PDT)
In-Reply-To: <20180619205914.21375-1-javierm@redhat.com>
References: <20180619205914.21375-1-javierm@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jun 2018 00:06:19 +0300
Message-ID: <CAHp75VeHWNi2UFEjYOG5xMmb_AWoAwS37U62uCcM3-V6TvVp4g@mail.gmail.com>
Subject: Re: [PATCH] driver core: add a debugfs entry to show deferred devices
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:59 PM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
>
>   $ cat /sys/kernel/debug/deferred_devices
>   48070000.i2c:twl@48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> ---
>
> Changes since RFC v1:
> - Remove unneeded ret variable from deferred_devs_show()
>
> Changes since RFC v2:
> - Use DEFINE_SHOW_ATTRIBUTE() macro.
> - Don't propagate debugfs_create_file() error.
> - Remove IS_ENABLED(CONFIG_DEBUG_FS) guards.
> - Drop RFC prefix.
>
>  drivers/base/dd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d7281c6..8ec9e3cfbe4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -16,6 +16,7 @@
>   * Copyright (c) 2007-2009 Novell Inc.
>   */
>
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> @@ -224,6 +225,24 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +/*
> + * deferred_devs_show() - Show the devices in the deferred probe pending list.
> + */
> +static int deferred_devs_show(struct seq_file *s, void *data)
> +{
> +       struct device_private *curr;
> +
> +       mutex_lock(&deferred_probe_mutex);
> +
> +       list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> +               seq_printf(s, "%s\n", dev_name(curr->device));
> +
> +       mutex_unlock(&deferred_probe_mutex);
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(deferred_devs);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -233,6 +252,9 @@ void device_unblock_probing(void)
>   */
>  static int deferred_probe_initcall(void)
>  {
> +       debugfs_create_file("deferred_devices", 0444, NULL, NULL,
> +                           &deferred_devs_fops);
> +
>         driver_deferred_probe_enable = true;
>         driver_deferred_probe_trigger();
>         /* Sort as many dependencies as possible before exiting initcalls */
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
