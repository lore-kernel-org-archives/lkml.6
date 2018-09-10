Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6416EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148D020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148D020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeIJVHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:07:09 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:11769 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:07:09 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8AGC3sp042546;
        Tue, 11 Sep 2018 01:12:03 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Tue, 11 Sep 2018 01:12:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.2] (239.166.151.153.ap.dti.ne.jp [153.151.166.239])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8AGC38a042542
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Sep 2018 01:12:03 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add i2s and spdif endpoints of
 rk3328
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180910161011.613-1-katsuhiro@katsuster.net>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <8acd8c0d-0185-e9b4-160b-0d406c0fa7ac@katsuster.net>
Date:   Tue, 11 Sep 2018 01:12:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910161011.613-1-katsuhiro@katsuster.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh, sorry. I got mistake.
This is 'v2' patch.

On 2018年09月11日 01:10, Katsuhiro Suzuki wrote:
> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
> Because to use modern sound card interface such as audio-graph-card.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index d3ef6566325e..fd35dbd37ee2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -179,7 +179,13 @@
>   		clock-names = "i2s_clk", "i2s_hclk";
>   		dmas = <&dmac 11>, <&dmac 12>;
>   		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		i2s0_p0: port {
> +			i2s0_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	i2s1: i2s@ff010000 {
> @@ -190,7 +196,13 @@
>   		clock-names = "i2s_clk", "i2s_hclk";
>   		dmas = <&dmac 14>, <&dmac 15>;
>   		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		i2s1_p0: port {
> +			i2s1_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	i2s2: i2s@ff020000 {
> @@ -201,7 +213,13 @@
>   		clock-names = "i2s_clk", "i2s_hclk";
>   		dmas = <&dmac 0>, <&dmac 1>;
>   		dma-names = "tx", "rx";
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		i2s2_p0: port {
> +			i2s2_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	spdif: spdif@ff030000 {
> @@ -214,7 +232,13 @@
>   		dma-names = "tx";
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&spdifm2_tx>;
> +		#sound-dai-cells = <0>;
>   		status = "disabled";
> +
> +		spdif_p0: port {
> +			spdif_p0_0: endpoint {
> +			};
> +		};
>   	};
>   
>   	pdm: pdm@ff040000 {
> 

