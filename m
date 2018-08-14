Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A20FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51E22170E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ueVnUv1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51E22170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbeHNRGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:06:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59672 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbeHNRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sXwMjNq8QW2l2WGeOGKXF2ABAogUZ1Vbp49lPxMIR2M=; b=ueVnUv1lBRBqdxpcw/nILBMNB
        UgCSiu29xb3kENPwpmTYe5G4ak+T/t1U36i/u+BnNNbDQhctjkEdJBXncymZBEvWHMoQHsjtE68cr
        +fKm1E5dq42skQXfdClSWmibGZ1caUjoC4SkXsn2bY7acEcXQy+u3mVsmknWm3OToWiUo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fpa9z-0000sE-SZ; Tue, 14 Aug 2018 14:18:59 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2E7CA1124449; Tue, 14 Aug 2018 15:18:59 +0100 (BST)
Date:   Tue, 14 Aug 2018 15:18:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kirill Kapranov <kirill.kapranov@compulab.co.il>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.stach@pengutronix.de
Subject: Re: [PATCH] spi:fix IDR collision on systems with both fixed and
 dynamic SPI bus numbers
Message-ID: <20180814141859.GC5810@sirena.org.uk>
References: <20180813164810.16769-1-kirill.kapranov@compulab.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <20180813164810.16769-1-kirill.kapranov@compulab.co.il>
X-Cookie: All true wisdom is found on T-shirts.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 13, 2018 at 07:48:10PM +0300, Kirill Kapranov wrote:
> On systems where some controllers get a dynamic ID assigned and some have
> a fixed number (e.g. from ACPI tables), the current implementation might
> run into an IDR collision: in case of a fixed bus number is gotten by a
> driver (but not marked busy in IDR tree) and a driver with dynamic bus
> number gets the same ID and predictably fails.

Is this something that's actually happened for you?

> +	} else {
> +	/* devices with a fixed bus num must check-in with the num */
> +		mutex_lock(&board_lock);

The indentation here is weird, the comment isn't aligned with the code
it's commenting on.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlty5NIACgkQJNaLcl1U
h9Cltgf6AoHkyc03ShpCTDuvl+u2bjgiiUx+V3abGWb0pEZkU0ZVVIj4+3v+dIZI
Rv6pP6cY1bb2q9KYxbxJSP0h9d1ywrec1ynGvxbWswLQJrXH5KDV8s2AJhOmNoOr
bOQJESJBEpfC7msE6yqYKcI7HGBNT3Vsf8T3PVIRea+mJL8690mhsopehWwUKoiy
6B2IZcwYmS+3fCitHQEMZ8z6G9pXYaVNWCoVe1PVDihW2NE3qI474nbqnM5KNmnx
CfORtA1toS+a56QCR4baEWAyNAHbr/anRlnoqOic/qJQJflx1ZD5h1RoEmL3RgOV
6TmZUGdgvfbj2HeWgoN8HQ51zySPBw==
=EdRp
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
