Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B3FECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2CF21526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2CF21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbeITPY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:24:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44322 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeITPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:24:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9D484263B3F
Received: by earth.universe (Postfix, from userid 1000)
        id 045CC3C0A85; Thu, 20 Sep 2018 11:42:17 +0200 (CEST)
Date:   Thu, 20 Sep 2018 11:42:17 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] power: reset: qcom-pon: Add pms405 pon support
Message-ID: <20180920094217.n3lcyg6k7oj6gxrs@earth.universe>
References: <20180920015044.15686-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igmfdv2znylmvn3z"
Content-Disposition: inline
In-Reply-To: <20180920015044.15686-1-bjorn.andersson@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igmfdv2znylmvn3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 19, 2018 at 06:50:44PM -0700, Bjorn Andersson wrote:
> From: Vinod Koul <vkoul@kernel.org>
>=20
> Update the binding and driver for pms405 pon.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  Documentation/devicetree/bindings/power/reset/qcom,pon.txt | 5 ++++-
>  drivers/power/reset/qcom-pon.c                             | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt b=
/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> index 651491bb63b7..5705f575862d 100644
> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
> @@ -6,7 +6,10 @@ and resin along with the Android reboot-mode.
>  This DT node has pwrkey and resin as sub nodes.
> =20
>  Required Properties:
> --compatible: "qcom,pm8916-pon"
> +-compatible: Must be one of:
> +	"qcom,pm8916-pon"
> +	"qcom,pms405-pon"
> +
>  -reg: Specifies the physical address of the pon register
> =20
>  Optional subnode:
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-po=
n.c
> index 0c4caaa7e88f..3fa1642d4c54 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -74,6 +74,7 @@ static int pm8916_pon_probe(struct platform_device *pde=
v)
> =20
>  static const struct of_device_id pm8916_pon_id_table[] =3D {
>  	{ .compatible =3D "qcom,pm8916-pon" },
> +	{ .compatible =3D "qcom,pms405-pon" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
> --=20
> 2.18.0
>=20

--igmfdv2znylmvn3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluja3kACgkQ2O7X88g7
+prVcA/6AtI5k9Dui7cZUevF/k1CJSPBxzK6rHi7vtmgDEebU4+7Nkd1fnZkusWu
nDxOf7ZWksi8rFcfV8csXyivcC+ZLotHgJ+w1sUN8uc1s68yFNMM8cPDsTMMVZsZ
SeeXsGtfDxKlHsQtjcAp5bu3NjVWvXp4nDDa4NUNoN0WrIs7fN8a/y9pMR77ZB5X
GpunyWmUbzeFZwWydUg/646WK0cepE0r334qS2SRudv1mOVlHon80EBHP50wg8VA
QfxOkRQxiYH7GXQTEXh2Jthp8rK8yGkavfirjImN5NtCqcUzqDWOv/Ks7PCfH15e
FQF/yIjtPwXXXQDBKvgR7nGr5+O7xZ12vUVCdl+xO85WNx7mFciMFNkrEusw+pAc
DGqVEsfdUxvddFD6nJRn/q8VvayA/QVRWc9/JPsVaeBClFnqAOz0AGEi0QfX5GIl
PJ0yLbW3XMtWuU/CZvGm8kHx+VjG6sTy+/7iLkGmsStpyFM3gL3nhLuUfmS7DtuK
L/5ir/mgjHQL8RgU7rhUogaxVC+PhFyrTvDxd5RDIj/C3mNfsg3NkRfPnw5E/t1C
1bLEenhNkaNocbEPFUr0PVpGoXvju/suTplAxyWmvPvqkL222pOidOztmqh3ukji
lL+Lt+uZRIbH0UaYh0ZgbJiNZf9lzOPk9CNcYNETlku04usmdoY=
=GXhm
-----END PGP SIGNATURE-----

--igmfdv2znylmvn3z--
