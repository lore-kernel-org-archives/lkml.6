Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDLWio (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 18:38:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeDLWin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 18:38:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A795B60264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v3 2/2] MIPS: io: add a barrier after register read in
 readX()
To: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org, arnd@arndb.de, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <1522760109-16497-1-git-send-email-okaya@codeaurora.org>
 <1522760109-16497-2-git-send-email-okaya@codeaurora.org>
 <20180412215149.GA27802@saruman> <20180412215855.GB27802@saruman>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <33c9c074-e0a5-7552-9993-269cd85101aa@codeaurora.org>
Date: Thu, 12 Apr 2018 18:38:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412215855.GB27802@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2018 5:58 PM, James Hogan wrote:
> On Thu, Apr 12, 2018 at 10:51:49PM +0100, James Hogan wrote:
>> On Tue, Apr 03, 2018 at 08:55:04AM -0400, Sinan Kaya wrote:
>>> While a barrier is present in writeX() function before the register write,
>>> a similar barrier is missing in the readX() function after the register
>>> read. This could allow memory accesses following readX() to observe
>>> stale data.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Both patches look like obvious improvements to me, so I'm happy to apply
>> to my fixes branch.
> 
> Though having said that, a comment to go with the rmb() (as suggested by
> checkpatch) to detail the situation we're concerned about would be nice
> to have.

I can send a new version. No worries. 

Functional correctness is more important at this moment. I can accommodate
any nice to haves.

> 
> Cheers
> James
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
