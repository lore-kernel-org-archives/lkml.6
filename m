Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B672AC43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839D121019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbdmMJwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeLaGiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 01:38:09 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:54374 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeLaGiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 01:38:09 -0500
Received: by mail-it1-f196.google.com with SMTP id i145so34979629ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 22:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WDxHip/cwTK/RC79Rk7b22Sk/Z//HYyi4QdNtJqW8W4=;
        b=EbdmMJwbtX2MHM/ZVBrS3AyDWHDL9+ZRIUzzjHhTQ+D3IhYclCQhkcV0BcvtxM3X8p
         lV5OpjfdVUqDzKM9QjNv6z0h8u1VMqFQ1OnT4i8NGsdzC3jBiVY3WFllcEXZxb7w1V2F
         0GnEY79GgA5mU8Pd8kafWOkwyxzlbIWcJZe6CKW+yLfNBSagHIn2SEPAXuDqQ5GM7g7K
         NyTDb68sGhHruoR0tmDXASHQgeAiuztavJMypoZ1sH7F2jStVkEVd6WbJ7KeQvaBj0z3
         GQztK2DA9soM1embLo9EeXHgYh9+Z3TMS3wMYuGBluOMg9wTwf6hV6XvlD5B3OpdycOS
         qYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WDxHip/cwTK/RC79Rk7b22Sk/Z//HYyi4QdNtJqW8W4=;
        b=mlqdjGGre3vIcwKJn5fvQBC5piChDhTatG/j12DzFHhX7A5+igfmdUqAtwGBAx933S
         vlI5IkNtDGPvz76qDzfiOvVrCglL8w+81xM+ypA00ZlgtymqdPcaZx3UPJBfjC9pZ311
         sZH9NM/pbYeS8REgw+iAt6aAnJNRpQWJBJR8C5gyPaSTn9uow/HyABwcj3EOKdE3ImlF
         +IejdSAnFohffpjLKxUWAtqeXALZlukj8u74D5hX+m4JY6n12GNL3PWLfAV4bmqYEW5C
         zFl73PXboxoSq/6s+GQLIQ+TK4byD+Jxu0xK/3/nhT3zxMIwVF0ZMa1fTUp22EFQFJyK
         Ah3A==
X-Gm-Message-State: AA+aEWYYj9LDfoRsqCnwAWEwj8CK+qiqzs+Nf9L99fff19oZ3U4JxtLq
        zm21Sx7TN0qDVQDE3xQ5JbG+aSjU6tlagr6fjzLI0Q==
X-Google-Smtp-Source: AFSGD/UuoyzyBlb2+vpgpuj0E6nfWustF69TXMCApFHgdcAUw1EgD8I14jfQDzS8o80Lsla90BhN67xs2KUJQ9o4vcs=
X-Received: by 2002:a02:8904:: with SMTP id o4mr23277296jaj.35.1546238287664;
 Sun, 30 Dec 2018 22:38:07 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009e1fa9057c5fd1ae@google.com>
In-Reply-To: <0000000000009e1fa9057c5fd1ae@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 Dec 2018 07:37:56 +0100
Message-ID: <CACT4Y+anVmfsjt-jo7RvJ3YOgKgkTY=m-5k3Pv4UBcHdnYTpSw@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in __schedule (2)
To:     syzbot <syzbot+df28818b7ebe8e7d704e@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 8:51 PM syzbot
<syzbot+df28818b7ebe8e7d704e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d08970904582 Merge tag 'for-4.20-rc5-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=106a5dd5400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b9cc5a440391cbfd
> dashboard link: https://syzkaller.appspot.com/bug?extid=df28818b7ebe8e7d704e
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12940cfb400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fb5e25400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+df28818b7ebe8e7d704e@syzkaller.appspotmail.com


Since this involves OOMs:

#syz dup: kernel panic: corrupted stack end in wb_workfn



> kmem_cache               161KB        165KB
> Out of memory: Kill process 7764 (syz-executor613) score 0 or sacrifice
> child
> Killed process 7770 (syz-executor613) total-vm:18964kB, anon-rss:2124kB,
> file-rss:4kB, shmem-rss:0kB
> oom_reaper: reaped process 7770 (syz-executor613), now anon-rss:0kB,
> file-rss:0kB, shmem-rss:0kB
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in schedule_debug kernel/sched/core.c:3284
> [inline]
> BUG: KASAN: stack-out-of-bounds in __schedule+0x1c1b/0x21d0
> kernel/sched/core.c:3394
> Read of size 8 at addr ffff8881ce710000 by task kworker/u4:4/2620
>
> CPU: 1 PID: 2620 Comm: kworker/u4:4 Not tainted 4.20.0-rc5+ #266
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: writeback wb_workfn (flush-8:0)
> Call Trace:
>
> The buggy address belongs to the page:
> page:ffffea000739c400 count:1 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 dead000000000100 dead000000000200 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8881ce70ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
>   ffff8881ce70ff80: f1 00 00 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2
> > ffff8881ce710000: f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2
>                     ^
>   ffff8881ce710080: f2 00 f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00
>   ffff8881ce710100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 2620 Comm: kworker/u4:4 Tainted: G    B             4.20.0-rc5+
> #266
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: writeback wb_workfn (flush-8:0)
> Call Trace:
> oom_reaper: reaped process 7789 (syz-executor613), now anon-rss:0kB,
> file-rss:0kB, shmem-rss:0kB
> rsyslogd invoked oom-killer: gfp_mask=0x6200ca(GFP_HIGHUSER_MOVABLE),
> nodemask=(null), order=0, oom_score_adj=0
> rsyslogd cpuset=/ mems_allowed=0
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
