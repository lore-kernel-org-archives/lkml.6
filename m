Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23529C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49E1240A9
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="GmE2NAmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49E1240A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeGERbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:31:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42620 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeGERbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N91yp6x5mF7LGeGz9ipRtV5s9V3upsUsK1TPuVWiVO4=; b=GmE2NAmoycbYTXSiz45Z3wn1y
        zPM/hnv0jmCAhYsmzjeGadz6XW7QGpTbn1tnfyZS78/8IycLrrRYmRfcjynambZAM8A8633Li3ZYp
        0iVl0H2KTQ+OGKhif0Egj3+bPtvTaed2cUDi0Yq352F7YEGAa/55kbNln9A2MBgnmL2I8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb85s-00011L-5A; Thu, 05 Jul 2018 17:31:00 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fb85r-00014Z-Ju; Thu, 05 Jul 2018 18:30:59 +0100
Date:   Thu, 5 Jul 2018 18:30:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: slimbus: add support to raw read/writes
Message-ID: <20180705173059.GF6227@sirena.org.uk>
References: <20180705113700.32465-1-srinivas.kandagatla@linaro.org>
 <20180705150857.GA6227@sirena.org.uk>
 <3c958e52-d720-c008-913b-4ff29ea35c00@linaro.org>
 <20180705165011.GC6227@sirena.org.uk>
 <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Content-Disposition: inline
In-Reply-To: <5c3bfd3c-f84a-3fa2-f6fd-5624fd052e87@linaro.org>
X-Cookie: Chess tonight.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 06:20:50PM +0100, Srinivas Kandagatla wrote:

> Access to codec registers is done in 2 steps.

> 1> Write page number in page register.
> 2> access register within the page.

> This seems to exactly what struct regmap_range_cfg gives.

> Adding ranges to regmap_config along with read/write bus callbacks works for
> me.

OK, great - that's what I was expecting.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls+VdIACgkQJNaLcl1U
h9Dwzwf7BS21OmgSCcrqCc2sl9oEx140R+UQLHXRJtXS0w1TF7H8JytRTOEle3ZI
UbZpdLxk3shYHRQpzTtauRPkfQbg4XLtPwO4WW/1bJCnOFAb2fXWZlGzHvdyy62h
+EeLJqaNZE0TIxM2AUV0VZu6FCxdWIyIdr5rq6rrBih9wmMYcB3xapZK6dryE9eu
qV0V+esNB2nU7X3SSC2nJM9aQPFwInPF9KTs1sZdnmOuklAY5N/LNQHUhRR0E2qU
5Ig8927m45O11qYffy44rq0I7EOxpW4Jw+cjcJIV3OWalUa32dJFdvg0RUqWY3NZ
Z7I530q+KUG8wvO4dKX8My7Y+HAjOA==
=RO5v
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
