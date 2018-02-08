Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBHIYR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:24:17 -0500
Received: from anholt.net ([50.246.234.109]:44710 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeBHIYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:24:16 -0500
From: Eric Anholt <eric@anholt.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Brown <broonie@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc: linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
In-Reply-To: <20180207160002.GA9292@embeddedgus>
References: <20180207160002.GA9292@embeddedgus>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date: Thu, 08 Feb 2018 08:22:54 +0000
Message-ID: <87inb7c2ld.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> Add suffix ULL to constant 9 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> unsigned long long (64 bits, unsigned).
>
> The expression tfr->len * 9 * 1000000 is currently being evaluated
> using 32-bit arithmetic.
>
> Addresses-Coverity-ID: 1339619
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

The effect looks like it would be that we would have chosen polling mode
instead of waiting for interrupts for some transfers >477 seconds.
Seems like a good fix for an unlikely bug.

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlp8CN8ACgkQtdYpNtH8
nuhFJg/+If8zqN025T35hzY8SlSSyWxwWL0VFvyljQaDUkwMYkEvcgdpAMF7NX+N
86SO2VtTAmxDc/bFQCHhdMrU65LTpsuFE4Vx8KP0MAYtw7jZF+caMYp+n7xpTG5U
2+3o6GyOpXX5A4iKPc2J0yw70YsRmah+s/mpZPH/EcSh89tmZdEcEdwSXAGjgND2
Dn/XEuUXuLB8AozI1feyMyM1c8pzq04PDiu6Kx8hqSB5h0UtiemnrmPL12CLvypa
l1lEyArkAmd8URtMEr6fWXZxHq2ikst8BFk9QGvtsp3UeePDgbcRA0hmJh+rsLJM
0ATE8Grcb6Do/NC6NDQw/seSHjvR90RxZ98TEGVFCTl4+11RUU8YhCGUOBe3+9SB
VBSMEsd3vk1tPnauM+qkLic2gjjdM9Qbeh09pzMxDL6svMti4wVsbIz4zDiRL0/v
7zDWpCXwBH0QJlNXJWPmZ0A5KppoloYPuPwg9YVm7gb2SnL21tWCoy5tP0SsFi3A
w7yd4XDbsqGJwB0dh6qiWM20fGaqqz6OPUB1KdQwNdPk0h44z8KAKJKugwisfGy2
j06VhvLK+iEGR/4d5UKZAWgN9KRIZtYO8NZDLuNQQQlExirMsOTMSsg/wZl1ZN+p
qep7mpfKkh2vaCr3y+FXNE2AzrQ1KiN6Qf8zCH2PRxLPuJIuh6M=
=n2nX
-----END PGP SIGNATURE-----
--=-=-=--
