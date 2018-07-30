Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AABA160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1BD208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="qOgrfTDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1BD208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeG3RKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:10:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54468 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeG3RKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bbs/D1socRe45v1LI1/Ta0Dxb+3m3ibmjtplzMcPPfI=; b=qOgrfTDZMu7EVRCFEmW1yKYgo
        0E1MaO+Rkt5+wNIMHbWTVbianeVNwiJZPseIRTi/+Un5KTGtK+r/DuHwl2WUQRV4GealG4PlrmfdW
        XoxOjXxf6e2Y+xpSdsp2swK8xH92ci4wHwq9mWMMHoUydWT4MQoq9LVoH/dhgRBUP0Fuw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkAC6-0005X7-FT; Mon, 30 Jul 2018 15:34:46 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 336051124216; Mon, 30 Jul 2018 16:34:46 +0100 (BST)
Date:   Mon, 30 Jul 2018 16:34:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@imgtec.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 13/15] spi: img-spfi: RX maximum burst size for DMA is 8
Message-ID: <20180730153446.GN5789@sirena.org.uk>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-14-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GEn4szYucjS2InE7"
Content-Disposition: inline
In-Reply-To: <20180722212010.3979-14-afaerber@suse.de>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GEn4szYucjS2InE7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 22, 2018 at 11:20:08PM +0200, Andreas F=E4rber wrote:
> From: Ionela Voinescu <ionela.voinescu@imgtec.com>
>=20
> The depth of the FIFOs is 16 bytes. The DMA request line is tied
> to the half full/empty (depending on the use of the TX or RX FIFO)
> threshold. For the TX FIFO, if you set a burst size of 8 (equal to
> half the depth) the first burst goes into FIFO without any issues,
> but due the latency involved (the time the data leaves  the DMA
> engine to the time it arrives at the FIFO), the DMA might trigger
> another burst of 8. But given that there is no space for 2 additonal
> bursts of 8, this would result in a failure. Therefore, we have to
> keep the burst size for TX to 4 to accomodate for an extra burst.

This seems like something that should be sent as a bug fix - doesn't it
fix anything?  If it is a fix then it should've gone at the start of the
series so it's got no dependencies and could be sent to Linus for the
current release.

> While here, move the burst size setting outside of the if/else branches
> as they have the same value for both 8 and 32 bit data widths.

Though this refactoring probably less so.

--GEn4szYucjS2InE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltfMBUACgkQJNaLcl1U
h9A8fQf8DSTyUdJz3ii5KeP1L+ww020+hxhlkv6pI/+iToSlsTzqljvcJqKoodUd
I3GKROAn1z+oIhdlLTrzq6PbLbGd7/VIK6GR5RG5Y7hRuOBy4dPhvG896r/24s8s
kKZHboyXoKWh841UylnNOKFs7NVSrZJ1B9ru3XczSPD62ge8mYmkuhrzAYBuNdhW
lqiz+ADaMgakHv4cOL5vJPkJFgqGYdHsAtiCY59qfl2huKrhDs8oeFODFlLGB+DK
O8BIwugd0spRSWKIo/cZIqguWPjHn+RT2wUZzWRt1yNnPpXioU2EjHGs3CzVpsfQ
8fXKQOaliO6vHri/IWdvMiSHi+t0ug==
=NzDz
-----END PGP SIGNATURE-----

--GEn4szYucjS2InE7--
