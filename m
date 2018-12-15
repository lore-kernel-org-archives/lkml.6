Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3C2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeLOTeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:34:05 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:56789 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOTeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:34:04 -0500
Received: by mail-it1-f197.google.com with SMTP id x3so9532952itb.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 11:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HHxcuaF34DsOSs5YTBN9J6gv+3d2uklVpRqcCT23R6Y=;
        b=mbrQ+RIBvqBjg+DhI6HO7vMG02RaN/TqPBYmyEquZKC8T2vswkFzYb4z38PBXtrXCI
         w1+Qg4IPbl0GtkGddhbgsUzc9X9NV7fmBNRgcW3zz/M6qZcKWW/FevsrTGjuIyaIimdV
         mq1QZDNJCje5iV1Fuv6nDnRAdhECju4uYXsVaquAI73yN8ZB5y67LkZhh+3h0a/3LPlC
         2dDB9rBQ6dkrlj97C3PdG/bai9e8iPH3u+SIRVOWgARDPkP4CElQ9ILa3xk53rcb2IIU
         /C0dVGvLcHeBSzepAKDoKMF7ySKkmJEdWOBbQxHiFgGQHuCb99nzlMi3wfJNKq3a+4Iw
         gNHQ==
X-Gm-Message-State: AA+aEWbIlCTvXvFX05nRGIgTgzC11oM+RgFJwWwrDJytU+DmZknb70/O
        KCq0MAnJWu4VmOHHSyDWTCVjTAxaFcsYA/a+D+AuP33G5dGT
X-Google-Smtp-Source: AFSGD/XYcIq6swbrE24mnEkhrtNP1bbaCBHBSKw170p51Utl98olIdkr0a3aYM4bF3eu+1RB84idvNBG2TMCM6sN6W4dUfOnBUDo
MIME-Version: 1.0
X-Received: by 2002:a24:6504:: with SMTP id u4mr6683283itb.25.1544902443268;
 Sat, 15 Dec 2018 11:34:03 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:34:03 -0800
In-Reply-To: <000000000000064bcf057a59e3b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058055a057d14a1f4@google.com>
Subject: Re: WARNING in ovl_instantiate
From:   syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d14b746c6c1c Add linux-next specific files for 20181214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=143f9a15400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1da6d2d18f803140
dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6e543400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com

overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
overlayfs: filesystem on './file0' not supported as upperdir
WARNING: CPU: 1 PID: 28918 at fs/overlayfs/dir.c:263  
ovl_instantiate+0x369/0x400 fs/overlayfs/dir.c:263
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 28918 Comm: syz-executor1 Not tainted 4.20.0-rc6-next-20181214+  
#171
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x632 kernel/panic.c:214
  __warn.cold.8+0x20/0x4f kernel/panic.c:571
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:ovl_instantiate+0x369/0x400 fs/overlayfs/dir.c:263
Code: c3 89 c6 e8 89 35 ed fe 85 db 0f 85 9e 00 00 00 e8 6c 34 ed fe 4c 89  
e7 45 31 f6 e8 a1 b1 44 ff e9 ec fe ff ff e8 57 34 ed fe <0f> 0b e9 e0 fe  
ff ff e8 4b 34 ed fe 0f 0b e9 63 ff ff ff e8 ef 88
RSP: 0018:ffff8881ca6679a8 EFLAGS: 00010293
RAX: ffff8881d39c44c0 RBX: ffff8881ca667a40 RCX: ffffffff8292cd44
RDX: 0000000000000000 RSI: ffffffff8292cec9 RDI: 0000000000000007
RBP: ffff8881ca667a68 R08: ffff8881d39c44c0 R09: ffffed10394ccee8
R10: ffffed10394ccee8 R11: 0000000000000003 R12: ffff8881a357c8c0
R13: ffff8881ca6679e0 R14: ffffffffffffff8c R15: 0000000000000000
  ovl_create_over_whiteout fs/overlayfs/dir.c:518 [inline]
  ovl_create_or_link+0xad6/0x1560 fs/overlayfs/dir.c:582
  ovl_create_object+0x2e9/0x3a0 fs/overlayfs/dir.c:616
  ovl_symlink+0x24/0x30 fs/overlayfs/dir.c:651
  vfs_symlink+0x37a/0x5d0 fs/namei.c:4127
  do_symlinkat+0x242/0x2d0 fs/namei.c:4154
  __do_sys_symlink fs/namei.c:4173 [inline]
  __se_sys_symlink fs/namei.c:4171 [inline]
  __x64_sys_symlink+0x59/0x80 fs/namei.c:4171
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457659
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbde1680c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 0000000000457659
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000020000040
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbde16816d4
R13: 00000000004c532d R14: 00000000004d97a0 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..

