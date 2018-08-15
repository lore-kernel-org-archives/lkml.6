Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893DB2154C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB1m+4+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 893DB2154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeHOUTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:19:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42097 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:19:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so1523462ljc.9;
        Wed, 15 Aug 2018 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ENRdBRZa8JYP2d0hhKiYI6DZX5Flotm+JoHk7m1WeoY=;
        b=YB1m+4+oyM/CxiTCBZFbQow8iAQeCPMHbwtkQQsreg/qm2xmt+wnSo7kdQ4hBeYtrY
         /zRUHRs0Wbk1RFyhMmLi1H/RZTtkX0N3JFI1CKyuGNNHIxeU6KT+pbuOGzRphe+kMMWG
         CdrPoqXtC+i43kjrbLkvCMZiVFpQdr0xkdSuuqxv9GKndV7DhyQj6KfCE2QPdRf0vANi
         e6KRJTZJQHsMuTiN4ot6Hq4awaRRPphkmTNutMnBStdWTlCv+d+7ctqtOsRPiqklz773
         3043Pw2vsc6LOQL4huPIT2XRTjnu1pTG54nzp5CWe8ZPu1aLiYYod+jTAVLXFBKGB7W5
         FTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ENRdBRZa8JYP2d0hhKiYI6DZX5Flotm+JoHk7m1WeoY=;
        b=dGWjescjOlvP/n6gERAgPbnNmKdZuADBvpt0xgxsr+TiYCsE+OnGRes/0/K26LNnJd
         hdl/p5YH0chDbzdSLmqOzmTEcRZ+LlRuRQqHp9ASER/yPO95t1e+DFFMyqCvtOhQmCvl
         DzyFBiQm1+aet8/XkmGeRZs25CvcQZ4IC1WHB6OxuQHfym7dZk4xwl/IVX8Hr3A8w62x
         ZnXqPPtYqqEP2IRkUfdfJWGc6FhKoq9v4O8QnfNa8P6FyOS/EiTDwCg43ZOK4j6gpIKa
         Mvon+Wgo6Rj3d6O0fcKBHUXPfrEpINNTj2gtvS9I767mzMJM5poiNarXBY9OUK3vmalj
         On+A==
X-Gm-Message-State: AOUpUlEMNOwZEPpeeVM4BhwxfK75I4MpSJIC2wUOKgNnZqZwAFJ70ZnA
        cprGMIAsoS9Otfbd6Axth4wnbcJvgVI=
X-Google-Smtp-Source: AA+uWPzIqZtG9V3fAg4SfWcoXZlqUEjp250S6NlmgiJChWCQNj+O+Udy/J2Wkpl0Yp8FfBMHnEoCig==
X-Received: by 2002:a2e:1d50:: with SMTP id d77-v6mr18586087ljd.104.1534354010899;
        Wed, 15 Aug 2018 10:26:50 -0700 (PDT)
Received: from gmail.com (c-2ec2e3af-74736162.cust.telenor.se. [46.194.227.175])
        by smtp.gmail.com with ESMTPSA id o3-v6sm4602238lfc.95.2018.08.15.10.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 10:26:49 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:27:00 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20180815172700.GA29039@gmail.com>
References: <20180815163852.GA4910@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20180815163852.GA4910@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 15, 2018 at 11:38:52AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>=20
> Addresses-Coverity-ID: 1462408 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel=
/cros_ec_accel_legacy.c
> index 063e89e..d609654 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platfor=
m_device *pdev)
>  		switch (i) {
>  		case X:
>  			ec_accel_channels[X].scan_index =3D Y;
> +			/* fall through */
>  		case Y:
>  			ec_accel_channels[Y].scan_index =3D X;
> +			/* fall through */
>  		case Z:
>  			ec_accel_channels[Z].scan_index =3D Z;
>  		}

Hum, I'm not sure we are supposed to fall through here, even if it does
not hurt to do so.
I even think we can remove the switch and put that outside the for-loop,
e.g:

	ec_accel_channels[X].scan_index =3D Y;
	ec_accel_channels[Y].scan_index =3D X;
	ec_accel_channels[Z].scan_index =3D Z;

	for (i =3D X ; i < MAX_AXIS; i++) {
		if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID && i !=3D Y)
			state->sign[i] =3D -1;
		else
			state->sign[i] =3D 1;
	}


Best regards,
Marcus Folkesson


> --=20
> 2.7.4
>=20

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlt0YmAACgkQiIBOb1ld
UjLeDw/+I5HcY7PZ8db/lQ3/nhoeswqUMgvdFBiatI0hczVsWU6XBDRRcKnXSF8v
ZAQd7otLNWIKQZWqPEIyeQmv2Nzf4Qm1vxlssrylTDOSQd/cx84XenrKqOyYk8WI
GpABy6WsNBVqnPPWdhpfdu0P9D/Tum3QCzsvNSJCNhZ5xl2bhoCCGxqUvz5s/9ZF
Um+FoXCJBS6j5/2u9127IAa7ftB2y5OIcfok9pancrfLJ8dqRCMTh+hDg2kaWYy3
BN0Fg7yYadX0OOa5AZBeA0I4FcfIrCa42yI22jiYPGMOUhzlz2G1IVcjDyDwxfXr
O9vgf2G7Gwm6Ht1dECvvYrRUPr1Mfx7KPaDket5HoFsOozZnN+YKFSk9z7yfxSfq
VeLNXB1AA+tjsDmv3C/0PCNYWloghwTFwUSKEIYF26y9Ac4r1EYeC3ddbQGGdxzd
qAdG3Paw53vUh2wL7CBkKrG3bHL1UHjvHF3mWsAMWgOY9J85VMaO8tmQ1bFiXD+j
Zf7vWQ3OnkuY3GyrZgVGd8iGD5ZTMIBfEPw//keZ98ssqhVihU0C1qCPt7lZfbQg
QmBm+kNnDwixI76imjSo/O1wMUliEwwFJDnc4I1HvZsr183ZgCdlQiTV7IM8sMAT
v5n7fxl6ybxl0qix4dmlCBvvXzpyw2H3MPjZwdf5BYPLqXFM+F4=
=NCRc
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
