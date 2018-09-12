Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4154BECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049A5206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049A5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeILRqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:46:33 -0400
Received: from foss.arm.com ([217.140.101.70]:58816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeILRqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:46:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57FED80D;
        Wed, 12 Sep 2018 05:42:12 -0700 (PDT)
Received: from [10.4.13.23] (en101.Emea.Arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1353F703;
        Wed, 12 Sep 2018 05:42:10 -0700 (PDT)
Subject: Re: [PATCH 02/11] dts: hisilicon: Update coresight bindings for
 hardware ports
To:     leo.yan@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, sudeep.holla@arm.com, xuwei5@hisilicon.com,
        lipengcheng8@huawei.com
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-3-git-send-email-suzuki.poulose@arm.com>
 <20180912104735.GC3353@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <22fd3ec6-bde0-87c6-673b-f95a15190bda@arm.com>
Date:   Wed, 12 Sep 2018 13:42:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912104735.GC3353@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 12/09/18 11:47, leo.yan@linaro.org wrote:
> On Tue, Sep 11, 2018 at 11:17:03AM +0100, Suzuki K Poulose wrote:
>> Switch to updated coresight bindings for hw ports.
> 
> As Shawn suggested, please change subject as "arm64: dts: hi6220:
> ...."
> 

Sure, will do.

>> Cc: xuwei5@hisilicon.com
>> Cc: lipengcheng8@huawei.com
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 147 ++++++++++++---------
>>   1 file changed, 85 insertions(+), 62 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
>> index 7afee5d..2202816 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> 
> [...]
> 
>> @@ -302,10 +315,12 @@
>>   
>>   			cpu = <&cpu3>;
>>   
>> -			port {
>> -				etm3_out: endpoint {
>> -					remote-endpoint =
>> -						<&acpu_funnel_in3>;
>> +			out-ports {
>> +				port {
>> +					etm3_out: endpoint {
>> +						remote-endpoint =
>> +							<&acpu_funnel_in3>;
>> +					};
>>   				};
>>   			};
>>   		};
>> @@ -319,10 +334,12 @@
>>   
>>   			cpu = <&cpu4>;
>>   
>> -			port {
>> +			out-ports {
>> +				port {
>>   				etm4_out: endpoint {
> 
> Indent?

Yes, I have fixed this locally for v2.

> 
> After applied this patch and tested on Hikey board; FWIW:
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks for the testing !

Cheers
Suzuki
