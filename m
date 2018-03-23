Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755112AbeCWLgM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:36:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:46044 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbeCWLgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:36:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,349,1517904000";
   d="scan'208";a="185362490"
Message-ID: <1521804964.23017.96.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Timur Tabi <timur@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Grant Likely <grant.likely@secretlab.ca>, linux-gpio@vger.kernel.org
Date: Fri, 23 Mar 2018 13:36:04 +0200
In-Reply-To: <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
         <20180321165848.89751-4-swboyd@chromium.org>
         <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-22 at 19:16 -0500, Timur Tabi wrote:
> On 03/21/2018 11:58 AM, Stephen Boyd wrote:
> > +static int msm_gpio_init_valid_mask(struct gpio_chip *chip,
> > +				    struct msm_pinctrl *pctrl)
> > +{
> > +	int ret;
> > +	unsigned int len, i;
> > +	unsigned int max_gpios = pctrl->soc->ngpios;
> > +
> > +	/* The number of GPIOs in the ACPI tables */
> > +	ret = device_property_read_u16_array(pctrl->dev, "gpios",
> > NULL, 0);
> > +	if (ret > 0 && ret < max_gpios) {
> 
> This needs to be ret <= max_gpios, otherwise it will fail if every
> GPIO 
> is available.
> 
> And it should print an error message and return an error code if ret
> > 
> max_gpios.

Perhaps makes sense to do the opposite condition

if (ret < 0 || ret > max_gpios) {
 ... error handling ...
}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
