Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6EDC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6E208A1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE6E208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbeG0L5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:57:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33049 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbeG0L5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:57:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4272A20876; Fri, 27 Jul 2018 12:36:31 +0200 (CEST)
Received: from localhost (unknown [88.128.81.178])
        by mail.bootlin.com (Postfix) with ESMTPSA id 04AF820618;
        Fri, 27 Jul 2018 12:36:20 +0200 (CEST)
Date:   Fri, 27 Jul 2018 12:36:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 1/2] MIPS: mscc: ocelot: add interrupt controller
 properties to GPIO controller
Message-ID: <20180727103621.GA7701@piout.net>
References: <20180725122621.31713-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725122621.31713-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2018 14:26:20+0200, Quentin Schulz wrote:
> The GPIO controller also serves as an interrupt controller for events
> on the GPIO it handles.
> 
> An interrupt occurs whenever a GPIO line has changed.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index d7f0e3551500..afe8fc9011ea 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -168,6 +168,9 @@
>  			gpio-controller;
>  			#gpio-cells = <2>;
>  			gpio-ranges = <&gpio 0 0 22>;
> +			interrupt-controller;
> +			interrupts = <13>;
> +			#interrupt-cells = <2>;
>  
>  			uart_pins: uart-pins {
>  				pins = "GPIO_6", "GPIO_7";
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
