Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeDZCes (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:34:48 -0400
Received: from bert.emutex.com ([91.103.1.109]:54914 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbeDZCeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:34:44 -0400
Date: Thu, 26 Apr 2018 03:34:41 +0100
From: Javier Arteaga <javier@emutex.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Dan O'Donovan" <dan@emutex.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 2/3] leds: upboard: Add LED support
Message-ID: <20180426023441.f2a7337sjlyd6xhf@localhost>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-3-javier@emutex.com>
 <1524672945.21176.594.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524672945.21176.594.camel@linux.intel.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Wed, Apr 25, 2018 at 07:15:45PM +0300, Andy Shevchenko
   wrote: > On Sat, 2018-04-21 at 09:50 +0100, Javier Arteaga wrote: > > Allow
    userspace to use the on-board LEDs as "upboard:<color>:". > > > + struct
   upboard_led *led = container_of(cdev, struct > > upboard_led, cdev); > > #define
    to_upboard_led(cdev) container_of(cdev, struct upboard_led, > cdev) > > ...
    led = to_upboard_led(cdev); > > > + struct upboard_led *led = container_of(cdev,
    struct > > upboard_led, cdev); > > Ditto. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 07:15:45PM +0300, Andy Shevchenko wrote:
> On Sat, 2018-04-21 at 09:50 +0100, Javier Arteaga wrote:
> > Allow userspace to use the on-board LEDs as "upboard:<color>:".
> 
> > +	struct upboard_led *led = container_of(cdev, struct
> > upboard_led, cdev);
> 
> #define to_upboard_led(cdev) container_of(cdev, struct upboard_led,
> cdev)
> 
> ... led = to_upboard_led(cdev);
> 
> > +	struct upboard_led *led = container_of(cdev, struct
> > upboard_led, cdev);
> 
> Ditto.

Will do - thanks!

> > +static int __init upboard_led_probe(struct platform_device *pdev)
> 
> Are you sure about __init here?

Not 100% now :)

My understanding was that in this context, __init allows this probe() to
be dropped from memory after module load.

What am I doing wrong there?

> > +	struct upboard_led_data * const pdata = pdev-
> > >dev.platform_data;
> 
> Don't use direct dereference to platform_data.

Sorry, I don't understand this one. What's the alternative?

> > +	if (!pdev->dev.parent)
> > +		return -EINVAL;
> > +
> > +	upboard = dev_get_drvdata(pdev->dev.parent);
> > +	if (!upboard || !pdata)
> > +		return -EINVAL;
> 
> Wouldn't be better to supply regmap as part of platform data?
> It will allow be flexible of parent device.

I'll play around with that.

> > +MODULE_LICENSE("GPL");
> 
> License mismatch.

Will fix.
