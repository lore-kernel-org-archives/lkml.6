Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453C22184B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U73qZGDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfALGJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 01:09:04 -0500
Received: from ozlabs.org ([203.11.71.1]:40045 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfALGJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 01:09:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43c8SY430Xz9sCr;
        Sat, 12 Jan 2019 17:09:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547273341;
        bh=uk6D+z3hLPk9r/8YxGxkTCEbnNtxul+Z5nEJ9P1cJZ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U73qZGDoB43FaCSECeMvcb+EjZCkGZhMBeE2evsFIDWWk+FVUtvgSenSXEKuHx5b8
         Nlut35d7Dlstpxx0dB+6aThu6h0QODJ0/g7sOvL5Hz6m+7xQjgU8AcRIFY57d2MRFz
         PNfiKvc6eaZrfXBXOS2doLAHPsMeu1PcWKqkJ89XvDkFCuy98w99r5LYtKXhih4xvB
         yKY0MsAJMVJC7+Hnrz8I35dNVXbEphOIrkbKF871H8vWbYDZXvW+yUks6zSEL1+bIW
         3u/kpL3AdqeoYo49xOnVbKjVTMcCU97ksO43cT8fvjsn37hjR532Ofd8TVH5fOxIgV
         n2QsicdWCrQWw==
Date:   Sat, 12 Jan 2019 17:08:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: build failure after merge of the pwm tree
Message-ID: <20190112170859.2cee77d0@canb.auug.org.au>
In-Reply-To: <20190112170117.0d4674fa@canb.auug.org.au>
References: <20190112170117.0d4674fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NCyz0D41LjETSkwD3QrFoy6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NCyz0D41LjETSkwD3QrFoy6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 12 Jan 2019 17:01:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> [Reported by "kernelci.org bot" <bot@kernelci.org>]

[Also reported by Mark Brown <broonie@kernel.org>]

>=20
> After merging the pwm tree, today's linux-next build (arm64-allmodconfig)
> failed like this:
>=20
> In file included from drivers/pwm/pwm-imx27.c:15:
> drivers/pwm/pwm-imx27.c:292:25: error: 'imx_pwm_dt_ids' undeclared here (=
not in a function); did you mean 'pwm_imx27_dt_ids'?
>  MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
>                          ^~~~~~~~~~~~~~
> include/linux/module.h:213:15: note: in definition of macro 'MODULE_DEVIC=
E_TABLE'
>  extern typeof(name) __mod_##type##__##name##_device_table  \
>                ^~~~
> include/linux/module.h:213:21: error: '__mod_of__imx_pwm_dt_ids_device_ta=
ble' aliased to undefined symbol 'imx_pwm_dt_ids'
>  extern typeof(name) __mod_##type##__##name##_device_table  \
>                      ^~~~~~
> drivers/pwm/pwm-imx27.c:292:1: note: in expansion of macro 'MODULE_DEVICE=
_TABLE'
>  MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
>=20
> Caused by commit
>=20
>   5a309d380019 ("pwm: imx: Split into two drivers")

--=20
Cheers,
Stephen Rothwell

--Sig_/NCyz0D41LjETSkwD3QrFoy6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw5hHsACgkQAVBC80lX
0Gyipwf8DJ2WC3pLs3SOkW8TL5svLfIN+6kVEu8F1PPx0ZZQT9PlUCXonfGC3g/n
T6dcY5UU63BbqGWQQzob44nxO3LWakHJ0O6z522aJvU478K0dEW+pSMrfJfM0yjE
XHpM/HbbXr6acjfjckgsVF7lZ9Icl+rM3xUWN128JMfhWN+vZEG5XIKT0kAhR01U
y+Hvzk7B97PTqCYHX1XXqzq48Nd6t5cjyeSdx9hDSmamCMD0Oz0ahJ+0lpOkAxgD
XDQb0NhLaTokrDVE1mjYUtKEcY+NVgqcv1CfNglgrqV/NnabBvSoVTVXA3aX2FQx
WLwINzAmWl20pRqYiBOS99iXYuZF0A==
=VLlf
-----END PGP SIGNATURE-----

--Sig_/NCyz0D41LjETSkwD3QrFoy6--
