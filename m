Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeECVEO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:04:14 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:41603 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbeECVEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:04:02 -0400
X-Google-Smtp-Source: AB8JxZqk8OXI3U9CtF+Fur9kXJ4GQL6YONWlhrZfNnA/U3R59i0Qa4pirpP7ZgIurYMq0Bclpzxg+EUAMdUQav1oH/KJJVDQUgB/
MIME-Version: 1.0
Date: Thu, 03 May 2018 14:04:02 -0700
In-Reply-To: <0000000000005dbad8056b20cabc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000000722056b538b68@google.com>
Subject: Re: kernel BUG at include/linux/mm.h:LINE!
From: syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        hpa@zytor.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@elte.hu, mingo@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, prudo@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, takahiro.akashi@linaro.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org,
        xlpang@redhat.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c15f6d8d4715 Merge tag 'dma-mapping-4.17-4' of git://git.i..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165343c7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a1dc06635c10d27
dashboard link: https://syzkaller.appspot.com/bug?extid=d96f60296ef613fe1d69
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=105a4437800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com

flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: ffffea0006b60aa0 ffff8801dae2fdd8 0000000000000000 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:492!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4524 Comm: syz-executor0 Not tainted 4.17.0-rc3+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:put_page_testzero include/linux/mm.h:492 [inline]
RIP: 0010:__free_pages+0x14f/0x180 mm/page_alloc.c:4427
RSP: 0018:ffff8801ad01fc08 EFLAGS: 00010203
RAX: 0000000000000000 RBX: 1ffff10035a03f82 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a5b2e5 RDI: ffffed0035a03f70
RBP: ffff8801ad01fc98 R08: ffff8801ad09e740 R09: ffffed003b5c4fb0
R10: ffffed003b5c4fb0 R11: ffff8801dae27d87 R12: ffffea0006b6e740
R13: 1ffff10035a03f86 R14: ffff8801ad01fc70 R15: ffffea0006b6e75c
FS:  0000000002891940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d9fc4 CR3: 00000001ad7ed000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  free_pages+0x50/0x90 mm/page_alloc.c:4441
  free_transition_pgtable+0x68/0xf0 arch/x86/kernel/machine_kexec_64.c:42
  machine_kexec_cleanup+0x9/0x10 arch/x86/kernel/machine_kexec_64.c:268
  kimage_free+0x1f2/0x270 kernel/kexec_core.c:639
  do_kexec_load+0x53a/0x790 kernel/kexec.c:170
  __do_sys_kexec_load kernel/kexec.c:243 [inline]
  __se_sys_kexec_load kernel/kexec.c:218 [inline]
  __x64_sys_kexec_load+0x1bf/0x230 kernel/kexec.c:218
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007ffdca50c2b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000f6
RAX: ffffffffffffffda RBX: 0000000002891914 RCX: 0000000000455979
RDX: 00000000200001c0 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000403 R14: 00000000006fa0e8 R15: 0000000000000005
Code: 68 5b 41 5c 41 5d 41 5e 41 5f 5d c3 8b b5 74 ff ff ff 4c 89 e7 e8 02  
87 ff ff eb c6 48 c7 c6 00 66 d0 87 4c 89 e7 e8 81 7a 0d 00 <0f> 0b 4c 89  
ef 89 85 70 ff ff ff e8 51 7b 1d 00 8b 85 70 ff ff
RIP: put_page_testzero include/linux/mm.h:492 [inline] RSP: ffff8801ad01fc08
RIP: __free_pages+0x14f/0x180 mm/page_alloc.c:4427 RSP: ffff8801ad01fc08
---[ end trace dbb114ab9bd59585 ]---
