Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE9EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E9320658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaRG4s52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E9320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH3Cdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeH3Cdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:33:40 -0400
Received: from mail.kernel.org (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC9D20644;
        Wed, 29 Aug 2018 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535582078;
        bh=/ZZWfGwSl+CvBKPvstFBZEL5hy/8u7W5lcx1kO5YgqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kaRG4s52AZktWPssaW7U/NrMGsV08tVwmmlBqqXounUoNqG9M7hFU8YqkI9qJ2rMV
         rKbun3p8wMVgak2//ObQ6VaRouHARlVof/lgXGwarxoc8Fjl3Qj0OTEAAAMni7PbXV
         3p5M40kAd9Sq/YWqDzh3ddIi6qZH5WoAqIkXppDc=
Date:   Thu, 30 Aug 2018 00:34:34 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] power: supply: cros_usbpd: remove unused pointer
 'dev'
Message-ID: <20180829223434.bzxjrmkkbrywhzsc@earth.universe>
References: <20180829145106.9847-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jax4wz6scaqxy76c"
Content-Disposition: inline
In-Reply-To: <20180829145106.9847-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jax4wz6scaqxy76c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 29, 2018 at 03:51:06PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Pointer 'dev' is being assigned but is never used hence it is
> redundant and can be removed.
>=20
> Cleans up clang warning:
> variable 'dev' set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>=20
> V2: change subject to include 'cros_usbpd' and also send to Sameer.
>=20
> ---

Thanks, queued with 'Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>'
Please don't forget to carrier over previously received Rb Tags!

-- Sebastian

>  drivers/power/supply/cros_usbpd-charger.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/su=
pply/cros_usbpd-charger.c
> index 688a16bacfbb..f2b8de502b82 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -378,12 +378,10 @@ static int cros_usbpd_charger_ec_event(struct notif=
ier_block *nb,
>  {
>  	struct cros_ec_device *ec_device;
>  	struct charger_data *charger;
> -	struct device *dev;
>  	u32 host_event;
> =20
>  	charger =3D container_of(nb, struct charger_data, notifier);
>  	ec_device =3D charger->ec_device;
> -	dev =3D charger->dev;
> =20
>  	host_event =3D cros_ec_get_host_event(ec_device);
>  	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
> --=20
> 2.17.1
>=20

--jax4wz6scaqxy76c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluHH3oACgkQ2O7X88g7
+ppU+Q/+PO4BfHE1T9MHy7GVhb5SKruKyYRothvpPsYM8qPbljTRUXqRjD1h90Qq
0k90IgH6/srdHVlgGVUjeWTTWW55AXFeoM90KpjZbjo5DaUVfwKBF48H7fJqQgSC
sPTvNeQQs5Ysct2C8TFiFbYQKBae7/hU1JGj1d+z6f++QmUZsVF+yTKG2yh+CWw9
VenmbF8HBMpHqWa9nx74QSSbLPPK8CONLyxFoKCCpqoKp5lyXj6nnqeFPVEqPsWE
/5BZmYDnXZClxo94Bg+zr/SgbTzAdD03iNhYsZsHm2NwqW3p1pteZlpnl3N/URYJ
zLPbCrl8Ci/DdVpW7fqvn9vrQG+onnnvoJbZGKTMhg29T3EiO5HO05JIUp85SIDU
HxXV59vV4UeL4xhakqWIzEMrjzc3/c7Lrd0LYypi3laARcPJqi/GtoHnR/OkfSpu
7CC94zcaqXjxIxTSII6jganFI4YfvnAqQJ4e1dD1FisrleB7lbXrKIG/sFgzZuU4
hpmPUQpzk9FvEAcKD8ddVpDR+Wps7DU1Yy9IheCwpsOLdxzgNCWqevsEqDp70mAp
Qq0yPziwdyZnxzTYvf9wyYCBvyAxg2QvyBLFxYyHhrHs9PN7n+z3iBhqyhAfgjuB
ZT5WEgUyuFA/vqO5E+VY9Y4irWgYYzx5uh/XUrqXK4F+FkfUYsk=
=Bmj6
-----END PGP SIGNATURE-----

--jax4wz6scaqxy76c--
