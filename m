Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03FB214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03FB214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbeHBNHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:07:10 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41270 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbeHBNHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:07:09 -0400
Received: from wd0970.dip.tu-dresden.de ([141.76.111.202] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1flBad-0001Rf-Je; Thu, 02 Aug 2018 13:16:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     broonie@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 3/5] dt-bindings: mfd: rk808: Add binding informations for RK809 and RK817.
Date:   Thu, 02 Aug 2018 13:16:18 +0200
Message-ID: <2820701.ErqR8ge6r7@phil>
In-Reply-To: <1533023850-29004-4-git-send-email-tony.xie@rock-chips.com>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com> <1533023850-29004-4-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Am Dienstag, 31. Juli 2018, 09:57:28 CEST schrieb Tony Xie:
> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>

I don't see the devicetree binding maintainers listed in the recipient
list, so adding them in the next iteration might increase your chances
to get an Ack on the binding.

scripts/get_maintainer.pl -f Documentation/devicetree/bindings lists

Rob Herring <robh+dt@kernel.org>
Mark Rutland <mark.rutland@arm.com>

as the main dt maintainers.

[...]

> @@ -99,6 +147,13 @@ number as described in RK818 datasheet.
>  	- HDMI_SWITCH
>  	- OTG_SWITCH
>  
> +There are three pins needed to config, named "gpio_ts" "gpio_gt" "gpio_slp".
> +	The gpio_gt and gpio_ts pins support the gpio function.
> +	The gpio_slp pin is for controlling the pmic states, as below:
> +		- reset
> +		- power down
> +		- sleep
> +

Is this common for all rk8xx pmics or just the two new ones?
As the paragraph above makes it sound like these are present on all
and I didn't find mention of them in the datasheets for previous pmics
I have.

Also to me it is not clear in what way these should be used and I didn't
find any mention of them at all in the rest of your series.


Heiko


