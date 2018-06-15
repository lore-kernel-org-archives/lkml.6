Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458F4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1DA2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1DA2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966169AbeFOTlh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:41:37 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52525 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964930AbeFOTlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:41:35 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5FJeLqp074049;
        Sat, 16 Jun 2018 04:40:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Sat, 16 Jun 2018 04:40:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5FJeGwv074035
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 16 Jun 2018 04:40:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in __sb_start_write
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000283c37056b4a81a5@google.com>
 <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
 <20180611073038.GK12217@hirez.programming.kicks-ass.net>
 <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
 <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
 <CACT4Y+ZaUanRCWtq4nFhFVxfDCX=2e6JCW-qkX7vp++QvijWBw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <dd849e4f-a30f-e508-d4e9-0f3c6d11c89a@i-love.sakura.ne.jp>
Date:   Sat, 16 Jun 2018 04:40:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZaUanRCWtq4nFhFVxfDCX=2e6JCW-qkX7vp++QvijWBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/15 18:19, Dmitry Vyukov wrote:
> On Thu, Jun 14, 2018 at 12:33 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2018/06/11 16:39, Dmitry Vyukov wrote:
>>> On Mon, Jun 11, 2018 at 9:30 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>>> On Sun, Jun 10, 2018 at 11:47:56PM +0900, Tetsuo Handa wrote:
>>>>
>>>>> This looks quite strange that nobody is holding percpu_rw_semaphore for
>>>>> write but everybody is stuck trying to hold it for read. (Since there
>>>>> is no "X locks held by ..." line without followup "#0:" line, there is
>>>>> no possibility that somebody is in TASK_RUNNING state while holding
>>>>> percpu_rw_semaphore for write.)
>>>>>
>>>>> I feel that either API has a bug or API usage is wrong.
>>>>> Any idea for debugging this?
>>>>
>>>> Look at percpu_rwsem_release() and usage. The whole fs freezer thing is
>>>> magic.
>>>
>>> Do you mean that we froze fs? We tried to never-ever issue
>>> ioctl(FIFREEZE) during fuzzing. Are there other ways to do this?
>>>
>>
>> Dmitry, can you try this patch? If you can get
> 
> I've tried replying 5 logs with this patch, but I don't see that we
> return to user-space with locks held, nor deadlock reports.

Did you succeed to reproduce khungtaskd messages with this patch?
If yes, was one of sb_writers#X/sb_pagefaults/sb_internal printed there?
If no, we would want a git tree for testing under syzbot.

> 
> What I've noticed is that all these logs contain lots of error
> messages around block subsystem. Perhaps if we can identify the common
> denominator across error messages in different logs, we can find the
> one responsible for hangs.

While there are lots of error messages around block subsystem, how can
down_read() fail to continue unless up_write() somehow failed to wake up
waiters sleeping at down_read(), assuming that khungtaskd says that none
of sb_writers#X/sb_pagefaults/sb_internal was held?

Hmm, there might be other locations calling percpu_rwsem_release() ?
