Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99921C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E2921874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546036137;
	bh=1kcgDHXoWwOcoEu59RAjMuWloNe4Hvrfo/HlcHMda7Q=;
	h=To:References:Subject:Cc:From:In-Reply-To:Date:List-ID:From;
	b=mYRqus429DICvPw3wsCK9d5wLoZEEwMT2ZvlLYTZGVPVDFG1suzcf0zGkPeJjg0bS
	 HSe5yi0UTa/9gM3I9WXEeP/V5Zt0iXhCyNCzqlmB/AMVNVXAiwLSyCN5lsh0/Ppteo
	 FSt9B+Hd74cO1+BdT88YsuwepijiMSP6ZGY5IlV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeL1W24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:28:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeL1W24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:28:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15514206C0;
        Fri, 28 Dec 2018 22:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546036135;
        bh=1kcgDHXoWwOcoEu59RAjMuWloNe4Hvrfo/HlcHMda7Q=;
        h=To:References:Subject:Cc:From:In-Reply-To:Date:From;
        b=QZq+/ehyWBGnP/IjA1vgv9Vam7EthRGHfk/tw7xoJBAIc8sGQP5hcMRsBt3cto4Qo
         LCAFa5PuoeDx8eXcIY/XMvTfGeE+bAKHJUeQcAyAeLCKuuqo/rD/Vgc1wMP1IOmZq8
         /8OcZbqf+DMI23wRyHE9VssoxO7kL831zchD8MHs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Message-ID: <154603613437.179992.1170701312259011363@swboyd.mtv.corp.google.com>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org> <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com> <20181218143503.GA32562@centauri.ideon.se> <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names from DT
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, will.deacon@arm.com,
        bjorn.andersson@linaro.org, vkoul@kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
In-Reply-To: <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
Date:   Fri, 28 Dec 2018 14:28:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez (2018-12-26 01:20:07)
> On 12/18/18 15:35, Niklas Cassel wrote:
> > On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
> >> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
> >>> Allow accessing the parent clock names required for the driver
> >>> operation by using the device tree node.
> >>>
> >>> This permits extending the driver to other platforms without having to
> >>> modify its source code.
> >>>
> >>> For backwards compatibility leave previous values as default.
> >>
> >> Why do we need to maintain backwards compatibility? Isn't is required
> >> that the nodes have clocks properties?
> >>
> >=20
> > Hello Stephen,
> >=20
> >=20
> > This is the existing DT nodes for msm8916:
> >=20
> >                 a53pll: clock@b016000 {
> >                          compatible =3D "qcom,msm8916-a53pll";
> >                          reg =3D <0xb016000 0x40>;
> >                          #clock-cells =3D <0>;
> >                  };
> >=20
> >                  apcs: mailbox@b011000 {
> >                          compatible =3D "qcom,msm8916-apcs-kpss-global"=
, "syscon";
> >                          reg =3D <0xb011000 0x1000>;
> >                          #mbox-cells =3D <1>;
> >                          clocks =3D <&a53pll>;
> >                          #clock-cells =3D <0>;
> >                  };
> >=20
> >=20
> > This is the (suggested) DT nodes for qcs404:
> >=20
> >                  apcs_hfpll: clock-controller@0b016000 {
> >                          compatible =3D "qcom,hfpll";
> >                          reg =3D <0x0b016000 0x30>;
> >                          #clock-cells =3D <0>;
> >                          clock-output-names =3D "apcs_hfpll";
> >                          clocks =3D <&xo_board>;
> >                          clock-names =3D "xo";
> >                  };
> >=20
> >                  apcs_glb: mailbox@b011000 {
> >                          compatible =3D "qcom,qcs404-apcs-apps-global",=
 "syscon";
> >                          reg =3D <0x0b011000 0x1000>;
> >                          #mbox-cells =3D <1>;
> >                          clocks =3D <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apc=
s_hfpll>;
> >                          clock-names =3D "aux", "pll";
> >                          #clock-cells =3D <0>;
> >                  };
> >=20
> > qcs404 specifies two clocks, with an accompanied clock-name for each cl=
ock.
> >=20
> > msm8916 specifies a single clock, without an accompanied clock-name.
> >=20
> > It is possible to append clock-names =3D "pll" for the existing clock,
> > as well as to define the aux clock in the apcs node in the msm8916 DT:
> > clocks =3D <&gcc GPLL0_VOTE>;
> > clock-names =3D "aux";
> >=20
> > However, since the DT is treated as an ABI, the existing DT for msm8916=
 must
> > still work, so I don't think that it is possible to ignore having backw=
ards
> > compability in the apcs clock driver.
>=20
>=20
> so where are we with this?
>=20
> do we remove backwards compatibility (see below] for v2 or is the DT=20
> really an ABI and therefore the patch under review is good as is?
>=20

Breaking compatibility is up to the platform maintainers. If anything, I
would make the DTS and driver changes in parallel and then remove the
driver's backwards compatibility logic later on.

