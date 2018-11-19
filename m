Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B12A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="DFPifyPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B12A2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeKTBvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:51:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54480 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeKTBvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UmUodzWPcbC2WT+fBDOXo+eIOvgW2yydkOYBNhwY708=; b=DFPifyPTuFrP2WuW2t53ljsIC
        EKEtPTJnQ4L1ZhgUPUdPx3T4cLZyrz6GX4xW7/D8BHfj/oCan8U44qwkYWIJUv7I04EwEzPe7rE2y
        7P2CK5MUd262Yuq32Sm8LP7gU1ZUyqHdsmpwdzB9o24lwEU06OWqS/KUYjpwuJ0gzceH0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gOlSa-0000JH-Be; Mon, 19 Nov 2018 15:27:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D2CBE1125031; Mon, 19 Nov 2018 15:27:35 +0000 (GMT)
Date:   Mon, 19 Nov 2018 15:27:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Message-ID: <20181119152735.GB3535@sirena.org.uk>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
X-Cookie: news: gotcha
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2018 at 03:12:00PM +0100, Marek Vasut wrote:
> On 11/19/2018 11:01 AM, Mason Yang wrote:

> > +++ b/drivers/spi/spi-renesas-rpc.c
> > @@ -0,0 +1,750 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> > +// Copyright (C) 2018 Macronix International Co., Ltd.
> > +//
> > +// R-Car D3 RPC SPI/QSPI/Octa driver
> > +//
> > +// Authors:
> > +//	Mason Yang <masonccyang@mxic.com.tw>
> > +//

> Fix multiline comment please.

The SPDX header needs to be C++ style so I push people to make the whole
block C++ otherwise it looks messy.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvy1mcACgkQJNaLcl1U
h9AZPwgAgz+jR6KDSiQW6O7CN72Z0ZZHZYG5GwRntXc5QS7quRocYsywQF3J3efX
dkH2TaTlFg5xR67jkpz80982DIfUNTNi+5FgoTOahIqCKYU68ioZMFQCfiDjlCy2
60V+M4HI0eLUtMTEHai6sOkd6Pfxmro4RcsCdGS6KOUpbv5Ye4er0v/gRB5jo7OW
LTi3WMpTFmaA3CjPEnLUZu0tTdmGpNbheBGn8+WIrG6wZW/0yBeBdX2j8yARy3nt
JCRkRnWEs7oMDS2yimdDvG1WiDvDDzsaf8WqUuRX4rM48hDYoKp2CADyVzL7FEtj
d53z/bQUCT5UYxoC+n0ic7IkQ3BwXQ==
=dihg
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
