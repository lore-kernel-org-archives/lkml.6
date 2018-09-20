Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F31C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090BE2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090BE2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbeIUH1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:27:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49212 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeIUH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:27:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7FCF4263AB0
Received: by earth.universe (Postfix, from userid 1000)
        id 0A8C53C092C; Thu, 20 Sep 2018 23:42:05 +0200 (CEST)
Date:   Thu, 20 Sep 2018 23:42:05 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Craig <ctatlor97@gmail.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Message-ID: <20180920214204.vse2qz25dbl5vqpr@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com>
 <20180916121045.aptj6nciwskfg4st@earth.universe>
 <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com>
 <20180920165847.6xqzeoqzqkyotshx@earth.universe>
 <5039A15E-E604-4D03-AFEF-4B139EB18A30@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbc3zhnwdmybmfig"
Content-Disposition: inline
In-Reply-To: <5039A15E-E604-4D03-AFEF-4B139EB18A30@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kbc3zhnwdmybmfig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 08:13:52PM +0100, Craig wrote:
> On 20 September 2018 17:58:47 BST, Sebastian Reichel <sebastian.reichel@c=
ollabora.com> wrote:
> >[Dropped a couple of people from CC, added Baolin]
> >
> >Hi Craig, Baolin and Rob,
> >
> >On Thu, Sep 20, 2018 at 03:32:29PM +0100, Craig wrote:
> >> On 16 September 2018 13:10:45 BST, Sebastian Reichel
> ><sebastian.reichel@collabora.com> wrote:
> >> >Sorry for my long delay in reviewing this. I like the binding,
> >> >but the "qcom," specific properties should become common properties
> >> >in
> >> >
> >> >Documentation/devicetree/bindings/power/supply/battery.txt
> >> >and referenced via monitored-battery.
> >
> >> Thanks for the review, what bindings for ocv would you prefer? The
> >> spreadtrum ones or mine?
> >
> >Most importantly I want to see only one generic binding supporting
> >both use cases. As far as I can see there are two major differences:
> >
> >1. Qcom uses legend properties and SC27XX embedds this into data
> >2. Qcom supports temperature based mapping
> >
> >The second point is easy: Not having temperature information can
> >be a subset of the data with temperature info. The main thing to
> >discuss are the legend properties. I suppose we have these
> >proposals:
> >
> >Proposal A (from Qcom BMS binding):
> >
> >ocv-capacity-legend =3D /bits/ 8 <100 95 90 85 80 75 70 65 60 55 50 45
> >...>;
> >ocv-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
> >ocv-lut-microvolt =3D <43050000 43050000 43030000 42990000
> >
> >Proposal B (from SC27XX binding):
> >
> >ocv-cap-table =3D <4185 100>, <4113 95>, <4066 90>, <4022 85> ...;
> >
> >I prefer the second binding (with mV -> uV), but I think it becomes
> >messy when temperature is added. What do you think about the
> >following proposal (derived from pinctrl style):
> >
> >Proposal C:
> >
> >ocv-capacity-table-temperatures =3D <(-10) 0 10>;
> >ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ...;
> >ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, ...;
> >ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, ...;
> >
> >-- Sebastian
>=20
> C looks good to me however I do kinda think it should be
> millivolts as I don't think any hardware reads in microvolts and
> the zeroes make it look quite ugly

I agree, that it looks a bit ugly in the table. Nevertheless I think we
should use microvolts, since that is being used by all other properties.

-- Sebastian

--kbc3zhnwdmybmfig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlukFCkACgkQ2O7X88g7
+poOZRAAp0oYgcoLWxjJSqdpOJQzaWc1QV0GkGyqrcu0Q1zCx7UBvmkfOToFez3o
lXxeefw3hU3JIOsF9jzYJbTAfQM+IAUd01aC0EGsrGfCEzRo6cFMeKdA5EtdjixB
r2iU2F8i4VlqYuzbiitvOHxs9ylw5i71Xk2TeT1c4Lgmie09Wou/wOjy72+uFap2
9Pj7jq0zPIauvUY44U8QRi5T9kkF3a7ZGmrsF48noDrGHQ9qj3Zn3a5X0lAbjuiI
A43xqlQi0eQMJHEdaY6dHVdYkGKSHUFq1l4w4qx2zuNRqr9uWHOJX38jx7wEPDAw
FSUwHQdhNx8kW9XxvxhCkvLuMcSsx1SP7Bdu7Q7p2Wo9ZKAH3J6TZ8i7JRK98UoQ
Lys/0TW85u5RBWmo/gn3A6UJ5XsfB3OODLQ1vWPNqsznQ72QtD0Iu3A3xINKaBTE
B4AXnhbSXk50nAwN2FcdMTW4oFaUURdUTUil+65pX9BgGIIGspxtTAwZYITPzmDs
sj2c9XfaKeaVIl+3xlsrkIyXqujRdAj6kylR7A96gVcR9LaN6Y3BRBkMh75AO7Fi
qxVY2v5WdBlStQIQXD6uR1slTeVYPECPnBJZX1hnMzPec6nwlQ5Jwqtaxa7BJSNe
onevmo07tKefSNCsm/2fGp1fADveF/OI20i5WSkbY5Iawko1bl8=
=nP87
-----END PGP SIGNATURE-----

--kbc3zhnwdmybmfig--
