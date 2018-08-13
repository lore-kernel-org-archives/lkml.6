Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C1C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040A8217FE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040A8217FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeHMLrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:47:22 -0400
Received: from regular1.263xmail.com ([211.150.99.138]:60596 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeHMLrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:47:22 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Aug 2018 07:47:21 EDT
Received: from huangtao?rock-chips.com (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 3C87D203;
        Mon, 13 Aug 2018 16:59:39 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.73] (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 6A73D3CC;
        Mon, 13 Aug 2018 16:59:25 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: huangtao@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: huangtao@rock-chips.com
X-UNIQUE-TAG: <32d99b4659e079536095e1a761f1480c>
X-ATTACHMENT-NUM: 0
X-SENDER: huangtao@rock-chips.com
X-DNS-TYPE: 0
Received: from [172.16.12.73] (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 209431RUQ3P;
        Mon, 13 Aug 2018 16:59:30 +0800 (CST)
Subject: Re: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for
 rk3399
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Caesar Wang <wxt@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Xing Zheng <zhengxing@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        dbasehore@chromium.org, Will Deacon <will.deacon@arm.com>,
        dianders@chromium.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        tony.xie@rock-chips.com, David Wu <david.wu@rock-chips.com>,
        cf@rock-chips.com, Jianqun Xu <jay.xu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org
References: <1467793254-10808-1-git-send-email-wxt@rock-chips.com>
 <5620784.b19SH5PkdR@phil>
 <ae312dc3-f640-ecf3-049a-c8576bb83330@rock-chips.com>
 <3578407.YVa0lydFsh@phil>
From:   Tao Huang <huangtao@rock-chips.com>
Message-ID: <fe65548d-3c98-968c-c9e1-c90dfad12502@rock-chips.com>
Date:   Mon, 13 Aug 2018 16:59:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3578407.YVa0lydFsh@phil>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018年08月13日 16:25, Heiko Stuebner wrote:
> Hi Tao,
>
> Am Sonntag, 12. August 2018, 18:24:45 CEST schrieb Tao Huang:
>> On 2018年08月10日 04:09, Heiko Stuebner wrote:
>>> Am Mittwoch, 6. Juli 2016, 10:20:54 CEST schrieb Caesar Wang:
>>>
>>>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>> index a6dd623..12ce265 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>> @@ -101,6 +101,18 @@
>>>>  			};
>>>>  		};
>>>>  
>>>> +		idle-states {
>>>> +			entry-method = "psci";
>>>> +			cpu_sleep: cpu-sleep-0 {
>>>> +				compatible = "arm,idle-state";
>>>> +				local-timer-stop;
>>>> +				arm,psci-suspend-param = <0x0010000>;
>>>> +				entry-latency-us = <350>;
>>>> +				exit-latency-us = <600>;
>>>> +				min-residency-us = <1150>;
>>> Looking at the chromeos kernel, there are some more patches adapting
>>> this idle-state to use different timings.
>> Yes, we have another values. So the values of this patch are wrong.
>>> There also was a cluster-idle state added for a while but that seems to
>>> cause audio issues according to the CrOS history.
>> DMA or Audio driver should add PM_QOS_CPU_DMA_LATENCY or other methods to avoid the effects of idle.
>> Idle itself is good.
> Thanks for the clarification. Do you know if some from Rockchip plans
> on submitting a new version of the patch with changed timings and
> cluster-sleep?

Okay. I will arrange engineer to submit the patch.

