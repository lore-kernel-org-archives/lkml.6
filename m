Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A22171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678405;
	bh=FnKT6ewSKdwngGO6cn93TLXc3mQtAw84nsJzs6CA/o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w1moDm5KHbSinI3D8uGBCtNrkOeP2I8894BpPV/8A8qE73tMBoqf9OHdxkuLkb97G
	 6m8rcxEkXc0Oqdv42nm8biGcWQsELlAxxrTZyFCaj0fkXrEnEDDVUg8CYRGffE/mw8
	 GKKpCdkMVRjeFSbIA0ZCaf9+wQBK9AAwbaVCaYOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfA1M0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:26:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1M0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cEneVQDt5owcuCiSpjo8HwrddzUQYEnP2+VEv83KNZI=; b=Hu6+nl8U6+gMmN/x3f7vHD9cV
        fRfbVg3aUMkaeRB/0WA9/NCaHMp/MMndIPmUIoUNyrtcVBD13cZLwBIAiu2y3riaOkBkACL7nU6eM
        +yV7u3cAMvzDxsslSfsWZJkAtwrh68+uCX7OXwcm5l9JHxySK2gHFVh/2cKRfxHpmU6WY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go5zk-0002RE-7J; Mon, 28 Jan 2019 12:26:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AA6F51127D29; Mon, 28 Jan 2019 12:26:31 +0000 (GMT)
Date:   Mon, 28 Jan 2019 12:26:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Message-ID: <20190128122631.GD11699@sirena.org.uk>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 10:05:29AM +0000, Yogesh Narayan Gaur wrote:

> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index e23ad9ef028e..adc3c0e14f38 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)

This does not apply against current code, the above file is not present
upstream.  Please do not submit patches to out of tree code upstream.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO9PYACgkQJNaLcl1U
h9Bc7wf+PzfVYK47sKb7gYCwrFPhskxTV0PfgznGOSHdzhtJmhuLjfDzsgLC+PH5
T25AIY5kF5IKbod3WbKT8atM1uQCDHDae81MTD0m6da0uNCpqPsGBquyU+WPiwJA
SOEpzPRyV0GSI/TQW5fKWnWVUxLVKdMEzTBZnvu9I7EvOpv+eiS0udKenqsE8iVp
U0EgQng2D51VRhvVOmRY4bmvtby54bzZXjt/4TYsdvNux2ar00OzH8FOJ2XTKnOO
JdDZlmY/K0NSgjE5T1JYHT4CDn8LLL1wJQ4g04CN/WAKdbGU1GgSMcnxK8OD0C2i
t3E/tHBlG4R/WC4KdDO76rZk6mCTTg==
=DbNg
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
