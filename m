Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB9q5YSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5441A601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932492AbeFFISe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:18:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44817 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbeFFISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:18:31 -0400
X-Google-Smtp-Source: ADUXVKITCuR64xp+KaIdqhtSKkkPEgRb5NQ6om9jP3R6R8tLrp9mqxADPjnOkrB4fYadKGRaXID7SQ==
Date: Wed, 6 Jun 2018 10:18:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
Message-ID: <20180606081827.GD11810@ulmo>
References: <20180525210843.1821071-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <20180525210843.1821071-1-arnd@arndb.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 25, 2018 at 11:08:30PM +0200, Arnd Bergmann wrote:
> Without dmaengine support, we get a harmless warning about an
> unused function:
>=20
> drivers/pwm/pwm-stm32.c:166:12: error: 'stm32_pwm_capture' defined but no=
t used [-Werror=3Dunused-function]
>=20
> Changing the #ifdef to an IS_ENABLED() check shuts up that warning
> and is slightly nicer to read.
>=20
> Fixes: 53e38fe73f94 ("pwm: stm32: Add capture support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pwm/pwm-stm32.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Lee, I applied this on top of your immutable MFD/PWM branch because it
depends on the capture support that you applied. I wasn't sure what your
PR timing was going to be, so I thought I'd do it this way since I'm
pulling in some last minute fixes for v4.18.

Thierry

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsXmNMACgkQ3SOs138+
s6EcEBAAqwZUm5dl8ofKzCnB3CIifLjGBte4Yw5gnfyd4+WYlkth7fNMZgdCV+Y6
0wb8O7kD1G3XR8JUFY2va6xkwJ+kZ77MUcxS30tv12y8XFngRIHnqtC8YEh+Yfnm
mPT2Ci5KLl239jRiTgptWRxCzbbXCNpkGl+nzO5nFtvQ7RGGn0uhBzYvwVomnCMk
kF9CXAzPe53zXerh4URh9UeU+64tzr1k9CntsqrKTAraqIlaA4tdGTGUfgvZxLu9
CB7ejodJ5RXz7LbseIAjjoaprECU67Dtl8wrrhIE8GCqbV19TlczkLnUHuurPwMo
0VewxWb2XP3hPGm1XDuflPAvsTvdBS/8JasVLXPN8N4+XyNtJhZLYykUBkaW2M5Q
7OJCsgfh2Z8wVaNZ0n/l4CWyJDt2SkMFz1SNbDAlEbowJ0XCYTiagZsGAcrf32VV
7RGtYlCTq8rZ99jVPUQsLBbbZZMgclG+NFXSGMnjcTdP//Ihf3Dw9KdMA8M3VgDC
jh3DGrp1MAR07/diomHi97CX+9IAPm51VFWcKvonbPgHn7J9mckddCR0onk9h+wC
6W4gZ1MTJpFcXL0nmBKMTU6DQPTzHvpCsdfmCBfbTVLKf0tDDBIHpS/JH8s776Ab
oZ/dyickV62XE4f4C8X/Cf9/P141PmceysLLzotgaoj+HB2GOts=
=/eQ9
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
