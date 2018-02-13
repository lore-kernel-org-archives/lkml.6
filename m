Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965947AbeBMVmD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:42:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965864AbeBMVmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:42:01 -0500
Subject: Re: [PATCH] kthread: Export kthread_data()
From: Waiman Long <longman@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1518187941-29275-1-git-send-email-longman@redhat.com>
 <20180213155033.GA16684@infradead.org>
 <7084eed7-5343-f9cc-beda-816c3fae1022@redhat.com>
Organization: Red Hat
Message-ID: <11243edc-22b2-6d07-c2b7-b83a6dd09308@redhat.com>
Date: Tue, 13 Feb 2018 16:42:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <7084eed7-5343-f9cc-beda-816c3fae1022@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 04:40 PM, Waiman Long wrote:
> On 02/13/2018 10:50 AM, Christoph Hellwig wrote:
>> On Fri, Feb 09, 2018 at 09:52:21AM -0500, Waiman Long wrote:
>>> When multiple kernel threads are created to cooperatively work on
>>> a common task, we may need a convenient way to access data that are
>>> specific to each kthread.
>>>
>>> The kthread_data() function fits this need.  However, it was not
>>> visible to kthreads started in a kernel module. To solve this problem,
>>> the kthread_data() function is now exported allowing kthreads from
>>> kernel modules to use it.
>> Please send this along wit hthe actual user of it.
> It is the developers of the dm-vdo/kvdo modules that would like to use
> the kthread_data() function. See
>
> https://github.com/dm-vdo/kvdo
>
> Those modules have a bunch of kernel threads working on block storage
> deduplication/compression.
>
> -Longman
>
BTW, I am fine with not exporting the function. They just have to find
an alternative way of doing it.

-Longman
