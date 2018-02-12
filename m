Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1885623-1518455494-2-14528802506332119611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518455493; b=R2UKwp8T3fCdiw2d4WKnpaFEpC3kzzMiLwbyKrdRrkEsZZT
    HsmhimpBPujFtt/6gDFaFJMiOI5JeK/XH7/kP9oo3B8DwGKfdEY2GaknR6A38Azl
    f1MrvQZMpMQM/WOeHXXDFwlyz8FVYviz6fT5s73MctAi+1vb+VsCUWJrMYNEXyTU
    B8mo0r0rLQwrhCzwEYwv0hYfLHDCk0QN4PrmqFGdgHz4eYGb9Qi33PNicp4jrWJ+
    r2/EhBwOBxvVM34LlSlQUy5wjFfGB6j0FFdHqDbkEFuPrqWUqJDizXdUxhe67Vju
    hQ3zL1OML/gdJyqr+Kjnuqss7em6C2LbqPLCxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518455493; bh=g
    kGleq8TxOC2hgX09Sz+zYgyHWZ4q7eV3ywMMEjmo3s=; b=Y+aEXdW1Sc0z0PU33
    n3g9Ke8ilA9WCcL3B3YD2n5kJuoGEnbeCla6g/WI7zVcAE7m5avfYXJeTTKpRrUP
    joeofbErCQI7xJk8La5zW1ezipzYYYJNDNPJqzPKnsgKiQNAevP+gd+WKqXLIwJa
    vK3ooRQKDX9/x8SzWv80GAFl8+uMbMgrdIApku8Es2fJ7Fznd6fsA2x8PRwqoRIL
    SsEPhw2E8m+AHghp5M9SV7FpLBEWthRGwnSTcvgOs7azyExRyH2MyAVi4w0GcDDL
    1nsg+hWIXj+3MEmur++EzsCaQAfghUI34WMT+3fAqN58h7wPmqjHeHHqmGrw8pjQ
    QVSLg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=nT4nxH4m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=epAK1QSs;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=nT4nxH4m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=epAK1QSs;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2248rvMCYuRPC/VFhvV1saIqxS2h9nOXwCzpazkk93CEsMJNA5l9UNOYd5UNTPV9d6rRkiadFfduRS2NhG9dUNI=
MIME-Version: 1.0
In-Reply-To: <CAHRSSEw7xrtANf2t4bUqMuz83MOo4s9+oGcDqSS7QpMoW7XGJQ@mail.gmail.com>
References: <001a113f65b6d93e74056505e572@google.com>
 <CACT4Y+ZcXVrPAFrxfAohQ=PdqcN8fwrFq4ZGwzP-K_sSUEOY8A@mail.gmail.com>
 <CAHRSSEw7xrtANf2t4bUqMuz83MOo4s9+oGcDqSS7QpMoW7XGJQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Feb 2018 18:11:02 +0100
Message-ID: <CACT4Y+bPoOWqCfz-jx13Vs+KVnrV2V6nn-nFDzjP=WgWYN1CWw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in remove_wait_queue
To: Todd Kjos <tkjos@google.com>
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
 Todd Kjos <tkjos@android.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 syzbot <syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com>,
 Martijn Coenen <maco@android.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 5:52 PM, Todd Kjos <tkjos@google.com> wrote:
> On Mon, Feb 12, 2018 at 7:57 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Mon, Feb 12, 2018 at 4:54 PM, syzbot
>> <syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com> wrote:
>> > Hello,
>> >
>> > syzbot hit the following crash on upstream commit
>> > f1517df8701c9f12dae9ce7f43a5d300a6917619 (Thu Feb 8 23:18:32 2018 +0000)
>> > Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux
>> >
>> > So far this crash happened 3 times on upstream.
>> > C reproducer is attached.
>> > syzkaller reproducer is attached.
>> > Raw console output is attached.
>> > compiler: gcc (GCC) 7.1.1 20170620
>> > .config is attached.
>> > user-space arch: i386
>>
>> This seems to be binder, so +binder maintainers.
>
>
> There's a fix queued for 4.16: https://patchwork.kernel.org/patch/10146253/

The commit on which it was triggered already includes this fix. So
there must be another bug.



>> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > Reported-by: syzbot+a2a3c4909716e271487e@syzkaller.appspotmail.com
>> > It will help syzbot understand when the bug is fixed. See footer for
>> > details.
>> > If you forward the report, please keep this part and the footer.
>> >
>> > ==================================================================
>> > BUG: KASAN: use-after-free in debug_spin_lock_before
>> > kernel/locking/spinlock_debug.c:83 [inline]
>> > BUG: KASAN: use-after-free in do_raw_spin_lock+0x1e0/0x220
>> > kernel/locking/spinlock_debug.c:112
>> > Read of size 4 at addr ffff8801db1608a4 by task syzkaller818560/5118
>> >
>> > CPU: 1 PID: 5118 Comm: syzkaller818560 Not tainted 4.15.0+ #215
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> > Google 01/01/2011
>> > Call Trace:
>> >  __dump_stack lib/dump_stack.c:17 [inline]
>> >  dump_stack+0x194/0x257 lib/dump_stack.c:53
>> >  print_address_description+0x73/0x250 mm/kasan/report.c:256
>> >  kasan_report_error mm/kasan/report.c:354 [inline]
>> >  kasan_report+0x23b/0x360 mm/kasan/report.c:412
>> >  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>> >  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>> >  do_raw_spin_lock+0x1e0/0x220 kernel/locking/spinlock_debug.c:112
>> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
>> >  _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:152
>> >  remove_wait_queue+0x81/0x350 kernel/sched/wait.c:50
>> >  ep_remove_wait_queue fs/eventpoll.c:595 [inline]
>> >  ep_unregister_pollwait.isra.7+0x18c/0x590 fs/eventpoll.c:613
>> >  ep_free+0x13f/0x320 fs/eventpoll.c:830
>> >  ep_eventpoll_release+0x44/0x60 fs/eventpoll.c:862
>> >  __fput+0x327/0x7e0 fs/file_table.c:209
>> >  ____fput+0x15/0x20 fs/file_table.c:243
>> >  task_work_run+0x199/0x270 kernel/task_work.c:113
>> >  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
>> >  exit_to_usermode_loop+0x275/0x2f0 arch/x86/entry/common.c:166
>> >  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>> >  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>> >  do_syscall_32_irqs_on arch/x86/entry/common.c:336 [inline]
>> >  do_fast_syscall_32+0xbe8/0xfa1 arch/x86/entry/common.c:392
>> >  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129
>> > RIP: 0023:0xf7f56c79
>> > RSP: 002b:00000000f7f3112c EFLAGS: 00000286 ORIG_RAX: 000000000000014a
>> > RAX: 0000000000000009 RBX: 0000000000000008 RCX: 0000000000000009
>> > RDX: 0000000000000000 RSI: 00000000000000f0 RDI: 0000000008120030
>> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> >
>> > Allocated by task 5105:
>> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>> >  set_track mm/kasan/kasan.c:459 [inline]
>> >  kasan_kmalloc+0xad/0xe0 mm/kasan/kasan.c:552
>> >  kmem_cache_alloc_trace+0x136/0x740 mm/slab.c:3607
>> >  kmalloc include/linux/slab.h:512 [inline]
>> >  kzalloc include/linux/slab.h:701 [inline]
>> >  binder_get_thread+0x1cf/0x870 drivers/android/binder.c:4279
>> >  binder_poll+0x8c/0x390 drivers/android/binder.c:4393
>> >  ep_item_poll.isra.10+0xf2/0x320 fs/eventpoll.c:885
>> >  ep_insert+0x6a2/0x1ac0 fs/eventpoll.c:1457
>> >  SYSC_epoll_ctl fs/eventpoll.c:2104 [inline]
>> >  SyS_epoll_ctl+0x12bf/0x1a80 fs/eventpoll.c:1990
>> >  do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
>> >  do_fast_syscall_32+0x3ee/0xfa1 arch/x86/entry/common.c:392
>> >  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129
>> >
>> > Freed by task 5105:
>> >  save_stack+0x43/0xd0 mm/kasan/kasan.c:447
>> >  set_track mm/kasan/kasan.c:459 [inline]
>> >  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:520
>> >  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:527
>> >  __cache_free mm/slab.c:3485 [inline]
>> >  kfree+0xd9/0x260 mm/slab.c:3800
>> >  binder_free_thread drivers/android/binder.c:4306 [inline]
>> >  binder_thread_dec_tmpref+0x27f/0x310 drivers/android/binder.c:1879
>> >  binder_thread_release+0x4a1/0x6b0 drivers/android/binder.c:4382
>> >  binder_ioctl+0xc02/0x1417 drivers/android/binder.c:4599
>> >  C_SYSC_ioctl fs/compat_ioctl.c:1461 [inline]
>> >  compat_SyS_ioctl+0x151/0x2a30 fs/compat_ioctl.c:1407
>> >  do_syscall_32_irqs_on arch/x86/entry/common.c:330 [inline]
>> >  do_fast_syscall_32+0x3ee/0xfa1 arch/x86/entry/common.c:392
>> >  entry_SYSENTER_compat+0x54/0x63 arch/x86/entry/entry_64_compat.S:129
>> >
>> > The buggy address belongs to the object at ffff8801db160800
>> >  which belongs to the cache kmalloc-512 of size 512
>> > The buggy address is located 164 bytes inside of
>> >  512-byte region [ffff8801db160800, ffff8801db160a00)
>> > The buggy address belongs to the page:
>> > page:ffffea00076c5800 count:1 mapcount:0 mapping:ffff8801db160080 index:0x0
>> > flags: 0x2fffc0000000100(slab)
>> > raw: 02fffc0000000100 ffff8801db160080 0000000000000000 0000000100000006
>> > raw: ffffea00073c6ea0 ffffea0007076ce0 ffff8801db000940 0000000000000000
>> > page dumped because: kasan: bad access detected
>> >
>> > Memory state around the buggy address:
>> >  ffff8801db160780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> >  ffff8801db160800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> >>
>> >> ffff8801db160880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> >
>> >                                ^
>> >  ffff8801db160900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> >  ffff8801db160980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> > ==================================================================
>> >
>> >
>> > ---
>> > This bug is generated by a dumb bot. It may contain errors.
>> > See https://goo.gl/tpsmEJ for details.
>> > Direct all questions to syzkaller@googlegroups.com.
>> >
>> > syzbot will keep track of this bug report.
>> > If you forgot to add the Reported-by tag, once the fix for this bug is
>> > merged
>> > into any tree, please reply to this email with:
>> > #syz fix: exact-commit-title
>> > If you want to test a patch for this bug, please reply with:
>> > #syz test: git://repo/address.git branch
>> > and provide the patch inline or as an attachment.
>> > To mark this as a duplicate of another syzbot report, please reply with:
>> > #syz dup: exact-subject-of-another-report
>> > If it's a one-off invalid bug report, please reply with:
>> > #syz invalid
>> > Note: if the crash happens again, it will cause creation of a new bug
>> > report.
>> > Note: all commands must start from beginning of the line in the email body.
>> >
>> > --
>> > You received this message because you are subscribed to the Google Groups
>> > "syzkaller-bugs" group.
>> > To unsubscribe from this group and stop receiving emails from it, send an
>> > email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> > To view this discussion on the web visit
>> > https://groups.google.com/d/msgid/syzkaller-bugs/001a113f65b6d93e74056505e572%40google.com.
>> > For more options, visit https://groups.google.com/d/optout.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
