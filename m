Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F18C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3512146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfBSUZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:25:31 -0500
Received: from sauhun.de ([88.99.104.3]:49298 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSUZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:25:30 -0500
Received: from localhost (p54B338D8.dip0.t-ipconnect.de [84.179.56.216])
        by pokefinder.org (Postfix) with ESMTPSA id 78A892CF689;
        Tue, 19 Feb 2019 21:25:28 +0100 (CET)
Date:   Tue, 19 Feb 2019 21:25:27 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: designware: Add support for a bus clock
Message-ID: <20190219202527.rz45advkmpyzvaf4@katana>
References: <1550589042-11096-1-git-send-email-gareth.williams.jx@renesas.com>
 <1550589042-11096-3-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xncw63d3ut7d66zp"
Content-Disposition: inline
In-Reply-To: <1550589042-11096-3-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xncw63d3ut7d66zp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> -	if (prepare)
> +	if (prepare) {
> +		/* Optional bus clock */
> +		ret = clk_prepare_enable(dev->busclk);
> +		if (ret)
> +			return ret;
> +
>  		return clk_prepare_enable(dev->clk);

This leaves 'busclk' enabled when the other clock fails.


--xncw63d3ut7d66zp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxsZjcACgkQFA3kzBSg
KbYF/Q//YfCWlIPd7f5aibwFWpnbkSx2UvQwQg/+XuG/IA8BTP3NTwXD6r/S5zOZ
5DSUrYAkyRlvzisB7IEKhTzAG9lTNgIhGZxYWraI00zw9ahpfxJP9Eu45t7sPmPW
nWRg6WlHtVlEYIOP+AAR4+qnlb6FaNYISpy14pSA1xNSGf3SidE9yKZANblrKGuS
HECknFMvMHTJ4AayzyjzZXUH3AIXvTKXVgKGOgkk1Uv5AdI5AOtRmVFpaW5Ax30J
LRKr2Ald7345U4uyuA9nXctaLu2PR9UyVJ/Vpiu5k8K1ucW7XMMUcHnHNXdZUqMI
yAIZimb5tjAHh3TbsBQ00CG9vip9FkpavPLjLouGBXvc0ixKXZlpJyCkYn5C4d8+
vn/YdV3GzEcicXSPKh8dJA5OSCeeAtIDIo+C46tNDnm9vw/3ZROi3Al+SDdzPAtl
TbUR7thUTQ2bz6rMJD4HPYQ3Pi3D0EGGpQJ0yhfgBaCdJhBHwP1jSH05NfgffODt
TBj690d1s+xaU0LAR/vSVQFPXjqwC5BBYUTu92CopAIJJc9/6EfsQTCQbKa5zI1y
/ZLX9SeBFRKMdGx0C7odTmcudUi9N9UkPiVVpsYJApAAKd6rjYpRc14eEwHpQqFg
qo1Jny5QJ5fQWwgNOKHkMePzdnwVME0BXNzHzAw2SGbbkHDDKPw=
=1A/8
-----END PGP SIGNATURE-----

--xncw63d3ut7d66zp--
