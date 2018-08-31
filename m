Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CD520839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CD520839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHaFaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:30:00 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:56057 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeHaF37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:29:59 -0400
Received: by mail-it0-f72.google.com with SMTP id m207-v6so3602573itg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QeqGSzgO9DUbM+lhVgWKkYgO0shLqx52Bm1p9lglowg=;
        b=U/hShNgf4SWJ2tfv1NGm90ZZ8MBf5UMmwsOETQCoqWLxeFjhGXsE46jtDVL86010Dz
         9n8cSfnCA1UPeAInGIroCdtm4sE9Nvarg8eV/xVMbVvOW8N+XKP30N9OW2HCekjWoEVW
         ca/McmoWDluHsmjHOShyXNidXV2rjvD39Q3FV2jUvipsvicgsE7AyrdVG/pvknSDKIZ3
         gKspXMxldzw56ugBqiUpDK9PiOEgbFLSQOH+xRFQ7U9A9j/sp9UOaV3teH9woVTmlBsd
         e0440GoeC68XTSwJllWCgP9bv2JoR46+cvAE8S+nPuUxRQcvl/fHLOmVwJeIPtGVE/j8
         hHCg==
X-Gm-Message-State: APzg51DgdesIvqwWdQ275AtH+N2pFkotU5DvMpiPkSx9RMTeIiRvHHay
        cxYMyPEqpo1j1QEpot2xxx1VQzM03a3KpZ2612LhYqjGjIQv
X-Google-Smtp-Source: ANB0VdZPok8VKLxw8KnaNw7jesAfeVo3lxSmYRaiqUyCJdGYdjsg+NR3oBWUz6R9Her98GDXcC9h3ZCVUZSL+jPUDaxKiQiOafqH
MIME-Version: 1.0
X-Received: by 2002:a02:1b81:: with SMTP id 1-v6mr5586070jas.6.1535678702898;
 Thu, 30 Aug 2018 18:25:02 -0700 (PDT)
Date:   Thu, 30 Aug 2018 18:25:02 -0700
In-Reply-To: <00000000000005859b0574ab47e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000935bfc0574b10f14@google.com>
Subject: Re: KMSAN: uninit-value in rds_connect
From:   syzbot <syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, santosh.shilimkar@oracle.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    25114c64b719 kmsan: unpoison pages moved from iov_iter to ..
git tree:       https://github.com/google/kmsan.git/master
console output: https://syzkaller.appspot.com/x/log.txt?x=14465da6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3431f03869413153
dashboard link: https://syzkaller.appspot.com/bug?extid=0049bebbf3042dbd2e8f
compiler:       clang version 8.0.0 (trunk 339414)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b8513e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d64e96400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
==================================================================
BUG: KMSAN: uninit-value in rds_connect+0x213/0x950 net/rds/af_rds.c:511
CPU: 0 PID: 4780 Comm: syz-executor239 Not tainted 4.19.0-rc1+ #38
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x14b/0x190 lib/dump_stack.c:113
  kmsan_report+0x183/0x2b0 mm/kmsan/kmsan.c:956
  __msan_warning+0x70/0xc0 mm/kmsan/kmsan_instr.c:645
  rds_connect+0x213/0x950 net/rds/af_rds.c:511
  __sys_connect+0x64e/0x750 net/socket.c:1662
  __do_sys_connect net/socket.c:1673 [inline]
  __se_sys_connect net/socket.c:1670 [inline]
  __x64_sys_connect+0xd8/0x120 net/socket.c:1670
  do_syscall_64+0x15b/0x220 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x440199
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff5f41c118 EFLAGS: 00000213 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440199
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401a20
R13: 0000000000401ab0 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----address@__sys_connect
Variable was created at:
  __sys_connect+0x6a/0x750 net/socket.c:1645
  __do_sys_connect net/socket.c:1673 [inline]
  __se_sys_connect net/socket.c:1670 [inline]
  __x64_sys_connect+0xd8/0x120 net/socket.c:1670
==================================================================

