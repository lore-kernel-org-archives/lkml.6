Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A2EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5162075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAfg5xir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5162075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030643AbeFSTxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:53:09 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42198 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030510AbeFSTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:53:08 -0400
Received: by mail-ua0-f194.google.com with SMTP id x18-v6so605679uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zy6PuIUKch9bSzWNtjL2QEuV4nkzE4CTZhF8kG/y3UM=;
        b=RAfg5xirIWvnKMcBPPQhpunPko6AKAyXDp+29EEJJC1bqSzn+V/2kpNOQlPvjkz0ZX
         kJotq+PituPYghtDuMUoGMPk+QjJbUpVeRVzAI9oeMwrUpMPZJV6Uu8Jpas1+Q+sQ+Rk
         fb2tv4WhLjE8zfbHL1KItxQQuTRqTGi51wH8IyzXcvyJkNv2WkDBJeP+E/mmdoWlmwam
         Jo9pctw/TxdVpuqqv9aGeSRqdRotCl72RigIHYmFdP0MGk/lbscIIo3rKe0DREB5gF30
         hBOn8WKlY2WKQvi/D29hUw49ZNKkgK6QwKEX7WzFBhHjI9NiSV5FAgenwZWdBveqBZkW
         w0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zy6PuIUKch9bSzWNtjL2QEuV4nkzE4CTZhF8kG/y3UM=;
        b=dpAoWQ8Q+rHgJJusubfeVcxY+hHol6vI8OGYEZhY7zu155PDU4RQmk/y4YUdhOpGWM
         popKVfGn4T637e9RkpRtDHh0z88yQLmVOlW4+FEmgcediXp9Jha1Bb23QrW8umBGFJk+
         nqTqWLTtFAdCJWKoVrKo0/3UfQSwckH8U/9b0Y3yXtsz6HhMo4HXOFPjzvbNMZutPvWf
         084zsgQAZfOvJV52GZkHvR7Q+v18KWwgvDl5jtZYdiL/59j/ElzsMwUiRi12Igq42qTU
         oN3JP/WR4TcG6aVGBYSTAIWU6SPIGd1xSyg708jVmGMTNSnCzpiEODKgVQWqwt2EarhN
         zvcg==
X-Gm-Message-State: APt69E3KG3JuNDrgBy6gCuCvP9ScpJtSHtsvU9r+f/i1FgODO7UJItOc
        ZK9BGjWje5AtMUMBEiE+c0GViC+NI+yGrEHqZOGBM9wU
X-Google-Smtp-Source: ADUXVKIXYih+9w3X0RCb2WK1om8DQWCb8Da+cfCNxHQrtsYcHV/mbBGxV+8OHRtFOb5GY7iW0JQScke29fxW0xZpj1k=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr11248099uae.199.1529437987854;
 Tue, 19 Jun 2018 12:53:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 12:53:07
 -0700 (PDT)
In-Reply-To: <20180619183356.32106-1-javierm@redhat.com>
References: <20180619183356.32106-1-javierm@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 22:53:07 +0300
Message-ID: <CAHp75Vcn39N9rZ0UO3szGrODVLxek4X746uWs+RPXwy4i0s1Ug@mail.gmail.com>
Subject: Re: [RFC PATCH v2] driver core: add a debugfs entry to show deferred devices
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:33 PM, Javier Martinez Canillas
<javierm@redhat.com> wrote:
> For debugging purposes it may be useful to know what are the devices whose
> probe function was deferred. Add a debugfs entry showing that information.
>
>   $ cat /sys/kernel/debug/deferred_devices
>   48070000.i2c:twl@48:bci
>   musb-hdrc.0.auto
>   omapdrm.0

> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +#include <linux/debugfs.h>
> +
> +static struct dentry *deferred_devices;
> +
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
> +

> +static int deferred_devs_open(struct inode *inode, struct file *file)
> +{
> +       return single_open(file, deferred_devs_show, inode->i_private);
> +}
> +
> +static const struct file_operations deferred_devs_fops = {
> +       .owner = THIS_MODULE,
> +       .open = deferred_devs_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = single_release,
> +};

Isn't this DEFINE_SHOW_ATTRIBUTE() ?

> +#endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -233,6 +269,14 @@ void device_unblock_probing(void)
>   */
>  static int deferred_probe_initcall(void)
>  {
> +       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> +               deferred_devices = debugfs_create_file("deferred_devices",
> +                                                      0444, NULL, NULL,
> +                                                      &deferred_devs_fops);
> +               if (!deferred_devices)
> +                       return -ENOMEM;
> +       }
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
