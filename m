Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8742EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfAROMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:12:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55255 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfAROMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:12:23 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gkUsY-0002Rx-E9; Fri, 18 Jan 2019 15:12:14 +0100
Message-ID: <1547820733.2626.11.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: imx6q: add pmu interrupt-affinity
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     max.krummenacher@toradex.com, marcel.ziswiler@toradex.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, dev@pschenker.ch,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 18 Jan 2019 15:12:13 +0100
In-Reply-To: <20190118135907.2336-1-stefan@agner.ch>
References: <20190118135907.2336-1-stefan@agner.ch>
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

Am Freitag, den 18.01.2019, 14:59 +0100 schrieb Stefan Agner:
> Explicitly specify interrupt affinity to avoid HW perfevents
> need to guess. This avoids the following error upon boot:
>   hw perfevents: no interrupt-affinity property for /pmu, guessing.
> 
But then it isn't correct either AFAICS. On i.MX6 all the PMU IRQs are
ORed together into a single SPI, instead of each core dealing with its
own PPI. So pretending that there are more IRQs with affinity to each
core isn't the right thing to do, no?

Regards,
Lucas

> Specifying all four CPUs shows no aversive effects on i.MX 6Dual
> SoCs.
> 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/imx6q.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 8381d24eff7d..d2c1977c8b16 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -537,6 +537,13 @@
> >  			<0x28 0x0000000c>; /* DCIC2_MUX_CTL */
>  };
>  
> +&pmu {
> > > +	interrupt-affinity = <&{/cpus/cpu@0}>,
> > > +			     <&{/cpus/cpu@1}>,
> > > +			     <&{/cpus/cpu@2}>,
> > > +			     <&{/cpus/cpu@3}>;
> +};
> +
>  &vpu {
> >  	compatible = "fsl,imx6q-vpu", "cnm,coda960";
>  };
