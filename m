Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Sw9BIAMbHVu6NQAAmS7hNA
	; Sun, 10 Jun 2018 12:35:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ECAB4607E7; Sun, 10 Jun 2018 12:35:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wEtb4By7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72BF9606DD;
	Sun, 10 Jun 2018 12:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72BF9606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeFJMfR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753431AbeFJMfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:35:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB9F20660;
        Sun, 10 Jun 2018 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528634115;
        bh=6b/GA4cbvcwQjBaS1KXt+QqEATojFJJ5IOn4tVfyVfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wEtb4By7OH3iYFzi9lIB0skCeYxmDWWoetM4W8IfKjYnoIp/p4ItYdTWdDYtGYyZa
         6ACUZ07uHmdBid7rNx8/febonsy1Mdtj1alcs4KeMuYv6ihD3DeNjfky7/Javu76UZ
         No/1mU00+vARHwNiYTzcDb8OaN6HbAJvaE6PoXyI=
Date: Sun, 10 Jun 2018 13:35:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 8/9] ARM: dts: at91: sama5d2: add channel cells for
 ADC device
Message-ID: <20180610133509.2063cd35@archlinux>
In-Reply-To: <1526975559-18966-9-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-9-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 10:52:38 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Preparing the ADC device to connect channel consumer drivers
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
The driver for the touchscreen is no in the IIO tree, but it wasn't
early enough (due to a block on a fix working it's way in) for this
merge window.  Will be going upstream in the next merge window.

Thanks,

Jonathan

> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 61f68e5..f06ba99 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -47,6 +47,7 @@
>  #include <dt-bindings/dma/at91.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/at91.h>
> +#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
>  
>  / {
>  	model = "Atmel SAMA5D2 family SoC";
> @@ -1437,6 +1438,7 @@
>  				atmel,max-sample-rate-hz = <20000000>;
>  				atmel,startup-time-ms = <4>;
>  				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
> +				#io-channel-cells = <1>;
>  				status = "disabled";
>  			};
>  
