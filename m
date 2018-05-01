Return-Path: <3oe_nWgkbAPww23oeppivettmh.ksskpiywivgsrxirx.gsq@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525149601; cv=none;
        d=google.com; s=arc-20160816;
        b=iSkxGNCjEFzvpT+8J8nUdT0jnbNd2OcZI8u/Tyt17a4FHo+Y9K8IzzCa0vi8ctsVLI
         sUBa5IMQAFfE1P7BvxyPj+IZ00j0dzW1Yek/+A8qTeJUYV+08bURR08pXHQ2qyWDvbkD
         Olfj4nD14BuRiLvacCMzbChUE/vvemziTlneqanMp75cMtxXTHONTsqDgcNu9H29jw1J
         Owz6seD3EYM8yuUptPfvnnusfm6LaHJQW3d8TlrN2KLddmubJ1KgW3mQ/h9v8uRf+xLT
         i2LXrvsj1hOkGHaCH3SODy5IyoJPMi+wpCf5deT0VEhP55842qzpclzfrd97Z3u9hhwQ
         GN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:from:subject:message-id:date:mime-version
         :arc-authentication-results;
        bh=h+xs1ePZKm8HQjfm26K8Vt9/ZTQZt/tJ9sP2a4XXr8M=;
        b=DhVaUmspky8COnwZ6wgQFilkl7U1OLYufYZ9gdGwH0KRwyMiVyX/20KC4Lm71DqIwh
         WsE4yI7ubfKm4qq6vpraYT8TxOakpRu/J8fSzpmBKFeNnzpj8hRotpqr7fPv9T9PiS5m
         +Zxm0nbCVoo8ULPznWop3cya7xwAlttw/paw+4ZXLdGhMu4oFFTKERzR/rHMcpYrXcg8
         cukgz4Dc99HMgnkd0qcSt2VNp4nlehnyh2CS5Jt32Pvvi/6ORrF6ZqqgOTLixxrrbEix
         u8m7y2LjHvwop2YxY9cdGlI8MWaPHYabLyLVlzwMnu7u/aZTlAGRH8oQ1rdubFJskr0e
         0g9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of 3oe_nwgkbapww23oeppivettmh.ksskpiywivgsrxirx.gsq@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3oe_nWgkbAPww23oeppivettmh.ksskpiywivgsrxirx.gsq@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of 3oe_nwgkbapww23oeppivettmh.ksskpiywivgsrxirx.gsq@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com designates 209.85.220.69 as permitted sender) smtp.mailfrom=3oe_nWgkbAPww23oeppivettmh.ksskpiywivgsrxirx.gsq@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=appspotmail.com
X-Google-Smtp-Source: AB8JxZqhiKlbYYfC/d6eOV4k8QrV+WtR0lc9VkGWHFVSdAx/OOcWCkarRryAzvbDiOInb9gNCyBwHW4gZliwdLZ+/SJ1bBCjUgDN
MIME-Version: 1.0
Date: Mon, 30 Apr 2018 21:40:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b1d65056b1d9046@google.com>
Subject: general protection fault in n_tty_set_termios
From: syzbot <syzbot+ed02be0ad5f26ef4e31b@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599235269199846482?=
X-GMAIL-MSGID: =?utf-8?q?1599235269199846482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

syzbot found the following crash on:

HEAD commit:    8188fc8bef8c Merge  
git://git.kernel.org/pub/scm/linux/kerne...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?id=5093449355231232
kernel config:   
https://syzkaller.appspot.com/x/.config?id=6493557782959164711
dashboard link: https://syzkaller.appspot.com/bug?extid=ed02be0ad5f26ef4e31b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller  
repro:https://syzkaller.appspot.com/x/repro.syz?id=6543533393575936
C reproducer:   https://syzkaller.appspot.com/x/repro.c?id=5754063643738112

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ed02be0ad5f26ef4e31b@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 4509 Comm: syz-executor654 Not tainted 4.17.0-rc3+ #26
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:n_tty_set_termios+0x2d9/0xe80 drivers/tty/n_tty.c:1782
RSP: 0018:ffff8801b42df698 EFLAGS: 00010203
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000000000b
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000005
RBP: ffff8801b42df6d0 R08: ffff8801d97aa000 R09: 0000000000000002
R10: ffff8801d97aa888 R11: ffff8801d97aa000 R12: ffff8801d9bea500
R13: ffff8801d9bea8b4 R14: 000000000000005d R15: ffff8801b42df730
FS:  00007f082d3d7700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f082d3b5e78 CR3: 00000001ac8aa000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tty_set_termios+0x7a0/0xac0 drivers/tty/tty_ioctl.c:341
  set_termios+0x41e/0x7d0 drivers/tty/tty_ioctl.c:414
  tty_mode_ioctl+0x855/0xb50 drivers/tty/tty_ioctl.c:749
  n_tty_ioctl_helper+0x54/0x3b0 drivers/tty/tty_ioctl.c:940
  n_tty_ioctl+0x54/0x320 drivers/tty/n_tty.c:2441
  tty_ioctl+0x5e1/0x1870 drivers/tty/tty_io.c:2655
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:500 [inline]
  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
  __do_sys_ioctl fs/ioctl.c:708 [inline]
  __se_sys_ioctl fs/ioctl.c:706 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445d19
RSP: 002b:00007f082d3d6da8 EFLAGS: 00000297 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac3c RCX: 0000000000445d19
RDX: 0000000020000040 RSI: 0000000000005402 RDI: 0000000000000033
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 00000000006dac38
R13: 6d74702f7665642f R14: 00007f082d3d79c0 R15: 0000000000000007
Code: 8b 45 d0 31 ff 83 e0 02 89 c6 89 45 d0 e8 50 4a e1 fd 8b 45 d0 4c 89  
f1 48 ba 00 00 00 00 00 fc ff df 85 c0 0f 95 c0 48 c1 e9 03 <0f> b6 14 11  
4c 89 f1 83 e1 07 38 ca 7f 08 84 d2 0f 85 96 09 00
RIP: n_tty_set_termios+0x2d9/0xe80 drivers/tty/n_tty.c:1782 RSP:  
ffff8801b42df698
---[ end trace b89be7398398fc5c ]---


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

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
