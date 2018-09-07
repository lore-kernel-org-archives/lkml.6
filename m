Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D77C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8614720645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8614720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeIHCGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:06:53 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:57033 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeIHCGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:06:52 -0400
Received: by mail-io1-f71.google.com with SMTP id o18-v6so533373ioh.23
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 14:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KgkqmRnS3AZzB3QIggzwrYdCYIF9GfsHtsr+USeiCIM=;
        b=TAxjky7fgUhO0nPg9RJwn1TDjHElnnwac2Rajfjw1ol3UpP6BsHqngz5aVYHKv6NKw
         PO4B4Wty4MpUXyd0Nnb0B1UQmUR/ggQzGYr/3sikbjYn4WU6mkabI2MFEiICanzhdkRx
         7QUcwpFhWkhklE26DVBM9ZRbtQLO8Rher/5TEOLcwGa3PLH4AdZPaLWC3Ue3mIH0o7/H
         bm2LCb7jWoAumi1C5Sd4AFSH8rzEyAH07YrvdkmhniBirQJzCnIw1iy2KegSki0KdVCH
         zC0Qy7NcEXF1ayHjgdOvY0oo6Mq/lHVnzpOBTD7s4Fvil6SOO6sMOJCbYTqHW67A9B5W
         ZlBg==
X-Gm-Message-State: APzg51Adv9ST16SFnE0HZYmywxZl+g8CZN8DREumXifL7AVoZjxk/u9f
        n+Sj7aKZHymaOxuRrsbZJKjXQZgpilb3iiJJUN3h9b4AxKYA
X-Google-Smtp-Source: ANB0VdbDzDJ94OErMdVSzETOm9jOw6rmM2xpBJy0C+5Cow7u/T2qyTfVLIdpL0UBfX2NKEj53cI+Krnt00ctFt6km1Y3daobLnh7
MIME-Version: 1.0
X-Received: by 2002:a5e:d908:: with SMTP id n8-v6mr8278316iop.77.1536355443119;
 Fri, 07 Sep 2018 14:24:03 -0700 (PDT)
Date:   Fri, 07 Sep 2018 14:24:03 -0700
In-Reply-To: <000000000000038dab0575476b73@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fa12a05754ea030@google.com>
Subject: Re: WARNING: kmalloc bug in str_read
From:   syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
To:     eparis@parisplace.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, penguin-kernel@I-love.SAKURA.ne.jp,
        peter.enderborg@sony.com, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    a49a9dcce802 Merge tag 'drm-fixes-2018-09-07' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11981149400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c9564cd177daf0c
dashboard link: https://syzkaller.appspot.com/bug?extid=ac488b9811036cea7ea0
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1717dfa9400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c1adea400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
audit: type=1400 audit(1536355256.676:7): avc:  denied  { map } for   
pid=4365 comm="syz-executor462" path="/root/syz-executor462675731"  
dev="sda1" ino=16481 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
WARNING: CPU: 0 PID: 4365 at mm/slab_common.c:1031 kmalloc_slab+0x56/0x70  
mm/slab_common.c:1031
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 4365 Comm: syz-executor462 Not tainted 4.19.0-rc2+ #5
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x252/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
RIP: 0010:kmalloc_slab+0x56/0x70 mm/slab_common.c:1031
Code: c5 40 db f2 87 5d c3 b8 10 00 00 00 48 85 ff 74 f4 83 ef 01 c1 ef 03  
0f b6 87 60 da f2 87 eb d8 31 c0 81 e6 00 02 00 00 75 db <0f> 0b 5d c3 48  
8b 04 c5 80 da f2 87 5d c3 66 90 66 2e 0f 1f 84 00
RSP: 0018:ffff8801c2317298 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000d7fffd6 RCX: ffffffff832e9d2e
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000d7fffd7
RBP: ffff8801c2317298 R08: ffff8801c197a700 R09: ffffed003b6046de
R10: ffffed003b6046de R11: ffff8801db0236f3 R12: 00000000006000c0
R13: ffff8801c2317938 R14: ffff8801c23173c0 R15: 00000000006000c0
  __do_kmalloc mm/slab.c:3713 [inline]
  __kmalloc+0x25/0x720 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  str_read+0x48/0x160 security/selinux/ss/policydb.c:1104
  common_read+0x37c/0x560 security/selinux/ss/policydb.c:1177
  policydb_read+0xf09/0x5f90 security/selinux/ss/policydb.c:2407
  security_load_policy+0x23b/0x1650 security/selinux/ss/services.c:2165
  sel_write_load+0x247/0x460 security/selinux/selinuxfs.c:565
  __vfs_write+0x117/0x9d0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440049
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd03e23ca8 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440049
RDX: 0000000000000163 RSI: 0000000020000380 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 00000000004018d0
R13: 0000000000401960 R14: 0000000000000000 R15: 0000000000000000
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

