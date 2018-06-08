Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id r4t7C3+GGluSegAAmS7hNA
	; Fri, 08 Jun 2018 13:37:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 76E61608B8; Fri,  8 Jun 2018 13:37:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EReX0McQ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C2B08607DC;
	Fri,  8 Jun 2018 13:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2B08607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFHNg7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:36:59 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41177 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeFHNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:36:57 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so8341219plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TU9bsZcLF9Jww4G0zNWf/69CizzLZxM/Lvm2LFDcYOQ=;
        b=EReX0McQ2+AE8TS8idBPlAB+ANkPJqCOxyhq8ksu4cNHWa0FMgN9eS3QKUukmWK5w1
         OpgApsfLAPIqzLWiVlaulUvOw6MQqSX5S4i5mDfO1EC3jBnCJbbRxfTuFUDM9aGWICJI
         Oc8ptUzDHQcMBidoW1K0cBpDyORj0W5GsNnuVZBcBWvn4fMwHNUAFUY9GDKWKlkcmQzS
         /sbeALZ5TNK9ZSLvYZESRLZpXeo/e86V1tvqL6+tQ2cHPxw8tWOuiRT/3WhEibNCUqFR
         0ieRajwFgj6c4H75o7Zp9NVhtTSXliIwf4RSipXfhHiJ4EkI81mMn4Ihm6PArQbDqDwH
         xd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TU9bsZcLF9Jww4G0zNWf/69CizzLZxM/Lvm2LFDcYOQ=;
        b=mrWWRP5K0zK3DDFTW9krx+y7IRwOdoSBTnfk1WPSnh9SU7JRElJM2UCHFGXYt7vlfa
         dooIGscJz1Jf8p+gp8oKxCK753hvqMIGOR7lCbLCs2GPp+ExlfbG3D1gtUHfmBDDiVJy
         Tgx8DB2i9DZKV/S9KbfXubiPf40BleSXafLUvNlaPJyhRNr2vkzKTRw/qitK/W/QSYnT
         cYXyxJMuQ6FjXDwRKxkcAtQ+smgFQI8mEA/ROC2MsNQlmaR1iZFwu+BWz/DisQS0Plad
         Z/V+vHIqvM7cD5c1FGMczN9nadLV7rFQITqp84hbWCDIUKc2fxOxaPmBBBE4p4OiZrF9
         6FDQ==
X-Gm-Message-State: APt69E0z+QAQEpDfACLoAhKsZGaQxE2S3eCYXCGhlqe/qXYBOGBbKk7C
        1Gc3ld6b59BSsYMboAMnxBepajj26+BwAbAaIJfvYA==
X-Google-Smtp-Source: ADUXVKJYpqy6AX2nbtAXsv0ce/Vyea8rq92uLbe8o05qsYx6xM+kjRLitNZedfA0HmTzIefMkI393nyKIGsoZsloSQQ=
X-Received: by 2002:a17:902:8d85:: with SMTP id v5-v6mr6706336plo.93.1528465016845;
 Fri, 08 Jun 2018 06:36:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Fri, 8 Jun 2018 06:36:36
 -0700 (PDT)
In-Reply-To: <000000000000c109af056e2121a4@google.com>
References: <000000000000c109af056e2121a4@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 8 Jun 2018 15:36:36 +0200
Message-ID: <CACT4Y+Zt7WEnnY4H+XC+DasLHRcgSF6V9f373N0LA-c7WcG4YA@mail.gmail.com>
Subject: Re: general protection fault in pipe_write
To: syzbot <syzbot+772c951c5f15d2f1df03@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 3:11 PM, syzbot
<syzbot+772c951c5f15d2f1df03@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    7170e6045a6a strparser: Add __strp_unpause and use it in k..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b5c8cf800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a601a80fec461d44
> dashboard link: https://syzkaller.appspot.com/bug?extid=772c951c5f15d2f1df03
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13ad0b6f800000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+772c951c5f15d2f1df03@syzkaller.appspotmail.com

This seems to be same as the splash of other crashes in bpfilter:

#syz fix: bpfilter: fix race in pipe access


> 8021q: adding VLAN 0 to HW filter on device team0
> 8021q: adding VLAN 0 to HW filter on device team0
> bpfilter: read fail -512
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 1 PID: 6572 Comm: syz-executor5 Not tainted 4.17.0-rc7+ #82
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:pipe_write+0xa49/0xeb0 fs/pipe.c:480
> RSP: 0000:ffff8801ac6b7858 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c22b3b
> RDX: 0000000000000005 RSI: ffffffff81c22b49 RDI: 0000000000000028
> RBP: ffff8801ac6b78d8 R08: ffff8801b3796080 R09: 0000000000000006
> R10: ffff8801b3796080 R11: 0000000000000000 R12: ffff8801cdbaa820
> R13: ffff8801cdb31a40 R14: 0000000000000000 R15: dffffc0000000000
> FS:  00007fe12b0e9700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fe01b0f9af0 CR3: 00000001c43e7000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  call_write_iter include/linux/fs.h:1784 [inline]
>  new_sync_write fs/read_write.c:474 [inline]
>  __vfs_write+0x64d/0x960 fs/read_write.c:487
>  __kernel_write+0x10c/0x380 fs/read_write.c:506
>  __bpfilter_process_sockopt+0x1d8/0x35b net/bpfilter/bpfilter_kern.c:66
>  bpfilter_mbox_request+0x4d/0xb0 net/ipv4/bpfilter/sockopt.c:25
>  bpfilter_ip_set_sockopt+0x33/0x40 net/ipv4/bpfilter/sockopt.c:31
>  ip_setsockopt+0x124/0x140 net/ipv4/ip_sockglue.c:1250
>  raw_setsockopt+0xe2/0x100 net/ipv4/raw.c:868
>  sock_common_setsockopt+0x9a/0xe0 net/core/sock.c:3059
>  __sys_setsockopt+0x1bd/0x390 net/socket.c:1903
>  __do_sys_setsockopt net/socket.c:1914 [inline]
>  __se_sys_setsockopt net/socket.c:1911 [inline]
>  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:1911
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4559f9
> RSP: 002b:00007fe12b0e8c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> RAX: ffffffffffffffda RBX: 00007fe12b0e96d4 RCX: 00000000004559f9
> RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 000000000072bf50 R08: 0000000000000370 R09: 0000000000000000
> R10: 00000000200003c0 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004c0d8b R14: 00000000004d0828 R15: 0000000000000001
> Code: 48 c1 ea 03 80 3c 02 00 0f 85 fc 03 00 00 48 8b 45 c8 48 8b 58 20 48
> b8 00 00 00 00 00 fc ff df 48 8d 7b 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f
> 85 ef 03 00 00 48 8b 7b 28 31 d2 be 01 00 00 00
> RIP: pipe_write+0xa49/0xeb0 fs/pipe.c:480 RSP: ffff8801ac6b7858
> ---[ end trace 7e44f4b8135e2e72 ]---
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c109af056e2121a4%40google.com.
> For more options, visit https://groups.google.com/d/optout.
