Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A3A214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iQd4v5E9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbfAJW4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:56:09 -0500
Received: from ozlabs.org ([203.11.71.1]:51137 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfAJW4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:56:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43bLvV1KW1z9sCs;
        Fri, 11 Jan 2019 09:56:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547160966;
        bh=kqm9s2zyajwfla164th5NEoKtqyz9X87B6UQliZXw1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iQd4v5E9DZeDR0eDgPmmMwN+SZuNSIn6c+mtV677wmregpMnbYfYXe/ZoBUcIoIp1
         YVrq+3PmlS8mN0SsqlkpJRNznpmvxEUXXIZ91Syd4e7fzyq4bFKj5Rt4CXzmnIIPTC
         N8Ok2yI5LKe4K4zpB7nARAQAj9q+RkNfH2LrINet5eypaIwvCyPlD8Xy+yUMswS0K1
         Qih+6KGbYfhRyhLxXlFTYGlWqhfUCiqD+db6k++VQVYAD4gryaFrIRKboRH2LOYSIj
         LtHo/O++uKKrYjLPiNWCTEIuTkS74g4HL1rtSr1g9raaZcxZMykEdbhrmMxqZvwfVI
         0EXIaVoF3ZxwA==
Date:   Fri, 11 Jan 2019 09:56:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190111095605.129a93a2@canb.auug.org.au>
In-Reply-To: <20190111093003.2f00829e@canb.auug.org.au>
References: <20190111093003.2f00829e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3O6vCmLnbnn1XwkAV/X4229"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3O6vCmLnbnn1XwkAV/X4229
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 11 Jan 2019 09:30:03 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the imx-mxs tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:

Actually this is only treated as a warning.

> arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge): /soc=
/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI bus
>   also defined at arch/arm/boot/dts/vf610-bk4.dts:130.8-142.3
> arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
>=20
>=20
> Caused by commit
>=20
>   cf91ce9696a0 ("ARM: dts: vf610-bk4: Provide support for reading ID code=
 from MVB device")
--=20
Cheers,
Stephen Rothwell

--Sig_/3O6vCmLnbnn1XwkAV/X4229
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw3zYUACgkQAVBC80lX
0Gx63gf+NdietG6AJEIFDCQcfz2tsug7WsnPbABOb980IYxHZKpC5HU520BDo+qk
FWzDAoBbLHjeB7rROA38yekr+MFW4SRVxq9EHX9HIzN4dafoxpcXqkcydnXxA62r
Xhb12s0PRdrrOMgPknh4gjUaOPv+/o6y83AxhgQgUOOkp5WFl3gGh24hKWq1Ybm+
Q9P93uI766V15pCOUykza+V4Ji0j8zW2kZ5U4qJd6rrH4FsnSXRu6nl9TRjJVof0
0B1rgKHFJJFaiZhIZVOE/IAarv5/mTUdMKuvQ9FBAko5NgPypBPmnz43UY6t6WyK
9LsMsceUDPz1ltjyGobg+sW3lo+y1g==
=7Jz+
-----END PGP SIGNATURE-----

--Sig_/3O6vCmLnbnn1XwkAV/X4229--
