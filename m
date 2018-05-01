Return-Path: <b-liu@ti.com>
X-Google-Smtp-Source: AB8JxZpBApap3RUd2J8iMKLOQPAhB8GfzuKLOaNpmoTXWQvP/N5Tncvetrz09yVaI/ffqymRFSwd
ARC-Seal: i=1; a=rsa-sha256; t=1525191781; cv=none;
        d=google.com; s=arc-20160816;
        b=yobgFSD1NI/f/3Ypae8U8RT7b9BWVyvdjElUNs6fOVZuhUKxwKxM3I5YvVvlYuaosS
         SHF/8aJyJy0FIMbQbxcXG2U4G5+q1SWGYyM3gn5NpshXumqel/Ici32ajAeMGwIGTCst
         lTdiRPYIxb6qDWOwC0PZPm32X8pKmpd/QXX9vEvjEcRawpxHYMp0xCmcYhOfZPvQQSq2
         0qSIfLj1SuzUQ5fT3oM/6unGWimJwVoP2ljzbxiurwW8Z7+fXvyf/8bJeVPsF0qc3xah
         3XLex3Vk3m5DlmYrndoyWsn/hSr1ZuJN9sWZuEGtO+7GGndYmrT2w4onXL5njyJOA5Ed
         cPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vdgNQsrOnofTS9qTRkvkyM1h4qbqMOYQgG3O5qJ+ocY=;
        b=oD00RUhdVeAQzgHMTYGkIIo7/OUkf5RSPuxCEG/KmWwsqJybF5QT4HVFHoAjRHDezY
         R7qL6O4a6xUuEjuy8v/rmxd5zOqWd9mljMN83oEcsMGxuVY6IHD0Ib6I8od7zTThQnqZ
         KGgYAp0zKXWj3wXWxpAMW1t6hzsaTtbu8csKTn2EVESqPJfN3ynICgQ30iuE8Y+zS+NL
         mRZOc3ic1B/oPzsbPORlTd/DBydhO7UbE+AqtpFk8xlOGWUcxODfiXtMZSnXXkOTd3j1
         NqODpnB/O+h4/v2tfYk7tKmDp7POPuTOdFrao+QIZGHlRxtj+gCUToXfAX2K9QmHBJXY
         qh9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=aY091IuN;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=aY091IuN;
       spf=pass (google.com: domain of b-liu@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=b-liu@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Date: Tue, 1 May 2018 11:22:54 -0500
From: Bin Liu <b-liu@ti.com>
To: Paul Kocialkowski <contact@paulk.fr>
CC: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard
	<maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20180501162254.GF21238@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
	Paul Kocialkowski <contact@paulk.fr>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
 <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
 <b24cf58d2f48519893a5051a98bee6579c5e0d98.camel@paulk.fr>
 <20180501122533.GD21238@uda0271908>
 <5907f644301499eff3e2740e15f16aaffec84817.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5907f644301499eff3e2740e15f16aaffec84817.camel@paulk.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596219936239404188?=
X-GMAIL-MSGID: =?utf-8?q?1599279497854483559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 03:26:57PM +0200, Paul Kocialkowski wrote:
> Hi,
> 
> Le mardi 01 mai 2018 à 07:25 -0500, Bin Liu a écrit :
> > On Mon, Apr 30, 2018 at 11:08:42PM +0200, Paul Kocialkowski wrote:
> > > Hi,
> > > 
> > > Le samedi 21 avril 2018 à 09:34 -0500, Bin Liu a écrit :
> > > > Okay, this came down to an argument that whether we should require
> > > > loading a gadget driver on a dual-role port to work in host mode,
> > > > which is currently required on musb since a long long time ago.
> > > > 
> > > > I understand the requirement is kinda unnecessary, but since it
> > > > already
> > > > exists on musb stack for a long time, I don't plan to change it.
> > > > Because I
> > > > cannot think of a use case in real products that doesn't
> > > > automatically
> > > > load a gadget function on the dual-role port.
> > > > 
> > > > If you can explain a use case in real world (not a engineering
> > > > lab)
> > > > that the gadget driver will not be loaded at linux booting up, but
> > > > later based on user's input, I will reconsider my decision. To
> > > > remove
> > > > this requirement from musb stack, the work is more than this
> > > > patch.
> > > 
> > > My use case here is to support common GNU/Linux-based distributions,
> > > not
> > > use-case-specific varieties of GNU/Linux-based rootfs. So my point
> > > here
> > > would be that most distros will (and probably should) ship g_ether
> > > as a
> > > module but without any particular reason to autoload it, or any
> > > other
> > > gadget module in particular, since the system is general-purpose.
> > 
> > This is the case I called it "in a engineering lab", not a real
> > product.
> 
> To me, this sounds more like "daily use with upstream like on any
> laptop/desktop" rather than an engineering lab, but that's not the main
> point here.
> 
> > > Then, imagine a user wants to plug a USB device through OTG (say,
> > > because it's the only USB port available at all on the tablet
> > > they're
> > > using), it simply won't work. It won't be obvious to that user that
> > > this
> > > is because no gadget is loaded, since what they want to do does not
> > > involve using gadget mode at any point.
> > 
> > If a tablet has a dual-role usb port, it is designed to use a gadget
> > driver,
> 
> I don't understand the logic behind this assertion. If it has a dual-
> role USB port, then its hardware allows both use cases. It's obvious
> that the use case is up to the user of the device since it can be
> switched by software and is not fixed at design time.

My view is the whole (embedded) system, not just Linux itself. If the
hardware designs a dual-role port, a gadget driver has to be used.
Otherwise, define the port as host-only, either in the hardware design,
or at least in device tree.

> >  which has to be loaded at some point. In the case you described
> > above, when the gadget driver will be loaded? and how?
> 
> Again, loading a gadget driver is not part of the use case. In what I
> described, the user only wants to use the dual-role port for its host
> capability and does not care about gadget at all. When the device is
> plugged into a host, it will simply charge and not propose any USB
> device features.

It sounds to me a hacking to an existing product, not designing a new
product. If so, please hack it completely, define the port dr_mode to
host in the board device tree, then the port should work for you.

> > If a gadget driver will never be used, a host-only port should be on
> > the board, not a dual-role port.
> 
> Here as well, I think the use case is separate from the hardware design.
>  I crafted this patch because I was in the use case I described, with a
> tablet that only features a micro B USB OTG port. The form factor simply

I guess you meant micro-AB port, microB doesn't have an ID pin, cannot
make MUSB to work in host mode.

> does not allow having a full USB A female host-only port.
> 
> > > Do you think this is a valid use case? It surely is a common one and
> > > perfectly depicts my situation.
> > 
> > As I explained above, I don't think so.
> 
> I am really surprised that using regular upstream GNU/Linux
> distributions out of the box is not a valid use case for the MUSB
> driver. The situation I'm describing is exactly the same as buying a
> laptop with a preinstalled OS and replacing it with a regular distro. In
> my case, that's what I did with the tablet (that had an old Android
> version that did expose gadget features via USB) and I installed
> upstream Linux and a distro on it.

Embedded system is different than PC, I don't expect to just drop in a
distro without any modification to work, especially in this case you
change the function of the product originally designed - dual-role port
to host-only port. You would have to at least modify the board device
tree for your new purpose. 

> 
> > > Note that in addition to Allwinner devices, I also have omap3/4/5
> > > devices for testing things. I don't think I have other MUSB-enabled
> > 
> > Much more than what I have ;)
> > 
> > > devices in my collection though, but I would be willing to test
> > > fixes to
> > > this issue on the ones I have.
> > 
> > Appreciated it, but someone has to make the patches first. The one you
> > posted might be a good start, but it is not complete. The first 
> > problem
> 
> Oh, I am definitely up for making the changes as well, I mentioned
> testing to show what level of test coverage I could bring to the table,
> since this will probably require making sure that it doesn't break
> specific platforms, glue layers, etc.

yes, no regression is required.

> > I see is that musb_start() will be called twice, one in the place you
> > patched, the other is when the gadget driver is bound to the UDC.
> 
> Okay, I will look into this and make sure there is only a single call to
> musb_start in all scenarios. Are there other things that should be
> modified as well?

As I said earlier I don't plan to change it because I don't think it is
an issue, so never really looked into this. But following is my initial
thought:

Currently musb_start() is called separately for host and gadget, because
the musb drivers don't want to couple these two configurations together.
(Though the host-only or gadget-only MUSB configuration might not work
today, I have tested them for a long time, but at least the Kconfig
options are there...)

So the final solution that I would think should not couple both
configurations even more. And I will not accept a solution which only
simply adds if-else to distinguish the configurations, the drivers
already have enough if-else to clean up.

If musb_start() could be moved in musb core where is independent to host
or device, that might be a possible solution.

Again, my opinion on removing this requirement is wasting of time, as
the hardware design should be done properly at first for the usage, or
if hacking on an existing product, device tree modification should be
done first, or just simply let the Linux init module to load a gadget
driver.

Regards,
-Bin.
