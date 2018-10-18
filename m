Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67581C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9B72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvPIcpK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9B72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeJRXe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:34:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32916 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeJRXe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:34:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id y140-v6so2122420wmd.0;
        Thu, 18 Oct 2018 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CfZxJT+X35TDRugibjiWsyi9jqjDhW9u5vsmbXrQ1nY=;
        b=PvPIcpK/h29zNZR+0w8DG2uvYteHqntpKrfq6Cs7aMYevFqQYG2fafgvYR+wD5S3zb
         A+QV5fcKLueTmWk9/CIgcIU2IEVg2KjNUpf3F6h2qL/I4UXoN2srcpSCSAfiW1gBoynt
         JX7uhDQeJlnEw0WNAoGBUj66/FWKglLE8oZ5fqk7tzewXQ9Nv0PHNVhUVsN1Ot66bcxX
         1pyTGSkDnrKjukkrWvS9LvHqEWQz+YicO7VJwRUYMLQJ1w2b+1w0+8iKyyQ2q1QgXPGW
         Lp1fZqVNavPtsbk+cLs3OO3YEvs4S4ZWl+rM8wdo6vj1SqK/miqBy5fuA2FDlnOl59zi
         BonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CfZxJT+X35TDRugibjiWsyi9jqjDhW9u5vsmbXrQ1nY=;
        b=gnvE2F4WuvAfCpDB72ZyUTmLWKOoaJysxy5V0ryUYjw2CO6zpN9ofqm1jMmIlD/lO0
         n9z1ZMnB04KvtQbqdfV0UuZUnFiF7FDrxCwfIoUbgFxA5KBWvkHUOKYLL4iKKEjrgfxk
         UY+/1I02SNvbbmbCt3v4ybledynKe19c4T5qupnm7/wizq4cZmGybrRfTmwptEBz/4UD
         g9t4npKHg4UV2yuhXcmx8559dIerFH5viOg0HQfOu99jtlZoUE/B+v7rPh/Zo/jg8Cxt
         tkFVRAIdNpkIQrq/P8pCLb+hntMseFGfRYZh1fX/ZLT0SMxNLegT1mLYTAcPi7kebnaU
         xf/Q==
X-Gm-Message-State: ABuFfoieLBFRfWj+aeFt18VvgdS2MWW17CkhhuJjxq5Z9cwt8xyENLOb
        rrYYuY0goFWNf4r+oJh8Bgk=
X-Google-Smtp-Source: ACcGV60+8ZTO/mBO4AQLxT9yEEAyXwphYEND1D21ZGazQFLESwact9IVCooINXmgcD/qbcOJ41nUQg==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr859195wmd.51.1539876772261;
        Thu, 18 Oct 2018 08:32:52 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id y25-v6sm3042325wrd.25.2018.10.18.08.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 08:32:51 -0700 (PDT)
Date:   Thu, 18 Oct 2018 17:32:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        alexandre.belloni@bootlin.com, shc_work@mail.ru, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
Message-ID: <20181018153250.GC6226@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
 <20181016122508.GH8852@ulmo>
 <139cc421-ac12-1262-bc32-763731528ccf@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <139cc421-ac12-1262-bc32-763731528ccf@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 12:42:00PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 16.10.2018 15:25, Thierry Reding wrote:
> > On Tue, Aug 28, 2018 at 04:01:18PM +0300, Claudiu Beznea wrote:
[...]
> >> +const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
> >> +{
> >> +	static const char * const modes[] =3D {
> >> +		"invalid",
> >> +		"normal",
> >> +		"complementary",
> >> +	};
> >> +
> >> +	if (!pwm_mode_valid(pwm, mode))
> >> +		return modes[0];
> >> +
> >> +	return modes[ffs(mode)];
> >> +}
> >=20
> > Do we really need to be able to get the name of the mode in the context
> > of a given PWM channel? Couldn't we drop the pwm parameter and simply
> > return the name (pwm_get_mode_name()?) and at the same time remove the
> > extra "invalid" mode in there? I'm not sure what the use-case here is,
> > but it seems to me like the code should always check for supported modes
> > first before reporting their names in any way.
>=20
> Looking back at this code, the main use case for checking PWM mode validi=
ty
> in pwm_mode_desc() was only with regards to mode_store(). But there is not
> need for this checking since the same thing will be checked in
> pwm_apply_state() and, in case user provides an invalid mode via sysfs the
> pwm_apply_state() will fail.
>=20
> To conclude, I will change this function in something like:
>=20
> if (mode =3D=3D PWM_MODE_NORMAL)
> 	return "normal";
> else if (mode =3D=3D PWM_MODE_COMPLEMENTARY)
> 	return "complementary";
> else if (mode =3D=3D PWM_MODE_PUSH_PULL)
> 	return "push-pull";
> else
> 	return "invalid";
>=20
> Please let me know if it is OK for you.

Do we even have to check here for validity of the mode in the first
place? Shouldn't this already happen at a higher level? I mean we do
need to check for valid input in mode_store(), but whatever mode we
pass into this could already have been validated, so that this would
never return "invalid".

For example, you already define an enum for the PWM modes. I think it'd
be best if we then used that enum to pass the modes around. That way it
becomes easy to check for validity.

So taking one step back, I think we can remove some of the ambiguities
by making sure we only ever specify one mode. When the mode is
explicitly being set, we only ever want one, right? The only point in
time where we can store more than one is for the capabilities. So I
think being more explicit about that would be useful. That way we remove
any uncertainties about what the unsigned long might contain at any
point in time.

> >> +/**
> >>   * pwmchip_add_with_polarity() - register a new PWM chip
> >>   * @chip: the PWM chip to add
> >>   * @polarity: initial polarity of PWM channels
> >> @@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chi=
p,
> >> =20
> >>  	mutex_lock(&pwm_lock);
> >> =20
> >> +	chip->get_default_caps =3D pwmchip_get_default_caps;
> >> +
> >>  	ret =3D alloc_pwms(chip->base, chip->npwm);
> >>  	if (ret < 0)
> >>  		goto out;
> >> @@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chi=
p,
> >>  		pwm->pwm =3D chip->base + i;
> >>  		pwm->hwpwm =3D i;
> >>  		pwm->state.polarity =3D polarity;
> >> +		pwm->state.mode =3D pwm_mode_get_valid(chip, pwm);
> >> =20
> >>  		if (chip->ops->get_state)
> >>  			chip->ops->get_state(chip, pwm, &pwm->state);
> >> @@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct=
 pwm_state *state)
> >>  	int err;
> >> =20
> >>  	if (!pwm || !state || !state->period ||
> >> -	    state->duty_cycle > state->period)
> >> +	    state->duty_cycle > state->period ||
> >> +	    !pwm_mode_valid(pwm, state->mode))
> >>  		return -EINVAL;
> >> =20
> >>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
> >> @@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct=
 pwm_state *state)
> >> =20
> >>  			pwm->state.enabled =3D state->enabled;
> >>  		}
> >> +
> >> +		/* No mode support for non-atomic PWM. */
> >> +		pwm->state.mode =3D state->mode;
> >=20
> > That comment seems misplaced. This is actually part of atomic PWM, so
> > maybe just reverse the logic and say "mode support only for atomic PWM"
> > or something. I would personally just leave it away.
>=20
> Ok, sure. I will remove the comment. But the code has to be there to avoid
> unassigned mode value for PWM state (normal mode means BIT(0)) and so to
> avoid future PWM applies failure.

Oh yeah, definitely keep the code around. I was only commenting on
the... comment. =3D)

> The legacy API has
> > no way of setting the mode, which is indication enough that we don't
> > support it.
> >=20
> >> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> >> index 56518adc31dd..a4ce4ad7edf0 100644
> >> --- a/include/linux/pwm.h
> >> +++ b/include/linux/pwm.h
> >> @@ -26,9 +26,32 @@ enum pwm_polarity {
> >>  };
> >> =20
> >>  /**
> >> + * PWM modes capabilities
> >> + * @PWMC_MODE_NORMAL_BIT: PWM has one output
> >> + * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite pola=
rities
> >> + * @PWMC_MODE_CNT: PWM modes count
> >> + */
> >> +enum {
> >> +	PWMC_MODE_NORMAL_BIT,
> >> +	PWMC_MODE_COMPLEMENTARY_BIT,
> >> +	PWMC_MODE_CNT,
> >> +};
> >> +
> >> +#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)
> >=20
> > Why the C in the prefix? Why not just PWM_MODE_* for all of the above?
>=20
> Well... PWM_MODE() macro was already took by pwm-sun4i.c driver at the ti=
me
> I wrote this patch... So I choose to add extra C to this macro, "C" meani=
ng
> "constant" in my mind. I was not sure it was the best solution at that ti=
me
> either.

We can always rename definitions in drivers if we want to use
conflicting names in the core. In this particular case, and given what I
said above regarding the PWM mode definitions, I think it'd be better to
drop the _BIT suffix from the enum values, so that we get something like
this:

	enum pwm_mode {
		PWM_MODE_NORMAL,
		PWM_MODE_COMPLEMENTARY,
		PWM_MODE_COUNT
	};

Then in order to create the actual bitmasks we can use a macro that is
explicit about creating bitmasks:

	#define PWM_MODE_MASK(name) BIT(PWM_MODE_##name##)

With that, the conflict with pwm-sun4i conveniently goes away.

> >> +struct pwm_caps {
> >> +	unsigned long modes;
> >> +};
> >> +
> >> +/**
> >>   * struct pwm_args - board-dependent PWM arguments
> >>   * @period: reference period
> >>   * @polarity: reference polarity
> >> + * @mode: reference mode
> >=20
> > As discussed in my reply to the cover letter, what is the use for the
> > reference mode? Drivers want to use either normal or some other mode.
> > What good is it to get this from board-dependent arguments if the
> > driver already knows which one it wants or needs?
>=20
> For the moment, no, there is no in-kernel user. Only sysfs. I was thinking
> I would also adapt, e.g., the pwm-regulator driver to also make use of th=
is
> features in setups like the one described in [1], page 2126
> (Figure 56-13: Half-Bridge Converter Application: No Feedback Regulation).
> But, for the moment there is no in-kernel user.
>=20
> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

Okay, so that means we don't have any use-cases where we even need the
mode in DT? If so, I don't think we should add that code yet. We'd be
adding an ABI that we don't know how it will be used or if it is even
sufficient. Granted, as long as nobody uses it we could probably just
silently drop it again, but why risk if it's just dead code anyway.

If I understand the half-bridge converter application correctly you
would want to model that with pwm-regulator and instead of using a
regular PWM (normal mode) you'd use a PWM_MODE_PUSH_PULL instead. Is
that really all there is to support this? Does the voltage output of
the half-bridge converter vary linearly with the duty-cycle? I suppose
one could always combine the push-pull PWM with a voltage table to make
it work. I'm not opposed to the idea, just trying to figure out if the
pwm-regulator driver would be viable or whether there are other things
we need to make these setups work.

Thierry

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvIp58ACgkQ3SOs138+
s6FSrxAAkjdTRIoPaHkcXlwkwivOvbKCFuz5/wExjR5tKl2rPJjfRmlWZ06FZiVl
EPJ3N2tSJmgklZE67QsO8I5U63gN7pRSao+lMz3rD44fg0eathO9a5+9C2wZ1lMh
HXSts7shjoKJFZTxqDhy50vpkofdasnC+WG5vy5SOtmoS3M3PGSy8xwznsRbvgOY
BOrt/mWmP93lucz4DQOd0TR/buMlkH4EI/PEmW2eMgKl06jLQjF/J//4jkwSASwV
3r6S2tT4h9oc1ta3uqwtHpcYFxr8d9sjpEkOQMvO8cjw/Z9DP/HKqMgi+a9Mci9L
dCsthKCYk9KO5KSzuGGYblKxKWEnzOCfUNz9puLKB3zzI0WwmNH4F5AJk+29gJtD
+iBU58t4Qi+sULq4EVh/Auc4+4kMAusXk+FM2NLCjgFBASR65i4/c1pTfxSjH/cb
xe0m5wBoORk2CfUzTGbOXJ3oxLQJNQGh6sW4tu1jWAb7uH2GrlDaAIbemiAukk0W
x8CEF1PAdKdz38v0tCsytDAXVJwywcDMKm5HVFrl/B9diz8amJp3Um/nzD3+ljJo
voShgtHPv8IGx6mHI0HDax7150NEPRaT1fBMsPgIvdaGsvK7pTI2ZQgoxoMsj9b+
KtQImMge2P+l9REzE3TjQv9DkbBY2uXtkk/NJyxbJTbP1sVtmtA=
=dUyc
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
