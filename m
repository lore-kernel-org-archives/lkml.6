Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE7C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10490206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544807766;
	bh=ySFlzq5RjV08D0LJcC5AwZ6G1xf3mFqoVIv4qlhNNmM=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=m/V65JYYsSp0x6w+6W9bbw1TicN77RDLbm0xFjfa05ruFnjwZeHsOH+/1GX3PJlwT
	 CuklGI+s8mSSTcaaHjvbAXetyUuAlRyaa9Yrs+ynR7sp3hQUMmAoDXUasAd28wIObg
	 fQWDFX72JV6oQp6G7GKmJk1PISkPEPXOcIxT2EY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbeLNRQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:16:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbeLNRQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:16:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18AF206DD;
        Fri, 14 Dec 2018 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544807763;
        bh=ySFlzq5RjV08D0LJcC5AwZ6G1xf3mFqoVIv4qlhNNmM=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=Ow/ASwOosmXhefebjh04Lye50s8P5Wz0971HNukWKwnrcz9p40voQDBSeFQtcGHHj
         HRwVxmh/XdryZD8DfY+B35UhBVNfbhsp4KVC1PrNkxxoDqA9X1omGE/metCXDEGQlc
         cePgdb85M+aJgtnTYz6PJ5eDBkGQJpa7zpLCqcnI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181214124145.dbtx6z3itwepsuwb@fsr-ub1664-175>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC instead
To:     Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com> <1544707047-4417-2-git-send-email-abel.vesa@nxp.com> <1544711727.3137.32.camel@pengutronix.de> <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175> <20181214011207.GB13243@dragon> <1544779331.3137.36.camel@pengutronix.de> <20181214124145.dbtx6z3itwepsuwb@fsr-ub1664-175>
Message-ID: <154480776200.19322.2879096818180669421@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Date:   Fri, 14 Dec 2018 09:16:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-12-14 04:41:46)
> On 18-12-14 10:22:11, Lucas Stach wrote:
> > Hi Shawn,
> >=20
> > Am Freitag, den 14.12.2018, 09:12 +0800 schrieb Shawn Guo:
> > > On Thu, Dec 13, 2018 at 02:51:50PM +0000, Abel Vesa wrote:
> > > ...
> > > > > > diff --git a/arch/arm64/Kconfig.platforms
> > > > > > b/arch/arm64/Kconfig.platforms
> > > > > > index 7e1545a..318dbb9 100644
> > > > > > --- a/arch/arm64/Kconfig.platforms
> > > > > > +++ b/arch/arm64/Kconfig.platforms
> > > > > > @@ -148,14 +148,6 @@ config ARCH_MXC
> > > > > > > > > > =C2=A0     =C2=A0=C2=A0This enables support for the ARM=
v8 based SoCs in the
> > > > > > > > > > =C2=A0     =C2=A0=C2=A0NXP i.MX family.
> > > > > > =C2=A0
> > > > > > -config SOC_IMX8MQ
> > > > > > > > > > -     bool "i.MX8MQ support"
> > > > > > > > > > -     depends on ARCH_MXC
> > > > > > > > > > -     select ARM64_ERRATUM_843419
> > > > > > > > > > -     select ARM64_ERRATUM_845719
> > > > > > > > > > -     help
> > > > > > > > > > -     =C2=A0=C2=A0This enables support for the i.MX8MQ =
SoC.
> > > > > > -
> > > > >=20
> > > > > NACK on this one. Having a single place where stuff that is absol=
utely
> > > > > critical for proper SoC operation can be selected is very useful =
and
> > > > > avoids hard to debug issues due to slightly wrong configs in the =
long
> > > > > run.
> > > >=20
> > > > As mentioned in the cover letter, please ignore this patch set enti=
rely.
> > > > The ARCH_MXC is actually used on arm32 too, so it won't work.
> > > >=20
> > > > I'm working on a patchset that will add the Kconfig into=C2=A0
> > > > drivers/clk/imx/ and in it will add CLK_IMX8MQ. That will
> > > > fix the clock dependency since the CLK_IMX8MQ will depend on
> > > > ARCH_MXC and ARM64. I believe the CLK_IMX8QXP will follow
> > > > the same pattern.
> > > >=20
> > > > As for the SOC_IMX8MQ, all the other vendors have one single
> > > > config for all the arm64 platforms. TBH, to control every SoC
> > > > independently it's a little bit of an overkill.
> > >=20
> > > Lucas,
> > >=20
> > > We are still waiting for further comments from Olof [1].=C2=A0=C2=A0B=
ut it sounds
> > > like SoC specific option is not welcomed on ARM64.
> >=20
> > While I personally would prefer to keep the SoC options, I see that we
> > need to align with the judgment of the arm-soc maintainers.
> >=20
> > But at the very least we should keep the select for vital system
> > workarounds. They need to move to the arch Kconfig symbol in that case
> > and might select stuff that isn't needed on each of the i.MX8 SoCs. But
> > better enabling more workaround and drivers than necessary than having
> > hard to debug system failures in the future.

CPU erratas are typically implemented with runtime code patching and
they're pretty much all 'default y' so having the SoC config option
select them doesn't do much besides force the errata to always be
enabled. If allowing the user to disable errata handling is a problem,
then perhaps those should only be visible when CONFIG_EXPERT=3Dy.

> >=20
>=20
> I get your point. But that seems to be an issue with the whole arm64 appr=
oach.
> TBH, I believe now would be the perfect time to "get it right" on IMX sin=
ce the 8MQ
> is the first one to get boot-up support upstream. It will be way much har=
der
> to change this later when more arm64 IMX SoCs get upstreamed.
>=20
> I would really love more opinions on this.
>=20
> I have patches on stand-by that remove the SOC_IMX8MQ in all the subsyste=
ms and
> a patch for the defconfig update which I'll keep on holding on to until t=
here
> is a agreement on this.
>=20

I will merge the clk patch now. Hope that helps you feel more confident
that CONFIG_SOC_FOO options aren't welcome.

