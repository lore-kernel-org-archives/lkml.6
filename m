Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDDBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B8220685
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B8220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbeITGRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:17:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41698 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeITGRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:17:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 05C6B26B9CE
Received: by earth.universe (Postfix, from userid 1000)
        id 74DEA3C0A85; Thu, 20 Sep 2018 02:36:30 +0200 (CEST)
Date:   Thu, 20 Sep 2018 02:36:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC27XX fuel gauge unit
 driver
Message-ID: <20180920003630.ygvjnuutmd5n2vre@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <1295864a38810a6db6c97e298c6663ae2b1350c1.1536736399.git.baolin.wang@linaro.org>
 <20180916143552.3oxjqpo6vravh5cy@earth.universe>
 <CAMz4kuJcA-Oo1vTtW=gf_oFmZ3TmgNxYPxO5wuWpy0Kcg2LFDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x26i7pb5xajtvdfn"
Content-Disposition: inline
In-Reply-To: <CAMz4kuJcA-Oo1vTtW=gf_oFmZ3TmgNxYPxO5wuWpy0Kcg2LFDw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x26i7pb5xajtvdfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 12:01:51PM +0800, Baolin Wang wrote:
[...]
> >> +static int sc27xx_fgu_parse_dt(struct sc27xx_fgu_data *data,
> >> +                            struct device_node *np)
> >> +{
> >> +     const __be32 *list;
> >> +     int i, len, size, ret;
> >> +
> >> +     ret =3D of_property_read_u32(np, "reg", &data->base);
> >> +     if (ret) {
> >> +             dev_err(data->dev, "failed to get fgu address\n");
> >> +             return ret;
> >> +     }
> >> +
> >> +     data->gpiod =3D devm_gpiod_get_optional(data->dev, "bat-detect",=
 GPIOD_IN);
> >> +     if (IS_ERR(data->gpiod)) {
> >> +             dev_err(data->dev, "failed to get battery detection GPIO=
\n");
> >> +             return PTR_ERR(data->gpiod);
> >> +     }
> >
> > According to the binding (and the remaining code!) this gpio is not
> > optional.
>=20
> Yes, they are not optional. If we can not get the detection GPIO, we
> will return errors. So am I missing something else?
>=20
> Thanks for your comments.

devm_gpiod_get_optional =3D> devm_gpiod_get

The _optional variant will return NULL if the GPIO is not specified in DT.
The variant without _optional will return an error instead.

-- Sebastian

--x26i7pb5xajtvdfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui64oACgkQ2O7X88g7
+pp72w/+PBMhziS4xo8Gk9wXxqq8FX5e54kd0AfV1i2CCeS5IG4vq6IoynmZ4EQv
MVS3HdeX9LMZLoR1J2Me4U4yyyF77sLg3CBwiqdskj6nbukvlWFeyAutQcZ/eDod
I9mNwK1oa0RvuItT6vfaAP9XZvnhqh3tze+TvPctpSG/bIXnmbY9Cla+MFnk6A2D
logiPxnBWJoRQGZGZwwgD+iRZ1fM3k7WxoL+Qg4TE2ij0k82rjxS2zYNp75J8eFd
0tlOgnAVTJRtmbZimaJComDBAbMxelD52/Pip/QCXIPfgxAh9zymnUMPGMZVEwNx
rqKfusukexOq8VUOMadZvhaoUAVHhzuRGnmV+qdjZ+eldhHir2XXv+q6av+pscl4
HBUKIfgbXDPX31Dbneo/AUfrhTbJzo6Hsaljy5HUsYLs1c2osm81ummcaivapfwE
cy79x1afz5mMEhQV0MgJXECLzL0MGGIUxlY2jxUYKp/n36NAWhkksCM3y70O9ZyQ
dmOp8QAm90j72byIjzsZxfHhfsnmwbYMdBCWP2l2nlBaVN+TQZMpYiRzQif/HQwq
DXk+r07RUwvilJSA3KZH/7ZgV8r4NE2jaqzW2Uh+GFuLgsimS0u3HBi6WkoJENhe
tf3cbDoADfGJ3QK+qj9OXLSQmEPmE9Xg0mV7vytj4tD6+bMZKdg=
=Ikka
-----END PGP SIGNATURE-----

--x26i7pb5xajtvdfn--
