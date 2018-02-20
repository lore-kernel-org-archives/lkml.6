Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeBTRek (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:34:40 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43601 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbeBTRej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:34:39 -0500
X-Google-Smtp-Source: AH8x2254mVV1WFRkIENLEl+wvVETP9W+/NbYoA7HMSykt8xVUB4Lh2JDiKebSFZ2GacE7hVTzMH3Uuz1V/DrnIZ+3LE=
MIME-Version: 1.0
In-Reply-To: <20180220150318.138827-1-delroth@google.com>
References: <20180220150318.138827-1-delroth@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2018 19:34:37 +0200
Message-ID: <CAHp75Vck_8G=zTD4ftYC7yd+q_6XiXWvs+kX_zqr6bUtMUf4wg@mail.gmail.com>
Subject: Re: [PATCH] max17042: propagate of_node to power supply device
To: Pierre Bourdon <delroth@google.com>
Cc: Andre Heider <a.heider@gmail.com>, Sebastian Reichel <sre@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 5:03 PM, Pierre Bourdon <delroth@google.com> wrote:
> max17042_get_status uses the core power_supply_am_i_supplied. That
> function relies on DT properties to figure out the power supply
> topology, and will error out without DT.

> +       psy_cfg.of_node = dev->of_node;

Perhaps do this in general manner, see how GPIOLIB takes care of it:

$ git grep -n -A4 -w CONFIG_OF_GPIO -- drivers/gpio/gpiolib.c
drivers/gpio/gpiolib.c:1161:#ifdef CONFIG_OF_GPIO
drivers/gpio/gpiolib.c-1162-    /* If the gpiochip has an assigned OF
node this takes precedence */
drivers/gpio/gpiolib.c-1163-    if (chip->of_node)
drivers/gpio/gpiolib.c-1164-            gdev->dev.of_node = chip->of_node;
drivers/gpio/gpiolib.c-1165-#endif
...

-- 
With Best Regards,
Andy Shevchenko
