Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67246C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDE4214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="rojxM9MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDE4214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeHBNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:38:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60474 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeHBNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z9Er2LelYS/9RwUNQ9KCBwf95GeCdqu3xpVPOnlOUcY=; b=rojxM9MRSVyyKEzrNwDT1Wo1B
        w3Mk/iG6QVW3U15f+pi1fEjIAl+Z9O8nf6guejtiPKlUyUbTWMstw9skCV+9DRwYavZDf05OgjcDb
        NLAwgBt7h0HrAzUlDmG/9cH/RLKRZB7FYCu3/iqgSIZsi6F4jm2cSY818Olzd6QAkuZJ0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1flC4I-00020S-AK; Thu, 02 Aug 2018 11:46:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1360B11242E7; Thu,  2 Aug 2018 12:46:58 +0100 (BST)
Date:   Thu, 2 Aug 2018 12:46:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Piotr Bugalski <pbu@cryptera.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>
Subject: Re: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180802114658.GL9117@sirena.org.uk>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
 <20180801172747.GJ5509@sirena.org.uk>
 <20180801215733.4dfa3a95@bbrezillon>
 <20180802101742.GF9117@sirena.org.uk>
 <6f9ca4f1-6809-2d7d-4d64-6869a4e413cb@exceet.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Content-Disposition: inline
In-Reply-To: <6f9ca4f1-6809-2d7d-4d64-6869a4e413cb@exceet.de>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3xQkynibq3FKlJyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2018 at 12:46:36PM +0200, Frieder Schrempf wrote:
> On 02.08.2018 12:17, Mark Brown wrote:

> > I don't seem to have a copy of this patch...  not sure it was sent to
> > me?

> When I sent the patch I put you in cc. So if nothing went wrong you should
> have it.
> It is part of the SPI MEM conversion series for the FSL QSPI driver [1].

Well, I can't find any references to it anywhere so yeah.

> So if you want I could send the patch separately so it can be applied with
> the Atmel driver.

I'm going to need a copy to review it.

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti7zEACgkQJNaLcl1U
h9ABhwf/V3uH25W2F8+EdiD5bFFKFfSbNOQ5ZyybnxxKnJLRUYzsv/ScZRGkFAEa
WH4dbokKTOmNJHGsTA9qatSLCY5eKLP6kEOPCBeh/4F0UOarfekWjUWAMt1cgkA2
z6KaasiiwiJGz45HaKyjbkGa4VfNm0Wbcz1hDFzNGR0K1lUougpDOejL1YU1CRcE
w8Cps3q65BYVVQquyH6CsPZNe6v6HMNf1k9UTwpipTSM5g3hrMI1Txu3qo5pYX/n
Pxl43sDVfiYrPWId+KK6h+Uj3mEq5abXBQC5SOLiI0KuAsrB5I8bheZIb7tDObI+
wtHRpfG8MacsFrkV/1oY/dyQE9fRJg==
=0LMP
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--
