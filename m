Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD02C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEB820652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 11:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEB820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeJESOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 14:14:24 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38659 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeJESOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 14:14:23 -0400
Received: by mail-io1-f69.google.com with SMTP id n17-v6so11702839ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 04:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bfI6tb5oXUKp8s/NPXz7svkxBNqeUYarmEygSX5sI0g=;
        b=VmaLsWVwhINPm6hgY5IArht6YFUiz7mLNuHfnQ5lpf2IHfTekrAnSg+XCHgo1aTP0m
         GjtrIWyMZurlHbYKzcSb3938dBYU10Ao6ZDK1o12O7F4+lViHP6OrdCNgabUDd257ja1
         3EQ1snq2/AfgOeJRHlF9Mbu6R/a+nf9inl/tZkDgpBRco0PwvEy/1cgsvPzJkjppD++b
         KHj9UsPF9Yxrhrfybr8bw64WZN9y8u/FjukuDSUWvaWdqSzfaRbTAp+EUTYHmiELVipv
         r2/SQTt4u8qL0BmDWcTJhj61sU4JsIeUhJGnGaaOKDz3jc3GPHtJUQT3XMPyph6DzS/t
         oQMg==
X-Gm-Message-State: ABuFfoiOFKl9s0BcgcRjw0oi53AlC5cXj0+p2G3VqZEM2singUEu+xUK
        zGoSrTTMUUu2gn2ElAeteU0BKkJns0WXdxeKpom1oAWAMUe7
X-Google-Smtp-Source: ACcGV631X6ceoLXXfUoDKTzaPNfoTqDUTpH4VzGARypjAnloWc/2UlZuz+L3d6WnsNnDm89jbh3URrUHM5Y1cxQZV8MobBR/Vkhx
MIME-Version: 1.0
X-Received: by 2002:a24:7546:: with SMTP id y67-v6mr8084495itc.26.1538738163750;
 Fri, 05 Oct 2018 04:16:03 -0700 (PDT)
Date:   Fri, 05 Oct 2018 04:16:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a722550577796543@google.com>
Subject: kernel BUG at security/keys/keyring.c:LINE!
From:   syzbot <syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jmorris@namei.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    befad944e231 Merge tag 'drm-fixes-2018-10-05' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161fc976400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=ec24e95ea483de0a24da
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10160e3a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16995491400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ec24e95ea483de0a24da@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at security/keys/keyring.c:1214!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5807 Comm: syz-executor226 Not tainted 4.19.0-rc6+ #268
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__key_link_begin+0x23a/0x300 security/keys/keyring.c:1214
Code: fe 48 c7 c7 20 ae 67 89 e8 b3 36 23 fe eb ac e8 ec 64 42 fe 48 c7 c7  
20 ae 67 89 e8 30 73 73 04 e9 e3 fe ff ff e8 d6 64 42 fe <0f> 0b e8 cf 64  
42 fe 48 8d bb ce 00 00 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff8801bbdc7b10 EFLAGS: 00010293
RAX: ffff8801d924e2c0 RBX: ffff8801d4e7e080 RCX: ffffffff833c4ebf
RDX: 0000000000000000 RSI: ffffffff833c50aa RDI: 0000000000000007
RBP: ffff8801bbdc7b40 R08: ffff8801d924e2c0 R09: fffffbfff12cf4a4
R10: fffffbfff12cf4a4 R11: ffffffff8967a523 R12: ffff8801bbdc7c48
R13: 0000000000000000 R14: ffff8801d4e7e200 R15: ffff8801d4e7e080
FS:  0000000001ce9880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020cab000 CR3: 00000001d829a000 CR4: 00000000001406f0
Call Trace:
  construct_alloc_key security/keys/request_key.c:389 [inline]
  construct_key_and_link security/keys/request_key.c:480 [inline]
  request_key_and_link+0x737/0x17a0 security/keys/request_key.c:593
  __do_sys_request_key security/keys/keyctl.c:213 [inline]
  __se_sys_request_key security/keys/keyctl.c:158 [inline]
  __x64_sys_request_key+0x305/0x400 security/keys/keyctl.c:158
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440169
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd70324808 EFLAGS: 00000217 ORIG_RAX: 00000000000000f9
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440169
RDX: 00000000200001c0 RSI: 0000000020000180 RDI: 00000000200000c0
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000111522d3 R11: 0000000000000217 R12: 00000000004019f0
R13: 0000000000401a80 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 40815c4a8f1e2472 ]---
RIP: 0010:__key_link_begin+0x23a/0x300 security/keys/keyring.c:1214
Code: fe 48 c7 c7 20 ae 67 89 e8 b3 36 23 fe eb ac e8 ec 64 42 fe 48 c7 c7  
20 ae 67 89 e8 30 73 73 04 e9 e3 fe ff ff e8 d6 64 42 fe <0f> 0b e8 cf 64  
42 fe 48 8d bb ce 00 00 00 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff8801bbdc7b10 EFLAGS: 00010293
RAX: ffff8801d924e2c0 RBX: ffff8801d4e7e080 RCX: ffffffff833c4ebf
RDX: 0000000000000000 RSI: ffffffff833c50aa RDI: 0000000000000007
RBP: ffff8801bbdc7b40 R08: ffff8801d924e2c0 R09: fffffbfff12cf4a4
R10: fffffbfff12cf4a4 R11: ffffffff8967a523 R12: ffff8801bbdc7c48
R13: 0000000000000000 R14: ffff8801d4e7e200 R15: ffff8801d4e7e080
FS:  0000000001ce9880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020cab000 CR3: 00000001d829a000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
