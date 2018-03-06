Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbeCFO7d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:59:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:21499 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932589AbeCFO7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:59:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,431,1515484800";
   d="scan'208";a="209287884"
Message-ID: <1520348368.10722.440.camel@linux.intel.com>
Subject: Re: [PATCH] pinctrl: intel: Implement intel_gpio_get_direction
 callback
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Arteaga <javier@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 06 Mar 2018 16:59:28 +0200
In-Reply-To: <1520348165.10722.438.camel@linux.intel.com>
References: <20180306134213.16898-1-javier@emutex.com>
         <3585081b-70af-5c31-08c0-84e96b6055bc@emutex.com>
         <1520348165.10722.438.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-06 at 16:56 +0200, Andy Shevchenko wrote:
> On Tue, 2018-03-06 at 14:31 +0000, Javier Arteaga wrote:

> > > +static int intel_gpio_get_direction(struct gpio_chip *chip,
> > > unsigned int offset)
> > > +{

> > > +	if (padcfg0 & PADCFG0_PMODE_MASK)
> > > +		return -EINVAL;
> 
> Actually we might return direction of GPIO function while pin is in
> some
> other mode, though it would probably make not much sense in practice.

One more though, this is a call back for GPIO function anyway, so, above
condition should never happen. I think it's safe to remove it
completely.

> > > +
> > > +	return !!(padcfg0 & PADCFG0_GPIOTXDIS);
> > > +}


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
