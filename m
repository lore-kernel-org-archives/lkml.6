Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeA3KZS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:25:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeA3KZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:25:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A8DD601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 1/2] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: andy.gross@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-2-rnayak@codeaurora.org>
 <20180126221501.GD28313@codeaurora.org>
 <514c49cc-71f9-ee21-250a-04f8fab151c0@codeaurora.org>
 <20180130094816.GJ28313@codeaurora.org>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <3ce97519-bc3d-d234-b10e-bd21b263cc73@codeaurora.org>
Date: Tue, 30 Jan 2018 15:55:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180130094816.GJ28313@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/30/2018 03:18 PM, Stephen Boyd wrote:
>>>> +	};
>>>> +
>>>> +	timer {
>>>> +		compatible = "arm,armv8-timer";
>>>> +		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>>> Are we supposed to use the GIC_CPU_MASK_SIMPLE macros still?
>> Not sure, is there another way?
> Me either. See this thread from Marc[1]. I guess just drop them?
> 
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1702.0/03522.html

thanks, Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt does seem to explain
how to specify PPI CPU affinity for GICv3 using a 4th cell if needed which I hadn't read :/

I'll send in a patch to get rid of them on 8996 as well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
