Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02DAECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3B20685
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 00:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB3B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbeITG0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:26:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41806 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeITG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:26:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D7645263B12
Received: by earth.universe (Postfix, from userid 1000)
        id 5EDBC3C0A85; Thu, 20 Sep 2018 02:46:12 +0200 (CEST)
Date:   Thu, 20 Sep 2018 02:46:12 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Craig Tatlor <ctatlor97@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge
 unit documentation
Message-ID: <20180920004612.63biirau5qxnbxxo@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <20180916135721.rhu3rn4fsrmmgnbf@earth.universe>
 <CAMz4ku+4pJHivw2FLjtpaBs7yQxgDH-kZ3AgHWWQr5Lb_UcYwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcwdf3hh3w7gnphb"
Content-Disposition: inline
In-Reply-To: <CAMz4ku+4pJHivw2FLjtpaBs7yQxgDH-kZ3AgHWWQr5Lb_UcYwg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xcwdf3hh3w7gnphb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 11:43:30AM +0800, Baolin Wang wrote:
> Hi Sebastian,
>=20
> On 16 September 2018 at 21:57, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > Hi,
> >
> > On Wed, Sep 12, 2018 at 03:29:38PM +0800, Baolin Wang wrote:
> >> This patch adds the binding documentation for Spreadtrum SC27XX series=
 PMICs
> >> fuel gauge unit device, which is used to calculate the battery capacit=
y.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >> ---
> >>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 +++++++++++=
+++++++++
> >>  1 file changed, 55 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2=
7xx-fg.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.=
txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> >> new file mode 100644
> >> index 0000000..7447bae
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> >> @@ -0,0 +1,55 @@
> >> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
> >> +
> >> +Required properties:
> >> +- compatible: Should be one of the following:
> >> +  "sprd,sc2720-fgu",
> >> +  "sprd,sc2721-fgu",
> >> +  "sprd,sc2723-fgu",
> >> +  "sprd,sc2730-fgu",
> >> +  "sprd,sc2731-fgu".
> >> +- reg: The address offset of fuel gauge unit.
> >> +- bat-detect-gpio: GPIO for battery detection.
> >> +- io-channels: Specify the IIO ADC channel to get temperature.
> >> +- io-channel-names: Should be "bat-temp".
> >> +- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
> >
> > This should be a property of the battery.without the sprd, prefix.
>=20
> Right. But I did not find one proper property of the battery, so I
> will add one new standard property of battery

Thanks.

> named 'inner-resistance-microohm' in next version. Is it OK for you?

The proper suffix is -micro-ohms according to
Documentation/devicetree/bindings/property-units.txt

Also the proper English term is internal resistance as far
as I know (and Wikipedia also names it this way), so I
suggest to name the property 'internal-resistance-micro-ohms'.

> >> +- sprd,ocv-cap-table: Provide the battery capacity percent with corre=
sponding
> >> +  open circuit voltage (ocv) of the battery, which is used to look up=
 current
> >> +  battery capacity according to current baterry ocv values.
> >
> > This should also be part of the battery binding. I just reviewed a
> > patchset for the Qualcomm Battery Monitoring System, which needs the
> > same functionality. The Qualcomm binding is more advanced, but
> > should also support this simpler case. Thus I think it makes sense
> > to use its description as base for adding support for this feature
> > to Documentation/devicetree/bindings/power/supply/battery.txt
>=20
> That's great. But could you give me the link of Qualcomm binding,
> which I can change my bindings. Thanks for your comments.

https://patchwork.kernel.org/patch/10464633/

-- Sebastian

--xcwdf3hh3w7gnphb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui7dQACgkQ2O7X88g7
+pqS/g/9FnEPHKRIBRw/MTICOD5x5VMJlGCPl5dqZfRkxQwLlwPCY3LnhrNjTE5e
i2xn34dV8o5jIMiZvrnbobBejknjl2w8wbRoXzFZaOurTT+in3ECEqGtL/7y/H6U
RI75GNgMcST4y+FRH0UCI3+6gg2gDmWKChzoBgLii71BFKTZlVmFzSjInIpr6bjV
xMbfz8eT5xV8iVdy6/GbDpV4+yHIko/MiMznf8GjaSHjhcF66f/HKegOqGauMXCt
yBaSC3nLhryGRLkdo08U1H2XYWJ3cD2P55Crix5Qlk8WR5bK/OGHEaHWsQPKqNgD
L9CBrytcHQP5BjCO/aTudt826n7NiPDAfk1+ACBwKV17yAd2nlWDVhi3X3fzRBts
IsWpytu2eYvT2Qb7A0AmHcoPV+2yIQ/EolNsf0HgA1cg7CKRg5B2jxWhXsV9w2SP
67JI3O/7xLh2gpkcxGkmeYhmJf27y1/kvp1Xtqak3IMCFk7oGq6MykKdErn9wBma
i1n4GNLcAMrgkaTJ1Uk6JFDjipsR0J+Vd2Vwqjau0MLdlefksZP9XdfRIMnBJqR3
nh/q7hI2bIkv8EY2ZpmAL+8Gibe2l9Y/71yuRy1+JQn5ZmXPNAk+m/XrpfW4l0DT
JE8YAs+Gzdp2OEdohymSzgaK5A8gogqchRqh/BOC+vc50c1GRH8=
=aiuD
-----END PGP SIGNATURE-----

--xcwdf3hh3w7gnphb--
