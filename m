Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeEOSCD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:02:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751295AbeEOSCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:02:02 -0400
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com>
 <20180515175805.GN12217@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1baa1a1a-a4a7-d706-8c01-5ff6a8757f97@redhat.com>
Date: Tue, 15 May 2018 14:02:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180515175805.GN12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 01:58 PM, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
>> +/*
>> + * Owner value to indicate the rwsem's owner is not currently known.
>> + */
>> +#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1)
> It might be nice to comment that this works and relies on having that
> ANON_OWNER bit set.

I am just trying not to expose internal working of rwsem, but I can
document that one of the bits is the real deal without specifying which one.

Cheers,
Longman
