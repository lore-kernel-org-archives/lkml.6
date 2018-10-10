Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D28C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E52085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795E52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJJOR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:17:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42216 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJJOR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:17:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8B153207C3; Wed, 10 Oct 2018 08:57:11 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6F553207CC;
        Wed, 10 Oct 2018 08:56:51 +0200 (CEST)
Date:   Wed, 10 Oct 2018 08:56:50 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 1/2] net: phy: mscc: fix signedness bug in
 vsc85xx_downshift_get
Message-ID: <20181010065650.ws6tsyk7ui4izzrw@qschulz>
References: <cover.1539113472.git.gustavo@embeddedor.com>
 <84a75d5e5f7717108feeda49b69b57ecbf361b9c.1539113472.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3vhf2tsc24yoqypk"
Content-Disposition: inline
In-Reply-To: <84a75d5e5f7717108feeda49b69b57ecbf361b9c.1539113472.git.gustavo@embeddedor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3vhf2tsc24yoqypk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Oct 09, 2018 at 09:38:33PM +0200, Gustavo A. R. Silva wrote:
> Currently, the error handling for the call to function
> phy_read_paged() doesn't work because *reg_val* is of
> type u16 (16 bits, unsigned), which makes it impossible
> for it to hold a value less than 0.
>=20

Ah, rookie mistake! I should have run Coccinelle on the patches.

> Fix this by changing the type of variable *reg_val* to int.
>=20
> Addresses-Coverity-ID: 1473970 ("Unsigned compared against 0")
> Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_page =
functions")

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks!
Quentin

--3vhf2tsc24yoqypk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu9orIACgkQhLiadT7g
8aPBihAAqfObV70EoaeIE16bTAHd/4Bca15w0mLe+DqiXpsL+0U3cx40OQQswvU/
D5Lx0MK/hNEwtn9PSW/KnTrnvWiBQYWBbEcxvV6Q8oNlO2fRvR/myrqcRyUVZ9EB
mkSK1mtHDDt6kbkDIoEpdQ2cusxQRZ6VE7pWnpXK5bS+iZ/iNCOiNW+ANTJBjSwj
y38vZkam3BbGV3MkX2jwzsWV3AocZA2GRnb/LTCR8rpPoOM//dwpZ2HG3D/ItE5L
um42w2TxnhiUF89Fn2v1JeXdYj2j64YdfPDUQXNAGVDcPPwUMoQQbeDK/FY/afzY
VJ9Y662KMuyN+1EI0vc8Em7Qd31e663WE/xzeAdtV1+jyOjNP38mM7mqKszqFuBY
GKsshz8n6cBYO996sGQC6cyjnbbDBdWfgC9E1l/Fcd8dxf2XOWayCwtjqckgV+vv
DfF63i1Ga0CpZuoRsOJamC5QVWTNLNsirinJYWafmOyGr1MgFOk6EYISFUKoyFI9
kpowkG3ogLOlPnwznnu4Ajv54vTsJZ+TIy8PeY2Id3ijYWZZCUF43ISC83Tqxn0O
hzFy6xms6Y9nvqt+ZU6zD1B7qDGZRZrdOJBNfY/SBp57SjcqibLE2TinSCxyRsS9
n0IkkC5ceUoflat3w/TzYp3aE0AhZgEWcRSB+uSWqFPlGo5gjeM=
=Ptjv
-----END PGP SIGNATURE-----

--3vhf2tsc24yoqypk--
