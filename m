Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE6EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F64C21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqlD9485"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F64C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeJSACX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:02:23 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39172 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbeJSACW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:02:22 -0400
Received: by mail-wr1-f45.google.com with SMTP id 61-v6so34287358wrb.6;
        Thu, 18 Oct 2018 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IKA0pxSLyzacMEIY+icLmzBmr0Mc5Eo0Y+wHBqiksFs=;
        b=MqlD9485z+IFA9orVBnJ5m2fRwQFNkVv42MMKorRt73Gj+TbDGec9KOJJCGv9fJaGH
         mF+oe5FA6NFMY9O14dagcFu55ihQNp4oh/tDRVaosssB4DRNB/VCkUKl1nTGbe5bTt79
         Fq9ccV58ROg2Ozerq7h16n6XdSwziI6oCwe0pbsCyn67J9KWA0SnOgAlWhxxsHoUbtuD
         tbayT/kWVJKJb2XLeeGR3dG453eCDgbJ/OLmd2Ge/83+D5TPuhqcy/obVyno6ayaJwh/
         OBRf24E7wT8Hg2SgoUfuj90lw/eFPglG/qT9OelP4S8PsczGazsiwKulrAIugiBcXb1a
         I0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IKA0pxSLyzacMEIY+icLmzBmr0Mc5Eo0Y+wHBqiksFs=;
        b=sTDRU5NSprBI59tXeAa4+mSAKudr0urtYf9vx/YkNFhMcNlzTOi/sX+oXeHLE9eKI/
         i0GJPgkYBkZsgxC/NkCzjT9l0eszybZXcgvGpTAtvsw3ViGkHadVguNHMTVjCPvRyGrt
         qbB4pGtKj4BlWVUU78llHrE8eC+vz1j+5BiffLIHf8lrkwT8yQscmNMFLRTeYEDnQCkx
         BE5Zih6xR4qcZ68Z6mjwcJ2vrApsGHJw1/OVuqVc4ld3c7TnJpEZevN8LhWe/Huz7ICK
         1SdfdKkeTTy4G7mAabsFvMZMe1Ih/IdtvLtP473Elhg8HNfps1VpXHepkayRfWRvcpIZ
         R5Ig==
X-Gm-Message-State: ABuFfohEmvAQuv6vAuHtzfv52csvcXpIgwIzQcUsqBl54rUqLgObFgOY
        M4z5J1inWrkXFnAAWcqAz0+ud/KB
X-Google-Smtp-Source: ACcGV61+WYxcgfsjv9AGK6hkJ/EPCWddRMNi2Fedf+c42FoygfsfuTHYekwbyjiFqXO3lil5VsYsvQ==
X-Received: by 2002:adf:c3cd:: with SMTP id d13-v6mr31001195wrg.68.1539878441024;
        Thu, 18 Oct 2018 09:00:41 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id g15-v6sm15076883wrp.56.2018.10.18.09.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 09:00:40 -0700 (PDT)
Date:   Thu, 18 Oct 2018 18:00:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu.Beznea@microchip.com
Cc:     Nicolas.Ferre@microchip.com, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, linux-pwm@vger.kernel.org,
        treding@nvidia.com, shc_work@mail.ru, mark.rutland@arm.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [RESEND PATCH v5 0/9] extend PWM framework to support PWM modes
Message-ID: <20181018160038.GD6226@ulmo>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <b95d0de2-1a97-36f0-03ad-3b5e52b1fa5d@microchip.com>
 <20181016120321.GG8852@ulmo>
 <fca49cff-f883-baf4-4bd3-80f45635bb5a@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <fca49cff-f883-baf4-4bd3-80f45635bb5a@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 12:41:53PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
>=20
>=20
> On 16.10.2018 15:03, Thierry Reding wrote:
> > On Fri, Sep 14, 2018 at 06:20:48PM +0200, Nicolas Ferre wrote:
> >> Thierry,
> >>
> >> On 28/08/2018 at 15:01, Claudiu Beznea wrote:
> >>> Hi,
> >>>
> >>> Please give feedback on these patches which extends the PWM framework=
 in
> >>> order to support multiple PWM modes of operations. This series is a r=
ework
> >>> of [1] and [2].
> >>
> >> This series started with a RFC back on 5 April 2017 "extend PWM framew=
ork to
> >> support PWM modes". The continuous work starting with v2 of this serie=
s on
> >> January 12, 2018.
> >>
> >> Then Claudiu tried to address all comments up to v4 which didn't have =
any
> >> more reviews. He posted a v5 without comments since May 22, 2018. This
> >> series is basically a resent of the v5 (as said in the $subject).
> >>
> >> We would like to know what is preventing this series to be included in=
 the
> >> PWM sub-system. Note that if some issue still remain with it, we are r=
eady
> >> to help to solve them.
> >>
> >> Without feedback from you side, we fear that we would miss a merge win=
dow
> >> again for no obvious reason (DT part is Acked by Rob: patch 5/9).
> >=20
> > First off, apologies for not getting around to this earlier.
> >=20
> > I think this series is mostly fine, but I still have doubts about the DT
> > aspects of this. In particular, Rob raised a concern about this here:
> >=20
> > 	https://lkml.org/lkml/2018/1/22/655
> >=20
> > and it seems like that particular question was never fully resolved as
> > the discussion veered off that particular topic.
>=20
> 1/ If you are talking about this sentence:
> "Yes, but you have to make "normal" be no bit set to be compatible with
> everything already out there."
>=20
> The current implementation consider that if no mode is provided then, the
> old approach is considered, meaning the normal mode will be used by every
> PWM in-kernel clients.
>=20
> In of_pwm_xlate_with_flags() the pmw->args.mode is initialized with what
> pwm_mode_get_valid() returns. In case of controllers which does not
> implement something special for PWM modes the PWM normal mode will be
> returned (pwmchip_get_default_caps() function has to be called in the end=
).
> Otherwise the pwm->args.mode will be populated with what user provided as
> input from DT, if what was provided from DT is valid for PWM channel.
> Please see that pwm_mode_valid() is used to validate user input, otherwise
> PWM normal mode will be used.

No, that part looks fine.

>=20
> +	pwm->args.mode =3D pwm_mode_get_valid(pc, pwm);
>=20
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
>=20
>=20
> 2/ If you are talking about this sentence:
> "Thinking about this some more, shouldn't the new modes just be
> implied? A client is going to require one of these modes or it won't
> work right."
>=20
> As explained at point 1, if there is no mode requested from DT the default
> mode for channel will be used, which, in case of PWM controller which are
> not implementing the new modes, will be PWM normal mode.

I don't think that's an issue. I think what Rob was referring to and
which mirrors my concern is that these modes are a feature that doesn't
extend to typical use-cases. So for all existing use-cases (like LED or
backlight) we always assume a PWM running in normal mode. Now, if you
write a driver for some particular piece of hardware that needs a mode
that is not the normal mode, the question is: wouldn't that driver know
that it wants exactly push-pull or complementary mode? Wouldn't it have
to explicitly check that the PWM supports it and select it (i.e. in the
driver code)?

Say you have a driver that requires push-pull mode. It doesn't really
make sense to require the mode to be encoded in DT, because the driver
will only work with one specific mode anyway. So might as well require
it and have the driver check for support and fail if the PWM is not
compatible. This would likely never happen, because hardware engineers
couldn't have validated the design in that case, but there's no reason
for the mode to be specified in DT because it is fixed by the very use-
case anyway.

Also, leaving it out of DT simplifies things. If you allow the mode to
be specified in DT you could end up with a situation where the driver
required push-pull mode, but the DT specifies complementary mode. What
do you do in such a situation? Warn about it and just go with push-pull
anyway? Then why give the users a way of screwing things up in the first
place?

> 3/ If you are talking about:
> "Also complementary mode could be accomplished with a single pwm output
> and a board level inverter, right? How would that be handled when the
> PWM driver doesn't support that mode?"
> This complicates the things and I think it requires extra device tree
> bindings to describe extra per-pwm channel capabilities. For the moment,
> with this series I've stopped to only have the capabilities registered fr=
om
> driver. My understanding is that this could be accomplished with extra
> device tree bindings in PWM controller to describe PWM channels
> capabilities. If you also want me to look into this direction please let =
me
> know. And also, suggestions would be appreciated.

I think this is very interesting, but I don't think this needs to be
done as part of this series.

> I know that Rob acked
> > the DT parts of this, but I suspect that this might have been glossed
> > over.
>=20
> If this is about point 3 I've emphasize above I would like to have some
> inputs from your side, if you agree with a behavior like having extra DT
> bindings. The intention wasn't to left this over but to have a better
> understanding of the subject. I'm thinking if it is ok to have modules
> outside of the SoC that model a behavior that could not be controlled from
> software (it could be only hardware) but to behave in a single way. Take
> for instance this scenario:
>=20
> - new DT bindings are implemented to specify this behavior per channel
> - hardware modules are soldered outside of a PWM channel with one output
> - the new DT bindings are not specified for the soldered PWM channel
> - user enables this channel, it will have only normal mode available for =
it
> to configure (because the new DT bindings were not provided)
> - but the real output the user will see would be in complementary or even
> push-pull mode.

I think we could possible model this as a "logical" PWM in DT. We could
for example have something like this:

	/ {
		...

		pwms {
			pwm@0 {
				compatible =3D "pwm-fixed"; /* or whatever */
				pwms =3D <&pwm 0 40000>; /* input PWM */
				mode =3D <PWM_MODE_COMPLEMENTARY>;
			};

			...
		};

		...
	};

The above would model a logical PWM that is driven by the specified PWM
in normal mode but which is effectively complementary because of some
additional circuitry on the board.

> > To restate the concern: these extended modes have special uses and none
> > of the users in the kernel, other than sysfs, can use anything other
> > than the normal mode. They may work fine with other modes, but only if
> > they ignore the extras that come with them. Therefore I think it's safe
> > to say that anyone who would want to use these modes would want to
> > explicitly say so. For example the sysfs interface already does that by
> > changing the mode only after the "mode" attribute is written. Any users
> > for special use-cases would want to do the same thing, that is, drive a
> > PWM in a specific mode, on purpose. You wouldn't have a "generic" user
> > such as pwm-backlight or leds-pwm request anything other than the normal
> > mode.
> >=20
> > So my question is, do we really need to represent these modes in DT? The
> > series currently doesn't contain any patches that add users of these new
> > modes. Are such patches available somewhere, or is the only user of this
> > supposed to be sysfs?
>=20
> For the moment, no, there is no in-kernel user for this, only sysfs. I had
> in mind to adapt the use of these new mode for PWM regulator for scenarios
> described in [1] page 2126. Anyway, since these patches doesn't introduce
> any user other that sysfs it will not disturbed me to drop the changes. By
> the time I or someone else will do some other changes that requires this,
> the DT part should also be introduced.
>=20
> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

Yes, I'd like that. The half-bridge converter certainly sounds like
something that may be able to use the DT bindings that you specified,
but I'd be less concerned about these changes if we had actual users.

> > I'm hesitant to move forward with this as-is without seeing how it will
> > be used.
>=20
> For the moment only sysfs is supposed to use this.
>=20
> The PWM specifier flags are somewhat abused by adding modes to
> > them.=20
>=20
> I see.
>=20
> I think this hasn't been completely thought through, because the
> > only reason to specify a mode is to actually set that mode.
>=20
> Maybe it wasn't clear understand, with the current implementation if no
> mode will be specified the default mode will be used. There is no impose =
to
> specify a mode.
>=20
>  But then the
> > DT ABI allows a bitmask of modes to be requested via DT. I know that
> > only the first of those modes will end up being used, but then why even
> > allow it in the first place?
>=20
> I had in mind that I will change the PWM regulator driver to work in
> scenarios like the one specified in the link above.

Yeah, that sounds like it would be reasonable from a quick look.
However, what I don't quite understand yet is why the mode in the PWM
specifier would need to be a bitmask. Take for example the pwm-regulator
case for a half-bridge converter. If your board uses such a setup, then
you absolutely must drive the PWM in push-pull mode, otherwise the
converter will not work, right? So you want exactly one mode to be
applied. Then why complicate matters by allowing the mode to be a
bitmask? We could just as easily reserve, say, 8 bits (24-31) for the
mode, which could then be identical to enum pwm_mode.

> > And again, even if we allow the mode to be specified in DT, how do the
> > consumer drivers know that the correct mode was being set in DT.=20
>=20
> PWM user will call at some point devm_pwm_get() which, in turn, will call
> of_pwm_get() which in turn will initialize PWM args with inputs from DT.
> After that PWM user will, at some point, apply a PWM state; if it is
> initialized with PWM args initialized when devm_pwm_get() was called then
> pwm_apply_state() would fail if no good mode is provided as input via DT.
>=20
> Same thing happens if a bad period is provided via DT.

But that only checks that the DT specified a supported mode, it doesn't
mean that it's the correct one. For cases like pwm-regulator this may be
fine because the driver ultimately doesn't care about the exact mode. If
you have a driver that only works with a specific mode, however, it can
be problematic.

> Let's
> > say we have a consumer that requires the PWM to be driven in
> > complementary mode. Should it rely on the DT to contain the correct
> > specification for the mode? And if it knows that it needs complementary
> > mode, why not just set that mode itself?
>=20
> I'm thinking it's the same way as is with PWM period which could also be
> provided from DT. In the end a bad period value could be provided from
> device tree. E.g. Atmel PWM controller could generate PWM signals who's
> periods could not be higher than ~0.6 seconds. If a bad value is provided
> the pwm_apply_state() will fail.

I understand that. And it's good to validate these things in the driver.
However, the PWM driver can only validate for the PWM that it is
driving. It doesn't know if the consumer has any special requirements
regarding the mode. So if the PWM supports push-pull mode and the DT
contains PWM_MODE_PUSH_PULL, then everything is fine as far as the PWM
driver is concerned. However, if the consumer driver strictly requires
complementary mode, there's nothing the PWM driver can do about it. So
we either need the consumer to be able to query the mode if it has any
specific needs and refuse to use a PWM that has the wrong mode in the
specifier, or the consumer needs to explicitly set a mode, in which case
there's no need to have it in DT and the PWM driver needs to reject it
if the PWM doesn't support it.

Thierry

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvIriQACgkQ3SOs138+
s6H7QA/9ElNhAyj6YqA+2QhAygxb253G48hRj3u8JZANzJV9HzKK5xFqjAhzMUlr
1/6SB+55FYRo0IUTDb6JNevNgtN44M/J4E5tyOJ/Yt3KOhRyPCDisBOp0oqmJVqj
hOrhtbb2+nb1u/VrtSCPpjA8dhx+JhC0VSaoTSqc9XsGKpULu+zMrckJiG9AyuvQ
+5N3+l0LuizfBc9m53z77T/TnTws+4RkteAOao5KGB3rQG1EhzXcY0bd4TgE3Cur
WF4X4PclpE23D8SZrGjgau+dKQ7k1LB7cwumsv1ArfVfcUStNg/K4+/3CwQH0njC
nE+4rIGCi+8TMyODPIVH4105TJbCpv5AhAGrP0c399LTkwkDaGM/xYTDyx2QRXru
2kKsi0LAlISIl0F20Y8spGi1R3wlP+2ghJtic6K8xE63mXigULQTjF5l1Unq24W3
8TcWu4qNX2XTl0txiGf/bQjNSbzBLp9+Dpdaud/ETWhEa3jYySjiG+cvMy1++gu2
YQjpu2zJ96w8FAe0kq105xuT874yj3o+ngdgvZjs6psCZxtZgoWiqTPx4K9a4L08
M3j6dH5TBsVo0NK1lY0G0Qbdxuh0WarBYeOfru92FkEZZUG51ERDfSuQQqB0A/Tn
Oxl7bPXkffzC1op/edVHqs/4u9YX69neR2MAkD1B8DKxba8fnAM=
=9zRG
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
