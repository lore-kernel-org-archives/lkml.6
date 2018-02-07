Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeBGEBF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:01:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeBGEBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:01:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18E3960272
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 12/15] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2
 board file
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-13-git-send-email-sricharan@codeaurora.org>
 <033a420e14f090258e4c8f14b7ba89a7@codeaurora.org>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <54429a54-764e-c834-7da7-f78be63d1427@codeaurora.org>
Date: Wed, 7 Feb 2018 09:30:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <033a420e14f090258e4c8f14b7ba89a7@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

<snip ..>

>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2017, The Linux Foundation. All rights reserved.
>> +
>> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
>> +
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK07.1-C2";
> 
>  s/IPQ40xx/IPQ4019
> 
 ok

>> +
>> +    soc {
>> +        pcie0: pci@40000000 {
>> +            status = "disabled";
>> +        };
> 
>  We can disable in base dtsi itself.
> 

 hmm, as mentioned in the previous patch, feels better to enable
 it only in the board file specifically and not to touch this here
 and the common dtsi.

>> +
>> +        pinctrl@1000000 {
>> +            serial_1_pins: serial1_pinmux {
>> +                mux {
>> +                    pins = "gpio8", "gpio9";
>> +                    function = "blsp_uart1";
>> +                    bias-disable;
>> +                };
>> +            };
>> +
>> +            spi_0_pins: spi_0_pinmux {
>> +                mux {
>> +                    pins = "gpio13", "gpio14",
>> "gpio15";
>> +                    function = "blsp_spi0";
>> +                    bias-disable;
>> +                };
>> +                cs1 {
>> +                    pins = "gpio12";
>> +                    function = "gpio";
>> +                };
>> +                host_int1 {
>> +                    pins = "gpio10";
>> +                    function = "gpio";
>> +                    input;
>> +                };
>> +                cs2 {
>> +                    pins = "gpio45";
>> +                    function = "gpio";
>> +                };
>> +                host_int2 {
>> +                    pins = "gpio61";
>> +                    function = "gpio";
>> +                    input;
>> +                };
>> +                rst {
>> +                    pins = "gpio36";
>> +                    function = "gpio";
>> +                    output-high;
>> +                };
> 
>  Normally spi pins should contains spi protocol related pins
>  could you please explain what is the role of host_pin and rst
>  pins and which driver will use these.
> 

 hmm, the additional pins were required for zigbee connected as the
 spidev device. So the right probably is to have the additional
 pins required for the device populated under the spi's child node.
 
>> +            };
>> +        };
>> +
>> +        serial@78b0000 {
>> +            pinctrl-0 = <&serial_1_pins>;
>> +            pinctrl-names = "default";
>> +            status = "ok";
>> +        };
>> +
>> +        spi_0: spi@78b5000 { /* BLSP1 QUP1 */
>> +            pinctrl-0 = <&spi_0_pins>;
>> +            pinctrl-names = "default";
>> +            status = "ok";
> 
>  From pinmux, it looks like multiple gpio based cs are being
>  used so do we need to specify cs-gpios like dk01-c2.
> 

 ok, let me check.

Regards,
 Sricharan


-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
