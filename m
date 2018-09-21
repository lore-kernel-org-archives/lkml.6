Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D1ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A4C2154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A4C2154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbeIUTcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:32:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39489 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeIUTck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:32:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9CA8420795; Fri, 21 Sep 2018 15:43:42 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id 40275208D9;
        Fri, 21 Sep 2018 15:43:16 +0200 (CEST)
Date:   Fri, 21 Sep 2018 15:43:16 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     wens@csie.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH -next] pinctrl: sunxi: fix 'pctrl->functions' allocation
 in sunxi_pinctrl_build_state
Message-ID: <20180921134316.io4isy7fgewjkcrv@flea>
References: <20180921015941.28468-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d5kfno5n4ibzgult"
Content-Disposition: inline
In-Reply-To: <20180921015941.28468-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d5kfno5n4ibzgult
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 09:59:41AM +0800, YueHaibing wrote:
> fixes following Smatch static check warning:
>=20
>  ./drivers/pinctrl/sunxi/pinctrl-sunxi.c:1112 sunxi_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
>=20
> As we will be calling krealloc() on pointer 'pctrl->functions', which mea=
ns
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
>=20
> Fixes: 0e37f88d9ad8 ("ARM: sunxi: Add pinctrl driver for Allwinner SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--d5kfno5n4ibzgult
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluk9XMACgkQ0rTAlCFN
r3QlYA//at/S51iemKySABdUNfmxAbP4GxYkIoBSEDPggtdtuM37fmjb/riNLLM6
s4WUoitJVaTTTwpRVPLtrLYrFoB/ExGKqqrFhHV6VuXLScgjgHgK6aKqaxJMCXIb
BxOTWbkQdKDmr4URa2Sv9ixIziIWtJub/pn2KJGkS4ohO9GUEy8oZLqdt9JuvYa4
JjhzjmRUAzdQUdnAFXjR8Qys3oQqqI0I6yIO81ZQqBNHAsC18xnvR6BhD4wIZewj
NXUr8uc6BfPcxQZvJa51UikSpFkBm7NpuAKATcbgLJ43q2oYUzCCLCysetV4I4EG
XpgGfhdWagQBYFKLxv2ny7qL17jcyIaZzfmf6PkWMVclA653ppnDOp9y5RyTsJln
OlwlWy2RGI7FV9YSCIh2ZyqC/N7t0izqYSFw2ehzU+YVYtfQhy6Rytx1Fr5ezE3u
euEKlZVcNaqOubgD4M++rQPpm78cRxG8ZzMh07nUP8oSbEzXjV02tknnh1GA77qB
i+azXJ1hlOc0KjZppxwzPKn/jAc/nlWTsbnexST5qXmK3pmmUcyW8E8xjnnevdjC
6nQBk17l21UhvL7h09WduAsgbBP9i8qLKbLiAoTqwNLWs1jsCq0zaH42Y6YbEpnK
lnmv5rJI62l9EXwplP6zmr7jxiTsBMQrn0hReZRIS8c904qsU1U=
=9tKN
-----END PGP SIGNATURE-----

--d5kfno5n4ibzgult--
