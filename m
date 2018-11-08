Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B8FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5800B20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA26e/b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5800B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeKIFf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:35:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47062 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeKIFf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:35:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id q1so28652053qkf.13;
        Thu, 08 Nov 2018 11:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GIPJrd7cXwt76+SVYunAjADxbhCS7WmzGfSgtT5rUA=;
        b=XA26e/b/K4BvYBhY9jFa3fcvftXIKLfMU3jZKh+BWAMyuIlX/WDyeqTUPvR9wh2Jne
         MdXVqzaXgiKQdYw9eAtY0AXJ25g5HERAXXeqXQ9sQr3EUsn4CZUfA0SpqUgzFcFuIjG8
         nT4ha+gQdgHDuw3z0+4up0wu4s5lU4igojPUcnY3P57fcoflIBqbzyRkgph93fd67nyy
         nQ0T34wFpLxXvkJ6Vlb1avqA5vSYabWpzuzizN2hG/1TWo94VWqLCYALuFbQocoo1n+N
         Tj5UqDIDsCZ4cJGJdK5sIUrNplYT7cejC2bPUmYeSk8ho/bZDgfixTFqYQ+P4AxLehnd
         42jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GIPJrd7cXwt76+SVYunAjADxbhCS7WmzGfSgtT5rUA=;
        b=lj9wEbs23gjuKcMA5JOXmeCVVePMOkD0fmZ2ubw0m2NkVtYC1CCFrHIw7FHSTyX2Lb
         qS1kN7zVzq/jHaLPP+Gh59QO2HOGQR52mV2M8PsfiW2DyOfH+ANbBNZKZr+mBgp3C9Yy
         ymnxTZeQbjVTpjFzFHtMQj0iW+zNUhogq9aCE/KNxwdI7Ved5F4i1qPPD/E9YlhJhAsr
         +XzrQvcP4w9mRKrXZdCkfhE5gY/HaMo+3nOfWNzapPy/NiSxqCR4A9jbF2ZTFmNNM2+E
         og9bz5npgBSp8d2VEr9WDPnJylVbDQy3kjBM57JUX0eJ/uDzqUxGMmvGM/meAotSbRbA
         Gm0g==
X-Gm-Message-State: AGRZ1gLfCR39iuVRf7f47dgGdYHgY5SxyDz6VqINhAm1PZqFCezB0yuJ
        j1RTBQMDzM49LkDwn4gMlP/nOhQUgRXAQahw8q4=
X-Google-Smtp-Source: AJdET5eaThrVsJZMuuNlBl0sojaModBwdgDTUeOswtdi60T1ZbGrzvvsViMczG0YTe+IsjCXkPuyr+3sCRJf2QAX9NE=
X-Received: by 2002:a37:4792:: with SMTP id u140mr5815414qka.301.1541707135426;
 Thu, 08 Nov 2018 11:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20181108171701.4444-1-ayman.bagabas@gmail.com> <20181108171701.4444-2-ayman.bagabas@gmail.com>
In-Reply-To: <20181108171701.4444-2-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Nov 2018 21:58:44 +0200
Message-ID: <CAHp75Vev_0ObO=KLHfON8JAco=a9MURycH9uk-a+h1JqrSSQFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] x86: add support for Huawei WMI hotkeys.
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 7:17 PM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This driver adds support for missing hotkeys on some Huawei laptops.
> Currently, only Huawei Matebook X and Matebook X Pro is supported.
>

Thanks for an update, my comments below.


> +config HUAWEI_LAPTOP
> +       tristate "Huawei WMI hotkeys driver"

> +       depends on ACPI

Do you need an ACPI dependency be explicit here?

> +       depends on ACPI_WMI
> +       depends on INPUT
> +       select INPUT_SPARSEKMAP
> +       help
> +         This driver provides support for Huawei WMI hotkeys.
> +         It enables the missing keys and adds support to the micmute
> +         LED found on some of these laptops.


> +/*
> + *  Huawei WMI hotkeys
> + *
> + *  Copyright (C) 2018       Ayman Bagabas <ayman.bagabas@gmail.com>

> + *
> + *  This program is free software: you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation, either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
> + *

Please, replace this boilerplate text with appropriate SPDX identifier.

> + */

> +#include <linux/init.h>
> +#include <linux/module.h>

One of them should be chosen.

> +static char *event_guid;
> +static struct input_dev *inputdev;

> +int huawei_wmi_micmute_led_set(bool on)
> +{
> +       acpi_handle handle = ACPI_HANDLE(&inputdev->dev);
> +       char *method;
> +       union acpi_object args[3];

> +       args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
> +       args[1].integer.value = 0x04;

Please, don't mix definitions and code.

> +       struct acpi_object_list arg_list = {
> +               .pointer = args,
> +               .count = ARRAY_SIZE(args),
> +       };
> +
> +       if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.SPIN")) {
> +               args[0].integer.value = 0;
> +               args[2].integer.value = on ? 1 : 0;
> +       } else if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.WPIN")) {
> +               args[0].integer.value = 1;
> +               args[2].integer.value = on ? 0 : 1;
> +       } else {
> +               pr_err("Unable to find ACPI method\n");

dev_err() here.

> +               return -1;

Return appropriate error code.

> +       }
> +
> +       acpi_evaluate_object(handle, method, &arg_list, NULL);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(huawei_wmi_micmute_led_set);
> +
> +static void huawei_wmi_process_key(struct input_dev *inputdev, int code)
> +{

> +               acpi_status status;
> +               unsigned long long result;
> +               const char *method = "\\WMI0.WQ00";
> +               union acpi_object args[] = {
> +                               { .type = ACPI_TYPE_INTEGER  },
> +               };

> +               args[0].integer.value = 0;

Don't mix definitions and code.

> +               struct acpi_object_list arg_list = {
> +                       .pointer = args,
> +                       .count = ARRAY_SIZE(args),
> +               };

> +       if ((key->sw.code == KEY_BRIGHTNESSUP
> +                       || key->sw.code == KEY_BRIGHTNESSDOWN)

I believe this can fit one line.

> +                       && strcmp(event_guid, MBXP_EVENT_GUID) == 0)
> +               return;
> +
> +       sparse_keymap_report_entry(inputdev, key, 1, true);
> +}

> +static int __init huawei_wmi_init(void)
> +{
> +       int err;
> +
> +       if (wmi_has_guid(MBX_EVENT_GUID)) {
> +               event_guid = MBX_EVENT_GUID;
> +       } else if (wmi_has_guid(MBXP_EVENT_GUID)) {
> +               event_guid = MBXP_EVENT_GUID;
> +       } else {

> +               pr_warn("No known WMI GUID found\n");

Simple "Compatible WMI GUID not found\n".

> +               return -ENODEV;
> +       }
> +

> +       err = huawei_wmi_input_init();
> +       if (err) {

> +               pr_err("Failed to setup input device\n");

Noise.

> +               return err;
> +       }
> +
> +       return 0;

...just do

return huawei_wmi_input_init();

> +}

-- 
With Best Regards,
Andy Shevchenko
