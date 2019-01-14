Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15772C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68FA205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547508382;
	bh=2eL9FfZw5+x1ON1pP7ckfn89Hi6sDq/th32LcZM1P9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oYdNoDn9cESlXrG+bnbws0q1kjmbqexVFjvcLm+9BdxR9UTO/Rxh/GhwpeKbouK8n
	 Q0DQISDFdr1olkTF1tYrlCdCTvK8TPNMPhQ8uJ5CfZolJ8bEb3sVZ4gQ0oKOEjbkrM
	 PEY3Fp2T6xD+toz4cIVVBQyc5HWD4AOK/96ytQ/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfANX0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:26:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49120 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANX0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fTRdVUeIWSZPSxdjBAm8/oj3dAC2FX4vyyd3C1OrkkY=; b=oTIcZ0sBjWIFJk0trYwMPdQbB
        yQvTRTEGk9GfxiXWdPgjbdHEf7q8aKvG2HLO2yh7j/KjmkFWlMqxibQX3Ijmp1IlrrcXDQ9b2aCQV
        ZJrm8lE/gJujXdt8Flg+mrcrxctBIrr+01J+XByldpxRJ7CvKLo04y32RvvDNZTidruYU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gjBcO-0000fQ-J9; Mon, 14 Jan 2019 23:26:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1B6961127AD1; Mon, 14 Jan 2019 23:26:08 +0000 (GMT)
Date:   Mon, 14 Jan 2019 23:26:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, vinod.koul@linaro.org,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer dereference in
 soc_find_component
Message-ID: <20190114232608.GL11073@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/jkxxxtAhYIHVDuh"
Content-Disposition: inline
In-Reply-To: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/jkxxxtAhYIHVDuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2019 at 01:44:02PM +0530, Rohit kumar wrote:

> -	if (!soc_find_component(link->platform->of_node, link->platform->name))
> -		return -EPROBE_DEFER;
> +	if (link->platform->of_node || link->platform->name)
> +		if (!soc_find_component(link->platform->of_node,
> +					link->platform->name))
> +			return -EPROBE_DEFER;

If we need to do this for every user (which we do pretty much it seems)
we should just be doing it inside find_component().

--/jkxxxtAhYIHVDuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9Go8ACgkQJNaLcl1U
h9A11Qf/Yrxphh6cv8p+IFzDXG9ACozaoDAZvSVV28Vk8dLUNepecWcgeJs1Y5bQ
bbRy093mTSg7itKQBgYok76GwpdQOQbtGVHgVQqvoY/1Ns2M/UZF2bYIfRV6JRUS
RD/lUVc5K+2xz9bOvte60oMNwjBurRYv1kMdv2t7gQ3GPx8p5Jkp8MBREULYCRxG
BnYgpCO7nneoRa5617M9QctJvcEbTAi7IGCoSyHufrAcMh7KbWcGsK2vu4M8Muen
f1ThSHZ0esdV8elN3niT2mRMN49ZbyNE5FOIc8brEg9gkG7SSuRDFsFLu172a3iQ
oiJBUJ/cUCcqjIuGgvKOQ0q37CyHlQ==
=IF84
-----END PGP SIGNATURE-----

--/jkxxxtAhYIHVDuh--
