Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD06EC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6879527BC4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6879527BC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933184AbeF2IPV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:15:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51989 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbeF2IPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:15:18 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fYoYf-0006je-I6; Fri, 29 Jun 2018 10:15:09 +0200
Message-ID: <1530260109.22468.60.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6: correct anatop regulators range
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Fri, 29 Jun 2018 10:15:09 +0200
In-Reply-To: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
References: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 29.06.2018, 15:54 +0800 schrieb Anson Huang:
> Correct some i.MX6 SoCs anatop regulators range
> according to reference manual.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

NACK.

This is wrong. While the regulator supports this range, the SoC
doesn't. The current settings are derived from the allowed operating
ranges of the SoC (at least for the MX6QDL), which is in accordance
with how regulator constraints in DT are meant to be used.

Regards,
Lucas

> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
>  arch/arm/boot/dts/imx6sl.dtsi  |  4 ++--
>  arch/arm/boot/dts/imx6sx.dtsi  |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 911141e..d9f98dd 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -689,8 +689,8 @@
> >  				regulator-1p1 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd1p1";
> > -					regulator-min-microvolt = <1000000>;
> > -					regulator-max-microvolt = <1200000>;
> > +					regulator-min-microvolt = <800000>;
> > +					regulator-max-microvolt = <1375000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x110>;
> >  					anatop-vol-bit-shift = <8>;
> @@ -704,8 +704,8 @@
> >  				regulator-3p0 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd3p0";
> > -					regulator-min-microvolt = <2800000>;
> > -					regulator-max-microvolt = <3150000>;
> > +					regulator-min-microvolt = <2625000>;
> > +					regulator-max-microvolt = <3400000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x120>;
> >  					anatop-vol-bit-shift = <8>;
> @@ -719,8 +719,8 @@
> >  				regulator-2p5 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd2p5";
> > -					regulator-min-microvolt = <2250000>;
> > -					regulator-max-microvolt = <2750000>;
> > +					regulator-min-microvolt = <2100000>;
> > +					regulator-max-microvolt = <2875000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x130>;
> >  					anatop-vol-bit-shift = <8>;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 81f48116..3d7931b 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -539,8 +539,8 @@
> >  				regulator-3p0 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd3p0";
> > -					regulator-min-microvolt = <2800000>;
> > -					regulator-max-microvolt = <3150000>;
> > +					regulator-min-microvolt = <2625000>;
> > +					regulator-max-microvolt = <3400000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x120>;
> >  					anatop-vol-bit-shift = <8>;
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 7130ab8..f26f611 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -607,8 +607,8 @@
> >  				regulator-3p0 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd3p0";
> > -					regulator-min-microvolt = <2800000>;
> > -					regulator-max-microvolt = <3150000>;
> > +					regulator-min-microvolt = <2625000>;
> > +					regulator-max-microvolt = <3400000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x120>;
> >  					anatop-vol-bit-shift = <8>;
