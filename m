Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B73C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB99205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB99205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeKBFhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:37:23 -0400
Received: from leonov.paulk.fr ([185.233.101.22]:46078 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbeKBFhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:37:23 -0400
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 1B456BFDEA;
        Thu,  1 Nov 2018 21:32:50 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 9C2EFC1050; Thu,  1 Nov 2018 21:32:49 +0100 (CET)
Received: from collins (unknown [192.168.1.1])
        by gagarine.paulk.fr (Postfix) with ESMTPSA id 42F77C1012;
        Thu,  1 Nov 2018 21:32:36 +0100 (CET)
Message-ID: <1e9757dd782ffb187efd26582881db019609493c.camel@paulk.fr>
Subject: Re: [PATCH v2 0/7] BL035-RGB-002 3.5" LCD sunxi DRM support
From:   Paul Kocialkowski <contact@paulk.fr>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com
Date:   Thu, 01 Nov 2018 21:33:26 +0100
In-Reply-To: <20181101200045.6078-1-contact@paulk.fr>
References: <20181101200045.6078-1-contact@paulk.fr>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nescmB2mFvrj1/wsvbDg"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nescmB2mFvrj1/wsvbDg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 01 novembre 2018 =C3=A0 21:00 +0100, Paul Kocialkowski a =C3=A9cri=
t :
> The series adds support for the BL035-RGB-002 LCD panel and the required
> device-tree bindings for using it on the BananaPi M1.
>=20
> Only the changes related to the DRM driver and the panel are submitted
> for merge, which does not include the two final commits.
>=20
> Changes since v1:
> * Used the full name of the panel for dt bindings;
> * Removed helper to match flags in order to only retrieve the connector
>   once, as it was already done.
> * Made the bus flags checking possible without a panel;

I forgot to mention that the last patch (not for merge) was untested.

> Paul Kocialkowski (7):
>   drm/sun4i: tcon: Pass encoder instead of using panel for RGB setup
>   drm/sun4i: tcon: Support an active-low DE signal with RGB interface
>   dt-bindings: Add vendor prefix for LeMaker
>   dt-bindings: Add bindings for the LeMaker BL035-RGB-002 LCD panel
>   drm/panel: simple: Add support for the LeMaker BL035-RGB-002 3.5" LCD
>   ARM: dts: sun7i: Add pinmux configuration for LCD0 RGB888 pins
>   ARM: dts: sun7i-a20-bananapi: Add bindings for the LeMaker 3.5" LCD
>=20
>  .../display/panel/lemaker,bl035-rgb-002.txt   |  7 ++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts      | 89 +++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi              | 11 +++
>  drivers/gpu/drm/panel/panel-simple.c          | 27 ++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.c            | 29 +++---
>  drivers/gpu/drm/sun4i/sun4i_tcon.h            |  1 +
>  7 files changed, 151 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lemak=
er,bl035-rgb-002.txt
>=20
--=20
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/

--=-nescmB2mFvrj1/wsvbDg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlvbYxYACgkQhP3B6o/u
lQztqA/9F3LAbSiY2mt2B0sZ9nERrkFSTvDYy604wlkGQioMm+eYgAs86MEeJtMf
ur4zV7X6CmNYcyTsYqwFboC7dTOt6XkeHVDuaX24J9vQjwcciucB9Ig//N38CZFD
Wi8P+WMXJPBr6u7TKd4BTnUN/j0010AEycfRbjfLH8fFlc/mDrsMqAQ36FiG/DqW
VYdGA9ppQZc1Ygijv9EO1JOiIB4j79urxpJrQxDeKMsqKR8FNARy0jySXqk+ykjJ
5iTPoMSciAj4Ad3w13RAm0kiOYfEh4wz71y3GTkAtT8sVtnh+B8Hs4h/YezC+1R9
FANZqYd4tUw3G6z1J8OpPdGlGPs2YqmGbptIvUplBgk2CNa4UkOKwAfDiXLtDju8
OAuOfuaPcSxj2q7N8vPSb3pC+Xncgz+a/couVBUZhwaJOxHBedqmd6QZlqymbUnn
qNIuk8gpzF/+v7m5NK58DmTbOLp9FeqXKf/slEtCKf/XA7DdJu9131+wiSn6/o8r
Swy/eZ/fAaWLBRSv2ox6SW+iVVTXSR1qs0UY18cvM/FN69u98SFvpXavm06foZmw
f9EWsC2rpcY4VXQqVTpjuMowT26Y8dI2bJjZdJtvT6Wm7jIKpgBl9sGZaUCueTnu
2Tupg2l383anF7XVLTbTm+CTJEazBQA3DzmSV2TSjsImUWajfww=
=jHHy
-----END PGP SIGNATURE-----

--=-nescmB2mFvrj1/wsvbDg--

