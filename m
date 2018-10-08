Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA9C676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E31620858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E31620858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJHTmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:42:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45449 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJHTmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:42:17 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42TKTL0GBZz1r0t0;
        Mon,  8 Oct 2018 14:30:46 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42TKTK6wbXz1qvlN;
        Mon,  8 Oct 2018 14:30:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Is6fKgegQWuB; Mon,  8 Oct 2018 14:30:44 +0200 (CEST)
X-Auth-Info: 0ELHI46n7ChVU/oMDA2Wsdu834TRt0VaJ9eR4ryAWSI=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  8 Oct 2018 14:30:44 +0200 (CEST)
Date:   Mon, 8 Oct 2018 14:30:43 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: bk4: Add device tree binding for
 Liebherr's BK4 SPI bus
Message-ID: <20181008143043.07cf1e56@jawa>
In-Reply-To: <20180927222655.24482-1-lukma@denx.de>
References: <20180927222655.24482-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eZHbOnwSVPpyTV8dcXOw_/x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eZHbOnwSVPpyTV8dcXOw_/x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

> Add Device Tree binding document for Liebherr's BK4 external SPI bus.
>=20

Gentle ping...

> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/misc/lwn-bk4.txt | 26
> ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/lwn-bk4.txt
>=20
> diff --git a/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> b/Documentation/devicetree/bindings/misc/lwn-bk4.txt new file mode
> 100644 index 000000000000..d6a8c188c087
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> @@ -0,0 +1,26 @@
> +* Liebherr's BK4 controller external SPI
> +
> +A device which handles data acquisition from compatible industrial
> +peripherals.
> +The SPI is used for data and management purposes in both master and
> +slave modes.
> +
> +Required properties:
> +
> +- compatible : Should be "lwn,bk4"
> +
> +Required SPI properties:
> +
> +- reg : Should be address of the device chip select within
> +  the controller.
> +
> +- spi-max-frequency : Maximum SPI clocking speed of device in Hz,
> should be
> +  30MHz at most for the Liebherr's BK4 external bus.
> +
> +Example:
> +
> +spidev0: spi@0 {
> +	compatible =3D "lwn,bk4";
> +	spi-max-frequency =3D <30000000>;
> +	reg =3D <0>;
> +};




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/eZHbOnwSVPpyTV8dcXOw_/x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlu7TfMACgkQAR8vZIA0
zr0YHQgApyUSUb/7k1+H3dA98OpAvPyaYaIV3WB4NNWkfS0JrPA9s8/m9qc4w4dc
YRGr1n0dzQEcZZ8aSo/e1iH6/x8qzdfuXulQXvbkOnKlJ4SfALO/0VnMxKb5bMTw
EhHHdijsyJn811KALDi+TBvgPbeBBN9DhGV9TiP+fZBdj1nfMB+qyCrBKl9hN3iB
RjIsH5ROczFfh3n6VUiLNznelsPJ+tgh7l/nkfjNHD7Fja6wwSjnnfL50uS5SPT5
GL1PrewyEZ+l2l3dJS12dMzOCxoMky1o1aJ795dIyzYYTwQq0DoNHPJKkE1TaXaF
PTHUaxzfIjfbjaHWTd2xcfY9stHfPQ==
=u8RR
-----END PGP SIGNATURE-----

--Sig_/eZHbOnwSVPpyTV8dcXOw_/x--
