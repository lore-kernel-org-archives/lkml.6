Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDEMUz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 08:20:55 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43450 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbeDEMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 08:20:54 -0400
Date: Thu, 5 Apr 2018 15:20:52 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi: fix asm/bootparam.h userspace compilation errors
Message-ID: <20180405122051.GA18727@altlinux.org>
Mail-Followup-To: Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20180405043210.GA13254@altlinux.org>
 <32e449e9-5738-d347-20ad-50ee4a2257e2@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <32e449e9-5738-d347-20ad-50ee4a2257e2@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 09:25:26AM +0200, Jan Kiszka wrote:
> On 2018-04-05 06:32, Dmitry V. Levin wrote:
> > Consistently use types provided by <linux/types.h> to fix the following
> > asm/bootparam.h userspace compilation errors:
> >=20
> > /usr/include/asm/bootparam.h:140:2: error: unknown type name 'u16'
> >   u16 version;
> > /usr/include/asm/bootparam.h:141:2: error: unknown type name 'u16'
> >   u16 compatible_version;
> > /usr/include/asm/bootparam.h:142:2: error: unknown type name 'u16'
> >   u16 pm_timer_address;
> > /usr/include/asm/bootparam.h:143:2: error: unknown type name 'u16'
> >   u16 num_cpus;
> > /usr/include/asm/bootparam.h:144:2: error: unknown type name 'u64'
> >   u64 pci_mmconfig_base;
> > /usr/include/asm/bootparam.h:145:2: error: unknown type name 'u32'
> >   u32 tsc_khz;
> > /usr/include/asm/bootparam.h:146:2: error: unknown type name 'u32'
> >   u32 apic_khz;
> > /usr/include/asm/bootparam.h:147:2: error: unknown type name 'u8'
> >   u8 standard_ioapic;
> > /usr/include/asm/bootparam.h:148:2: error: unknown type name 'u8'
> >   u8 cpu_ids[255];
> >=20
> > Fixes: 4a362601baa6 ("x86/jailhouse: Add infrastructure for running in =
non-root cell")
> > Cc: <stable@vger.kernel.org> # v4.16
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  arch/x86/include/uapi/asm/bootparam.h | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/u=
api/asm/bootparam.h
> > index aebf60357758..a06cbf019744 100644
> > --- a/arch/x86/include/uapi/asm/bootparam.h
> > +++ b/arch/x86/include/uapi/asm/bootparam.h
> > @@ -137,15 +137,15 @@ struct boot_e820_entry {
> >   * setup data structure.
> >   */
> >  struct jailhouse_setup_data {
> > -	u16	version;
> > -	u16	compatible_version;
> > -	u16	pm_timer_address;
> > -	u16	num_cpus;
> > -	u64	pci_mmconfig_base;
> > -	u32	tsc_khz;
> > -	u32	apic_khz;
> > -	u8	standard_ioapic;
> > -	u8	cpu_ids[255];
> > +	__u16	version;
> > +	__u16	compatible_version;
> > +	__u16	pm_timer_address;
> > +	__u16	num_cpus;
> > +	__u64	pci_mmconfig_base;
> > +	__u32	tsc_khz;
> > +	__u32	apic_khz;
> > +	__u8	standard_ioapic;
> > +	__u8	cpu_ids[255];
> >  } __attribute__((packed));
> > =20
> >  /* The so-called "zeropage" */
> >=20
>=20
> Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> But how did you trigger this?

Our equivalent of glibc-kernheaders package contains a test
for regressions of this kind.


--=20
ldv

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaxhSjAAoJEAVFT+BVnCUIctMP/Aq1Y4r7ry5c187hv4HWZctI
oRJTkhcms1PHDrTUNlq8T3Smhsr1Weq4ZU4Lr8frVHgX4UyPi3O8SN+7RT5u5+WE
r13a8kQbo/iEUgy4Bd8C8HzBdPa8B6ZthUK0FGEY2Kddr/7kVtFn8mh1UB3cOpnM
xR/sLND5uskYGXedNuu/NdvONiWGY3R/eAeb0K/L3D97QWMHwleKnMag98/JEweo
0M+dmauZa5NInTgufmxXJy+qfHeHq9zyZ5j26T2cvxzeBg70d4AWg8rnI6OKqlJ/
P9duX8+6KVkGPzf8Z2H+OoKivaQvxEXfmqmmPwMY6HbxVIBHvLLsUJv+NPnWcVnS
I4xqaNsi4LXA9k0le5WPm7E4gDj2wjtbZWS3LTjz9A2nZMs4oA9vwTW9h7kV2xps
mU65A1bi9LD9KktYYNxlBO+Xf5DKqaRKMQEJ9gzlanqhvQaj6XVc09/3CGad+Kcm
wLCJJDAh79uPoq5DNI6V4hOvg32JATIjzIfNgR/WzYVWOpndFmfsCJ+1gsXtaLMA
avZasoiURLFBp/qg8QjVxkWEFQwIzYuvKdrvonD42DLiYir8e+Q6BtD2URpXJgFE
NxM4eFIOYNQDWoTEtIohC2lAADirjOdwpIdZSICG15PVLRXRgrfu+DipkgfORnAf
D4U3tHKCOyQ2gyCxPMSp
=xcvP
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
