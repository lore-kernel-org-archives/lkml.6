Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeBFGTG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 01:19:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeBFGS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 01:18:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BEDE605A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 07/15] ARM: dts: ipq4019: Add ipq4019-ap.dk04.1-c1 board
 file
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk,
        bjorn.andersson@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-arm-msm-owner@vger.kernel.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-8-git-send-email-sricharan@codeaurora.org>
 <6821d93c282c8337b2a58c5c9337a008@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <4df81f9e-a018-822c-066b-e9735ed9908b@codeaurora.org>
Date: Tue, 6 Feb 2018 11:48:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6821d93c282c8337b2a58c5c9337a008@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 5:00 PM, Abhishek Sahu wrote:
> On 2018-01-29 10:41, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/Makefile                      | 1 +
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts | 8 ++++++++
>>  2 files changed, 9 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 21ed56d..1a8ab050 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -725,6 +725,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>      qcom-apq8084-mtp.dtb \
>>      qcom-ipq4019-ap.dk01.1-c1.dtb \
>>      qcom-ipq4019-ap.dk01.1-c2.dtb \
>> +    qcom-ipq4019-ap.dk04.1-c1.dtb \
>>      qcom-ipq8064-ap148.dtb \
>>      qcom-msm8660-surf.dtb \
>>      qcom-msm8960-cdp.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>> new file mode 100644
>> index 0000000..41123be
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
>> @@ -0,0 +1,8 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
>> +
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C1";
>> +};
> 
>  It seems major diff between DK01 C1 and other variants is
>  qpic nand. qpic nand is only available in C1 so do we need
>  to disable the nand is base dk04 dtsi and enable it in this
>  C1 dts only. same for qpic bam.

 C1 - Has QPIC NAND, spi 78b5000-> cs0 -> spi_nor
 C5 - Has QPIC NAND, spi 78b5000-> cs0 -> spi_nor, cs1 -> spi_nand
 C2 - Has QPIC NAND, spi 78b5000-> cs0 -> spi_nor ( Audio board, yet to be posted for pending audio drivers)
 C3 - spi 78b5000-> cs0 -> spi_nor

 So C3 is the board where it is disabled and enabled in the rest. But from a
 readability point, feels better to touch this only in each board specific file.
 So will remove this from the common 04.dtsi and move it to each board file.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
