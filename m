Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEA8218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfBFWbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:31:01 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39197 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:31:01 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 16F57100005;
        Wed,  6 Feb 2019 22:30:57 +0000 (UTC)
Date:   Wed, 6 Feb 2019 23:30:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ben.dooks@codethink.co.uk,
        ccaione@baylibre.com
Subject: Re: [PATCH v6 1/2] dt-bindings: rtc: add device-tree bindings for
 the Amlogic Meson RTC
Message-ID: <20190206223057.GB4719@piout.net>
References: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
 <20190119144332.11984-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119144332.11984-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/01/2019 15:43:31+0100, Martin Blumenstingl wrote:
> The 32-bit Amlogic Meson SoCs (Meson6, Meson8, Meson8b and Meson8m2)
> have a built-in RTC block.
> It has the following inputs:
> - an 32.768kHz crystal oscillator
> - an interrupt line
> - a reset line
> - 0.9V voltage input
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [resurrected patches from Ben after 2 years]
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/rtc/rtc-meson.txt     | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> new file mode 100644
> index 000000000000..23df3cf2dd73
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
> @@ -0,0 +1,32 @@
> +* Amlogic Meson6, Meson8, Meson8b and Meson8m2 RTC
> +
> +Required properties:
> +- compatible: should be one of the following describing the hardware:
> +	* "amlogic,meson6-rtc"
> +	* "amlogic,meson8-rtc"
> +	* "amlogic,meson8b-rtc"
> +	* "amlogic,meson8m2-rtc"
> +
> +- reg: physical register space for the controller's memory mapped registers.
> +- interrupts: the interrupt line of the RTC block.
> +- clocks: reference to the external 32.768kHz crystal oscillator.
> +- vdd-supply: reference to the power supply of the RTC block.
> +- resets: reset controller reference to allow reset of the controller
> +
> +Optional properties:
> +- #address-cells: should be 1 to address the internal non-volatile memory
> +- #address-cells: should be 1 to reference the internal non-volatile memory

Shouldn't that one be #size-cells ?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
