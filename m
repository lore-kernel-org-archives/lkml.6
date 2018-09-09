Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3599C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 01:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4770F20870
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 01:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4770F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbeIIGau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 02:30:50 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:58126 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeIIGau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 02:30:50 -0400
Received: by mail-it0-f69.google.com with SMTP id e6-v6so33909406itc.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 18:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pLcXHATuYeiEHc/O7VdP3V/bPj7KCbd66z3zZ3FdHzo=;
        b=fm6DfwRznNRIF6WAS8qRCPu3PKNtwqbyXXmtGLUfk0SoITlSDJBAD6nzQqRGF1GNT6
         CXdw7AjKTMby0NcrG1fv7RGj+XFuo6VuDrWW2kaHWpEc3dFgitAfZMt5L9l8V2W3HGWq
         ciovBBjFXg08sQssQ0XzMRHGQVxucBoGxn9T5pXFPYHC06Imhww9pQuBGRKWOQHuiBcg
         XTFp3N50bwdOevWJsxH8eUxClam3bVhM7cSuekYIG40up7A8OoOVL7ZOBFS3+XmKIZca
         OtY/HKL01EgtJCvvCrfFmZ3ZoP3m+fRPYIEyHbYEmpNpo7rGTHZBFSU907bBwwyJZpWS
         hAIA==
X-Gm-Message-State: APzg51AhyJDuyeYkQgH9ow4Sp3Ll7CpgHTNZ9II0ilO9OyzTitYLQcL9
        qVjPQo8/f3BEdjjBmtq6JJg2mxGpHUQScj4rTmLQSo9CqyYl
X-Google-Smtp-Source: ANB0VdaenacmuXzLqA20dxPTvPR32c+bXmnAqJCqKajd2cQk59v3Wygos0cibHAqirvvQ85HbMfeX3mT1QqUdcoTgiDa82agRslj
MIME-Version: 1.0
X-Received: by 2002:a6b:8dc3:: with SMTP id p186-v6mr12175328iod.33.1536457382325;
 Sat, 08 Sep 2018 18:43:02 -0700 (PDT)
Date:   Sat, 08 Sep 2018 18:43:02 -0700
In-Reply-To: <000000000000f9bd97057543ec30@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c7a640575665c3f@google.com>
Subject: Re: general protection fault in ovl_free_fs
From:   syzbot <syzbot+c75f181dc8429d2eb887@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    d7b686ebf704 Merge branch 'i2c/for-current' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148ac149400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=c75f181dc8429d2eb887
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11553b7a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b16421400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c75f181dc8429d2eb887@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
overlayfs: failed to clone upperpath
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5473 Comm: syz-executor554 Not tainted 4.19.0-rc2+ #7
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:ovl_free_fs+0x504/0x690 fs/overlayfs/super.c:226
Code: 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 78 01 00 00 48  
b8 00 00 00 00 00 fc ff df 4c 8b 23 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 67 01 00 00 49 8b 3c 24 e8 c9 0a 01 00 e9 0c fc
RSP: 0018:ffff8801b3de7798 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8801d87b7800 RCX: ffffffff828cacaf
RDX: 0000000000000000 RSI: ffffffff828cb065 RDI: 0000000000000001
RBP: ffff8801b3de77f0 R08: ffff8801c44ba680 R09: ffffed003b5e4732
R10: ffffed003b5e4732 R11: ffff8801daf23993 R12: 0000000000000000
R13: ffff8801d87b7820 R14: fffffffffffffff4 R15: ffff8801d87b7800
FS:  000000000207a880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14a574e169 CR3: 00000001c5068000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ovl_fill_super+0x4f4/0x40a3 fs/overlayfs/super.c:1508
  mount_nodev+0x6b/0x110 fs/super.c:1204
  ovl_mount+0x2c/0x40 fs/overlayfs/super.c:1516
  mount_fs+0xae/0x31d fs/super.c:1261
  vfs_kern_mount.part.35+0xdc/0x4f0 fs/namespace.c:961
  vfs_kern_mount fs/namespace.c:951 [inline]
  do_new_mount fs/namespace.c:2457 [inline]
  do_mount+0x581/0x31f0 fs/namespace.c:2787
  ksys_mount+0x12d/0x140 fs/namespace.c:3003
  __do_sys_mount fs/namespace.c:3017 [inline]
  __se_sys_mount fs/namespace.c:3014 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3014
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445119
Code: ad ce fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffef77a0948 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445119
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00007ffef77a0960 R08: 0000000020000100 R09: 00007ffef77f92f4
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 6b50ff34ce671ab8 ]---
RIP: 0010:ovl_free_fs+0x504/0x690 fs/overlayfs/super.c:226
Code: 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 78 01 00 00 48  
b8 00 00 00 00 00 fc ff df 4c 8b 23 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 67 01 00 00 49 8b 3c 24 e8 c9 0a 01 00 e9 0c fc
RSP: 0018:ffff8801b3de7798 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8801d87b7800 RCX: ffffffff828cacaf
RDX: 0000000000000000 RSI: ffffffff828cb065 RDI: 0000000000000001
RBP: ffff8801b3de77f0 R08: ffff8801c44ba680 R09: ffffed003b5e4732
R10: ffffed003b5e4732 R11: ffff8801daf23993 R12: 0000000000000000
R13: ffff8801d87b7820 R14: fffffffffffffff4 R15: ffff8801d87b7800
FS:  000000000207a880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f14a574e169 CR3: 00000001c5068000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

