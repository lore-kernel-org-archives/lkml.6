Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZpJb1rZ1xnFTC5wiSQZGJ5OEpsRZomqoY792u+SA/WqbYg6KfD26Nu3aoG3zSxG7o4r+Hs1
ARC-Seal: i=1; a=rsa-sha256; t=1525715436; cv=none;
        d=google.com; s=arc-20160816;
        b=R7UntJ4CwFpzwbse8FX7ULRsZNVZYV3fIFuSVL8KS38TjA73Z3j9xHDsGuaU2FYyFH
         Uw0jXhoEcTSU2gOTWcgtz/2Q4Vkuf/oJgH6l/IxLOR2aeKMeIpbmNuDNScufU9/dH/6C
         +z2oNkApT6odUrmlnN+fDfQfEvlYLOHXCG64+BOxBBK7jmAOPMYsgbpbUSIoo5FpXmhl
         D9ySY9dN6DDKBPkA/MxoAUBbrCxDzXJTJKavIcVI90sKuSb2RzvPgnUx+vl+66jPtgqn
         4R4qQRA6ZdJMq1GWchDattx8Vx4YE4YwDgy8e1M31l+j4zPoJX21JgAQKyRi7diRwXSR
         q6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=D1qzNOKeFvR6hGBcKpY3aZ2X1H63cHPdxcGHGs5mHYQ=;
        b=hyFdPKwOr9AppUFf/Sh9TZLnDBcAiVPF9Acga2RVBYfV8BC64lwsnzDj9aT/hNwHy8
         Q6uh5tCQZc6vloiKxi9dl2oKWgocC6c/H43bIytva0j6/rNSVdJDz1RFJeRHKRuFQ6gr
         RG8OxCQp+fh65ApBTMuv2UuB3LH2OX+f4vBF9prd287k4o3EQyid6oyXKbCi4ELFiJwv
         CLVTdRK6HLrC9Beog/KvHOA2js6NCo/1f3fpp8OXKG7itqRqtJOSvI2qHMXaAAd12wxF
         VQElPC41RhkJDVbHI/h+yiDaLPk/GswCxS6Vr7OWwUsEzQVGB5nWZuloxv9uElb/I5A2
         ojnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Mon, 7 May 2018 10:50:32 -0700
From: Tony Lindgren <tony@atomide.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180507175032.GR98604@atomide.com>
References: <20180426091018.GU4615@localhost>
 <CAL_JsqK=xQBx2YCd0kDP0zLn_LAZb6Mi5UfSTQf2soooVz2unQ@mail.gmail.com>
 <20180502081637.GE2285@localhost>
 <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507163439.GV2285@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599828589699341719?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Johan Hovold <johan@kernel.org> [180507 16:36]:
> On Mon, May 07, 2018 at 08:45:15AM -0700, Tony Lindgren wrote:
> > Hi,
> > 
> > * Johan Hovold <johan@kernel.org> [180507 03:03]:
> > > On Fri, May 04, 2018 at 01:42:13PM +0200, Sebastian Reichel wrote:
> > > 
> > > > Having said all of this, serdev does not yet support runtime PM (at
> > > > all). Tony is currently looking into it. Fortunately serdev allows
> > > > us to enable runtime PM by default (once implemented), since we know
> > > > the remote side and can (hopefully) avoid losing characters (i.e.
> > > > with sideband wakeup gpios).
> > > 
> > > I'm not sure we want generic runtime-pm support for the controllers in
> > > the sense that the slave device state is always reflected by the serial
> > > controller. Similar as for i2c and spi, we really only want to keep the
> > > controller active when we are doing I/O, but we may want to keep a
> > > client active for longer.
> > 
> > Yeah i2c seems to do the right thing where the bus takes care
> > of runtime PM.
> 
> Yeah, but since serial is async in contrast to i2c/spi, we may not be
> able to push this entirely into core. The serdev drivers may need to
> indicate when they expect or need to do I/O by opening and closing the
> port. And this is how I implemented these first couple of gnss drivers.

OK

> Also note that most serial driver do not do runtime pm while the port is
> open (as OMAP does), and doing so also has the drawbacks of lost
> characters etc. as Sebastian mentioned.

Yes serdev seems really nice for the oob wake gpios :)

> > > Take the u-blox driver in this series for example. As I'm using runtime
> > > PM to manage device power, user-space can chose to prevent the receiver
> > > from runtime suspending in order to avoid lengthy (re-)acquisition times
> > > in setups without a backup battery (by means of the power/control
> > > attribute).
> > 
> > Sorry I don't seem to have that one, care to paste the subject
> > line of that patch?
> 
> 	"[PATCH 5/7] gnss: add driver for u-blox receivers"
> 
> 	https://lkml.kernel.org/r/20180424163458.11947-6-johan@kernel.org

Thanks will take a look.

> > > Note that serdev not enabling runtime pm for controllers is roughly
> > > equivalent to setting the .ignore_children flag, which is what we do for
> > > i2c and spi controller, and possibly what we want here too.
> > 
> > We currently don't idle serdev at all even if not in use. What
> > I noticed is if I have these in my .config:
> > 
> > CONFIG_SERIAL_DEV_BUS=y
> > CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
> > 
> > And no hci_serdev.ko driver loaded, then the 8250 port still stays
> > active and there are no sysfs entries to idle it.
> 
> Sounds like the 8250_omap driver is doing something funky. Why would
> there not be any sysfs attributes to control runtime pm?

I don't know, they are there for the ports that don't have any
serdev device. But if there is a serdev child node, the sysfs
disappear for the 8250 port like it's /dev/ttyS* entry. That is
even with no hci_serdev.ko loaded :)

> > Are you seeing this with your series?
> 
> I'm using omap-serial (on BBB) and like 8250_omap, the driver disables
> runtime pm at probe by setting a negative autosuspend timeout.

Hmm I though we now have both 8250_omap and serial-omap behave the
same way for PM.

> Changing this through sysfs causes the serial controller to runtime
> suspend, but something is not right in my setup as it doesn't wake up on
> incoming data.

Do you have also a /dev/ttyO* entry created for the serdev port?

> I'd say the omap drivers are broken; the controller should definitely
> idle when the port is closed (whether using serdev or not) without
> having to fiddle with sysfs.

This is happening for the non-serdev ports for sure. FYI, there is
one patch needed for omap4 to idle unused ports that I posted
few days ago:

[PATCHv3] serial: 8250: omap: Fix idling of clocks for unused uarts

But the serdev port is never idled, even if unused.

Can you check your serdev port clkctrl reg with rwmem or similar
tool when it's idle?

You can do it with:

rwmem -s32 0x44e004b4           # uart 1 on l4_wkup
rwmem -s32 0x44e0006c+0x10      # uart 2 - 5 on l4_per
rwmem -s32 0x44e00038           # uart 6 on l4_per

And here's what I have on my bbb with 8250_omap:

0x44e004b4 = 0x00000002
0x44e0006c = 0x00030000
0x44e00070 = 0x00030000
0x44e00074 = 0x00030000
0x44e00078 = 0x00030000
0x44e00038 = 0x00030000

So all disabled except for the console UART.

Regards,

Tony
