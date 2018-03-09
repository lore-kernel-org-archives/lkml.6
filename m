Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCIFSc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 00:18:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37498 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeCIFSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 00:18:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 424DF6038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v2] slub: use jitter-free reference while printing age
To: Christopher Lameter <cl@linux.com>
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1520492010-19389-1-git-send-email-cpandya@codeaurora.org>
 <alpine.DEB.2.20.1803081211230.14668@nuc-kabylake>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <2e02a8f9-8a28-1db4-3dde-8490ee294e5f@codeaurora.org>
Date: Fri, 9 Mar 2018 10:48:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803081211230.14668@nuc-kabylake>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2018 11:42 PM, Christopher Lameter wrote:
> On Thu, 8 Mar 2018, Chintan Pandya wrote:
> 
>> In this case, object got freed later but 'age'
>> shows otherwise. This could be because, while
>> printing this info, we print allocation traces
>> first and free traces thereafter. In between,
>> if we get schedule out or jiffies increment,
>> (jiffies - t->when) could become meaningless.
> 
> Could you show the new output style too?

New output will exactly be same. 'age' is still
staying with single jiffies ref in both prints.

> 
> Acked-by: Christoph Lameter <cl@linux.com>
Thanks


Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
