Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934774AbeBMQu3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:50:29 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34040 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934514AbeBMQu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:50:27 -0500
X-Google-Smtp-Source: AH8x225CslJRAsfRowJ5YGJyfltAY8oR+7uedpp3rAlDZ0AHiI9t+0TzpgrGXthfuVT4dZBJV2wdqg==
Date: Tue, 13 Feb 2018 17:50:23 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Steven Honeyman <stevenhoneyman@gmail.com>,
        Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Jochen Eisinger <jochen@penguin-breeder.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mario Limonciello <Mario_Limonciello@dell.com>,
        Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Message-ID: <20180213165023.xmzovx7fd3gdljxw@pali>
References: <20180127133209.28995-1-pali.rohar@gmail.com>
 <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
 <20180128144509.pobnj7cayc4psgrj@pali>
 <CAHp75VdU1OMTqLcDuzhQMHuX9rMhjw6p3CkSWaW5Y4kOy8ggqg@mail.gmail.com>
 <20180131120348.azy25aqvn5wrdkeh@pali>
 <CAHp75Vf=-RQvCtS684Q5+X=YKmZXgP_1kr0to8BGZX0jQAsuZw@mail.gmail.com>
 <20180212153012.vffvjmz26ifyxbj5@pali>
 <CAHp75VfF+qwCXcr3yuayE-Z+UG9wuMOKfGzLhdyPk79daEi9gQ@mail.gmail.com>
 <20180213150004.5d2v7y7wwuure4io@pali>
 <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sby3f4udqueoitq4"
Content-Disposition: inline
In-Reply-To: <CAHp75VfxgbFiDxyrqyMRE8s85L1_EzkVvrA1NGYA5_su=5oGVQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sby3f4udqueoitq4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 13 February 2018 17:06:19 Andy Shevchenko wrote:
> On Tue, Feb 13, 2018 at 5:00 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > On Tuesday 13 February 2018 16:55:00 Andy Shevchenko wrote:
> >> On Mon, Feb 12, 2018 at 5:30 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> >> > On Wednesday 31 January 2018 14:27:51 Andy Shevchenko wrote:
> >> >> On Wed, Jan 31, 2018 at 2:03 PM, Pali Roh=C3=A1r <pali.rohar@gmail.=
com> wrote:
> >> >> > On Sunday 28 January 2018 17:00:35 Andy Shevchenko wrote:
> >> >> >> On Sun, Jan 28, 2018 at 4:45 PM, Pali Roh=C3=A1r <pali.rohar@gma=
il.com> wrote:
> >> >>
> >> >> >> > ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_p=
resent
> >> >> >> > function match only prefix and not exact string?
> >> >> >>
> >> >> >> OK, fair enough.
> >> >> >>
> >> >> >> Do we have more users of such pattern?
> >> >> >
> >> >> > I have not seen this ACPI pattern yet, so probably not.
> >> >>
> >> >> I see. So, my  one concern is the implicit names of the devices. I
> >> >> would like rather to see
> >> >>
> >> >> ... acpi_device_id ... []=3D {
> >> >>  {"SMO8800"},
> >> >>  {"SMO8810"},
> >> >> ...
> >> >> {}
> >> >> };
> >> >
> >> > Following table already exists in dell-smo8800.c file:
> >> >
> >> > static const struct acpi_device_id smo8800_ids[] =3D {
> >> >         { "SMO8800", 0 },
> >> >         { "SMO8801", 0 },
> >> >         { "SMO8810", 0 },
> >> >         { "SMO8811", 0 },
> >> >         { "SMO8820", 0 },
> >> >         { "SMO8821", 0 },
> >> >         { "SMO8830", 0 },
> >> >         { "SMO8831", 0 },
> >> >         { "", 0 },
> >> > };
> >> >
> >> > MODULE_DEVICE_TABLE(acpi, smo8800_ids);
> >> >
> >> > Can we reuse it?
> >>
> >> >  Maybe moving array smo8800_ids[] into some header file
> >> > (which one?) and statically inline it?
> >>
> >> Bad idea.
> >>
> >> > Or having it only in
> >> > dell-smo8800.c file and exporting its symbol?
> >>
> >> Even worse.
> >>
> >> > Or is there better idea?
> >> >
> >> > For sure I do not want to copy paste this table into another module =
and
> >> > maintaining two copies of this list.
> >>
> >> The copy is fine. Can you guarantee that those two lists would be
> >> always the same? I'm not.
> >
> > Me neither.
> >
> >> And besides that explicitly over implicitly  is a really good thing. I
> >> would not like to grep for an ID followed by grepping include line and
> >> check each files to check if it uses it or not.
> >
> > So what do you suggest now?
>=20
> Copy'n'paste and maintain two lists.
> Yes, it's not the ideal, but working solution.
>=20
> You may put a comment before each list to explain what the second does
> and tell a contributor to look at it and update if needed.

I'm not maintainer of i2c-i801.ko, Jean Delvare & Wolfram Sang are.
Therefore instructing future contributors would be up to them.

Jean, it is OK?

> > Having one file where it would be defined is a bad idea for you.
>=20
> Not just "one file", but "one *header* file". Or "exporting a symbol"
> which is basically not supposed to be exported.
> ID tables are part of the actual drivers, neither headers, nor libraries.

But this is exactly what is needed. This ACPI ID table contains ACPI
names which says if accelerometer is present or not.

> > And maintaining copy of same array in two different files in two
> > different subsystems is something which I cannot guarantee.
> >
> > Therefore the current patch is the best approach.
>=20
> I don't like it. I'll not take it, sorry.
>=20
> > No shared file with
> > shared array/table and also no copy of that array in two different
> > subsystems.
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--sby3f4udqueoitq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWoMXTAAKCRCL8Mk9A+RD
Um+FAJwNzfwBpTDvW4yvPauznhYCOibZMQCgxRwsy/4m14+zLcmgLl0D/2ykWNM=
=LQC0
-----END PGP SIGNATURE-----

--sby3f4udqueoitq4--
