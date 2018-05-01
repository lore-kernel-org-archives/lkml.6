Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbeEALAI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 07:00:08 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36031 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEALAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 07:00:06 -0400
X-Google-Smtp-Source: AB8JxZpnBYgOuh9F1M6PeaRLO+83fA2gc1855Ya/baBZEFF0uTe2okcBnVtbYAeIYtQhH0wcsq16Tg==
Date: Tue, 1 May 2018 13:00:03 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        qwrd <mistave@countermail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Dell WMI Hotkeys on Dell Inspiron 15R SE (7520)
Message-ID: <20180501110003.dhsbdvc6cv32lvt7@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="exw4cmo2br4o27ou"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--exw4cmo2br4o27ou
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Mistave contacted me, because he has Dell Inspiron 15R SE (7520) on
which are not working 3 hotkeys located in the right upper corner.

After debugging we find out that this Dell Inspirion sends following WMI
event to dell-wmi.c driver:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------
Left WMI key: Windows Mobility Center
Press:    Key with type 0x0000 and code 0xe026 pressed
Hold:     -
Release:  -

Only the press event was observed. It does not repeat when held down.

----------------------------------------
Middle WMI key: Dell Audio With Preset Switch
Press:    Key with type 0x0000 and code 0xe02a pressed
Hold:     Key with type 0x0000 and code 0xe02b pressed
          (code 0xe02a also repeats continuously)
Release:  Key with type 0x0000 and code 0xe02c pressed

Code 0xe02a repeats, if button is held down. After about 3 seconds a
single code 0xe02b entry will also appear. When released before the code
0xe02b pops up, the code 0xe02c will appear. If released afterwards,
code 0xe02c does not appear.

----------------------------------------
Right WMI key: Dell Instant Launch
Press:    -
Hold:     Key with type 0x0000 and code 0xe025 pressed
Release:  Key with type 0x0000 and code 0xe024 pressed

Code 0xe024 only appears, if the button is released within about 3
seconds. If held down for longer, a single code 0xe025 will appear. If
released after the code 0xe025 appears, the code 0xe024 will not appear.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Such hold and release events in 3sec time period are strange and I'm not
sure how we should handle them. Any idea?

Also there is another problem. Driver dell-wmi.c ignores 0xe025 events
because on all other machines it is reported also by PS/2 internal
keyboard. But seems not on this Dell Inspirion. How to handle this fact?
Add a new quirk into dell-wmi.c code?

Mario, do you have a documentation or something which can prove above
observation that keys are really reported via such strange WMI events?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--exw4cmo2br4o27ou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWuhIqgAKCRCL8Mk9A+RD
UuO4AKDHpEp452VtkxjyxV1hFtcgfnQuTACgiyp6eBn22GJSg39v+del43QqoMY=
=v5Vs
-----END PGP SIGNATURE-----

--exw4cmo2br4o27ou--
