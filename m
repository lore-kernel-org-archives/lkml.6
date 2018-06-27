Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F55C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A723225EF8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A723225EF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbeF0PQl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:16:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43857 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeF0PQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:16:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AD95720702; Wed, 27 Jun 2018 17:16:37 +0200 (CEST)
Received: from windsurf.home (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4C74C203EC;
        Wed, 27 Jun 2018 17:16:27 +0200 (CEST)
Date:   Wed, 27 Jun 2018 17:16:27 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: pxa: fix the rtc controller
Message-ID: <20180627171627.592849b5@windsurf.home>
In-Reply-To: <20180627150150.23951-2-robert.jarzmik@free.fr>
References: <20180627150150.23951-1-robert.jarzmik@free.fr>
        <20180627150150.23951-2-robert.jarzmik@free.fr>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 27 Jun 2018 17:01:50 +0200, Robert Jarzmik wrote:
> The RTC controller is fed by an external fixed 32kHz clock. Yet the
> driver wants to acquire this clock, even though it doesn't make any use
> of it, ie. doesn't get the rate to make calculation.
> 
> Therefore, use the exported 32.768kHz clock in the PXA clock tree to
> make the driver happy and working.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v1: change the dummy clock by the actual 32.768kHz
> ---
>  arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
>  arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
> index 95d59be97213..78a413ea0e88 100644
> --- a/arch/arm/boot/dts/pxa25x.dtsi
> +++ b/arch/arm/boot/dts/pxa25x.dtsi
> @@ -80,6 +80,10 @@
>  			#pwm-cells = <1>;
>  			clocks = <&clks CLK_PWM1>;
>  		};
> +
> +		rtc@40900000 {
> +			clocks = <&clks CLK_OSC32k768>>;

Double closing bracket, doesn't look good.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
