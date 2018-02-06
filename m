Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBFGBa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 01:01:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58678 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeBFGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 01:01:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23AFB6014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 06/15] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: mark.rutland@arm.com, robh@kernel.org, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk,
        bjorn.andersson@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-arm-msm-owner@vger.kernel.org,
        linux-soc@vger.kernel.org, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-7-git-send-email-sricharan@codeaurora.org>
 <a32d3a776c7a3f5c88a9a26200bff915@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <65ec9aef-c712-b8de-8da0-c1211ea0fbb3@codeaurora.org>
Date: Tue, 6 Feb 2018 11:31:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a32d3a776c7a3f5c88a9a26200bff915@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 2/3/2018 4:47 PM, Abhishek Sahu wrote:
> On 2018-01-29 10:41, Sricharan R wrote:
>> Add the common parts for the dk04 boards.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi | 147
> 
>  <snip>
>> +
>> +            nand_pins: nand_pins {
>> +                pullups {
>> +                    pins = "gpio52", "gpio53",
>> "gpio58",
>> +                        "gpio59";
>> +                    function = "qpic";
>> +                    bias-pull-up;
>> +                };
>> +
>> +                pulldowns {
>> +                    pins = "gpio54", "gpio55",
>> "gpio56",
>> +                        "gpio57", "gpio60",
>> "gpio61",
>> +                        "gpio62", "gpio63",
>> "gpio64",
>> +                        "gpio65", "gpio66",
>> "gpio67",
>> +                        "gpio68", "gpio69";
>> +                    function = "qpic";
>> +                    bias-pull-down;
>> +                };
>> +            };
> 
>  Can you please check once why do we need pull-up and
>  pull-down for NAND pins. The NAND chip will be mounted
>  over board itself so board design should take care of
>  required pull up and pull downs.
> 

  Mostly because, these are always **weak** pull up/down as defaults
  and should be overridden by the ones in the board (if there).


>  Also, some of the above pins like gpio52 will be only used
>  for LCD so we can remove those pins. Later on, when LCD
>  support will be added, we can add those pins.
 ok

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
