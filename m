Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeDKVCI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:02:08 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:52735 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755693AbeDKVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:02:03 -0400
X-Google-Smtp-Source: AIpwx49xE2Z7dC04njR2ivE/F2LkREUi8ez7SszxUmegycNVhsPP2jFsrga8PCZ26aEEJ07o8jn1qAKukA2BCBYFbMFbsG07OhWe
MIME-Version: 1.0
Date: Wed, 11 Apr 2018 14:02:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <f4f5e80803d0583578056998f3e0@google.com>
Subject: BUG: sleeping function called from invalid context at
 arch/x86/mm/fault.c:LINE (2)
From: syzbot <syzbot+4af447792df4648be93b@syzkaller.appspotmail.com>
To: hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot hit the following crash on upstream commit
c18bb396d3d261ebbb4efbc05129c5d354c541e4 (Tue Apr 10 00:04:10 2018 +0000)
Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
syzbot dashboard link:  
https://syzkaller.appspot.com/bug?extid=4af447792df4648be93b

syzkaller reproducer:  
https://syzkaller.appspot.com/x/repro.syz?id=4934545564499968
Raw console output:  
https://syzkaller.appspot.com/x/log.txt?id=6277896712749056
Kernel config:  
https://syzkaller.appspot.com/x/.config?id=-1223000601505858474
compiler: gcc (GCC) 8.0.1 20180301 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4af447792df4648be93b@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed. See footer for  
details.
If you forward the report, please keep this part and the footer.

IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
IPVS: ftp: loaded support on port[0] = 21
BUG: sleeping function called from invalid context at  
arch/x86/mm/fault.c:1342
in_atomic(): 0, irqs_disabled(): 1, pid: 4512, name: blkid
1 lock held by blkid/4512:
  #0: 00000000d5b4e650 (&mm->mmap_sem){++++}, at:  
__do_page_fault+0x381/0xe40 arch/x86/mm/fault.c:1328
irq event stamp: 1812
hardirqs last  enabled at (1811): [<ffffffff87600096>]  
entry_SYSCALL_64_after_hwframe+0x52/0xb7
hardirqs last disabled at (1812): [<ffffffff87601402>]  
error_entry+0x72/0xd0 arch/x86/entry/entry_64.S:1261
softirqs last  enabled at (1804): [<ffffffff87800778>]  
__do_softirq+0x778/0xaf5 kernel/softirq.c:311
softirqs last disabled at (1797): [<ffffffff8146dd91>] invoke_softirq  
kernel/softirq.c:365 [inline]
softirqs last disabled at (1797): [<ffffffff8146dd91>] irq_exit+0x1d1/0x200  
kernel/softirq.c:405
CPU: 1 PID: 4512 Comm: blkid Not tainted 4.16.0+ #16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
BUG: unable to handle kernel paging request at 0000000041b5e1f3
PGD 1b4390067 P4D 1b4390067 PUD 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4512 Comm: blkid Tainted: G        W        4.16.0+ #16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:msr_write_intercepted arch/x86/kvm/vmx.c:2126 [inline]
RIP: 0010:vmx_vcpu_run+0xa3d/0x25f0 arch/x86/kvm/vmx.c:9884
RSP: 0018:ffff8801b5d27380 EFLAGS: 00010046
==================================================================
BUG: KASAN: stack-out-of-bounds in __show_regs.cold.7+0x4e/0x54a  
arch/x86/kernel/process_64.c:79
Read of size 8 at addr ffff8801b5d27300 by task blkid/4512

CPU: 1 PID: 4512 Comm: blkid Tainted: G        W        4.16.0+ #16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:

The buggy address belongs to the page:
page:ffffea0006d749c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: 0000000000000000 ffffea0006d70101 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801b5d27200: f2 f2 f2 f2 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2
  ffff8801b5d27280: f3 f3 f3 f3 f2 f2 f8 f2 f2 f2 f2 f2 f2 f2 00 00
> ffff8801b5d27300: f2 f2 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00
                    ^
  ffff8801b5d27380: f1 f1 f1 f1 00 f2 f2 f2 f2 f2 f2 f2 00 f2 f2 f2
  ffff8801b5d27400: f2 f2 f2 f2 00 f2 f2 f2 f3 f3 f3 f3 00 00 00 00
==================================================================


---
This bug is generated by a dumb bot. It may contain errors.
See https://goo.gl/tpsmEJ for details.
Direct all questions to syzkaller@googlegroups.com.

syzbot will keep track of this bug report.
If you forgot to add the Reported-by tag, once the fix for this bug is  
merged
into any tree, please reply to this email with:
#syz fix: exact-commit-title
If you want to test a patch for this bug, please reply with:
#syz test: git://repo/address.git branch
and provide the patch inline or as an attachment.
To mark this as a duplicate of another syzbot report, please reply with:
#syz dup: exact-subject-of-another-report
If it's a one-off invalid bug report, please reply with:
#syz invalid
Note: if the crash happens again, it will cause creation of a new bug  
report.
Note: all commands must start from beginning of the line in the email body.
