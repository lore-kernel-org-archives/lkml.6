Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162082AbeCAVeJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:34:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161792AbeCAVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:34:06 -0500
Date: Thu, 1 Mar 2018 21:33:56 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 11/25] ASoC: qcom: q6asm: add support to audio stream
 apis
Message-ID: <20180301213356.GV12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TG7lY2/6mW/akb80"
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TG7lY2/6mW/akb80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 04:58:23PM +0000, srinivas.kandagatla@linaro.org wr=
ote:

>  	uint32_t used;
> @@ -131,7 +191,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a=
, struct audio_client *ac,
> =20
>  	rc =3D wait_event_timeout(a->mem_wait, (a->mem_state <=3D 0), 5 * HZ);
>  	if (!rc) {
> -		dev_err(a->dev, "CMD timeout \n");
> +		dev_err(a->dev, "CMD timeout\n");
>  		rc =3D -ETIMEDOUT;
>  	} else if (a->mem_state < 0) {
>  		rc =3D  q6dsp_errno(a->mem_state);

This should be folded into whatever patch is being fixed.

> +	open.hdr.opcode =3D ASM_STREAM_CMD_OPEN_WRITE_V3;
> +	open.mode_flags =3D 0x00;
> +	open.mode_flags |=3D ASM_LEGACY_STREAM_SESSION;

What is a legacy stream and why are we using it in new code?

--TG7lY2/6mW/akb80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYccMACgkQJNaLcl1U
h9B4PAf/XuHY01+J4AY6SjvYrppdjRDO75cG1EFh0grfxKTIwzDe4rz/G31M2XP6
+o4/4MM/kFyjfLrz6MFGzTli4f0L+XTA5g6xMWNBR88N4VCVeJUG7UtF5qRVdfty
3q7oFiYNGe1GatCnwT2Vdom5XsezJVOphq0o1n+pZg3/xN3r4Cob7erT1CA3t1we
St+PE0vCAItwRd4skPzZbYLQ5FbrX7Wg2tYEPaLb6p+DpVxbQbqoCp83TVRH6NVU
vBXlr2f4RSL1jHbhayVIOdYDpE7/duVy60qFMRDIt7L0FD7q+igro5n1ZuyxsBnB
evcmg1mok6pN7Bfcjmid04+odETRgA==
=Yo1h
-----END PGP SIGNATURE-----

--TG7lY2/6mW/akb80--
