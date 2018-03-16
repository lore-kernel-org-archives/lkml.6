Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCPMnP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:43:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPMnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:43:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E898F60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v2 13/13] ARM: dts: ipq8074: Enable few peripherals for
 hk01 board
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-14-git-send-email-sricharan@codeaurora.org>
 <7284d03a864202fd0baaeeea093068ee@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <5bb08fe8-7a3c-6a75-c385-df8f3890c4a0@codeaurora.org>
Date: Fri, 16 Mar 2018 18:13:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7284d03a864202fd0baaeeea093068ee@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On 3/16/2018 4:27 PM, Abhishek Sahu wrote:
> On 2018-03-16 15:08, Sricharan R wrote:
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq8074-hk01.dts | 103 ++++++++++++++++++++++++++++++
>>  1 file changed, 103 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> index 6a838b5..81dff867 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
>> @@ -21,6 +21,7 @@
>>
>>      aliases {
>>          serial0 = &blsp1_uart5;
>> +        serial1 = &serial_blsp2;
>>      };
>>
>>      chosen {
>> @@ -41,6 +42,47 @@
>>                      bias-disable;
>>                  };
>>              };
>> +
>> +             i2c_0_pins: i2c_0_pinmux {
>> +                  mux {
>> +                       pins = "gpio42", "gpio43";
>> +                       function = "blsp1_i2c";
>> +                       drive-strength = <8>;
>> +                       bias-disable;
>> +                  };
>> +             };
>> +
>> +             spi_0_pins: spi_0_pins {
>> +                  mux {
>> +                       pins = "gpio38", "gpio39", "gpio40", "gpio41";
>> +                       function = "blsp0_spi";
>> +                       drive-strength = <8>;
>> +                       bias-disable;
>> +                  };
>> +             };
>> +
>> +             hsuart_pins: hsuart_pins {
>> +                  mux {
>> +                       pins = "gpio46", "gpio47", "gpio48", "gpio49";
>> +                       function = "blsp2_uart";
>> +                       drive-strength = <8>;
>> +                       bias-disable;
>> +                  };
>> +             };
>> +
>> +             qpic_pins: qpic_pins {
>> +                mux {
>> +                       pins = "gpio1", "gpio3", "gpio4",
>> +                          "gpio5", "gpio6", "gpio7",
>> +                          "gpio8", "gpio10", "gpio11",
>> +                          "gpio12", "gpio13", "gpio14",
>> +                          "gpio15", "gpio16", "gpio17";
>> +                       function = "qpic";
>> +                       drive-strength = <8>;
>> +                       bias-disable;
>> +                  };
>> +            };
>> +
>>          };
>>
>>          serial@78b3000 {
>> @@ -48,5 +90,66 @@
>>              pinctrl-names = "default";
>>              status = "ok";
>>          };
>> +
>> +        spi@78b5000 {
>> +             pinctrl-0 = <&spi_0_pins>;
>> +             pinctrl-names = "default";
>> +             status = "ok";
>> +
>> +             m25p80@0 {
>> +                  #address-cells = <1>;
>> +                  #size-cells = <1>;
>> +                  compatible = "n25q128a11", "jedec,spi-nor";
>> +                  reg = <0>;
>> +                  spi-max-frequency = <50000000>;
>> +             };
>> +        };
>> +
>> +        serial@78B1000 {
> 
>  s/78B1000/78b1000
> 
>  With that,
>  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
> 

 ok, Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
