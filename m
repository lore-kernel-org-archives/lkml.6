Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E9420685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547061230;
	bh=1+ftpsYYagBkvr4RLXavv3zTdD8jlZgfewiROtO3LZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2oPciweUF0Acp7T6UHBTOzpY6ce9AbBMPi9w+zPO3pGdfaGTzZf72LuhEzupDimjQ
	 PNfthpUCRHS9ffi6IkbilPVtJV4Uscbq7+XjHVihCROy7s9Q5JIiaAvva9vU1G4dAY
	 jJPFXBprKctAsuPd8S9UWV5ZPi3J3hUghZiLAhdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAITNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:13:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46466 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfAITNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rP2MQHHcQg0feo7gjGBieN00kWqBcwsU1tDCQAfenSY=; b=kHuOjOJRNntwZWZS72g5qPDkz
        Fyoj5OIn0ISrJLmh+Sd6J+CrtnvK/Ue7mYdRD3t61kSuNT2oQLEqlNHHHxfnY4DkSqKu909qq3kVm
        WUdYopDSErqCHeIzYQuxS6B1CD7l5MzEDNOgNZJjts7F7jFMURjk1G3fQDoh6zQL6GgdQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ghJIR-0000vj-CM; Wed, 09 Jan 2019 19:13:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id C52E41127528; Wed,  9 Jan 2019 19:13:46 +0000 (GMT)
Date:   Wed, 9 Jan 2019 19:13:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     b-ak <anur.bhargav@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is deprecated
Message-ID: <20190109191346.GM10405@sirena.org.uk>
References: <20190109171121.GA12810@Ideapad-330S>
 <20190109183836.GI10405@sirena.org.uk>
 <20190109185124.GA15153@Ideapad-330S>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cGfB/trNgB3WtPHu"
Content-Disposition: inline
In-Reply-To: <20190109185124.GA15153@Ideapad-330S>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cGfB/trNgB3WtPHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2019 at 12:21:24AM +0530, b-ak wrote:

> > Note that the reason we've not done that already for everything is that
> > the DAPM graph needs updating for the new routing in machine drivers as
> > the two widgets are wired differently.  However this is fine here as
> > there aren't any in tree users I can see so I'll apply, thanks!

> And can you please point me to some documentation of the new updates talking about the
> differences in the routing?

Can't think of a specific doc about the transition but there are a bunch
of existing conversions like this:

2ca087bc9edafd7cd1e89d0ac61a31067985bd15 ASoC: rx51: Correct DAPM route for capture

--cGfB/trNgB3WtPHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2R+oACgkQJNaLcl1U
h9BnXQf/RKNjn9Jkj6uGJkyOD9wTMgqSIC9vTQ8clPyxFbKOjy850Gz1oagAgVEJ
pqQTGH+XRtVxOIHpZQuxFyCMNu1ijRsQNuh9M+5Pbq0uHo9jvidXd4Ivl1sV2EGl
6zF+DUXAtxZFkEuDfiDMAZMqWH2tzSL4ZGreBOkWXz/MaVl0nBQMxWfKpgyJRByd
9ZzQOwAG2O9YwiNwk+a+G//iREdBvR1KRAiBP3hHDxsWnVWoKsATDYC/U7Vzg9a4
4fYPiBgENcpycSa4AUQGHjFc8IdN0oDFRXiGInFdKyponD5G8mt0jq8Bi4KpzB9q
/JL1+2CrHnZuCwBhndZZwD7lWKWoiQ==
=14kA
-----END PGP SIGNATURE-----

--cGfB/trNgB3WtPHu--
