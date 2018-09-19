Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCD921522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="COwIlvRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCD921522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733056AbeISXK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:10:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55096 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731866AbeISXK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hi6LLiMcF9pUjhikPT2pyl0yNg44KM9+9pmQho0S2W0=; b=COwIlvRhuKfiaIVli7CwcMKAW
        in64qffsKZCi2gyBeXANhDXoev77BGCHnJwPLERLB9ySNTG4MiRDYM7tp7Rifm3OBUX68khxMPQNk
        yh5UHMDsHYsNpiHI6MKRO34w5gN7vEAA6IH1tpczk8QapGvnDC7aeoACwiZ2vMngaDBhU=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2gKW-0004kx-IB; Wed, 19 Sep 2018 17:32:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 27697440078; Wed, 19 Sep 2018 18:31:58 +0100 (BST)
Date:   Wed, 19 Sep 2018 10:31:57 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Peter Shih <pihsun@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] spi: mediatek: Don't modify spi_transfer when
 transfer.
Message-ID: <20180919173157.GD2471@sirena.org.uk>
References: <20180918161504.GM2471@sirena.org.uk>
 <20180919062928.238917-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U1t7w//IUm8YcF8e"
Content-Disposition: inline
In-Reply-To: <20180919062928.238917-1-pihsun@chromium.org>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U1t7w//IUm8YcF8e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 19, 2018 at 02:29:27PM +0800, Peter Shih wrote:
> Mediatek SPI driver modifies some fields (tx_buf, rx_buf, len, tx_dma,
> rx_dma) of the spi_transfer* passed in when doing transfer_one and in
> interrupt handler. This is somewhat unexpected, and there are some

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--U1t7w//IUm8YcF8e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluiiA0ACgkQJNaLcl1U
h9AEEgf/c9FGN+vhT4tkkoUG3IEtBQICO2atvwYxL9kWS06z6CkM3JjI7Ny4239O
vaxiEkEkXLgk+C0zZWpm05bu3hv3JL9tePjySlb1JxXKOn7h0waTiuSlBuDZs4hS
Yb7TwghHPZMbSG+NOS/GzZI/bYrY1FgSb4gUUa6fLSoyI7jnpqHZFzV3UwJOeHCd
BGGjIjUU8tLjhDMK7UckS9jwjEb0SusWfIEA36tko3xYI8TSN7zkck15KhiQLdsr
5ZxEtIAjUxh38y6MC9Csitah8PSV0/8ams5WduKybMlzDRCfZLMN2JeEsNDt0N1M
Ykgidr5LMY02nvK27GgojA3+CDl3tA==
=R8r6
-----END PGP SIGNATURE-----

--U1t7w//IUm8YcF8e--
