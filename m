Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeEDPJd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:09:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35460 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDPJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:09:30 -0400
Date: Fri, 4 May 2018 17:09:28 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/7] arm64: allwinner: h6: add node for R_PIO pin
 controller
Message-ID: <20180504150928.252mifsr533j6kvr@flea>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6zcrwr66nczuc3u2"
Content-Disposition: inline
In-Reply-To: <20180503183847.11046-5-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zcrwr66nczuc3u2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 02:38:44AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_PIO pin controller which controls PL and PM
> GPIO banks.
>=20
> Add support for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index db9da343ba46..a18b78fb4850 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -183,5 +183,18 @@
>  			#clock-cells =3D <1>;
>  			#reset-cells =3D <1>;
>  		};
> +
> +		r_pio: pinctrl@7022000 {
> +			compatible =3D "allwinner,sun50i-h6-r-pinctrl";
> +			reg =3D <0x07022000 0x400>;
> +			interrupts =3D <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&r_ccu CLK_R_APB1>, <&osc24M>, <&osc32k>;

As usual, try not to use the indices you introduce in the previous
patches of your serie. This introduces a dependency between the clk
and arm-soc tree that is not easy to deal with.

changed for the raw index, and applied, thanks!
maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--6zcrwr66nczuc3u2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrsd6cACgkQ0rTAlCFN
r3RXqw//WJkFW0L593QGYos88yEhGiKsZYGzjop2eej3pHaNZeoWbVK2ibV8XgFc
Ir+PgQ+PfuVd2h8gIZmFsGoiQnY5PRUG10Y4EbKQwI+701RFDpM6+WLHk1k19zH7
OfO84ucNIxpoi/fgpw/t7Yny1D7TLH6wvezddDicroR6rbq0YKsIgp/wLfr93Hr2
UaEWnlu7ImNo5t2tlQ/dGxUPNmYdj2FICUTEVcutE4tSHAQS+c89j7EIxMJIJLiV
RlHfZMUnxP7vVPFKt7Yqna1P9vw2SFUOqpsvnImjlEhgwYUQ+SwiqUGeu3inumNz
x4TW80xm704QuIKfn1t0QahSHltxcRL6VZgeGc+od8cHkvENloo2ghCBtKCF2Ftp
TGMfIbaRsPZIfHOkEjYlPN3hg+SINQydcOJWB+Aq3ofa9Cr2bEqDfP9aLN5NRpSF
MiDL5uhhMYo0JJgRx20gJP5O7ZnmjIANM9rMVQ33B369vePv72Vib2d9EgOPYOge
t+MrJS4NSQgEXtq1AqQXgugKkYJ2FZU67oNq98p/Fu9lCbzmtzKbd6KHYaLxlanx
QG8E4ItNsciXxXwcjdGs1nbzLy7t/cGKZbtTttEikl5lmY4vmv/CXaO7Thh8P+lT
JLFRIaiapYjItXSexX9G9+DBB7YdE1zopUt80KRG0G7yXRWaoa0=
=osqH
-----END PGP SIGNATURE-----

--6zcrwr66nczuc3u2--
