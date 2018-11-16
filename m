Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F22C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C1D2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C1D2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fivetechno.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKPTfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:35:36 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:38160 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727422AbeKPTff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:35:35 -0500
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Nov 2018 14:35:32 EST
Received: from [2003:a:659:3f00:21a:4dff:fe85:1148] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1gNZxa-0003Su-35; Fri, 16 Nov 2018 09:58:42 +0100
X-Virus-Scanned: by amavisd-new 2.8.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id wAG8wXmL013968
        (version=TLSv1.2 cipher=AES128-SHA bits=128 verify=NO);
        Fri, 16 Nov 2018 09:58:41 +0100
Subject: Re: [PATCH 0/9] ARM: SAMSUNG: add Exynos chipid driver
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CGME20181115151207epcas1p45adfa96d5b52e10fbb5ace76ebae5e3e@epcas1p4.samsung.com>
 <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Openpgp: preference=signencrypt
Autocrypt: addr=m.reichl@fivetechno.de; prefer-encrypt=mutual; keydata=
 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
 eD/Xv4SsK2JTO4nkQYw8
Organization: five technologies GmbH
Message-ID: <60d56be0-5333-2bff-3576-ff1fcd74d40a@fivetechno.de>
Date:   Fri, 16 Nov 2018 09:58:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l19oF13fUYOUnpd0s3oMYCCIQkdnZmEt0"
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1542360245;79b8ba48;
X-HE-SMSGID: 1gNZxa-0003Su-35
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l19oF13fUYOUnpd0s3oMYCCIQkdnZmEt0
Content-Type: multipart/mixed; boundary="6JzAUwaucyoq4BHtIlbwhJhC2LHTC3NNa";
 protected-headers="v1"
From: Markus Reichl <m.reichl@fivetechno.de>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Pankaj Dubey <pankaj.dubey@samsung.com>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <60d56be0-5333-2bff-3576-ff1fcd74d40a@fivetechno.de>
Subject: Re: [PATCH 0/9] ARM: SAMSUNG: add Exynos chipid driver
References: <CGME20181115151207epcas1p45adfa96d5b52e10fbb5ace76ebae5e3e@epcas1p4.samsung.com>
 <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>

--6JzAUwaucyoq4BHtIlbwhJhC2LHTC3NNa
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,


Am 15.11.18 um 16:11 schrieb Bartlomiej Zolnierkiewicz:
> Hi,
>=20
> This patchset adds Exynos chipid driver and converts Exynos platform
> code to use it. It is heavily based on "[PATCH v9 00/12] Introducing
> Exynos ChipId driver" patchset [1] so most credits go to Pankaj Dubey.
> The main difference in the current patchset is in taking simpler
> approach to converting existing Exynos platform code to use the new
> chipid driver. This results in much less code duplication.
>=20
> The diffstat for "[PATCH v9 00/12] Introducing Exynos ChipId driver":
>=20
>  14 files changed, 587 insertions(+), 255 deletions(-)
>=20
> for the current patchset it is:
>=20
>  14 files changed, 193 insertions(+), 195 deletions(-)
>=20
> This patchset has been tested on Exynos4210 (including rev0),
> Exynos3250, Exynos4412 & Exynos5422 SoCs.
>=20
> [1] https://marc.info/?l=3Dlinux-arm-kernel&m=3D149087972213359&w=3D2
>=20
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20

tested on Odroid-XU4:
[    0.022888] soc soc0: Exynos: CPU[EXYNOS5800] PRO_ID[0xe5422001] REV[0=
x1] Detected

Tested-by: Markus Reichl <m.reichl@fivetechno.de>

Gru=C3=9F,
--=20
Markus Reichl
>=20
> Bartlomiej Zolnierkiewicz (5):
>   ARM: EXYNOS: use chipid driver
>   ARM: EXYNOS: remove soc_is_exynos*() macros
>   ARM: SAMSUNG: remove samsung_rev()
>   ARM: SAMSUNG: remove s5p_init_cpu()
>   ARM: EXYNOS: remove <mach/map.h> include
>=20
> Pankaj Dubey (4):
>   ARM: EXYNOS: remove secondary startup initialization from
>     smp_prepare_cpus
>   soc: samsung: add exynos chipid driver support
>   ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
>   ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
>=20
>  arch/arm/mach-exynos/Kconfig                 |   1 +
>  arch/arm/mach-exynos/common.h                |  81 ++-----------------=

>  arch/arm/mach-exynos/exynos.c                |  75 ++++++++++--------
>  arch/arm/mach-exynos/firmware.c              |   8 +-
>  arch/arm/mach-exynos/include/mach/map.h      |  18 -----
>  arch/arm/mach-exynos/platsmp.c               |  40 ++--------
>  arch/arm/mach-exynos/pm.c                    |  25 +++---
>  arch/arm/plat-samsung/cpu.c                  |  17 ----
>  arch/arm/plat-samsung/include/plat/cpu.h     |   3 -
>  arch/arm/plat-samsung/include/plat/map-s5p.h |   2 -
>  arch/arm64/Kconfig.platforms                 |   1 +
>  drivers/soc/samsung/Kconfig                  |   5 ++
>  drivers/soc/samsung/Makefile                 |   1 +
>  drivers/soc/samsung/exynos-chipid.c          | 111 +++++++++++++++++++=
++++++++
>  14 files changed, 193 insertions(+), 195 deletions(-)
>  delete mode 100644 arch/arm/mach-exynos/include/mach/map.h
>  create mode 100644 drivers/soc/samsung/exynos-chipid.c
>=20


--6JzAUwaucyoq4BHtIlbwhJhC2LHTC3NNa--

--l19oF13fUYOUnpd0s3oMYCCIQkdnZmEt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEVKeIeBh0ZWJOldzLOiXeDmsa/bIFAlvuhrQACgkQOiXeDmsa
/bLsGwv/WpJlAbPX/uARV0BbXmy55U1CDSOjOxZlfF3PedRpq6TwkARYWj5+wlW1
q0t/JRnbrLlzg8zKrNxlJSD3bY0qfXY5f0K890HCTNehekqZdCHi550XauAL0zSG
u0tlw1gVdxEotrpwhwq8SX7TNrXvC71H0iywDve3Np66X7rDbUNLD5x8BU/PGOZY
pm3AIcXpSiWaTYBBrWeaFV04SaZAZ/wYDIqCrOZy/KAc1ESZ1zXaZv70IF39/pmy
ZhA3zwlsOnr1HwgWJO2H53x2NITN9hCR6X401iwBIG9rNmMDenk9LHvki+lxEltz
fNHqlZYqP+2D+d0uFVPvTf+ywZb6EMFy9cgxxvaXmBIB5xNL78XphqSVoccq/0BW
uSblVYtQ8ysyhN0EzqbpsLUf5d+SkS49rQTRNs0N4DcIfQ2ASzeA084TRYm1H4Ef
GFzWcSsZBwt9wnGzOCJn6KKjKtZB0SCU+uHYomUCW4E2Yp8SrrGAxh55ahpHTuIh
upQWXNhu
=/OUC
-----END PGP SIGNATURE-----

--l19oF13fUYOUnpd0s3oMYCCIQkdnZmEt0--
