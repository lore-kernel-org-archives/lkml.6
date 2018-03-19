Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933856AbeCSXJj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:09:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33902 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933688AbeCSXJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:09:36 -0400
X-Google-Smtp-Source: AG47ELvLYhVQ5uX5dby+zptijtozC+SVhemqTfgRkNZVVzFkK10ZKqYj/Pu9Vl3GTKeDLwJpuAIFEQ==
Subject: Re: [PATCH 3/3] perf/x86/intel: Enable C-state residency events for
 Cannon Lake
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, Kan.liang@intel.com, puthik@google.com,
        Benson Leung <bleung@google.com>, bleung@chromium.org
References: <20180309121549.630-1-harry.pan@intel.com>
 <20180309121549.630-3-harry.pan@intel.com>
From: Benson Leung <bleung@google.com>
Organization: Google
Message-ID: <cfac6f03-7700-dfe3-d1e6-9bf7f5a1d9c6@google.com>
Date: Mon, 19 Mar 2018 16:09:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309121549.630-3-harry.pan@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AFXW89FQTa5AmpcgmNtFFveZnxMq277ao"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AFXW89FQTa5AmpcgmNtFFveZnxMq277ao
Content-Type: multipart/mixed; boundary="nl5Eh0H4btItNHkwrOo2Qz8hg5ZIcfzke";
 protected-headers="v1"
From: Benson Leung <bleung@google.com>
To: Harry Pan <harry.pan@intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, Kan.liang@intel.com, puthik@google.com,
 Benson Leung <bleung@google.com>, bleung@chromium.org
Message-ID: <cfac6f03-7700-dfe3-d1e6-9bf7f5a1d9c6@google.com>
Subject: Re: [PATCH 3/3] perf/x86/intel: Enable C-state residency events for
 Cannon Lake
References: <20180309121549.630-1-harry.pan@intel.com>
 <20180309121549.630-3-harry.pan@intel.com>
In-Reply-To: <20180309121549.630-3-harry.pan@intel.com>

--nl5Eh0H4btItNHkwrOo2Qz8hg5ZIcfzke
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi Harry,

On 03/09/2018 04:15 AM, Harry Pan wrote:
> Cannon Lake supports C1/C3/C6/C7, PC2/PC3/PC6/PC7/PC8/PC9/PC10
> state residency counters, this patch enables those counters.
>=20
> The MSR information is based on Intel Software Developers' Manual,
> Vol. 4, Order No. 335592.
>=20
> Signed-off-by: Harry Pan <harry.pan@intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
>  arch/x86/events/intel/cstate.c | 44 +++++++++++++++++++++++++++++-----=
--------
>  1 file changed, 31 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cst=
ate.c
> index 72db0664a53d..9aca448bb8e6 100644
> --- a/arch/x86/events/intel/cstate.c
> +++ b/arch/x86/events/intel/cstate.c
> @@ -40,50 +40,51 @@
>   * Model specific counters:
>   *	MSR_CORE_C1_RES: CORE C1 Residency Counter
>   *			 perf code: 0x00
> - *			 Available model: SLM,AMT,GLM
> + *			 Available model: SLM,AMT,GLM,CNL
>   *			 Scope: Core (each processor core has a MSR)
>   *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
>   *			       perf code: 0x01
> - *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM
> + *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,GLM,
> +						CNL
>   *			       Scope: Core
>   *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
>   *			       perf code: 0x02
> - *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
> - *						SKL,KNL,GLM
> + *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
> + *						SKL,KNL,GLM,CNL
>   *			       Scope: Core
>   *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
>   *			       perf code: 0x03
> - *			       Available model: SNB,IVB,HSW,BDW,SKL
> + *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL
>   *			       Scope: Core
>   *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
>   *			       perf code: 0x00
> - *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM
> + *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
>   *			       perf code: 0x01
> - *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL
> - *						GLM
> + *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
> + *						GLM,CNL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
>   *			       perf code: 0x02
>   *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW
> - *						SKL,KNL,GLM
> + *						SKL,KNL,GLM,CNL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
>   *			       perf code: 0x03
> - *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL
> + *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
>   *			       perf code: 0x04
> - *			       Available model: HSW ULT only
> + *			       Available model: HSW ULT,CNL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
>   *			       perf code: 0x05
> - *			       Available model: HSW ULT only
> + *			       Available model: HSW ULT,CNL
>   *			       Scope: Package (physical package)
>   *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
>   *			       perf code: 0x06
> - *			       Available model: HSW ULT, GLM
> + *			       Available model: HSW ULT,GLM,CNL
>   *			       Scope: Package (physical package)
>   *
>   */
> @@ -486,6 +487,21 @@ static const struct cstate_model hswult_cstates __=
initconst =3D {
>  				  BIT(PERF_CSTATE_PKG_C10_RES),
>  };
> =20
> +static const struct cstate_model cnl_cstates __initconst =3D {
> +	.core_events		=3D BIT(PERF_CSTATE_CORE_C1_RES) |
> +				  BIT(PERF_CSTATE_CORE_C3_RES) |
> +				  BIT(PERF_CSTATE_CORE_C6_RES) |
> +				  BIT(PERF_CSTATE_CORE_C7_RES),
> +
> +	.pkg_events		=3D BIT(PERF_CSTATE_PKG_C2_RES) |
> +				  BIT(PERF_CSTATE_PKG_C3_RES) |
> +				  BIT(PERF_CSTATE_PKG_C6_RES) |
> +				  BIT(PERF_CSTATE_PKG_C7_RES) |
> +				  BIT(PERF_CSTATE_PKG_C8_RES) |
> +				  BIT(PERF_CSTATE_PKG_C9_RES) |
> +				  BIT(PERF_CSTATE_PKG_C10_RES),
> +};
> +
>  static const struct cstate_model slm_cstates __initconst =3D {
>  	.core_events		=3D BIT(PERF_CSTATE_CORE_C1_RES) |
>  				  BIT(PERF_CSTATE_CORE_C6_RES),
> @@ -557,6 +573,8 @@ static const struct x86_cpu_id intel_cstates_match[=
] __initconst =3D {
>  	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE,  snb_cstates),
>  	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_DESKTOP, snb_cstates),
> =20
> +	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
> +
>  	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
>  	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
> =20
>=20

Thank you!
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org


--nl5Eh0H4btItNHkwrOo2Qz8hg5ZIcfzke--

--AFXW89FQTa5AmpcgmNtFFveZnxMq277ao
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlqwQy0ACgkQHwn1ewov
5ljvZQ//Qj0HotSyz1L7n1DTEpWzFuQPkOIJjj+SpfE6qb/8dfBLwqh1Vx1J1NMZ
VGbfP7ee/bL3GQprZaJjy7dNVsJ54U0HkGk4z7Kx6Y89rlEUg7oPdZ/3kiOr7Jer
6GFAHENXo2xfntRKj7s7RH85jGzCizwQkIZ506qYuyKJsUm+WyGDYizYihKEtlq2
DNvzJeOBmPKYUs5cu9qXc5clQG6IGtAoDE/E8g+OdUjmw+sQIJ8hI/cVbyhWdHQ4
rmdz7Ng/HG15S2EbloY6uBcfsm7anK7i3uUsf/vSzJzkljDDMYtWbeelOSeGkUcu
++0WFoW2fnmIUgSk3B1Fxi6jV5KlzWEYJxWRgA2AspNtCrLcEyNqz7Zk4BT5veMl
vX6KzB+OEPzZOOb4jwNZis5nxkI24BTEHtw33JvG8MDTtC3yDW5e1Fmgagn6xXb/
hVKZo/Uwkk0C2C8km6BMVJ30hTi/5mOUfd3In85+0mXUWx7R+OYaUrBWzQN+qu9U
rTJn8xZWe6pLQezfegkRt/Sfxz/TRsSU3RIpE0P4OZ0cLGM9N6kMJVfHZFU+imYr
QJWuZ/3TD+OpNxdNLAwT2tnqQ1mdOTUD1VvRot4bPxDOWE+TrpNGr+0gvrrObRe8
7e9LS27xOFYD4U0gW1XPgC+3mNL1awn8PC/pfBJF34r8lTMo9XU=
=652K
-----END PGP SIGNATURE-----

--AFXW89FQTa5AmpcgmNtFFveZnxMq277ao--
