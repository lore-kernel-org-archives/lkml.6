Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA04AC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEB0208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEB0208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbeFNHyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:54:32 -0400
Received: from gloria.sntech.de ([95.129.55.99]:51500 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752813AbeFNHya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:54:30 -0400
Received: from ip5f5a8448.dynamic.kabel-deutschland.de ([95.90.132.72] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.1:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <heiko@sntech.de>)
        id 1fTN5G-0003CL-5k; Thu, 14 Jun 2018 09:54:18 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     David Wu <david.wu@rock-chips.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        huangtao@rock-chips.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: stmmac: dwmac-rk: Add GMAC support for PX30
Date:   Thu, 14 Jun 2018 09:54:17 +0200
Message-ID: <1961033.25ax7s0Z5i@diego>
In-Reply-To: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
References: <1528956927-32440-1-git-send-email-david.wu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Am Donnerstag, 14. Juni 2018, 08:15:27 CEST schrieb David Wu:
> Add constants and callback functions for the dwmac on PX30 Soc.
> The base structure is the same, but registers and the bits in
> them are moved slightly, and add the clk_mac_speed for selecting
> mac speed.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>

[...]

> @@ -1042,6 +1101,10 @@ static int rk_gmac_clk_init(struct
> plat_stmmacenet_data *plat) }
>  	}
> 
> +	bsp_priv->clk_mac_speed = devm_clk_get(dev, "clk_mac_speed");
> +	if (IS_ERR(bsp_priv->clk_mac_speed))
> +		dev_err(dev, "cannot get clock %s\n", "clk_mac_speed");
> +

I don't see that new clock documented in the dt-binding.
Also, which clock from the clock-controller does this connect to?


Thanks
Heiko



