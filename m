Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556DDC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D090720866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDaXxl8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D090720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIMOIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:08:31 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50337 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbeIMOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:08:31 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so6851226ite.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2V0AbW2ir1fyCygPxvYG3ka2D+OuEACgc44CF0Ec6Rw=;
        b=dDaXxl8pg0okyCyNQLyRPZsEJh2eQ+JQlNqBDn0OSx7AT26dnvD79tjWFPbbYlu7j5
         IVOUbzI8E/CM3x6b5k5tvxBX/k+seYuXZGPtN45Gj8/r3h9228vwqc55B7hbPWeGMGtc
         uqDo1/D6Zd1fCXQrF7avn5H/A6FDYqAvyGmoimefU5KaxIBoyoACRYKO4aZHOlprIoMh
         Q28fQCrHYoHaMSwsrOHsgaMx5t+aEAmktCbJNN0e4sjV0kDgVC1ozEB11hl28znFG+j3
         VxCpCKgMJxpCWPq5UhLyqOl+/GW80jRUS4qcvvEu0Hu1VdwBU1D3L9PpEcNUa8ZAL5yT
         Mr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2V0AbW2ir1fyCygPxvYG3ka2D+OuEACgc44CF0Ec6Rw=;
        b=pTHru2XPur0wjEw9+6lEqfCb8jZbJ5R5Sy4OHeZ9OgKxMRGFJyrREUXgFSdrwkltNX
         A9xsnO7Mbf+t+EEZ2YrTwBfx4Y1oH/CO/fG5poy+0QbmqUjlmV8SNm416m0cY13T4p9D
         HuC7+XVt6m7qdjviBT5BB+jku0IQB1INN8ZerDfK0gFEGXdx/AeCtQgrXyy0+atYEXMU
         qbAJTbXSjlHR6n/WydjgE/tdx1vKIDl2+5J77OsKWWEZmF7waGq6mTXzL5CLQIBPg7jj
         AXPs4keeVc2FvJDP4czoo7ileZm0Zu6jP87ryd7wsJ/HdERAj5o+F4oS0zcerqakpOoX
         Ek/Q==
X-Gm-Message-State: APzg51BBgNX4SukcgYVD5sPAjR9xprutGh2/tsQK19okIgppLLPNGLr9
        l4RRizxHSDjjE5nd8KEmKeEKNgkEAhYwLsICGMDcWw==
X-Google-Smtp-Source: ANB0VdZ4CK64I2zEURZzXGABWrajAEozKG9vmmWBGPLIxtqb0kKdfqjg5Jwzr1EaoF4l4SEe4OPcYfzamet7Thq9vno=
X-Received: by 2002:a02:c04e:: with SMTP id u14-v6mr5704760jam.110.1536829199288;
 Thu, 13 Sep 2018 01:59:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 01:59:38
 -0700 (PDT)
In-Reply-To: <5882d989-8e9d-0ae1-1b2d-3ba431e97eb6@virtuozzo.com>
References: <0000000000001e09780575bc189a@google.com> <5882d989-8e9d-0ae1-1b2d-3ba431e97eb6@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Sep 2018 10:59:38 +0200
Message-ID: <CACT4Y+ZKbErQHXjytpcCsgSYgfOL-fwCrQK3OHM9RGgamswvcA@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in fuse_dev_do_read
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     syzbot <syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:51 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> Hi,
>
> On 13.09.2018 11:00, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    54eda9df17f3 Merge tag 'pci-v4.19-fixes-1' of git://git.ke..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=109a3d9e400000
>
> what are requests id written here:
>
>    write$FUSE_INIT(r0, &(0x7f0000000100)={0x50, 0x0, 0x1}, 0x50)
>    write$FUSE_STATFS(r0, &(0x7f0000000040)={0x60, 0x0, 0x2, {{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xfffffffffffffffa}}}, 0x60)
>
> ?

Hi Kirill,

It may be easier to contrast these numbers with struct definitions here:
https://github.com/google/syzkaller/blob/master/sys/linux/fuse.txt

But passing this fragment through syskaller's tools/syz-prog2c gives
me the following (exact binary layout:

int main(void)
{
  syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);

  *(uint32_t*)0x20000100 = 0x50;
  *(uint32_t*)0x20000104 = 0;
  *(uint64_t*)0x20000108 = 1;
  *(uint32_t*)0x20000110 = 7;
  *(uint32_t*)0x20000114 = 0x1b;
  *(uint32_t*)0x20000118 = 0;
  *(uint32_t*)0x2000011c = 0;
  *(uint16_t*)0x20000120 = 0;
  *(uint16_t*)0x20000122 = 0;
  *(uint32_t*)0x20000124 = 0;
  *(uint32_t*)0x20000128 = 0;
  *(uint32_t*)0x2000012c = 0;
  *(uint32_t*)0x20000130 = 0;
  *(uint32_t*)0x20000134 = 0;
  *(uint32_t*)0x20000138 = 0;
  *(uint32_t*)0x2000013c = 0;
  *(uint32_t*)0x20000140 = 0;
  *(uint32_t*)0x20000144 = 0;
  *(uint32_t*)0x20000148 = 0;
  *(uint32_t*)0x2000014c = 0;
  syscall(__NR_write, -1, 0x20000100, 0x50);
  *(uint32_t*)0x20000040 = 0x60;
  *(uint32_t*)0x20000044 = 0;
  *(uint64_t*)0x20000048 = 2;
  *(uint64_t*)0x20000050 = 0;
  *(uint64_t*)0x20000058 = 0;
  *(uint64_t*)0x20000060 = 0;
  *(uint64_t*)0x20000068 = 0;
  *(uint64_t*)0x20000070 = 0;
  *(uint32_t*)0x20000078 = 0;
  *(uint32_t*)0x2000007c = 0;
  *(uint32_t*)0x20000080 = 0xfffffffa;
  *(uint32_t*)0x20000084 = 0;
  *(uint32_t*)0x20000088 = 0;
  *(uint32_t*)0x2000008c = 0;
  *(uint32_t*)0x20000090 = 0;
  *(uint32_t*)0x20000094 = 0;
  *(uint32_t*)0x20000098 = 0;
  *(uint32_t*)0x2000009c = 0;
  syscall(__NR_write, -1, 0x20000040, 0x60);
  return 0;
}


For request IDs syzkaller just chooses random numbers in 1:8 range:

type fuse_out[PAYLOAD] {
    len        len[parent, int32]
    err        flags[fuse_errors, int32]
    unique     fuse_unique
    payload    PAYLOAD
} [packed]

type fuse_unique int64[1:8]


> In case of parallel thread called write with id, we just queued to processing
> in fuse_dev_do_read(), we may bump to this stack (despite read has not finished
> yet, syzbot may write just everything, any id).
>
> fuse_dev_do_read()                                  fuse_dev_do_write()
>    list_move_tail(&req->list, &fpq->processing);      ...
>    spin_unlock(&fpq->lock);                           ...
>    ...                                                request_end(fc, req);
>    ...                                                  fuse_put_request(fc, req);
>    if (test_bit(FR_INTERRUPTED, &req->flags))
>          queue_interrupt(fiq, req);
>
> We should keep req refcount in fuse_dev_do_read(), till we haven't finished to use it.
> Something like this (compile tested only):
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 11ea2c4a38ab..675caed3e655 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1311,12 +1311,14 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>                 goto out_end;
>         }
>         list_move_tail(&req->list, &fpq->processing);
> +       __fuse_get_request(req);
>         spin_unlock(&fpq->lock);
>         set_bit(FR_SENT, &req->flags);
>         /* matches barrier in request_wait_answer() */
>         smp_mb__after_atomic();
>         if (test_bit(FR_INTERRUPTED, &req->flags))
>                 queue_interrupt(fiq, req);
> +       fuse_put_request(fc, req);
>
>         return reqsize;
>
>
>
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b8f349d23d3c4835
>> dashboard link: https://syzkaller.appspot.com/bug?extid=4e975615ca01f2277bdd
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
>> BUG: KASAN: use-after-free in fuse_dev_do_read.isra.27+0x1659/0x1920 fs/fuse/dev.c:1318
>> Read of size 8 at addr ffff8801cbd4ea30 by task syz-executor0/28821
>>
>> CPU: 1 PID: 28821 Comm: syz-executor0 Not tainted 4.19.0-rc3+ #11
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
>>  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
>>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>>  constant_test_bit arch/x86/include/asm/bitops.h:328 [inline]
>>  fuse_dev_do_read.isra.27+0x1659/0x1920 fs/fuse/dev.c:1318
>>  fuse_dev_read+0x1a9/0x250 fs/fuse/dev.c:1360
>>  call_read_iter include/linux/fs.h:1801 [inline]
>>  new_sync_read fs/read_write.c:406 [inline]
>>  __vfs_read+0x6ac/0x9b0 fs/read_write.c:418
>>  vfs_read+0x17f/0x3c0 fs/read_write.c:452
>>  ksys_read+0x101/0x260 fs/read_write.c:578
>>  __do_sys_read fs/read_write.c:588 [inline]
>>  __se_sys_read fs/read_write.c:586 [inline]
>>  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x4572d9
>> Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007faaeefe4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>> RAX: ffffffffffffffda RBX: 00007faaeefe56d4 RCX: 00000000004572d9
>> RDX: 0000000000001000 RSI: 00000000200040c0 RDI: 0000000000000003
>> RBP: 00000000009300a0 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
>> R13: 00000000004d4508 R14: 00000000004c8d44 R15: 0000000000000000
>>
>> Allocated by task 28825:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
>>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>>  kmem_cache_alloc+0x12e/0x730 mm/slab.c:3554
>>  __fuse_request_alloc+0x27/0xf0 fs/fuse/dev.c:58
>>  fuse_request_alloc fs/fuse/dev.c:89 [inline]
>>  __fuse_get_req+0x1f7/0x9e0 fs/fuse/dev.c:164
>>  fuse_get_req fs/fuse/dev.c:194 [inline]
>>  fuse_simple_request+0x28/0x730 fs/fuse/dev.c:549
>>  fuse_statfs+0x368/0x8a0 fs/fuse/inode.c:442
>>  statfs_by_dentry+0x136/0x210 fs/statfs.c:64
>>  vfs_statfs+0x47/0x2e0 fs/statfs.c:74
>>  user_statfs+0xbd/0x150 fs/statfs.c:89
>>  __do_sys_statfs+0x7f/0xf0 fs/statfs.c:179
>>  __se_sys_statfs fs/statfs.c:176 [inline]
>>  __x64_sys_statfs+0x54/0x80 fs/statfs.c:176
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Freed by task 28825:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
>>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>>  __cache_free mm/slab.c:3498 [inline]
>>  kmem_cache_free+0x83/0x290 mm/slab.c:3756
>>  fuse_request_free+0x8b/0xa0 fs/fuse/dev.c:104
>>  fuse_put_request+0x2a6/0x350 fs/fuse/dev.c:304
>>  fuse_simple_request+0x453/0x730 fs/fuse/dev.c:571
>>  fuse_statfs+0x368/0x8a0 fs/fuse/inode.c:442
>>  statfs_by_dentry+0x136/0x210 fs/statfs.c:64
>>  vfs_statfs+0x47/0x2e0 fs/statfs.c:74
>>  user_statfs+0xbd/0x150 fs/statfs.c:89
>>  __do_sys_statfs+0x7f/0xf0 fs/statfs.c:179
>>  __se_sys_statfs fs/statfs.c:176 [inline]
>>  __x64_sys_statfs+0x54/0x80 fs/statfs.c:176
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> The buggy address belongs to the object at ffff8801cbd4ea00
>>  which belongs to the cache fuse_request of size 448
>> The buggy address is located 48 bytes inside of
>>  448-byte region [ffff8801cbd4ea00, ffff8801cbd4ebc0)
>> The buggy address belongs to the page:
>> page:ffffea00072f5380 count:1 mapcount:0 mapping:ffff8801d4ad4840 index:0x0
>> flags: 0x2fffc0000000100(slab)
>> raw: 02fffc0000000100 ffffea000717eb48 ffff8801d4ad5c48 ffff8801d4ad4840
>> raw: 0000000000000000 ffff8801cbd4e000 0000000100000008 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff8801cbd4e900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>  ffff8801cbd4e980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> ffff8801cbd4ea00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                      ^
>>  ffff8801cbd4ea80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801cbd4eb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/5882d989-8e9d-0ae1-1b2d-3ba431e97eb6%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
