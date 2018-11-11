Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B651621104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkieru3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B651621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbeKKWxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:53:03 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36697 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeKKWxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:53:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so9164641qkf.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 05:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnBlG7472MsHKS6fCFX38wZUoRGSjjtO4xY3qxu6Dv8=;
        b=jkieru3AyPXdJOlI+fErpNFFcp80QCs04lQz2p71VagZrGqzMTZ5l9wJJLiFkef0+Z
         OL1cuoTiNWGSLvZ18zMvu+g9F7J5EYzLaqXt6y6AZlkFdQRw4x4nuRmAIIi28XSig4nq
         /RhdS09RpqUoyHiCvMRMqQ8zLOsu7SwL1xksq+cSTbpi6SdQxH+WC1AHqKCEeZWNvVUU
         83377rg9S1ODT50J3Dro7b+Os8ZXAWpsJG2PSPhOJCxO86rtJfpo0yuSgczjfYt7KC/O
         IlevzmpzNz2TQM/2cSt+HqjtiHOC1kLuZh/Cw/M+QnyApLJTjL0o2Mbt1Xbu1P4uxRxN
         9Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnBlG7472MsHKS6fCFX38wZUoRGSjjtO4xY3qxu6Dv8=;
        b=B5wep2y91ivLxODJuj97iBZUpJcB0gUd6nvrhPDpR4rsZi7RXPv/fkoStLAkTKXnKd
         8NoYDpnI7MYhL4KD5i74z4ZfyWeI1SebKOlpoeRiVi7Xo+xgHARzpB3ZqkkNn0r7VcJx
         M+B/2diXDCz+g0BzZv9jdTyc5iHXpGlCut1JlPyHQLJCbxNB5jgBP38OqQja9C+NIca8
         e0hvNlVMQrbP+nSwYfZoUX2vy+Vf6Ibs3Sv3Nakd859tXvd7BX+Y/f0JcwFaf0NaMX3u
         IMxUDUAjblxk1iZZMr15YbAzJDu97jIkAPATe8qsePwMR1iVgvlSrxCIJblGC8fItcNq
         /OAg==
X-Gm-Message-State: AGRZ1gKj2jTqjihioJkl1UKXvf+DO6jRXqEUXkUFFEzulCnsvw7v51Ik
        e9qkPK7RMUEmTKfJ8b5le7YipVG1k58g37vi8Aw=
X-Google-Smtp-Source: AJdET5d9DE9+PaMGygw5cQMJC4M9UNt2Ux4BlWj1/tCf+jwRYW13+ElkK8t9PEgbqhp/HXpFjp19Gilao6obbxNaWQU=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr15771283qvh.136.1541941470544;
 Sun, 11 Nov 2018 05:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 11 Nov 2018 15:04:18 +0200
Message-ID: <CAHp75VfwKbzLNrxWRhoGW3aLN1PLWhx7sXWMgyFw2kS+4KZcuQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Grant Likely <grant.likely@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I seems Grant's mail delivery bounces messages. I delibirately reduced
the Cc list for sake of ping Grant in case it would pass.

On Sat, Nov 10, 2018 at 8:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Consider the following scenario.
>
> There are two independent devices coupled together by functional dependencies:
>  - USB OTG (dwc3-pci)
>  - extcon (tested with extcon-intel-mrfld, not yet in upstream)
>
> Each of the driver services a corresponding device is built as a module. In the
> Buildroot environment the modules are probed by alphabetical ordering of their
> modaliases. The latter comes to the case when USB OTG driver will be probed
> first followed by extcon one.
>
> So, if the platform anticipates extcon device to be appeared, in the above case
> we will get deferred probe of USB OTG, because of ordering.
>
> Now, a cherry on top of the cake, the deferred probing list contains
> the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
> values in the local_trigger_count and deferred_trigger_count are not the same,
> and thus provokes deferred probe triggering again and again.
>
> ...
> [   20.678332] platform dwc3.0.auto: Retrying from deferred list
> [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.701254] platform dwc3.0.auto: Added to deferred list
> [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
> [   20.713732] platform dwc3.0.auto: Retrying from deferred list
> [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.736540] platform dwc3.0.auto: Added to deferred list
> [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
> [   20.748991] platform dwc3.0.auto: Retrying from deferred list
> [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> [   20.771914] platform dwc3.0.auto: Added to deferred list
> [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
> ...
>
> Deeper investigation shows the culprit commit 58b116bce136
> ("drivercore: deferral race condition fix") which was dedicated to fix some
> other issue while bringing a regression.
>
> This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
> we will have better solution.
>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/dd.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 169412ee4ae8..9a966e45fda5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -53,7 +53,6 @@
>  static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
> -static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>  static struct dentry *deferred_devices;
>  static bool initcalls_done;
>
> @@ -143,17 +142,6 @@ static bool driver_deferred_probe_enable = false;
>   * This functions moves all devices from the pending list to the active
>   * list and schedules the deferred probe workqueue to process them.  It
>   * should be called anytime a driver is successfully bound to a device.
> - *
> - * Note, there is a race condition in multi-threaded probe. In the case where
> - * more than one device is probing at the same time, it is possible for one
> - * probe to complete successfully while another is about to defer. If the second
> - * depends on the first, then it will get put on the pending list after the
> - * trigger event has already occurred and will be stuck there.
> - *
> - * The atomic 'deferred_trigger_count' is used to determine if a successful
> - * trigger has occurred in the midst of probing a driver. If the trigger count
> - * changes in the midst of a probe, then deferred processing should be triggered
> - * again.
>   */
>  static void driver_deferred_probe_trigger(void)
>  {
> @@ -166,7 +154,6 @@ static void driver_deferred_probe_trigger(void)
>          * into the active list so they can be retried by the workqueue
>          */
>         mutex_lock(&deferred_probe_mutex);
> -       atomic_inc(&deferred_trigger_count);
>         list_splice_tail_init(&deferred_probe_pending_list,
>                               &deferred_probe_active_list);
>         mutex_unlock(&deferred_probe_mutex);
> @@ -434,19 +421,9 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
>  static atomic_t probe_count = ATOMIC_INIT(0);
>  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>
> -static void driver_deferred_probe_add_trigger(struct device *dev,
> -                                             int local_trigger_count)
> -{
> -       driver_deferred_probe_add(dev);
> -       /* Did a trigger occur while probing? Need to re-trigger if yes */
> -       if (local_trigger_count != atomic_read(&deferred_trigger_count))
> -               driver_deferred_probe_trigger();
> -}
> -
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
>         int ret = -EPROBE_DEFER;
> -       int local_trigger_count = atomic_read(&deferred_trigger_count);
>         bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>                            !drv->suppress_bind_attrs;
>
> @@ -463,7 +440,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>
>         ret = device_links_check_suppliers(dev);
>         if (ret == -EPROBE_DEFER)
> -               driver_deferred_probe_add_trigger(dev, local_trigger_count);
> +               driver_deferred_probe_add(dev);
>         if (ret)
>                 return ret;
>
> @@ -559,7 +536,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>         case -EPROBE_DEFER:
>                 /* Driver requested deferred probing */
>                 dev_dbg(dev, "Driver %s requests probe deferral\n", drv->name);
> -               driver_deferred_probe_add_trigger(dev, local_trigger_count);
> +               driver_deferred_probe_add(dev);
>                 break;
>         case -ENODEV:
>         case -ENXIO:
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
