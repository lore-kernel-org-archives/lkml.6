Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6199AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372B820866
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeLTMe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:34:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60650 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730639AbeLTMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:34:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B3F68207D9; Thu, 20 Dec 2018 13:34:22 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 80C19207B8;
        Thu, 20 Dec 2018 13:34:12 +0100 (CET)
Date:   Thu, 20 Dec 2018 13:34:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio
 signal polarity
Message-ID: <20181220123412.GG2188@piout.net>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
 <1545308005-51559-4-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545308005-51559-4-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 12:13:56+0000, Vokáč Michal wrote:
> The reset signal of the SSD1306 OLED display is actually active-low.
> Adapt the DT to reflect the real world.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Changes from v1:
>  - Add R-by from Rob
> 
>  arch/arm/boot/dts/imx28-cfa10036.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
> index 8337ca2..d6eca31 100644
> --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> @@ -11,6 +11,7 @@
>  
>  /dts-v1/;
>  #include "imx28.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "Crystalfontz CFA-10036 Board";
> @@ -95,7 +96,7 @@
>  					pinctrl-names = "default";
>  					pinctrl-0 = <&ssd1306_cfa10036>;
>  					reg = <0x3c>;
> -					reset-gpios = <&gpio2 7 0>;
> +					reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
>  					solomon,height = <32>;
>  					solomon,width = <128>;
>  					solomon,page-offset = <0>;
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
