Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD9C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49462171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548699045;
	bh=F/I3aQYUgGTvQa4hixqvHE51vmgeXanls7sjrsNRZzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ILLsdiLWLOHiGSp6MO+j2EPdPGbl5U70NmxIpbn70N2hc5o+unXPzOR1+EO9vIT5V
	 RS1ZBImfaoxnN7m20M/dchVOyRXcpOxsXwS2x9jIZqm1c2mRemarLtBIVjjz8mSgCG
	 cSzaGGWkelCXwv3m/G5+eT4OSAfjwDIclVDupfus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfA1SKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:10:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39840 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfA1SKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6rz65wMwPx6JKLj0U1uilByOkexizZwcOOx3zNkZijo=; b=q1IvTaynFHN1BL8y2u5k5Ulg4
        NIfPexZIfLk2CmjsCKouFG2BjmaoyVvLUPjpaVPY27GByqiCQukZ+wZeIG/hoEKRNPahVlLVYT88R
        O2bxqAxvva/7zarmzSLFl+8xoH3daRZdObubkoHdWwMISzbGlh8bcfiz7iO8plWzqMVrs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goBMl-00038Y-Mt; Mon, 28 Jan 2019 18:10:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B1A241127D29; Mon, 28 Jan 2019 18:10:38 +0000 (GMT)
Date:   Mon, 28 Jan 2019 18:10:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonas Bonn <jonas@norrbonn.se>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for
 devices
Message-ID: <20190128181038.GF11699@sirena.org.uk>
References: <20190126163220.26421-1-jonas@norrbonn.se>
 <20190126163220.26421-2-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <20190126163220.26421-2-jonas@norrbonn.se>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 26, 2019 at 05:32:19PM +0100, Jonas Bonn wrote:

> @@ -164,6 +166,7 @@ struct spi_device {
>  	char			modalias[SPI_NAME_SIZE];
>  	const char		*driver_override;
>  	int			cs_gpio;	/* chip select gpio */
> +	uint16_t		word_delay;	/* inter-word delay (us) */

This needs some code in the core joining it up with the per-transfer
word delay similar to what we have for speed_hz and bits_per_word in
__spi_validate().  Then the controller drivers can just look at the
per-transfer value and support both without having to duplicate logic.

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxPRZ0ACgkQJNaLcl1U
h9Ac7Qf+PnvdYqut3vqHiLuZnIkM0rUN8LzkQjuzbXAcNDhc1Mng0wacMxY8/197
iHfg/0ZtyZGvI3LXfVstZaUtryS7tT5sUzuf7zLhUMANNTPT73J+RxabEMojYVdC
gXAcYSvZklqJW1C8SPR+KyxvrrkVJzfTDOt1QjIP2RuKTzqqrXZMXsUyw+8ZveMP
kfDi8HPRqFwpN3TnofAUG8pXYFWUnuBqYBZtZ1p44E741r3DXPP2aT3JMNEvl3lI
Du0WLYv06i4T8VjinvD7aChUtWcPdBYBjh157S+/E7YExhJvqXFKav7BtPc54VJu
Z/iGAOazu9hGpRh6EnHpkMMyFfyNqA==
=ilNl
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
