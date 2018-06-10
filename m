Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id osH3BhIaHVtYKgAAmS7hNA
	; Sun, 10 Jun 2018 12:32:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E4B3460850; Sun, 10 Jun 2018 12:32:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zzcseBF3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 63114606DD;
	Sun, 10 Jun 2018 12:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63114606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753717AbeFJMcT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 08:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753407AbeFJMcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 08:32:17 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA742087E;
        Sun, 10 Jun 2018 12:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528633937;
        bh=rkpklQWrnOMt+YsXbpQmQf6uTWTxLRoH1Zb4qZNNohg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zzcseBF3PbwbEqexhDCtr0KE6E5eYUYxrNr0fz5/bN3p4EcG/7WzrglYdG9pmW7x+
         pIVzkIPomiBmipaCB6WbaLKzOf3dRukZGh0U/y04SsWhv5giwBl3QHS3R56xaL7Zh1
         mgXDe2B0qNq6AOpN5irABlsLdMjPeZNfTHJaAr/M=
Date: Sun, 10 Jun 2018 13:32:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <nicolas.ferre@microchip.com>, <dmitry.torokhov@gmail.com>,
        <robh@kernel.org>
Subject: Re: [PATCH v7 4/9] dt-bindings: input: touchscreen:
 resistive-adc-touch: create bindings
Message-ID: <20180610133211.675209de@archlinux>
In-Reply-To: <1526975559-18966-5-git-send-email-eugen.hristev@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com>
        <1526975559-18966-5-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 10:52:34 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Added bindings for generic resistive touchscreen ADC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied, thanks

Jonathan
> ---
> Changes in v5:
>  - changed property name touchscreen-threshold-pressure to
> touchscreen-min-pressure
> 
> Changes in v3:
>  - renamed file and compatible to exclude "generic" keyword
>  - removed the pressure threshold property, added it as a common
> touchscreen property in the touchscreen common bindings in a separate
> commit.
> 
> Changes in v2:
>  - modified bindings to have a generic resistive touchscreen adc driver
> instead of specific architecture one.
> 
>  .../input/touchscreen/resistive-adc-touch.txt      | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
> new file mode 100644
> index 0000000..51456c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch.txt
> @@ -0,0 +1,30 @@
> +Generic resistive touchscreen ADC
> +
> +Required properties:
> +
> + - compatible: must be "resistive-adc-touch"
> +The device must be connected to an ADC device that provides channels for
> +position measurement and optional pressure.
> +Refer to ../iio/iio-bindings.txt for details
> + - iio-channels: must have at least two channels connected to an ADC device.
> +These should correspond to the channels exposed by the ADC device and should
> +have the right index as the ADC device registers them. These channels
> +represent the relative position on the "x" and "y" axes.
> + - iio-channel-names: must have all the channels' names. Mandatory channels
> +are "x" and "y".
> +
> +Optional properties:
> + - iio-channels: The third channel named "pressure" is optional and can be
> +used if the ADC device also measures pressure besides position.
> +If this channel is missing, pressure will be ignored and the touchscreen
> +will only report position.
> + - iio-channel-names: optional channel named "pressure".
> +
> +Example:
> +
> +	resistive_touch: resistive_touch {
> +		compatible = "resistive-adc-touch";
> +		touchscreen-min-pressure = <50000>;
> +		io-channels = <&adc 24>, <&adc 25>, <&adc 26>;
> +		io-channel-names = "x", "y", "pressure";
> +	};
