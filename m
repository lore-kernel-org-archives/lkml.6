Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B827ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC816208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC816208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeGQGrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:47:39 -0400
Received: from muru.com ([72.249.23.125]:51678 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbeGQGri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:47:38 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 02AAC80EE;
        Tue, 17 Jul 2018 06:19:52 +0000 (UTC)
Date:   Mon, 16 Jul 2018 23:16:40 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Koen Kooi <koen@dominion.thruhere.net>
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board
 support
Message-ID: <20180717061640.GX99251@atomide.com>
References: <1531463123-30340-1-git-send-email-koen@dominion.thruhere.net>
 <1531463123-30340-3-git-send-email-koen@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531463123-30340-3-git-send-email-koen@dominion.thruhere.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Koen,

Just noticed there should be generic node names here too, see below.

* Koen Kooi <koen@dominion.thruhere.net> [180713 06:28]:
> The "Beaglebone Enhanced" by Sancloud is based on the Beaglebone Black,
> but with the following differences:
> 
>  * Gigabit capable PHY
>  * Extra USB hub, optional i2c control
>  * lps3331ap barometer connected over i2c
>  * MPU6050 6 axis MEMS accelerometer/gyro connected over i2c
>  * 1GiB DDR3 RAM
>  * RTL8723 Wifi/Bluetooth connected over USB

> +&i2c0 {
> +	lps331ap: lps331ap@5C {
> +		compatible = "st,lps331ap-press";
> +		st,drdy-int-pin = <1>;
> +		reg = <0x5C>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <26 IRQ_TYPE_EDGE_RISING>;
> +	};

lps33lap: barometer@5c

> +	mpu6050: mpu6050@68 {
> +		compatible = "invensense,mpu6050";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> +		orientation = <0xff 0 0 0 1 0 0 0 0xff>;
> +	};

mpu6050: accelerometer@2c

And so on. Please check the lower case hex numbers too as
that's what Linux typically uses.

Thanks,

Tony
