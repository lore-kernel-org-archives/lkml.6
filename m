Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFAFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D170208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FtgcCgoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D170208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeG3RKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:10:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54984 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3RKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AsfBezTL97gH4iDO4Ep6SUWk4Dz4Szv31UCxcOEM1EU=; b=FtgcCgoSUvW4QKEZCC7iRahR9
        latWwGhjHOeJVCxvS6W+o2uGJutXEy3GzjBbO7Q8jxf+cDjhklb2xLI2wzcKZCAymU7LkMeFrZXIT
        OFF9oB5fHdgduuIrl9C/NgO1M04snObra6wV7lQcOC3EG5j/ZDGtWuGfh/+NUPL3PlojU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkACN-0005XJ-Ag; Mon, 30 Jul 2018 15:35:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 09B931124216; Mon, 30 Jul 2018 16:35:03 +0100 (BST)
Date:   Mon, 30 Jul 2018 16:35:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 14/15] spi: img-spfi: Finish every transfer cleanly
Message-ID: <20180730153503.GO5789@sirena.org.uk>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-15-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O3WNCzIuUImKerqE"
Content-Disposition: inline
In-Reply-To: <20180722212010.3979-15-afaerber@suse.de>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O3WNCzIuUImKerqE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:20:09PM +0200, Andreas F=E4rber wrote:
> From: Ionela Voinescu <ionela.voinescu@imgtec.com>
>=20
> Before this change, the interrupt status bit that signaled
> the end of a transfer was cleared in the wait_all_done
> function. That functionality triggered issues for DMA
> duplex transactions where the wait function was called
> twice, in both the TX and RX callbacks.

Again, is this not a fix?

--O3WNCzIuUImKerqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfMCYACgkQJNaLcl1U
h9BZmAf/QwgRuAnirIDhBewibP4c4V9oElrLpan9KExyh8toALsp037PJxbaO9oN
sCnn3i2vHYQPNmM92QOn24RQf5wE3KbuqDeS+5podX+Js+xX7VBqTT6X63KvtR6j
5R1wZ8XD0Nla/K8eNPoG55mbVNgFxeSwkVeQy2HU3JYo0Bzx6ShxDqkaBKFnoMkC
I0RoWsX2xV0DLcfRhQRRSpEIe2dtV++GR48Nfs2Auw8ZpAYukTZBik4DQ9ZwgEro
pP9MYuuGcW6TNGIqIDybg2DK2snVR9QBmCQv96IpTI9grZJiKBEQimOtw3eJ0qip
6RdZjmm9JC60Ejak/3jBUqfQTbuH7Q==
=ZyLh
-----END PGP SIGNATURE-----

--O3WNCzIuUImKerqE--
