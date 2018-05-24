Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965345AbeEXIUC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:20:02 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34507 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935631AbeEXIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:19:57 -0400
X-Google-Smtp-Source: AB8JxZq22rmwqSBPpFuqX1UlfATiW3k3QNNq4iQOOQeiSysiOuA33q2BoyKCe00MZI62lQlxGXc1+KHiT19mrklIGOw=
MIME-Version: 1.0
In-Reply-To: <20180522204753.GA260493@dtor-ws>
References: <20180522204753.GA260493@dtor-ws>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 10:19:55 +0200
Message-ID: <CACRpkdabMV1Vy5dGjW-eRVxY9yAcVhukMY1RNnb7nbYc7keHGw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: cherryview: limit Strago DMI workarounds to
 version 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 10:47 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> As Google/Intel will fix the BIOS/Coreboot issues with hardcoding
> virtual interrupt numbers for keyboard/touchpad/touchscreen controllers
> in ACPI tables, they will also update BOARD version number from 1.0
> to 1.1. Let's limit the DMI quirks that try to preserve virtual IRQ
> numbers on Strago boards to those that still carry older BIOSes.
>
> Note that ideally not BOARD but BIOS version should have been updated.
> However the BIOS version used by Chrome devices has format of
> Google_BUILD.BRANCH.PATCH which is not well suited for DMI matching as
> we do not have "less than" match mode for DMI data.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> v1->v2:
>
> - switch from matching on DMI_BIOS_VERSION to DMI_BOARD_VERSION

Patch applied for fixes.

Should this also be tagged for stable?

Yours,
Linus Walleij
