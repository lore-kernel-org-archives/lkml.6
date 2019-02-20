Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9921908
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfBTMdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:33:05 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:38418 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfBTMdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:33:04 -0500
Received: by mail-it1-f199.google.com with SMTP id r136so10503812ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LE7K7aUJYPsZzqZuSauK5S+BXkIVHxJgNdyyEeOBMmE=;
        b=QII9ea2y34LdWSHn8P5YESI8Ev1ZFe6bq0PT4GOQEvw9nlvuv8Y1jOjFm5tfIt3m6Y
         hXZGZyjbCyFxh5NDQCRx/w2upC9Vz2nIUYvYHS6BJEDtHb6Ek7sEMamUPwUfS4ATLHx4
         P6n+HbaU4HdbQGTOGUBA2NE7ppk0DBMzRxaHOlVGw+i0t3oqGs1G+crjgEDdBK917eK2
         lbFToyC1EACkLk3bCJBCxfs1CT7Ntlog03uafH++WG8zT23CQxv+gsAV1CG6FjHkvnte
         ruYkixvPFwAPcMudflHkXBSniV3Xu6WtMrkx1ZPzOzlMRaXR5grLvgOTGRDnfUhlZr/p
         kRdQ==
X-Gm-Message-State: AHQUAuZFOcocdIJ5Hxs0nInX+nof0auWxJyHIn/ju8ZpuIL+jA+tzWUg
        neSqF5LIMcjz4EgQChctpQSzbJs4NemWq0Dqoa5J73aPoas2
X-Google-Smtp-Source: AHgI3IZfG6iP8BmynGwtpTAYxUafQ0AaQgBTYd7W5Gg6zehoK94hCrRSf87O6NLxobYLckcWwbMT5d4AT3eoaKykN+tW1ikugLsP
MIME-Version: 1.0
X-Received: by 2002:a5d:914f:: with SMTP id y15mr8028264ioq.18.1550665983970;
 Wed, 20 Feb 2019 04:33:03 -0800 (PST)
Date:   Wed, 20 Feb 2019 04:33:03 -0800
In-Reply-To: <000000000000cedfe1058250076c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023d3080582528fad@google.com>
Subject: Re: BUG: assuming atomic context at kernel/seccomp.c:LINE
From:   syzbot <syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    abf446c90405 Add linux-next specific files for 20190220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=101e7fb0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=463cb576ac40e350
dashboard link: https://syzkaller.appspot.com/bug?extid=8bf19ee2aa580de7a2a7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a52778c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1007cc00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8bf19ee2aa580de7a2a7@syzkaller.appspotmail.com

BUG: assuming atomic context at kernel/seccomp.c:271
in_atomic(): 0, irqs_disabled(): 0, pid: 7853, name: syz-executor140
no locks held by syz-executor140/7853.
CPU: 1 PID: 7853 Comm: syz-executor140 Not tainted 5.0.0-rc7-next-20190220  
#39
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __cant_sleep kernel/sched/core.c:6218 [inline]
  __cant_sleep.cold+0xa3/0xbb kernel/sched/core.c:6195
  seccomp_run_filters kernel/seccomp.c:271 [inline]
  __seccomp_filter+0x12b/0x12b0 kernel/seccomp.c:801
  __secure_computing+0x101/0x360 kernel/seccomp.c:932
  syscall_trace_enter+0x5bf/0xe10 arch/x86/entry/common.c:120
  do_syscall_64+0x479/0x610 arch/x86/entry/common.c:280
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x43ec58
Code: 00 00 be 3c 00 00 00 eb 19 66 0f 1f 84 00 00 00 00 00 48 89 d7 89 f0  
0f 05 48 3d 00 f0 ff ff 77 21 f4 48 89 d7 44 89 c0 0f 05 <48> 3d 00 f0 ff  
ff 76 e0 f7 d8 64 41 89 01 eb d8 0f 1f 84 00 00 00
RSP: 002b:00007ffc2d0b2f48 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043ec58
RDX: 0000000000000000 RSI: 0000000

