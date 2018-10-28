Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F93C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0312082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 17:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyi8XQtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0312082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJ2Civ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 22:38:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34571 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJ2Civ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 22:38:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so3623703qkg.1;
        Sun, 28 Oct 2018 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4w8Il7hvMIBZ4QnYnQUfmonHHza2krN5vv1/C3g+XsQ=;
        b=Nyi8XQtjgIjHJHJ/hU2sd3DEkf2MZFM80aopWfaT/KjhPXlkyuOZXv3Zt0a4nigQMy
         4OrOYDvygPUSks0D1Ut+L8v4a78yprDFOBfjrlIJg9w0V81s/MjzGNSPEAxldNqsHfSR
         rNyeN8Aj1hrp0eICagEwNvV+JmQpUqlFpI/vDbLr8Xq6gNAqTMi+mkwIS3mII9rAFd58
         w01+YobjGrBAHOpTScPlPy617HKJejm1ckLkuAeIRtNjDhQ/1RGrZoRljbhOxHwr1r81
         YKh6xXP5xKPE8/9UuVpe7zFF0b/AzOJhoPREqgUBJvfwHTxk/asvExzMFPwzrqCQVL6P
         VECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4w8Il7hvMIBZ4QnYnQUfmonHHza2krN5vv1/C3g+XsQ=;
        b=M2FszkZUykdcCR7bIEUSvQm7OdVYCbqCdVabpLtwgjsTMZN973aRDHABdQCZScep3n
         eChN1lLo6Y8TqBzm4JYf1Tee4m0Dx1xZu7m6L1cTNWUar9FI4z/P9ZzYkjQ3B6tjrQMi
         PDAMuSlISojDCycimlvp9JK+KOjCunem5ULOHOiNllbGUyM8pmRtf5khqGOiW0TNomfn
         tWRxEUsAP1mQ3UOLyFEsN/a9KqpgjArNEqwBnVVOBbx8ZsdkOV7vMJAredxlnngyhslI
         +uL9vZDUYxDj5V0YBen7wKRVOTyB7Pe4JeQIOSXY29UL/dqTKxbfnHWzUyYsJBE5QV5h
         3lZw==
X-Gm-Message-State: AGRZ1gKB3FDnN+/DCeuFDHV+YxOLL7OZgHurkJ2YV+RvPUqatBwhHOsc
        d01B15iqmLKjbY/uEBej1lKCQ9f4
X-Google-Smtp-Source: AJdET5f5R25iN+HecL9zsfgrg/t+rRLWbiAkZkCGO9TGVqwwBOTTyCyQd2rNkw15F0ZX0YabhjojFw==
X-Received: by 2002:a37:9ce:: with SMTP id 197mr7258330qkj.164.1540749209329;
        Sun, 28 Oct 2018 10:53:29 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.92])
        by smtp.gmail.com with ESMTPSA id g46-v6sm2194908qta.79.2018.10.28.10.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 10:53:28 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 9C17D180F5A; Sun, 28 Oct 2018 14:53:25 -0300 (-03)
Date:   Sun, 28 Oct 2018 14:53:25 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzkaller-bugs@googlegroups.com,
        Vlad Yasevich <vyasevich@gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in sctp_getsockopt
Message-ID: <20181028175325.GQ6634@localhost.localdomain>
References: <000000000000e80c930579245751@google.com>
 <CADvbK_fK4jyPXA+ZJUtAFOjRcunqX0XdiEC2nZbnLMVxiJCAmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_fK4jyPXA+ZJUtAFOjRcunqX0XdiEC2nZbnLMVxiJCAmw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 02:58:33PM +0900, Xin Long wrote:
> On Sat, Oct 27, 2018 at 1:38 AM syzbot
> <syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    bd6bf7c10484 Merge tag 'pci-v4.20-changes' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16fd6bcb400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2dd8629d56664133
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5da0d0a72a9e7d791748
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b3ea33400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f9f1bd400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+5da0d0a72a9e7d791748@syzkaller.appspotmail.com
> >
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in sctp_getsockopt_pr_streamstatus
> > net/sctp/socket.c:7174 [inline]
> Forgot to change to use "&" in sctp_getsockopt_pr_streamstatus() in
> "sctp: get pr_assoc and pr_stream all status with SCTP_PR_SCTP_ALL instead"
> 
> @@ -7158,7 +7158,7 @@ static int
> sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
>                 goto out;
>         }
> 
> -       if (policy == SCTP_PR_SCTP_ALL) {
> +       if (policy & SCTP_PR_SCTP_ALL) {

Hmmm. This is trying to avoid the
   streamoute->abandoned_unsent[__SCTP_PR_INDEX(policy)]
with possibly large 'policy' as policy may be SCTP_PR_SCTP_ALL | SCTP_PR_SCTP_MASK

That said, I don't think this is a good fix because the input
parameter was bogus and we would be trying to make some sense out of
it. So I suggest something along these lines:

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index fc0386e8ff23..b816956c69f5 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7144,6 +7144,8 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 	policy = params.sprstat_policy;
 	if (!policy || (policy & ~(SCTP_PR_SCTP_MASK | SCTP_PR_SCTP_ALL)))
 		goto out;
+	if (policy & SCTP_PR_SCTP_ALL && policy & ~SCTP_PR_SCTP_ALL)
+		goto out;
 
 	asoc = sctp_id2assoc(sk, params.sprstat_assoc_id);
 	if (!asoc || params.sprstat_sid >= asoc->stream.outcnt)

To bail out if ALL is specificied together with anything else.
(the if condition probably could be optimized somehow)

> 
> > BUG: KASAN: slab-out-of-bounds in sctp_getsockopt+0x7516/0x7cc2
> > net/sctp/socket.c:7582
> > Read of size 8 at addr ffff8801d89f0968 by task syz-executor278/5330
> >
> > CPU: 1 PID: 5330 Comm: syz-executor278 Not tainted 4.19.0+ #303
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x244/0x39d lib/dump_stack.c:113
> >   print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
> >   kasan_report_error mm/kasan/report.c:354 [inline]
> >   kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
> >   __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
> >   sctp_getsockopt_pr_streamstatus net/sctp/socket.c:7174 [inline]
> >   sctp_getsockopt+0x7516/0x7cc2 net/sctp/socket.c:7582
> >   sock_common_getsockopt+0x9a/0xe0 net/core/sock.c:2937
> >   __sys_getsockopt+0x1ad/0x390 net/socket.c:1939
> >   __do_sys_getsockopt net/socket.c:1950 [inline]
> >   __se_sys_getsockopt net/socket.c:1947 [inline]
> >   __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1947
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x445789
> > Code: e8 6c b6 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007effdb293db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
> > RAX: ffffffffffffffda RBX: 00000000006dac48 RCX: 0000000000445789
> > RDX: 0000000000000074 RSI: 0000000000000084 RDI: 0000000000000003
> > RBP: 00000000006dac40 R08: 0000000020000040 R09: 0000000000000000
> > R10: 0000000020000080 R11: 0000000000000246 R12: 00000000006dac4c
> > R13: 00007ffcfc408c6f R14: 00007effdb2949c0 R15: 00000000006dad2c
> >
> > Allocated by task 5329:
> >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >   set_track mm/kasan/kasan.c:460 [inline]
> >   kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
> >   kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
> >   kmalloc include/linux/slab.h:513 [inline]
> >   kzalloc include/linux/slab.h:707 [inline]
> >   sctp_stream_init_ext+0x4f/0xf0 net/sctp/stream.c:237
> >   sctp_sendmsg_to_asoc+0x1308/0x1a20 net/sctp/socket.c:1896
> >   sctp_sendmsg+0x13c2/0x1da0 net/sctp/socket.c:2113
> >   inet_sendmsg+0x1a1/0x690 net/ipv4/af_inet.c:798
> >   sock_sendmsg_nosec net/socket.c:621 [inline]
> >   sock_sendmsg+0xd5/0x120 net/socket.c:631
> >   __sys_sendto+0x3d7/0x670 net/socket.c:1788
> >   __do_sys_sendto net/socket.c:1800 [inline]
> >   __se_sys_sendto net/socket.c:1796 [inline]
> >   __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1796
> >   do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 3223:
> >   save_stack+0x43/0xd0 mm/kasan/kasan.c:448
> >   set_track mm/kasan/kasan.c:460 [inline]
> >   __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
> >   kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
> >   __cache_free mm/slab.c:3498 [inline]
> >   kfree+0xcf/0x230 mm/slab.c:3813
> >   kzfree+0x28/0x30 mm/slab_common.c:1543
> >   aa_free_file_ctx security/apparmor/include/file.h:76 [inline]
> >   apparmor_file_free_security+0x133/0x1a0 security/apparmor/lsm.c:448
> >   security_file_free+0x4a/0x80 security/security.c:900
> >   file_free fs/file_table.c:54 [inline]
> >   __fput+0x4e8/0xa30 fs/file_table.c:294
> >   ____fput+0x15/0x20 fs/file_table.c:309
> >   task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
> >   tracehook_notify_resume include/linux/tracehook.h:188 [inline]
> >   exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
> >   prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
> >   syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
> >   do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > The buggy address belongs to the object at ffff8801d89f0900
> >   which belongs to the cache kmalloc-96 of size 96
> > The buggy address is located 8 bytes to the right of
> >   96-byte region [ffff8801d89f0900, ffff8801d89f0960)
> > The buggy address belongs to the page:
> > page:ffffea0007627c00 count:1 mapcount:0 mapping:ffff8801da8004c0 index:0x0
> > flags: 0x2fffc0000000100(slab)
> > raw: 02fffc0000000100 ffffea0007646748 ffffea0007613488 ffff8801da8004c0
> > raw: 0000000000000000 ffff8801d89f0000 0000000100000020 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff8801d89f0800: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >   ffff8801d89f0880: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > ffff8801d89f0900: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> >                                                            ^
> >   ffff8801d89f0980: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >   ffff8801d89f0a00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > ==================================================================
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> > syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
