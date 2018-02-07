Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753964AbeBGNeW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:34:22 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:38927 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753721AbeBGNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:34:20 -0500
X-Google-Smtp-Source: AH8x227CnbEf5MQp6AdRHZqIc0Q1Pc3ntAnEpm+mp1znHiQvBovmIgdzl0dg+0f5O8uXrezjLCZrUCdDuMsrt9UVStk=
MIME-Version: 1.0
In-Reply-To: <20180126011400.2191-3-sboyd@codeaurora.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org> <20180126011400.2191-3-sboyd@codeaurora.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 14:34:19 +0100
Message-ID: <CACRpkda2_nt24pweyQTtB_9gypDJTK1NHRm1LjsinEaK-G8F_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpiolib-of: Support 'reserved-gpio-ranges' property
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Timur Tabi <timur@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

nice work!

On Fri, Jan 26, 2018 at 2:13 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> For now, we plumb this into the gpiochip irq APIs so that
> GPIO/pinctrl drivers can use the gpiochip_irqchip_irq_valid() to
> test validity of GPIOs.

But is that the right thing to do, given that we just took the
trouble to define a DT binding that is explicitly about
any GPIO, not just IRQ capable ones?

I am worries that the *irq* infix etc on these functions
will be a bit confusing.

Is it a lot of work to make it just generic and maybe bake it
into the gpio_chip so as to refuse already in
gpiod_request_commit() in gpiolib already?

Yours,
Linus Walleij
