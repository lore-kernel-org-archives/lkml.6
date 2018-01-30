Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751611AbeA3JSx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:18:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32825 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbeA3JSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:18:49 -0500
X-Google-Smtp-Source: AH8x224eEteQQbdgaQO0sJilGPzMjfjDDbZ3H0EWylYkXqshC6opjdilSPr9s2xl9BQB8ly5H9HSPA==
Subject: Re: [PATCH 4/4] dmaengine: qcom: bam_dma: Add num-ees dt binding for
 remotely controlled
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Andy Gross <andy.gross@linaro.org>,
        dmaengine@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        David Brown <david.brown@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, yanhe@quicinc.com, ramkri@qti.qualcomm.com,
        sdharia@quicinc.com
References: <20180116190236.14558-1-srinivas.kandagatla@linaro.org>
 <20180116190236.14558-5-srinivas.kandagatla@linaro.org>
 <20180129162146.2h3kht4xhhr32mbp@rob-hp-laptop>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3f9a06a6-5637-5768-9f8a-11d451458ffa@linaro.org>
Date: Tue, 30 Jan 2018 09:18:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180129162146.2h3kht4xhhr32mbp@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 29/01/18 16:21, Rob Herring wrote:
> On Tue, Jan 16, 2018 at 07:02:36PM +0000, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> When Linux is master of BAM, it can directly read registers to know number
>> of supported execution enviroments, however when its remotely controlled
>> reading these registers would trigger a crash if the BAM is not yet
>> intialized/powered up on the remote side.
>>
>> This patch adds new binding num-ees to specify supported number of
>> Execution Environments when BAM is remotely controlled.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/dma/qcom_bam_dma.txt |  2 ++
>>   drivers/dma/qcom/bam_dma.c                             | 15 ++++++++++++---
>>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> The correct split is the binding changes in 1 patch. Driver changes
> separate.
> 
Sure, Will Split it in next version.
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
>> index aa6822cbb230..f0d10c2b393e 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
>> @@ -17,6 +17,8 @@ Required properties:
>>     remote proccessor i.e. execution environment.
>>   - num-channels : optional, indicates supported number of DMA channels in a
>>     remotely controlled bam.
>> +- num-ees : optional, indicates supported number of Execution Environments in a
>> +  remotely controlled bam.
> 
> This one needs a vendor prefix as it is not a common property.
> 
Make sense, I will change it in next version.

Thanks,
Srini
>>   
>>   Example:
>>   
