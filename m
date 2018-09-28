Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEDBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8392B21580
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Qpjsr4eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8392B21580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeI1TuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:50:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45894 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1TuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vVwRJHXxEyk90KDl5j89fIB3v0wK3lVJQN8flfXYOn8=; b=Qpjsr4ehwLwZBfQYyxEwk0RWL
        VcNjwQoYCxhPugha/YmQ6YEBoSzZL13TkQljkRyqaQEX/SgCQY5ZPD739mb2pWiCl2ymTyoWLRJ6R
        fgH1KrSVlkzu8wL6b+AT2a15SZkDv2fzftW1gH7qlItgwbgWHm5x0K1tUeG5wtEfx5ptU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g5smX-0008T4-TW; Fri, 28 Sep 2018 13:26:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 44574440078; Fri, 28 Sep 2018 14:26:08 +0100 (BST)
Date:   Fri, 28 Sep 2018 14:26:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Chuanhua Han <chuanhua.han@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Message-ID: <20180928132607.GK20825@sirena.org.uk>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
 <20180928084431.300b7bf9@bbrezillon>
 <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20180928091833.15e95f7f@bbrezillon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wSq95SjGPZBE6hCW"
Content-Disposition: inline
In-Reply-To: <20180928091833.15e95f7f@bbrezillon>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wSq95SjGPZBE6hCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2018 at 09:18:33AM +0200, Boris Brezillon wrote:

> I might be wrong, but that's not my understanding of ->bits_per_word.
> To me, it's something that you can use when your *device* (not
> controller) expects non-byte aligned words [1]. The spi-mem protocol is

Yes, bits per word is a device setting.  SPI devices can have control
protocols that have words larger than a byte with a fixed byte order,
many controllers do the required byte swapping.

--wSq95SjGPZBE6hCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluuK+8ACgkQJNaLcl1U
h9BOQwf+LqkpaV7bP+BUmsidnAw28PcCEe57W885U1yULgNr1lMjbXdcA4azs5pj
jS+3UNRW1Cx44/3eKvNsASub2mapMXVdSWv0Q7JsMjuu5piICIHlovk1LDdWu6gN
2lLDvCuEYeq1Ys+hxl8Rx7hekX/cZ+Z7udG/aZkuh5sq1Gokqvq10fHk/wnLLel8
MoisTOIGXwarSQMIphhfAted9qYTzX6FgP3rEyMop1NOHo+0Bs9nrRPYWcpzvlsy
gNIlpmnUZ7d94Nx6NdQS1K22Ipk7MuyDkp21eeRtFJZe/QmWVbDKtI3ZljDxU6y6
BvtdaWoQrjkCwiIQdeZCehRBY7Xqcw==
=uT86
-----END PGP SIGNATURE-----

--wSq95SjGPZBE6hCW--
