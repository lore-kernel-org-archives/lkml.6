Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C522C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA61218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545239257;
	bh=a8GVsQ/7nLmsJWL7WGBaDcBh0gQolyOwaPDxLUZ/t68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uzbNspDmu2dk6l53/W8Tm7DIpatHyTCo5pNjqAUyfwxL/woSZtSxYhr5s8E5iYnoj
	 Bkxn3SDf7BpW5Rq5ogNvPA8R2MTL2FtdTj+QRs7EHFD05C36K9JyQqz7ztJRvY7i/0
	 tmAQDi1mnN0teT15nX+graifMynkHkpI+6Q94qKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeLSRHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:07:36 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57306 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeLSRHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a8GVsQ/7nLmsJWL7WGBaDcBh0gQolyOwaPDxLUZ/t68=; b=jLA6Qt+OyXYVcVL5DdkLVAlZp
        js5Dcnj8YUAn501lLoY47bMGTb9B0ulg26y9RFon28scCd7+HtzdValsg6OfaciaUkRiKF3Dqrrgy
        u4m41KmlkJlEYpVxOfWyWTlfjQwkYO6Otmxw9V/IHzTg9oeIE9bm9qk5Q1ykovbF+fv9o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gZfJd-0004wI-S1; Wed, 19 Dec 2018 17:07:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7F65611259E9; Wed, 19 Dec 2018 17:07:25 +0000 (GMT)
Date:   Wed, 19 Dec 2018 17:07:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, tony@atomide.com, robh+dt@kernel.org,
        bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
Message-ID: <20181219170725.GH8130@sirena.org.uk>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com>
 <5C191770.9090804@ti.com>
 <20181219123812.GC8130@sirena.org.uk>
 <5C1A670E.9020904@ti.com>
 <6ebcd7a6-6c85-0312-0651-fb4fbfc25e55@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OpLPJvDmhXTZE4Lg"
Content-Disposition: inline
In-Reply-To: <6ebcd7a6-6c85-0312-0651-fb4fbfc25e55@lechnology.com>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OpLPJvDmhXTZE4Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 04:48:52PM +0100, David Lechner wrote:
> On 12/19/18 4:43 PM, Roger Quadros wrote:

> > Did I do something wrong or we just need to enhance regmap_debugfs.c?

> Do you assign the name field in pru_regmap_config and
> pru_debug_regmap_config?

Yeah, you'll at least need to override the name since the default is to
use the name of the device and that'll result in two duplicates.

--OpLPJvDmhXTZE4Lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwaeswACgkQJNaLcl1U
h9CWTgf/cZZEo8eNvdP0IgoJxnEy5fJxkfHTYDHzFjKXEovpTMdbnC+dgc/WvYbO
o0qfaHP+agPemGH3W834AbDSeBkZaqBNB691gebui1/Ftw3nsUwIQWSyHwmpoykX
mz7yRf5fedk+Pk00fknshzGzzSeNb1u73Wgb7FJCv9fThM69UlqDKSBbgLBLIEnH
WLGRU1BuT7wkkyJLJ5vOelap29aoBu+YklsYcQ4ugenHchTsSq+G0dCFseXvbTvc
qei2xzObUNpkSH3hGuwWJTGWdI3YaQR4x/nc+VEWjdFShLZA6nBwjSPY86gzJ/rH
/DFZAcI1IZ8Xx6fcBNidicCRRQ0W9w==
=ZIqH
-----END PGP SIGNATURE-----

--OpLPJvDmhXTZE4Lg--
