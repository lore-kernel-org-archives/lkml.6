Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3206DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B465D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmy5W/KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B465D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJPUP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:15:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42415 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPUP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:15:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id g15-v6so25265977wru.9;
        Tue, 16 Oct 2018 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZjJCxSQgL9GGnXiwiXtIxUZa+r3Ji/nLyiCES4xWFM=;
        b=Mmy5W/KF69wujNwpOVwtx4EYW3K2h//oYJNAYbqA4l6Ym+zUY3awCwj1rdOPej/CVD
         c8PwQc2GoeTbPRXNnbjdZpX4S6IEvnf+JJwnxIl589JtQ5zAd3Ju09BePaszmkpNoSOm
         JzxsbP8PqfQwOl6DYb6c0eN34WK70DlJIgGXsaCzLyKcLV5aWzTNyustuANInP+fbvo2
         AxCYM5GKBWuwPYu2xDTbl09Ls6S4wUaOg6BLFL8WihQbv8e1Y9AjAutvFZJYtvLpxFTp
         FNHWtEVO0CV41/a2gPSB+Nyn1SojAiMDTLFD3R9zuEr0jgpwEAaQ+pCWBAfuSfBUEv7M
         ENvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZjJCxSQgL9GGnXiwiXtIxUZa+r3Ji/nLyiCES4xWFM=;
        b=gXKDwcxaupApv7zAiW6CgC/FoX2qFfiJajcnGhwp6DnaJp3deOfgpXvWwWw+Gb5bS8
         vGhw7A+wdEyJmaXcJMs8eI6thjTVVetRmV6TAYIniSmQp16e9S6lBU0gdeOQBkiXQCfk
         AW+y9CUWL5MvWaOvcHHnYMle8OpckDyfD27kqsixYLtKfe+/sOwGDQjfcE2HCgyWty9c
         MfvVdV3/rNXQGMSa7TGHwHhsgXHJexSzf87fn81jz7vj9SZEGt2bjg5b1ETqA49wlzDf
         TptaW1wFFn6zMiC7+0gD07lDOjKG6JQyTUZxT78bNwPxI8uXPqlwNRR2h97do7TrsqVz
         tCDQ==
X-Gm-Message-State: ABuFfoiGmAZP4JOpd13HbekCohpjCW1/j4+wR4+KnTxcQKo2km2KCC8M
        E4NpITmWpuP94HYskVPRJH8=
X-Google-Smtp-Source: ACcGV625U2kDht0+0O1UtUNbIrSCHacDHbfICZ9Krecq+v5m+P+JqbARyjfZ2FYU+g8n70zLN9qU9g==
X-Received: by 2002:adf:9d26:: with SMTP id k38-v6mr19585286wre.18.1539692710065;
        Tue, 16 Oct 2018 05:25:10 -0700 (PDT)
Received: from localhost (pD9E5106D.dip0.t-ipconnect.de. [217.229.16.109])
        by smtp.gmail.com with ESMTPSA id o201-v6sm14962248wmg.16.2018.10.16.05.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:25:09 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:25:08 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     shc_work@mail.ru, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
Message-ID: <20181016122508.GH8852@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
In-Reply-To: <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 04:01:18PM +0300, Claudiu Beznea wrote:
> Add basic PWM modes: normal and complementary. These modes should
> differentiate the single output PWM channels from two outputs PWM
> channels. These modes could be set as follow:
> 1. PWM channels with one output per channel:
> - normal mode
> 2. PWM channels with two outputs per channel:
> - normal mode
> - complementary mode
> Since users could use a PWM channel with two output as one output PWM
> channel, the PWM normal mode is allowed to be set for PWM channels with
> two outputs; in fact PWM normal mode should be supported by all PWMs.
>=20
> The PWM capabilities were implemented per PWM channel. Every PWM controll=
er
> will register a function to get PWM capabilities. If this is not explicit=
ly
> set by the driver a default function will be used to retrieve the PWM
> capabilities (in this case the PWM capabilities will contain only PWM
> normal mode). This function is set in pwmchip_add_with_polarity() as a
> member of "struct pwm_chip". To retrieve capabilities the pwm_get_caps()
> function could be used.
>=20
> Every PWM channel have associated a mode in the PWM state. Proper
> support was added to get/set PWM mode. The mode could also be set
> from DT via flag cells. The valid DT modes are located in
> include/dt-bindings/pwm/pwm.h. Only modes supported by PWM channel could =
be
> set. If nothing is specified for a PWM channel, via DT, the first availab=
le
> mode will be used (normally, this will be PWM normal mode).
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pwm/core.c  | 124 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  drivers/pwm/sysfs.c |  61 ++++++++++++++++++++++++++
>  include/linux/pwm.h |  39 +++++++++++++++++
>  3 files changed, 221 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6ab1b1f..59a9df9120de 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -136,6 +136,7 @@ struct pwm_device *
>  of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_arg=
s *args)
>  {
>  	struct pwm_device *pwm;
> +	int modebit;
> =20
>  	/* check, whether the driver supports a third cell for flags */
>  	if (pc->of_pwm_n_cells < 3)
> @@ -154,9 +155,23 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const s=
truct of_phandle_args *args)
> =20
>  	pwm->args.period =3D args->args[1];
>  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> +	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);
> =20
> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> -		pwm->args.polarity =3D PWM_POLARITY_INVERSED;
> +	if (args->args_count > 2) {
> +		if (args->args[2] & PWM_POLARITY_INVERTED)
> +			pwm->args.polarity =3D PWM_POLARITY_INVERSED;
> +
> +		for (modebit =3D PWMC_MODE_COMPLEMENTARY_BIT;
> +		     modebit < PWMC_MODE_CNT; modebit++) {
> +			unsigned long mode =3D BIT(modebit);
> +
> +			if ((args->args[2] & mode) &&
> +			    pwm_mode_valid(pwm, mode)) {
> +				pwm->args.mode =3D mode;
> +				break;
> +			}
> +		}
> +	}
> =20
>  	return pwm;
>  }
> @@ -183,6 +198,7 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const struct=
 of_phandle_args *args)
>  		return pwm;
> =20
>  	pwm->args.period =3D args->args[1];
> +	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);
> =20
>  	return pwm;
>  }
> @@ -250,6 +266,97 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
>  }
> =20
>  /**
> + * pwm_get_caps() - get PWM capabilities of a PWM device
> + * @chip: PWM chip
> + * @pwm: PWM device to get the capabilities for
> + * @caps: returned capabilities
> + *
> + * Returns: 0 on success or a negative error code on failure
> + */
> +int pwm_get_caps(struct pwm_chip *chip, struct pwm_device *pwm,
> +		 struct pwm_caps *caps)
> +{
> +	if (!chip || !pwm || !caps)
> +		return -EINVAL;
> +
> +	if (chip->ops && chip->ops->get_caps)
> +		pwm->chip->ops->get_caps(chip, pwm, caps);
> +	else if (chip->get_default_caps)
> +		chip->get_default_caps(caps);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pwm_get_caps);

I'm confused by the way ->get_default_caps() is used here. This always
points at pwmchip_get_default_caps() if I understand correctly, so why
bother with the indirection?

I think it would be better to either export pwmchip_get_default_caps()
as a default implementation of ->get_caps(), something like:

	void pwm_get_default_caps(struct pwm_chip *chip, struct pwm_device *pwm,
				  struct pwm_caps *caps)
	{
		...
	}
	EXPORT_SYMBOL_GPL(pwm_get_default_caps);

This could be used by the individual drivers as the implementation if
they don't support any modes.

Another, probably simpler approach would be to just get rid of the
chip->get_default_caps() pointer and directly call
pwmchip_get_default_caps() from pwm_get_caps():

	int pwm_get_caps(...)
	{
		/*
		 * Note that you don't need the check for chip->ops because
		 * the core checks for that upon registration of the chip.
		 */
		if (chip->ops->get_caps)
			return chip->ops->get_caps(...);

		return pwm_get_default_caps(...);
	}

And if we do that, might as well fold pwm_get_default_caps() into
pwm_get_caps().

> +/**
> + * pwm_mode_get_valid() - get the first available valid mode for PWM
> + * @chip: PWM chip
> + * @pwm: PWM device to get the valid mode for
> + *
> + * Returns: first valid mode for PWM device
> + */
> +unsigned long pwm_mode_get_valid(struct pwm_chip *chip, struct pwm_devic=
e *pwm)

This is a little ambiguous. Perhaps pwm_get_default_mode()?

> +/**
> + * pwm_mode_valid() - check if mode is valid for PWM device
> + * @pwm: PWM device
> + * @mode: PWM mode to check if valid
> + *
> + * Returns: true if mode is valid and false otherwise
> + */
> +bool pwm_mode_valid(struct pwm_device *pwm, unsigned long mode)

Again, this is slightly ambiguous because the name suggests that it
merely tests a mode for validity, not that it is really supported by the
given device. Perhaps something like pwm_supports_mode()?

> +const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
> +{
> +	static const char * const modes[] =3D {
> +		"invalid",
> +		"normal",
> +		"complementary",
> +	};
> +
> +	if (!pwm_mode_valid(pwm, mode))
> +		return modes[0];
> +
> +	return modes[ffs(mode)];
> +}

Do we really need to be able to get the name of the mode in the context
of a given PWM channel? Couldn't we drop the pwm parameter and simply
return the name (pwm_get_mode_name()?) and at the same time remove the
extra "invalid" mode in there? I'm not sure what the use-case here is,
but it seems to me like the code should always check for supported modes
first before reporting their names in any way.

> +/**
>   * pwmchip_add_with_polarity() - register a new PWM chip
>   * @chip: the PWM chip to add
>   * @polarity: initial polarity of PWM channels
> @@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> =20
>  	mutex_lock(&pwm_lock);
> =20
> +	chip->get_default_caps =3D pwmchip_get_default_caps;
> +
>  	ret =3D alloc_pwms(chip->base, chip->npwm);
>  	if (ret < 0)
>  		goto out;
> @@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  		pwm->pwm =3D chip->base + i;
>  		pwm->hwpwm =3D i;
>  		pwm->state.polarity =3D polarity;
> +		pwm->state.mode =3D pwm_mode_get_valid(chip, pwm);
> =20
>  		if (chip->ops->get_state)
>  			chip->ops->get_state(chip, pwm, &pwm->state);
> @@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pw=
m_state *state)
>  	int err;
> =20
>  	if (!pwm || !state || !state->period ||
> -	    state->duty_cycle > state->period)
> +	    state->duty_cycle > state->period ||
> +	    !pwm_mode_valid(pwm, state->mode))
>  		return -EINVAL;
> =20
>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
> @@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pw=
m_state *state)
> =20
>  			pwm->state.enabled =3D state->enabled;
>  		}
> +
> +		/* No mode support for non-atomic PWM. */
> +		pwm->state.mode =3D state->mode;

That comment seems misplaced. This is actually part of atomic PWM, so
maybe just reverse the logic and say "mode support only for atomic PWM"
or something. I would personally just leave it away. The legacy API has
no way of setting the mode, which is indication enough that we don't
support it.

> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 56518adc31dd..a4ce4ad7edf0 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -26,9 +26,32 @@ enum pwm_polarity {
>  };
> =20
>  /**
> + * PWM modes capabilities
> + * @PWMC_MODE_NORMAL_BIT: PWM has one output
> + * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarit=
ies
> + * @PWMC_MODE_CNT: PWM modes count
> + */
> +enum {
> +	PWMC_MODE_NORMAL_BIT,
> +	PWMC_MODE_COMPLEMENTARY_BIT,
> +	PWMC_MODE_CNT,
> +};
> +
> +#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)

Why the C in the prefix? Why not just PWM_MODE_* for all of the above?

> +
> +/**
> + * struct pwm_caps - PWM capabilities
> + * @modes: PWM modes

This should probably say that it's a bitmask of PWM_MODE_*.

> +struct pwm_caps {
> +	unsigned long modes;
> +};
> +
> +/**
>   * struct pwm_args - board-dependent PWM arguments
>   * @period: reference period
>   * @polarity: reference polarity
> + * @mode: reference mode

As discussed in my reply to the cover letter, what is the use for the
reference mode? Drivers want to use either normal or some other mode.
What good is it to get this from board-dependent arguments if the
driver already knows which one it wants or needs?

> @@ -300,6 +331,7 @@ struct pwm_chip {
> =20
>  	struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>  					const struct of_phandle_args *args);
> +	void (*get_default_caps)(struct pwm_caps *caps);

As mentioned above, I don't think we need this.

Thierry

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvF2KEACgkQ3SOs138+
s6FInQ//dCrrajHRK2UhdVBR9LxxWy0fdBPpQngnitnBEiuIUj5b8ZpshFeuFUqX
4r6v1M/z34agLbm4sn8rdGOxNrjqdigtNt9l/ig0BvqhC5TWgSRALC+fTdIihIkx
t/N0utliojPi/tLBgxR6w1lg39wEMCI4wfr9UxOb73JY9CDrI7IpbPciund1wn9b
CLoMiGDzHE+1RiES+1SfRlnyXXq57Ow9s6aBB/SQyviI/+qtl0gRrv3lNorpqIsc
EFUwJ0uOTBCa1uQA/KR5rAIBBt8iYATrmhyv+UyOhNERrpV83pdj54BH5uPqqREa
8kYyOo5Fw5GMRZwqF3FhcUNkzHKmNG9ghZLMt8gZFUucZg/hFfps3OL6+d6Pb+G9
GPAzE7rO4Ss/GkaoPWlLHxLGzycJwUeQbZV4M6ah2ixRHePSXKzoCQsVvEpWJZja
i40AxqcO0PmQZK7iVIZAb43tABtKxowbA/D4hpmYX2/7zZil8vEEfFsRtvn113Zi
OrFn8w/aGU0WwFzX5v1aZqRTi6VGykAl0JIEvYCQCrMuHQQnCzV5jJnIjCFA6KbH
ZzpwFyRA1/g1KQShgOYtLkasYmRpRed9pmWDwDR+wDZz1DRvqeTsetyYHBT2ezKU
odNVBYVW0DGZdl/HI+8rzMQl+4ZpAyk0NTs/FAX+jc/EFAhgr2U=
=gGpY
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
