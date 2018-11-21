Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368CCC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA766214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQOdZmdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA766214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbeKVE1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:27:19 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35190 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732631AbeKVE1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:27:18 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so10156302itj.0;
        Wed, 21 Nov 2018 09:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juP00LESCzOeh85tb9TNe4Jmuz8/nk9/j0NF7EpQkDM=;
        b=gQOdZmdM1bFZgjEOv7asJidmePKL9Q4intkn+gJYjmQ20LlVIIGhWBElk63lEpgrKl
         MZgQWT6am7JOFtJdkLfz15XV3u52sOjQvU5TIywWI0vyS88ame5rbSWtUEc8HNix4zjp
         cjRyGwBsEiQarx3cp5DlwcHmxMlzqOUB+u5CORuAxU3UAhnAZe7q4thOWUYkRgEbqTJV
         L/RZPeVh2LacXoK4U+S4AOdkXbggWVUSsusEyL6b1zRU/lOC5BML2ezo2TUA0d+EACB/
         Qi1Kq9G/33muWM4pfDxO72+NPnqUKX2chY17E7Zvr5+C0CQXYLji4Ls4HBzfC3WWFl3m
         2XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juP00LESCzOeh85tb9TNe4Jmuz8/nk9/j0NF7EpQkDM=;
        b=F24RBNnL+nO8dsGcau1KzrWZbmFIa48HYYEpvxuf6ZnakJPrAqA94Zjq0vIiaDa2f7
         faWIzzgfYt/P9N5O7IOnEdpAQrviUO3L5P5I+y7Q1Kj8MgDSoJkgFlakkCXBz1lswhm2
         4RRPjThvMwwZPHJC1ou6uEf/0MhLjucvcdPuwCdNu8d4tCoZ/c4+J5ISTSYiN4jPunMZ
         rT19tMphNxjqwq3sQM6E2UbK0fUTRY7Np96BJjZnEsv91mr04CUQtqk3Z1VLLWXfhEk2
         LJoEaHlbQJ664jeqFljOVjEz3rP3TmgbkHQ+9y4w61lQnbc75+0JGL3kZFQAF+tbtVHx
         L+XA==
X-Gm-Message-State: AA+aEWaRDTiewbWCcyg+idC6rtaIsLHCafAao9RTVsnpO5p/4eY4fyhp
        F0ik0HMpKqnTtfNiXaPhd3tDZ/uuRB2Ht9NMq+JrFjTR
X-Google-Smtp-Source: AJdET5f/gbpLxSesb1sZH3YUJPQ0BkM9Q7/uCwZAtplimL4ye7tr/TzjUCT3s8KfDzUo+kAqRqw3+PeUiQTtRziRAxA=
X-Received: by 2002:a02:1509:: with SMTP id j9mr6774410jad.5.1542822715785;
 Wed, 21 Nov 2018 09:51:55 -0800 (PST)
MIME-Version: 1.0
References: <00000000000014c430057b252d70@google.com>
In-Reply-To: <00000000000014c430057b252d70@google.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 22 Nov 2018 02:51:44 +0900
Message-ID: <CADvbK_cZ74Sh60V8M2-=VMqi13Hq4PLjfo84+CJkez6-jxuzFg@mail.gmail.com>
Subject: Re: general protection fault in sctp_sched_dequeue_common
To:     syzbot+e33a3a138267ca119c7d@syzkaller.appspotmail.com
Cc:     davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs@googlegroups.com,
        Vlad Yasevich <vyasevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 1:30 PM syzbot
<syzbot+e33a3a138267ca119c7d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    cfc6731d2f79 Merge branch 'sctp-add-subscribe-per-asoc-and..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14fc234d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
> dashboard link: https://syzkaller.appspot.com/bug?extid=e33a3a138267ca119c7d
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+e33a3a138267ca119c7d@syzkaller.appspotmail.com
>
> netlink: 'syz-executor1': attribute type 39 has an invalid length.
> IPv6: ADDRCONF(NETDEV_CHANGE): lo: link becomes ready
> A link change request failed with some changes committed already. Interface
> lo may have been left with an inconsistent configuration, please check.
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 4030 Comm: syz-executor5 Not tainted 4.20.0-rc3+ #304
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:__list_del_entry_valid+0x84/0x100 lib/list_debug.c:51
> Code: 0f 84 60 01 00 00 48 b8 00 02 00 00 00 00 ad de 49 39 c4 0f 84 39 01
> 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75
> 5f 49 8b 14 24 48 39 da 0f 85 4e 01 00 00 49 8d 7d
> RSP: 0018:ffff8881c1bfea48 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8881bb175618 RCX: ffffc9001006b000
> RDX: 0000000000000000 RSI: ffffffff8752c823 RDI: ffff8881bb175620
> RBP: ffff8881c1bfea60 R08: ffff88818dc04200 R09: ffff8881c1bff488
> R10: ffffed103837feb6 R11: 0000000000000003 R12: 0000000000000000
> R13: 0000000000000000 R14: ffff8881cb4d8e20 R15: dffffc0000000000
> FS:  00007f34b0944700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000ae0ed0 CR3: 00000001cb898000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   __list_del_entry include/linux/list.h:117 [inline]
>   list_del_init include/linux/list.h:159 [inline]
>   sctp_sched_dequeue_common+0xab/0x610 net/sctp/stream_sched.c:267
>   sctp_sched_fcfs_dequeue+0x18d/0x280 net/sctp/stream_sched.c:90
This probably is also caused by stream->out_curr not being updated
when adding stream_out. we need a fix like:

+static void sctp_stream_out_copy(struct flex_array *fa,
+                                struct sctp_stream *stream, __u16 count)
+{
+       size_t index = 0;
+       void *elem;
+
+       count = min(count, stream->outcnt);
+       while (count--) {
+               elem = flex_array_get(stream->out, index);
+               flex_array_put(fa, index, elem, 0);
+               if (stream->out_curr == elem)
+                       stream->out_curr = flex_array_get(fa, index);
+               index++;
+       }
+}
+
 static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
                                 gfp_t gfp)
 {
@@ -146,7 +164,7 @@ static int sctp_stream_alloc_out(struct
sctp_stream *stream, __u16 outcnt,
                return -ENOMEM;

        if (stream->out) {
-               fa_copy(out, stream->out, 0, min(outcnt, stream->outcnt));
+               sctp_stream_out_copy(out, stream, outcnt);
                fa_free(stream->out);
        }


>   sctp_outq_dequeue_data net/sctp/outqueue.c:90 [inline]
>   sctp_outq_flush_data net/sctp/outqueue.c:1079 [inline]
>   sctp_outq_flush+0x13e2/0x34f0 net/sctp/outqueue.c:1205
>   sctp_outq_uncork+0x6a/0x80 net/sctp/outqueue.c:772
>   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1820 [inline]
>   sctp_side_effects net/sctp/sm_sideeffect.c:1220 [inline]
>   sctp_do_sm+0x5ff/0x7180 net/sctp/sm_sideeffect.c:1191
>   sctp_primitive_SEND+0xa0/0xd0 net/sctp/primitive.c:178
>   sctp_sendmsg_to_asoc+0xa0b/0x1a10 net/sctp/socket.c:1955
>   sctp_sendmsg+0x13c2/0x1da0 net/sctp/socket.c:2113
>   inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
>   sock_sendmsg_nosec net/socket.c:621 [inline]
>   sock_sendmsg+0xd5/0x120 net/socket.c:631
>   sock_write_iter+0x35e/0x5c0 net/socket.c:900
>   call_write_iter include/linux/fs.h:1857 [inline]
>   new_sync_write fs/read_write.c:474 [inline]
>   __vfs_write+0x6b8/0x9f0 fs/read_write.c:487
>   vfs_write+0x1fc/0x560 fs/read_write.c:549
>   ksys_write+0x101/0x260 fs/read_write.c:598
>   __do_sys_write fs/read_write.c:610 [inline]
>   __se_sys_write fs/read_write.c:607 [inline]
>   __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x457569
> Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f34b0943c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
> RDX: 0000000000034000 RSI: 0000000020000040 RDI: 0000000000000005
> RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f34b09446d4
> R13: 00000000004c5cde R14: 00000000004da090 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 23757f22491d2e93 ]---
> RIP: 0010:__list_del_entry_valid+0x84/0x100 lib/list_debug.c:51
> Code: 0f 84 60 01 00 00 48 b8 00 02 00 00 00 00 ad de 49 39 c4 0f 84 39 01
> 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75
> 5f 49 8b 14 24 48 39 da 0f 85 4e 01 00 00 49 8d 7d
> kobject: 'loop0' (00000000e65c44e1): kobject_uevent_env
> kobject: 'loop0' (00000000e65c44e1): fill_kobj_path: path
> = '/devices/virtual/block/loop0'
> RSP: 0018:ffff8881c1bfea48 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: ffff8881bb175618 RCX: ffffc9001006b000
> kobject: 'rx-0' (000000005994716d): kobject_cleanup, parent 00000000ba7aa131
> RDX: 0000000000000000 RSI: ffffffff8752c823 RDI: ffff8881bb175620
> kobject: 'loop4' (000000004d250bad): kobject_uevent_env
> kobject: 'rx-0' (000000005994716d): auto cleanup 'remove' event
> kobject: 'loop4' (000000004d250bad): fill_kobj_path: path
> = '/devices/virtual/block/loop4'
> kobject: 'rx-0' (000000005994716d): kobject_uevent_env
> RBP: ffff8881c1bfea60 R08: ffff88818dc04200 R09: ffff8881c1bff488
> R10: ffffed103837feb6 R11: 0000000000000003 R12: 0000000000000000
> kobject: 'rx-0' (000000005994716d): kobject_uevent_env: uevent_suppress
> caused the event to drop!
> R13: 0000000000000000 R14: ffff8881cb4d8e20 R15: dffffc0000000000
> kobject: 'rx-0' (000000005994716d): auto cleanup kobject_del
> FS:  00007f34b0944700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
> kobject: 'rx-0' (000000005994716d): calling ktype release
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000072c000 CR3: 00000001cb898000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> kobject: 'rx-0': free name
> kobject: 'loop0' (00000000e65c44e1): kobject_uevent_env
> kobject: 'tx-3' (00000000a24965cd): kobject_cleanup, parent 00000000ba7aa131
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> kobject: 'tx-3' (00000000a24965cd): auto cleanup 'remove' event
> kobject: 'loop0' (00000000e65c44e1): fill_kobj_path: path
> = '/devices/virtual/block/loop0'
> kobject: 'tx-3' (00000000a24965cd): kobject_uevent_env
> kobject: 'tx-3' (00000000a24965cd): kobject_uevent_env: uevent_suppress
> caused the event to drop!
> kobject: 'tx-3' (00000000a24965cd): auto cleanup kobject_del
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
