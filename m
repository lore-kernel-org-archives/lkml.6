Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeCEPwU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:52:20 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:52:19 -0500
Date: Mon, 5 Mar 2018 15:52:08 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
Message-ID: <20180305155208.GK8588@sirena.org.uk>
References: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline
In-Reply-To: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2018 at 12:32:13PM +0000, srinivas.kandagatla@linaro.org wrote:

> +int dapm_pinctrl_event(struct snd_soc_dapm_widget *w,
> +		       struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_dapm_pinctrl_priv *priv = w->priv;
> +	struct pinctrl *p = w->pinctrl;
> +	struct pinctrl_state *s;
> +
> +	if (!p || !priv)
> +		return -EIO;
> +
> +	soc_dapm_async_complete(w->dapm);

This doesn't look right - we're trying to synchronize with the DAPM
async queue from something that should be run inside that very queue.
What is this supposed to be doing?

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdZ6gACgkQJNaLcl1U
h9Cf2Qf+LEcnkBxz5K9/VMMvmHzkz6BFHGu6MjMGN3KKJAiV/NN5mKOnL0jFqlci
to7GQdx9HMXBCq6osQqHuDOYtY57kYWN0KpBG0i3dddvJLF4kGc+QZnzB7WpBfeu
0Vb1T/nE9h6J7wSqfIdYqxUw/7cAdIqxL/qrV8PQWTgZFKAV/45VuQ/bEYVZsmFM
uXqUuGwJm0OFkU66pkHVg4b1fPBIP3XfX9UohgO3Gejj8N7gBIBI4tPD3J42Eu49
CEGHaf0888RmXYQprZZcUE8NOQH+zsbkU6TNhf0JFVVL1u9QF0ofR1mz6IaIZ/lL
A9B8c0OT+3Z8CRMxSB0VFL5wnqKm6g==
=hY2d
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--
