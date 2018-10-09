Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F921C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB97204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB97204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeJIOok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:44:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42188 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbeJIOok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:44:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E32B7207C4; Tue,  9 Oct 2018 09:29:03 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id A9C5C20717;
        Tue,  9 Oct 2018 09:28:53 +0200 (CEST)
Date:   Tue, 9 Oct 2018 09:28:53 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] phy: ocelot-serdes: fix out-of-bounds bug
Message-ID: <20181009072853.t4jjqdlvc4g735hm@qschulz>
References: <cover.1539036280.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2hg36japngcgt3t"
Content-Disposition: inline
In-Reply-To: <cover.1539036280.git.gustavo@embeddedor.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2hg36japngcgt3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, Oct 09, 2018 at 12:20:28AM +0200, Gustavo A. R. Silva wrote:
> This patchset aims to fix an out-of-bounds bug in
> the phy-ocelot-serdes driver.
>=20
> Currently, there is an out-of-bounds read on array ctrl->phys,
> once variable i reaches the maximum array size of SERDES_MAX
> in the for loop.
>=20
> Quentin Schulz pointed out that SERDES_MAX is a valid value to
> index ctrl->phys. So, I updated SERDES_MAX to be SERDES6G_MAX + 1
> in include/dt-bindings/phy/phy-ocelot-serdes.h.
>=20
> Then I changed the condition in the for loop from
> i <=3D SERDES_MAX to i < SERDES_MAX in order to
> complete the fix.
>=20
> The reason I'm sending this fix as series is because
> checkpatch reported an error when I first tried to
> integrate the whole solution into a singe patch. So,
> changes to dt-bindings should be sent as a separate
> patch.
>=20

Much appreciated, thank you!

Quentin

--s2hg36japngcgt3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu8WLUACgkQhLiadT7g
8aP/Xw//Sb5u2WBcKkRQ3/kAMWd4C6r5/Ke2ID6V9wUk04n/IH2V3coTqNfNTjTi
vXiVjYD628H7A2Eqsw/qhn3rHWoaek1WbV02ZlORVll/7XQdTepxH72vQKiVOLO1
n8WHT3LRSutqhNfvvIPuvxbVklrDwr3OUT2Pcjyk+Nb3vXFCksLGXTrORbFiEtNO
nVem4NT3UmZvE2NnMDRjvf9Rsc4npyyrrIgAfEF36tusCaHSrt3V8GIX94ddQ1fW
f9Rwv0YDWw05vUw2c8ZoW6nMdrHZPA4HsTmclG5jcS+cVcPbYskmkWRtMcQNCEok
9t+JIdyYBqMBp4KU18n8KHv6FhqZlr8DwIOjntr96O1nzVnRNfHcsC3RRDFR8Waj
RNbMvnwzs0eHlXgaVfuXDgoNSJn05OxcgHsRfsK0Y+2QtncY3yvaCKYqUSMqjoAx
192ZGoc3xA32t+oY59GF0L13j7Yeou/XLRixCN0K6CdnrTpfhGVOCRp/k0ctA5y2
e33lhWT/zFn1BbqqQCS0nl93tTu+tqVBiowGIZv7uEEBpbVbbm6/hdJ2GEGfa5NR
dAH/Qk1CyfBGWefMhlC4Te88556cv1w/IhspSW2PzOlGgd4HS3BcGpQeDjAfc4vO
xCv/zK+sWNxTeZ4enVv7geuaR7I+LNlGe/XqwlRHESpEKCjt5hs=
=/lkD
-----END PGP SIGNATURE-----

--s2hg36japngcgt3t--
