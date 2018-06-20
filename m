Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A63C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D5D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bDlk7gL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D5D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbeFTKyX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:54:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53518 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeFTKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f4zjjhlPiA+Eky3lEqezkaWQiQ3DHAcsQDW9vPYR2Oc=; b=bDlk7gL2W8IhRRyzHlBsRE/CX
        CFWSINQ5ckmbTMfTvubi6piq1jXgPStXxSZQFUCY3/sc5OgqM4SzEydOIYo6cQqVjbZBTtO6eyfzK
        LwgDT1WhxHiaNjbG1KNtI2nxNZ3wtR74X+hBibMe7/ZXulOHw08vpkvUNEqzOEXcAQ2LE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVakh-0002AP-OF; Wed, 20 Jun 2018 10:54:15 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fVakh-0002Zr-73; Wed, 20 Jun 2018 11:54:15 +0100
Date:   Wed, 20 Jun 2018 11:54:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] driver core: add a debugfs entry to show deferred devices
Message-ID: <20180620105415.GC6242@sirena.org.uk>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20180619225145.GA23389@kroah.com>
X-Cookie: No directory.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2018 at 07:51:45AM +0900, Greg Kroah-Hartman wrote:

> And what is the use of this file?  What can you do with this
> information?  Who is going to use it?  Don't we have other deferred
> probe debugging somewhere else?

Pretty much all we have right now is kernel log messages, and people
keep trying to suppress those as they're quite noisy sometimes.  Ideally
the device dependency stuff will reduce that problem but I'm not sure
how that's getting on.

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqMlYACgkQJNaLcl1U
h9CoGQf+NJ0Rj8PZa3trN+Wn9mxnUySGR4M36tGjJpHPyyaGHGAZ7iwG67Lcc6c9
vsO4eb1a4U0RhLWTBIZN3NMZ8ZCL7TZ+8yClFYGtbmYLrmu8Nk4+0sYxN2mKqte3
7q0L8/0mPS6pfL3EedH+mVn0CdLS0+20dwcf6vSXMH/CihAkTy/UbdilLdBNahjg
nbr3B6yTr5KFM0FQuB5V4/n3wm9OTtdTug0HNWm71TyEqBUyZuOW0ulIkdCZS9gf
Pty3/jGxebV3CQtaHsrUBR3eUC7FMTDH6hB25b9muz1ab9jJotKbJqSqP0PCjeLG
3pcgckC06N1zxxZB+JvBPFP6QA88PQ==
=ZxM/
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
