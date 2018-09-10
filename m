Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B824C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B406C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJoBP/g9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B406C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeIJIMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeIJIMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:12:06 -0400
Received: from dragon (unknown [45.56.155.51])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EFF20883;
        Mon, 10 Sep 2018 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536540623;
        bh=6DXlDCEX8HwqHnh7itZte1HGJeMT5Ql9q5TaBkxfxfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJoBP/g9CoxQmrHTAfC3Q27ZYiaW609nh2/biT3chQsHu70usOg/XIh8jM6YmqGih
         GVCHSG4nIhdnTdKaoEhMk8d9TN6+dkMAANyyf4gqDzYLXuApy5su3ruJ+51e0axSYv
         +4OBHtX7NM8/2ZNPXvNEB2R7nIFZUi/e+CDJNxEA=
Date:   Mon, 10 Sep 2018 08:48:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6: RDU2: Use new CODEC reset pin name
Message-ID: <20180910004857.GF21218@dragon>
References: <20180904142018.4267-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904142018.4267-1-afd@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:20:17AM -0500, Andrew F. Davis wrote:
> The correct DT property for specifying a GPIO used for reset
> is "reset-gpios", the driver now accepts this name use this here.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
> 
> Changes from v1:
>  - Remove "fix" from commit message
> 
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

Is it intended to change the polarity?

Shawn

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
