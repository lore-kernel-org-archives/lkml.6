Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754467AbeBGUJb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 15:09:31 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40339 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeBGUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 15:09:29 -0500
X-Google-Smtp-Source: AH8x224DMYdzMAabY5tZ/FYdP7LOyP9IvLfKZLBuDwd8JXvB8TbRW8wXxZOYpMH8aXfBFuXyX5t2/Q==
Subject: Re: [PATCH] of: cache phandle nodes to decrease cost of
 of_find_node_by_phandle()
To: Chintan Pandya <cpandya@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1517429142-25727-1-git-send-email-frowand.list@gmail.com>
 <5b84a166-c71b-3a41-9e7f-a7624a8441f6@codeaurora.org>
 <38cdcae5-ec0f-d1be-b024-1990d4387731@gmail.com>
 <9e23d32f-05a0-ce8a-41f8-9a1a3d66be37@codeaurora.org>
 <fd9f5f63-b08e-602e-1510-85a65889f550@gmail.com>
 <567731e8-8f89-bd6e-c3d4-e36400e69198@codeaurora.org>
 <0db129ef-ffd8-96fe-46a7-55fb575272e3@gmail.com>
 <0a178f4b-75fe-0564-7b0e-596f52fca1dc@codeaurora.org>
 <1768c791-7456-c1fe-578b-f6245e79746f@codeaurora.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <2e95e5f3-0f50-fb06-354e-918b48a55732@gmail.com>
Date: Wed, 7 Feb 2018 12:09:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1768c791-7456-c1fe-578b-f6245e79746f@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/18 04:44, Chintan Pandya wrote:
> 
> 
> On 2/5/2018 5:53 PM, Chintan Pandya wrote:
>>
>>>
>>> My question was trying to determine whether the numbers reported above
>>> are for a debug configuration or a production configuration.
>> My reported numbers are from debug configuration.
>>
>>> not a production configuration, I was requesting the numbers for a
>>> production configuration.
>> I'm working on it. But please expect some delay in my response for this. As I mentioned earlier, I need to work with few teams to get these numbers.
>>
>>
>>> show a significant boot time reduction from the patch then there is
>>> less justification for adding complexity to the existing code.  I
>>> prefer to use simpler data structures and algorithms __if__ extra
>>> complexity does not provide any advantage.  The balance between
>>> complexity and benefits is a core software engineering issue.
>>>
>> Ok
> 
> Avg Kernel boot time comparison in production set up:
> 
> [0] Base: 4519ms
> [1] 4115ms (~400ms improvement)
> [2] 4115ms (~400ms improvement)
> [3] 4177ms (~340ms improvement)
> 
> Full data:
> [1] 1024 sized pre-populated cache
> ITR-1    ITR-2    ITR-3    ITR-4    Avg
> 4115    4123    4124    4107    4115
> 
> [2] Dynamic sized cache allocation/free
> ITR-1    ITR-2    ITR-3    ITR-4    Avg
> 4122    4131    4106    4118    4115
> 
> [3] Fixed 64 sized cache
> ITR-1    ITR-2    ITR-3    ITR-4    Avg
> 4153    4186    4198    4181    4177
> 
> 
> [1] is my experimental patch and dirty enough to not get merged anywhere. So, I will not push it.
> 
> 
> 
> Chintan

Thank you very much.  This looks like a real improvement to me.

I'll rebase my patches, updated to address the comments, on 4.16-rc1.

-Frank
