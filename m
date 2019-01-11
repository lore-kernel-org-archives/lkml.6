Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6382177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547175209;
	bh=oZKi2MTg1AqpyqReXhqTQ3F1OFNrCnIawIBlFvdkN4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jINfiibLLzXZtw9FeKmRhnSOuQayvdQBclOrYM76Rr3zz0IAz/li9ObPpyhJ0oF2o
	 9gfx4MDEx4IsqFQOEkcWaCAMYdiXdae8DZtxIMYKDDChB5qlfnjglMF0I0d7xO6khe
	 iEpQrLoiT/Y4LZpcnAawEtK+gY0sS8YDWtbqrays=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfAKCx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:53:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbfAKCx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:53:28 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 285832084C;
        Fri, 11 Jan 2019 02:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547175207;
        bh=oZKi2MTg1AqpyqReXhqTQ3F1OFNrCnIawIBlFvdkN4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fk60+bhCF5DRuQV+8ah61Os3814mAbLRyk8hKUl59mP2tHYOU0DDzotWHRMXYV580
         wnbcsLNjCh6Oxs+1ZHi1Yb+o4vnSJ1wn3B0zbIiidRv6/C4x2pixiWWbuKcdr6vy20
         tBF4tgCC4f/7HnGnL6O82s57JzaGYTsq5ydxDk40=
Date:   Fri, 11 Jan 2019 10:53:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx7ulp: add sim node
Message-ID: <20190111025314.GH25218@dragon>
References: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 08:20:22AM +0000, Anson Huang wrote:
> i.MX7ULP SoC revision info is inside the SIM mode's JTAG_ID
> register, add sim node to support SoC revision check.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7ulp.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index b86daf7..fca6e50 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -347,4 +347,17 @@
>  			gpio-ranges = <&iomuxc1 0 96 32>;
>  		};
>  	};
> +
> +	m4aips1: bus@41080000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x41080000 0x80000>;
> +		ranges;
> +
> +		sim: sim@410a3000 {
> +			compatible = "fsl,imx7ulp-sim", "syscon";

The compatible needs to be documented. Also we generally compose a series
in order below.

 - Bindings patch
 - Kernel patch
 - DTS patch

Shawn

> +			reg = <0x410a3000 0x1000>;
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
