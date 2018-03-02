Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946524AbeCBP6E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:58:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426385AbeCBP6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:58:01 -0500
Subject: Re: [PATCH] arm64: dts: Hi3660: Remove 'CPU_NAP' idle state
To: Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1515472362-19979-1-git-send-email-leo.yan@linaro.org>
 <20180228050803.GB20745@leoy-ThinkPad-T440>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Wang <jean.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5A997473.40706@hisilicon.com>
Date: Fri, 2 Mar 2018 15:57:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180228050803.GB20745@leoy-ThinkPad-T440>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.47]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2018/2/28 5:08, Leo Yan wrote:
> Hi Wei,
> 
> On Tue, Jan 09, 2018 at 12:32:42PM +0800, Leo Yan wrote:
>> Thanks a lot for Vincent Guittot careful work to find bug for 'CPU_NAP'
>> idle state.  At early time, the CPU CA73 CPU_NAP idle state has been
>> supported on Hikey960.  Later we found the system has the hang issue
>> and for resolving this issue Hisilicon released new MCU firmware, but
>> unfortunately the new MCU firmware has side effect and results in the
>> CA73 CPU cannot really enter CPU_NAP state and roll back to WFI state.
>>
>> After discussion we cannot see the possibility to enable CA73 CPU_NAP
>> state anymore on Hikey960, based on this conclusion we should remove
>> this state from DT binding.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Kevin Wang <jean.wangtao@linaro.org>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Could you help to pick up this patch? Thanks!

Applied into hisilicon dt tree.
Thanks!

Best Regards,
Wei

> 
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 32 ++++---------------------------
>>  1 file changed, 4 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index ab0b95b..8fddf0d 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -96,11 +96,7 @@
>>  			reg = <0x0 0x100>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&A73_L2>;
>> -			cpu-idle-states = <
>> -					&CPU_NAP
>> -					&CPU_SLEEP
>> -					&CLUSTER_SLEEP_1
>> -			>;
>> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>>  		};
>>  
>>  		cpu5: cpu@101 {
>> @@ -109,11 +105,7 @@
>>  			reg = <0x0 0x101>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&A73_L2>;
>> -			cpu-idle-states = <
>> -					&CPU_NAP
>> -					&CPU_SLEEP
>> -					&CLUSTER_SLEEP_1
>> -			>;
>> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>>  		};
>>  
>>  		cpu6: cpu@102 {
>> @@ -122,11 +114,7 @@
>>  			reg = <0x0 0x102>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&A73_L2>;
>> -			cpu-idle-states = <
>> -					&CPU_NAP
>> -					&CPU_SLEEP
>> -					&CLUSTER_SLEEP_1
>> -			>;
>> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>>  		};
>>  
>>  		cpu7: cpu@103 {
>> @@ -135,24 +123,12 @@
>>  			reg = <0x0 0x103>;
>>  			enable-method = "psci";
>>  			next-level-cache = <&A73_L2>;
>> -			cpu-idle-states = <
>> -					&CPU_NAP
>> -					&CPU_SLEEP
>> -					&CLUSTER_SLEEP_1
>> -			>;
>> +			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP_1>;
>>  		};
>>  
>>  		idle-states {
>>  			entry-method = "psci";
>>  
>> -			CPU_NAP: cpu-nap {
>> -				compatible = "arm,idle-state";
>> -				arm,psci-suspend-param = <0x0000001>;
>> -				entry-latency-us = <7>;
>> -				exit-latency-us = <2>;
>> -				min-residency-us = <15>;
>> -			};
>> -
>>  			CPU_SLEEP: cpu-sleep {
>>  				compatible = "arm,idle-state";
>>  				local-timer-stop;
>> -- 
>> 2.7.4
>>
> 
> .
> 
