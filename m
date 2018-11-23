Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99927C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8DC20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bA+d2bHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8DC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405531AbeKXAPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:15:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeKXAPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0+7sjnzFxnWCHvUyY435I2q+6Ivy5gFveXEBwf99Bjk=; b=bA+d2bHuhTcUMqwf9AI9zNcYQ
        s6mKYhmNkzH/84hN6JRBoCPReliRpqtJn/iVhAYFSZnW16zKCStLS5ktxkN6CVDe2fCzI4/akAcDm
        luwy9yk6JllPyLKYuygfBQxxx/gUMXTEyKZsaOHWIIvznLfkkOe43T9Bqwg6IFwAx+BEg=;
Received: from [176.12.107.140] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gQBYP-00013i-1W; Fri, 23 Nov 2018 13:31:29 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 07610440078; Fri, 23 Nov 2018 13:31:27 +0000 (GMT)
Date:   Fri, 23 Nov 2018 13:31:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v9 1/8] ASoC: dt-bindings: sun50i-codec-analog: Add
 headphone amp regulator supply
Message-ID: <20181123133126.GF2089@sirena.org.uk>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-2-wens@csie.org>
 <20181122153241.lzrwhkewg5q4hy2c@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tWc6BTYdre847SEs"
Content-Disposition: inline
In-Reply-To: <20181122153241.lzrwhkewg5q4hy2c@flea>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tWc6BTYdre847SEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2018 at 04:32:41PM +0100, Maxime Ripard wrote:
> On Thu, Nov 22, 2018 at 06:23:18PM +0800, Chen-Yu Tsai wrote:

> > +- cpvdd-supply: Regulator supply for the headphone amplifier

> I guess we should make this optional, since even if it's missing, it's
> going to create a dummy regulator. and that allows to have backward
> compatibility.

Regulators should never be marked as optional unless they can be
physically absent.  It is true that Linux has code to handle partially
defined device trees but we shouldn't rely on other OSs having similar
code and it's better practice to have board device trees be fully
specified, it means that if we need the regulator information for some
future thing it's more likely to be there and it's less likely that bugs
which do things like cause the regulator to be powered off incorrectly
will be introduced in future.

--tWc6BTYdre847SEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv4AS4ACgkQJNaLcl1U
h9AYIggAhg//WqT0GsO27SLAihrkB6m9aDOYxbNLf16kxManjIHvCNpKAyuOc+bn
Go+pZkE9hZ83rkO86bfA5fMjkJnkjVmt8/k0nGyJqm9vH7jXh9qW9R7pBhCazgvG
Pd9Va3ouJXI/HhcECJApYMPXS+DOn9fdS/HUeXcF5FyhEAbVwUsD7l3CZFxgO8n3
kzVevvyicXzRaYnnSJZMUBQM9INkFwAaPXBzLoYNre86eA/ktc//e4zXCVh1PMwx
D2cExRRexfpU6QjlCvivVGYY5Qxk4qPMsmdaKD5b94HkVgFszXKjPHqOLobQ2wIA
w02xpmRW28FVH2vYd/FlOHRfrMGzdQ==
=9LaI
-----END PGP SIGNATURE-----

--tWc6BTYdre847SEs--
