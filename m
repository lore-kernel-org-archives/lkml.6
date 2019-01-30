Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7994C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C062184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbfA3Sxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:53:46 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:44787 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfA3SxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:53:05 -0500
Received: by mail-it1-f200.google.com with SMTP id x82so442531ita.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mt+8QDwGdQHkFcSQ1U/++Iz39xm6+iQbVchpWXR7CTc=;
        b=D4wkI75ATJ5/szDFrsrxuJYtwMsGU+FYjLfSVvMTh5XRDiT/Drg/xpblXm/hwfbMrJ
         Zesu4gOSW9a5JYHQjHCZrPPQuwYGoWz0b0LvLk1+sjNJmDKSbSSY/bBwWx287tslyPRv
         WwaQLs39ESvNarJa5FdeGUsbExLXDSJsVbmdN8Ps6Z5o9tr/wg39AoRiot5URfSI4kze
         KORhDmkJMK1wo8sfPYRIKnLR5cWTQlvY0BfysGkUDzW7isUzzbrAClsoqHC7wZf9sw1V
         a3r5Cm4EWhNUM6x8alW1HSQTm9PtyTJeeHKLLzkBncXhYZ68d816q4cAhEePK9zuEC97
         bOCw==
X-Gm-Message-State: AHQUAuaqd0DGSVR02aVjMScLY2Z9zu4xufrgRtAsIeO8tKIAxfKoXQdv
        4RRgRXHuNHeaWIyAp7mNsh6vh5UINQgRvpcma6QWkFAoH7Wu
X-Google-Smtp-Source: AHgI3IaUM0XDRuqf2MYE5GUi/Ag5vOzU+VmtibanLglIghES2sC9vE34N3Qd14t3TXWOUuElzlev9M9kt5HvmSu+7b0ozuSjrELZ
MIME-Version: 1.0
X-Received: by 2002:a5e:a70c:: with SMTP id b12mr1066746iod.26.1548874384418;
 Wed, 30 Jan 2019 10:53:04 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:53:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c36aa0580b16b56@google.com>
Subject: WARNING in strp_done (2)
From:   syzbot <syzbot+ea38a133bb90dd367b6e@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, doronrk@fb.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        vakul.garg@nxp.com, yhs@fb.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    02495e76ded5 Add linux-next specific files for 20190130
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a00c2f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2b2e9c0bc43c14d
dashboard link: https://syzkaller.appspot.com/bug?extid=ea38a133bb90dd367b6e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b059ef400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ea38a133bb90dd367b6e@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_hsr: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): bridge0: link becomes ready
WARNING: CPU: 0 PID: 7927 at net/strparser/strparser.c:526  
strp_done+0xca/0xf0 net/strparser/strparser.c:526
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7927 Comm: kworker/0:3 Not tainted 5.0.0-rc4-next-20190130 #22
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events sk_psock_destroy_deferred
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x48 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:strp_done+0xca/0xf0 net/strparser/strparser.c:526
Code: 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 31 48 c7 43 18 00 00  
00 00 e8 82 bc 40 fa 5b 41 5c 41 5d 5d c3 e8 76 bc 40 fa <0f> 0b eb 81 e8  
1d 7e 85 fa e9 5c ff ff ff 4c 89 e7 e8 70 7e 85 fa
RSP: 0018:ffff88808a7a7900 EFLAGS: 00010293
RAX: ffff88808f9343c0 RBX: ffff8880a7fa9240 RCX: ffffffff87415c5a
RDX: 0000000000000000 RSI: ffffffff87415cda RDI: 0000000000000001
RBP: ffff88808a7a7918 R08: ffff88808f9343c0 R09: ffffed1015cc5b80
R10: ffffed1015cc5b7f R11: ffff8880ae62dbfb R12: 0000000000000001
R13: 1ffff110114f4f71 R14: ffff8880a7fa9200 R15: ffff88809fda3e00
  sk_psock_destroy_deferred+0x8b/0x7f0 net/core/skmsg.c:557
  process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
  worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
  kthread+0x357/0x430 kernel/kthread.c:247
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
