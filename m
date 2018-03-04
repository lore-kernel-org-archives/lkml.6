Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeCDRbT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 12:31:19 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:35065 "EHLO
        1.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbeCDRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 12:31:18 -0500
Message-ID: <1520182292.14077.2.camel@florentflament.com>
Subject: Re: [PATCH] HID: Logitech K290: Add driver for the Logitech K290
 USB keyboard
From: Florent Flament <contact@florentflament.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Date: Sun, 04 Mar 2018 17:51:32 +0100
In-Reply-To: <CAHp75VeLaXb+wOUJOXojOwXSm68=oaiA7=RCKH_tOsBT7OzUxg@mail.gmail.com>
References: <20180302220425.27707-1-contact@florentflament.com>
         <CAHp75VeLaXb+wOUJOXojOwXSm68=oaiA7=RCKH_tOsBT7OzUxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2601110263949785759
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrjeehgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-03 at 18:08 +0200, Andy Shevchenko wrote:
> On Sat, Mar 3, 2018 at 12:04 AM, Florent Flament
> <contact@florentflament.com> wrote:
> > With the generic HID driver, K290 keyboards' F1 to F12 keys send
> > multimedia events by default, and standard keycodes when the
> > function
> > key is pressed. This driver allows to configure K290 keyboards, so
> > that F1 to F12 have a standard behavior and send multimedia events
> > when the function key is pressed. The keyboard mode is set through
> > the
> > fn_mode module parameter: when set to 1 (default setting) the
> > keyboard
> > behaves as with the generic HID driver, when set to 0 the keyboard
> > is
> > configured to work as standard keyboards.
> 
> SPDX ID?
> 
> > +/*
> > + * HID driver for Logitech K290 keyboard
> > + *
> > + * Copyright (c) 2018 Florent Flament
> > + *
> > + * This drivers allows to configure the K290 keyboard's function
> > key
> > + * behaviour (whether function mode is activated or not by
> > default).
> > + *
> > + * Logitech custom commands taken from Marcus Ilgner k290-fnkeyctl
> > + * (https://github.com/milgner/k290-fnkeyctl):
> > + * K290_SET_FUNCTION_CMD
> > + * K290_SET_FUNCTION_VAL
> > + * K290_SET_FUNCTION_OFF
> > + * K290_SET_FUNCTION_ON
> > + *
> > + * Based on hid-accutouch.c and hid-elo.c
> > + *
> > + * This driver is licensed under the terms of GPLv2.
> 
> ...instead of this.

Fine, I'll replace this with the appropriate SPDX ID.

> 
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/hid.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/mod_devicetable.h>
> 
> Do you need these both? I suppose module.h effectively provides them.

Indeed, module.h is enough. The 2 following includes are not necessary.
Fixing this.

> 
> > +#include <linux/stat.h>
> > +#include <linux/types.h>
> > +#include <linux/usb.h>
> 
> 

Regards,
Florent
