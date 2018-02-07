Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeBGErK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:47:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:60458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeBGErI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:47:08 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CB656029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Rob Herring <robh@kernel.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <CAL_JsqLb4PQ+NkA_RBAgB-5MzFKd+6wBvfCjXvoH-i8pGzzdTg@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <43b34b44-f613-79c6-1fe4-01c9dfe85e62@codeaurora.org>
Date: Wed, 7 Feb 2018 10:17:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLb4PQ+NkA_RBAgB-5MzFKd+6wBvfCjXvoH-i8pGzzdTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[]..

>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. SDM845";
> 
> This should only be in the board level file.

thanks, will fix.

> 
>> +
>> +       interrupt-parent = <&intc>;
>> +
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       chosen { };
>> +
>> +       memory {
>> +               device_type = "memory";
>> +               /* We expect the bootloader to fill in the reg */
> 
> The start address is variable? If not you should populate the base and
> have a unit-address.

sure, I'll check and update.

> 
>> +               reg = <0 0 0 0>;
>> +       };
>> +

[]..
>> +
>> +       soc: soc {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges = <0 0 0 0xffffffff>;
>> +               compatible = "simple-bus";
>> +
>> +               intc: interrupt-controller@17a00000 {
>> +                       compatible = "arm,gic-v3";
>> +                       #interrupt-cells = <3>;
>> +                       interrupt-controller;
>> +                       #redistributor-regions = <1>;
>> +                       redistributor-stride = <0x0 0x20000>;
>> +                       reg = <0x17a00000 0x10000>,     /* GICD */
>> +                             <0x17a60000 0x100000>;    /* GICR * 8 */
>> +                       interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +               };
>> +
>> +               gcc: clock-controller@100000 {
>> +                       compatible = "qcom,gcc-sdm845";
> 
> sdm845-gcc is the preferred order.

This is still proposed as part of the GCC patch for sdm845 [1]
(which looks like has neither you nor the DT list copied :/ )
Also looking at Documentation/devicetree/bindings/clock/qcom,gcc.txt,
I see we seem to follow the gcc-<soc> convention for compatible all along :(

                        "qcom,gcc-apq8064"
                        "qcom,gcc-apq8084"
                        "qcom,gcc-ipq8064"
                        "qcom,gcc-ipq4019"
                        "qcom,gcc-ipq8074"
                        "qcom,gcc-msm8660"
                        "qcom,gcc-msm8916"
                        "qcom,gcc-msm8960"
                        "qcom,gcc-msm8974"
                        "qcom,gcc-msm8974pro"
                        "qcom,gcc-msm8974pro-ac"
                        "qcom,gcc-msm8994"
                        "qcom,gcc-msm8996"
                        "qcom,gcc-mdm9615"

[1] https://patchwork.kernel.org/patch/10193895/ 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
