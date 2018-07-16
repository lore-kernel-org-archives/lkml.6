Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA7ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2FB20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Q1r6kNcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2FB20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeGPLxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:53:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbeGPLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DN4rsSPKsoUS69cMHk7XPNdlGl9/b3SwTFxVzsRsqtg=; b=Q1r6kNcDAhZnf/yK/C5kCd543
        DZljoqBDOjszdjOm+CgBjMsMonANaBGJWjwW5LeR7zNAKjrwsJIGBlAGTYtIuqM7jWRNJv11XHPVH
        nYE+vyTh0IiMg27GeVvAuSSOKVoTObScIsDk65u4pHOtxeA4Ce+gtzgkoDbesWuSy+tdE=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ff1eA-0000Jy-IG; Mon, 16 Jul 2018 11:26:30 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ff1e9-0000dh-LC; Mon, 16 Jul 2018 12:26:29 +0100
Date:   Mon, 16 Jul 2018 12:26:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fill actual_length when doing DMA
 transfer
Message-ID: <20180716112629.GC20734@sirena.org.uk>
References: <20180716062508.7726-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20180716062508.7726-1-andrew.smirnov@gmail.com>
X-Cookie: /* Halley */
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 15, 2018 at 11:25:08PM -0700, Andrey Smirnov wrote:
> Users of SPI device drivers may rely on 'actual_length', so it is
> important that information is correctly reported. One example would be
> spi_mem_exec_op() which will fail if 'actual_length' doesn't match
> requested transfer length. To fix the problem, add necessary code to
> populate 'actual_length'.

This doesn't apply against current code, please check and resend.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltMgOQACgkQJNaLcl1U
h9B8uwf/U8yc5YQUdZomPA25pS8WoG3Zg6ed86KrBQdSDvgckrM73McNoEHTIJVi
b3pmXBS17zXlfVF7aWHbotAJi5Xd1syeoZjc60nUMqtbtRlTox65GtRclrErsaGU
9/wwCi+UZqzV3iP2tqOR2gJhkEImH8wPSJTYQTaswLrJsxMNTvwaxYUKAG8oSLey
UdyiY/LhS8EfknzMDHE1zWvno8MC2lg3ZlNO++rGFWlAHw/PuGgmcMk7xuGj44Pz
55MJKFrCcmqImwmfcTv9NsgOaNZRFLzdOzGc/QX47JhWQQVlAUt3Pu3aKhbZo5t4
0ywSGlEM+T/EhjVaoEo+K14NQZMYVQ==
=qoT6
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
