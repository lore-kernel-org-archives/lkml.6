Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FE6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106562075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nqdj9fFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106562075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeGROuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:50:06 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37522 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbeGROuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:50:05 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so2109264plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hm0GfILnPdVZ55zrW5t1PKask/NBpNc3HziUVobAoO4=;
        b=Nqdj9fFC+kcqPSq8h9q/j6cEEm7qgnrSO9p57iquFiuQLjDdcEPjS6c2n3uTDz8o8T
         KxYfHXcghsM+wPmMShmCqf89OsBjl7sv4WHMxqxXBQzPpdjhNI3TQrSeZnDrn4DqJXjX
         mWz6TCk0cGNOvjV9amxbNROB0tGjTq3IKQfXJ4HS3BOt3M6fczSPDkD+hwveYdSeDJ6w
         OxJX/F4Pn6lh0WZNDvFaULL2LghHlJui7Jv7mG7o5H82Kx5KrldmOVXWRbkkOu49liSB
         SJjtB8i7zqZa9Eqyy3vRZcZotnneDN2qHQ+JafmUFlMZI+M5ajWsQuBuNhQ3FG7/GA3Q
         7N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hm0GfILnPdVZ55zrW5t1PKask/NBpNc3HziUVobAoO4=;
        b=IDxYhv01xCi8nzpu2TmZhVxZK0uPmcoTn889M62AcLl4+2vw7NjItvmSLavHK2HoqA
         zRNxpULZvircJsd/QrzY36EGH3J/VdQxe6nHML2W2RgPifW7FTF1VPz2jDHi3WXqHQqQ
         pTE0IvMnLaQKJfwpmUrirv4gIyPhFsnzOAps7/HxLSOh6oFqarOL7QExCyRuY2BmlkcM
         55SouSC2FVDPeJn7EIDRmJ7bAHBGj6eR99fjhtaw/bKzn2HuBQ22C1sSh/Qmd0hHXVC+
         jJptkSIOHIfdlBTBuwbQVnfhi+6X+QRe+KGkZ/HMuDrB+DorwfQlWniTLiFPav7qgZEW
         IYiA==
X-Gm-Message-State: AOUpUlFdUh5Nj9lOIgQSYd2fQBeEKOzcGdbYdoC9QF84l5/B+sPsxV4r
        AL9WnLSYTIWQrMs1yj3dhCeh7ABwlFZImFqdvG4pQA==
X-Google-Smtp-Source: AAOMgpcZK7HEsNLrj745eTzXFTUu2mYx+EjCgy/JKaOEhmhGTDOOY9XJ8Aw5/5J2kHSCeqqN2Ly4R3D4ZIxp1sk6/hU=
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr6062203plo.117.1531923118965;
 Wed, 18 Jul 2018 07:11:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 07:11:38
 -0700 (PDT)
In-Reply-To: <fe20c22a-028b-b2a3-7714-c90b7fe51cbf@i-love.sakura.ne.jp>
References: <0000000000002f5541057143a85e@google.com> <eb295f49-78b3-62f5-84a8-221671c84634@I-love.SAKURA.ne.jp>
 <CACT4Y+bWR8s4_Chd33cjZ_qbTDyiciAQfmYP8fDv+r3Ar7X8iw@mail.gmail.com>
 <CACT4Y+bM1tfisT+7=ZChHRZKZkddbWp0kNi5q46EqOYBSptXtg@mail.gmail.com>
 <0adc592b-d4a3-f6da-3c5c-22490f641eb9@i-love.sakura.ne.jp>
 <CACT4Y+YqDFNrdtk+aet9UVBxyvxs+O85YLnMYL3FvoPckBx-Mg@mail.gmail.com> <fe20c22a-028b-b2a3-7714-c90b7fe51cbf@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 16:11:38 +0200
Message-ID: <CACT4Y+YShmryp_RJErUrjP=9GJ3YcRPLXyQP8XKoA9AW114Ygg@mail.gmail.com>
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

On Wed, Jul 18, 2018 at 3:35 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> This seems to be related to 9p. After rerunning the log I got:
>>>>
>>>> root@syzkaller:~# ps afxu | grep syz
>>>> root     18253  0.0  0.0      0     0 ttyS0    Zl   10:16   0:00  \_
>>>> [syz-executor] <defunct>
>>>> root@syzkaller:~# cat /proc/18253/task/*/stack
>>>> [<0>] p9_client_rpc+0x3a2/0x1400
>>>> [<0>] p9_client_flush+0x134/0x2a0
>>>> [<0>] p9_client_rpc+0x122c/0x1400
>>>> [<0>] p9_client_create+0xc56/0x16af
>>>> [<0>] v9fs_session_init+0x21a/0x1a80
>>>> [<0>] v9fs_mount+0x7c/0x900
>>>> [<0>] mount_fs+0xae/0x328
>>>> [<0>] vfs_kern_mount.part.34+0xdc/0x4e0
>>>> [<0>] do_mount+0x581/0x30e0
>>>> [<0>] ksys_mount+0x12d/0x140
>>>> [<0>] __x64_sys_mount+0xbe/0x150
>>>> [<0>] do_syscall_64+0x1b9/0x820
>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>> [<0>] 0xffffffffffffffff
>>>>
>>>> There is a bunch of hangs in 9p, so let's do:
>>>>
>>>> #syz dup: INFO: task hung in flush_work
>>>>
>>> Then, is dumping all threads when khungtaskd fires a candidate
>>> for CONFIG_DEBUG_AID_FOR_SYZBOT=y path?
>>
>> Perhaps would be useful. But maybe only tasks that are blocked for
>> more than timeout/2? and/or unkillable tasks? killable tasks are not a
>> problem.
>
> TASK_KILLABLE waiters are not reported by khungtaskd, are they?
>
>   /* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
>   if (t->state == TASK_UNINTERRUPTIBLE)
>     check_hung_task(t, timeout);
>
> And TASK_KILLABLE waiters can become a problem because
>
>>
>> Btw, I see that p9_client_rpc uses wait_event_killable, why wasn't it
>> killed along with the whole process?
>>
>
> wait_event_killable() would return -ERESTARTSYS if got SIGKILL.
> But if (c->status == Connected) && (type == P9_TFLUSH) is also true,
> it ignores SIGKILL by retrying the loop...
>
>   again:
>     err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
>     if ((err == -ERESTARTSYS) && (c->status == Connected) && (type == P9_TFLUSH)) {
>       sigpending = 1;
>       clear_thread_flag(TIF_SIGPENDING);
>       goto again;
>     }
>
> I wish they don't ignore SIGKILL (by e.g. offloading operations to a kernel thread).


I guess that's the problem, right? SIGKILL-ed task must not ignore
SIGKILL and hang in infinite loop. This would explain a bunch of hangs
in 9p.
