Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeCUT7J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:59:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37819 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbeCUT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:59:06 -0400
X-Google-Smtp-Source: AG47ELvdPhdLTcg8bsxCxyEgziUMpnXIF7rMREXWZ3aBBqA0TVPpNG9Hq/+zZhJ7oBhVE1whCC45rg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1521655150.23017.79.camel@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-3-swboyd@chromium.org>
 <1521655150.23017.79.camel@linux.intel.com>
Message-ID: <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/3] gpiolib: Support 'gpio-reserved-ranges' property
Date: Wed, 21 Mar 2018 12:59:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2LJxx0E028995

Quoting Andy Shevchenko (2018-03-21 10:59:10)
> On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> > From: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > Some qcom platforms make some GPIOs or pins unavailable for use by
> > non-secure operating systems, and thus reading or writing the
> > registers
> > for those pins will cause access control issues. Add support for a DT
> > property to describe the set of GPIOs that are available for use so
> > that
> > higher level OSes are able to know what pins to avoid reading/writing.
> > Non-DT platforms can add support by directly updating the
> > chip->valid_mask.
> 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> 
> Hmm...

Don't look closely! :P

> 
> > +     gpiochip->valid_mask = kcalloc(BITS_TO_LONGS(gpiochip-
> > >ngpio),
> > +                                    sizeof(long), GFP_KERNEL);
> 
> Just noticed that kcalloc is superfluous here.
> kmalloc_array() would be enough.
> 

Ok. I was copying the irqchip style. Should I fold them together into a
helper function and also update to kmalloc_array?
