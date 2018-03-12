Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeCLN6G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:58:06 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:41801 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:58:03 -0400
X-Google-Smtp-Source: AG47ELtX+968THku2gCrUJ0SOOTE9HMGJ4fs4k1FNYwbxpv0H3i8+47FUxfD1GBu42y+Blj/OH9JE8jy4O1lXMgfwvU=
MIME-Version: 1.0
In-Reply-To: <1520591651-4565-1-git-send-email-phil.edworthy@renesas.com>
References: <1520591651-4565-1-git-send-email-phil.edworthy@renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Mar 2018 15:58:02 +0200
Message-ID: <CAHp75VcxH=UQoc5oMjTMHZvCqmYths5LPTVVzY-ntC+r3ivguQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Add support for a bus clock
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 12:34 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> From: Michel Pollet <michel.pollet@bp.renesas.com>
>
> Enable specified clocks from DTS, if any.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

>  #include <linux/spinlock.h>
>  #include <linux/platform_data/gpio-dwapb.h>
>  #include <linux/slab.h>
> +#include <linux/clk.h>

Keep in order.


> +       clk = devm_clk_get(&pdev->dev, NULL);
> +       if (!IS_ERR(clk) && clk_prepare_enable(clk))
> +               dev_info(&pdev->dev, "no clock source\n");

First of all, it shadows any error from clk_prepare_enable(), second,
it misses the clock name.
Next, I don't see how you managed the clock during PM and / or
->remove() operation.

-- 
With Best Regards,
Andy Shevchenko
