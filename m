Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFF8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5DB2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 20:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nl8+HJRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5DB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeKQGzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:55:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52370 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 01:55:14 -0500
Received: by mail-it1-f193.google.com with SMTP id t190-v6so36770536itb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 12:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tRsJsiCJc6GHz0rUwaofZuLWJHyfeu8YwRwz9cISpoo=;
        b=Nl8+HJRgtYhQVTdqwJt4JPtGoFUXhkfdLqF/xZobQHrqnUgrkJyHFT2iZ9bBTx9DU9
         tlOdtSIsYzLprlpneS+Y5+zpJ09+JpAFX89mOjQPLKH/r+OfN6M7xRMoPQX2f+o9nRCV
         FMmnhzkrWgFz3ZJaR5+gvoLiRbsKBLBH/7Gk1LiFl4PXNg2WXZ55zztTjVf05Qi+geJ/
         p1h5OMLdHbGolcLqjhu2zcLF1bWUZZV6wExYWgu5SNgHKtziPzkz6ouOnli26whaR7GB
         5iRRrux8DQRcPNl2rtciW1IyLIlkvjr0DdjnFPs/7U2YvglaYRDdbeAyfWfyM5LkpKhq
         TjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tRsJsiCJc6GHz0rUwaofZuLWJHyfeu8YwRwz9cISpoo=;
        b=q12wcVq84VBiCp3XlUQ/5HX1wk0osmxubZxSYEyQeKo4IAwDKehrUmZDO/nYDfQ5eS
         Qu6L1pI8CVAzvFTMCkfum9njgGILYcOW5VroAu8zo8A8Wv15u6A8kjPnhrkjwLWIGD3g
         YK5qy8hUk74Qz+yb+7yYqlmv9PCiURXb53XJNHIWKJssp0UqD4JQpSRDFUv9EFYvhorh
         5gs+pCtD1fN3LgzoEi5EVKYk6Vc6LbrOA5BqDT3IMT8mLSvNXjlqL09DnRC1oILZ2M85
         VhF/pIc4WUtS+Atbi80HzPbI2U2ez2VmbJ8HglRVNpuUsmZjd95kJaUzvypddJkO9y9V
         zG4w==
X-Gm-Message-State: AGRZ1gJ+xfX9fBara6oHLTO0I8YvDdEo6sH/no428oZHyeLbEErJ3Eqj
        7VfqL6VSD3QcGU+5mZOTjM8RSJJtGbEYQnMmDeKwow==
X-Google-Smtp-Source: AJdET5fG4CH1M3SeoZo2VtgCqSau+B3vnZfC/TJMtsdXs9lFah0Nd2Bjxe7i0aW5x032/3iYKbob5o7H21nRu/15mq0=
X-Received: by 2002:a24:940f:: with SMTP id j15-v6mr11384154ite.12.1542400878519;
 Fri, 16 Nov 2018 12:41:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 16 Nov 2018 12:40:58
 -0800 (PST)
In-Reply-To: <00000000000082cc8d057a0c0877@google.com>
References: <00000000000082cc8d057a0c0877@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 16 Nov 2018 12:40:58 -0800
Message-ID: <CACT4Y+Zh4GmqecF0ftBjGUg0Zvi2Gto7QLzFcDe_+LGASxX5BQ@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in locks_remove_flock
To:     syzbot <syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:03 PM, syzbot
<syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d881de30d29e Add linux-next specific files for 20181107
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14aa485d400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caa433e1c8778437
> dashboard link: https://syzkaller.appspot.com/bug?extid=1818cd833edc063452c6
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+1818cd833edc063452c6@syzkaller.appspotmail.com

This is another manifestation of the following report, right?

#syz dup: KASAN: use-after-free Read in locks_delete_block

> ==================================================================
> BUG: KASAN: stack-out-of-bounds in locks_remove_flock+0x33c/0x350
> fs/locks.c:2567
> Read of size 8 at addr ffff8801c71c7a08 by task syz-executor5/20562
>
> CPU: 0 PID: 20562 Comm: syz-executor5 Not tainted 4.20.0-rc1-next-20181107+
> #107
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x244/0x39d lib/dump_stack.c:113
>  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  locks_remove_flock+0x33c/0x350 fs/locks.c:2567
>  locks_remove_file+0x148/0x5c0 fs/locks.c:2607
>  __fput+0x2f0/0xa70 fs/file_table.c:271
>  ____fput+0x15/0x20 fs/file_table.c:312
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x411021
> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3 48
> 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89
> c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
> RSP: 002b:00007ffdb42509a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000411021
> RDX: 0000000000000000 RSI: 0000000000732ea0 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffdb42508c0 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000001 R14: 0000000000000201 R15: 0000000000000005
>
> The buggy address belongs to the page:
> page:ffffea00071c71c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> flags: 0x2fffc0000000000()
> raw: 02fffc0000000000 0000000000000000 ffffffff071c0101 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801c71c7900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8801c71c7980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>> ffff8801c71c7a00: f2 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>                       ^
>  ffff8801c71c7a80: 00 f1 f1 f1 f1 00 00 f2 f2 f2 f2 f2 f2 f8 f2 f2
>  ffff8801c71c7b00: f2 f2 f2 f2 f2 00 f2 f2 f2 00 00 00 00 00 00 00
> ==================================================================
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/00000000000082cc8d057a0c0877%40google.com.
> For more options, visit https://groups.google.com/d/optout.
