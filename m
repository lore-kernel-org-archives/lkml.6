Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690FAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD6220811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544638588;
	bh=2ATXMLzbj5ZX9j8kW3YotW8ib6/OqKq1Zot9nIQNS/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nzY0g5jJ53gnkoA7RC+DfrHgOI1aBWWbT4s3zTSGhigf7RolWfUh8se693/+9pyC9
	 yz6/aNLqQkx3f7PivKumrPNDyCPM/qFp9ECUChTpP6FoGnThY9Ldn911rZ2Pn6zjkI
	 yYCgsXq6xoyaSflmFCWRIc7D+1PVzLctxIOcQOp4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD6220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeLLSQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:16:27 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbeLLSQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k9Cika/KlSH+AHWtLDzw6b/US8Aq1qYz/v8eH/B9e8M=; b=NC4BgWShKAgpj+huqjzZZEGGc
        3FCTRoEeX6hQwJEM4tOHgaDwfP8phhHoo2utUJNTlSAVqO1HGRKiCNcvBLCSFBDnSVfsBAIrk9aaC
        sXl884sxbXYCTIpWn9ejuLdc/3GFdHGbqMSMpWkLf7wqa6p4lDUBeTTFZXpIfRd7uq/eo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gX93Y-0004UV-B3; Wed, 12 Dec 2018 18:16:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 028451125535; Wed, 12 Dec 2018 18:16:23 +0000 (GMT)
Date:   Wed, 12 Dec 2018 18:16:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Message-ID: <20181212181623.GF6920@sirena.org.uk>
References: <20181204062224.28844-1-xiaoning.wang@nxp.com>
 <20181211143005.GJ6686@sirena.org.uk>
 <AM6PR04MB5016E6D2220CDD266B2C6C01F3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB5016E6D2220CDD266B2C6C01F3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
X-Cookie: The greatest remedy for anger is delay.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2018 at 02:10:46AM +0000, Clark Wang wrote:

> These five patches are based on patch series spi: lpspi: Add Slave Mode support for LPSPI. For the patch series make a big change, should I hold these five patches until the patch series are applied in your git branch?

OK, if you're sending patches that depend on other things that are still
in review it's important to call that out in the cover letter for the
series or after the --- for single patches, that way it's clear what's
going on.  Please resend these as a series with a note pointing at the
other series.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwRUHcACgkQJNaLcl1U
h9DWQwf/eSs6W0no3bCwdBsHEh6RjMVq16uNECwN7o3UEJ3f5Aq5J/74kFUB2N8E
keaeg9YYszDCrdbjJen+3TPk+k843CnNFVbo7X7WRGHCTjtkjM9Epfdol4eUbEjn
1aGwp+D33j13gAeVoTy7SBLbMTke5VC+9X4mdaRpbg/vT6R2NEmgFin/JDWnR35J
5m85rQgS78Rw8R5WZpEZsN8Qi+7nQ3aRLsRggRDgEZPcibWwzSVKfg+RRcaxab4N
XWpZYakgbnkzoKbtFgjV9D0YqbPYIuBiMgzXlkLA9bviKU5nRENC1AYGmpQzpkqN
lVTQWOBUNwpIT/jc9oaIL40vbrqi4Q==
=/8Ft
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--
