Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeB1I2q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:28:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:53348 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751126AbeB1I2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:28:45 -0500
Date: Wed, 28 Feb 2018 09:28:43 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add a binding for the sunxi message box
Message-ID: <20180228082843.fga47gfrv2g5kmiz@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5ct4qf4wlve2wiua"
Content-Disposition: inline
In-Reply-To: <20180228022714.30068-2-samuel@sholland.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5ct4qf4wlve2wiua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2018 at 08:27:12PM -0600, Samuel Holland wrote:
> This mailbox hardware is present in several Allwinner sun8i and sun50i
> SoCs. Add a device tree binding for it.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/mailbox/sunxi-msgbox.txt   | 40 ++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbo=
x.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt b=
/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> new file mode 100644
> index 000000000000..3b3ed7f870a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> @@ -0,0 +1,40 @@
> +Allwinner sunxi Message Box
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +The hardware message box on sunxi SoCs is a two-user mailbox controller
> +containing 8 unidirectional FIFOs bonded into 4 bidirectional mailbox ch=
annels.
> +An interrupt is raised for received messages, but software must poll to =
know
> +when a transmitted message has been acknowledged by the remote user.
> +
> +Refer to ./mailbox.txt for generic information about mailbox device-tree
> +bindings.
> +
> +Mailbox Device Node:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "allwinner,sunxi-msgbox".

The IP change quite often in the Allwinner SoCs, so it would be better
to use a more specific compatible there. IIRC that IP was introduced
with the A31, so what about sun6i-a31-msgbox?

> +- reg:			Contains the mailbox register address range (base
> +			address and length).
> +- clocks:		phandle for the clock controller and specifier.
> +- clock-names:		Must be "bus".
> +- resets:		phandle for the reset controller and specifier.
> +- reset-names:		Must be "bus".
> +- interrupts:		Contains interrupt information for the mailbox.
> +- #mbox-cells		Must be 2 - the indexes of the transmit and receive
> +			channels, respectively.

That would prevent any unidirectional communication, wouldn't it?
Other mailboxes driver seem to have two mbox channels, one for each
direction, which also seem to mimic our DMA bindings (where we are in
pretty much the same situation).

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5ct4qf4wlve2wiua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqWaDoACgkQ0rTAlCFN
r3SAlw/+JVlP12hEQO3c+N9nXlJJaog946jybj40D0sQC2Oz1+ifJ5uqnl80EudG
P7dWyZUvyhNPE7iM8UF2ntmZ0m07f8MysUScPmsbke7dIfjDkxEdnnMmXz4coXaX
jlfJliXNke4EoPZOcVLU2omZl90MQoVUVyFcY+nWZHhIxD0YSEwIt63DV1q5BYLr
ve2n7h7QIaMwwnU1+5UXv2MIh17f5Do7nesEipF6AYsiOtkuztZ4xMd7kFU1E8md
BB8rcIyEJ6gVYp0avaIPoxTJlqSXnAoUQWHjGhsEmB3IZ3CL4GIkmSgYibzfyhbo
B3Tgt98SbNZyKBuqOr8jo85gG3OxZ9vHcQtMf8QTTAzg/F/IegB3iRRKckkTUHeX
+++Sk/wkTonEXAKEatgneGmHtCmVGgRsf4sEiA+W8xaqYiEIwYOw7LSODzvvQ1e+
SYI496k+rJ9jPLDCgSemBvpOJBRkMPeMOaRxNDP5ywdqlRYsJL4Udb/bz0L96Skh
qMx2Eh9zXYBElNw89MlXLsp+nIWTfo+MTIp2A5RDkI+Igt+fsG4/Tm/UZB4ucGQE
lofWAoiFgCwddyXbJZJzZ88pz6/5KHgo4GKWxulbraaqnZ380GiDS8Vchz/yj5C5
2WVtzVy+ZvMGg/ZFbCJE4vCUoZSYjvdQarXPJGICSCKydhbORrw=
=CxO8
-----END PGP SIGNATURE-----

--5ct4qf4wlve2wiua--
