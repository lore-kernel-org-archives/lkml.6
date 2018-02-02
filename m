Return-Path: <ebiggers3@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517613794; cv=none;
        d=google.com; s=arc-20160816;
        b=mUuQI21pgg+XP+l4/0DDFN5+I5v6J1iTohWBT7Hmg3uOOaVd+wmnVCRdd25tkBkprk
         xEvdX43Zs9wRkQ/PGcWYJmZy5coGJKb1JnL/0mbuvmPjVkzuBI3Yf2d4lVdHXhFp/tyg
         y9XQNFvo5OSprBKGmFW6TUF+FxjLkj9krIp2S2dpxDA2f39nXVtqeiNfg7gwxwJvvkQf
         rMWuZkvYtl/WkDNvy558cF0/wnWPNNxIBVJbQJdZj0H44EPmc4IXmDf2S7ALo1i1bQYz
         YflrjOm9NBVOogzTMlSU4yvZ7rNIKzhVAi9rgez7nAi56yjYBkbwQHTBQrtpkNOEmDtJ
         w0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=k3FoKlGsXFgz69H0L9ucTHz4qjprbeqST1L638B5+zI=;
        b=uhlZPutg6IuJPbZra6pIbcqF/gpZYSAmJZXnCRN1SNkhDRT/jq4B5S8iOFkb2kR2rT
         dS/ynJ3COej1l3pH8CSH6qdKoQ/02oZnJPoctloCcjQedrlgeMFaCR97t/IFiG7i5hfe
         hrwYBqkLIL8Yj8js9iiK9JW/HGmT7JOl8OmYvQ023Z5rIQitMdFlLTP/ErbdIl3jdjq8
         X0l/ScIfN9mIY3uKIT5tkavJyerF+iXnnqMi2a2yD31EYb6bjnMEFofoIYH4NQD//Mpm
         A73lNGLA5u5eqPSzyw8p/fkgE7p8fCP63IFVK9FRtAJ4LLq6WKUeJBgUhIMor+j28uhR
         N/vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lnWpxc6c;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lnWpxc6c;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224dBH8v5oAMNXc8OOKDOWr9sVQpq0736O3wJVaAP6pH5AevWvQ9ptTM/O/hdHcHsilaJjD9fw==
Date: Fri, 2 Feb 2018 15:23:10 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: syzbot <syzbot+9cd6f6d80e1a5205f2f6@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, dave.jiang@intel.com,
	gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mingo@kernel.org, syzkaller-bugs@googlegroups.com,
	zaitcev@redhat.com
Subject: Re: KASAN: use-after-free Read in mon_bin_vma_fault
Message-ID: <20180202232310.xa3mezyibvzfbbom@gmail.com>
References: <001a113f8d56b52d6605616c2b84@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a113f8d56b52d6605616c2b84@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1588060070485715658?=
X-GMAIL-MSGID: =?utf-8?q?1591333401967719502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Dec 28, 2017 at 12:15:01PM -0800, syzbot wrote:
> Hello,
> 
> syzkaller hit the following crash on
> beacbc68ac3e23821a681adb30b45dc55b17488d
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> Unfortunately, I don't have any reproducer for this bug yet.
> 
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+9cd6f6d80e1a5205f2f6@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> ==================================================================
> BUG: KASAN: use-after-free in mon_bin_vma_fault+0x378/0x400
> drivers/usb/mon/mon_bin.c:1238
> Read of size 8 at addr ffff8801cd040080 by task syz-executor1/5424
> 
> CPU: 1 PID: 5424 Comm: syz-executor1 Not tainted 4.15.0-rc5+ #238
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:53
>  print_address_description+0x73/0x250 mm/kasan/report.c:252
>  kasan_report_error mm/kasan/report.c:351 [inline]
>  kasan_report+0x25b/0x340 mm/kasan/report.c:409
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:430
>  mon_bin_vma_fault+0x378/0x400 drivers/usb/mon/mon_bin.c:1238
>  __do_fault+0xeb/0x30f mm/memory.c:3196
>  do_read_fault mm/memory.c:3606 [inline]
>  do_fault mm/memory.c:3706 [inline]
>  handle_pte_fault mm/memory.c:3937 [inline]
>  __handle_mm_fault+0x1d8f/0x3ce0 mm/memory.c:4061
>  handle_mm_fault+0x334/0x8d0 mm/memory.c:4098
>  faultin_page mm/gup.c:502 [inline]
>  __get_user_pages+0x50c/0x15f0 mm/gup.c:699
>  populate_vma_page_range+0x20e/0x2f0 mm/gup.c:1216
>  __mm_populate+0x23a/0x450 mm/gup.c:1266
>  mm_populate include/linux/mm.h:2226 [inline]
>  vm_mmap_pgoff+0x241/0x280 mm/util.c:338
>  SYSC_mmap_pgoff mm/mmap.c:1533 [inline]
>  SyS_mmap_pgoff+0x462/0x5f0 mm/mmap.c:1491
>  SYSC_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
>  SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:91
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> RIP: 0033:0x452ac9
> RSP: 002b:00007f7721b03c58 EFLAGS: 00000212 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 000000000071bea0 RCX: 0000000000452ac9
> RDX: 0000000001000004 RSI: 0000000000004000 RDI: 0000000020ac6000
> RBP: 000000000000039b R08: 0000000000000014 R09: 0000000000000000
> R10: 0000000000008011 R11: 0000000000000212 R12: 00000000006f2728
> R13: 00000000ffffffff R14: 00007f7721b046d4 R15: 0000000000000000
> 
> Allocated by task 5424:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:551
>  kmem_cache_alloc_trace+0x136/0x750 mm/slab.c:3610
>  kmalloc include/linux/slab.h:499 [inline]
>  kzalloc include/linux/slab.h:688 [inline]
>  mon_bin_open+0x1ae/0x4a0 drivers/usb/mon/mon_bin.c:703
>  chrdev_open+0x257/0x730 fs/char_dev.c:417
>  do_dentry_open+0x667/0xd40 fs/open.c:752
>  vfs_open+0x107/0x220 fs/open.c:866
>  do_last fs/namei.c:3379 [inline]
>  path_openat+0x1151/0x3530 fs/namei.c:3519
>  do_filp_open+0x25b/0x3b0 fs/namei.c:3554
>  do_sys_open+0x502/0x6d0 fs/open.c:1059
>  SYSC_open fs/open.c:1077 [inline]
>  SyS_open+0x2d/0x40 fs/open.c:1072
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> 
> Freed by task 5433:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_slab_free+0x71/0xc0 mm/kasan/kasan.c:524
>  __cache_free mm/slab.c:3488 [inline]
>  kfree+0xd6/0x260 mm/slab.c:3803
>  mon_bin_ioctl+0x68d/0xd40 drivers/usb/mon/mon_bin.c:1040
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:686
>  SYSC_ioctl fs/ioctl.c:701 [inline]
>  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:692
>  entry_SYSCALL_64_fastpath+0x1f/0x96
> 
> The buggy address belongs to the object at ffff8801cd040080
>  which belongs to the cache kmalloc-2048 of size 2048
> The buggy address is located 0 bytes inside of
>  2048-byte region [ffff8801cd040080, ffff8801cd040880)
> The buggy address belongs to the page:
> page:000000003d43a99d count:1 mapcount:0 mapping:0000000083654cb9 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffff8801cd040080 0000000000000000 0000000100000003
> raw: ffffea00072a2e20 ffffea00071e6920 ffff8801db000c40 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801cd03ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8801cd040000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > ffff8801cd040080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff8801cd040100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cd040180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title

No reproducer, but this seems to have stopped happening; I'm guessing it was
fixed by commit 46eb14a6e158:

#syz fix: USB: fix usbmon BUG trigger

- Eric
