Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbeCUUbW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:31:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:53283 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753021AbeCUUbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:31:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="210238097"
Message-ID: <1521664274.23017.92.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/3] gpiolib: Support 'gpio-reserved-ranges' property
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Timur Tabi <timur@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date: Wed, 21 Mar 2018 22:31:14 +0200
In-Reply-To: <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
         <20180321165848.89751-3-swboyd@chromium.org>
         <1521655150.23017.79.camel@linux.intel.com>
         <152166234504.91116.14942145962035607739@swboyd.mtv.corp.google.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 12:59 -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2018-03-21 10:59:10)
> > On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> > > 

> > 
> > > +     gpiochip->valid_mask = kcalloc(BITS_TO_LONGS(gpiochip-
> > > > ngpio),
> > > 
> > > +                                    sizeof(long), GFP_KERNEL);
> > 
> > Just noticed that kcalloc is superfluous here.
> > kmalloc_array() would be enough.
> > 
> 
> Ok. I was copying the irqchip style. Should I fold them together into
> a
> helper function and also update to kmalloc_array?

Not sure about first part, but definitely makes sense the second one (as
a separate patch perhaps).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
