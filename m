Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29189C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB017216F6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 08:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB017216F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeHEKSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 06:18:55 -0400
Received: from bues.ch ([80.190.117.144]:33858 "EHLO bues.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeHEKSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 06:18:55 -0400
Received: by bues.ch with esmtpsa (Exim 4.89)
        (envelope-from <m@bues.ch>)
        id 1fmEBx-0008Cq-Kn; Sun, 05 Aug 2018 10:15:09 +0200
Date:   Sun, 5 Aug 2018 10:14:18 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ssb: driver_gige: use true and false for boolean values
Message-ID: <20180805101418.456f6ff7@wiggum>
In-Reply-To: <20180805000453.GA19115@embeddedor.com>
References: <20180805000453.GA19115@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/qyHcmaUW7GZnipGeSTQWz._"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qyHcmaUW7GZnipGeSTQWz._
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 4 Aug 2018 19:04:53 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Return statements in functions returning bool should use true or false
> instead of an integer value.
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/ssb/driver_gige.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/ssb/driver_gige.c b/drivers/ssb/driver_gige.c
> index e973405..ebee6b0 100644
> --- a/drivers/ssb/driver_gige.c
> +++ b/drivers/ssb/driver_gige.c
> @@ -242,7 +242,7 @@ static int ssb_gige_probe(struct ssb_device *sdev,
>  bool pdev_is_ssb_gige_core(struct pci_dev *pdev)
>  {
>  	if (!pdev->resource[0].name)
> -		return 0;
> +		return false;
>  	return (strcmp(pdev->resource[0].name, SSB_GIGE_MEM_RES_NAME) =3D=3D 0);
>  }
>  EXPORT_SYMBOL(pdev_is_ssb_gige_core);

Looks good. Thanks.

Reviewed-by: Michael Buesch <m@bues.ch>


--=20
Michael

--Sig_/qyHcmaUW7GZnipGeSTQWz._
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAltmsdoACgkQ9TK+HZCN
iw52Zg/+IW67CT8Vmim2BJjO257qCYYOVo9GtZdFDzHt4XrXFwJL2h6XvSPMOmq+
bmB9xsNj3G48oJS3+x3v1fxmwSTYjE0ok8fba8VcYFEbgYXYfF68G6JBdYwk0R9m
QB02t97iqV9gpyUM4EN/UgIZNFUIiiKdN5X5maP0s67El6df+zUSy4ZZfwT52uQO
/jbpuPkPaRKe5FAsC8NTRvg0yEo5czokYnfEd2sG+9Q3CLEOIMAln1hjY5DSYilZ
8qrqla0eUmmrcgrhn6B8mVi6Dcv/J7/OJ8Ji9GQJUvFJuOVTfBgLkRnq066IxEEl
2V9TKIO6EI6l/apkagD/GGFE+6Gc7N6tnS5dh47McVvZ8fUJmLXL8C1b+G/hSvPD
BTxIQ49nEWsR97QZBUKAZtz2Uruop9IbmKZpLVrWwkrq19tgG+8ajofUt7UtDiv/
2ON4HH7bzn6E7hJx25S48mm63Q4s3CYM/HrpwjjGiPCdTHbmT54mRLCHVV0qeMqR
08/b3MyZdOL7m+PQ1ZwPcR1cwS1mdh7ku+Xg3LYAbwsJyn4urlNHgoXgXYqZCpB2
5GeNENjQqRplgZN3/NiVtp6lnTTiLDSzbkcaFxWeoWeQwojgJDWaC7vwffkCsfSE
0iN38rao+cEPZR9AJ2bcgV2+XiVpIStZ7WvtgZYajfrpxCH4/64=
=xr6s
-----END PGP SIGNATURE-----

--Sig_/qyHcmaUW7GZnipGeSTQWz._--
