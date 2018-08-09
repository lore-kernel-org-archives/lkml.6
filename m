Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488CDC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C3A21AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vDhL4AGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C3A21AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbeHILzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:55:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeHILzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fA5g6wm5ulNWtSt+N7KAK4ryYP04tDqpEVFKAdRBcD0=; b=vDhL4AGfpCgiCruZokhiWuocz
        tP0EuilM52dztWvXdEvKIuKxHoGsd/2pyPZxZOyGJCnezI59LUckWAsBcSOhwIr8WmT7uMyuD1gIj
        PLEFwTPMkPXCjsSvMD5E+LirsihI2CApHfFsN1OB6RhDKAjSo4XgzIBf/wSnLo0E7DIrY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fnhHZ-00039n-5j; Thu, 09 Aug 2018 09:31:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E1EB01124340; Thu,  9 Aug 2018 10:31:00 +0100 (BST)
Date:   Thu, 9 Aug 2018 10:31:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: adau1761: Mark expected switch fall-though
Message-ID: <20180809093100.GC6132@sirena.org.uk>
References: <20180808192213.GA27872@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20180808192213.GA27872@embeddedor.com>
X-Cookie: UNIX enhancements aren't.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 02:22:13PM -0500, Gustavo A. R. Silva wrote:

> @@ -518,7 +518,8 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
>  			ARRAY_SIZE(adau1761_jack_detect_controls));
>  		if (ret)
>  			return ret;
> -	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
> +		/* fall through */
> +	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE:
>  		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
>  			ARRAY_SIZE(adau1761_no_dmic_routes));
>  		if (ret)

Again, are you *sure* here?

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsCdQACgkQJNaLcl1U
h9BuQQf/TCi8yGlYZEF7RX3gN++hw95VcrRisZ+dRCCSqvNLd7HLThruScE2erOa
TDNlOUChGODOjFc4cDhR2XJPFi8+RtrU6TNEyjGZiwtAnY129PS7SdVHrKsFAUQH
nidn2ogCbeC0uSJCYwXCSRdSmXDKDMJQg9GBQvlmopDTFGDyF8wA3GiiGKXl31kz
gM3AN/TstSfFxnVeQYC69XJm7/apOmuWQ/kUsTotH8U+g3/5wbCLcX37Yx7+bp62
65/X0x2jgOXa49lONaoO/LuR1IFPb7DytV0jyihk660w0V3pLxB05pk3hMs1Mq8v
LrUeF8oOt79DYGEm+FCNvBTwsr5Xlw==
=P1Yl
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
