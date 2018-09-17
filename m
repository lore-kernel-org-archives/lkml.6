Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC1ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95B8214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95B8214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeIQQOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:14:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33506 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbeIQQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:14:17 -0400
Received: from wd0459.dip.tu-dresden.de ([141.76.109.203] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g1r3l-0000bj-Ot; Mon, 17 Sep 2018 12:47:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add i2s and spdif endpoints of rk3328
Date:   Mon, 17 Sep 2018 12:47:17 +0200
Message-ID: <9920488.EWSIgOMfRJ@phil>
In-Reply-To: <20180917085555.21775-1-katsuhiro@katsuster.net>
References: <20180917085555.21775-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 17. September 2018, 10:55:55 CEST schrieb Katsuhiro Suzuki:
> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
> Because to use modern sound card interface such as audio-graph-card.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index d3ef6566325e..fd35dbd37ee2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -179,7 +179,13 @@
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		dmas = <&dmac 11>, <&dmac 12>;
>  		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		i2s0_p0: port {
> +			i2s0_p0_0: endpoint {
> +			};
> +		};

I'm still pondering this. I.e. I'm not sure I really like adding all these
empty nodes only to have them filled in board devicetrees.

This is specific to the audio-graph-card, and neither simple-audio-card
nor the Rockchip-specific cards we have use something like this, so
currently I'm tending to just have all audio-graph-nodes defined in the
board devicetree using it.

For example similar to arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
or zte/zx296718-pcbox.dts do it.

It would be different if the graph-links were actually on the soc-level
like vop<->hdmi or so, but this is completely board-specific.

Same for the others below.

Thoughts?
Heiko


>  	};
>  
>  	i2s1: i2s@ff010000 {
> @@ -190,7 +196,13 @@
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		dmas = <&dmac 14>, <&dmac 15>;
>  		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		i2s1_p0: port {
> +			i2s1_p0_0: endpoint {
> +			};
> +		};
>  	};
>  
>  	i2s2: i2s@ff020000 {
> @@ -201,7 +213,13 @@
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		dmas = <&dmac 0>, <&dmac 1>;
>  		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		i2s2_p0: port {
> +			i2s2_p0_0: endpoint {
> +			};
> +		};
>  	};
>  
>  	spdif: spdif@ff030000 {
> @@ -214,7 +232,13 @@
>  		dma-names = "tx";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&spdifm2_tx>;
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		spdif_p0: port {
> +			spdif_p0_0: endpoint {
> +			};
> +		};
>  	};
>  
>  	pdm: pdm@ff040000 {
> 




