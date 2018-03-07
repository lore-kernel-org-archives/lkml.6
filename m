Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeCGOgd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:36:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57492 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCGOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:36:32 -0500
Date: Wed, 7 Mar 2018 14:36:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Tim Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Guo Zeng <Guo.Zeng@csr.com>
Subject: Re: [PATCH v2] regmap: irq: fix ack-invert
Message-ID: <20180307143629.GG7290@sirena.org.uk>
References: <1520283457-31637-1-git-send-email-tharvey@gateworks.com>
 <20180306145749.GC5799@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Content-Disposition: inline
In-Reply-To: <20180306145749.GC5799@atomide.com>
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 06:57:49AM -0800, Tony Lindgren wrote:

> > By using regmap_irq_update_bits to ACK the interrupts we use the masked
> > status bits so we take care not to affect any other bits then use
> > ack_invert to determine if we clear or set those bits.

> This change to use regmap_irq_update_bits() now breaks things for
> me with cpcap interrupts. So it seems to cause a non-inverted mode
> regression. There should be no need to read the ack register, I
> gues that's the whole idea of having a separate ack register :)

Yes, that'd be my expectation as well - the register should be just
write only.  regmap_update_bits() definitely isn't the right thing here
since it will suppress the write part of the read/modify/write cycle if
it detects that it didn't actually modify anything as an optimization.

--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqf+O0ACgkQJNaLcl1U
h9AZ0Af/c6BIvxLuu1Qn8ihGVSG/xaNc+NnuCFm3t2m9VBTaj+B4X/cZfpA1q9vs
B85yE51ewcb7E6tFbJXhGMTOEN7Ax0Hv7bE90jnNrPKTBvwqvxvxnZxk2NgCZKUY
BOAALv+4QXFJJo1PMYtTkc+2MH+t2BfyYxVH7+pqJBQfHFZxcq67Gw1C2efcC4Lj
8UKrPtkvTKkQw5J2XKbzX/66cnmy9/A63hPvHB02Qs9UvhV8Gm8ME7uQZ98+isQ7
dCh76dWVRLIcT++WKaRrgsBcuHSuv5xlFzMbusZXBbzwS2p8D9/DCG72WT9ak2E6
fM7tlLfS+Ac0DcCo7lT7ET7h9s/LBQ==
=HiLJ
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--
