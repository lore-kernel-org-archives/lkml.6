Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756388AbeDZNhB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:37:01 -0400
Received: from bert.emutex.com ([91.103.1.109]:55050 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755172AbeDZNg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:36:59 -0400
Date: Thu, 26 Apr 2018 14:36:53 +0100
From: Javier Arteaga <javier@emutex.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 3/3] pinctrl: upboard: Add UP2 pinctrl and
 gpio driver
Message-ID: <20180426133653.4yhjv6uuaox7vt7m@localhost>
References: <20180421085009.28773-1-javier@emutex.com>
 <20180421085009.28773-4-javier@emutex.com>
 <20180426065028.fvdf7ke5va2kacmv@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180426065028.fvdf7ke5va2kacmv@dell>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Thu, Apr 26, 2018 at 07:50:28AM +0100, Lee Jones wrote:
    > > static const struct mfd_cell upboard_up2_mfd_cells[] = { > > + { .name
    = "upboard-pinctrl" }, > > UPBOARD_LED_CELL(upboard_up2_led_data, 0), > >
    UPBOARD_LED_CELL(upboard_up2_led_data, 1), > > UPBOARD_LED_CELL(upboard_up2_led_data,
    2), > > Please made this a separate patch. > > There aren't any build dependencies
    between the files. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 07:50:28AM +0100, Lee Jones wrote:
> >  static const struct mfd_cell upboard_up2_mfd_cells[] = {
> > +	{ .name = "upboard-pinctrl" },
> >  	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
> >  	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
> >  	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
> 
> Please made this a separate patch.
> 
> There aren't any build dependencies between the files.

Will do.

I have one further question about MFD in this patch too - should I keep
passing regmap into the driver via dev_get_drvdata(pdev->dev.parent),
or is explicit platform_data preferable?

Andy suggested platform_data allows more flexibility on the parent
device side (although I can't see upboard-pinctrl being used other than
as a child of the upboard driver).

I went with parent drvdata simply because that's what I found in other
MFD drivers and material [1].

Thank you!

[1]: http://events17.linuxfoundation.org/sites/events/files/slides/belloni-mfd-regmap-syscon_0.pdf
