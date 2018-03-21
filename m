Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCUG3s (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:29:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCUG3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:29:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03735607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v3 1/7] dt-bindings: reset: Add AOSS reset bindings for
 SDM845 SoCs
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, georgi.djakov@linaro.org,
        jassisinghbrar@gmail.com, ohad@wizery.com, mark.rutland@arm.com,
        kyan@codeaurora.org, sricharan@codeaurora.org, akdwived@codeaurora.org,
        linux-arm-msm@vger.kernel.org, tsoni@codeaurora.org
References: <1521019283-32212-1-git-send-email-sibis@codeaurora.org>
 <1521019283-32212-2-git-send-email-sibis@codeaurora.org>
 <20180318224459.GC5626@tuxbook-pro>
From: Sibi S <sibis@codeaurora.org>
Message-ID: <d5a7f0c0-5daa-d2ac-a383-9456e9e38e4f@codeaurora.org>
Date: Wed, 21 Mar 2018 11:59:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180318224459.GC5626@tuxbook-pro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Thanks for the review.

On 03/19/2018 04:14 AM, Bjorn Andersson wrote:
> On Wed 14 Mar 02:21 PDT 2018, Sibi S wrote:
>> +- reg:
>> +	Usage: required
>> +	Value type: <prop-encoded-array>
>> +	Definition: must specify the base address and size of the register
>> +	            space.
>> +
>> +
> 
> Double empty lines.
> 

will remove them

>> +- #reset-cells:
>> +	Usage: required
>> +	Value type: <uint>
>> +	Definition: must be 1; cell entry represents the reset index.
>> +
>> +example:
> 
> Please capitalize the initial char.
>

sure

>> +
>> +aoss_reset: qcom,reset-controller@b2e0100 {
>> +	compatible = "qcom,sdm845-aoss-reset";
>> +	reg = <0xc2b0000 0x20004>;
> 
> 0x20004 does seem very even, please verify this size.
> 

even though the reg space after that range is unused, the AOSS reset
driver is supposed to control only those listed reset lines

>> +	#reset-cells = <1>;
>> +};
>> +
>> +
>> +Specifying reset lines connected to IP modules
> 
> "AOSS reset clients"
> 

yep this heading makes much more sense

> Although you could probably get a way with just referring to reset.txt
> and the header file.
> 
>> +==============================================
>> +
>> +Device nodes that need access to reset lines should
>> +specify them as a reset phandle in their corresponding node as
>> +specified in reset.txt.
>> +
>> +For list of all valid reset indicies see
>> +<dt-bindings/reset/qcom,sdm845-aoss.h>
>> +
>> +Example:
>> +
>> +modem-pil@4080000 {
>> +	...
>> +
>> +	resets = <&aoss_reset AOSS_CC_MSS_RESTART>;
>> +	reset-names = "mss_restart";
>> +
>> +	...
>> +};
>> diff --git a/include/dt-bindings/reset/qcom,sdm845-aoss.h b/include/dt-bindings/reset/qcom,sdm845-aoss.h
>> new file mode 100644
>> index 0000000..e9b38fc
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/qcom,sdm845-aoss.h
>> @@ -0,0 +1,17 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> For tooling reasons header files should have their SPDX License tag
> wrapped in /* */
> 

Sure will replace it

>> +/*
>> + * Copyright (C) 2018 The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RESET_AOSS_SDM_845_H
>> +#define _DT_BINDINGS_RESET_AOSS_SDM_845_H
>> +
>> +#define AOSS_CC_MSS_RESTART	0
>> +#define AOSS_CC_CAMSS_RESTART	1
>> +#define AOSS_CC_VENUS_RESTART	2
>> +#define AOSS_CC_GPU_RESTART	3
>> +#define AOSS_CC_DISPSS_RESTART	4
>> +#define AOSS_CC_WCSS_RESTART	5
>> +#define AOSS_CC_LPASS_RESTART	6
>> +
>> +#endif
> 
> Apart from these nits this looks reasonable.
> 
> Regards,
> Bjorn
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
