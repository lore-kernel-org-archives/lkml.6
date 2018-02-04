Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeBDUIH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 15:08:07 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38073 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeBDUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 15:08:01 -0500
X-Google-Smtp-Source: AH8x225kvLrMuN9UcC4pz14v2qRdLFBpgo61t8TnpCs0cNDxXSKOm9SPI9+fdzMn0ykJ3UHbh4EI9A==
Date: Sun, 4 Feb 2018 21:07:57 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 devices
Message-ID: <20180204200757.kt5awlysvbbthlep@pali>
References: <20180124104121.7g3zfay5smc5v2tc@pali>
 <20180201192945.wrsqjq7f5ejhqj6m@dtor-ws>
 <bb5156667d084d77841f7078d373a265@ausx13mpc120.AMER.DELL.COM>
 <CAKdAkRS_TjTi-VxGg59+aw8wQZxrx8YBAF+m9MdknYNdKGyrvQ@mail.gmail.com>
 <ffe4f35a6570401083d7032e261daa20@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t7ychuym3ussoodl"
Content-Disposition: inline
In-Reply-To: <ffe4f35a6570401083d7032e261daa20@ausx13mpc120.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7ychuym3ussoodl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 01 February 2018 21:23:40 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: Thursday, February 1, 2018 3:14 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>; linux-input@vger.kernel.org=
; lkml <linux-
> > kernel@vger.kernel.org>
> > Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 dev=
ices
> >=20
> > On Thu, Feb 1, 2018 at 11:35 AM,  <Mario.Limonciello@dell.com> wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > >> Sent: Thursday, February 1, 2018 1:30 PM
> > >> To: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > >> Cc: Limonciello, Mario <Mario_Limonciello@Dell.com>; linux-
> > >> input@vger.kernel.org; linux-kernel@vger.kernel.org
> > >> Subject: Re: Dell docking station & Dell Embedded Controller & PS/2 =
devices
> > >>
> > >> Hi Pali,
> > >>
> > >> On Wed, Jan 24, 2018 at 11:41:21AM +0100, Pali Roh=C3=A1r wrote:
> > >> > Hi Dmitry!
> > >> >
> > >> > I'm observing a problem with internal touchpad (handled by psmouse=
=2Eko)
> > >> > on Dell laptops connected to Dell E docking station. When I connect
> > >> > external PS/2 keyboard to docking station then internal laptop tou=
chpad
> > >> > switch from multitouch absolute mode to relative bare PS/2 mode.
> > >> >
> > >> > And because ALPS driver in psmouse.ko is capable to process interl=
eaved
> > >> > bare 3-byte PS/2 packets with 6-byte ALPS packets (which handles
> > >> > trackstick data on some ALPS models), ALPS driver does not show any
> > >> > message about this "downgrade" from multitouch to bare mode. And
> > >> > continue working in bare mode.
> > >> >
> > >> > When I rmmod psmouse and modprobe it again, then touchpad switch b=
ack to
> > >> > multitouch mode.
> > >> >
> > >> > Mario told me that Dell Embedded Controller, which handle internal
> > >> > keyboard, internal touchpad and external PS/2 keyboard, automatica=
lly
> > >> > send RESET command to *all* those devices when external PS/2 keybo=
ard is
> > >> > connected. Therefore this is reason why touchpad downgrade to to b=
are
> > >> > mode. And according to Mario, host system should issue vendor spec=
ific
> > >> > PS/2 commands to re-initialize all PS/2 devices when this situation
> > >> > happen. Mario also told me that Windows is doing this action.
> > >>
> > >> Yeah, I remember fun with Inspiron 8100 - when you dock it it woudl
> > >> silently switch Synaptics touchpad into standard mode and it would n=
ot
> > >> come back as Synaptics until you disconnect. And there was no
> > >> notification to the kernel as far as I could tell.
> > >>
> > >> It could be that we need to monitor dock events and then kick reconn=
ect
> > >> of serio port, either from userspace via udev (I think that would be
> > >> preferred), or in kernel.
> > >>
> > >> >
> > >> > Every time when I connect external PS/2 keyboard to dock I see this
> > >> > message in dmesg:
> > >> >
> > >> > Spurious ACK... Some program might be trying to access hardware di=
rectly.
> > >> >
> > >> > I see it also every time when I dock laptop into docking station (=
to
> > >> > which is keyboard already connected). And it happens also when I c=
onnect
> > >> > external PS/2 mouse to dock.
> > >> >
> > >> > Dmitry, how to handle this situation to re-initialize psmouse.ko w=
hen
> > >> > external PS/2 device is connected to Dell E docking station? Accor=
ding
> > >> > to Mario, this is how Dell Embedded Controller is designed and sup=
pose
> > >> > how OS should work with it.
> > >> >
> > >> > Manually rmmoding and modprobing for every docking/undocking lapto=
p is
> > >> > not ideal solution.
> > >> >
> > >> > Could it be possible to use that Spurious ATKBD_RET_ACK from atkbd=
=2Ec be
> > >> > handled on Dell systems (probably via DMI) as an event to reset and
> > >> > reinitialize all PS/2 devices?
> > >>
> > >> So we need to figure out what exactly we are getting from the docking
> > >> station in this case. We do try to handle the new device 0xaa 0x00
> > >> announcements:
> > >
> > > Docking station itself won't have sent any events.  The PS2 ports in =
it
> > > are electrically wired to the external PS2 pins in the docking adapte=
r on
> > > the system.
> > >
> > > System EC is what will be sending any PS2 events.
> >=20
> > OK, it does not matter from the input layer POW, if they are PS/2
> > events they should be coming from i8042.

Dell EC sends reset to touchpad, not to kernel.

> > >
> > >>
> > >>       /* Check if this is a new device announcement (0xAA 0x00) */
> > >>       if (unlikely(psmouse->packet[0] =3D=3D PSMOUSE_RET_BAT && psmo=
use-
> > >> >pktcnt <=3D 2)) {
> > >>               if (psmouse->pktcnt =3D=3D 1) {
> > >>                       psmouse->last =3D jiffies;
> > >>                       goto out;
> > >>               }
> > >>
> > >>               if (psmouse->packet[1] =3D=3D PSMOUSE_RET_ID ||
> > >>                   (psmouse->protocol->type =3D=3D PSMOUSE_HGPK &&
> > >>                    psmouse->packet[1] =3D=3D PSMOUSE_RET_BAT)) {
> > >>                       __psmouse_set_state(psmouse, PSMOUSE_IGNORE);
> > >>                       serio_reconnect(serio);
> > >>                       goto out;
> > >>               }
> > >>
> > >> ...
> > >>
> > >> I am not sure where the "spurious ACK comes from". Can you enable i8=
042
> > >> debug before trying to dock and capture the data stream from the mou=
se?
> > >>
> > >
> > > The system EC has reset PS2 devices (but AFAIK kernel won't have seen=
 this
> > > communication).
> >=20
> > So what kind of communication does EC send when docking? It sounds it
> > is completely out of band from PS/2 connection.
>=20
> Yes it's out of band from PS/2 connection OS sees.  However as Pali has=
=20
> mentioned this issue will happen even if already docked but you plug in
> PS/2 keyboard.
>=20
> It will probably be clearer to you what OS has seen from this when Pali
> shares the captured data stream.

Currently I'm not near my docking station, so cannot do testing.

But in logs I can dig these lines which appeared every time after
putting notebook into dock (which has PS/2 keyboard connected):

kernel: [20127.033965] atkbd serio0: Spurious ACK on isa0060/serio0. Some p=
rogram might be trying to access hardware directly.
kernel: [20127.076030] acpi PNP0401:00: Already enumerated
kernel: [20127.083088] acpi PNP0501:00: Still not present
kernel: [20127.087042] acpi device:41: Cannot transition to power state D3h=
ot for parent in (unknown)

And sometimes after 1-5s I see Spurious event again:

kernel: [20128.325569] atkbd serio0: Spurious ACK on isa0060/serio0. Some p=
rogram might be trying to access hardware directly.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--t7ychuym3ussoodl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWndoGQAKCRCL8Mk9A+RD
UgFlAJ4n0AZpq2JpBeSawLnaKepLMK2NtwCgufXAVOhQd83obQ2+oPixXkC233o=
=z8NN
-----END PGP SIGNATURE-----

--t7ychuym3ussoodl--
