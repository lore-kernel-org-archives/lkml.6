Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161518AbeBNRlx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:41:53 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:23656 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161418AbeBNRls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:41:48 -0500
Date: Wed, 14 Feb 2018 18:41:26 +0100
From: Pierre Moreau <pmoreau@pmoreau.org>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Lyude Paul <lyude@redhat.com>, Meelis Roos <mroos@linux.ee>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Nouveau] 4.16-rc1: UBSAN warning in
 nouveau/nvkm/subdev/therm/base.c + oops in nvkm_therm_clkgate_fini
Message-ID: <20180214174125.b5bdowaadck3vf5n@pmoreau.org>
Mail-Followup-To: Ilia Mirkin <imirkin@alum.mit.edu>,
        Lyude Paul <lyude@redhat.com>, Meelis Roos <mroos@linux.ee>,
        nouveau <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
References: <alpine.LRH.2.21.1802132200260.24929@math.ut.ee>
 <alpine.LRH.2.21.1802141628110.25362@math.ut.ee>
 <CAKb7Uvj3MKGzNNcrc=-JA5GN4jt9+TU7ZjWDZpccmYJLDo76WQ@mail.gmail.com>
 <CAKb7UvhRt=25J5aOUZusdE51hh1JVc45aQ8OhCVeOJwzYvLOJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dwdkp45xn3dm5qq2"
Content-Disposition: inline
In-Reply-To: <CAKb7UvhRt=25J5aOUZusdE51hh1JVc45aQ8OhCVeOJwzYvLOJw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dwdkp45xn3dm5qq2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-02-14 =E2=80=94 09:36, Ilia Mirkin wrote:
> On Wed, Feb 14, 2018 at 9:35 AM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> > On Wed, Feb 14, 2018 at 9:29 AM, Meelis Roos <mroos@linux.ee> wrote:
> >>> This is 4.16-rc1+todays git on a lowly P4 with NV5, worked fine in 4.=
15:
> >>
> >> NV5 in another PC (secondary card in x86-64) made the systrem crash on
> >> boot, in nvkm_therm_clkgate_fini.
> >
> > Mind booting with nouveau.debug=3Dtrace? That should hopefully tell us
> > more exactly which thing is dying. If you have a cross-compile/distcc
> > setup handy, a bisect may be even more useful.
>=20
> Erm, sorry, nevermind. You even said it -- nvkm_therm_clkgate_fini is
> somehow mis-hooked up for NV5 now. A bisect result would still make
> the culprit a lot more obvious.

CC=E2=80=99ing Lyude Paul as she hooked up the clockgating support.

Looking at the code, only NV40+ do have a therm engine. Therefore, shouldn=
=E2=80=99t
nvkm_therm_clkgate_enable(), nvkm_therm_clkgate_fini() and
nvkm_therm_clkgate_oneinit() all check for therm being not NULL, on top of
their check for the clkgate_* hooks being there? Or instead, maybe have the
check in nvkm_device_init() nvkm_device_init()?

Pierre

--dwdkp45xn3dm5qq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEuCp/qmebDh5BvKefO2dY27124hoFAlqEdMEACgkQO2dY2712
4hqonA//XCWbLxa9FkJGpe5m0xPTHQTMjIhlr7G06cvIzCFj+QYjCiNPZAF1RM5L
wZ5UlJktHSU9m8mCZTebRskJLe89B/1szrPmZjE2EugpnQQjJF0Ae65icZaTvx6p
n6JCpQz3+Jrg8MY1d5n5dGvWodPhbiVu8Z12ScTqr2rSbOcL5fNubk7JSOY7xlI6
yi1DKAL9aM88ojJRXX5mAV1pfrqw4cWv3xcQtdzQ8E1ePyHoMsPEafemCv0kMy2F
cPaKAzA8ok5RULR5zLAXhIFlMiJxVjkjhOKVrdZoC0UdocRwcRpZkUljWOCbe7kn
j1nik54MGuw6tBx3xpQBLB/FWAaMi50eNWZ96H7MMEhV8GFLppN8k0v1xKse2vmx
TqHCQCkFHSqNvocT3aXPTfCrOmwog192B5V4kQS84j/Auf2xEO8UmKH9euxGzZgt
RF4goFzudrbNH1oIyYRA0lLOraeBr+k3eoK2ZTaJprBgjCGu1VoRsguu8acz1qUU
rFGqXNs46GmSZb3CkCV1i4j/yMc0ycqPQVcthWxVHeJ3SwkgscpdLzGFaNj+wdA9
ISijMV873PZmFt0/BU1RxCkdW2QA3nNP92XhXjehezHJksGTKW6O7gYo5smKGauC
BEo9DmqpTsmjTVCGK8lQQM4zGWj+G4jbXLSRDYolf7FKt3Tm0mg=
=sYjh
-----END PGP SIGNATURE-----

--dwdkp45xn3dm5qq2--
