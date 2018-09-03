Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B041C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19002077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbArH3Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19002077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeICJOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 05:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbeICJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 05:14:12 -0400
Received: from dragon (unknown [45.56.155.117])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1442D2077C;
        Mon,  3 Sep 2018 04:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535950545;
        bh=2DFVnTNmaDXnALBC5Qh8IjLeIcXVee8IcyfXgTVQfsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbArH3JvTMjm8iPcHoZRetl1mCR5vdniVPSnKhUVLzJA2zV8Ipj6UYWvAhdXGibEv
         KTGSa5ojO2lU1LU1a3wR7Qne7SILLjXcuWavzhfpu6YI2N84ZFYm171Of6/det5w23
         TE8/LPiCxr54vu45Gn+Sfobvl0k6EqMaSIkG35OY=
Date:   Mon, 3 Sep 2018 12:54:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: imx6: RDU2: Fix the audio CODEC's reset pin
Message-ID: <20180903045426.GM3850@dragon>
References: <20180831191732.25504-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831191732.25504-1-afd@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 02:17:31PM -0500, Andrew F. Davis wrote:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", fix this here.
> 
> Fixes: d763762e3b58 ("ARM: dts: imx6: add ZII RDU2 boards")

This Fixes tag and word 'Fix' in subject is inappropriate to me, as you
are not fixing something wrong from the beginning, but actually
replacing a deprecated property with new one.

Shawn

> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 7fff3717cf7c..a0f5cfda0055 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -384,7 +384,7 @@
>  		AVDD-supply = <&reg_3p3v>;
>  		IOVDD-supply = <&reg_3p3v>;
>  		DVDD-supply = <&vgen4_reg>;
> -		gpio-reset = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	accel@1c {
> @@ -572,7 +572,7 @@
>  		AVDD-supply = <&reg_3p3v>;
>  		IOVDD-supply = <&reg_3p3v>;
>  		DVDD-supply = <&vgen4_reg>;
> -		gpio-reset = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	touchscreen@20 {
> -- 
> 2.18.0
> 
