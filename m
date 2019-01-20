Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB3C61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD45D2084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 02:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfATCvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 21:51:14 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:13253 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfATCvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 21:51:14 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0K2ooal028244;
        Sun, 20 Jan 2019 11:50:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Sun, 20 Jan 2019 11:50:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0K2ooHt028240
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 20 Jan 2019 11:50:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] locking/lockdep: Add debug_locks check in
 __lock_downgrade()
To:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1547093005-26085-1-git-send-email-longman@redhat.com>
 <CACT4Y+YJYSo5GtSvMSqh4y_w7jWC1S-RYu+exuR3DU9NyrpJqA@mail.gmail.com>
 <20190114133650.GC10486@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <250f311c-a686-d4b3-d88f-6d39ff3b1492@i-love.sakura.ne.jp>
Date:   Sun, 20 Jan 2019 11:50:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114133650.GC10486@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, will this fix be sent to linux.git shortly?
syzbot is generating many corrupted reports due to this race.

On 2019/01/14 22:36, Peter Zijlstra wrote:
> On Thu, Jan 10, 2019 at 11:21:13AM +0100, Dmitry Vyukov wrote:
>> On Thu, Jan 10, 2019 at 5:04 AM Waiman Long <longman@redhat.com> wrote:
>>>
>>> Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
>>> warning right after a previous lockdep warning. It is likely that the
>>> previous warning turned off lock debugging causing the lockdep to have
>>> inconsistency states leading to the lock downgrade warning.
>>>
>>> Fix that by add a check for debug_locks at the beginning of
>>> __lock_downgrade().
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>>
>> Please also add:
>>
>> Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
>>
>> for tracking purposes. But Tetsuo deserves lots of credit for debugging it.
> 
> I made that:
> 
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
