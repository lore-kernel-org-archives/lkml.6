Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CA8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F4D21920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550231849;
	bh=PCYa+c0eCnbIu+HxFarqiypOUw21U7WcHvRIJKETVIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UiMeVddeqiceArJ2KKKkRsucSc7nxjbpNgq5PadjB86SxJD/Z4GbNxTTu1dTEOw1g
	 JC8rjGbQ/95F/Zb7umYYZueMd+f/5BCx73uxnaNHL+Wsh5vAGUnuNAIAWCM5002MCM
	 Wh9+8tB3MVXW45BqNFpPFvl/wdUGiw3PxrPK1zCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436862AbfBOL50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:57:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33374 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436815AbfBOL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PCYa+c0eCnbIu+HxFarqiypOUw21U7WcHvRIJKETVIc=; b=stYm10rQF5ZASlz5rVMf/PZ5j
        ZpFMDgtKt3WC0t44WTGIIpjDwxexdgLwK4GNZ9aH+6GlCvgdmwn2o7PI55Z9dJGThUfno8J2qej6z
        xu+1dWj1oAiJ8c8jT2GzOAg8UTj3LY7byKlIqinSFcIDbhBEHXa++tSDR8SF0f0WbYz44=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1guc7F-0006Ep-Vl; Fri, 15 Feb 2019 11:57:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0177D1127748; Fri, 15 Feb 2019 11:57:12 +0000 (GMT)
Date:   Fri, 15 Feb 2019 11:57:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH AUTOSEL 4.20 06/77] ASoC: soc-core: defer card probe
 until all component is added to list
Message-ID: <20190215115712.GB7897@sirena.org.uk>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20190215020855.176727-6-sashal@kernel.org>
X-Cookie: Neutrinos have bad breadth.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 09:07:44PM -0500, Sasha Levin wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> [ Upstream commit 8780cf1142a59568a3aa77959cbd76b2edb6fd81 ]
>=20
> DAI component probe is not called if it is not present
> in component list during sound card registration.
> Check if component is available in component list for
> platform and cpu dai before soundcard registration.

This is a really bad idea without also looking at surrounding commits -
taken randomly by itself it's more likely to introduce regressions than
help.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxmqRgACgkQJNaLcl1U
h9DWjgf6AlWLAxR1hL6HIkwlHJH4eF9gc0iLXBTZ6K89SoQjv5OjnR2dh794cxzr
OMVuVRQ0ChIJAj88S4ylZytsB6V1dKrRq3sazR746BhzM7nr8tY4dMPSkRi4hjeC
8YL1o2A57T5Q1Hj0fQOXcr9Lu2Qf+ZUcP2lQLEfv8FFkCtJ2uPhVD+264jHY+Y/c
8HzqKE29oKgIxc5UHPFBH+kMM0ljGWpXaNiAHAjtAh7HzF7NxGXcWjTzYd+Z7H/K
HQ2sWooOnCwdYHwqdyIQrtMaIeAAiUKoIVjRdggZbXa9BkAPp3BqBTJlczFha850
ESR7GqP1rXrCXr/FpPjpNeeYkoG0Qg==
=0ttp
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
