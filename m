Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A6DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F8521741
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F8521741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964815AbeGBISl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:18:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59927 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbeGBISh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:18:37 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fZu2T-0002iY-66; Mon, 02 Jul 2018 10:18:25 +0200
Message-ID: <1530519505.22468.77.camel@pengutronix.de>
Subject: Re: [PATCH V2] ARM: dts: imx6: correct anatop regulators range
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Mon, 02 Jul 2018 10:18:25 +0200
In-Reply-To: <1530497076-15509-1-git-send-email-Anson.Huang@nxp.com>
References: <1530497076-15509-1-git-send-email-Anson.Huang@nxp.com>
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

Am Montag, den 02.07.2018, 10:04 +0800 schrieb Anson Huang:
> According to i.MX6 datasheet, the LDO_1P1's typical
> programming operating range is 1.0V to 1.2V, and
> the LDO_2P5's typical programming operating range
> is 2.25V to 2.75V, correct LDO_1P1 and LDO_2P5's
> regulator range settings for i.MX6 SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> changes since V1:
> 	Correct the regulator range according to datasheet's statement.
>  arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
>  arch/arm/boot/dts/imx6sx.dtsi | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 81f48116..c64bd90 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -524,8 +524,8 @@
> >  				regulator-1p1 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd1p1";
> > -					regulator-min-microvolt = <800000>;
> > -					regulator-max-microvolt = <1375000>;
> > +					regulator-min-microvolt = <1000000>;
> > +					regulator-max-microvolt = <1200000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x110>;
> >  					anatop-vol-bit-shift = <8>;
> @@ -554,8 +554,8 @@
> >  				regulator-2p5 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd2p5";
> > -					regulator-min-microvolt = <2100000>;
> > -					regulator-max-microvolt = <2850000>;
> > +					regulator-min-microvolt = <2250000>;
> > +					regulator-max-microvolt = <2750000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x130>;
> >  					anatop-vol-bit-shift = <8>;
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 7130ab8..596763c 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -592,8 +592,8 @@
> >  				regulator-1p1 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd1p1";
> > -					regulator-min-microvolt = <800000>;
> > -					regulator-max-microvolt = <1375000>;
> > +					regulator-min-microvolt = <1000000>;
> > +					regulator-max-microvolt = <1200000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x110>;
> >  					anatop-vol-bit-shift = <8>;
> @@ -622,8 +622,8 @@
> >  				regulator-2p5 {
> >  					compatible = "fsl,anatop-regulator";
> >  					regulator-name = "vdd2p5";
> > -					regulator-min-microvolt = <2100000>;
> > -					regulator-max-microvolt = <2875000>;
> > +					regulator-min-microvolt = <2250000>;
> > +					regulator-max-microvolt = <2750000>;
> >  					regulator-always-on;
> >  					anatop-reg-offset = <0x130>;
> >  					anatop-vol-bit-shift = <8>;
