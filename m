Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbeCUQlk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:41:40 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54774 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbeCUQlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:41:31 -0400
X-Google-Smtp-Source: AG47ELvKBWZm7VDNd62fC/+HMa/N4E94jEvhUY01seJNA5sQv/Xn1JFrJMFBUJUi0kMVGlQdsBj05A==
Date: Wed, 21 Mar 2018 17:41:26 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Masaki Ota <masaki.ota@jp.alps.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization for v3
 and v6 protocols
Message-ID: <20180321164126.fr4srexf5pxz4pud@pali>
References: <20180312230915.26050-1-pali.rohar@gmail.com>
 <20180312231335.fnfxgenu22utr3z6@pali>
 <TYXPR01MB0719092EDE164BA6C576A1C7C7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180314225816.634w64kggycj67ec@pali>
 <TYXPR01MB07191C487C66BA03E5D9AB3DC7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180316105811.t2nkwowqs66f6ji6@pali>
 <TYXPR01MB0719CA528857480EC046DEF6C7D40@TYXPR01MB0719.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ou7kqgnkeluwkzru"
Content-Disposition: inline
In-Reply-To: <TYXPR01MB0719CA528857480EC046DEF6C7D40@TYXPR01MB0719.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ou7kqgnkeluwkzru
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

That is pity, but OK.

Anyway, as wrote patch which I sent in the first email matches this
documentation.

Dmitry, can you review/comment/accept/reject this patch?

On Monday 19 March 2018 08:41:19 Masaki Ota wrote:
> Hi, Pali,
>=20
> v3/v6 devices are T3 type, and it can use only Method 2.
> P36 (At this time GLIDEPOINT_T3 uses the Method 2 ....)
> T3 has the potential that uses Method2, but I think it needs to change Fi=
rmware.
>=20
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]=20
> Sent: Friday, March 16, 2018 7:58 PM
> To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alps.=
com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-input@vger.kernel.=
org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization fo=
r v3 and v6 protocols
>=20
> Great, thank you. Enabling that RAW/extended/SP4 mode is done by sequence=
 E6, E6, E6, F3, C8, F3, 14 (written in page 35) and it matches what functi=
on alps_trackstick_enter_extended_mode_v3_v6() in my patch is doing. So is =
correct.
>=20
> On page 36 I see that there is described Method 1 for reporting stick dat=
a which prevents cursor jumps. Seems that kernel uses Method 2.
> Method 1 depends on some prioritization.
>=20
> Do you have some information how to activate Method 1? Sometimes I observ=
e that problem with "cursor jumps" and from Method 1 could prevent it. So I=
 would like to try experimenting...
>=20
> On Wednesday 14 March 2018 23:56:46 Masaki Ota wrote:
> > Hi, Pali,
> >=20
> > I have added Appendix.
> > According to this spec documents, SP raw mode is SP 4 byte mode.
> > I think Extended mode meaning is almost all the same as Raw mode.
> > The description of how to set is written in Page 35.
> >=20
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > Sent: Thursday, March 15, 2018 7:58 AM
> > To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.alp=
s.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>;=20
> > linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization=
=20
> > for v3 and v6 protocols
> >=20
> > Hi! Thank you for information.
> >=20
> > Your PS/2 Aux Port Control description seems to really matches. Just th=
ere is reverse order of bits. Bit 0 in description is highest, therefore ma=
tches BIT(7) macro.
> >=20
> > Bit 6 in description (BIT(1) in code) describes SP Extended Mode which =
alps.c enabled. And in that description is written:
> >=20
> > "If 1 SP is extended packet format (driver must set SP raw mode and GP =
absolute mode)."
> >=20
> > Do you have any idea what "SP raw mode" is? How to set it? For me it lo=
oks like it could be that extended mode of trackstick itself.
> >=20
> > "GP absolute mode" I guess is GlidePoint absolute mode, therefore=20
> > enable
> > 6 byte absolute mode for touchpad.
> >=20
> > And for Bit 7 (BIT(0)) is written:
> >=20
> > This bit is used with the PS/2 Aux port to use the Pass-Thru mode ( see=
 appendix A ). Do you have some information about this appendix A?
> >=20
> > On Wednesday 14 March 2018 10:21:43 Masaki Ota wrote:
> > > Hi, Pali,
> > >=20
> > > I just picked up the spec which relates with trackstic.
> > >=20
> > > Best Regards,
> > > Masaki Ota
> > > -----Original Message-----
> > > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > > Sent: Tuesday, March 13, 2018 8:14 AM
> > > To: =E5=A4=AA=E7=94=B0 =E7=9C=9F=E5=96=9C Masaki Ota <masaki.ota@jp.a=
lps.com>; Dmitry Torokhov=20
> > > <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] Input: alps - Demystify trackstick=20
> > > initialization for v3 and v6 protocols
> > >=20
> > > Masaki, if you have access to the internal ALPS v3 / Rushmore=20
> > > documentation, I would like to have a review of this patch or=20
> > > confirmation of those information :-)
> >=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com
>=20
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ou7kqgnkeluwkzru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWrKLNAAKCRCL8Mk9A+RD
UhgCAKCbKZp3UgS0Xpk3CLcOHoAsGE8ccwCfdF7CCsOb7PR925/fc903vKxqu6w=
=SJFN
-----END PGP SIGNATURE-----

--ou7kqgnkeluwkzru--
