Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBFG1a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 01:27:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFG1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 01:27:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C46B360558
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 09/15] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3
 board file
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk,
        bjorn.andersson@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-arm-msm-owner@vger.kernel.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-10-git-send-email-sricharan@codeaurora.org>
 <4a173ff2a74ed7d1555d52674cf64ddd@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <a9f6233b-0dc2-d729-b7e7-09e228794529@codeaurora.org>
Date: Tue, 6 Feb 2018 11:57:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4a173ff2a74ed7d1555d52674cf64ddd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 5:07 PM, Abhishek Sahu wrote:
> On 2018-01-29 10:41, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/Makefile                      |  1 +
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 68e4b15..0104ba2 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -727,6 +727,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>      qcom-ipq4019-ap.dk01.1-c2.dtb \
>>      qcom-ipq4019-ap.dk04.1-c1.dtb \
>>      qcom-ipq4019-ap.dk04.1-c5.dtb \
>> +    qcom-ipq4019-ap.dk04.1-c3.dtb \
>>      qcom-ipq8064-ap148.dtb \
>>      qcom-msm8660-surf.dtb \
>>      qcom-msm8960-cdp.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
>> new file mode 100644
>> index 0000000..7a93fc4
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
>> +
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C3";
>> +
>> +    soc {
>> +        nand: qpic-nand@79b0000 {
>> +            status = "disabled";
>> +        };
> 
>  Normally we need to disable in base dtsi and enable in
>  board dtsi so that base dtsi will always work in all the
>  boards. Now If We load the base dtsi in any DK04 board
>  other than C1, then nand failure will come.

 Hmm, qpic nand is not there only on C3 and available in rest
 of dk04-c* variants. So it should work, downstream also
 does it in same way. Anyways, from a readability point, feel that
 better to make these uncommon configurations in each board file
 specifically rather than putting in common file and changing like this.

Regards,
 Sricharan


-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
