Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeBBV0f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:26:35 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:42695 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeBBV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:26:27 -0500
X-Google-Smtp-Source: AH8x226RTRSWmlC963oAXtPbwhjWcb3kTQNoZ2XC1HJoAeNUsJPqLvocIeUjK37rd+gJrMyyArO36g==
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
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <0db129ef-ffd8-96fe-46a7-55fb575272e3@gmail.com>
Date: Fri, 2 Feb 2018 13:26:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <567731e8-8f89-bd6e-c3d4-e36400e69198@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/18 21:59, Chintan Pandya wrote:
> 
> 
> On 2/2/2018 12:40 AM, Frank Rowand wrote:
>> On 02/01/18 02:31, Chintan Pandya wrote:
>>>
>>>>> Anyways, will fix this locally and share test results.
>>>>
>>>> Thanks, I look forward to the results.
>>>>
>>>
>>> Set up for this time was slightly different. So, taken all the numbers again.
>>>
>>> Boot to shell time (in ms): Experiment 2
>>> [1] Base            : 14.843805 14.784842 14.842338
>>> [2] 64 sized fixed cache    : 14.189292 14.200003 14.266711
>>> [3] Dynamic freeable cache    : 14.112412 14.064772 14.036052
>>>
>>> So, [3] (this patch) looks to be improving 750ms (on avg from base build).
>>>
>>
>> Is this with the many debug options enabled?  If so, can you repeat with
>> a normal configuration?
> 
> Could you share me the point of doing this experiment in perf mode ?


You had mentioned earlier in another thread:

   My recent results were taken on debug_defconfig which has many performance
   slowing code. So, gap between base-build and w/ the test patches would be
   more than the actual production build.

If you measure a large performance gain with a debug configuration, that
may not represent the actual gain you will get with a production
configuration, as you noted.

My question was trying to determine whether the numbers reported above
are for a debug configuration or a production configuration.  And if
not a production configuration, I was requesting the numbers for a
production configuration.  If the production configuration does not
show a significant boot time reduction from the patch then there is
less justification for adding complexity to the existing code.  I
prefer to use simpler data structures and algorithms __if__ extra
complexity does not provide any advantage.  The balance between
complexity and benefits is a core software engineering issue.


> I don't have a set up for taking these numbers in perf mode. For
> that, I need to ask some other team and round trip follow ups. In my
> set up, I rely on serial console logging which gets disabled in perf
> mode.
> 
>>
>> Thanks,
>>
>> Frank
>>
> 
> Chintan
