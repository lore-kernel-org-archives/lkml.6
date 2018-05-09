Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525857512; cv=none;
        d=google.com; s=arc-20160816;
        b=Dl94z6LSCHqDTq2Xg5JKLWt/ofBegsZezeA/spllMvR0vIUgebn/w19jGez1WtDB+U
         T1G93lTxxFWsqvZUQEL/EtKVoA+lUWyzRYDXFo3kY7+64bc1XmHVANzBMb0nWLw2rP4/
         0rDiXEv4AxEz1BhxLLcNhI1MUS4Oj6SfjQPdawr+o+b3X+4J0uG7sKRYrOPYSHtQOBF+
         3W4Ztl4kkaRY1+HAQo6C3pCOY4nJKeGOD4n84etqqcNY08qLpo3TFg0neYZ6FWfMVgV9
         eX3u3Jcb8S+lybc3igP2ANg21qyDGU8IFieYruM0s+8JJ/o9tXxknxAVDB1x0Rib7Kp8
         Padw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=iFjN9cb6vBbD5PDJy/gD+uXgE74Nwj0Qh4wb0yyOsNE=;
        b=HH3Xp6pG/3of34D4uLqc2h65SJhBY3/bmT8yev6YgRgJtu8SNmN4LWPsTIsi3eyF7J
         LBYn/9Cfp2pT14z5/2LdQc/UceGOZvg0VLUYB73AwslGABGOXEIJmvbVmN93Y+zTEaDc
         nS2I7Dr/Lifvq6FnkIhUKSw+Y/FhUFi0ViKErAUEMnir2D+RJqOuIQswwuF06YNwxNHa
         SQi+jBCC1IKeSumgP0yqaE1kGSoht1Xq0F1UAgqLGFbiS1yXz3I0LWNrxMJpCTAQCxCP
         3wuPdO4cDzVY/W0AZ1lcM+KG10WpBq6UHZ3HuFBd5s0CZp00ISjDyOrS9U98Ie0sir0E
         KoNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l6cnpKl3;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=l6cnpKl3;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZpXg3x0XAecTAqxJjXIS8JeZqxuHiEXMzDgN38mBVrTBxM62gL+EUKReVd1vGj6L+ehw2ZG0Q==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 9 May 2018 11:18:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Tony Lindgren <tony@atomide.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Serdev runtime PM (was: Re: [PATCH 4/7] dt-bindings: gnss: add
 u-blox binding)
Message-ID: <20180509091831.GA2285@localhost>
References: <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180508155608.3bzcbepsmoskhlox@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508155608.3bzcbepsmoskhlox@earth.universe>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599977567023696204?=
X-GMAIL-MSGID: =?utf-8?q?1599977567023696204?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ Changing the subject line as this is thread is no longer about DT
  bindings.

  Also adding linux-serial and linux-pm while keeping some context. ]

On Tue, May 08, 2018 at 05:56:08PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, May 07, 2018 at 06:34:39PM +0200, Johan Hovold wrote:
> > On Mon, May 07, 2018 at 08:45:15AM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan@kernel.org> [180507 03:03]:
> > > > On Fri, May 04, 2018 at 01:42:13PM +0200, Sebastian Reichel wrote:
> > > > 
> > > > > Having said all of this, serdev does not yet support runtime PM (at
> > > > > all). Tony is currently looking into it. Fortunately serdev allows
> > > > > us to enable runtime PM by default (once implemented), since we know
> > > > > the remote side and can (hopefully) avoid losing characters (i.e.
> > > > > with sideband wakeup gpios).
> > > > 
> > > > I'm not sure we want generic runtime-pm support for the controllers in
> > > > the sense that the slave device state is always reflected by the serial
> > > > controller. Similar as for i2c and spi, we really only want to keep the
> > > > controller active when we are doing I/O, but we may want to keep a
> > > > client active for longer.
> > > 
> > > Yeah i2c seems to do the right thing where the bus takes care
> > > of runtime PM.
> > 
> > Yeah, but since serial is async in contrast to i2c/spi, we may not be
> > able to push this entirely into core. The serdev drivers may need to
> > indicate when they expect or need to do I/O by opening and closing the
> > port. And this is how I implemented these first couple of gnss drivers.
> >
> > Also note that most serial driver do not do runtime pm while the port is
> > open (as OMAP does), and doing so also has the drawbacks of lost
> > characters etc. as Sebastian mentioned.
> 
> I think using open/close for runtime pm is good enough for GPS,
> since it regularly sends data and draws lots of power anyways.
> But devices, that have an out-of-band wakeup signal can do proper
> runtime PM of the serial port without loosing characters.

Yeah, there may be some applications where this is possible. And this is
not the case for GPS, but not just because of a generally higher power
consumption, but due to the fact that we cannot afford having the first
message in every report burst be dropped.

> Note, that OMAP does not reach deep idle states with active
> serial port. This is not acceptable for low power devices.

Sure, but note that OMAP is the only serial driver which currently
implements this kind of aggressive runtime PM (besides a couple of
usb-serial drivers). This means that a serdev driver can never rely on
this being the case, and therefore needs to be restrictive about how
long the port is kept open if it cares about power at all.

> > > > Take the u-blox driver in this series for example. As I'm using runtime
> > > > PM to manage device power, user-space can chose to prevent the receiver
> > > > from runtime suspending in order to avoid lengthy (re-)acquisition times
> > > > in setups without a backup battery (by means of the power/control
> > > > attribute).
> > > 
> > > Sorry I don't seem to have that one, care to paste the subject
> > > line of that patch?
> > 
> > 	"[PATCH 5/7] gnss: add driver for u-blox receivers"
> > 
> > 	https://lkml.kernel.org/r/20180424163458.11947-6-johan@kernel.org
> > 
> > > > Note that serdev not enabling runtime pm for controllers is roughly
> > > > equivalent to setting the .ignore_children flag, which is what we do for
> > > > i2c and spi controller, and possibly what we want here too.
> 
> For I2C/SPI this works, since receive operations are initiated by
> the controller. Unfortunately its harder to implement for async
> serial. But I agree, that we may want to have runtime PM for the
> serdev client and .ignore_children is the way to go.

It's really about adding runtime PM support to serdev controllers.
Serdev client drivers can already use runtime PM (as mentioned above).

The ignore_children flag would then allow the controller RPM state to be
managed independently of the child/slave device state when more fine
grained RPM control is desired.

> I think the client API should allow two things:
> 
> 1. minimal runtime PM support: The controller is runtime enabled
> on serdev open and disabled on serdev close. This may be enough
> for some clients and useful for writing new drivers.

Right, and we already have something like this today by means of how the
serial driver implement runtime PM (i.e. they are generally active while
the port is open).

> 2. full runtime PM support: The controller is sleeping by default
> even with serdev open. The calls to write/change port settings/...
> automatically enables the device, similar to i2c/spi. But there
> must be additional functions to enable/disable runtime PM based
> on a wakeup gpio or similar out-of-band information. It may be
> enough to just provide:
> 
> int serdev_pm_runtime_get_sync(struct serdev_device *serdev) {
>     pm_runtime_get_sync(&serdev->dev);
> }
> 
> int serdev_pm_runtime_put_autosuspend(struct serdev_device *serdev) {
>     pm_runtime_put_autosuspend(&serdev->dev);
> }

I'm not a big fan of rpm wrappers and prefer using the RPM interface
directly, but that's a side note. In the above case we really want to
manage the controller (&serdev->ctrl->dev) rather than the client
however (.ignore_children should be set, remember).

Also note that a serial driver implementing aggressive RPM (e.g. using
autosuspend) would manage the RPM counts itself when changing terminal
settings etc, so the only thing that would be needed is for the
client/slave device to resume the controller pro-actively when it is
expecting incoming data.

To make this more concrete; an example could be a device with an OOB
wake-up signal, but using a request-response type protocol so that the
client driver knows when it's safe to allow the controller to again
suspend.

We can model this similarly to how we do it for usb-serial, namely that
the core takes an extra RPM reference at open, which a sufficiently
power aware driver can then chose to drop in order to allow for more
aggressive controller runtime PM (should the underlying device and driver
support it).

I've cooked up a patch which I'll be sending as a reply to this mail.

Thanks,
Johan
