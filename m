Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D7F21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D7F21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeKORzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:55:46 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:53026 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeKORzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 12:55:46 -0500
Received: by mail-it1-f198.google.com with SMTP id o205so9900628itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 23:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=94Yz197PuQr99cZ/uprED/KGQpRDi+X2PIFZDpzwMWY=;
        b=qPOX/IK8ucdj7hMtcQOIh9fYbYwPSMWDwkgxOL2aEn/O642lSXbY9zKCPfY/hAua5X
         ZiGj1nBV7NsFemNj8OQ1m5QyIaIZ9n+QoyCuHNt3ds2ddhOsxQiz86w+JqFN3A7+ItE8
         gTQa5PKEp+UA1s7HJZrYobPxFxhGNcbZ+j7B48/BWXdgTiIlNA5+TsiOmw3sVMyYEYmz
         eZcIzXnnmceLbCqCC7ZBQwW6JQAZAvwDNyjil3ZYV2xF0T2aLu0OyqmFZZQjzl2ZCQ8Q
         a7O7nJi5QXqmX1wdCuwLm1v38jq/cU35i57aj1weqwseJega2iL6YuZmc3LTN2vsACK6
         LI2Q==
X-Gm-Message-State: AGRZ1gIr19h5uY6IvfNgr7EwnXmxym+HBvKULnAl7nGhCU7+HAseOOoK
        PrlYaXS9p8zNqOQvQgBBaOo+WMtO3hrsKDQvfi32P3m19K7j
X-Google-Smtp-Source: AJdET5dsv2u3JvtYBiQZK23fCwzooZldRMD3st+AgDyZjkZO0AB0oHvPH6Hy54JoDwu5y9Ywcdj7l3D85OGRhpqi87WBH1BKReEK
MIME-Version: 1.0
X-Received: by 2002:a02:4f87:: with SMTP id r7-v6mr3787479jad.25.1542268142613;
 Wed, 14 Nov 2018 23:49:02 -0800 (PST)
Date:   Wed, 14 Nov 2018 23:49:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9fe68057aaf48ff@google.com>
Subject: WARNING in bpf_check (2)
From:   syzbot <syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ccda4af0f4b9 Linux 4.20-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129edfbd400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc427c7af994b0948be
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172b626d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148dcb0b400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com

audit: type=1400 audit(1542221670.986:36): avc:  denied  { map } for   
pid=6270 comm="syz-executor244" path="/root/syz-executor244665442"  
dev="sda1" ino=16484 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
------------[ cut here ]------------
audit: type=1400 audit(1542221670.986:37): avc:  denied  { prog_load } for   
pid=6270 comm="syz-executor244"  
scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023 tclass=bpf  
permissive=1
verifier bug. No program starts at insn 7
WARNING: CPU: 0 PID: 6270 at kernel/bpf/verifier.c:5880 jit_subprogs  
kernel/bpf/verifier.c:5879 [inline]
WARNING: CPU: 0 PID: 6270 at kernel/bpf/verifier.c:5880 fixup_call_args  
kernel/bpf/verifier.c:6023 [inline]
WARNING: CPU: 0 PID: 6270 at kernel/bpf/verifier.c:5880  
bpf_check+0x5461/0x6310 kernel/bpf/verifier.c:6404
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6270 Comm: syz-executor244 Not tainted 4.20.0-rc2+ #112
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x55c kernel/panic.c:188
  __warn.cold.8+0x20/0x45 kernel/panic.c:540
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:jit_subprogs kernel/bpf/verifier.c:5879 [inline]
RIP: 0010:fixup_call_args kernel/bpf/verifier.c:6023 [inline]
RIP: 0010:bpf_check+0x5461/0x6310 kernel/bpf/verifier.c:6404
Code: b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 69 0b 00  
00 8b 73 04 48 c7 c7 c0 ca 30 88 44 01 ee e8 4f 14 b9 ff <0f> 0b 48 8b 54  
24 08 b8 ff ff 37 00 48 c1 e0 2a 48 c1 ea 03 0f b6
RSP: 0018:ffff8881c126f980 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffc90005e13040 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8165e7e5 RDI: 0000000000000005
RBP: ffff8881c126fb30 R08: ffff8881a322e0c0 R09: ffffed103b5c5020
R10: ffffed103b5c5020 R11: ffff8881dae28107 R12: 0000000000000000
R13: 0000000000000002 R14: ffffc90005e13044 R15: ffff8881c0da6380
  bpf_prog_load+0x113d/0x1cc0 kernel/bpf/syscall.c:1528
  __do_sys_bpf kernel/bpf/syscall.c:2504 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2466 [inline]
  __x64_sys_bpf+0x36c/0x520 kernel/bpf/syscall.c:2466
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440159
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff04546138 EFLAGS: 00000207 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440159
RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000207 R12: 00000000004019e0
R13: 0000000000401a70 R14: 0000000000000000 R15: 0000000000000000
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
