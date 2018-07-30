Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7927C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D22E20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="Dmj2LMPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D22E20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=riseup.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeG3Xo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:44:26 -0400
Received: from mx1.riseup.net ([198.252.153.129]:44691 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbeG3Xo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:44:26 -0400
Received: from piha.riseup.net (piha-pn.riseup.net [10.0.1.163])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id AA6011A0E3B;
        Mon, 30 Jul 2018 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1532988444; bh=7kWiIejmS/yRQ0lJNOT4RpwS2WZOGwgHnPBrac1L70g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dmj2LMPsHRVX4OYqtFQ8M3v2yjmAjNKYs9PENwqJBRDekDpeQ8YUb1Ohu9FoL311S
         LHE9gRdibs23Yq3VVjJyg3JwfkF6aomy8avNSUNw6mb8bDyr7gTXMsgMag9sTb/bMI
         MxYTs2SHbadoVOCPvbx5qWiP72YsU8V+au1yCM+k=
X-Riseup-User-ID: 3351028C486B2D49F92EA71C3D9B17ED06D97C2DB9C482CAD89A72D895C59DD2
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by piha.riseup.net with ESMTPSA id 67FE845D94;
        Mon, 30 Jul 2018 15:07:23 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eero.t.tamminen@intel.com, ggherdovich@suse.cz,
        mgorman@techsingularity.net,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] cpufreq: intel_pstate: Limit the scope of HWP dynamic boost platforms
In-Reply-To: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
References: <20180730220029.81983-1-srinivas.pandruvada@linux.intel.com>
Date:   Mon, 30 Jul 2018 14:50:30 -0700
Message-ID: <87va8wcs0p.fsf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:

> Dynamic boosting of HWP performance on IO wake showed significant
> improvement to IO workloads. This series was intended for Skylake Xeon
> platforms only and feature was enabled by default based on CPU model
> number.
>
> But some Xeon platforms reused the Skylake desktop CPU model number. This
> caused some undesirable side effects to some graphics workloads. Since
> they are heavily IO bound, the increase in CPU performance decreased the
> power available for GPU to do its computing and hence decrease in graphics
> benchmark performance.
>
> For example on a Skylake desktop, GpuTest benchmark showed average FPS
> reduction from 529 to 506.
>
> This change makes sure that HWP boost feature is only enabled for Skylake
> server platforms by using ACPI FADT preferred PM Profile. If some desktop
> users wants to get benefit of boost, they can still enable boost from
> intel_pstate sysfs attribute "hwp_dynamic_boost".
>
> Fixes: 41ab43c9c89e (cpufreq: intel_pstate: enable boost for Skylake Xeon)
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=3D107410
> Reported-by: Eero Tamminen <eero.t.tamminen@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Reviewed-by: Francisco Jerez <currojerez@riseup.net>

> ---
>  drivers/cpufreq/intel_pstate.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 3c3971256130..d4ed0022b0dd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -311,12 +311,20 @@ static DEFINE_MUTEX(intel_pstate_limits_lock);
>=20=20
>  #ifdef CONFIG_ACPI
>=20=20
> -static bool intel_pstate_get_ppc_enable_status(void)
> +static bool intel_pstate_acpi_pm_profile_server(void)
>  {
>  	if (acpi_gbl_FADT.preferred_profile =3D=3D PM_ENTERPRISE_SERVER ||
>  	    acpi_gbl_FADT.preferred_profile =3D=3D PM_PERFORMANCE_SERVER)
>  		return true;
>=20=20
> +	return false;
> +}
> +
> +static bool intel_pstate_get_ppc_enable_status(void)
> +{
> +	if (intel_pstate_acpi_pm_profile_server())
> +		return true;
> +
>  	return acpi_ppc;
>  }
>=20=20
> @@ -459,6 +467,11 @@ static inline void intel_pstate_init_acpi_perf_limit=
s(struct cpufreq_policy *pol
>  static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *=
policy)
>  {
>  }
> +
> +static inline bool intel_pstate_acpi_pm_profile_server(void)
> +{
> +	return false;
> +}
>  #endif
>=20=20
>  static inline void update_turbo_state(void)
> @@ -1841,7 +1854,7 @@ static int intel_pstate_init_cpu(unsigned int cpunu=
m)
>  		intel_pstate_hwp_enable(cpu);
>=20=20
>  		id =3D x86_match_cpu(intel_pstate_hwp_boost_ids);
> -		if (id)
> +		if (id && intel_pstate_acpi_pm_profile_server())
>  			hwp_boost =3D true;
>  	}
>=20=20
> --=20
> 2.17.1

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW1+IJgAKCRCDmTidfVK/
W3khAP0YpHQlG/h0QWGEj+Zl1xSpqquyGWdOLDtRCokhiMks2QD/UNC1lfcXFVXu
BnJkDXstqBlAEWdp59VgcpYPjFQEnkw=
=efVI
-----END PGP SIGNATURE-----
--==-=-=--
