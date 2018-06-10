Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Pxz/Az8bHVvQNwAAmS7hNA
	; Sun, 10 Jun 2018 12:36:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E779D60850; Sun, 10 Jun 2018 12:36:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAN8MLsS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 69001606DD;
	Sun, 10 Jun 2018 12:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69001606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeFJMgM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeFJMgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:36:10 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9C820660;
        Sun, 10 Jun 2018 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528634169;
        bh=+D9usx6NeIFrcIYvlzqjkwC2o6IxtXLfwbc53h1nVts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iAN8MLsSVJQpRhBkOXa7Np6NJh7amZE75WcKbZdLFrBQdfWbKYUaG7D6LIDnc7rC/
         3U39VDrG0VzgXe9FrPUdgnJnpoadi2Rd8oqInK18YDQcIXpMvZI5uTtlj1NwZ8xY2J
         annabQstgVXEAI3frzK1cYL4piSseY5syKQgFqkg=
Date: Sun, 10 Jun 2018 13:36:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 9/9] ARM: dts: at91: sama5d2: Add resistive touch
 device
Message-ID: <20180610133604.71421803@archlinux>
In-Reply-To: <1526975559-18966-10-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-10-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 10:52:39 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add generic resistive touch device which is connected to ADC block
> inside the SAMA5D2 SoC
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
As with the previous patch, the driver side of things is working it's
way through the IIO tree, but will be the next merge window, not the
current one.

Thanks,

Jonathan

> ---
> Changes in v5:
>  - renamed touchscreen-threshold-pressure to touchscreen-min-pressure
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index f06ba99..a44f325 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1442,6 +1442,16 @@
>  				status = "disabled";
>  			};
>  
> +			resistive_touch: resistive-touch {
> +				compatible = "resistive-adc-touch";
> +				io-channels = <&adc AT91_SAMA5D2_ADC_X_CHANNEL>,
> +					      <&adc AT91_SAMA5D2_ADC_Y_CHANNEL>,
> +					      <&adc AT91_SAMA5D2_ADC_P_CHANNEL>;
> +				io-channel-names = "x", "y", "pressure";
> +				touchscreen-min-pressure = <50000>;
> +				status = "disabled";
> +			};
> +
>  			pioA: pinctrl@fc038000 {
>  				compatible = "atmel,sama5d2-pinctrl";
>  				reg = <0xfc038000 0x600>;
