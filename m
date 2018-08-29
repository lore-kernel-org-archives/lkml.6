Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A361BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419042083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="V/5EjNs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419042083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeH2SvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:51:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57422 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeH2SvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ogjZgVaAFNI7XWFWHBYtVz+qOnA4jZ3sO5MUfHwYjL8=; b=V/5EjNs5YTnuFphKy+xtCcAIO
        Sj+8b21rUb212IsrF9RAfv37zbRaMbwwuTf3bBb8nE/Rc3Kawv6wCLuc4B1PY5ONjidJJYxpuOwY/
        d5O+IPFQab0mCLs95CgOpb6StSpLblVa8xSEwY3uUFR9Ib3dj0fvRuWcSULfYCEOORqqM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fv1r2-0000Mr-0l; Wed, 29 Aug 2018 14:53:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8A646112486B; Wed, 29 Aug 2018 15:53:55 +0100 (BST)
Date:   Wed, 29 Aug 2018 15:53:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, florian.meier@koalo.de,
        cristian.birsan@microchip.com
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a
 WM8731)
Message-ID: <20180829145355.GD27808@sirena.org.uk>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
X-Cookie: Not every question deserves an answer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 29, 2018 at 05:47:26PM +0300, Codrin Ciubotariu wrote:

> +static const unsigned int wm8731_rates_12288000[] = {
> +	8000, 32000, 48000, 96000,
> +};
> +
> +static struct snd_pcm_hw_constraint_list wm8731_constraints_12288000 = {
> +	.list = wm8731_rates_12288000,
> +	.count = ARRAY_SIZE(wm8731_rates_12288000),
> +};
> +
> +static int snd_proto_startup(struct snd_pcm_substream *substream)
> +{
> +	/* Setup constraints, because there is a 12.288 MHz XTAL on the board */
> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
> +				   SNDRV_PCM_HW_PARAM_RATE,
> +				   &wm8731_constraints_12288000);
> +	return 0;
> +}

This bit is better added to the CODEC driver since it'll apply to any
system where there's this clock rate (someone else could come in and add
other rates, no need to do that yourself though it'd be nice of course).

That also has the nice bonus that with that I think you'd be able to use
the graph card rather than a custom driver?

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGs4IACgkQJNaLcl1U
h9BMcQf9HdY9EONm+yWwQ7kU0mb+CJjqPSHn4kRKd7wuVKMauN0RyzVZKPpdhO4A
Kp3reX0sY5uqvKk2V1zh7/ceOHoMM+l3g+Gj+tmWF2eXEcuovP9fFNZY2HPG1Tjw
eU+focC0h/2AiT/y//70B3FhDAjH/Chd4Jtqpmdm3qfmfNbFaw42eJS+oA2eBK/f
4ZRO0Q1uj3N1YnGOsrsRR3+wFveVoVf+zG7tPPQJYQICxXj5MZf9ExiWSjfTl6/b
VN/qXMdOMGOT/2EKJzSFRTWKu4WKlJOdURxnTzHgeXxas7DF63pEeXgKdq22yq/Y
7GVcZisHHftdm8xEdQpW5GsZaP60Ng==
=5Nmi
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
