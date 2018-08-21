Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15D9C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91804208E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91804208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeHUPAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:00:30 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:3334 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeHUPAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:00:30 -0400
Received: from eos (unknown [80.242.164.60])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id CFEEB5FFBA;
        Tue, 21 Aug 2018 13:39:21 +0200 (CEST)
Date:   Tue, 21 Aug 2018 13:39:16 +0200
From:   Alban <albeu@free.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Alban Bedel <albeu@free.fr>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
Message-ID: <20180821133916.3a1c51b1@eos>
In-Reply-To: <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
        <20180810080526.27207-7-brgl@bgdev.pl>
        <20180817182720.6a6e5e8e@bbrezillon>
        <20180819133106.0420df5f@tock>
        <20180819184609.6dcdbb9a@bbrezillon>
        <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
        <20180820202038.5d3dc195@bbrezillon>
        <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/H3emaZsLss0.QG=/IEiqnC1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/H3emaZsLss0.QG=/IEiqnC1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Aug 2018 10:50:07 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> Just curious...Is there a reason why we can't do it like this?:
> Is this because of issue of #address-cells and #size-cells Or mtd=20
> bindings always prefer subnodes?
>=20
> 	mtdnode {
> 		reg =3D <0x0123000 0x40000>;
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		cell@0 {
> 			compatible =3D "nvmem-cell";
> 			reg =3D <0x0 0x14>;
> 		};
>=20
> 		partitions {
> 			compatible =3D "fixed-partitions";
> 			#address-cells =3D <1>;
> 			#size-cells =3D <1>;
>=20
> 			partition@0 {
> 				reg =3D <0x0 0x20000>;
> 				cell@0 {
> 					compatible =3D "nvmem-cell";
> 					reg =3D <0x0 0x10>;
> 				};
> 			};
> 		};
> 	};

That would work, the MTD partitions parser ignore child nodes with a
compatible string when looking for "old style" partitions, see [1].
However we still have the a potential address space clash between the
nvmem cells and the main device binding.

Alban

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/mtd/ofpart.c#L28

--Sig_/H3emaZsLss0.QG=/IEiqnC1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE0W61GceYqNjiMSkodJSaS524LbwFAlt7+eQACgkQdJSaS524
Lbw8Eg/+LksOLDz4/cK1Hv2Osee6M3szNFj3GJYOMAb+35h4qvp3QUEQDLsGQ3Kd
XDdsoRPCc0iuMkN+CWH1mC8/02oufsP1e55OhYcIyMxdCi4PORyCzlkjuWZBBdsU
tw7NP2/zWTaboRVe8nWCRd8gVEDxyfPqlLJXrk+N4ZBuB35LOOOHHH8GbGCay5cp
uZgRZDpS7QgHQbDQU7lHH6yKT6oYx/GTY3BKZU5Q3FoFrQ9vEne9ZO/xJf2JNhjY
5vS8hhhsHbFhfo9CwUOQuisWsdvZEyB0EKtmeF7Wq6NuvFv7VE/hrIjklZY3d1Kx
bNy12FyRvIgX43q9arV8FTNOOGJkyJbiBUm9B4FnBFzmpWqg6QmY4AmIqhuIDZi3
TiOHBp9gARLX+lJNZeqEY46hZoHJp/eWAqHtdlTfVGxAecApwMH/gZw5Ad62N8qB
K0dVL0JVUWR15TfnqOkaPWGsnpRdEf9hvqbPWroND+FKppBH+weVzC/H2aalmQyQ
Td9OVH0wyLI5SoyCptcw/12g5icNhsxmcIGxQfidbsric9lpFJH/D/jm0BPDAoVo
E8rAEARYGaaBG3+FXXRD8pHVJIX0JmqgHAp/9qmnyBYM/F9CaiGt/7oc89fFKO7h
mYUKeBXbMfNEalg1UuyN5mMvDaFFp/uFBmvq/LXKyeJW94RCwJA=
=Ecun
-----END PGP SIGNATURE-----

--Sig_/H3emaZsLss0.QG=/IEiqnC1--
