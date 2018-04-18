Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753001AbeDRHAD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:00:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36533 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752811AbeDRG7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 02:59:50 -0400
X-Google-Smtp-Source: AIpwx4/OIFcSm6J7QLlJm7NoNTSdleejrFrLpZHuFOM61KYRVbVirK7Sj8sPlu/kOj8K2TszQLktNw==
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        absahu@codeaurora.org, marc.zyngier@arm.com, richardcochran@gmail.com
Subject: Re: [v5,05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
Date: Wed, 18 Apr 2018 08:59:46 +0200
Message-ID: <2641190.FRMBLJWkCS@bentobox>
User-Agent: KMail/5.2.3 (Linux/4.14.0-0.bpo.3-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
References: <1521800336-19266-6-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3043434.9TQ9TfbtKO"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3043434.9TQ9TfbtKO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 23. M=E4rz 2018 15:48:48 CEST Sricharan R wrote:
> Add the common parts for the dk04 boards.
>=20
> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi | 115 ++++++++++++++++++++=
++++++
>  arch/arm/boot/dts/qcom-ipq4019.dtsi           |   2 +-
>  2 files changed, 116 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi

The no-map reserved-memory for tz and smem are missing. Linux doesn't have=
=20
control over these regions and they are placed in the middle of the ram bef=
ore=20
Linux even starts. And u-boot is also not adding these ranges automatically.

    	reserved-memory {
    		#address-cells =3D <0x1>;
    		#size-cells =3D <0x1>;
    		ranges;
   =20
    		smem@87e00000 {
    			reg =3D <0x87e00000 0x080000>;
    			no-map;
    		};
   =20
    		tz@87e80000 {
    			reg =3D <0x87e80000 0x180000>;
    			no-map;
    		};
    	};

This can either (depending on HW/SW configuration) lead to a failed boot [1=
]=20
or to runtime crashes like:

    root@OpenWrt:/# /tmp/memory-allocator-test
    main 0
    [  571.758058] Unhandled fault: imprecise external abort (0xc06) at 0x0=
1715ff8
    [  571.758099] pgd =3D cebec000
    [  571.763826] [01715ff8] *pgd=3D8e7fa835, *pte=3D87e7f75f, *ppte=3D87e=
7fc7f
    Bus error

I would not know how to disable QSEE on these boards and thus would assume=
=20
that it should be part of this dtsi.

Kind regards,
	Sven

[1] https://www.spinics.net/lists/linux-arm-msm/msg21536.html

--nextPart3043434.9TQ9TfbtKO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrW7OIACgkQXYcKB8Em
e0aC/A//SFl29P4JrehoVB558QcgRW5yqR1YFSEsPH3w2UxV4Dptj2OSI/jbqNC+
p13mYZhBXEq0tyPQV7jR3VW6Lj8Z68LOIDxTXMp+Qc9kuSNWpWFT7uW6Mw8no0kp
NIxvMr+oY2wlhZD1Sxaba6n2O9rVF6w58nQIloi96bRSlrS3Ig2Qz4XRU5cGYZsk
xhLjSLogSJMvgqsvB7OaxML8ao41CLxxnYssadU6THltzH6GMjJyja9bQSVJVINk
zqjjf1nWevwPiFz75/BKXvzb7sUIjRoEKMJ8hlf9bvkKo0ccSQCcxSrIIqtSZp0O
rWcJtVYrjK/WURy3i/yV6hMH6cHiW0lJgI87uHM7CLfJuiteui1ks7RcPAbZIWeO
yTcjARIYvBbWFiZXSpgYvXzHrlSbH5JGIbnN9ZDPG2tqsxDqEbNBoPlE+yXqluva
mCOxD4SuQ/tECsCHe4hSzoWW5XOoyVsXBBliZSHbgxpDvcJLx/Nb5wdmE7FKp2WB
SQvxdLPGHnngOLk2sKekISazh1FP9RBO8KgOIbcoyt7BreOGw1CVOEsW8PP47c9d
WcGZktS/JVxIbrSIAdHSrFSeDxW80V4RfrFABz27wPt4zZzOo0EPfJBcKS5loVIJ
Gq1MYhhhlqTXmi4N7swpDl3+fNG5TgCw9jkPjxRwbv1+RV3zGAM=
=kUPf
-----END PGP SIGNATURE-----

--nextPart3043434.9TQ9TfbtKO--
