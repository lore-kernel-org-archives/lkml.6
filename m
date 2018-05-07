Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeEGT7S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:59:18 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:36242 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752081AbeEGT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:59:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EEAQBWr/BamD+a6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYMVgQKBCCgKmFuBeYEPhn2MKRSBZAuEbAKCVCE2FgECAQEBAQE?=
 =?us-ascii?q?BAgEBAhABAQEBAQgLCwYoL4I1IoJTAQEBAQIBJ1IMBAIBCBEEAQEBJwchJQMBB?=
 =?us-ascii?q?QgCBAENBQgThG4DDQipbzOHDg2BK4JIiCWCE4EPgwuCT4F8EYVLIAKMSYs1LAi?=
 =?us-ascii?q?LUGeCDoxqig+DIoMbgSUjB4F9cIMTgi6OIG+ODYEfgRgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EEAQBWr/BamD+a6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYM?=
 =?us-ascii?q?VgQKBCCgKmFuBeYEPhn2MKRSBZAuEbAKCVCE2FgECAQEBAQEBAgEBAhABAQEBA?=
 =?us-ascii?q?QgLCwYoL4I1IoJTAQEBAQIBJ1IMBAIBCBEEAQEBJwchJQMBBQgCBAENBQgThG4?=
 =?us-ascii?q?DDQipbzOHDg2BK4JIiCWCE4EPgwuCT4F8EYVLIAKMSYs1LAiLUGeCDoxqig+DI?=
 =?us-ascii?q?oMbgSUjB4F9cIMTgi6OIG+ODYEfgRgBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.49,375,1520917200";
   d="scan'208";a="182686111"
X-DLP: DLP_GlobalPCIDSS
To: <dmitry.torokhov@gmail.com>, <pali.rohar@gmail.com>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Dell docking station & Dell Embedded Controller & PS/2 devices
Thread-Topic: Dell docking station & Dell Embedded Controller & PS/2 devices
Thread-Index: AQHT5UDMWM1nc4K7y0Sd6Py+b6Y5jaQkSIuAgAC1NgD//7D3wA==
Date: Mon, 7 May 2018 19:59:14 +0000
Message-ID: <147aa25ad2d14bad975731a6c9cf9281@ausx13mpc124.AMER.DELL.COM>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
 <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
 <20180506134733.zttaitnf6ej4tith@pali> <20180507084431.r2dipv32wt3vbx3k@pali>
 <20180507193306.GA31301@dtor-ws>
In-Reply-To: <20180507193306.GA31301@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47JxNQt017117

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Monday, May 7, 2018 2:33 PM
> To: Pali Rohár
> Cc: Limonciello, Mario; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devices
> 
> On Mon, May 07, 2018 at 10:44:31AM +0200, Pali Rohár wrote:
> > On Sunday 06 May 2018 15:47:33 Pali Rohár wrote:
> > > On Thursday 01 February 2018 11:29:45 Dmitry Torokhov wrote:
> > > > Hi Pali,
> > > >
> > > > On Wed, Jan 24, 2018 at 11:41:21AM +0100, Pali Rohár wrote:
> > > > > Hi Dmitry!
> > > > >
> > > > > I'm observing a problem with internal touchpad (handled by psmouse.ko)
> > > > > on Dell laptops connected to Dell E docking station. When I connect
> > > > > external PS/2 keyboard to docking station then internal laptop touchpad
> > > > > switch from multitouch absolute mode to relative bare PS/2 mode.
> > > > >
> > > > > And because ALPS driver in psmouse.ko is capable to process interleaved
> > > > > bare 3-byte PS/2 packets with 6-byte ALPS packets (which handles
> > > > > trackstick data on some ALPS models), ALPS driver does not show any
> > > > > message about this "downgrade" from multitouch to bare mode. And
> > > > > continue working in bare mode.
> > > > >
> > > > > When I rmmod psmouse and modprobe it again, then touchpad switch back
> to
> > > > > multitouch mode.
> > > > >
> > > > > Mario told me that Dell Embedded Controller, which handle internal
> > > > > keyboard, internal touchpad and external PS/2 keyboard, automatically
> > > > > send RESET command to *all* those devices when external PS/2 keyboard is
> > > > > connected. Therefore this is reason why touchpad downgrade to to bare
> > > > > mode. And according to Mario, host system should issue vendor specific
> > > > > PS/2 commands to re-initialize all PS/2 devices when this situation
> > > > > happen. Mario also told me that Windows is doing this action.
> > > >
> > > > Yeah, I remember fun with Inspiron 8100 - when you dock it it woudl
> > > > silently switch Synaptics touchpad into standard mode and it would not
> > > > come back as Synaptics until you disconnect. And there was no
> > > > notification to the kernel as far as I could tell.
> > > >
> > > > It could be that we need to monitor dock events and then kick reconnect
> > > > of serio port, either from userspace via udev (I think that would be
> > > > preferred), or in kernel.
> > > >
> > > > >
> > > > > Every time when I connect external PS/2 keyboard to dock I see this
> > > > > message in dmesg:
> > > > >
> > > > > Spurious ACK... Some program might be trying to access hardware directly.
> > > > >
> > > > > I see it also every time when I dock laptop into docking station (to
> > > > > which is keyboard already connected). And it happens also when I connect
> > > > > external PS/2 mouse to dock.
> > > > >
> > > > > Dmitry, how to handle this situation to re-initialize psmouse.ko when
> > > > > external PS/2 device is connected to Dell E docking station? According
> > > > > to Mario, this is how Dell Embedded Controller is designed and suppose
> > > > > how OS should work with it.
> > > > >
> > > > > Manually rmmoding and modprobing for every docking/undocking laptop is
> > > > > not ideal solution.
> > > > >
> > > > > Could it be possible to use that Spurious ATKBD_RET_ACK from atkbd.c be
> > > > > handled on Dell systems (probably via DMI) as an event to reset and
> > > > > reinitialize all PS/2 devices?
> > > >
> > > > So we need to figure out what exactly we are getting from the docking
> > > > station in this case. We do try to handle the new device 0xaa 0x00
> > > > announcements:
> > > >
> > > > 	/* Check if this is a new device announcement (0xAA 0x00) */
> > > > 	if (unlikely(psmouse->packet[0] == PSMOUSE_RET_BAT && psmouse-
> >pktcnt <= 2)) {
> > > > 		if (psmouse->pktcnt == 1) {
> > > > 			psmouse->last = jiffies;
> > > > 			goto out;
> > > > 		}
> > > >
> > > > 		if (psmouse->packet[1] == PSMOUSE_RET_ID ||
> > > > 		    (psmouse->protocol->type == PSMOUSE_HGPK &&
> > > > 		     psmouse->packet[1] == PSMOUSE_RET_BAT)) {
> > > > 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
> > > > 			serio_reconnect(serio);
> > > > 			goto out;
> > > > 		}
> > > >
> > > > ...
> > > >
> > > > I am not sure where the "spurious ACK comes from". Can you enable i8042
> > > > debug before trying to dock and capture the data stream from the mouse?
> > > >
> > > > Thanks.
> > > >
> > >
> > > Hi Dmitry!
> > >
> > > I enabled unmask_kbd_data and debug and here is output from dmesg.
> > >
> > > echo Y > /sys/module/i8042/parameters/debug
> > > echo Y > /sys/module/i8042/parameters/unmask_kbd_data
> > >
> > > PS/2 keyboard is already connected in dock and laptop was just docked:
> > >
> > > [25461.552314] i8042: [6365474] fa <- i8042 (interrupt, 0, 1)
> > > [25461.552319] atkbd serio0: Spurious ACK on isa0060/serio0. Some program
> might be trying to access hardware directly.
> > > [25462.707296] i8042: [6365763] ed -> i8042 (kbd-data)
> > > [25462.851289] i8042: [6365799] fa <- i8042 (interrupt, 0, 1)
> > > [25462.851303] i8042: [6365799] 00 -> i8042 (kbd-data)
> > > [25462.858437] i8042: [6365801] fa <- i8042 (interrupt, 0, 1)
> > > [25462.869512] i8042: [6365804] fa <- i8042 (interrupt, 0, 1)
> > > [25462.869517] atkbd serio0: Spurious ACK on isa0060/serio0. Some program
> might be trying to access hardware directly.
> > > [25463.670515] i8042: [6366004] ed -> i8042 (kbd-data)
> > > [25463.670647] i8042: [6366004] fa <- i8042 (interrupt, 0, 1)
> > > [25463.670655] i8042: [6366004] 02 -> i8042 (kbd-data)
> > > [25463.676769] i8042: [6366005] fa <- i8042 (interrupt, 0, 1)
> > >
> > >
> > > Laptop is docked and PS/2 keyboard was just connected:
> > >
> > > [26571.014368] i8042: [6642848] fa <- i8042 (interrupt, 0, 1)
> > > [26571.014380] atkbd serio0: Spurious ACK on isa0060/serio0. Some program
> might be trying to access hardware directly.
> > >
> > >
> > > In both cases there is no events from touchpad, only from keyboard. So
> > > Dell EC silently reset PS/2 touchpad when PS/2 keyboard is attached.
> > >
> > > So I think we should capture 0xFA and on Dell machines we should
> > > reinitialize PS/2 drivers. As there is really nothing more then 0xFA.
> >
> > Info about PS/2 mouse:
> >
> > In case I have laptop already docked and just connect PS/2 mouse there
> > is absolutely no i8042 event.
> >
> > To check that mouse is worked I clicked button and then in dmesg
> > appeared:
> >
> > [ 3945.481403] i8042: [986322] 09 <- i8042 (interrupt, 1, 12)
> > [ 3945.482486] i8042: [986323] 00 <- i8042 (interrupt, 1, 12)
> > [ 3945.483667] i8042: [986323] 00 <- i8042 (interrupt, 1, 12)
> > [ 3945.483917] input: PS/2 ALPS Mouse as
> /devices/platform/i8042/serio1/input/input36
> > [ 3945.594926] i8042: [986351] 08 <- i8042 (interrupt, 1, 12)
> > [ 3945.596062] i8042: [986351] 00 <- i8042 (interrupt, 1, 12)
> > [ 3945.597203] i8042: [986351] 00 <- i8042 (interrupt, 1, 12)
> >
> > So we have no way to detect when external PS/2 mouse was connected to
> > dock. But ALPS driver can deal with it and process these mouse events.
> >
> > And when I have already connected PS/2 mouse to the dock and I'm just
> > putting laptop into dock, then I get following events:
> >
> > [ 4336.481381] i8042: [1084079] fa <- i8042 (interrupt, 0, 1)
> > [ 4336.481388] atkbd serio0: Spurious ACK on isa0060/serio0. Some program
> might be trying to access hardware directly.
> > [ 4337.653275] i8042: [1084372] ed -> i8042 (kbd-data)
> 
> I wonder where this "set leds" command is coming from and where is the
> parameter... Can you add some more tracing? And maybe boot with
> libps2.dyndbg=+pf
> 
> > [ 4337.949198] i8042: [1084446] fa <- i8042 (interrupt, 0, 1)
> > [ 4337.949202] atkbd serio0: Spurious ACK on isa0060/serio0. Some program
> might be trying to access hardware directly.
> > [ 4338.623167] i8042: [1084615] ed -> i8042 (kbd-data)
> >
> > So again, no event from mouse, just from keyboard.
> >
> > Note that in these tests I have disconnected my PS/2 keyboard from
> > dock.
> 
> So I guess you could write a platform driver that would install i8042
> filter on Dell laptops/portables, monitor keyboard data stream and kick
> of rescans on serio ports. The problem is filter gets "serio" so you do
> not really know whether ACK is spurious or not. And I would really
> prefer keeping this crap out of atkbd proper... And all of this is racy
> as hell. What happens if we get keyboard reconnected as we reinitialize
> it?

If it's done as a platform driver I would suspect it's possible to tell whether
a dock is connected to at least give you some heuristic here to have a better
guess whether it's spurious.

Pali on your system that supports this dock, check and see how many
System Enclosure SMBIOS tables (structure type 03) are present.
There should be a separate one for the dock as far as I can tell with values
that will vary based on whether it's attached.

Assuming that's true I think making a platform filter driver that only attaches
to systems that actually support this type of dock should be possible too.

> 
> Mario, how does Windows driver know when it should send "vendor"
> commands to reinitialize peripherals?
> 

Sorry , I don't know.  It's "inbox" Windows drivers that are used here so
it's a "black box" to me how they work.
