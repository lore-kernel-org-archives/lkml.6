Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ABFC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5ED620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ViXz6D+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ED620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbeLMP4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:56:32 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55466 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeLMP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:56:32 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so4343472itg.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPAu8dEvGbRxDZCPiDjJw7RXuLAjqpVZZHAjcnPHYKg=;
        b=ViXz6D+YbP87zysWBmcPui+w3XLbrHRK6n5nhmGzCE1Z0/qeO/e43SuXvtRnqalli2
         Eqf9AmLUTUCHN5UMUPBU+a6PEQVlaaj1UTLE0wgIoLZu9gUVvc9/nHnKsTAGg9jtfWzR
         9bR9qqxmGcQL14sjspZN3O/XzKoVkHWGrhO7HKLR709ruojvocgmP4JAzNYzFISpCXM7
         DHZ7FwW4zB8bgwUsDJePw1OB56JE6MIZOq2V1B9k2peV55L3A0sq5uz2ooOG4z/mUkxc
         U8j3hh4MuESesNKqar5DZchZ0jjzxRNbHDPRPiNwcfD6w2w/ixDT9GNG5x/u4y57n3yM
         aezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPAu8dEvGbRxDZCPiDjJw7RXuLAjqpVZZHAjcnPHYKg=;
        b=D1kA56lhyxw8RMhkTr51M4tDYq0qLVwkVbSTDu5j8oRiIrLJ0a66A5CvljJcbICF5j
         31kXknC/eOrktw7qvqKn86aVlY/QFL90Vd89tdUm5V+PB6Hg7XgB1plcXVc+rQ2NEuqG
         R2UwMrvONYtO5RgMBJT2Ju2V5jFiqfmJ3nQfmDDFwHM61b9JY3baIn9nOVa0dzcgsgGv
         8oUwzowuCOWVoiiPibZZ1vPi3XZhsa31RfmWlOcvi210Wlo01NE60WLMUFew/DpvCSlY
         I3Z6KwOLl22ljK01zfqFnzRboT1ygXd/lIdDP0eRpp48Ff+crwKhHzEYE5KfVekzWtLq
         3wJg==
X-Gm-Message-State: AA+aEWY8qbdd9dCYmJzgNOGOxoklfCYIZRl+fTF/imwjqvNJZ7k/xE21
        FY/ejexTVGEbbCNrkdGsyCqaGNd1V7mE/z33ma8LSQ==
X-Google-Smtp-Source: AFSGD/XMuxfkMf2kIGIAEw3xRbrAkw9LiaRwGzGs3Xv7jVy7zCBTpxR3fGHd/Ws6WF9/XQg125pdNFdia1G8Tt6Og28=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr9404441iti.166.1544716590299;
 Thu, 13 Dec 2018 07:56:30 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000dbf4a057cd1418b@google.com> <DM5PR15MB1513AA1661B9F06198CB0C959AA00@DM5PR15MB1513.namprd15.prod.outlook.com>
 <CACT4Y+aw3rpLHprBdV2uqwtsy_m2NjwV2i0D56PJShSxNqV0rQ@mail.gmail.com> <DM5PR15MB1513DB1A65401CB9C924D2B39AA00@DM5PR15MB1513.namprd15.prod.outlook.com>
In-Reply-To: <DM5PR15MB1513DB1A65401CB9C924D2B39AA00@DM5PR15MB1513.namprd15.prod.outlook.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Dec 2018 16:56:18 +0100
Message-ID: <CACT4Y+b5Kctm3uVCm0CHvt+G2Ek2C9eOYNQHJ7rC0bgiq-4=WQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tipc_group_cong
To:     Jon Maloy <jon.maloy@ericsson.com>
Cc:     syzbot+9845fed98688e01f431e@syzkaller.appspotmail.com,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tipc-discussion@lists.sourceforge.net,
        Ying Xue <ying.xue@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 1:24 PM Jon Maloy <jon.maloy@ericsson.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Dmitry Vyukov <dvyukov@google.com>
> > Sent: 13-Dec-18 04:47
> > To: Jon Maloy <jon.maloy@ericsson.com>
> > Cc: syzbot+9845fed98688e01f431e@syzkaller.appspotmail.com; David Miller
> > <davem@davemloft.net>; LKML <linux-kernel@vger.kernel.org>; netdev
> > <netdev@vger.kernel.org>; syzkaller-bugs <syzkaller-
> > bugs@googlegroups.com>; tipc-discussion@lists.sourceforge.net; Ying Xue
> > <ying.xue@windriver.com>
> > Subject: Re: KASAN: use-after-free Read in tipc_group_cong
> >
> > On Thu, Dec 13, 2018 at 1:16 AM Jon Maloy <jon.maloy@ericsson.com>
> > wrote:
> > > > -----Original Message-----
> > > > From: syzbot
> > <syzbot+9845fed98688e01f431e@syzkaller.appspotmail.com>
> > > > Sent: 12-Dec-18 06:11
> > > > To: davem@davemloft.net; Jon Maloy <jon.maloy@ericsson.com>; linux-
> > > > kernel@vger.kernel.org; netdev@vger.kernel.org; syzkaller-
> > > > bugs@googlegroups.com; tipc-discussion@lists.sourceforge.net;
> > > > ying.xue@windriver.com
> > > > Subject: KASAN: use-after-free Read in tipc_group_cong
> > >
> > > This seems to be an effect of the same bug as reported in
> > > https://syzkaller.appspot.com/bug?extid=10a9db47c3a0e13eb31c
> >
> > Let's do
> >
> > #syz dup: KASAN: use-after-free Read in tipc_group_bc_cong
> >
> > then.
> >
> >
> > > Cong posted a fix for that one. Did you see the crash after applying his
> > patch?
> >
> > Which patch do you mean? Unfortunately kernel development process is so
> > that it's not possible to figure out what fixes what.
>
> This one:
> [Patch net] tipc: check tsk->group in tipc_wait_for_cond()

I see it includes syzbot Reported-by tag for "KASAN: use-after-free
Read in tipc_group_bc_cong". So we just wait for syzbot reaction now.



> > I would just wait for new syzbot results.
> >
> >
> >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    f5d582777bcb Merge branch 'for-linus' of
> > git://git.kernel...
> > > > git tree:       upstream
> > > > console output:
> > > > https://syzkaller.appspot.com/x/log.txt?x=1705d525400000
> > > > kernel config:
> > > > https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
> > > > dashboard link:
> > > > https://syzkaller.appspot.com/bug?extid=9845fed98688e01f431e
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=101b6ba3400000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the
> > commit:
> > > > Reported-by: syzbot+9845fed98688e01f431e@syzkaller.appspotmail.com
> > > >
> > > > 8021q: adding VLAN 0 to HW filter on device team0
> > > > 8021q: adding VLAN 0 to HW filter on device team0
> > > > audit: type=1400 audit(1544592509.246:38): avc:  denied  { associate
> > > > } for
> > > > pid=6204 comm="syz-executor5" name="syz5"
> > > > scontext=unconfined_u:object_r:unlabeled_t:s0
> > > > tcontext=system_u:object_r:unlabeled_t:s0 tclass=filesystem
> > > > permissive=1
> > > >
> > ==========================================================
> > > > ========
> > > > BUG: KASAN: use-after-free in tipc_group_find_dest
> > > > net/tipc/group.c:255 [inline]
> > > > BUG: KASAN: use-after-free in tipc_group_cong+0x566/0x5d0
> > > > net/tipc/group.c:416
> > > > Read of size 8 at addr ffff8881c59f5000 by task syz-executor4/10565
> > > >
> > > > CPU: 1 PID: 10565 Comm: syz-executor4 Not tainted 4.20.0-rc6+ #151
> > > > Hardware name: Google Google Compute Engine/Google Compute
> > Engine,
> > > > BIOS Google 01/01/2011 Call Trace:
> > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> > > >   print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
> > > >   kasan_report_error mm/kasan/report.c:354 [inline]
> > > >   kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
> > > >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> > > >   tipc_group_find_dest net/tipc/group.c:255 [inline]
> > > >   tipc_group_cong+0x566/0x5d0 net/tipc/group.c:416
> > > >   tipc_send_group_anycast+0x9bb/0xc80 net/tipc/socket.c:972
> > > >   __tipc_sendmsg+0x12b1/0x1d40 net/tipc/socket.c:1309
> > > >   tipc_sendmsg+0x50/0x70 net/tipc/socket.c:1272
> > > >   sock_sendmsg_nosec net/socket.c:621 [inline]
> > > >   sock_sendmsg+0xd5/0x120 net/socket.c:631
> > > >   ___sys_sendmsg+0x7fd/0x930 net/socket.c:2116
> > > >   __sys_sendmsg+0x11d/0x280 net/socket.c:2154
> > > >   __do_sys_sendmsg net/socket.c:2163 [inline]
> > > >   __se_sys_sendmsg net/socket.c:2161 [inline]
> > > >   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2161
> > > >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > RIP: 0033:0x457679
> > > > Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> > > > 89 f7
> > > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> > > > f0 ff ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > > RSP: 002b:00007f813d748c78 EFLAGS: 00000246 ORIG_RAX:
> > > > 000000000000002e
> > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457679
> > > > RDX: 0000000000000000 RSI: 00000000200006c0 RDI: 0000000000000005
> > > > RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f813d7496d4
> > > > R13: 00000000004c44dd R14: 00000000004d74c8 R15: 00000000ffffffff
> > > >
> > > > Allocated by task 10551:
> > > >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> > > >   set_track mm/kasan/kasan.c:460 [inline]
> > > >   kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
> > > >   kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
> > > >   kmalloc include/linux/slab.h:546 [inline]
> > > >   kzalloc include/linux/slab.h:741 [inline]
> > > >   tipc_group_create+0x152/0xa70 net/tipc/group.c:171
> > > >   tipc_sk_join net/tipc/socket.c:2829 [inline]
> > > >   tipc_setsockopt+0x2d1/0xd70 net/tipc/socket.c:2944
> > > >   __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
> > > >   __do_sys_setsockopt net/socket.c:1913 [inline]
> > > >   __se_sys_setsockopt net/socket.c:1910 [inline]
> > > >   __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
> > > >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > >
> > > > Freed by task 10567:
> > > >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> > > >   set_track mm/kasan/kasan.c:460 [inline]
> > > >   __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
> > > >   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> > > >   __cache_free mm/slab.c:3498 [inline]
> > > >   kfree+0xcf/0x230 mm/slab.c:3817
> > > >   tipc_group_delete+0x2e4/0x3f0 net/tipc/group.c:227
> > > >   tipc_sk_leave+0x113/0x220 net/tipc/socket.c:2863
> > > >   tipc_setsockopt+0x97d/0xd70 net/tipc/socket.c:2947
> > > >   __sys_setsockopt+0x1ba/0x3c0 net/socket.c:1902
> > > >   __do_sys_setsockopt net/socket.c:1913 [inline]
> > > >   __se_sys_setsockopt net/socket.c:1910 [inline]
> > > >   __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1910
> > > >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> > > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > >
> > > > The buggy address belongs to the object at ffff8881c59f5000
> > > >   which belongs to the cache kmalloc-192 of size 192 The buggy
> > > > address is located 0 bytes inside of
> > > >   192-byte region [ffff8881c59f5000, ffff8881c59f50c0) The buggy
> > > > address belongs to the page:
> > > > page:ffffea0007167d40 count:1 mapcount:0 mapping:ffff8881da800040
> > > > index:0x0
> > > > flags: 0x2fffc0000000200(slab)
> > > > raw: 02fffc0000000200 ffffea0007160488 ffffea00071aff08
> > > > ffff8881da800040
> > > > raw: 0000000000000000 ffff8881c59f5000 0000000100000010
> > > > 0000000000000000 page dumped because: kasan: bad access detected
> > > >
> > > > Memory state around the buggy address:
> > > >   ffff8881c59f4f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > >   ffff8881c59f4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > > > ffff8881c59f5000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >                     ^
> > > >   ffff8881c59f5080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > > >   ffff8881c59f5100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >
> > ==========================================================
> > > > ========
> > > >
> > > >
> > > > ---
> > > > This bug is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this bug report. See:
> > > > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate
> > > > with syzbot.
> > > > syzbot can test patches for this bug, for details see:
> > > > https://goo.gl/tpsmEJ#testing-patches
> > >
> > > --
> > > You received this message because you are subscribed to the Google
> > Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an
> > email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/syzkaller-
> > bugs/DM5PR15MB1513AA1661B9F06198CB0C959AA00%40DM5PR15MB1513.
> > namprd15.prod.outlook.com.
> > > For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/DM5PR15MB1513DB1A65401CB9C924D2B39AA00%40DM5PR15MB1513.namprd15.prod.outlook.com.
> For more options, visit https://groups.google.com/d/optout.
