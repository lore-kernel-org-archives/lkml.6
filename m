Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F6BC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC29620823
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfB0RCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:02:07 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:43339 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0RCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:02:06 -0500
Received: by mail-it1-f200.google.com with SMTP id w200so5721138itc.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:02:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2LeEqyuwTyOpjsmCCEtw8Ypkn0vyekRX5ySD1/BfW3M=;
        b=iYNM3B/OM9XUBaagPJ2ITKx1e2ViPojomzOf9jWtecwaD9y16c5bxo3fBQeH06RYBR
         melX3PjjYr0hlFB5PXdt3DbQJUyjzB9nYS0OlbkWaJ/ZCB9s6YDH2U8BfZ7IRaAeTI3t
         YzN+2mD/Vd8S1wrRF6aff8cWz1x0G59RdEEeuk/AveMbGORGMuMUa3PkktBBZhdEO4LN
         h06UFWT0oYyJSIpfsuafOgZpFDdj+ufq6DSKjKzIoQZu+tWb/KvFELmUeJc2GeGX2ir8
         ryIEChGsqOXxyS0fmi3k++aciZIKGED7vUImj6j6hL03F8aqLVXvvUtXnNUitmdkb087
         9XSw==
X-Gm-Message-State: AHQUAuaovOMkopFXW7N8uAI4nOgnbwv/lCS+MiNJk+O8B5UfJEZsP+eH
        42MW390bvGFS2hMvwLF5RrRrN87MucLlZm3jwIw0oS71q9Os
X-Google-Smtp-Source: AHgI3Ibx8NfbGnr4lGsqtscnldwl7Xa+JK4RyLDBah7Xm5A3jC2nbZfDzHTeMBXcURWapXOXutuv55j3saJKjQ/Q/owzCcz4Ozbd
MIME-Version: 1.0
X-Received: by 2002:a24:334a:: with SMTP id k71mr154184itk.14.1551286925023;
 Wed, 27 Feb 2019 09:02:05 -0800 (PST)
Date:   Wed, 27 Feb 2019 09:02:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c63c80582e32294@google.com>
Subject: kernel panic: MAC Initialization failed.
From:   syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7b827ff9af88 Add linux-next specific files for 20190227
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15336f14c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa6b8975759dcc5
dashboard link: https://syzkaller.appspot.com/bug?extid=e1b8084e532b6ee7afab
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ee708ac00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16954084c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com

  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441059
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcf60be0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441059
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007ffcf60be0d0 R08: 0000000000001000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
ERROR: Out of memory at tomoyo_realpath_from_path.
Kernel panic - not syncing: MAC Initialization failed.
CPU: 0 PID: 9747 Comm: syz-executor533 Not tainted 5.0.0-rc8-next-20190227  
#44
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  tomoyo_warn_oom.cold+0x35/0x43 security/tomoyo/memory.c:28
  tomoyo_realpath_from_path+0x3a8/0x730 security/tomoyo/realpath.c:320
  tomoyo_realpath_nofollow+0xc8/0xdb security/tomoyo/realpath.c:336
  tomoyo_find_next_domain+0x28c/0x1f8a security/tomoyo/domain.c:725
  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:107 [inline]
  tomoyo_bprm_check_security+0x12a/0x1b0 security/tomoyo/tomoyo.c:97
  security_bprm_check+0x69/0xb0 security/security.c:751
  search_binary_handler+0x77/0x570 fs/exec.c:1644
  exec_binprm fs/exec.c:1698 [inline]
  __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
  do_execveat_common fs/exec.c:1865 [inline]
  do_execveat fs/exec.c:1893 [inline]
  __do_sys_execveat fs/exec.c:1969 [inline]
  __se_sys_execveat fs/exec.c:1961 [inline]
  __x64_sys_execveat+0xed/0x130 fs/exec.c:1961
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441059
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcf60be0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441059
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007ffcf60be0d0 R08: 0000000000001000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
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
