Return-Path: <andrew@aj.id.au>
X-Google-Smtp-Source: AH8x2269qry00xmJMNXd2s4WRXaclVC9a91iwAs9GitzQ3CLF+04KxexzztXFe7HhR+anoKgW090
ARC-Seal: i=1; a=rsa-sha256; t=1518757469; cv=none;
        d=google.com; s=arc-20160816;
        b=VnN5naeIeQKLVUUWdfQcnsP6bAFrUME8faRN8menk06lksA7Gpjf5M87XOsc0ZvLaj
         +jPAvVQSo5x6SJvJPo2qXt7VlpIORGf/XA+CDosQfeaP3c1P22+vk2x6Z7+ppeg7PVeU
         eJZ8oV91ae+rLqAVkv1KxYgUuWpRHIv0sHY6YY2IkAAjYWQ6IVDVZXPklsl3//CKytOR
         sIog1/c+yLj7jgPaRi6RiUMuzN1I4t1JY/jNYiOMCg11WY47RqPxzQrmc5p/Ynq+eY+c
         gWJ9WDKFgWPEqP6QygNhydg6dDrFQJmPj7ur62xBbQ/t8FX+EYl1InHYVq18pwNIH3w5
         5Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:date:cc:to:from:subject
         :message-id:dkim-signature:dkim-signature:arc-authentication-results;
        bh=85jfjxWz5qXBz6/y6YcJ143ZbqHMEPwwmDZRu4wG5uU=;
        b=VJ08klJkVlxD76Vv0flIkS0fwQ2/Nn1GN4wKLFT2LT0kl9ucb0YxxiA6TRV78YOdPc
         ID785ADrZvWCZi70DEX8wwtnLO6WTIYrlY5MYpyiwYRC4rgnNdWjq8MgjZpoR6/UEUuZ
         7vwMP3Kh1ccTfXmJNEinDfumCy1o8AZpZllYCbRAPQBzodXzIAFBCIzHpRW4ST97UQgX
         0ei5kUSCx5DBBDffS9/YhjBFKkz2soq6nPo0wSr2/4HRzruamJ2CCm9Us2MzwJFZvZ2H
         B8brMm5t+i/4fm8o8sTLO7t5R4PvCockd25YV2MH0OJ+71mpcLplR6yzP6tx9E9GE7Ii
         pQUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@aj.id.au header.s=fm2 header.b=rCE4zAed;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=V38fea4s;
       spf=pass (google.com: domain of andrew@aj.id.au designates 66.111.4.29 as permitted sender) smtp.mailfrom=andrew@aj.id.au
Authentication-Results: mx.google.com;
       dkim=pass header.i=@aj.id.au header.s=fm2 header.b=rCE4zAed;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=V38fea4s;
       spf=pass (google.com: domain of andrew@aj.id.au designates 66.111.4.29 as permitted sender) smtp.mailfrom=andrew@aj.id.au
X-ME-Sender: <xms:XGaGWvLeZVyNIIVEtjIwBOIGk_OUBFHdjVPq5IdXfK2HvCdP3fMQEg>
Message-ID: <1518757459.10440.32.camel@aj.id.au>
Subject: Re: [PATCH 1/3] dt-bindings: aspeed-lpc: Document LPC Host
 Interface Controller
From: Andrew Jeffery <andrew@aj.id.au>
To: Joel Stanley <joel@jms.id.au>, Lee Jones <lee.jones@linaro.org>, Rob
	Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Cyril Bur <cyrilbur@gmail.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Lei YU <mine260309@gmail.com>
Date: Fri, 16 Feb 2018 15:34:19 +1030
In-Reply-To: <20180212070847.32387-2-joel@jms.id.au>
References: <20180212070847.32387-1-joel@jms.id.au>
	 <20180212070847.32387-2-joel@jms.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gNbZ4d3BCzIKF12NhpLC"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178085601098938?=
X-GMAIL-MSGID: =?utf-8?q?1592532632335127979?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--=-gNbZ4d3BCzIKF12NhpLC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-02-12 at 17:38 +1030, Joel Stanley wrote:
> The LPC Host Interface Controller is part of a BMC SoC that is used for
> communication with the host.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt         | 40 ++++++++++++++++=
++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Docum=
entation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 514d82ced95b..94a31de109c4 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -109,6 +109,46 @@ lpc: lpc@1e789000 {
>  	};
>  };
> =20
> +BMC Node Children
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LPC Host Interface Controller

This should be under the Host Node Children header given the
function's position in the MMIO layout and the split prescribed by the
bindings.

> +-------------------
> +
> +The LPC Host Interface Controller manages functions exposed to the host =
such as
> +LPC firmware hub cycles, configuration of the LPC-to-AHB mapping, UART
> +management and bus snoop configuration.
> +
> +Required properties:
> +
> +- compatible:	One of:
> +		"aspeed,ast2400-lpc-ctrl";
> +		"aspeed,ast2500-lpc-ctrl";
> +
> +- reg:		contains offset/length values of the host interface controller
> +		memory regions
> +
> +- clocks:	contains a phandle to the syscon node describing the clocks.
> +		There should then be one cell representing the clock to use
> +
> +- memory-region: A phandle to a reserved_memory region to be used for th=
e LPC
> +		to AHB mapping
> +
> +- flash:	A phandle to the SPI flash controller containing the flash to
> +		be exposed over the LPC to AHB mapping
> +
> +Example:
> +
> +lpc-host@80 {
> +	lpc_ctrl: lpc-ctrl@0 {
> +		compatible =3D "aspeed,ast2500-lpc-ctrl";
> +		reg =3D <0x0 0x80>;
> +		clocks =3D <&syscon ASPEED_CLK_GATE_LCLK>;
> +		memory-region =3D <&flash_memory>;
> +		flash =3D <&spi>;
> +	};
> +};

ACK wrt the content, just need to fix its location.

> +
>  Host Node Children
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
--=-gNbZ4d3BCzIKF12NhpLC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJahmZTAAoJEJ0dnzgO5LT52c4P/3ZzJU8r2LgucUqkicb8QSTq
EK3WKpJcyJGYkIrvd8pf/8VdG0rTnz2jLVdNGUUMFRDWjG7aUo8rL0GtCPpFWsjB
j9DRVdwZLrdAfYmZ8Bv8CK6isBx9jzjAWeFN7i+LvcjmS5LM/slRvk+n7UuwATe/
1s5dpYu+6FrFSPV/1Fa0tG1VuEw9Iv2bDK1DdVPyVu0Lt1IogXnNnDLHkauFEhxU
67XQbBBXRXNAklMrWDwnRtgdotKXVpmv5IcPA9uGgwAXH5J8QnEQ8DKRpLw+VPIt
s2E3l2yZLydQ1sAoWaJeD5CUeAadt+p6CutV1oIU3o4YrgE4H0Lx1ikfFYXI6E2+
xdL5ObabsBi9p4hJ/0kc5VUqX/FWkuTqMqsU7MOxjUocf9iKDRX8AP40zzppCqIO
OqnySRxDrRy/sWEdPUrjM/XotooW55FPLlugP7MzFogoJAUMTJ+imZevEHUOK/Wx
ZQY4ExX9fblB/r4hGiAu+guw3uRRqM027enVbJVIyW+8X126W7WCWXgB5tRcHg3E
/2zxMwWwiEO2NLBHVKvju7V5uOH/jXifAISPrqfoyc2trJb4nf9vN40EFwq3YnEs
0gh9rXGqxGI0WM8VxkhXO9qkYZ1LLzduElQG8Ly5XNj1Wu/WM60Ba+7p8zGdVU2Y
Q5zBxZj6FzhZdTqPjLKe
=Fyfi
-----END PGP SIGNATURE-----

--=-gNbZ4d3BCzIKF12NhpLC--
