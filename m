Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C104ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E4820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E4820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbeGRO5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:57:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:29129 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbeGRO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:57:00 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6IEHwWq060723;
        Wed, 18 Jul 2018 23:17:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Wed, 18 Jul 2018 23:17:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6IEHwZn060697
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Jul 2018 23:17:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in grab_super
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <0000000000002f5541057143a85e@google.com>
 <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
 <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
 <CACT4Y+bM1tfisT+7=ZChHRZKZkddbWp0kNi5q46EqOYBSptXtg@mail.gmail.com>
 <0adc592b-d4a3-f6da-3c5c-22490f641eb9@i-love.sakura.ne.jp>
 <CACT4Y+YqDFNrdtk+aet9UVBxyvxs+O85YLnMYL3FvoPckBx-Mg@mail.gmail.com>
 <fe20c22a-028b-b2a3-7714-c90b7fe51cbf@i-love.sakura.ne.jp>
 <CACT4Y+YShmryp_RJErUrjP=9GJ3YcRPLXyQP8XKoA9AW114Ygg@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <727110bb-0154-e5df-4b2f-e965e3b98c62@i-love.sakura.ne.jp>
Date:   Wed, 18 Jul 2018 23:17:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YShmryp_RJErUrjP=9GJ3YcRPLXyQP8XKoA9AW114Ygg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/18 23:11, Dmitry Vyukov wrote:
> On Wed, Jul 18, 2018 at 3:35 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>> This seems to be related to 9p. After rerunning the log I got:
>>>>>
>>>>> root@syzkaller:~# ps afxu | grep syz
>>>>> root     18253  0.0  0.0      0     0 ttyS0    Zl   10:16   0:00  \_
>>>>> [syz-executor] <defunct>
>>>>> root@syzkaller:~# cat /proc/18253/task/*/stack
>>>>> [<0>] p9_client_rpc+0x3a2/0x1400
>>>>> [<0>] p9_client_flush+0x134/0x2a0
>>>>> [<0>] p9_client_rpc+0x122c/0x1400
>>>>> [<0>] p9_client_create+0xc56/0x16af
>>>>> [<0>] v9fs_session_init+0x21a/0x1a80
>>>>> [<0>] v9fs_mount+0x7c/0x900
>>>>> [<0>] mount_fs+0xae/0x328
>>>>> [<0>] vfs_kern_mount.part.34+0xdc/0x4e0
>>>>> [<0>] do_mount+0x581/0x30e0
>>>>> [<0>] ksys_mount+0x12d/0x140
>>>>> [<0>] __x64_sys_mount+0xbe/0x150
>>>>> [<0>] do_syscall_64+0x1b9/0x820
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>> [<0>] 0xffffffffffffffff
>>>>>
>>>>> There is a bunch of hangs in 9p, so let's do:
>>>>>
>>>>> #syz dup: INFO: task hung in flush_work
>>>>>
>>>> Then, is dumping all threads when khungtaskd fires a candidate
>>>> for CONFIG_DEBUG_AID_FOR_SYZBOT=y path?
>>>
>>> Perhaps would be useful. But maybe only tasks that are blocked for
>>> more than timeout/2? and/or unkillable tasks? killable tasks are not a
>>> problem.
>>
>> TASK_KILLABLE waiters are not reported by khungtaskd, are they?
>>
>>   /* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
>>   if (t->state == TASK_UNINTERRUPTIBLE)
>>     check_hung_task(t, timeout);
>>
>> And TASK_KILLABLE waiters can become a problem because
>>
>>>
>>> Btw, I see that p9_client_rpc uses wait_event_killable, why wasn't it
>>> killed along with the whole process?
>>>
>>
>> wait_event_killable() would return -ERESTARTSYS if got SIGKILL.
>> But if (c->status == Connected) && (type == P9_TFLUSH) is also true,
>> it ignores SIGKILL by retrying the loop...
>>
>>   again:
>>     err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
>>     if ((err == -ERESTARTSYS) && (c->status == Connected) && (type == P9_TFLUSH)) {
>>       sigpending = 1;
>>       clear_thread_flag(TIF_SIGPENDING);
>>       goto again;
>>     }
>>
>> I wish they don't ignore SIGKILL (by e.g. offloading operations to a kernel thread).
> 
> 
> I guess that's the problem, right? SIGKILL-ed task must not ignore
> SIGKILL and hang in infinite loop. This would explain a bunch of hangs
> in 9p.

Did you check /proc/18253/task/*/stack after manually sending SIGKILL?
I mean, who (i.e. you or syzkaller programs) is sending a signal (not limited
to SIGKILL but any signal) that makes TASK_KILLABLE waiters to wake up?
