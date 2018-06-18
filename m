Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D6C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5951D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5951D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755003AbeFRQD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:03:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47959 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753570AbeFRQDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:03:24 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fUwcg-0005UR-8P; Mon, 18 Jun 2018 18:03:18 +0200
Message-ID: <1529337797.7211.4.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path
 property
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Emmanuel Vadot <manu@freebsd.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 18 Jun 2018 18:03:17 +0200
In-Reply-To: <20180618154257.16919-1-manu@freebsd.org>
References: <20180618154257.16919-1-manu@freebsd.org>
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

Am Montag, den 18.06.2018, 17:42 +0200 schrieb Emmanuel Vadot:
> The RIoTboard debug uart is connected to serial1.
> Add a chosen property in the DTS so OS knows what serial port to use for
> the console.
> 
> > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm/boot/dts/imx6dl-riotboard.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
> index 2e98c92adff7..315d2ae6fa45 100644
> --- a/arch/arm/boot/dts/imx6dl-riotboard.dts
> +++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
> @@ -19,6 +19,10 @@
> >  		reg = <0x10000000 0x40000000>;
> >  	};
>  
> > +	chosen {
> +		stdout-path = "serial1:115200n8";

If there a reason to deviate from the "stdout-path = &uart1;" notation
used by other i.MX boards?

Regards,
Lucas

> +	};
> +
> >  	regulators {
> >  		compatible = "simple-bus";
> >  		#address-cells = <1>;
