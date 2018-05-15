Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeEOSH1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:07:27 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35309 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753039AbeEOSFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:05:39 -0400
X-Google-Smtp-Source: AB8JxZqLa78mmXyeqRvoGKc3TZcdnsPMGQ+hBwdwPqJzYeEY7pR82u2930oA2rBkpoVj20t5/GgGA710r2vTH0sTNDI=
MIME-Version: 1.0
In-Reply-To: <1baa1a1a-a4a7-d706-8c01-5ff6a8757f97@redhat.com>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-3-git-send-email-longman@redhat.com> <20180515175805.GN12217@hirez.programming.kicks-ass.net>
 <1baa1a1a-a4a7-d706-8c01-5ff6a8757f97@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 May 2018 21:05:34 +0300
Message-ID: <CAOQ4uxj246koNjek_b=nP_Jf7HzL2v-KFO=RPG963YC7RJrCpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/percpu-rwsem: Annotate rwsem ownership
 transfer by setting RWSEM_OWNER_UNKNOWN
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 9:02 PM, Waiman Long <longman@redhat.com> wrote:
> On 05/15/2018 01:58 PM, Peter Zijlstra wrote:
>> On Tue, May 15, 2018 at 01:38:04PM -0400, Waiman Long wrote:
>>> +/*
>>> + * Owner value to indicate the rwsem's owner is not currently known.
>>> + */
>>> +#define RWSEM_OWNER_UNKNOWN ((struct task_struct *)-1)
>> It might be nice to comment that this works and relies on having that
>> ANON_OWNER bit set.
>
> I am just trying not to expose internal working of rwsem, but I can
> document that one of the bits is the real deal without specifying which one.
>

BUILD_BUG_ON(!rwsem_has_anonymous_owner(RWSEM_OWNER_UNKNOWN))
inside rwsem.c and comment above to explain it.

Thanks,
Amir.
