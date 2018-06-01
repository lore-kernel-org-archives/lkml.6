Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeFAPKd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:10:33 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43850 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752764AbeFAPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:10:28 -0400
X-Google-Smtp-Source: ADUXVKIFMCu7ANs5RGNmQWr6N8AKUHe3hYLrH9iEFS0u0cezR67WPXUPKQXG8HA7u4FwSIkZUmh8TrB0v3fJz7COmgU=
MIME-Version: 1.0
In-Reply-To: <CAHp75VcP=RBpfqN1c0M4Uy639t80sCQ+YidweFmRZSt0J5i37g@mail.gmail.com>
References: <20180530214938.1073749-1-arnd@arndb.de> <CAHp75VcP=RBpfqN1c0M4Uy639t80sCQ+YidweFmRZSt0J5i37g@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 1 Jun 2018 17:10:26 +0200
X-Google-Sender-Auth: 7M5N3LiG69sYZq5WBzBA16jmDRI
Message-ID: <CAK8P3a1O=pbmeNxWNmU9UHjnBVwJXUjTuxRudTZ3OHBdbiVv9A@mail.gmail.com>
Subject: Re: [PATCH] fb_omap: add gpiolib dependency
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-fbdev@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 8:04 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, May 31, 2018 at 12:49 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c: In function 'hdmi_probe_of':
>> drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c:584:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
>> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c: In function 'hdmi_probe_of':
>> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:554:2: error: implicit declaration of function 'of_node_put'; did you mean 'node_set'? [-Werror=implicit-function-declaration]
>
>> Rather than fixing up each one individually, this just marks all of it
>> as depending on GPIOLIB.
>
> Hmm... But the OF stuff is not part of GPIOLIB.

The underlying issue is the same though: linux/gpio.h includes a
different set of header files
depending on CONFIG_GPIOLIB being set or not. Without it, we are missing all the
indirect includes from asm-generic/gpio.h that include linux/of.h and
linux/gpio/consumer.h.

        Arnd
