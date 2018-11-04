Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F85C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C363D2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpkL+tgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C363D2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbeKDQxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 11:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728924AbeKDQxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 11:53:51 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AFD52081C;
        Sun,  4 Nov 2018 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541317191;
        bh=MdDZvI2m0lsWOHDH/QNyVnZsnlZycyHxdlk6eUlk3nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpkL+tgzDpJZawCBfEad146abYioJnYJQrrab6bzuET8UPwesQBzQ3j6vZwyswV7t
         89n8dMcScbBR9ir1WrfB8jWEPR/WtL3kK8q2JnV3BnLDndhOyIOJVVhOxOgycMe4zt
         Brzd/SZEPz+5u0fx09/ijdToqICa+37P1g1Xe6Ow=
Date:   Sun, 4 Nov 2018 15:39:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
Message-ID: <20181104073931.GC26016@tiger>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
 <20181023052831.2553-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023052831.2553-2-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 05:30:44AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Add stop-mode property which is required by stop mode wakeup
> feature.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 844caa39364f..3f459d6da7fc 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -448,6 +448,7 @@
>  				clocks = <&clks IMX6SX_CLK_CAN1_IPG>,
>  					 <&clks IMX6SX_CLK_CAN1_SERIAL>;
>  				clock-names = "ipg", "per";
> +				stop-mode = <&gpr 0x10 1 0x10 17>;

Is it supported by upstream?  I cannot find this property in ether flexcan
bindings doc or kernel driver.

Shawn

>  				status = "disabled";
>  			};
>  
> @@ -458,6 +459,7 @@
>  				clocks = <&clks IMX6SX_CLK_CAN2_IPG>,
>  					 <&clks IMX6SX_CLK_CAN2_SERIAL>;
>  				clock-names = "ipg", "per";
> +				stop-mode = <&gpr 0x10 2 0x10 18>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.17.1
> 
