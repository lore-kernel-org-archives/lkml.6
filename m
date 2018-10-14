Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F26DC28CF8
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 00:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4538920693
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 00:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4538920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeJNHuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 03:50:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34507 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeJNHuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 03:50:01 -0400
Received: by mail-io1-f71.google.com with SMTP id y3-v6so15020896iob.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 17:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xQAgvQRu7sH2JoNTQCcRvqDOKCQEu4QBeslDrU2lMac=;
        b=XfIrj8YNZrdjAYa/abEVD/rNpIbSp5dfo7mmrKYNv8oujYz0t2Lq1kabIG3/E9yAtN
         KZ2FH3SDwtEna4fWb+koAVGvnb2V07KknYXITdZhq4aNPIbgYVbullD8fsIXeoruwbF4
         h/N7tJW1GG6Okths3Px0/NdqeDDPEOMG+oEapTojBAbAN2aFGAm1atiJEy+Mm16I/SwE
         2WJb55Vrv7f/u6SNPx7aJp5dKGXEGR2ZNaLt+NAeWiUNDYmekwXKQAPU4s4bTmtI26ZL
         g5N3ZnYkM202tWZ5MhvoffYjILSBHnsxiQzf4h6PvH89Fynd0QSKCc1F8WuPBR10Z5qk
         nwlA==
X-Gm-Message-State: ABuFfojqP62hu0+oTnFCv+/1YU4yhKszhrVYcvb4wX0b4g2EEVAMcLa/
        jwELe6hqPs5ckKEwOvCRDcukE1e1RjdWoqzhBSod5knG78kc
X-Google-Smtp-Source: ACcGV62+yV3ODqAVxKgeMzc99xIHNk33N8Zw/KQ4kiF6LdZHzuBFxQCjCPWDs/a+FR7wQ+89brjjgEhR3llPtCln2nM372OXP4m8
MIME-Version: 1.0
X-Received: by 2002:a6b:4614:: with SMTP id t20-v6mr9159182ioa.13.1539475862787;
 Sat, 13 Oct 2018 17:11:02 -0700 (PDT)
Date:   Sat, 13 Oct 2018 17:11:02 -0700
In-Reply-To: <00000000000009f9a305708faf46@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f11d1c05782527d2@google.com>
Subject: Re: WARNING in cgroup_apply_control_enable
From:   syzbot <syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com>
To:     davem@davemloft.net, guro@fb.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1ae80cf31938 bpf: wait for running BPF programs when updat..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b82735400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e7e2279c0020d5f
dashboard link: https://syzkaller.appspot.com/bug?extid=5493b2a54d31d6aea629
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120ead5e400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b7426400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5493b2a54d31d6aea629@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 0 PID: 5812 at kernel/cgroup/cgroup.c:2931  
cgroup_apply_control_enable+0x22c/0xea0 kernel/cgroup/cgroup.c:2931
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 5812 Comm: syz-executor858 Not tainted 4.19.0-rc6+ #119
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:cgroup_apply_control_enable+0x22c/0xea0  
kernel/cgroup/cgroup.c:2931
Code: 48 c1 e8 03 42 80 3c 28 00 0f 85 18 0a 00 00 49 8b 5f 18 31 ff 83 e3  
02 48 89 de e8 5e 60 07 00 48 85 db 74 07 e8 24 5f 07 00 <0f> 0b e8 1d 5f  
07 00 48 8b 85 a0 fe ff ff 48 c1 e8 03 42 80 3c 28
RSP: 0018:ffff8801bbe97808 EFLAGS: 00010293
RAX: ffff8801bbee2040 RBX: 0000000000000002 RCX: ffffffff81777662
RDX: 0000000000000000 RSI: ffffffff8177766c RDI: 0000000000000007
RBP: ffff8801bbe979b8 R08: ffff8801bbee2040 R09: fffffbfff1277dac
R10: ffff8801bbe97890 R11: ffffffff893bed67 R12: ffffffff893c50c0
R13: dffffc0000000000 R14: 000000000000000b R15: ffff8801d8f08a40
  cgroup_apply_control+0x1f/0x50 kernel/cgroup/cgroup.c:3017
  cgroup_enable_threaded kernel/cgroup/cgroup.c:3229 [inline]
  cgroup_type_write+0x3bb/0x580 kernel/cgroup/cgroup.c:3270
  cgroup_file_write+0x2f7/0x7e0 kernel/cgroup/cgroup.c:3450
  kernfs_fop_write+0x2ba/0x480 fs/kernfs/file.c:316
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441d29
Code: e8 cc b2 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe2c31df58 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441d29
RDX: 0000000000000009 RSI: 0000000020000140 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000000001
R13: 000000000000bc4a R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..

