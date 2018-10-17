Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B66ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02C3214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtNsF1Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02C3214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJQWNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:13:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35950 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeJQWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:13:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id a85-v6so16548345qkg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Auy6A7nZyjkaINCspo+YaVJkei55i/ixp+Oe//zMYAI=;
        b=qtNsF1XdZO76bEEXRMIOlycYeCY60Pl5udpkdW6m6XbQLjrdcCc3mtvU8DnNr74nWG
         DtMWrvmnbSLh+K5sFKvI0+VyErGgZzGGLvfpoCIybfpJXvcZk1CDXC9MTF4zw9i6z1BK
         /EfILSGDbcVMIZNH5oSrbm/rRYUNLanEDrhfoMxxJ+fy6yqCXcGktTItZXbWw7SME6Dl
         egMcE+hcguYOOeg7XPnr7Ri+jtLWKryZ95uAhYQKSqPSMt8oRqiU+DcxcM1NMu/Xiy3Q
         DsUgFK9lc/5KkIF8a2eOB7E6616n501NRAX4e/hlwEQ/ZsWVVmT2YnLHkYCX1m33EhUI
         fZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Auy6A7nZyjkaINCspo+YaVJkei55i/ixp+Oe//zMYAI=;
        b=ipmQPjziu9cA84utUY/Hc6nejKHPRYZz0HtcJE9fti9Fsv3MwOLmFxuEyRdFFtcXIu
         6rOJmuZb7gTa0UHqMx/Jh4uZqj4kwXPO08JkaIrj3J6LIo/K4lpXnMpz/diGOpm9ddHw
         aUfziZqOLygm8HHjBHco8HzJYTFov3Gtyz/NiD5AU+yJb9xwUwWoLJqA8aTSp/4wa7jr
         nBz5rGZdc0EEWoppXkEJ7EUr+Q4by2sUja/+Qm/03CTo7jlTYuX+FmKM+r8giWjlUqWb
         ECtPUNjcT6BoynfsGGVU5uAaQXPy4JpZNg+0RervbFneBB0gzuxYsFzuTBart92R7ncF
         pn4Q==
X-Gm-Message-State: ABuFfoiCN6So34PhLb0cnjwPS25K7NTWIBohTNpEkLt355jVGiDkGJ8R
        BK7uD0X35HndhXlE03X+CBk7vfir/GNuiZ4TkPU=
X-Google-Smtp-Source: ACcGV637y1ACrBRP+ZsLrEdESzwcCwRQZhjXbb3oTng2s8JRUixntibzTtGvenWkegsajLUPAKY7C8c5sdPg1IPiwAE=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr24669009qkg.70.1539785871263;
 Wed, 17 Oct 2018 07:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017132404eucas1p2a413f6853af8f11a874650b6289d56cf@eucas1p2.samsung.com>
 <CAHp75Vd2c3sHz=ZObsNAyEmOK-=__2=y-soDM5DqNUyLLK8jdA@mail.gmail.com> <20181017132400.5300-1-a.hajda@samsung.com>
In-Reply-To: <20181017132400.5300-1-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 17:17:39 +0300
Message-ID: <CAHp75VdwnHLuXazD926CU+HWWv+sgp8BFCdW=vHqzMqsE87Ekg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 4:24 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v3:
>   - adjusted deferred_devs_show, to accept newline ended messages,
>   - changed conditonal check to positive,
>   - added R-b by Andy.
> v2:
>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>   - use kasprintf instead of bunch of code,
>   - keep consistent format of devices_deferred lines,
>   - added R-Bs (again I hope changes above are not against it).
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c |  9 +++++----
>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..effbd5e7f9f1 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -75,6 +75,7 @@ struct device_private {
>         struct klist_node knode_driver;
>         struct klist_node knode_bus;
>         struct list_head deferred_probe;
> +       char *deferred_probe_msg;
>         struct device *device;
>  };
>  #define to_device_private_parent(obj)  \
> @@ -113,6 +114,8 @@ extern void device_release_driver_internal(struct device *dev,
>  extern void driver_detach(struct device_driver *drv);
>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>  extern void driver_deferred_probe_del(struct device *dev);
> +extern void __deferred_probe_set_msg(const struct device *dev,
> +                                    struct va_format *vaf);
>  static inline int driver_match_device(struct device_driver *drv,
>                                       struct device *dev)
>  {
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 1f3e99c2ef03..27990110fb24 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3076,6 +3076,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>   *
>   * This helper implements common pattern present in probe functions for error
>   * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * In case of -EPROBE_DEFER it sets defer probe reason.
>   * It replaces code sequence:
>   *     if (err != -EPROBE_DEFER)
>   *             dev_err(dev, ...);
> @@ -3091,14 +3092,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>         struct va_format vaf;
>         va_list args;
>
> -       if (err == -EPROBE_DEFER)
> -               return err;
> -
>         va_start(args, fmt);
>         vaf.fmt = fmt;
>         vaf.va = &args;
>
> -       dev_err(dev, "error %d: %pV", err, &vaf);
> +       if (err == -EPROBE_DEFER)
> +               __deferred_probe_set_msg(dev, &vaf);
> +       else
> +               dev_err(dev, "error %d: %pV", err, &vaf);
>
>         va_end(args);
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..6e488146b328 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -27,6 +27,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
> +#include <linux/slab.h>
>
>  #include "base.h"
>  #include "power/power.h"
> @@ -132,6 +133,8 @@ void driver_deferred_probe_del(struct device *dev)
>         if (!list_empty(&dev->p->deferred_probe)) {
>                 dev_dbg(dev, "Removed from deferred list\n");
>                 list_del_init(&dev->p->deferred_probe);
> +               kfree(dev->p->deferred_probe_msg);
> +               dev->p->deferred_probe_msg = NULL;
>         }
>         mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -202,6 +205,21 @@ void device_unblock_probing(void)
>         driver_deferred_probe_trigger();
>  }
>
> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device
> + */
> +void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
> +{
> +       mutex_lock(&deferred_probe_mutex);
> +

> +       if (dev->p->deferred_probe_msg)

Sorry, I have noticed this a bit late, this check is not needed, since
kfree() is NULL-aware.

> +               kfree(dev->p->deferred_probe_msg);
> +       dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV",
> +                                              dev_driver_string(dev), vaf);

...and perhaps slightly better looking (up to you):

const char *drv = dev_driver_string(dev);

...

... = kasprintf(..., drv, ...); // it would be exactly oneline

> +
> +       mutex_unlock(&deferred_probe_mutex);
> +}
> +
>  /*
>   * deferred_devs_show() - Show the devices in the deferred probe pending list.
>   */
> @@ -212,7 +230,8 @@ static int deferred_devs_show(struct seq_file *s, void *data)
>         mutex_lock(&deferred_probe_mutex);
>
>         list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> -               seq_printf(s, "%s\n", dev_name(curr->device));
> +               seq_printf(s, "%s\t%s", dev_name(curr->device),
> +                          curr->device->p->deferred_probe_msg ?: "\n");
>
>         mutex_unlock(&deferred_probe_mutex);
>
> --
> 2.18.0
>


-- 
With Best Regards,
Andy Shevchenko
