Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD2AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27D425530
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="M4sc7AkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27D425530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeGBKGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:06:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeGBKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dhYL2KhVHTcYscNzOEtsaJCKecqREW9UCKeVmPiyl+o=; b=M4sc7AkOL505QDPT3zQI7Tsxj
        l4YH4vxgcWYq90CvWii8YkNyK+iHujBtODSOTDeuU+ocCd9hKhvyyr9f/bt+uUhfBw+NZO5PAJlWg
        5Sqm1nYaK/i9DeHr00h3GwezZemeDL2gnpOZwNXSMeQSJFCANEMdE/QGpR0QNC6VgNnCI=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvjJ-00042b-OV; Mon, 02 Jul 2018 10:06:45 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvjJ-0006BP-9v; Mon, 02 Jul 2018 11:06:45 +0100
Date:   Mon, 2 Jul 2018 11:06:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: es7241: add dt-bindings documentation for
 the es7241 adc
Message-ID: <20180702100645.GE18211@sirena.org.uk>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
 <20180630172241.10806-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Content-Disposition: inline
In-Reply-To: <20180630172241.10806-2-jbrunet@baylibre.com>
X-Cookie: A good memory does not equal pale ink.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 30, 2018 at 07:22:40PM +0200, Jerome Brunet wrote:

> +Optional properties:
> +- VDDP-supply: regulator phandle for the VDDA supply
> +- VDDA-supply: regulator phandle for the VDDP supply
> +- VDDD-supply: regulator phandle for the VDDD supply

Same issue as with the other binding: power isn't optional in the
hardware so shouldn't be optional in the binding.

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+TQACgkQJNaLcl1U
h9Cc6wf+NZEPaRFu73AMwKwM3gRUSniFTZwz4wGM7Gc/fZIQDORCh96O01cl2eev
EzzT8jy5qZLpRTae4Dth7r2jhMkrk+DUVDeitb/47p53ownbhJnLkj2nOTfo+HIP
4Uv8mXb7nk5pQ7/u1s7cIse45X12DDKipsMbdlqa4N84N0Yu6k2IMyNd1TXFKsSi
/XXJ+vHEbCjZOEODe1FAMTElgwb57fJzSJsV+4xRaz+icVNH+9NwbXK6+wbsHXls
/rdejm5M5OMUsOCbVNmqasS1ey69RtuiyXzH4fPNaav9bsNraEVm8JTcPdyWMmsS
IVzkHIf1yrdYSXxYb5LcaLeFDHnDjA==
=lr+8
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
