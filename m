Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753560AbeEVXvd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:51:33 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59043 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753139AbeEVXvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:51:31 -0400
Message-ID: <b92df74ecb0399db0fc1be49361134870d016421.camel@decadent.org.uk>
Subject: Re: [PATCH] KVM: VMX: Expose SSBD properly to guests.
From: Ben Hutchings <ben@decadent.org.uk>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Date: Wed, 23 May 2018 01:50:55 +0200
In-Reply-To: <20180521215449.26423-2-konrad.wilk@oracle.com>
References: <20180521215449.26423-1-konrad.wilk@oracle.com>
         <20180521215449.26423-2-konrad.wilk@oracle.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-GJwvkgTlHZFyEXHu/d6p"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 92.40.248.203
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GJwvkgTlHZFyEXHu/d6p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-05-21 at 17:54 -0400, Konrad Rzeszutek Wilk wrote:
> The X86_FEATURE_SSBD is an synthetic CPU feature - that is
> it bit location has no relevance to the real CPUID 0x7.EBX[31]
> bit position. For that we need the new CPU feature name.
>=20
> Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")
>=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/kvm/cpuid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index ced851169730..598461e24be3 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -407,8 +407,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_ent=
ry2 *entry, u32 function,
> =20
>  	/* cpuid 7.0.edx*/
>  	const u32 kvm_cpuid_7_0_edx_x86_features =3D
> -		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(SSBD) |
> -		F(ARCH_CAPABILITIES);
> +		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
> +		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
> =20
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();

For 4.9-stable, guest_cpuid_has_spec_ctrl() needs a similar fix.

Ben.

--=20
Ben Hutchings
It is easier to change the specification to fit the program
than vice versa.

--=-GJwvkgTlHZFyEXHu/d6p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsErN8ACgkQ57/I7JWG
EQnThxAAzSIf/WuZV0sWf8i41+KkAGCWTuhxc7gLotDufLIK4jC73qkd8Sf6pLrg
7IOxEtdCKC1NUyxKCLhPaIHENprqKlxjrZLs6pC3dbpqK1Yrp2CfweWm/fy5n2ks
onrQrMTSfYk5IS26eHeICPEvtRqJiC5TEOEw8gqqp2gtAp5QTJGn29Z6k4jwRlui
TT6wrsXG04SpvnaZsseqw3eqN73izEmFnXsGD1izvPkr9x4oYusvnkZKCkRv6CLw
tQaBSWb9TYfpaPqDZH7ewOWmbjGe4NeT4dPGOtCT4yCsHWCRUuiyX1b5+VJQ0OpR
KXNiMM9mf0rJma2AbhAHpBwex8gK50MG+f2eGTWGVV9N3DdG72ct2vVDEBVYbaR4
lZ4zgeUILLBQW12S2VJWJ69R0heE+0P8Qr9Ooirs6QapVSUEg9BNCUpdIU4E+UKg
Fw3RZhRnY9B30zoA7QURjHx+Z7t0MYJLyvDEzdNStiNLKhFACSSWXM99m7yZkQnC
3AX8KXng3KHOM8hHkjOMNb8rjv3P4J7gtbGUKesUvDC76La8agBa6yzJZ5gXATPk
odEl9/gPxxdQPUtoUGnaPq0NDSQgh7qIPcw4IRFuii5Dx4ymbzmc1qR5EVMPgj4o
c/gbA8pqHBOXcz1PNsqd7NdZ+7UaT5uxJu9jI9ERV7DPK43l5pQ=
=3zIs
-----END PGP SIGNATURE-----

--=-GJwvkgTlHZFyEXHu/d6p--
