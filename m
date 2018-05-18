Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbeERJON (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:14:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42556 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeERJN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:13:56 -0400
X-Google-Smtp-Source: AB8JxZq7zURSAwR/yxDdVEQbfGQLle+c7HQ85x+Rs2twjkbdSLTXcKT8NAFWEKZO9ZSWA7ufGhfBJA==
Date: Fri, 18 May 2018 11:13:52 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 11/11] ARM: tegra: Create platform device for
 tegra20-cpufreq driver
Message-ID: <20180518091352.GK14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-12-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:56PM +0300, Dmitry Osipenko wrote:
> Tegra20-cpufreq driver require a platform device in order to be loaded,
> instantiate a simple platform device for the driver during of the machines
> late initialization.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index 02e712d2ea30..f9587be48235 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -97,6 +97,10 @@ static void __init tegra_dt_init_late(void)
>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>  	    of_machine_is_compatible("compal,paz00"))
>  		tegra_paz00_wifikill_init();
> +
> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
> +	    of_machine_is_compatible("nvidia,tegra20"))
> +		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>  }
> =20
>  static const char * const tegra_dt_board_compat[] =3D {

Tegra124 has a CPU frequency driver that is similar to this and it
contains code that will instantiate the platform device from the CPU
frequency driver's module_init function.

I think the primary reason for doing that was to not tie the code to
32-bit ARM, even though it never runs on anything but that, so it's
slightly over-engineered.

I don't mind either way, and it's easy enough to change this to
something else later on if we want. I'll pick this up into the Tegra
tree.

Thierry

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+mVAACgkQ3SOs138+
s6EUEhAAwVCPLLasRUQ+ubjpdCkMnz1lmxN2DkCaAcM3BnTQmO9ALBrzeeWMHP30
Q8R0uUNFJ4SWdd4Oapf6jAarSh5X7OU9wTafDinvTcL3Wyo5svcNPfCOoES1n2S+
G+6pmDeuysQ1rWK8/wJ1w6j4YVczagdkAOW7fu8a1JG72AC245HBioezPmEOmE63
KambHKvtT56vwo+4Bj6GwsnsEIf5sQG+EdOILgfpHC/35Nyck6zPWHYv850SAWvH
fN8GHalQH/mb3spTEhKKOmyLVytO14TP0veus4KpICyw7QyuQS5Zs0nKZvXn2LtD
vOf+1NvKuEyzmyVr+q2R5cQ/iZSQImI0lwNZ1jnZDlLXxvc7oA7B73nZ49AHa1P/
yS85aWFTaOhKiUURi/dDayL21uotHpfj51dDn3F8ttwdHD5YFHljQGbgZqZ759qC
uM2yUFjAOpbJCpkKrYK5BCQpXT9qPpf3dI1zU6D5x0vwd2hEfBeyY4ucdyuBMr06
DGrsb1PkFNNFCrU8pgItFM0GavnolPa7FKmGql9kX5/scP/fYz6TjH8gDJ7t9vDr
vrDGOWYcOn5OcdbftZmC06SBjTasdGbV9GZAYRWpV4Q8x5J0q2oQCcOSJj1mIL/I
33ubbhHepx2MFFHpRUMJJy5IV7B/5X4S5nArSAQUHJrJkIJZn4U=
=hAUr
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
