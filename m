Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A404BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AFF218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfADSGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:06:15 -0500
Received: from sauhun.de ([88.99.104.3]:35072 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADSGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:06:14 -0500
Received: from localhost (p54B3373D.dip0.t-ipconnect.de [84.179.55.61])
        by pokefinder.org (Postfix) with ESMTPSA id E0F5B2E3614;
        Fri,  4 Jan 2019 19:06:12 +0100 (CET)
Date:   Fri, 4 Jan 2019 19:06:12 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: use struct_size() in
 devm_kzalloc()
Message-ID: <20190104180612.GE3009@kunai>
References: <20190104174327.GA30932@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <20190104174327.GA30932@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:

I am okay with this patch in general. However, I think the name of the
helper 'struct_size' is a bit unfortunate. I really wondered on the
first read why it needs 3 arguments to find out a struct size. I only
understood on the second read. I think 'trailing_array_struct_size'
would be way more clearer what it does.


--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwvoJQACgkQFA3kzBSg
Kbab8g/8Csm4yMDQXB3AiC2iWdWtjRM0k03QWDCvN3dVV1VGWbpuO6534EsmKF6g
vLHMtJJ0oZv5d7PiNKfmX6Pit4brrBYqW1cQ0EyWTbgSSm8HBP6WQFqy7v0QADSi
7vCUJeoY8SppZiM3zNxM5mtusbGfVBROmk6buEAF+gvzTUG2TiqJv/o5qPdG+iC4
MECZEzfPG93VXz+PsL2NILbpX7KV8c1EFeXlL2AU7AxNOkl781hlrOYIlj1f9A/l
bKo4UKLbsWGPh1kdwSNr/IbDjEWOSY9BdEsfj4NS39EfetdF6Pn4HiyV5s65g8yf
entP8bOUgXG8AMLxU9e9B6ydUniMy2ASvELV/XDXkcHAAFhbALylAgCN4G6zO0vH
cFP8G0IrhWmNULL3pTQm2BjHZxdj8x1nG38qqUZkmzZ7+0RULOcmzK2U+ddc8KBp
BJMOOAFzAPo6BiZlNdjR1wHPThUUaCDfzBhY1qn5D+RAPXPJYM33nLfYdkLwrFvo
ZalWEZJgrtW7Q1cvsfK5Kh4sUM905AYDcZTpLvTJIBLrV6YvNAB9+2m1CHvNKr0M
idaS/anHyz/2K5PlhLZ1i7UuyRRX34vy39hLa5CwfUKt46votKoGyw9Bbd+AWlRE
PBxOBzeRoqQB/uj1tkYtCVqf/1dYvmKC7rqyWQBI7UuYRRj1v74=
=d9UO
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
