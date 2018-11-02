Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA1DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FBA20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ol7xZadR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FBA20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeKCE2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:28:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37670 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKCE2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:28:22 -0400
Received: by mail-it1-f195.google.com with SMTP id e74-v6so4621121ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=29K521QUNUq/mTyay8S87fPUFUgW2fNu2DEDWamBehc=;
        b=Ol7xZadRL8HtwRCktGXoywaaWw4+oGVgc/IrPChdUEtmW3m1tIMV8vR90NhzKs86xW
         nYsFyX2qO01/G3EX6GWFZ2kPiQYs4ddStdhbcenRwj0gjLbqkdrwD1i4va1P/AsO578V
         Knm/wETnoTIQBQzBmxbrnHbNZsXBhM7cabvKwJqebNXKaync32nRW0kMHkY4MjvZTyNb
         8/OTXIgTITt306uvbvTFbIPoRaPeMBYtbdBr1oRZqcI07Gh0VPUOSMLAgNxe+Z6VzTf2
         MWCYYK2GlvT5p012mMvZZXwzC0kLdYT3oPfRtnwOgDESvE01Xbe4UvWeUmpOhlvmWZXU
         72sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=29K521QUNUq/mTyay8S87fPUFUgW2fNu2DEDWamBehc=;
        b=T0P0Wv/gHbXVSY1tNkHm0ryvxY/dZD7lkyvQnZJg2pnsaIhprFQENQ1+KMEaqE+MAC
         SdxMThHZcWYkeh3EVzXYvrBk526W5e8rVRa2JnV4Bhzww9F7MTImRJFBys1AAKNSo1Of
         JGgEz7Wx0JgpU/wLswETbkpIF6IAWphVv6qGmgW2xJvKzYrCxoPGLvTrZFeDkgpP2c3K
         o7l/V1Fi83K7aXASC3WfrsFa6sM9rrBdB0ylhIZTAwHMwm1++qmlML6VqJwtz9W3VXDR
         zCyIWvhbBWCibfDHW7Q4BYhBGEddB/kyKspO3sRpwQNqUgLewwvmZeBeC56CW+0Eh8wY
         9LIA==
X-Gm-Message-State: AGRZ1gJLrRKuhrvcmaasJvlLrmEqspgRGMVfe/5QQoq/aM+q0H+dKm3V
        Fl+Iq01jE97IytRwNJ3M3dwzMjmgPAPl7Sp22oNZmA==
X-Google-Smtp-Source: AJdET5eKxK932saA9fyiPossSe/439vrAan7iCIynSwyhBygdY4EschoRhaVLtxViaxKcgDLg9uDw+vFfqD8u/YSiLc=
X-Received: by 2002:a02:1548:: with SMTP id j69-v6mr10789578jad.72.1541186398616;
 Fri, 02 Nov 2018 12:19:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:b01b:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 12:19:38 -0700 (PDT)
In-Reply-To: <727110bb-0154-e5df-4b2f-e965e3b98c62@i-love.sakura.ne.jp>
References: <0000000000002f5541057143a85e@google.com> <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
 <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
 <CACT4Y+bM1tfisT+7=ZChHRZKZkddbWp0kNi5q46EqOYBSptXtg@mail.gmail.com>
 <0adc592b-d4a3-f6da-3c5c-22490f641eb9@i-love.sakura.ne.jp>
 <CACT4Y+YqDFNrdtk+aet9UVBxyvxs+O85YLnMYL3FvoPckBx-Mg@mail.gmail.com>
 <fe20c22a-028b-b2a3-7714-c90b7fe51cbf@i-love.sakura.ne.jp>
 <CACT4Y+YShmryp_RJErUrjP=9GJ3YcRPLXyQP8XKoA9AW114Ygg@mail.gmail.com> <727110bb-0154-e5df-4b2f-e965e3b98c62@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 2 Nov 2018 20:19:38 +0100
Message-ID: <CACT4Y+Z-jwUJsfisdevXZdReWYgNnLELhgDtkVH53GC_mZqEPw@mail.gmail.com>
Subject: Re: INFO: task hung in grab_super
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net,
        syzbot <syzbot+f425456ea8aa16b40d20@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 4:17 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/07/18 23:11, Dmitry Vyukov wrote:
>> On Wed, Jul 18, 2018 at 3:35 PM, Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>>> This seems to be related to 9p. After rerunning the log I got:
>>>>>>
>>>>>> root@syzkaller:~# ps afxu | grep syz
>>>>>> root     18253  0.0  0.0      0     0 ttyS0    Zl   10:16   0:00  \_
>>>>>> [syz-executor] <defunct>
>>>>>> root@syzkaller:~# cat /proc/18253/task/*/stack
>>>>>> [<0>] p9_client_rpc+0x3a2/0x1400
>>>>>> [<0>] p9_client_flush+0x134/0x2a0
>>>>>> [<0>] p9_client_rpc+0x122c/0x1400
>>>>>> [<0>] p9_client_create+0xc56/0x16af
>>>>>> [<0>] v9fs_session_init+0x21a/0x1a80
>>>>>> [<0>] v9fs_mount+0x7c/0x900
>>>>>> [<0>] mount_fs+0xae/0x328
>>>>>> [<0>] vfs_kern_mount.part.34+0xdc/0x4e0
>>>>>> [<0>] do_mount+0x581/0x30e0
>>>>>> [<0>] ksys_mount+0x12d/0x140
>>>>>> [<0>] __x64_sys_mount+0xbe/0x150
>>>>>> [<0>] do_syscall_64+0x1b9/0x820
>>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>> [<0>] 0xffffffffffffffff
>>>>>>
>>>>>> There is a bunch of hangs in 9p, so let's do:
>>>>>>
>>>>>> #syz dup: INFO: task hung in flush_work
>>>>>>
>>>>> Then, is dumping all threads when khungtaskd fires a candidate
>>>>> for CONFIG_DEBUG_AID_FOR_SYZBOT=y path?
>>>>
>>>> Perhaps would be useful. But maybe only tasks that are blocked for
>>>> more than timeout/2? and/or unkillable tasks? killable tasks are not a
>>>> problem.
>>>
>>> TASK_KILLABLE waiters are not reported by khungtaskd, are they?
>>>
>>>   /* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
>>>   if (t->state == TASK_UNINTERRUPTIBLE)
>>>     check_hung_task(t, timeout);
>>>
>>> And TASK_KILLABLE waiters can become a problem because
>>>
>>>>
>>>> Btw, I see that p9_client_rpc uses wait_event_killable, why wasn't it
>>>> killed along with the whole process?
>>>>
>>>
>>> wait_event_killable() would return -ERESTARTSYS if got SIGKILL.
>>> But if (c->status == Connected) && (type == P9_TFLUSH) is also true,
>>> it ignores SIGKILL by retrying the loop...
>>>
>>>   again:
>>>     err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
>>>     if ((err == -ERESTARTSYS) && (c->status == Connected) && (type == P9_TFLUSH)) {
>>>       sigpending = 1;
>>>       clear_thread_flag(TIF_SIGPENDING);
>>>       goto again;
>>>     }
>>>
>>> I wish they don't ignore SIGKILL (by e.g. offloading operations to a kernel thread).
>>
>>
>> I guess that's the problem, right? SIGKILL-ed task must not ignore
>> SIGKILL and hang in infinite loop. This would explain a bunch of hangs
>> in 9p.
>
> Did you check /proc/18253/task/*/stack after manually sending SIGKILL?

Yes:

root@syzkaller:~# ps afxu | grep syz
root     18253  0.0  0.0      0     0 ttyS0    Zl   10:16   0:00  \_
[syz-executor] <defunct>
root@syzkaller:~# cat /proc/18253/task/*/stack
[<0>] p9_client_rpc+0x3a2/0x1400
[<0>] p9_client_flush+0x134/0x2a0
[<0>] p9_client_rpc+0x122c/0x1400
[<0>] p9_client_create+0xc56/0x16af
[<0>] v9fs_session_init+0x21a/0x1a80
[<0>] v9fs_mount+0x7c/0x900
[<0>] mount_fs+0xae/0x328
[<0>] vfs_kern_mount.part.34+0xdc/0x4e0
[<0>] do_mount+0x581/0x30e0
[<0>] ksys_mount+0x12d/0x140
[<0>] __x64_sys_mount+0xbe/0x150
[<0>] do_syscall_64+0x1b9/0x820
[<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
[<0>] 0xffffffffffffffff



> I mean, who (i.e. you or syzkaller programs) is sending a signal (not limited
> to SIGKILL but any signal) that makes TASK_KILLABLE waiters to wake up?

Both. syzkaller always SIGKILLs test process after some timeout and
expects it to go away. I also tried manually after that, but it does
not make any difference.
