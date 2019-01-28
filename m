Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1859FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAD21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548678660;
	bh=qeaxo85atsF5I/3Hpvacj/cXzBpdxjfNBhPgowTVcjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fkFFYL6mNkD3Vksu4iqUJNiFLY6p21xbHXTK7JceJ36CzvIGSzdNzob0SrUlgxiy7
	 KA1foDfL4HduXkAFMJnChANNiPUCAH/h2kZncjQ52SYYUcprVQwXARIA3SxHZ9H1fg
	 xKgUhRrsmJHYoCKFOmni14R1OoJN1pAwKxwd4Gj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfA1Ma7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:30:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34216 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1Ma6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cXAyeWFIpMOGgCIqLGzeDp4ajkXjIWJQ3xqRqloXnbQ=; b=UfdSblx+k6fhF5uBftq4r8EzE
        2IAqiYQCHw+f0xizLEWqBqY5KEEkNg9bJUKQqxzLfnNpYCk4vX9TyqgH/wZ0OPbQoDkvkfEn2kygG
        qWiePjM73nA3PL/Z6KlDqncIJ8xwLMvJrnaddOTsi694ZWbXRGlS601R5mA6cytskHLy8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1go63u-0002RV-NE; Mon, 28 Jan 2019 12:30:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5021F1127D29; Mon, 28 Jan 2019 12:30:50 +0000 (GMT)
Date:   Mon, 28 Jan 2019 12:30:50 +0000
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
Message-ID: <20190128123050.GE11699@sirena.org.uk>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20190128122631.GD11699@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <20190128122631.GD11699@sirena.org.uk>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 12:26:31PM +0000, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 10:05:29AM +0000, Yogesh Narayan Gaur wrote:

> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > index e23ad9ef028e..adc3c0e14f38 100644
> > --- a/drivers/spi/spi-nxp-fspi.c
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)

> This does not apply against current code, the above file is not present
> upstream.  Please do not submit patches to out of tree code upstream.

So it turns out your other series was adding that driver.  Please if
you're doing this make sure you call out any interdependencies in either
the patch itself or the cover letter, if you're sending separate patch
serieses you should expect them to be handled separately.

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO9fkACgkQJNaLcl1U
h9BsYQf6A45qVJRvph5tyVH50pk3XTa/3pcow8e2pPLdqTbQDypz5tpGQaDC4jqB
nsGIHXjKMru6xRvC49DPoKm4XGOpdHyW/qWGvaZmVnbGK2YX61L8BHQyfkN5LEGo
NsW89904eo5ycNYgapwwDwpUoUoE8Vj/9oYI/mDpW9Nr1QqyyIOHsh7yRXrZTdEV
S6pR/iU+KWgAFP3zrEXxkZqm8mdjwA5SEuAJ6oNl78Lz+Vtt3TleiLSnG2K+enTQ
WJYfS3mvVCjI6XQILWXracX0HmeC9T58GiyKyr8V4l8JEJS0YJI/zqb6b9ccSjgb
2YJA6Gp3Bh4MozVa3Dq+m2WFYN3giw==
=llBo
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
