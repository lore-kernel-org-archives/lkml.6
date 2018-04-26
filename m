Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbeDZHz5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:55:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:47202 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752749AbeDZHzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:55:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="53775762"
Message-ID: <1524729349.21176.614.camel@linux.intel.com>
Subject: Re: [RFC PATCH RESEND 2/3] leds: upboard: Add LED support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Arteaga <javier@emutex.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Dan O'Donovan" <dan@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Apr 2018 10:55:49 +0300
In-Reply-To: <20180426023441.f2a7337sjlyd6xhf@localhost>
References: <20180421085009.28773-1-javier@emutex.com>
         <20180421085009.28773-3-javier@emutex.com>
         <1524672945.21176.594.camel@linux.intel.com>
         <20180426023441.f2a7337sjlyd6xhf@localhost>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-26 at 03:34 +0100, Javier Arteaga wrote:
> On Wed, Apr 25, 2018 at 07:15:45PM +0300, Andy Shevchenko wrote:
> > On Sat, 2018-04-21 at 09:50 +0100, Javier Arteaga wrote:

> > > +static int __init upboard_led_probe(struct platform_device *pdev)
> > 
> > Are you sure about __init here?
> 
> Not 100% now :)
> 
> My understanding was that in this context, __init allows this probe()
> to
> be dropped from memory after module load.
> 
> What am I doing wrong there?

Just give another thought about it. The keyword(s) here is(are): time to
live of the objects in question. It's good to get knowing what unbind-
bind means (for built-in drivers).

> > > +	struct upboard_led_data * const pdata = pdev-
> > > > dev.platform_data;
> > 
> > Don't use direct dereference to platform_data.
> 
> Sorry, I don't understand this one. What's the alternative?

See other drivers how they do that stuff. Hint: check inline functions
in include/linux/device.h.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
