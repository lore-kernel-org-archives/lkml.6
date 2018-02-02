Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeBBF73 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 00:59:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBBF7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 00:59:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB5396076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5b84a166-c71b-3a41-9e7f-a7624a8441f6@codeaurora.org>
 <38cdcae5-ec0f-d1be-b024-1990d4387731@gmail.com>
 <9e23d32f-05a0-ce8a-41f8-9a1a3d66be37@codeaurora.org>
 <fd9f5f63-b08e-602e-1510-85a65889f550@gmail.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <567731e8-8f89-bd6e-c3d4-e36400e69198@codeaurora.org>
Date: Fri, 2 Feb 2018 11:29:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <fd9f5f63-b08e-602e-1510-85a65889f550@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/2018 12:40 AM, Frank Rowand wrote:
> On 02/01/18 02:31, Chintan Pandya wrote:
>>
>>>> Anyways, will fix this locally and share test results.
>>>
>>> Thanks, I look forward to the results.
>>>
>>
>> Set up for this time was slightly different. So, taken all the numbers again.
>>
>> Boot to shell time (in ms): Experiment 2
>> [1] Base            : 14.843805 14.784842 14.842338
>> [2] 64 sized fixed cache    : 14.189292 14.200003 14.266711
>> [3] Dynamic freeable cache    : 14.112412 14.064772 14.036052
>>
>> So, [3] (this patch) looks to be improving 750ms (on avg from base build).
>>
> 
> Is this with the many debug options enabled?  If so, can you repeat with
> a normal configuration?

Could you share me the point of doing this experiment in perf mode ? I 
don't have a set up for taking these numbers in perf mode. For that, I 
need to ask some other team and round trip follow ups. In my set up, I 
rely on serial console logging which gets disabled in perf mode.

> 
> Thanks,
> 
> Frank
> 

Chintan
-- 
Qualcom India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
