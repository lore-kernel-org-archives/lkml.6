Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A158B214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kgGPICft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A158B214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeIRCsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:48:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRCsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L9hAWRtUg5s0mSPA5IzmRcueXxQmPlmUd5tXOKenZ8s=; b=kgGPICftyv8HmWCBiznkEhCZ/
        /3+60c3K2Ty35/6sf/rLLOA8YDwMjCzdw+xOC8eaS0uI+BSOG3MVgCcBEQaXEZDJu3quzAK1hMW8v
        Aoch0MVgHB8SI/x45eJOu/4g28FztmDtS5S7fRiy/GrGofOY+FFKOBNxG/n5qm2M641E0=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g20uj-0000jb-ED; Mon, 17 Sep 2018 21:18:37 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 759B8440078; Mon, 17 Sep 2018 22:18:35 +0100 (BST)
Date:   Mon, 17 Sep 2018 14:18:35 -0700
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] spi: spi-davinci: Add support for SPI_CS_WORD
Message-ID: <20180917211835.GH2471@sirena.org.uk>
References: <20180913003920.30600-1-david@lechnology.com>
 <20180913003920.30600-5-david@lechnology.com>
 <CAMuHMdUb=sXBBRLhKNxsWT_Z4PCoLcM16NajvmPVHWsvgoL7_w@mail.gmail.com>
 <fb43f4d7-5b19-72be-9216-efdca9b59eba@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <fb43f4d7-5b19-72be-9216-efdca9b59eba@lechnology.com>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 13, 2018 at 09:26:48AM -0500, David Lechner wrote:
> On 09/13/2018 08:44 AM, Geert Uytterhoeven wrote:

> I suppose it might be best to modify the SPI core to say:

> 	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
> 					  gpio_is_valid(spi->cs_gpio)) {

> instead of:

> 	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {

> Then we could drop the error above.

Yes, that makes sense - the same thing is going to apply to any
controller with this support.

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlugGioACgkQJNaLcl1U
h9Acdgf/X/OeJnFpgtiBslpY7yCDTv4ulyxoYx45ExUrvKW0mJTNGrJa2zjPiX98
j7v4A/s9MJb7t5Rn8I9ZhDVApF0ydTbEDj/sLtyjvdzMVXH/moB48WAYWlCl9Cdm
OPdxhZyoO1DyxrszcsUO0o+LsCEQoslL4ru7Wk9wdyOCi05j9yTxPpxlPlq6Wfcu
ugs/OVezQYE6EKqCegn/UtDJTrZjFKafY/7Db6SZBKWnXz/ffSV+mc7CHK5QfBrz
LHf01dtYhAoURWfH7VMmOukkLeR5C6WFSU7sTWD9FucjGtw009p6LGK4yRtH33yw
8xR4A3ErQos2mFIkWmexZNTnAyLb+w==
=Wiqq
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
