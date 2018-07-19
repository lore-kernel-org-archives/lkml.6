Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAEEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C8E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="F7Jxu/VO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C8E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbeGSOI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:08:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46720 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbeGSOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7bLfIv1sJgapZFHwlAUg57gjgu5+MH5l7pE/lELuBZg=; b=F7Jxu/VO91ZVE+kgnR+8euzcT
        e1HrtFVNf6K2OrxyGNR+YfyYkKRF/iNIZmRLbG8J9R0kEooA8pDM/6CXNvEKUMGaHPultS3A0ltg7
        kVvQq6sglLP2BJu4l/hA95pESwhzr6hETRhrgTv4kgg7MGOacR307ujj6ngwstD1GHZPg=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fg8vh-0006zg-60; Thu, 19 Jul 2018 13:25:13 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fg8vg-0007Jm-Cn; Thu, 19 Jul 2018 14:25:12 +0100
Date:   Thu, 19 Jul 2018 14:25:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [DISCUSSION] spi multi chipselect support
Message-ID: <20180719132512.GA27938@sirena.org.uk>
References: <20180718163530.zsa5md3huz3dnotb@earth.universe>
 <c497b0e2-c663-fa29-dabc-6dd5ca26e0a4@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <c497b0e2-c663-fa29-dabc-6dd5ca26e0a4@metafoo.de>
X-Cookie: I'm having an emotional outburst!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 07:19:19PM +0200, Lars-Peter Clausen wrote:

> My preferred solution would to have something like
> i2c_new_secondary_device(), but for SPI. This way the driver that binds to
> the compatible string can allocate devices for additional chip selects as
> necessary. Also make use of the reg-names property the same way as in I2C.

Yes, that's at least the most consistent way forwards if nothing else.
I don't really have any more appealing ideas anyway.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltQkTUACgkQJNaLcl1U
h9BUkAf/YnEw9f7VUM63wKafD/gmY55xm7M0gWEZi4Mm18LD1AfLpyNVO3YWB1Vq
G+GPeacLi0g6Mb1Vu7kkAV67Ox3IjATYxADuxhGksQvSTszyCV8v0DY2nTlozSb+
Z20YGSnh8zjFCPENA3tBAsj56HghEumfXlWmFL06/XNpmxcG7UrVMtkLmeglavNf
GZh+sNKlC363Obm8eOWVkXLuSB+JeHHexyN6q40tvT1BrFbDkYktGNJJ93F7cM07
nq5uluV/EhPnJCcSo0zoqj3gtwpDGfJpYEe9b4t63qoMaB6wAhG+dR3mYmm2fZd8
IONpmBEc0tP8PQHrh9jTQwy59lRDAQ==
=YmQv
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
