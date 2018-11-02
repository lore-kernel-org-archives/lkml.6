Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633AFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D3F2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajill+0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D3F2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeKCD25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:28:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33492 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCD25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:28:57 -0400
Received: by mail-qk1-f196.google.com with SMTP id o89so4571927qko.0;
        Fri, 02 Nov 2018 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNLdfMluRo91wWWaAdKYR2GxKT7CoFra9G9QladbRqM=;
        b=Ajill+0S/+3jLNcZ8ETLwetJI7I0VAouaNVY4mmGXgZnV6KPQqrtY6VqdRPmjdlFnL
         6rqQyh3V3/SeEQdYm+eZm4Mdqv4Q4/LfkU6lqEfucd3kmrzx4/YmA58NdkAW0MWRukLk
         ZM6Cg76RCOWtGH9k3RFWzSI3ub9MkIsX2S8NG7Ebwo/2liKuhDBoWt2eKcUvxvYOAWqI
         e2wQrFK9pBGq9VkuQjFPzRlqgNrueT1KjwkwWSentQf1rFX+ggQeraLomGZaKBQW2n2u
         sx5ZK0f5IKuEW2Csq/5Z3H2n4+xdCrr8l0s7PMY5SfRTQnbcGh74jMGOpyGkhFXzu7gi
         tfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNLdfMluRo91wWWaAdKYR2GxKT7CoFra9G9QladbRqM=;
        b=X4uZDZI1zWRx/vwFwL5FassQu+EAOPShKU0mpslg44lDo5RO8k6C1YzXYcm8yAKAjK
         O1l/1XbGBASsq4qe0SlQbxj2rbyFCfGPR5eyICy3Zq51Ftxc0ZesrJnUCClxM/t6vUn2
         w/BSgqvXtJTKK/yVtBPkiQLmdYM0Rm4eQw55r38cZbXPAdNlLgN10+0AqZcO6+ziszL9
         9bXuMQZfmO3zUqm8VbN9IjnJOSthZg1lCqS/Wq+5BP4GX0rg6fD8N1Sa/N+bh45PXobW
         LBn/akgrAR+h+kuRVXVz24w5K+pkQcgbVUizLqK0Su+7TK7+xJN8nolwTb8+HGEaZHQZ
         P3ug==
X-Gm-Message-State: AGRZ1gJB0LVaGgi3pB8TXtBI350MtyjADsAsvU+xubCtEjS5UH3kRNG+
        SH4wz4GNSdceteyr5M6iii7BecGUmVSVl5xxueA=
X-Google-Smtp-Source: AJdET5c5AoUrpWtaGQj0UuHd5fxO+rV2jm2sCxTdwiOJS3RBKyujcETETcjxfGSC158CTnyZB7OHG/q8nV82ly0c6j4=
X-Received: by 2002:a0c:b3da:: with SMTP id b26mr20252qvf.138.1541182849351;
 Fri, 02 Nov 2018 11:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181102041120.7603-1-ayman.bagabas@gmail.com> <20181102041120.7603-2-ayman.bagabas@gmail.com>
In-Reply-To: <20181102041120.7603-2-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Nov 2018 20:20:37 +0200
Message-ID: <CAHp75Vds_RucAxD7ZHkRs8C32Y=UG3YQngGhZ28vvagVESTC_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86: add support for Huawei WMI hotkeys.
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kailang@realtek.com,
        Hui Wang <hui.wang@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 6:11 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> This driver adds support for missing hotkeys on some Huawei laptops.
> Currently, only Huawei Matebook X Pro is supported. The driver
> recognizes the following keys: brightness keys, micmute, wlan, and
> Huawei special key. The brightness keys are ignored since they work out
> of the box.

> +config HUAWEI_LAPTOP
> +       tristate "Huawei WMI hotkeys driver"
> +       depends on ACPI

> +       depends on ACPI_WMI


> +       depends on INPUT
> +       select INPUT_SPARSEKMAP
> +       help
> +         This driver provides support for Huawei WMI hotkeys.
> +         It enables the missing keys and adds support to micmute
> +         led found on these laptops.q
> +         Supported devices are:
> +         - Matebook X Pro


> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Huawei WMI Hotkeys Driver
> + *
> + *  Copyright (C) 2018           Ayman Bagabas <ayman.bagabas@gmail.com>
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
> + */

> +MODULE_LICENSE("GPL");


Here you have the following issues:
- inconsistency between IDs for license (fix accordingly)
- SDPX _and_ License header (remove latter)


> +#include <linux/kernel.h>

> +#include <linux/module.h>
> +#include <linux/init.h>

Choose one of them.

> +#include <linux/input.h>
> +#include <linux/input/sparse-keymap.h>
> +#include <linux/acpi.h>
> +#include <linux/wmi.h>

Please, keep in order.

> +static const struct key_entry huawei_wmi_keymap[] __initconst = {
> +               { KE_IGNORE, 0x281, { KEY_BRIGHTNESSDOWN } },
> +               { KE_IGNORE, 0x282, { KEY_BRIGHTNESSUP } },
> +               { KE_KEY,       0x287, { KEY_MICMUTE } },
> +               { KE_KEY,       0x289, { KEY_WLAN } },
> +               // Huawei |M| button
> +               { KE_KEY,       0x28a, { KEY_PROG1 } },
> +               { KE_END,       0 }
> +};
> +

> +struct huawei_wmi_device {
> +       struct input_dev *inputdev;
> +};

Apparently no need to have this, you may use struct input_dev
directly, isn't it?

> +static struct huawei_wmi_device *wmi_device;

No global variables, please.

> +int huawei_wmi_micmute_led_set(bool on)
> +{
> +       u32 args = (on) ? MICMUTE_LED_ON : MICMUTE_LED_OFF;

Redundant parens.

> +       struct acpi_buffer input = { (acpi_size)sizeof(args), &args };
> +       acpi_status status;
> +
> +       status = wmi_evaluate_method(AMW0_GUID, 0, 1, &input, NULL);
> +       if (ACPI_FAILURE(status))
> +               return status;
> +
> +       return 0;
> +}

> +static void huawei_wmi_process_key(struct input_dev *input_dev, int code)
> +{
> +       const struct key_entry *key;
> +

> +       key = sparse_keymap_entry_from_scancode(input_dev, code);
> +

This blank line is redundant.

> +       if (!key) {
> +               pr_info("%s: Unknown key pressed, code: 0x%04x\n",
> +                                       MODULE_NAME, code);

dev_info(); no MODULE_NAME, please.

> +               return;
> +       }
> +
> +       sparse_keymap_report_entry(input_dev, key, 1, true);
> +}

> +static void huawei_wmi_notify(u32 value, void *context)
> +{
> +       struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object *obj;
> +       acpi_status status;
> +
> +       status = wmi_get_event_data(value, &response);
> +       if (ACPI_FAILURE(status)) {

> +               pr_err("%s: Bad event status 0x%x\n",
> +                                       MODULE_NAME, status);

No MODULE_NAME, please.
If needed, use pr_fmt() macro.

But I'm pretty sure you may pass pointer to input device and use dev_err().

> +               return;
> +       }
> +

> +       obj = (union acpi_object *)response.pointer;
> +

No redundant blank lines, please.

> +       if (!obj)
> +               return;
> +
> +       if (obj->type == ACPI_TYPE_INTEGER)
> +               huawei_wmi_process_key(wmi_device->inputdev,
> +                                                       obj->integer.value);
> +       else

> +               pr_info("%s: Unknown response received %d\n",
> +                                       MODULE_NAME, obj->type);

Ditto about module name.

> +
> +       kfree(response.pointer);
> +}
> +
> +static int huawei_input_init(void)
> +{
> +       acpi_status status;
> +       int err;

> +       status = wmi_install_notify_handler(EVENT_GUID,
> +                       huawei_wmi_notify,

> +                       NULL);

Pointer to the input device instead of NULL.

> +

No redundant blank lines, please.

> +       if (ACPI_FAILURE(status)) {
> +               err = -EIO;
> +               goto err_free_dev;
> +       }

> +}


> +       wmi_device = kmalloc(sizeof(struct huawei_wmi_device), GFP_KERNEL);

sizeof(*wmi_device)

> +       if (!wmi_device)
> +               return -ENOMEM;

> +}


> +       pr_debug("%s: Driver unloaded successfully\n", MODULE_NAME);

Noise.

--
With Best Regards,
Andy Shevchenko
