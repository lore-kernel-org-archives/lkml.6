Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CED205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661237;
	bh=V6dxpkGFLLAT6rPyjGCl22hwTVuly61yFYw+Zrvr5Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IH1vB/o32y8RHTGQg0m1vu8TyDIL3yJ+fef2cktSJAuQZLEH2dnsysnNV5fs6rg9s
	 QTjCY5UU0ydx6RaT8VkedCQ2ke1gwHEzf+OQPfw6Shk1cND1ehL/4p+RD9tgNBG+3w
	 W/CpAR4DgfI3rb1gksgb3Qf1XTiVu9/gqMRzq8Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbfBTLN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:13:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45176 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBTLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vY5SRfJlXscVnhkSOWU6nMBR8roWZL4p/c9CNCphkvQ=; b=iNcY3W+2ZH3muYS9g67DmJSQr
        Ov5kZaR4VXggKGAA0k/j3J1dZ+gDRswqw4gfJEEMGiOUjDbjXxNyWICkDJddcABH1BU/4voOPd3OB
        1/OX3g+LV4P4D52xWBVJvaPMt1w5xjHZHP6Lqrt0S4xXMYQ0WwogwAfuGuQUOLmYAbx4A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gwPom-00011o-EQ; Wed, 20 Feb 2019 11:13:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7C2C611284DC; Tue, 19 Feb 2019 16:56:54 +0000 (GMT)
Date:   Tue, 19 Feb 2019 16:56:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     lgirdwood@gmail.com, dannenberg@ti.com, m-stecklein@ti.com,
        afd@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Message-ID: <20190219165654.GB20883@sirena.org.uk>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
X-Cookie: May be too intense for some viewers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 19, 2019 at 04:29:28PM +0000, Codrin.Ciubotariu@microchip.com wrote:

> The ADCs are sleeping when the SLEEP bit is set and running when it's
> cleared, so the bit should be inverted.
> Tested on pcm1863.

This definitely seems to be the case from the datasheet but...

> @@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
>  	 * Put the codec into SLEEP mode when not in use, allowing the
>  	 * Energysense mechanism to operate.
>  	 */
> -	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
> -	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
> +	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
> +	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
>  };

...we still have a bug on pcm1865 as we've got the same register bit for
both channels which isn't something that's supposed to happen.  Looking
at the register description this feels like it'd be better handled in
set_bias_level() or as a DAPM supply widget.  However that's already an
issue without this patch.  I am a bit curious how this ever worked for
anyone though.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxsNVUACgkQJNaLcl1U
h9AO/Af8CsANMFAV4KT3K/DF+qSVvEq+iLlU4Op5w9ozsNP/Mv4UpBuATJ5xOHe1
P7IkfODTQp3iep1B3u+ZtMLKkR8FuSVEg/fbAbraBuZ6veVH//8IUOXc57/heL7c
6z9/dnXPoGrAa1VMynaThm7e9aeX7UWo6LVZDSabN8UqOBSjvePTGVWPLxcpQhLb
ro8yf/Msaceurtyd4uPzS4TaIH0VD4z5TP41XyljM/04YmJiAU7OBHFtqTkP9Whk
H3JECDi4+SgLjk4RyUxlmYeMASjo/OEgDCzmLR1HgSRdqk4YNU15fenEl6xbWS4T
llmwXxGLVkX9TWb0IQOV+aKJa/w2rQ==
=e8Bn
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
