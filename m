Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9FCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24ACC20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oER5F9JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ACC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeK0Bsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:48:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeK0Bsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LyqQIyAR7BK84h4paITub9/jA3XcrZxMnjbpVtTlDf8=; b=oER5F9JDTbkGCnJCKbqC47L33
        hdVny83H1SGnNGZdIuQSF7oCoIg3wvTwV0c+CZ7ZFf1nrbRjQOooteqetThqDJYomcd1cWdCDB6xf
        Sr9gF01X8fwPg2buabTN2IYN/t3/YSRLbM+4qzUtkYdlHnXbV9RrFKUlla77iOdJ1eeNE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRIHM-0004AC-RU; Mon, 26 Nov 2018 14:54:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 841EB112519F; Mon, 26 Nov 2018 14:54:28 +0000 (GMT)
Date:   Mon, 26 Nov 2018 14:54:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH 3/3] gpio: Add reference counting for non-exclusive GPIOs
Message-ID: <20181126145428.GF9715@sirena.org.uk>
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
 <20181122173015.23905-3-ckeepax@opensource.cirrus.com>
 <CACRpkdZEu44WHScd5VibYT5C9RikqcvKsgpVOpkkdrYbLaV8Ng@mail.gmail.com>
 <20181123105729.GM16508@imbe.wolfsonmicro.main>
 <20181123132522.GE2089@sirena.org.uk>
 <20181126130001.GN16508@imbe.wolfsonmicro.main>
 <20181126140927.GD9715@sirena.org.uk>
 <20181126143028.GO16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
In-Reply-To: <20181126143028.GO16508@imbe.wolfsonmicro.main>
X-Cookie: Gloffing is a state of mine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2018 at 02:30:28PM +0000, Charles Keepax wrote:

> Would there perhaps be milage in looking at just making
> the regulator core request the GPIO, rather than the end
> drivers? Gives us a single request/free point. We don't need
> any special flags in the GPIO layer, as its just a single
> user as far as GPIO is concerned.

Yes, I did suggest that earlier in the thread :/

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv8CSMACgkQJNaLcl1U
h9DuNAf/d+AY4KvIqj5xvScPihPqRzRv8uiTOUlSxKvGEKpN7HLirsHxP8E0RcNO
qmrfEzunSBOlvPd5hR3ToWdm98A71xpVMSi0n402LP6ST7SIH2VVBv/3Gx1dCXC/
An5mPArY4tLAh3a3YuxR6haWATAUQ/afvkvT+eCK3aG5w6FPz5Avo1YGptkfHn0o
UNhSdr5puDg8d9idumG09iCt/xRNTV/TfO4AJYH30qsFBEYu9O+V5CzohhR4hDU0
Vsr73f9mRrNATwcPrJGTL3nQT6BVtLaomXbAV8dcG046Lk7j1cVznK1VRbRJTBi3
ZMohpIBgb4BpceqZu8SX2dsaIAAk4w==
=4NcP
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
