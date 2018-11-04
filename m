Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A2C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C6F20866
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C6F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbeKDVdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 16:33:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40272 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeKDVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 16:33:52 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AC2CE8097D; Sun,  4 Nov 2018 13:18:59 +0100 (CET)
Date:   Sun, 4 Nov 2018 13:19:01 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/11] spi: pxa2xx: Deal with the leftover garbage in
 TXFIFO
Message-ID: <20181104121901.GW23864@amd>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-12-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hc4757KF+wLS/WHK"
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-12-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hc4757KF+wLS/WHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:09:36, Lubomir Rintel wrote:
> There doesn't seem to be a way to empty TXFIFO on MMP2. The datasheet is
> super-secret and the method described in Armada 16x manual won't work:
>=20
>   "The TXFIFO and RXFIFO are cleared to 0b0 when the SSPx port is reset or
>   disabled (by writing a 0b0 to the <Synchronous Serial Port Enable> field
>   in the SSP Control Register 0)."
>=20
>   # devmem 0xd4037008           # read SSSR
>   0x0000F204
>   # devmem 0xd4037000 32 0x80   # SSE off in SSCR0
>   # devmem 0xd4037000 32 0x87   # SSE on
>   # devmem 0xd4037008
>   0x0000F204
>          ^ TXFIFO level is still 2. Sigh.
>=20
> The OLPC 1.75 boot firmware leaves two bytes in the TXFIFO. Those are
> basically throwaway bytes used in response to the messages from the EC.
> The OLPC kernel copes with this by power-cycling the hardware. Perhaps
> the firmware should do this instead.
>=20
> Other than that, there's not much we can do other than complain loudly
> until the garbage gets drained and discard the actual data... For the
> OLPC EC this will work just fine and pushing more data to TXFIFO would
> break further transactions.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hc4757KF+wLS/WHK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlve47UACgkQMOfwapXb+vJ0kQCgoz2t2PBI0Wsd+Q8gcUWHfqCX
G80AoJoac16+K78lqYwRylFytYLxCjR8
=13JX
-----END PGP SIGNATURE-----

--hc4757KF+wLS/WHK--
