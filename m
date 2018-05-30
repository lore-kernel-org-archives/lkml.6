Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeE3MZM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:25:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbeE3MZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:25:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE21460646
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=hareeshg@codeaurora.org
Subject: Re: [PATCH] lib/plist.c: Export plist_*() APIs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, jcrouse@codeaurora.org,
        Mel Gorman <mgorman@suse.de>, efault@gmx.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
References: <1512484543-24772-1-git-send-email-hareeshg@codeaurora.org>
 <20171205144104.egber33dwpc6uo7c@hirez.programming.kicks-ass.net>
 <12861d19-1579-2f78-7c4c-ac8983b505ae@codeaurora.org>
 <20171206155917.se5mmw2gf5qz4otf@hirez.programming.kicks-ass.net>
From: Hareesh Gundu <hareeshg@codeaurora.org>
Message-ID: <8a59865a-1143-3ba1-8be7-cf590d422c36@codeaurora.org>
Date: Wed, 30 May 2018 17:55:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20171206155917.se5mmw2gf5qz4otf@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/2017 9:29 PM, Peter Zijlstra wrote:
> On Wed, Dec 06, 2017 at 08:59:27PM +0530, Hareesh Gundu wrote:
>> On 12/5/2017 8:11 PM, Peter Zijlstra wrote:
>>> On Tue, Dec 05, 2017 at 08:05:43PM +0530, Hareesh Gundu wrote:
>>>> Allow plist_add(), plist_del() and plist_requeue() APIs to
>>>> be referenced by kernel modules by adding the EXPORT_SYMBOL().
>> This change is not for in-tree kernel module. It's for modules built outside
>> of kernel tree modules.
>>
>> Is it really required to show out tree kernel modules ?
> Typically we don't add EXPORTs for functions not used in in-tree
> modules.
We changed our design and planned to have our module in-tree kernel 
instead of out tree kernel module.
Below is the reference for in-tree kernel module proposal for 
"drviers/gpu/msm" which is referring to plist_* symbols.

https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/gpu/msm/adreno_dispatch.c?h=msm-4.9#n533

Could you please revisit the patch and approve for upstream.
