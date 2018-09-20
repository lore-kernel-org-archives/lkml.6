Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA1FECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2322121547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2322121547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbeIUH1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:27:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbeIUH1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:27:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 88C7727DB8D
Received: by earth.universe (Postfix, from userid 1000)
        id 692943C092F; Fri, 21 Sep 2018 00:13:11 +0200 (CEST)
Date:   Fri, 21 Sep 2018 00:13:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Craig <ctatlor97@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Message-ID: <20180920221311.mrynysyh54si4g7f@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180614151435.6471-1-ctatlor97@gmail.com>
 <20180614151435.6471-3-ctatlor97@gmail.com>
 <20180916121045.aptj6nciwskfg4st@earth.universe>
 <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com>
 <20180920165847.6xqzeoqzqkyotshx@earth.universe>
 <CAMz4kuKj1wtUMLLM8kzKSzotA64vHk466f2G7AxRsdWXZVJL_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6vhc6aw6werrrbl3"
Content-Disposition: inline
In-Reply-To: <CAMz4kuKj1wtUMLLM8kzKSzotA64vHk466f2G7AxRsdWXZVJL_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6vhc6aw6werrrbl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 21, 2018 at 04:08:28AM +0800, Baolin Wang wrote:
> Hi Sebastian,
>=20
> On 21 September 2018 at 00:58, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > [Dropped a couple of people from CC, added Baolin]
> >
> > Hi Craig, Baolin and Rob,
> >
> > On Thu, Sep 20, 2018 at 03:32:29PM +0100, Craig wrote:
> >> On 16 September 2018 13:10:45 BST, Sebastian Reichel <sebastian.reiche=
l@collabora.com> wrote:
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
> > Most importantly I want to see only one generic binding supporting
> > both use cases. As far as I can see there are two major differences:
> >
> > 1. Qcom uses legend properties and SC27XX embedds this into data
> > 2. Qcom supports temperature based mapping
> >
> > The second point is easy: Not having temperature information can
> > be a subset of the data with temperature info. The main thing to
> > discuss are the legend properties. I suppose we have these
> > proposals:
> >
> > Proposal A (from Qcom BMS binding):
> >
> > ocv-capacity-legend =3D /bits/ 8 <100 95 90 85 80 75 70 65 60 55 50 45 =
=2E..>;
> > ocv-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
> > ocv-lut-microvolt =3D <43050000 43050000 43030000 42990000
> >
> > Proposal B (from SC27XX binding):
> >
> > ocv-cap-table =3D <4185 100>, <4113 95>, <4066 90>, <4022 85> ...;
> >
> > I prefer the second binding (with mV -> uV), but I think it becomes
> > messy when temperature is added. What do you think about the
> > following proposal (derived from pinctrl style):
> >
> > Proposal C:
> >
> > ocv-capacity-table-temperatures =3D <(-10) 0 10>;
> > ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ...;
> > ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, ...;
> > ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, ...;
>=20
> For SC27XX, we have no temperatures consideration, but I think
> Proposal C can be compatible with our case.

Yes. I think for SC27XX proposal C could be used like this:

ocv-capacity-table-temperatures =3D <20>; /* room temperature */
ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, ...;

With only one curve defined it would be used for all temperatures.

-- Sebastian

--6vhc6aw6werrrbl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlukG3QACgkQ2O7X88g7
+pqK8A//UHm+2Hn8GO+wWI7y3JLRVXeF+/dLftzWW/DkPLcH5ZLMa5SssXYPMD6a
hGMcYMqgVKSmhtSjXOoazRO7t4KzO4YmqMERGajfFq1lEN/5ZkF/exo0rr4tiqZz
nCCX52eOAPUVkqHKBEVMIb4Zgtg9hrHxavZsD42TkaPm2gatyn5ackJ9DvNtXZ38
p7bdTi17AqD7gODIIg3ChqUimIUZPgZ494UtJkdWZBDnVyETlrFyaqJEoHNbkU9F
zNRPcGuFhKs4rxRgC7QpDc9ieO2o8A+B1HI26muyUvSJ78YDjWDmwshWsOCuAiiw
LOcih1AQNiSVJu+FUn1nP3w/MMzevuh6/Ubbl+VqHH2oln3ptCUsMU3yHvo6Mss9
cAMc0KsP8Jd7+b+Uq0TnCs/QhzUIbS8H1NnAXJVOvDzD6/7whwDlAuzWseptE2HV
8XAwHeL6XnAcukY461GkK5Z3h1jx/QdmnrTLeYuvDBHL629rE7WfOe9wQkVZQ4Zi
WdPV2QVi21DtpTaBQ9ZKxojt9bVtVASt0BZg+OiwuSrRrqpAoizJFMxDsbomJjl5
LbER0SiVJ4QSCnuwz3bkykQBV8jcluuG6eFs9fUFoYs0ALDNAaIHsp1/IlDxaw0K
6NlbOguMaQXQEWP0QUt3yIKpGhUD2XbmnqovMBSJK9nkpTfAC2w=
=RK6h
-----END PGP SIGNATURE-----

--6vhc6aw6werrrbl3--
