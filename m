Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF192C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F12084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544538609;
	bh=HS57lYH7JptwNtPF4OwkNLWuULlu/aMyD06HHgWcovw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fhRvsRrOAhPOnvzcpPZSgdLMIWI2JAH3611sShm0VjPRPeLRF1IfKKdAqQy8mtVX/
	 h9UqjNQbNecI5Qdx+Kd5+44Q0eRBsLYWkMmVbQpZE2mwJMsV4CQXzUouB4TYspRoNS
	 sSvGYHsBGWl6m/RaALnFGuNrjKVD9Elm9ZxrvXi0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1F12084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeLKOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:30:07 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56264 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeLKOaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HS57lYH7JptwNtPF4OwkNLWuULlu/aMyD06HHgWcovw=; b=w48UEWvgc7kusQWgLC2b2hIv5
        I5lzC9n1432G9a9wS9Ic44FDCTpMPqv58Iw8owGTtE+WXszDi7TosAQO2nge5QPZEweJ1fjR6/8mj
        gjgsle7DlJ5oezFhuKQyVpG3dA2hX4H5sq7ewswdKfUw7w7qgm7hDyYOR2dVboafjtey8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gWj30-00017W-6N; Tue, 11 Dec 2018 14:30:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CE83E112540E; Tue, 11 Dec 2018 14:30:05 +0000 (GMT)
Date:   Tue, 11 Dec 2018 14:30:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Message-ID: <20181211143005.GJ6686@sirena.org.uk>
References: <20181204062224.28844-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <20181204062224.28844-1-xiaoning.wang@nxp.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 06:23:19AM +0000, Clark Wang wrote:
> Remove Reset operation in fsl_lpspi_config(). This RST may cause both CLK
> and CS pins go from high to low level under cs-gpio mode.
> Add fsl_lpspi_reset() function after one message transfer to clear all
> flags in use.

This doesn't apply against current code, please check and resend.

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPye0ACgkQJNaLcl1U
h9BAygf/dnLhg3GtANkZTYpKtHYETF7XJSIoWNyd9k0A9sJ5RoRZsze7LKQwR7rz
D6PtMkNEv5HJDLOYZLz19V1TuTSwRHAKJ3w4Lz+Yb6vl9guscyXTncXcv3steZX5
nSZQgWl2aBGKynQy5/lv7uOlLr6hcCZFkZq0sD183oPGCw7HPqMokISo+FQPndUh
ZKNVqpcEF5YZJJE0YPbrGp0rHqW4AaLdYDuOrM6zgwqmdu0G1eZkNNww9ulI0g1N
mzB+tUd8Oup0u/LfyYQcfNpcfgaf2h5m2+rL5snG8CVSF0gHFPQHyojfev4QGfZS
ppfXA3gov1qTmMysUM25YMpq52mRIA==
=pMcg
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
