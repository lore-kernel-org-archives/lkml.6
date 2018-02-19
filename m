Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeBSNgc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:36:32 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37365 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeBSNga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:36:30 -0500
X-Google-Smtp-Source: AH8x22605O6YYgFbTBK24oNS0G5ZH4kNVfGO+QGX/KF9+fHWAgFyU2zuCXp0nPzXwAPmyP8uJNty59M0ZDABLjgQeP0=
MIME-Version: 1.0
In-Reply-To: <20180219133038.21995-1-ckeepax@opensource.cirrus.com>
References: <20180219133038.21995-1-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 15:36:29 +0200
Message-ID: <CAHp75Vc6ok2s0fiQi9ePgmf4BVyO5N125B6iE1jnqWmgWF01Ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mfd: arizona: Update reset pin to use GPIOD
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 3:30 PM, Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> Now GPIOD has support for both pdata systems and for non-standard DT
> bindings the Arizona reset GPIO can be converted to use it.

>  static inline void arizona_enable_reset(struct arizona *arizona)
>  {
> -       if (arizona->pdata.reset)
> -               gpio_set_value_cansleep(arizona->pdata.reset, 0);
> +       gpiod_set_value_cansleep(arizona->pdata.reset, 0);
>  }

Did you try that code when !GPIOLIB ?

Or driver depends on it?

-- 
With Best Regards,
Andy Shevchenko
