Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161891AbeCAVEl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:04:41 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43030 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161796AbeCAVEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:04:39 -0500
Date: Thu, 1 Mar 2018 21:04:28 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 03/25] ASoC: qcom: qdsp6: Add common qdsp6 helper
 functions
Message-ID: <20180301210428.GS12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/U0GMd1Pus0mbMSS"
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-4-srinivas.kandagatla@linaro.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/U0GMd1Pus0mbMSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:15PM +0000, srinivas.kandagatla@linaro.org wrote:

> +config SND_SOC_QDSP6_COMMON
> +	tristate
> +	default n
> +

Ah, the other default n that had snuck in was actually in an earlier
patch in the series!  I'm fairly sure this has come up with earlier
drivers you've submitted...

> +int q6dsp_map_channels(u8 ch_map[PCM_FORMAT_MAX_NUM_CHANNEL], int ch)
> +{
> +	memset(ch_map, 0, PCM_FORMAT_MAX_NUM_CHANNEL);
> +
> +	switch (ch) {
> +	case 1:
> +			ch_map[0] = PCM_CHANNEL_FC;
> +		break;
> +	case 2:
> +			ch_map[0] = PCM_CHANNEL_FL;
> +			ch_map[1] = PCM_CHANNEL_FR;
> +		break;

That's some really funky indentation there...

> +static inline int q6dsp_errno(u32 error)
> +{
> +	int ret = -EINVAL;
> +
> +	if (error <= ARRAY_SIZE(q6dsp_err_codes))
> +		ret = q6dsp_err_codes[error].lnx_err_code;
> +
> +	return ret;
> +}

Is the error handling such a hot path that we need to make the lookup
functions (and the data table with the lookups) static inlines in a
header or could we just move the functions and the data into a C file?
Especially given the string lookups for the errors (which are really
nice to have) it seems wasteful.

--/U0GMd1Pus0mbMSS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYatsACgkQJNaLcl1U
h9BlTQf9GxyaM1vTkhv2OQa2s4bd3M3jGz+u9SFXCfM90dcKPeEDbXWDaBKWXDBp
VmUXFJwdYWrj3IYA5woFFLEitl3qam5OOfnOIWCHNmcA+sNM0JSCxiWVzmC9WUrK
Lqpn9Ggy41EDKePr5b6Fz5Me2rpyq6ijANzRtQcsHo2CaAXjj3vmdrRccO5QD0aH
0A1nZFC6xGwRRKC3MTHlOcH+1oAGw23VkRydKJLUxCCx5d5BlRWj7/bw0FPtK/3z
TV/h38Zf1xDntDxJRAYPkBGSgvlILe+0qyCIHC5dHPfILceOFjXXXHsU7am8SKju
KlyMhmcoyBGHOzYFHNx9ev5yoojkOA==
=k4hS
-----END PGP SIGNATURE-----

--/U0GMd1Pus0mbMSS--
