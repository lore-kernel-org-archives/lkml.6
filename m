Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C350913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7135D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rlzDHQDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7135D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbeG3L4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:56:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37310 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbeG3L4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jDTTyW2KUl6ulW67CVRcrexsvc5Sg/CrnTnoSP+kCGM=; b=rlzDHQDkTJC+J7l+QrD5BHrBL
        gXnn+S9MC3fpX9futgF8t3KTHc/hnRSbLsOJAUw1iTiMUQuxjcO+SZ+2KwxcpsxTVDqwLMw/vOye3
        GxkYudYzZhXgBHjy+A9i1vdZ4NsngC4HFBTm/HOtgeTeLCnoi7puQx9k5xfWkR4qXc1Us=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fk5JB-0004wI-VY; Mon, 30 Jul 2018 10:21:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B0CAC1124216; Mon, 30 Jul 2018 11:21:45 +0100 (BST)
Date:   Mon, 30 Jul 2018 11:21:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, lgirdwood@gmail.com,
        thierry.reding@gmail.com, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 4/4] ASoC: tegra: i2s: Add support for more than 2
 channels
Message-ID: <20180730102145.GG5789@sirena.org.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-5-jorge.sanjuan@codethink.co.uk>
 <d81d5c3c-2b2f-308f-d98e-d39c5d5d147f@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <d81d5c3c-2b2f-308f-d98e-d39c5d5d147f@nvidia.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 30, 2018 at 10:46:14AM +0100, Jon Hunter wrote:
> On 27/07/18 13:59, Jorge Sanjuan wrote:

> > -	if (params_channels(params) != 2)
> > +	if (params_channels(params) > 8)
> >  		return -EINVAL;

> For normal I2S mode, channels should always be 2 and so it could be worth checking
> if we are using TDM mode here or not.

Yes, there's some question if a multi-channel I2S setup is going to be
all the left channels then all the right channels, have multiple data
lines in parallel (this especially common for high end applications) or
something else.  Usually it's safer to use a DSP mode for those.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlte5rgACgkQJNaLcl1U
h9Az4wf9ENuJw9xHWLzCcUCojvR2r6t/dd8C4zfCSklN8D/pL24kyXy+HXtDXgqw
dzYaYCL27iECyw16JmuMzM3U/vnnOTIxamjlcCF3/6BjBxYaJJ94gZP3RBLImrDF
bCga+cNlb3FK0D7FEpyFSlSvREN3ZBpG5H+Da0vhdHZxglKYFsvqkjzJABamiGDK
u3ryKn9BWMWVFITB5X9o24f902wdc2DY/ErIfCB5nQbmSLPXU7dAJ/3I7YmNSOLD
8HiHKm74QIAtiDzZT3Sv+kZ8EgAbp8XmkWs/PGxoN7eveBbAJpEQHewQ99ystzKy
tJNxVjlj1mGVRCxIsi+vNT1JAm9+RA==
=moNh
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
