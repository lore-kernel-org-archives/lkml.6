Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeDYHCf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:02:35 -0400
Received: from bert.emutex.com ([91.103.1.109]:54629 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeDYHCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:02:32 -0400
Date: Wed, 25 Apr 2018 08:02:27 +0100
From: Javier Arteaga <javier@emutex.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 2/3] leds: upboard: Add LED support
Message-ID: <20180425070227.exixjo64spvt36vo@localhost>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-3-javier@emutex.com>
 <20180425064133.GC5352@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425064133.GC5352@amd>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Pavel, On Wed, Apr 25, 2018 at 08:41:33AM +0200, Pavel
   Machek wrote: > On Sat 2018-04-21 09:50:08, Javier Arteaga wrote: > > Allow
    userspace to use the on-board LEDs as "upboard:<color>:". > > > > Signed-off-by:
    Javier Arteaga <javier@emutex.com> > > > +static enum led_brightness upboard_led_brightness_get(struct
    led_classdev *cdev) > > +{ > > + struct upboard_led *led = container_of(cdev,
    struct upboard_led, cdev); > > + int brightness = 0; > > + > > + regmap_field_read(led->field,
    &brightness); > > + > > + return brightness; > > +}; > > I'm slightly confused
    here. Is each led controlled by single bit? [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, Apr 25, 2018 at 08:41:33AM +0200, Pavel Machek wrote:
> On Sat 2018-04-21 09:50:08, Javier Arteaga wrote:
> > Allow userspace to use the on-board LEDs as "upboard:<color>:".
> > 
> > Signed-off-by: Javier Arteaga <javier@emutex.com>
> 
> > +static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
> > +{
> > +	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
> > +	int brightness = 0;
> > +
> > +	regmap_field_read(led->field, &brightness);
> > +
> > +	return brightness;
> > +};
> 
> I'm slightly confused here. Is each led controlled by single bit?

Yes. Each regmap field is one bit wide.

> What is going on with ";" at end of function? We don't do that.

Huh, I totally missed this. It's all throughout the patchset too, and
it's going away in v2 of course.

> If it is single bit, max_brightness should be one, and != LED_OFF test
> should not be needed.

Got it. Will do for v2.

Thanks for your time!
