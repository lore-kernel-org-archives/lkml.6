Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBAKcK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 05:32:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbeBAKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 05:32:03 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D83036076A
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
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <9e23d32f-05a0-ce8a-41f8-9a1a3d66be37@codeaurora.org>
Date: Thu, 1 Feb 2018 16:01:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <38cdcae5-ec0f-d1be-b024-1990d4387731@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Anyways, will fix this locally and share test results.
> 
> Thanks, I look forward to the results.
> 

Set up for this time was slightly different. So, taken all the numbers 
again.

Boot to shell time (in ms): Experiment 2
[1] Base			: 14.843805 14.784842 14.842338
[2] 64 sized fixed cache	: 14.189292 14.200003 14.266711
[3] Dynamic freeable cache	: 14.112412 14.064772 14.036052

So, [3] (this patch) looks to be improving 750ms (on avg from base build).

-- 
Qualcom India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
