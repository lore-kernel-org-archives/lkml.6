Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8601AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3626023E3F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3626023E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeFVHfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:35:04 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:35436 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeFVHfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:35:02 -0400
Received: by mail-io0-f200.google.com with SMTP id r16-v6so4582672ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JEU+uMLmhRzT8rLggiYnVYMt+GvkJm3SQjwfvZ6Imtc=;
        b=ecq0BL55XfVe8DBgUYmZNzQoUJd/91LH8x9PooqPZ4TwZecDdSTZljv+awwfyIF9AL
         X/VupvJVDg5Srq2ziLUUW46ntzXBg6/Dn9uxiClajKh0D3akZjEWGfn/ykUJ926Xqc8q
         b395bdt/vITLIqesduF7LgERp6ycjyBXbZWbaQ7SHj1VGAJJctPaZKfuuL//mp2JRoPs
         PKpmtwgWdkJlfWkqVXdRQ9xCKRSXbsx2ZvJli2yXV9NRnKtY4HtfJe7tUMxkw3YbcG99
         lngN3Fx1Msul9LOWObXhWfMysY/m8baQHh18kx1SndUnNr4BuFZnEiCjz+L7EUge6Wfy
         e89A==
X-Gm-Message-State: APt69E3TYhHCXJRx7ApxRJ/8n9Sgqe0asuJVz/Rx/fjX672aW8QpFAdK
        3yD2m1W9R8rwPL3CzMr/vRNQIlXc2IO6LtpWEuwkgcdQ4PA5
X-Google-Smtp-Source: AAOMgpfp6L1vbhgxnC5OO11nrBHsGxnpwDUN09l0K255iMe4eyHxtulUopF/nW879obyN8PQjK+eMxtq2SY/bSirzAcNxfeyq9k/
MIME-Version: 1.0
X-Received: by 2002:a6b:ee11:: with SMTP id i17-v6mr159522ioh.37.1529652902029;
 Fri, 22 Jun 2018 00:35:02 -0700 (PDT)
Date:   Fri, 22 Jun 2018 00:35:02 -0700
In-Reply-To: <0000000000004f02b3056e895cce@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daf3c0056f361135@google.com>
Subject: Re: WARNING: refcount bug in smap_release_sock
From:   syzbot <syzbot+d464d2c20c717ef5a6a8@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1609ed08400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=d464d2c20c717ef5a6a8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10a53fbf800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d27aa0400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d464d2c20c717ef5a6a8@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
device lo entered promiscuous mode
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 4505 at lib/refcount.c:187  
refcount_sub_and_test+0x2d3/0x330 lib/refcount.c:187
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4505 Comm: syz-executor540 Not tainted 4.17.0+ #39
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  panic+0x22f/0x4de kernel/panic.c:184
  __warn.cold.8+0x163/0x1b3 kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:refcount_sub_and_test+0x2d3/0x330 lib/refcount.c:187
Code: 89 de e8 40 7e 21 fe 84 db 74 07 31 db e9 52 ff ff ff e8 60 7d 21 fe  
48 c7 c7 20 4b 1a 88 c6 05 78 64 40 06 01 e8 8d 97 ed fd <0f> 0b 31 db e9  
31 ff ff ff 48 8b bd 28 ff ff ff 89 85 34 ff ff ff
RSP: 0018:ffff8801b18b7800 EFLAGS: 00010282
RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffffffff8161907a
RDX: 0000000000000000 RSI: ffffffff8161f371 RDI: ffff8801b18b74d8
RBP: ffff8801b18b78e8 R08: ffff8801b24923c0 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffff
R13: ffff8801b18b78c0 R14: 0000000000000001 R15: ffff8801b318f040
  refcount_dec_and_test+0x1a/0x20 lib/refcount.c:212
  smap_release_sock+0x6e/0x2f0 kernel/bpf/sockmap.c:1358
  sock_hash_ctx_update_elem.isra.24+0x896/0x1560 kernel/bpf/sockmap.c:2281
  sock_hash_update_elem+0x14f/0x2d0 kernel/bpf/sockmap.c:2303
  map_update_elem+0x5c4/0xc90 kernel/bpf/syscall.c:765
  __do_sys_bpf kernel/bpf/syscall.c:2357 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2328 [inline]
  __x64_sys_bpf+0x32d/0x510 kernel/bpf/syscall.c:2328
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445a69
Code: e8 3c b6 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 51 00 00 c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f90f7ac8db8 EFLAGS: 00000293 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000006dac94 RCX: 0000000000445a69
RDX: 0000000000000020 RSI: 0000000020000180 RDI: 0000000000000002
RBP: 00000000006dac90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffc108bd18f R14: 00007f90f7ac99c0 R15: 0000000000000001
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

