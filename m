Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeEGUHi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:07:38 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37358 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEGUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:07:37 -0400
X-Google-Smtp-Source: AB8JxZpqaizzMCQ4NcsVsGUQfpPcsBzZNZuFAm1OesT2bPUg+9/0+UmReLE8JMVeJ/LO62SIh+Fqwg==
Date: Mon, 7 May 2018 22:07:33 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devices
Message-ID: <20180507200733.s43zd2hfzw4f4wr2@pali>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
 <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
 <20180506134733.zttaitnf6ej4tith@pali>
 <20180507084431.r2dipv32wt3vbx3k@pali>
 <20180507193306.GA31301@dtor-ws>
 <147aa25ad2d14bad975731a6c9cf9281@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4hhbsk2pwuhj2jrv"
Content-Disposition: inline
In-Reply-To: <147aa25ad2d14bad975731a6c9cf9281@ausx13mpc124.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4hhbsk2pwuhj2jrv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 07 May 2018 19:59:14 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: Monday, May 7, 2018 2:33 PM
> > To: Pali Roh=C3=A1r
> > Cc: Limonciello, Mario; linux-input@vger.kernel.org; linux-kernel@vger.=
kernel.org
> > Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 dev=
ices
> >=20
> > On Mon, May 07, 2018 at 10:44:31AM +0200, Pali Roh=C3=A1r wrote:
> > > On Sunday 06 May 2018 15:47:33 Pali Roh=C3=A1r wrote:
> > > > On Thursday 01 February 2018 11:29:45 Dmitry Torokhov wrote:
> > > > > Hi Pali,
> > > > >
> > > > > On Wed, Jan 24, 2018 at 11:41:21AM +0100, Pali Roh=C3=A1r wrote:
> > > > > > Hi Dmitry!
> > > > > >
> > > > > > I'm observing a problem with internal touchpad (handled by psmo=
use.ko)
> > > > > > on Dell laptops connected to Dell E docking station. When I con=
nect
> > > > > > external PS/2 keyboard to docking station then internal laptop =
touchpad
> > > > > > switch from multitouch absolute mode to relative bare PS/2 mode.
> > > > > >
> > > > > > And because ALPS driver in psmouse.ko is capable to process int=
erleaved
> > > > > > bare 3-byte PS/2 packets with 6-byte ALPS packets (which handles
> > > > > > trackstick data on some ALPS models), ALPS driver does not show=
 any
> > > > > > message about this "downgrade" from multitouch to bare mode. And
> > > > > > continue working in bare mode.
> > > > > >
> > > > > > When I rmmod psmouse and modprobe it again, then touchpad switc=
h back
> > to
> > > > > > multitouch mode.
> > > > > >
> > > > > > Mario told me that Dell Embedded Controller, which handle inter=
nal
> > > > > > keyboard, internal touchpad and external PS/2 keyboard, automat=
ically
> > > > > > send RESET command to *all* those devices when external PS/2 ke=
yboard is
> > > > > > connected. Therefore this is reason why touchpad downgrade to t=
o bare
> > > > > > mode. And according to Mario, host system should issue vendor s=
pecific
> > > > > > PS/2 commands to re-initialize all PS/2 devices when this situa=
tion
> > > > > > happen. Mario also told me that Windows is doing this action.
> > > > >
> > > > > Yeah, I remember fun with Inspiron 8100 - when you dock it it wou=
dl
> > > > > silently switch Synaptics touchpad into standard mode and it woul=
d not
> > > > > come back as Synaptics until you disconnect. And there was no
> > > > > notification to the kernel as far as I could tell.
> > > > >
> > > > > It could be that we need to monitor dock events and then kick rec=
onnect
> > > > > of serio port, either from userspace via udev (I think that would=
 be
> > > > > preferred), or in kernel.
> > > > >
> > > > > >
> > > > > > Every time when I connect external PS/2 keyboard to dock I see =
this
> > > > > > message in dmesg:
> > > > > >
> > > > > > Spurious ACK... Some program might be trying to access hardware=
 directly.
> > > > > >
> > > > > > I see it also every time when I dock laptop into docking statio=
n (to
> > > > > > which is keyboard already connected). And it happens also when =
I connect
> > > > > > external PS/2 mouse to dock.
> > > > > >
> > > > > > Dmitry, how to handle this situation to re-initialize psmouse.k=
o when
> > > > > > external PS/2 device is connected to Dell E docking station? Ac=
cording
> > > > > > to Mario, this is how Dell Embedded Controller is designed and =
suppose
> > > > > > how OS should work with it.
> > > > > >
> > > > > > Manually rmmoding and modprobing for every docking/undocking la=
ptop is
> > > > > > not ideal solution.
> > > > > >
> > > > > > Could it be possible to use that Spurious ATKBD_RET_ACK from at=
kbd.c be
> > > > > > handled on Dell systems (probably via DMI) as an event to reset=
 and
> > > > > > reinitialize all PS/2 devices?
> > > > >
> > > > > So we need to figure out what exactly we are getting from the doc=
king
> > > > > station in this case. We do try to handle the new device 0xaa 0x00
> > > > > announcements:
> > > > >
> > > > > 	/* Check if this is a new device announcement (0xAA 0x00) */
> > > > > 	if (unlikely(psmouse->packet[0] =3D=3D PSMOUSE_RET_BAT && psmous=
e-
> > >pktcnt <=3D 2)) {
> > > > > 		if (psmouse->pktcnt =3D=3D 1) {
> > > > > 			psmouse->last =3D jiffies;
> > > > > 			goto out;
> > > > > 		}
> > > > >
> > > > > 		if (psmouse->packet[1] =3D=3D PSMOUSE_RET_ID ||
> > > > > 		    (psmouse->protocol->type =3D=3D PSMOUSE_HGPK &&
> > > > > 		     psmouse->packet[1] =3D=3D PSMOUSE_RET_BAT)) {
> > > > > 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
> > > > > 			serio_reconnect(serio);
> > > > > 			goto out;
> > > > > 		}
> > > > >
> > > > > ...
> > > > >
> > > > > I am not sure where the "spurious ACK comes from". Can you enable=
 i8042
> > > > > debug before trying to dock and capture the data stream from the =
mouse?
> > > > >
> > > > > Thanks.
> > > > >
> > > >
> > > > Hi Dmitry!
> > > >
> > > > I enabled unmask_kbd_data and debug and here is output from dmesg.
> > > >
> > > > echo Y >=C2=A0/sys/module/i8042/parameters/debug
> > > > echo Y > /sys/module/i8042/parameters/unmask_kbd_data
> > > >
> > > > PS/2 keyboard is already connected in dock and laptop was just dock=
ed:
> > > >
> > > > [25461.552314] i8042: [6365474] fa <- i8042 (interrupt, 0, 1)
> > > > [25461.552319] atkbd serio0: Spurious ACK on isa0060/serio0. Some p=
rogram
> > might be trying to access hardware directly.
> > > > [25462.707296] i8042: [6365763] ed -> i8042 (kbd-data)
> > > > [25462.851289] i8042: [6365799] fa <- i8042 (interrupt, 0, 1)
> > > > [25462.851303] i8042: [6365799] 00 -> i8042 (kbd-data)
> > > > [25462.858437] i8042: [6365801] fa <- i8042 (interrupt, 0, 1)
> > > > [25462.869512] i8042: [6365804] fa <- i8042 (interrupt, 0, 1)
> > > > [25462.869517] atkbd serio0: Spurious ACK on isa0060/serio0. Some p=
rogram
> > might be trying to access hardware directly.
> > > > [25463.670515] i8042: [6366004] ed -> i8042 (kbd-data)
> > > > [25463.670647] i8042: [6366004] fa <- i8042 (interrupt, 0, 1)
> > > > [25463.670655] i8042: [6366004] 02 -> i8042 (kbd-data)
> > > > [25463.676769] i8042: [6366005] fa <- i8042 (interrupt, 0, 1)
> > > >
> > > >
> > > > Laptop is docked and PS/2 keyboard was just connected:
> > > >
> > > > [26571.014368] i8042: [6642848] fa <- i8042 (interrupt, 0, 1)
> > > > [26571.014380] atkbd serio0: Spurious ACK on isa0060/serio0. Some p=
rogram
> > might be trying to access hardware directly.
> > > >
> > > >
> > > > In both cases there is no events from touchpad, only from keyboard.=
 So
> > > > Dell EC silently reset PS/2 touchpad when PS/2 keyboard is attached.
> > > >
> > > > So I think we should capture 0xFA and on Dell machines we should
> > > > reinitialize PS/2 drivers. As there is really nothing more then 0xF=
A.
> > >
> > > Info about PS/2 mouse:
> > >
> > > In case I have laptop already docked and just connect PS/2 mouse there
> > > is absolutely no i8042 event.
> > >
> > > To check that mouse is worked I clicked button and then in dmesg
> > > appeared:
> > >
> > > [ 3945.481403] i8042: [986322] 09 <- i8042 (interrupt, 1, 12)
> > > [ 3945.482486] i8042: [986323] 00 <- i8042 (interrupt, 1, 12)
> > > [ 3945.483667] i8042: [986323] 00 <- i8042 (interrupt, 1, 12)
> > > [ 3945.483917] input: PS/2 ALPS Mouse as
> > /devices/platform/i8042/serio1/input/input36
> > > [ 3945.594926] i8042: [986351] 08 <- i8042 (interrupt, 1, 12)
> > > [ 3945.596062] i8042: [986351] 00 <- i8042 (interrupt, 1, 12)
> > > [ 3945.597203] i8042: [986351] 00 <- i8042 (interrupt, 1, 12)
> > >
> > > So we have no way to detect when external PS/2 mouse was connected to
> > > dock. But ALPS driver can deal with it and process these mouse events.
> > >
> > > And when I have already connected PS/2 mouse to the dock and I'm just
> > > putting laptop into dock, then I get following events:
> > >
> > > [ 4336.481381] i8042: [1084079] fa <- i8042 (interrupt, 0, 1)
> > > [ 4336.481388] atkbd serio0: Spurious ACK on isa0060/serio0. Some pro=
gram
> > might be trying to access hardware directly.
> > > [ 4337.653275] i8042: [1084372] ed -> i8042 (kbd-data)
> >=20
> > I wonder where this "set leds" command is coming from and where is the
> > parameter... Can you add some more tracing? And maybe boot with
> > libps2.dyndbg=3D+pf
> >=20
> > > [ 4337.949198] i8042: [1084446] fa <- i8042 (interrupt, 0, 1)
> > > [ 4337.949202] atkbd serio0: Spurious ACK on isa0060/serio0. Some pro=
gram
> > might be trying to access hardware directly.
> > > [ 4338.623167] i8042: [1084615] ed -> i8042 (kbd-data)
> > >
> > > So again, no event from mouse, just from keyboard.
> > >
> > > Note that in these tests I have disconnected my PS/2 keyboard from
> > > dock.
> >=20
> > So I guess you could write a platform driver that would install i8042
> > filter on Dell laptops/portables, monitor keyboard data stream and kick
> > of rescans on serio ports. The problem is filter gets "serio" so you do
> > not really know whether ACK is spurious or not. And I would really
> > prefer keeping this crap out of atkbd proper... And all of this is racy
> > as hell. What happens if we get keyboard reconnected as we reinitialize
> > it?
>=20
> If it's done as a platform driver I would suspect it's possible to tell w=
hether
> a dock is connected to at least give you some heuristic here to have a be=
tter
> guess whether it's spurious.

Apparently checking for docking station is not enough. There are also
Dell Legacy Extenders (or how it is called) which exports internal PS/2,
Parallel and Serial Ports. It is also connecting to bottom of laptop.
But currently I do not have them for testing.

> Pali on your system that supports this dock, check and see how many
> System Enclosure SMBIOS tables (structure type 03) are present.

Do you mean DMI type 3 structure? Here is something from dmidecode:

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
        Manufacturer: Dell Inc.
        Type: Laptop
        Lock: Not Present
        Version: Not Specified
        Serial Number: --REMOVED--
        Asset Tag: Not Specified
        Boot-up State: Safe
        Power Supply State: Safe
        Thermal State: Safe
        Security Status: None
        OEM Information: 0x00000000
        Height: Unspecified
        Number Of Power Cords: 1
        Contained Elements: 0
        SKU Number: To be filled by O.E.M.

But probably you mean something different?

> There should be a separate one for the dock as far as I can tell with val=
ues
> that will vary based on whether it's attached.
>=20
> Assuming that's true I think making a platform filter driver that only at=
taches
> to systems that actually support this type of dock should be possible too.
>=20
> >=20
> > Mario, how does Windows driver know when it should send "vendor"
> > commands to reinitialize peripherals?
> >=20
>=20
> Sorry , I don't know.  It's "inbox" Windows drivers that are used here so
> it's a "black box" to me how they work.
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--4hhbsk2pwuhj2jrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWvCyAwAKCRCL8Mk9A+RD
UjCBAKCnmxdqGVPxB3EtFe1gsVwVw/xIqQCfRv9968XE7T1Sfw4DzHURy0999wk=
=Lu0o
-----END PGP SIGNATURE-----

--4hhbsk2pwuhj2jrv--
