Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeEKTdm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:33:42 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:42787 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeEKTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:33:41 -0400
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
To: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180510163701.28936-1-guro@fb.com>
 <20180510183224.GP2368884@devbig577.frc2.facebook.com>
 <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
 <20180511143228.GU2368884@devbig577.frc2.facebook.com>
 <ae4dc3f9-baa6-b492-7c43-0359734440b3@kernel.org>
 <20180511162920.GV2368884@devbig577.frc2.facebook.com>
 <957d089f-7a88-9ff4-733a-8e082339720c@kernel.org>
 <20180511180342.GA20683@castle>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <fb835740-cee8-83f8-880c-ea6eea8c7c63@kernel.org>
Date: Fri, 11 May 2018 13:33:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511180342.GA20683@castle>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:03 PM, Roman Gushchin wrote:
> On Fri, May 11, 2018 at 10:58:53AM -0600, Shuah Khan wrote:
>> On 05/11/2018 10:29 AM, Tejun Heo wrote:
>>> Hello, Shuah.
>>>
>>> On Fri, May 11, 2018 at 08:55:28AM -0600, Shuah Khan wrote:
>>>> I think we don't need to create a special branch and all. The following
>>>> should work:
>>>>
>>>> linux-next already has the skip work. What we can do is:
>>>>
>>>> Do the cleanup and test it against linux-next. In linux-next SKIP isn't PASS. If test is
>>>> compiled on linux-next, you will see that SKIP is SKIP. If it is compiled on the mainline,
>>>> it will be reported PASS, which will be a temporary state.
>>>
>>> Hah, why not just create a branch and make sure what we see in the
>>> topic branch is what we'll push?  That's how these things are done
>>> usually.
>>>
>>
>> It probably doesn't need to be complex.
>>
>> Unless there is a dependency with the cgroup tree and the cgroup test,
>> the test can go through kselftest tree with you. That is usually how
>> I handle kselftests.
>>
>> If you think there is a dependency and it has to go through cgroup tree
>> then, I can give you the Ack once this TEST_* gets cleaned up.
>>
>> thanks,
>> -- Shuah
>>
> 
> 
> Hello, Shuah!
> 
> A minor problem here is a version with KSFT_ constants won't even compile
> without your patch, which redefines KSFT_SKIP into a separate value,
> due to duplicate cases in the switch statement at the end of the file.
> 
> Anyway, not a big deal, we can handle it either way.
> An updated version below.
> 
> Thanks!
> 

Yeah. I see that. You have a switch for the KSFT_ values. Since there is no
dependency on the cgroup tree, I would recommend having this patch go through
kselftest tree which is the normal process for tests anyway.

This version is good and I can apply this to linux-kselftest next. I ran a
quick test and the Skip case looks good.

TAP version 13
selftests: cgroup: test_memcontrol
========================================
1..0 # Skipped: memory controller isn't available
not ok 1..1 selftests: cgroup: test_memcontrol [SKIP]


Tejun! Please send me your Ack.

thanks,
-- Shuah
