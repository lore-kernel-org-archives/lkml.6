Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeEOSqA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:46:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752763AbeEOSp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:45:59 -0400
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
To: Amir Goldstein <amir73il@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <1baa1a1a-a4a7-d706-8c01-5ff6a8757f97@redhat.com>
 <CAOQ4uxj246koNjek_b=nP_Jf7HzL2v-KFO=RPG963YC7RJrCpg@mail.gmail.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e011289a-e13a-8839-7a48-eb6e58f5eaa7@redhat.com>
Date: Tue, 15 May 2018 14:45:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxj246koNjek_b=nP_Jf7HzL2v-KFO=RPG963YC7RJrCpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 02:05 PM, Amir Goldstein wrote:
> On Tue, May 15, 2018 at 9:02 PM, Waiman Long <longman@redhat.com> wrote:
>> On 05/15/2018 01:58 PM, Peter Zijlstra wrote:
>>> On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
>>>> +/*
>>>> + * Owner value to indicate the rwsem's owner is not currently known.
>>>> + */
>>>> +#define RWSEM_OWNER_UNKNOWN ((struct task_struct *)-1)
>>> It might be nice to comment that this works and relies on having that
>>> ANON_OWNER bit set.
>> I am just trying not to expose internal working of rwsem, but I can
>> document that one of the bits is the real deal without specifying which one.
>>
> BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN))
> inside rwsem.c and comment above to explain it.

Yes, it is a good idea. I will do that.

-Longman
