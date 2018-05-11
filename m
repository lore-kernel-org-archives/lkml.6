Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeEKOzp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:55:45 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57596 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753143AbeEKOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:55:44 -0400
Subject: Re: [PATCH v2] selftests/cgroup: memory controller self-tests
To: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, kernel-team@fb.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20180510163701.28936-1-guro@fb.com>
 <20180510183224.GP2368884@devbig577.frc2.facebook.com>
 <a652ce44-07f9-d229-70d4-4376bfbafa40@kernel.org>
 <20180511143228.GU2368884@devbig577.frc2.facebook.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <ae4dc3f9-baa6-b492-7c43-0359734440b3@kernel.org>
Date: Fri, 11 May 2018 08:55:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511143228.GU2368884@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 08:32 AM, Tejun Heo wrote:
> Hello, Shuah.
> 
> On Thu, May 10, 2018 at 01:29:07PM -0600, Shuah Khan wrote:
>> Don't pull them yet. If Roman can redo the patches on linux-kselftest next,
>> he can pick up the SKIP changes.
> 
> So, what we can do is either fix that up during / after the merge
> window or creating a separate branch which pulls from both cgroup and
> kselftest.  Please let me know which way you wanna go and if the
> latter which branch I should pull (it gotta be a stable branch).
> 
> Thanks.
> 

I think we don't need to create a special branch and all. The following
should work:

linux-next already has the skip work. What we can do is:

Do the cleanup and test it against linux-next. In linux-next SKIP isn't PASS. If test is
compiled on linux-next, you will see that SKIP is SKIP. If it is compiled on the mainline,
it will be reported PASS, which will be a temporary state.

cgroup test will end up in linux-next anyway with crgoups tree before the merge window.
We can verify it then and make sure it is working correctly.

So I would recommend a version 3 that includes the cleanup to get rid if the TEST_* local
defines.

thanks,
-- Shuah
