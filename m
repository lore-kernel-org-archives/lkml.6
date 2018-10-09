Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC877C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28E021479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="oZlWuVG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28E021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeJIRtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:49:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51282 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJIRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/e+drWByxHHmmesslfAXQbnzGc4Oh/PInToCk2RzedM=; b=oZlWuVG0v1OJSwUEi5sgT/QqN
        irOFjO69OHPHcCH8SXSzUQsNhgWgNi2lcLu7Ud5Mb2VMMJPeqvdl/bCghMYDFIThbHb12RLK+N6TA
        2PYdbP1aDjfZiMzLuj8ZY8ZmIuw3oM6tGyf4IxMjV5GRqwUtKSQ/y/o+apqezaiGVa0go=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9pKT-0005Tv-0q; Tue, 09 Oct 2018 10:33:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 93979112234B; Tue,  9 Oct 2018 11:33:28 +0100 (BST)
Date:   Tue, 9 Oct 2018 11:33:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Chuanhua Han <chuanhua.han@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Message-ID: <20181009103328.GA20774@sirena.org.uk>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
 <20180928084431.300b7bf9@bbrezillon>
 <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20180928091833.15e95f7f@bbrezillon>
 <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20181009120522.6b2bd15a@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <20181009120522.6b2bd15a@bbrezillon>
X-Cookie: Ego sum ens omnipotens.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 12:05:22PM +0200, Boris Brezillon wrote:
> On Tue, 9 Oct 2018 09:52:23 +0000
> Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > 1. In the dspi driver (spi controller), bits_per_word
> > (dspi->bits_per_word = transfer->bits_per_word) passed from the upper
> > layer (spi-mem.c) is used. In this way, I can only assign the
> > appropriate value of transfer->bits_per_word before passing to the
> > controller, that is, the controller driver does not know the value of
> > bits_per_word, and it will use this value when the upper level sets
> > what value is passed.

> I think you're missing my point: ->bits_per_word is not what you're
> looking for if what you're trying to do is use 32-bits accesses when
> things are properly aligned.

To be clear: bits_per_word affects what goes out on the SPI bus (4 byte
words swapped to be in MSB first order), it needn't have any effect on
on what goes on inside the SoC - many controllers fill their FIFO in 32
bit blocks even when sending 8 bit SPI words.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu8g/UACgkQJNaLcl1U
h9DLawf/WlD+TLCVZMYkPjr2exJkiriLytbS+tBT2Ajv3GJ3iEz5RaT1I/vULM7/
gQAcl9hvJGEMQQHTwdY7ZCwaP81liqd2qG5R/qX/yfoZh4Z3FCMYjEbdOHPpNgLA
aATd4k7ve4rsOhYUPkFYgtfcGz+Y004RSLuraaDUcDHLuOOF895vEfRpRg0PgLwy
c1fVHgAyOoxbOfj1oF9mmupmBqiTx+NiNrZGq16xST6RPGqRLhpFmGAZ8++7p3kw
RyZtmnq5b/U7fPk4HftVsJk1uxp1/0/xFUYv1tU5gHgc18Jcu0lFa1D1guwqa1Xn
ibh1mtxlboxFIDXVp2Gu1Nj3zS9x5g==
=gyE5
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
