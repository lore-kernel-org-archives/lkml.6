Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeEBHpT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:45:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeEBHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:45:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 02 May 2018 13:15:12 +0530
From: Amit Nischal <anischal@codeaurora.org>
To: Rob Herring <robh@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: Introduce QCOM Video clock
 bindings
In-Reply-To: <20180501135054.GA373@rob-hp-laptop>
References: <1524576771-31096-1-git-send-email-anischal@codeaurora.org>
 <1524576771-31096-2-git-send-email-anischal@codeaurora.org>
 <20180501135054.GA373@rob-hp-laptop>
Message-ID: <55ef90a4034f5c7e94274c1ea02d3af1@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-01 19:20, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 07:02:50PM +0530, Amit Nischal wrote:
>> Add device tree bindings for video clock controller for Qualcomm
>> Technology Inc's SoCs.
>> 
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> ---
>>  .../devicetree/bindings/clock/qcom,videocc.txt     | 18 
>> ++++++++++++++++
>>  include/dt-bindings/clock/qcom,videocc-sdm845.h    | 25 
>> ++++++++++++++++++++++
>>  2 files changed, 43 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/clock/qcom,videocc.txt
>>  create mode 100644 include/dt-bindings/clock/qcom,videocc-sdm845.h
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.txt 
>> b/Documentation/devicetree/bindings/clock/qcom,videocc.txt
>> new file mode 100644
>> index 0000000..1c23b41
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.txt
>> @@ -0,0 +1,18 @@
>> +Qualcomm Video Clock & Reset Controller Binding
>> +-----------------------------------------------
>> +
>> +Required properties :
>> +- compatible : shall contain "qcom,videocc-sdm845"
> 
> '<vendor>,<soc>-<block>' is the preferred order.
> 
> Every single QCom binding... Can someone spread the word in QCom.

Thanks for the review. I will make the suggested change in the next
series.

> 
>> +- reg : shall contain base register location and length
>> +- #clock-cells : shall contain 1
>> +- #reset-cells : shall contain 1
>> +- #power-domain-cells : shall contain 1
> 
> No header definitions for resets and power-domain? There's no
> requirement to have headers, but the binding should be complete even if
> you don't have a driver yet.

Will do the required changes in the next patch series.
> 
>> +
>> +Example:
>> +	videocc: qcom,videocc@ab00000 {
> 
> clock-controller@...

Will be fixed in the next patch series.

> 
>> +		compatible = "qcom,videocc-sdm845";
>> +		reg = <0xab00000 0x10000>;
>> +		#clock-cells = <1>;
>> +		#reset-cells = <1>;
>> +		#power-domain-cells = <1>;
>> +	};
>> diff --git a/include/dt-bindings/clock/qcom,videocc-sdm845.h 
>> b/include/dt-bindings/clock/qcom,videocc-sdm845.h
>> new file mode 100644
>> index 0000000..f5f7599
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,videocc-sdm845.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2016-2018, The Linux Foundation. All rights 
>> reserved. */
>> +
>> +#ifndef _DT_BINDINGS_CLK_MSM_VIDEO_CC_SDM845_H
>> +#define _DT_BINDINGS_CLK_MSM_VIDEO_CC_SDM845_H
>> +
>> +#define VIDEO_CC_APB_CLK			0
>> +#define VIDEO_CC_AT_CLK				1
>> +#define VIDEO_CC_QDSS_TRIG_CLK			2
>> +#define VIDEO_CC_QDSS_TSCTR_DIV8_CLK		3
>> +#define VIDEO_CC_VCODEC0_AXI_CLK		4
>> +#define VIDEO_CC_VCODEC0_CORE_CLK		5
>> +#define VIDEO_CC_VCODEC1_AXI_CLK		6
>> +#define VIDEO_CC_VCODEC1_CORE_CLK		7
>> +#define VIDEO_CC_VENUS_AHB_CLK			8
>> +#define VIDEO_CC_VENUS_CLK_SRC			9
>> +#define VIDEO_CC_VENUS_CTL_AXI_CLK		10
>> +#define VIDEO_CC_VENUS_CTL_CORE_CLK		11
>> +#define VIDEO_PLL0				12
>> +
>> +#define VENUS_GDSC				0
>> +#define VCODEC0_GDSC				1
>> +#define VCODEC1_GDSC				2
>> +
>> +#endif
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
