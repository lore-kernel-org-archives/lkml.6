Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A55DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE39920864
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE39920864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbeGQHHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:07:35 -0400
Received: from muru.com ([72.249.23.125]:51722 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbeGQHHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:07:35 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7C21880C5;
        Tue, 17 Jul 2018 06:39:44 +0000 (UTC)
Date:   Mon, 16 Jul 2018 23:36:31 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Koen Kooi <koen@dominion.thruhere.net>
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Message-ID: <20180717063631.GZ99251@atomide.com>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-3-git-send-email-koen@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531808688-9716-3-git-send-email-koen@dominion.thruhere.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Koen Kooi <koen@dominion.thruhere.net> [180717 06:28]:
> +&i2c0 {
> +	lps331ap: barometer@5c {
> +		compatible = "st,lps331ap-press";
> +		st,drdy-int-pin = <1>;
> +		reg = <0x5c>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <26 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	mpu6050: accelerometer@68 {
> +		compatible = "invensense,mpu6050";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> +		orientation = <0xff 0 0 0 1 0 0 0 0xff>;
> +	};
> +
> +	usb2512b@2c {
> +		compatible = "microchip,usb2512b";
> +		reg = <0x2c>;
> +		reset-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
> +		/* wifi on port 4 */
> +	};
> +};

Thanks for updating it, should the last one be usb-hub@2c?

Regards,

Tony
