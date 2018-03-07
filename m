Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2592411-1520409186-2-5119748327136058175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520409185; b=twwij3ImC9HPVFj6ppc6O8JYpakPZxdv3R/3RnCt9awh/zZ
    +W9u64eSAmrD+9SiQQcaT6pbCxCKCiigaHbSGVPT1kHaSu772jvagVmfuF2irv3q
    v1Dkg//RS0KUD/Teb3UiNXj1w/vrQ8xQNCjvFScqNmNQeTsEWSNUUmWRbXaeVbpg
    Tdex2kLdnbHGf0gSD6sYX2FUNBIQ/MLT7OfMVJ0YUVQn/fINUoIpqaSy0LEOAJ8E
    vVwvuqNxB1hVyqYHHunUfvaJFrajRzcE18sjx7IarCo5hDoNIGVvzeGy9IqV4g/K
    cENoK7Wp2IQXA2Yu6xX9K5b/uGYAtG9f/Dv2mrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520409185; bh=X
    PRe8Eq4efYJPrRcA2dHPjzXx+Y7NBUUkshXI0z0YIo=; b=YNZt0I6Bn7yI6xtnP
    9NOen0vHo8NZ5XMyhBlYky1C22q1TPDkAU0zJzpAcEN4JgSRkFuy2qj2w8OGZ2Iz
    ZS+/JQq47wI4WQiY5j+rB79rFcNsi/pfzTvlettVFs80KTLZMhOBgUsXDSRpNKaF
    o00LBiMJYkx8bkK77ILtPVnyzFXexp8EHEpNyEvkTl5MyeFBSbj7+7CipgnKokqF
    Y0TraRdvJlH7A8LEYCpn+0M7XQ0d3jrcO9mn3uj1XfOkYMnjl9LUXlvjrULaWut6
    KdvSgnCUVDT/3D+nc9jSaOq9NEh3gH4aq5P/sB1/ib/2obFXeeg2ZQjBfKmFGQFo
    nM6Qg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=SVuXbMUL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=byFYehI5;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=SVuXbMUL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-51 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=byFYehI5;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELscYS1Eg0qTfdKTh6divBdwvFfar12p8bwRVGMk484cETBkfy67Uebi5TBnUg852zJ03sBteutHgaDO8WDey0k=
MIME-Version: 1.0
In-Reply-To: <001a1140c614ad7a730566ba3f61@google.com>
References: <001a1140c614ad7a730566ba3f61@google.com>
From: Martijn Coenen <maco@android.com>
Date: Wed, 7 Mar 2018 08:52:54 +0100
Message-ID: <CAB0TPYH99OTEd14DfFJFG=ry265D5zkNeBXewKMZ922WDfjuJg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __list_del_entry_valid (3)
To: syzbot <syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Todd Kjos <tkjos@android.com>, Greg KH <gregkh@linuxfoundation.org>,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 9:30 AM, syzbot
<syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot hit the following crash on upstream commit
> 094b58e1040a44f991d7ab628035e69c4d6b79c9 (Mon Mar 5 19:57:06 2018 +0000)
> Merge tag 'linux-kselftest-4.16-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest

I'll take a look at this one,

Martijn

>
> Unfortunately, I don't have any reproducer for this crash yet.
> Raw console output is attached.
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached.
> user-space arch: i386
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+09e05aba06723a94d43d@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
>
> binder: release 6174:6185 transaction 4 in, still active
> binder: send failed reply for transaction 4 to 6174:6185
> binder: 6194:6198 ERROR: BC_REGISTER_LOOPER called without request
> ==================================================================
> binder: 6198 RLIMIT_NICE not set
> BUG: KASAN: use-after-free in __list_del_entry_valid+0x144/0x150
> lib/list_debug.c:54
> Read of size 8 at addr ffff8801daede810 by task kworker/1:1/24
>
> CPU: 1 PID: 24 Comm: kworker/1:1 Not tainted 4.16.0-rc4+ #252
> binder: BINDER_SET_CONTEXT_MGR already set
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Workqueue: events binder_deferred_func
> Call Trace:
>  __dump_stack lib/dump_stack.c:17 [inline]
>  dump_stack+0x194/0x24d lib/dump_stack.c:53
> binder: 6194:6206 got new transaction with bad transaction stack,
> transaction 9 has target 6194:0
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23c/0x360 mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  __list_del_entry_valid+0x144/0x150 lib/list_debug.c:54
>  __list_del_entry include/linux/list.h:117 [inline]
>  list_del_init include/linux/list.h:159 [inline]
>  binder_dequeue_work_head_ilocked drivers/android/binder.c:893 [inline]
>  binder_dequeue_work_head drivers/android/binder.c:913 [inline]
>  binder_release_work+0x163/0x490 drivers/android/binder.c:4191
> binder: 6194:6206 transaction failed 29201/-71, size 0-0 line 2875
> binder: 6191:6205 ioctl 40046207 0 returned -16
>  binder_thread_release+0x4d0/0x720 drivers/android/binder.c:4396
>  binder_deferred_release drivers/android/binder.c:4939 [inline]
>  binder_deferred_func+0x4f4/0x1340 drivers/android/binder.c:5022
> binder: BINDER_SET_CONTEXT_MGR already set
> binder: 6200:6207 ioctl 40046207 0 returned -16
> binder: 6191:6208 ERROR: BC_REGISTER_LOOPER called without request
>  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
> binder: 6208 RLIMIT_NICE not set
> binder: 6200:6212 ERROR: BC_REGISTER_LOOPER called without request
> binder: 6212 RLIMIT_NICE not set
> binder: 6191:6213 got new transaction with bad transaction stack,
> transaction 11 has target 6194:0
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
> binder: 6191:6213 transaction failed 29201/-71, size 0-0 line 2875
> binder: 6198 RLIMIT_NICE not set
> binder: release 6200:6207 transaction 14 out, still active
> binder: undelivered TRANSACTION_COMPLETE
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
>
> Allocated by task 6185:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>  kmem_cache_alloc_trace+0x136/0x740 mm/slab.c:3607
>  kmalloc include/linux/slab.h:512 [inline]
>  kzalloc include/linux/slab.h:701 [inline]
>  binder_transaction+0x13c1/0x81c0 drivers/android/binder.c:2900
>  binder_thread_write+0xb50/0x3840 drivers/android/binder.c:3513
>  binder_ioctl_write_read.isra.38+0x261/0xcb0 drivers/android/binder.c:4451
>  binder_ioctl+0xb72/0x1417 drivers/android/binder.c:4591
>  C_SYSC_ioctl fs/compat_ioctl.c:1461 [inline]
>  compat_SyS_ioctl+0x151/0x2a30 fs/compat_ioctl.c:1407
>  do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
>  do_fast_syscall_32+0x3ec/0xf9f arch/x86/entry/common.c:392
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
>
> Freed by task 24:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>  set_track mm/kasan/kasan.c:459 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>  __cache_free mm/slab.c:3485 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3800
>  binder_free_transaction+0x6a/0x90 drivers/android/binder.c:1966
>  binder_send_failed_reply+0x1c9/0x380 drivers/android/binder.c:2005
>  binder_thread_release+0x4bb/0x720 drivers/android/binder.c:4395
>  binder_deferred_release drivers/android/binder.c:4939 [inline]
>  binder_deferred_func+0x4f4/0x1340 drivers/android/binder.c:5022
>  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
>  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
>  kthread+0x33c/0x400 kernel/kthread.c:238
>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
>
> The buggy address belongs to the object at ffff8801daede800
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 16 bytes inside of
>  192-byte region [ffff8801daede800, ffff8801daede8c0)
> The buggy address belongs to the page:
> page:ffffea00076bb780 count:1 mapcount:0 mapping:ffff8801daede000 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801daede000 0000000000000000 0000000100000010
> raw: ffffea0006e746e0 ffffea0006f0b620 ffff8801dac00040 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8801daede700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801daede780: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>
>> ffff8801daede800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>
>                          ^
>  ffff8801daede880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff8801daede900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
