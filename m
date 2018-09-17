Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15177ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42D1214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42D1214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeIQQjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:39:36 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:16453 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeIQQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:39:36 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8HBCJDQ051547;
        Mon, 17 Sep 2018 20:12:19 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Mon, 17 Sep 2018 20:12:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.2] (239.166.151.153.ap.dti.ne.jp [153.151.166.239])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8HBCIx6051541
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 17 Sep 2018 20:12:18 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2] arm64: dts: rockchip: add i2s and spdif endpoints of
 rk3328
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180917085555.21775-1-katsuhiro@katsuster.net>
 <9920488.EWSIgOMfRJ@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <71ab1337-3681-ecdc-4eb8-57ad5656db27@katsuster.net>
Date:   Mon, 17 Sep 2018 20:12:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9920488.EWSIgOMfRJ@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 2018年09月17日 19:47, Heiko Stuebner wrote:
> Hi,
> 
> Am Montag, 17. September 2018, 10:55:55 CEST schrieb Katsuhiro Suzuki:
>> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
>> Because to use modern sound card interface such as audio-graph-card.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index d3ef6566325e..fd35dbd37ee2 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -179,7 +179,13 @@
>>   		clock-names = "i2s_clk", "i2s_hclk";
>>   		dmas = <&dmac 11>, <&dmac 12>;
>>   		dma-names = "tx", "rx";
>> +		#sound-dai-cells = <0>;
>>   		status = "disabled";
>> +
>> +		i2s0_p0: port {
>> +			i2s0_p0_0: endpoint {
>> +			};
>> +		};
> 
> I'm still pondering this. I.e. I'm not sure I really like adding all these
> empty nodes only to have them filled in board devicetrees.
> 
> This is specific to the audio-graph-card, and neither simple-audio-card
> nor the Rockchip-specific cards we have use something like this, so
> currently I'm tending to just have all audio-graph-nodes defined in the
> board devicetree using it.
> 
> For example similar to arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> or zte/zx296718-pcbox.dts do it.
> 
> It would be different if the graph-links were actually on the soc-level
> like vop<->hdmi or so, but this is completely board-specific.
> 
> Same for the others below.
> 
> Thoughts?
> Heiko

Hmm, OK. These nodes will move into the device tree of ROCK64.
Thank you for your advise!

Regards,
--
Katsuhiro Suzuki


> 
> 
>>   	};
>>   
>>   	i2s1: i2s@ff010000 {
>> @@ -190,7 +196,13 @@
>>   		clock-names = "i2s_clk", "i2s_hclk";
>>   		dmas = <&dmac 14>, <&dmac 15>;
>>   		dma-names = "tx", "rx";
>> +		#sound-dai-cells = <0>;
>>   		status = "disabled";
>> +
>> +		i2s1_p0: port {
>> +			i2s1_p0_0: endpoint {
>> +			};
>> +		};
>>   	};
>>   
>>   	i2s2: i2s@ff020000 {
>> @@ -201,7 +213,13 @@
>>   		clock-names = "i2s_clk", "i2s_hclk";
>>   		dmas = <&dmac 0>, <&dmac 1>;
>>   		dma-names = "tx", "rx";
>> +		#sound-dai-cells = <0>;
>>   		status = "disabled";
>> +
>> +		i2s2_p0: port {
>> +			i2s2_p0_0: endpoint {
>> +			};
>> +		};
>>   	};
>>   
>>   	spdif: spdif@ff030000 {
>> @@ -214,7 +232,13 @@
>>   		dma-names = "tx";
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&spdifm2_tx>;
>> +		#sound-dai-cells = <0>;
>>   		status = "disabled";
>> +
>> +		spdif_p0: port {
>> +			spdif_p0_0: endpoint {
>> +			};
>> +		};
>>   	};
>>   
>>   	pdm: pdm@ff040000 {
>>
> 
> 
> 
> 
> 

