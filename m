Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91594ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3601820844
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3601820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbeGQG0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:26:42 -0400
Received: from muru.com ([72.249.23.125]:51640 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727293AbeGQG0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:26:42 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EEF6680EE;
        Tue, 17 Jul 2018 05:58:59 +0000 (UTC)
Date:   Mon, 16 Jul 2018 22:55:47 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel.lezcano@linaro.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, aford173@gmail.com,
        drivshin@awxrd.com
Subject: Re: [RFC PATCH 1/4] ARM: dts: am33xx: Add all fck timer clocks
Message-ID: <20180717055547.GV99251@atomide.com>
References: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
 <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531773542-15736-2-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Neil Armstrong <narmstrong@baylibre.com> [180716 20:42]:
> Add the missing fck clock to all timer nodes of the AM33XX dtsi.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 9cd62bc2..e8e665d 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -541,6 +541,8 @@
>  			reg = <0x48042000 0x400>;
>  			interrupts = <69>;
>  			ti,hwmods = "timer3";
> +			clocks = <&timer3_fck>;
> +			clock-names = "fck";
>  		};

These should all use the clkctrl clock nodes, see:

$ git grep CLKCTRL include/dt-bindings/clock/ | grep TIMER

The module clock is bit 0, and on some SoCs bit 24 is the
timer fck. But I don't think these SoS use separate bit 24
clock.

Regards,

Tony
