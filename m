Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77846C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223E421770
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ZlYFNSz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223E421770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbeHGPzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:55:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50266 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbeHGPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T5U1JRJNvEfNwuzG4u7TCkCugCdeg52MioEYC4tTJSA=; b=ZlYFNSz1BuLmF+4ZSK/Axk7F4
        ZLHydMmNd7pv2Z/GzHIwh8nxeK6fG3PaBt7GEvnK9lRdNNga0pfanx444H9mtD6VfvtMHr/TDHxOQ
        efoIiKx9meSDShTpSgE6pS3BjCNQjP/rVuDYBEWcgK7NX4bpQwxMMYY8K00XyKY5fx6f4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fn2Ek-0000l0-D2; Tue, 07 Aug 2018 13:41:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B4BC1112433B; Tue,  7 Aug 2018 14:41:21 +0100 (BST)
Date:   Tue, 7 Aug 2018 14:41:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Message-ID: <20180807134121.GA7958@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
X-Cookie: Danger: do not shake.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:

> +Optional properties:
> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
> +	converted to the delay clock cycles = interval number * 4 + 10.

What's a frame here, and does it overlap with any of the existing delay
configuration we have?  In general it's better for this stuff to be
configured at runtime by the device rather than at DT time by the
controller since that way if the device needs the delays we always do
them if we can and if they are only needed some of the time (eg, for
only one device on the bus or for only some operations) then we don't
take the performance hit when we don't need to.

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltpoYAACgkQJNaLcl1U
h9AipAf8C3BTJ+JtWaUjns2mJPPiv5Ck30ahWS7xkS4zheh+pLz7a689zgEGwCfW
zqlaNz0G2RPcPmOG6Erur6AM4H1p13ymRNPEY9HDdOyGaiLyuYx3LhL7cCTcAdvY
3TbWIuEWTMxaOj8LTubqA9JGuWWcHsfAqqJxj/4a1GX/mFKWFh11K2utNEybziNt
1daiNHmNEsGf09Oz37PHpCm5q+zjD0ZfA4OkIknFY9x9ey/kt8eMkROtQjxwDSNR
D0/QmkL/OQ5nLGDohgl3MvwwNMJI1tP0iTs1eZSIHECGsfchVTpWjRsUYYy2DTCJ
lgLJ/7Yc2oFh5HZxACtltPVYBxmX+w==
=58R/
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
