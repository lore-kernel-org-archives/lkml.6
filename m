Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032985AbeCAQjL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:39:11 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34075 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033046AbeCAQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:39:09 -0500
X-Google-Smtp-Source: AG47ELu4E0A6qVX3XvQ0nX4SpXdUeGUZkPC7h0k1M8q0yUjdyABvVdH0xtUwTSuKGdLku645l+HgcKCSoeJjMzHkFJQ=
MIME-Version: 1.0
In-Reply-To: <77b9d62ee2600bb01c08c618e67b63c8aaa35f49.1519920316.git.joe@perches.com>
References: <77b9d62ee2600bb01c08c618e67b63c8aaa35f49.1519920316.git.joe@perches.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 18:39:07 +0200
Message-ID: <CAHp75Ve6H9Ra4zm-EA6+1rHenoOkQJi9d=OJ+0B64HjxLkPBvQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: Fix misuse of vsprintf extension %pULL
To: Joe Perches <joe@perches.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 6:08 PM, Joe Perches <joe@perches.com> wrote:
> %pULL doesn't officially exist but %pUL does.
>
> Miscellanea:
>
> o Add missing newlines to a couple logging messages

Darren, are you agree on the change?

To me it seems fine.

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/platform/x86/wmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index f90ba83359f5..8e3d0146ff8c 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -936,7 +936,7 @@ static int wmi_dev_probe(struct device *dev)
>                 wblock->char_dev.mode = 0444;
>                 ret = misc_register(&wblock->char_dev);
>                 if (ret) {
> -                       dev_warn(dev, "failed to register char dev: %d", ret);
> +                       dev_warn(dev, "failed to register char dev: %d\n", ret);
>                         ret = -ENOMEM;
>                         goto probe_misc_failure;
>                 }
> @@ -1039,7 +1039,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
>
>         if (result) {
>                 dev_warn(wmi_bus_dev,
> -                        "%s data block query control method not found",
> +                        "%s data block query control method not found\n",
>                          method);
>                 return result;
>         }
> @@ -1189,7 +1189,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
>
>                 retval = device_add(&wblock->dev.dev);
>                 if (retval) {
> -                       dev_err(wmi_bus_dev, "failed to register %pULL\n",
> +                       dev_err(wmi_bus_dev, "failed to register %pUL\n",
>                                 wblock->gblock.guid);
>                         if (debug_event)
>                                 wmi_method_enable(wblock, 0);
> --
> 2.15.0
>



-- 
With Best Regards,
Andy Shevchenko
