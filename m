Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A29DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3426121526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRADcSez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3426121526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQTaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:30:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37605 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:30:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id d14-v6so29498398qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04QSD0e3zhfJhEu92WOWMQ/lx1OgM8EE3aevV5ZUBes=;
        b=lRADcSezK8m3JIyvqHqisMjLFm2Fh9HqPaXDLRA++jwUS6l7hcvA6ao5k+kXSiyEe+
         9dDijdHWnB0mIlj5+y1PE8UB//x4e3t7Wif7u1Vk8AGSSdZhzCsk+rc6aLY08ysJc1/W
         ldLJQA6Awn3EOiLkljdrysAZDoqA09x7CJralRk+4JD7KmOJNAVahhT9sI1yoPPTgWA3
         6lTNhtlMLvSo8vPkdeNYqQk1OJpLpNv3vKMhopmOHKy9s8VE7QyoMBVTmwwFzy+uBv0A
         3bBCIleThfBWXyj/1blBKd1tsut9ExLb7Kx9SPSAdSX/iCbO8G45/bk5t7iaP4FHVPel
         EJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04QSD0e3zhfJhEu92WOWMQ/lx1OgM8EE3aevV5ZUBes=;
        b=AordX27KF2OnEqWR/1ymg59xCWB5PJ0bgFqmA1aniYiedhPTmTDbzs610JB4+Ihmpm
         XAgJ70Olz9PPSwMx4Am94CWZgZ/ABa1PE5tbguEtme+Ef6YOydupzZCpJNExV1J7d3AJ
         rR4ydL3eh6L9Sj+53VlDYEcd4shjDlr8PtyyyS461b4MNI8zaCckUuar0f9F/K8SHpSo
         6JSqL2d5JAmJvsPe9xMEv6UDgsmGvQh98zxDqZK+q1Ol5disQWlmXt4jMnAZRKoLS1mr
         NHLOn6Vo7qSj2w0HXOZlwCZ2TV8gofLsXmZA4BdWC1R2HtHMrwVUlGw6ncLaK2p0Ua0l
         ZyDA==
X-Gm-Message-State: ABuFfogUhn/+ydUnj68dyKx50EP0cYct3TOqzJig249jK636g0GeDNjZ
        +0FdOV3fZeUdLHdHamSCRGuBIbyP9Xqztpjj25Y=
X-Google-Smtp-Source: ACcGV63bw6ZBQ84L7lLHHczW/XlUPo5O9IEwek3/x6xwQmxZPe3jVeWs8djkZJnX+CO26LPGLiDEiUNcv3XXfl2f5f8=
X-Received: by 2002:aed:2de3:: with SMTP id i90-v6mr5625705qtd.229.1539776111662;
 Wed, 17 Oct 2018 04:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181017085952eucas1p2ff93b96d300aab2dc70b97bf266978ab@eucas1p2.samsung.com>
 <CAHp75VefP2qit3=s9E_uuOg4+J0Zk2OD-XjpVsWM7X3s2g-0wA@mail.gmail.com> <20181017085936.30886-1-a.hajda@samsung.com>
In-Reply-To: <20181017085936.30886-1-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 14:35:00 +0300
Message-ID: <CAHp75Vd2c3sHz=ZObsNAyEmOK-=__2=y-soDM5DqNUyLLK8jdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:59 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
>

Looks good to me (with one comment below since patch 1 will be changed anyway),
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> v2:
>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>   - use kasprintf instead of bunch of code,
>   - keep consistent format of devices_deferred lines,
>   - added R-Bs (again I hope changes above are not against it).
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c | 11 +++++++----
>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>  3 files changed, 30 insertions(+), 5 deletions(-)
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
> index aa6f3229d066..560758b2ae79 100644
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
> @@ -3091,13 +3092,15 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>         struct va_format vaf;
>         va_list args;
>
> -       if (err == -EPROBE_DEFER)
> -               return err;
> -
>         va_start(args, fmt);
>         vaf.fmt = fmt;
>         vaf.va = &args;

> -       dev_err(dev, "%pV, %d\n", &vaf, err);
> +

This new line can be part of patch 1.

> +       if (err != -EPROBE_DEFER)
> +               dev_err(dev, "%pV, %d\n", &vaf, err);
> +       else
> +               __deferred_probe_set_msg(dev, &vaf);
> +

Here you may still keep the same, i.e. positive, conditional.

>         va_end(args);
>
>         return err;
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..345fbfe335d1 100644
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
> +               kfree(dev->p->deferred_probe_msg);
> +       dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV",
> +                                              dev_driver_string(dev), vaf);
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
> +               seq_printf(s, "%s\t%s\n", dev_name(curr->device),
> +                          curr->device->p->deferred_probe_msg ?: "");
>
>         mutex_unlock(&deferred_probe_mutex);
>
> --
> 2.18.0
>


-- 
With Best Regards,
Andy Shevchenko
