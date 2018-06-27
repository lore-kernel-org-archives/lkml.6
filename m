Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFEBC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CF9246C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7cNeEnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CF9246C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966377AbeF0WXq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:23:46 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42254 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755065AbeF0WXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:23:45 -0400
Received: by mail-vk0-f67.google.com with SMTP id s187-v6so2127551vke.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zbO5fPe9nnsRbUos/kF6qIYCI5wwWVE8TYDMG5XjENg=;
        b=e7cNeEnrajzEFrmCN1T2lR/6BFhZo98rQN1Iwm7KCOtzCe6j2Dq0MfR4K+O0R3hbM1
         cQemPsCUiG91XC0uueFcN6O92kWNFEkzRq8E3iqa5/AqyvBgRSUT6Tb/U7wnyvfpW2xS
         MAG7tQo3zPw73oYpRd15lHZ3CRchXsNO5SkuEj7CALtrfspKpy5tnHkTF9IlvOPzB8Nq
         dXdGdoafs0Q0QOu5wg/arktsjrXbtJhtGj00VYbUJphOuxqOwtzBZo44zthAlsQw33EF
         CRmrYjPe6dkZWuhGqs11xKd407a3IsmKDHEwzdtTENTg2QHHvR941N15PmSll+Nw4fUz
         no4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zbO5fPe9nnsRbUos/kF6qIYCI5wwWVE8TYDMG5XjENg=;
        b=bQOU89ntEWieu0D6t/bLNyFie+NVIAi8+RW0MLZ8T35cAUaiKkuRMAPfgJkzeiKU7X
         UryGP4EFKtCZBFSbBWTvy91ZhElURM8oNaSx4kJIjBNejzD9D0EeBuA9aZH+DmQuSBf3
         a+5NyepMe3MrUoLkKHZsIxKpPEOq20LgpZknAaXS+o3/VQDFCamFEHENJVZPHcpg7QWs
         BbwXqN7qhGkGAEKEYneJDNhSINg7xQJ9ksL30R1NWZ6myqdrWRR6+iG7F1NKGxY3/OQy
         Wld1nr2690MzncLWvAdFyr1U2SUwsjmzaP2whBHVOqGOqKg8aTcRbloI576NcqdtUgQ2
         +D+g==
X-Gm-Message-State: APt69E1Ik9n0PUEwip6LSsZT/ebHKBx6cy+XPbyzQmPz7mWWSDmSXCwD
        1nzW0HK1S9WlDkFsr3BsJTR5RyXvUz9YMEBdQXE=
X-Google-Smtp-Source: AAOMgpc9zjnTVjfDYVaKeHZBvPwl+adiVz6pEtizchQAW0Ltvjs08uJShyETew7Qa21aIBFqyDAvMjDF/jXIY3S54Yc=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr4785807vkf.26.1530138224489;
 Wed, 27 Jun 2018 15:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 15:23:43
 -0700 (PDT)
In-Reply-To: <20180627220656.19298-1-javierm@redhat.com>
References: <20180627220656.19298-1-javierm@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jun 2018 01:23:43 +0300
Message-ID: <CAHp75Vc5o54BwnQfJFXixpMD3yRTHy6UJq-m09gd1aou1B5fmw@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: add a debugfs entry to show deferred devices
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 1:06 AM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
> With Device Trees (DT), the dependencies of the devices are defined in the
> DT, then the drivers parse that information to lookup the needed resources
> that have as dependencies.
>
> Since drivers and devices are registered in a non-deterministic way, it is
> possible that a device that is a dependency has not been registered yet by
> the time that is looked up.
>
> In this case the driver that requires this dependency cannot probe and has
> to defer it. So the driver core adds it to a list of deferred devices that
> is iterated again every time that a new driver is probed successfully.
>
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
>
>   $ cat /sys/kernel/debug/devices_deferred
>   48070000.i2c:twl@48:bci
>   musb-hdrc.0.auto
>   omapdrm.0
>
> This information could be obtained partially by enabling debugging, but it
> means that the kernel log has to be parsed and the probe deferral balanced
> with the successes. This can be error probe and has to be done in a ad-hoc
> manner by everyone who needs to debug these kind of issues.
>
> Since the information is already known by the kernel, just show it to make
> it easier to debug.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>
> ---
>
> Andy, I didn't carry your Reviewed-by tag because it wasn't clear to me
> if you had agreed with the patch or not from your last email.

I just had agreed on the concerns that Greg pointed out to. If it's
resolved (*),
I'm fine with the change per se. So, my tag still stays

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(*) At least I'd got the rationale behind it, though it wasn't clear
in the previous commit message.

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
> Changes since v1:
> - Better explain in the commit message why this patch is useful.
> - Rename deferred_devices entry to devices_deferred.
> - Add an exit function and remove the debugfs entry.
>
>
>  drivers/base/dd.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 1435d7281c6..489c484301b 100644
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
> @@ -53,6 +54,7 @@ static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
>  static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
> +static struct dentry *deferred_devices;
>  static bool initcalls_done;
>
>  /*
> @@ -224,6 +226,24 @@ void device_unblock_probing(void)
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
> @@ -233,6 +253,9 @@ void device_unblock_probing(void)
>   */
>  static int deferred_probe_initcall(void)
>  {
> +       deferred_devices = debugfs_create_file("devices_deferred", 0444, NULL,
> +                                              NULL, &deferred_devs_fops);
> +
>         driver_deferred_probe_enable = true;
>         driver_deferred_probe_trigger();
>         /* Sort as many dependencies as possible before exiting initcalls */
> @@ -242,6 +265,12 @@ static int deferred_probe_initcall(void)
>  }
>  late_initcall(deferred_probe_initcall);
>
> +static void __exit deferred_probe_exit(void)
> +{
> +       debugfs_remove_recursive(deferred_devices);
> +}
> +__exitcall(deferred_probe_exit);
> +
>  /**
>   * device_is_bound() - Check if device is bound to a driver
>   * @dev: device to check
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
