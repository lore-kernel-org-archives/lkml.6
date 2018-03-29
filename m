Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeC2Ozr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:55:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752343AbeC2Ozp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:55:45 -0400
Subject: Re: [PATCH v4 1/2] locking/rwsem: Add DEBUG_RWSEMS to look for
 lock/unlock mismatches
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <1522246852-17501-1-git-send-email-longman@redhat.com>
 <1522246852-17501-2-git-send-email-longman@redhat.com>
 <20180329013224.tfryvl6lv5i72jwm@linux-n805>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1b8d58b1-faf3-f210-7356-9d67930a2efb@redhat.com>
Date: Thu, 29 Mar 2018 10:55:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180329013224.tfryvl6lv5i72jwm@linux-n805>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/2018 09:32 PM, Davidlohr Bueso wrote:
> On Wed, 28 Mar 2018, Waiman Long wrote:
>
>> +config DEBUG_RWSEMS
>> +    bool "RW Semaphore debugging: basic checks"
>> +    depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
>
> Why depend on RWSEM_SPIN_ON_OWNER? Doesn't everyone benefit from this?
> For example, DEBUG_MUTEXES does not need it.
>
> Thanks,
> Davidlohr

Because it checks the owner field which is present only if
RWSEM_SPIN_ON_OWNER is defined. Mutex is different in the sense that the
owner field is always there no matter if MUTEX_SPIN_ON_OWNER is set or not.

Cheers,
Longman
