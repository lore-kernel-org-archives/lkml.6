Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeCUR7P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:59:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:63363 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbeCUR7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:59:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="30043316"
Message-ID: <1521655150.23017.79.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/3] gpiolib: Support 'gpio-reserved-ranges' property
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
Date: Wed, 21 Mar 2018 19:59:10 +0200
In-Reply-To: <20180321165848.89751-3-swboyd@chromium.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
         <20180321165848.89751-3-swboyd@chromium.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Some qcom platforms make some GPIOs or pins unavailable for use by
> non-secure operating systems, and thus reading or writing the
> registers
> for those pins will cause access control issues. Add support for a DT
> property to describe the set of GPIOs that are available for use so
> that
> higher level OSes are able to know what pins to avoid reading/writing.
> Non-DT platforms can add support by directly updating the
> chip->valid_mask.

> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Hmm...

> +	gpiochip->valid_mask = kcalloc(BITS_TO_LONGS(gpiochip-
> >ngpio),
> +				       sizeof(long), GFP_KERNEL);

Just noticed that kcalloc is superfluous here.
kmalloc_array() would be enough.

> +	if (!gpiochip->valid_mask)
> +		return -ENOMEM;
> +
> +	/* Assume by default all GPIOs are valid */
> +	bitmap_fill(gpiochip->valid_mask, gpiochip->ngpio);


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
