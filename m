Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dRDLI0T6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BSCaqDAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F798607CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeFFGkF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:40:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45620 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeFFGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:40:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A720607C7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
To: Vinod Koul <vinod.koul@linaro.org>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180605164031.GZ16230@vkoul-mobl>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <1b376fc2-6a1b-1457-ffff-332954d1bef8@codeaurora.org>
Date: Wed, 6 Jun 2018 12:09:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605164031.GZ16230@vkoul-mobl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 6/5/2018 10:10 PM, Vinod Koul wrote:
> On 05-06-18, 18:26, Sricharan R wrote:
>> Hi Vinod,
>>
>> On 6/5/2018 11:49 AM, Vinod wrote:
>>> On 05-06-18, 11:12, Sricharan R wrote:
>>>
>>>> +config QCOM_Q6V5_WCSS
>>>> +	tristate "Qualcomm Hexagon based WCSS Peripheral Image Loader"
>>>> +	depends on OF && ARCH_QCOM
>>>> +	depends on QCOM_SMEM
>>>> +	depends on RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)
>>>> +	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>>>
>>> Is there a reason why it depends on RPMSG_QCOM_GLINK_SMEM=n? What would
>>> happen if distro wants both this and RPMSG_QCOM_GLINK_SMEM
>>>
>>   RPMSG_QCOM_GLINK_SMEM=n should be for the COMPILE_TEST. Probably that
> 
> why would that be a limitation? I am more worried about
> RPMSG_QCOM_GLINK_SMEM=n being the condition here. In new drivers we
> should not typically have dependency on some symbol being not there
> 

Without that, if RPMSG_QCOM_GLINK_SMEM=m is compiled as a module, then
it would break the build.

>>   means that it should be corrected here and for ADSP, Q6V5_PIL as well.
>>   Bjorn, is that correct ?, should it be, below ?
>>  
>>   depends on (RPMSG_QCOM_SMD || (COMPILE_TEST && RPMSG_QCOM_SMD=n)) || (RPMSG_QCOM_GLINK_SMEM || (COMPILE_TEST && RPMSG_QCOM_GLINK_SMEM=n))
> 
> that doesnt really sound good :(
> 

 Hmm, but i was thinking it should functionally depend on either SMD or GLINK and not both.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
