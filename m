Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0717C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD2208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4geUWXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CD2208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeJPVd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:33:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36779 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeJPVd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:33:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id a85-v6so14111272qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ew/LKuRyPRsNQImcIzn1HrgKz5B1mML4J0IHGOGkhyY=;
        b=G4geUWXUmd2BhaBGuSEl26RJpQPn8MXJlcCVbqfRVU085dAdQ/EYkJiAJtqWm+ybjD
         7J89Zogcc1XAVwmFjiqqN0mPfVlur7UWkec/UDfZJavC0wWbDsRvw1vUVrTnpuXbGy9x
         8f3J2YXFfbYkOSz4+jHEKu0n5onmT4+xy9EUE9UoAJv/W58b4QJP2fEz1LdDMjTOp+Xb
         bWjLTXVFacoXPfovXUiZvEfnd9pAOJKd3q1ZYCMpXYTtAi4Uuoc64SVVQwqDNYdSv3ay
         gXriRL9roLH05qDJlBjy6ChT4L8kB9dE05knN09gjqGaHEGdS8CbryDiaoNFLLYb167b
         IVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ew/LKuRyPRsNQImcIzn1HrgKz5B1mML4J0IHGOGkhyY=;
        b=X2NrRvmqay1evjHbFyJaW2GvS0yMJmUeldAkAWmgCmu9DC4IpSHVXqrTJ7iMo+Gh3b
         2fMcYp0+BuQloo42wFANZqaFD9hIJ6Fz76TWeDmfPzQbnwlHK4S91wcugXmVjyM/EdOt
         EqbkvSbDMeE28gg4K45HhqQ6FnU42JJx6TRyqulqg/9zS9RSbHiRdIIueQk4GUir7FN2
         8L5OWFEyUS/hk6D2lx+N/Y/MGLgFZUlrVrRxhPb+ypjfw/6GJZTFgxt4EM09vRH0d1/m
         Lz35y2f+DJshPUmcmxapi6Txb5GqOax4T4sCxb3433w0C3wlqu4e0QOcdPn7B/zR/APf
         nQZA==
X-Gm-Message-State: ABuFfogqVkRM7iebPJDE503V2WSxQpwVQ+vywJx6ccffVAfZlTmiV301
        +xOEPsPmOkWECPatnLWnnqMGJOFOie8fTH0MfNN42hQbc5U=
X-Google-Smtp-Source: ACcGV63c11UiYZT8V6eX+Di8q7cU12BsMspI9o9q9HAgPaSL48LNagsaRZjqExNDqyow7tmimu6rpqDIZtKXWHGAqY8=
X-Received: by 2002:ae9:f40b:: with SMTP id y11-v6mr20915015qkl.137.1539697373775;
 Tue, 16 Oct 2018 06:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016072249eucas1p28855602564eb74a771fe521712962680@eucas1p2.samsung.com>
 <20181016072244.1216-1-a.hajda@samsung.com> <20181016072244.1216-3-a.hajda@samsung.com>
In-Reply-To: <20181016072244.1216-3-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Oct 2018 16:42:41 +0300
Message-ID: <CAHp75VefP2qit3=s9E_uuOg4+J0Zk2OD-XjpVsWM7X3s2g-0wA@mail.gmail.com>
Subject: Re: [PATCH 2/3] driver core: add deferring probe reason to
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

On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.


> -       if (err != -EPROBE_DEFER) {
> -               va_start(args, fmt);
> +       va_start(args, fmt);
>
> -               vaf.fmt = fmt;
> -               vaf.va = &args;
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
>
> +       if (err != -EPROBE_DEFER)
>                 __dev_printk(KERN_ERR, dev, &vaf);
> -               va_end(args);
> -       }
> +       else
> +               __deferred_probe_set_msg(dev, fmt, args);
> +
> +       va_end(args);

Yeah, ping-pong style of programming (one patch "amends" something
which had been introduced by another).
That's why better to follow my comment for the patch 1.

> +/*
> + * __deferred_probe_set_msg() - Set defer probe reason message for device
> + */
> +void __deferred_probe_set_msg(const struct device *dev, const char *fmt,
> +                                    va_list args)
> +{
> +       const int size = 128;
> +       char **p;
> +       int n;
> +
> +       mutex_lock(&deferred_probe_mutex);
> +


> +       p = &dev->p->deferred_probe_msg;
> +       if (!*p) {
> +               *p = kmalloc(size, GFP_KERNEL);
> +               if (!*p)
> +                       goto end;
> +       }
> +       n = snprintf(*p, size, "%s %s: ", dev_driver_string(dev), dev_name(dev));
> +       if (n < size)
> +               vsnprintf(*p + n, size - n, fmt, args);

Perhaps kasprintf() instead of this huge plays around the size and allocation?

>         list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> -               seq_printf(s, "%s\n", dev_name(curr->device));
> +               if (curr->device->p->deferred_probe_msg)
> +                       seq_puts(s, curr->device->p->deferred_probe_msg);
> +               else
> +                       seq_printf(s, "%s\n", dev_name(curr->device));

I wouldn't care (much) about debugfs, though better to keep some order
here, i.e. always print device name.

Something like

seq_printf(s, "%s\t%s\n", dev_name(), deferred_probe_msg ?: "");

and remove that part from above __deferred_probe_set_msg().

-- 
With Best Regards,
Andy Shevchenko
