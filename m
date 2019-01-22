Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE78C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B81321019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548171053;
	bh=+ze9XkHIdknVov2ncto1OAcGgPMRE1R5ksGVJ4Dzoto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x3KsXxif6bSeq5YS6ntEWTYKTalOvknY7+li38mXP6w7DDk5m9aKg+FEjYcoiEVf5
	 qFLrTEciStKwAnYSttWdPu5e/4vJ/9QcP77eGTtc418xk9dH6HivxCMWCUFK9CGK2O
	 r2qmRJeH9n4tVxdGPTPK5bX3adcWxdHbBJgq42h4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfAVPav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:30:51 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36799 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbfAVPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:30:51 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so17716078oix.3;
        Tue, 22 Jan 2019 07:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0oZbCOd/mtM48E/UJZ5LN56e4E+XswQVYFwXTP3224=;
        b=mdekVGC3Asaf0d1swzmItotlw6zx3t3sp4qb3nu1rPHBiN/QFfTwiXoXzBtcuFJ8sX
         fS1mxVnHySBm58gr3N39GROB9u02uYasNraLVMA4Dg68UTzAjuW56VV7O+rcewaiMbrS
         9J9JQt5VLRQPN4Jvp8xL5ruguzxXYuwvBWr6aWdbshqxzL5wm8K9XouKvWKDnypazm5H
         4HXJZ/ZOfe/HwKn8pVkiyfF5CpppzAhelOZdLX+M3Br2iqum/e1lzanJMy4s1bK/CyC7
         yuY/upyEKXh2n97EHJUuGaJn5A22YW1WIqfKxRkkt+5vp979xmZ+L2FvJ0DtcS/9WUxG
         ubCg==
X-Gm-Message-State: AJcUukfvBbMCH4bSpiGMW/YorcG/wG3hbR5lgVXFyNJFfrAt+3iCF059
        dWs/5rN7wispq6I0GqWkrNDdLW7HQJQH2mCYchU=
X-Google-Smtp-Source: ALg8bN71MJPNQKjQ9XzsE5MbE8JlDkzZjOdBaKFYvXcjAHN2sd7o45ZAdchnvW5z/MlWx75tG2udVMZPWM0CFxKQMhc=
X-Received: by 2002:aca:e715:: with SMTP id e21mr8788729oih.76.1548171050254;
 Tue, 22 Jan 2019 07:30:50 -0800 (PST)
MIME-Version: 1.0
References: <20190122152151.16139-48-gregkh@linuxfoundation.org>
In-Reply-To: <20190122152151.16139-48-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 16:30:38 +0100
Message-ID: <CAJZ5v0jLeZfsmX12g6r0zXCt9dTjD0TnJ03+Sntt6i2f-PxsGw@mail.gmail.com>
Subject: Re: [PATCH] power: qos: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:25 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

All of these changes are fine by me and I can take the patches
touching the code maintained by me, so please let me know.

> ---
>  kernel/power/qos.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index b7a82502857a..9d22131afc1e 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -582,10 +582,8 @@ static int register_pm_qos_misc(struct pm_qos_object *qos, struct dentry *d)
>         qos->pm_qos_power_miscdev.name = qos->name;
>         qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
>
> -       if (d) {
> -               (void)debugfs_create_file(qos->name, S_IRUGO, d,
> -                                         (void *)qos, &pm_qos_debug_fops);
> -       }
> +       debugfs_create_file(qos->name, S_IRUGO, d, (void *)qos,
> +                           &pm_qos_debug_fops);
>
>         return misc_register(&qos->pm_qos_power_miscdev);
>  }
> @@ -685,8 +683,6 @@ static int __init pm_qos_power_init(void)
>         BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
>
>         d = debugfs_create_dir("pm_qos", NULL);
> -       if (IS_ERR_OR_NULL(d))
> -               d = NULL;
>
>         for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
>                 ret = register_pm_qos_misc(pm_qos_array[i], d);
> --
> 2.20.1
>
