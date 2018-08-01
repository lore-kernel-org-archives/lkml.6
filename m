Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89513C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB7120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/yiQBya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB7120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbeHAKPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:15:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387959AbeHAKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:15:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so2374732pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vuD4B/omTKbF53qpXutE+SGENoGNSQUgBRUesq4aQ4E=;
        b=s/yiQByaevLn53+veFGKWUkz23c5LTy7i+/+NGYIYaAeGjaCemrilSzqCSS6/xgtvG
         vj0i8hfdnaiP0PyXkQhOfpGXpNWxt2RnUFVFo4TZxrU2BMmZtDkRUK3oPWJkvuXNu8Jf
         Qk96VZ6GDPVZjU10s+opFRYUPL5HStYaj4pr2fzJRWCuW/YNhP0YDpRJAgBvqUZqhFv+
         j/JxChfztuWZrxmhTzZxIoEFj6pggyJ4peU+YfkAFBVeAWrMfLfeuth9aSXIBG41XOf5
         J/N5E7xgxgv9jxWQX9RNSFR1RfvAE+I76BiN9KuONGbR3J6hpyT48gxelfAhnDY6mwev
         7RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vuD4B/omTKbF53qpXutE+SGENoGNSQUgBRUesq4aQ4E=;
        b=OeKASCDFXwpxU9yBybsx5FmZC5iVAwLeZWpSr3kKB1s4xfPthXvBaWT8PRFSu9L7eK
         KkA0siI/DYQV3SJqDTiIGLRxLXwOTeasjZFB0gTbV287jePuQCIY/s3RhgOdVAp5Ju41
         9lVv9EJSO+HFGL0iBBogyMfATo7R3MZgnVDy3mMsEB3hbX36axfLjVsdWovDwUpEZU5n
         Jz5JZjvtCQ8s7SyOnc7ADk33LAUAYj59gLn6XjsdnswR1DCm8D0MRydlGQpPJICmSB+6
         fLJE6vHsRxzp6UVP3jHDUfxtZ4kqmb61OBoNtkgQd+Te6Yj7wWQqlLXJ+hBZbB9a5Njp
         /c9A==
X-Gm-Message-State: AOUpUlEJDl+Upt9ANbYlqbS28I+0Q9UgelS7dKBx1xoq6VVHl8kLcIQ9
        iVqnOVF+22qckLKSrGPpcIfLtqWF7RbwRY0pqPxMTMA9Ero=
X-Google-Smtp-Source: AAOMgpddZkGj0AAph31hIIu1/mF/7hSbnPoawS4eLObahk8zaHbnUdMpR4Vv3gzxvAZIclIYQCVq55MACjTjjzSBWD8=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr1188254pgu.96.1533112240220;
 Wed, 01 Aug 2018 01:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 01:30:19
 -0700 (PDT)
In-Reply-To: <20180731154351.GF17816@stefanha-x1.localdomain>
References: <000000000000b4f77905723b70ee@google.com> <20180731154351.GF17816@stefanha-x1.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 10:30:19 +0200
Message-ID: <CACT4Y+YG-n1iKeQKHiVK73fkSumFgYNdye1yCB1nJW7xgN-9Kw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in vhost_transport_send_pkt
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     syzbot <syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com>,
        Jason Wang <jasowang@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 5:43 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Mon, Jul 30, 2018 at 11:15:03AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    acb1872577b3 Linux 4.18-rc7
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14eb932c400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2dc0cd7c2eefb46f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bd391451452fb0b93039
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com
>>
>> netlink: 'syz-executor5': attribute type 2 has an invalid length.
>> binder: 28577:28588 transaction failed 29189/-22, size 0-0 line 2852
>> ==================================================================
>> BUG: KASAN: use-after-free in debug_spin_lock_before
>> kernel/locking/spinlock_debug.c:83 [inline]
>> BUG: KASAN: use-after-free in do_raw_spin_lock+0x1c0/0x200
>> kernel/locking/spinlock_debug.c:112
>> Read of size 4 at addr ffff880194d0ec6c by task syz-executor4/28583
>>
>> CPU: 1 PID: 28583 Comm: syz-executor4 Not tainted 4.18.0-rc7+ #169
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/report.c:432
>>  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
>>  do_raw_spin_lock+0x1c0/0x200 kernel/locking/spinlock_debug.c:112
>>  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:136 [inline]
>>  _raw_spin_lock_bh+0x39/0x40 kernel/locking/spinlock.c:168
>>  spin_lock_bh include/linux/spinlock.h:315 [inline]
>>  vhost_transport_send_pkt+0x12e/0x380 drivers/vhost/vsock.c:223
>
> Thanks for the vsock fuzzing.  This is a useful bug report.

Thanks. But note that syzkaller descriptions for vsock were written by
people who have no idea what is vsock whatsoever:
https://github.com/google/syzkaller/blob/master/sys/linux/socket_vnet.txt
So most likely fuzzing is inefficient and does not test the most
interesting parts of vsock.


> It looks like vhost_vsock_get() needs to involve a reference count so
> that vhost_vsock instances cannot be freed while something is still
> using them.
>
> The reproducer probably involves racing close() with connect().
>
> I am looking into a fix.
>
> Stefan
>
>>  virtio_transport_send_pkt_info+0x31d/0x460
>> net/vmw_vsock/virtio_transport_common.c:190
>>  virtio_transport_connect+0x17c/0x220
>> net/vmw_vsock/virtio_transport_common.c:588
>>  vsock_stream_connect+0x4fb/0xfc0 net/vmw_vsock/af_vsock.c:1197
>>  __sys_connect+0x37d/0x4c0 net/socket.c:1673
>>  __do_sys_connect net/socket.c:1684 [inline]
>>  __se_sys_connect net/socket.c:1681 [inline]
>>  __x64_sys_connect+0x73/0xb0 net/socket.c:1681
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x456a09
>> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
>> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
>> 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007fa4aee5bc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
>> RAX: ffffffffffffffda RBX: 00007fa4aee5c6d4 RCX: 0000000000456a09
>> RDX: 0000000000000010 RSI: 0000000020000200 RDI: 0000000000000016
>> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>> R13: 00000000004ca838 R14: 00000000004c25fb R15: 0000000000000000
>>
>> Allocated by task 28583:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>>  __do_kmalloc_node mm/slab.c:3682 [inline]
>>  __kmalloc_node+0x47/0x70 mm/slab.c:3689
>>  kmalloc_node include/linux/slab.h:555 [inline]
>>  kvmalloc_node+0xb9/0xf0 mm/util.c:423
>>  kvmalloc include/linux/mm.h:573 [inline]
>>  vhost_vsock_dev_open+0xa2/0x5a0 drivers/vhost/vsock.c:511
>>  misc_open+0x3ca/0x560 drivers/char/misc.c:141
>>  chrdev_open+0x25a/0x770 fs/char_dev.c:417
>>  do_dentry_open+0x818/0xe40 fs/open.c:794
>>  vfs_open+0x139/0x230 fs/open.c:908
>>  do_last fs/namei.c:3399 [inline]
>>  path_openat+0x174a/0x4e10 fs/namei.c:3540
>>  do_filp_open+0x255/0x380 fs/namei.c:3574
>>  do_sys_open+0x584/0x760 fs/open.c:1101
>>  __do_sys_openat fs/open.c:1128 [inline]
>>  __se_sys_openat fs/open.c:1122 [inline]
>>  __x64_sys_openat+0x9d/0x100 fs/open.c:1122
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Freed by task 28579:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>>  __cache_free mm/slab.c:3498 [inline]
>>  kfree+0xd9/0x260 mm/slab.c:3813
>>  kvfree+0x61/0x70 mm/util.c:442
>>  vhost_vsock_free drivers/vhost/vsock.c:499 [inline]
>>  vhost_vsock_dev_release+0x4fd/0x750 drivers/vhost/vsock.c:604
>>  __fput+0x355/0x8b0 fs/file_table.c:209
>>  ____fput+0x15/0x20 fs/file_table.c:243
>>  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>>  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>>  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
>>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The buggy address belongs to the object at ffff880194d05f80
>>  which belongs to the cache kmalloc-65536 of size 65536
>> The buggy address is located 36076 bytes inside of
>>  65536-byte region [ffff880194d05f80, ffff880194d15f80)
>> The buggy address belongs to the page:
>> page:ffffea0006534000 count:1 mapcount:0 mapping:ffff8801dac02500 index:0x0
>> compound_mapcount: 0
>> flags: 0x2fffc0000008100(slab|head)
>> raw: 02fffc0000008100 ffffea0006599808 ffff8801dac01e48 ffff8801dac02500
>> raw: 0000000000000000 ffff880194d05f80 0000000100000001 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff880194d0eb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff880194d0eb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> > ffff880194d0ec00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                                           ^
>>  ffff880194d0ec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff880194d0ed00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20180731154351.GF17816%40stefanha-x1.localdomain.
> For more options, visit https://groups.google.com/d/optout.
