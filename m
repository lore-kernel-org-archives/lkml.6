Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA207C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60942087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="YJhl/lZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60942087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kde.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeGIMZA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:25:00 -0400
Received: from letterbox.kde.org ([46.43.1.242]:47554 "EHLO letterbox.kde.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932571AbeGIMY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:24:58 -0400
Received: from archbox.localdomain (p5097754f.dip0.t-ipconnect.de [80.151.117.79])
        (Authenticated sender: bshah)
        by letterbox.kde.org (Postfix) with ESMTPSA id B5D222809F5;
        Mon,  9 Jul 2018 13:24:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1531139096; bh=u7c0IYa3mO/lnQsh+phdJbGehjT3l4+l25XSU0bFlsc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=YJhl/lZ4B99/PM0xptE4Y37c6Tarl0raodpbCMKt8YcQ6PvfYKgZNQ7x87f3NbHrJ
         NFwdbsMr9R9v2ZPpbWF9cBiI5ZLHkk5rKkwS7UUhpdG3jHTkPzMpXvPbgZz8i126JE
         skO/89WUc78zt7PrJP8tkN6Cohj23QVe0Y+Isf6Z2h1kNLzJO0tGcKvA6IjpD13uAp
         1ktUVEAUYo4iQuOWw0dkT7fe0U9ZnqHn1TVUromvOMrDG6ZJhB26ELYjigemNsXpHx
         VVciqXvNmfyB0Z5MoTyWwQwSnvXzcN2vEqzUfaLPxIYoca8WfGe7jSa/pauJADlzAs
         VGJnnOp9N1slA==
Date:   Mon, 9 Jul 2018 17:48:50 +0530
From:   Bhushan Shah <bshah@kde.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <masneyb@onstation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-hammerhead: increase load on l20
 for sdhci
Message-ID: <20180709121850.GC1774@orion>
References: <20180709091628.GA8854@orion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20180709091628.GA8854@orion>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 09, 2018 at 02:46:28PM +0530, Bhushan Shah wrote:
> The kernel would not boot on the hammerhead hardware due to the
> following error:
>=20
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmc0: sdhci: Sys addr:  0x00000200 | Version:  0x00003802
> mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000200
> mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> mmc0: sdhci: Present:   0x03e80000 | Host ctl: 0x00000034
> mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
> mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
> mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> mmc0: sdhci: Int enab:  0x02ff900b | Sig enab: 0x02ff100b
> mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
> mmc0: sdhci: Caps:      0x642dc8b2 | Caps_1:   0x00008007
> mmc0: sdhci: Cmd:       0x00000c1b | Max curr: 0x00000000
> mmc0: sdhci: Resp[0]:   0x00000c00 | Resp[1]:  0x00000000
> mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> mmc0: sdhci: Host ctl2: 0x00000008
> mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x70040220
> mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmc0: Card stuck in wrong state! mmcblk0 card_busy_detect status: 0xe00
> mmc0: cache flush error -110
> mmc0: Reset 0x1 never completed.
>=20
> This patch increases the load on l20 to 0.2 amps for the sdhci
> and allows the device to boot normally.
>=20
> Signed-off-by: Bhushan Shah <bshah@kde.org>

Please also add,

Signed-off-by: Brian Masney <masneyb@onstation.org>

which I missed in previous patch.

> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Brian Masney <masneyb@onstation.org>
> ---
>  arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/a=
rch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index 4dc0b347b1ee..c2dc9d09484a 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -189,6 +189,8 @@
>  						regulator-max-microvolt =3D <2950000>;
> =20
>  						regulator-boot-on;
> +						regulator-system-load =3D <200000>;
> +						regulator-allow-set-load;
>  					};
> =20
>  					l21 {
> --=20
> 2.17.1
>=20

--=20
Bhushan Shah
http://blog.bshah.in
IRC Nick : bshah on Freenode
GPG key fingerprint : 0AAC 775B B643 7A8D 9AF7 A3AC FE07 8411 7FBC E11D

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEs8s2ZVJUC+Bu6a2XEZaMRJKMrvwFAltDUoAACgkQEZaMRJKM
rvxGxQf8Du3m/uwcEpcrpY8yWnAspG6QNKqJKX4F2+JJHCcu0tgKQlh8OkAaH8Mf
LSxAxoVpk1uDTn4zAs1NqivaRVLBjJlt7IzFbppJd67YY6b/GC0tsy1eUWzoWPnC
WiBLnytFCCUCWWZgxCNXkopg4HKoLjLJhAZV16kq+SAfCFOMg1RX2QUfWTlVb42V
KebonWPQ3DP6ksrluD5reK6zpaeqoGRLHs+fC9dLgsxJTaJ+7iUQUQ8zcaivqp0O
Kvo17dLJuuOqnKO8VAoH4bLdjf6Vc5g81GNywsWuQ+Xqopd9HAPVx8RaDyzXHeEX
l9yVbxd6wN5hGH9m+Js90aVZXBkySQ==
=JoZ8
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
