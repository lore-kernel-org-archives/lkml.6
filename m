Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932103AbeCCQIe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 11:08:34 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36358 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCCQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 11:08:32 -0500
X-Google-Smtp-Source: AG47ELttuZvDzcFHfHtJa3T02GfJALAw4iwrNB1It2F9dpgf5dYH4yDPTOCYc/XEeLpGcTb5C47eBHRUyVM7qXxdA/M=
MIME-Version: 1.0
In-Reply-To: <20180302220425.27707-1-contact@florentflament.com>
References: <20180302220425.27707-1-contact@florentflament.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Mar 2018 18:08:30 +0200
Message-ID: <CAHp75VeLaXb+wOUJOXojOwXSm68=oaiA7=RCKH_tOsBT7OzUxg@mail.gmail.com>
Subject: Re: [PATCH] HID: Logitech K290: Add driver for the Logitech K290 USB keyboard
To: Florent Flament <contact@florentflament.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 3, 2018 at 12:04 AM, Florent Flament
<contact@florentflament.com> wrote:
> With the generic HID driver, K290 keyboards' F1 to F12 keys send
> multimedia events by default, and standard keycodes when the function
> key is pressed. This driver allows to configure K290 keyboards, so
> that F1 to F12 have a standard behavior and send multimedia events
> when the function key is pressed. The keyboard mode is set through the
> fn_mode module parameter: when set to 1 (default setting) the keyboard
> behaves as with the generic HID driver, when set to 0 the keyboard is
> configured to work as standard keyboards.

SPDX ID?

> +/*
> + * HID driver for Logitech K290 keyboard
> + *
> + * Copyright (c) 2018 Florent Flament
> + *
> + * This drivers allows to configure the K290 keyboard's function key
> + * behaviour (whether function mode is activated or not by default).
> + *
> + * Logitech custom commands taken from Marcus Ilgner k290-fnkeyctl
> + * (https://github.com/milgner/k290-fnkeyctl):
> + * K290_SET_FUNCTION_CMD
> + * K290_SET_FUNCTION_VAL
> + * K290_SET_FUNCTION_OFF
> + * K290_SET_FUNCTION_ON
> + *
> + * Based on hid-accutouch.c and hid-elo.c
> + *

> + * This driver is licensed under the terms of GPLv2.

...instead of this.

> + */

> +
> +#include <linux/device.h>
> +#include <linux/hid.h>
> +#include <linux/module.h>

> +#include <linux/moduleparam.h>
> +#include <linux/mod_devicetable.h>

Do you need these both? I suppose module.h effectively provides them.

> +#include <linux/stat.h>
> +#include <linux/types.h>
> +#include <linux/usb.h>

-- 
With Best Regards,
Andy Shevchenko
