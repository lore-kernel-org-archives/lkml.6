Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8456C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572EB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572EB20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeIJSvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:51:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44022 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbeIJSvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:51:51 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fzMh1-0003fc-TK; Mon, 10 Sep 2018 15:57:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add i2s and spdif endpoint of rk3328
Date:   Mon, 10 Sep 2018 15:57:31 +0200
Message-ID: <2729174.Cl53sqNc79@phil>
In-Reply-To: <20180906163956.20667-1-katsuhiro@katsuster.net>
References: <20180906163956.20667-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 6. September 2018, 18:39:56 CEST schrieb Katsuhiro Suzuki:
> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
> Because to use modern sound card interface such as audio-graph-card.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index d3ef6566325e..41f0a20b73ed 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -179,7 +179,13 @@
>  		clock-names = "i2s_clk", "i2s_hclk";
>  		dmas = <&dmac 11>, <&dmac 12>;
>  		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>  		status = "disabled";
> +
> +		i2s0_p0: port@0 {

there is only one port per device, so this should probably be
	i2s0_p0: port {
without the address. Same for all others.
The of-graph framework should work just fine then as well.

Heiko


