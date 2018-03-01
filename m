Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162315AbeCAVuE convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162201AbeCAVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:49:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5888B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Linus Walleij <linus.walleij@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CACRpkda2_nt24pweyQTtB_9gypDJTK1NHRm1LjsinEaK-G8F_Q@mail.gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-3-sboyd@codeaurora.org>
 <CACRpkda2_nt24pweyQTtB_9gypDJTK1NHRm1LjsinEaK-G8F_Q@mail.gmail.com>
Message-ID: <151994099669.240031.102662015980326125@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] gpiolib-of: Support 'reserved-gpio-ranges' property
Date: Thu, 01 Mar 2018 13:49:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Walleij (2018-02-07 05:34:19)
> Hi Stephen,
> 
> nice work!
> 
> On Fri, Jan 26, 2018 at 2:13 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > For now, we plumb this into the gpiochip irq APIs so that
> > GPIO/pinctrl drivers can use the gpiochip_irqchip_irq_valid() to
> > test validity of GPIOs.
> 
> But is that the right thing to do, given that we just took the
> trouble to define a DT binding that is explicitly about
> any GPIO, not just IRQ capable ones?
> 
> I am worries that the *irq* infix etc on these functions
> will be a bit confusing.
> 
> Is it a lot of work to make it just generic and maybe bake it
> into the gpio_chip so as to refuse already in
> gpiod_request_commit() in gpiolib already?

I don't think that it will be too much work to tweak the code to treat
these as gpios instead of irq lines. It may end up duplicating a bit of code
that the irq line stuff is already doing, but I'll take a stab at it and
see how bad it comes out.
