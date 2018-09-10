Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6CBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5E320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeIJVCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:02:41 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:12432 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbeIJVCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:02:41 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8AG7Iqo041831;
        Tue, 11 Sep 2018 01:07:18 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Tue, 11 Sep 2018 01:07:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.2] (239.166.151.153.ap.dti.ne.jp [153.151.166.239])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8AG7Iaq041828
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Sep 2018 01:07:18 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add i2s and spdif endpoint of
 rk3328
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180906163956.20667-1-katsuhiro@katsuster.net>
 <2729174.Cl53sqNc79@phil>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <ba47e7c5-184c-caf7-2892-3610639d36eb@katsuster.net>
Date:   Tue, 11 Sep 2018 01:07:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2729174.Cl53sqNc79@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 2018年09月10日 22:57, Heiko Stuebner wrote:
> Hi,
> 
> Am Donnerstag, 6. September 2018, 18:39:56 CEST schrieb Katsuhiro Suzuki:
>> This patch adds port and endpoint of i2s and spdif nodes for rk3328.
>> Because to use modern sound card interface such as audio-graph-card.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> index d3ef6566325e..41f0a20b73ed 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
>> @@ -179,7 +179,13 @@
>>   		clock-names = "i2s_clk", "i2s_hclk";
>>   		dmas = <&dmac 11>, <&dmac 12>;
>>   		dma-names = "tx", "rx";
>> +		#sound-dai-cells = <0>;
>>   		status = "disabled";
>> +
>> +		i2s0_p0: port@0 {
> 
> there is only one port per device, so this should probably be
> 	i2s0_p0: port {
> without the address. Same for all others.
> The of-graph framework should work just fine then as well.

Thanks, indeed. I'll fix and send v2.


> 
> Heiko
> 
> 
> 

Regards,
--
Katsuhiro Suzuki
