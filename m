Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED79ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D746E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6diqGe5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D746E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbeGRLNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:13:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46027 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeGRLNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:13:52 -0400
Received: by mail-pl0-f65.google.com with SMTP id 94-v6so1851010ple.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W4b56EUdPicefY+H6mE5sl9UuAt7t9AAk2+uKJV44K8=;
        b=E6diqGe5lRjPtZhGWr35RUdp+BGE2KV6xL3VtjSkJNvd3iDcErH8H9U2edMCIUxIBX
         BC85OptUBKpoRj7v0gZIq/XeVd7HDSpSnI+zK6s9qOxXiunF813Mc5T5PLce+LoMJbOB
         0Y5NW0W7Yq0TiHIHj5Vy/xGY3GQp9Ip40poBy2Z1NxuqYiQYkqbHcwrHrbpswkc8QIUT
         tRRNd+c0poqTmQPeX/k8Dt4XSIKK3COmgeaoagnaYrZ9DOKojYy7w3mgNe2ueOFeyN1D
         Oz7xYO9pIEr9NPiJXSmVaQBi0jjx00gvZT+wSs/ie4hKqePGryNlxkKKLUuFqhEH4oO5
         dryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W4b56EUdPicefY+H6mE5sl9UuAt7t9AAk2+uKJV44K8=;
        b=BmzpdfwNUXT+HIoErzgS7ztBER6kBxlaVmWqVArJ16vyib1RAxIaHsm0axGRVOoaf/
         4/Ag3WDWkwjc9uLZw5RJHOkMgAMooVfVzJGKHABj1Ir2pU6F4f/oQua8hzv9ubIGM2hh
         Ei4/rWAcIH7PIdp1/XKPZw2u6zxDhROmMoH27hKo3gUy/KXCiUrEDyvuuJTrdd3nC/YX
         3UnmbiGKZTHf5V14Rm4+Jj4RDpryM7cX8ZSgzuuiEzjqqaLsUeTuzQr6PxatqurbBu/6
         DFxanPOYhriDNqjLuwxXZbvT+YihqLN3r2TLe1+lX166Uppo2qxiwASWY0nSwUiok02a
         uu9Q==
X-Gm-Message-State: AOUpUlEc/xUHkJKUhuDEgP6rAhtGuJzPm2STbuEW9mu1y1xj12gL+MxB
        IHcYOgiPZtN1KkVoe1A6AGuKd9PW19mJIPSXzMutwQ==
X-Google-Smtp-Source: AAOMgpenRi1x5Stu5txFl1gZ/Ldd710oFCy0pR6knlqhhcfwhjsA5riUtzF9n3Lrl5bCKbvIxXkdRAc32RVvtWw3cv4=
X-Received: by 2002:a17:902:d710:: with SMTP id w16-v6mr5418177ply.93.1531910195540;
 Wed, 18 Jul 2018 03:36:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:36:14
 -0700 (PDT)
In-Reply-To: <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
References: <0000000000009ce88d05714242a8@google.com> <4b349bff-8ad4-6410-250d-593b13d8d496@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jul 2018 12:36:14 +0200
Message-ID: <CACT4Y+aPBp0Cb+mE+k_cH5TSqJQze99D4X3uKcrsFG0CSxW49w@mail.gmail.com>
Subject: Re: INFO: task hung in generic_file_write_iter
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+9933e4476f365f5d5a1b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Jan Kara <jack@suse.cz>,
        jlayton@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:28 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/07/18 17:58, syzbot wrote:
>> mmap: syz-executor7 (10902) uses deprecated remap_file_pages() syscall. See Documentation/vm/remap_file_pages.rst.
>
> There are many reports which are stalling inside __getblk_gfp().
> And there is horrible comment for __getblk_gfp():
>
>   /*
>    * __getblk_gfp() will locate (and, if necessary, create) the buffer_head
>    * which corresponds to the passed block_device, block and size. The
>    * returned buffer has its reference count incremented.
>    *
>    * __getblk_gfp() will lock up the machine if grow_dev_page's
>    * try_to_free_buffers() attempt is failing.  FIXME, perhaps?
>    */
>
> This report is stalling after mount() completed and process used remap_file_pages().
> I think that we might need to use debug printk(). But I don't know what to examine.


There is a thread in the same process that is doing acct on a mounted
fat filesystem, you can see it at the bottom of the report. Not sure
it's related or not.

FWIW the program that caused this is:

18:26:17 executing program 0:
syz_mount_image$vfat(&(0x7f0000001680)='vfat\x00',
&(0x7f0000000100)='./file0\x00', 0x100000000000dfff, 0x1,
&(0x7f0000000040)=[{&(0x7f00000016c0)="eb64c86d4f66732e66617400020441000500077008f8",
0x16}], 0x0, &(0x7f0000000140)=ANY=[])
chroot(&(0x7f00000000c0)='./file0\x00')
mknod(&(0x7f0000000500)='./file0/file0\x00', 0x0, 0x0)
acct(&(0x7f0000000280)='./file0/file0\x00')
umount2(&(0x7f0000000140)='./file0\x00', 0xffffff0f)




>> CPU: 1 PID: 10863 Comm: syz-executor0 Not tainted 4.18.0-rc5+ #151
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x50 kernel/kcov.c:106
>> Code: e2 00 01 1f 00 48 8b 75 08 75 2b 8b 90 90 12 00 00 83 fa 02 75 20 48 8b 88 98 12 00 00 8b 80 94 12 00 00 48 8b 11 48 83 c2 01 <48> 39 d0 76 07 48 89 34 d1 48 89 11 5d c3 0f 1f 00 55 40 0f b6 d6
>> RSP: 0018:ffff8801913be760 EFLAGS: 00000216
>> RAX: 0000000000040000 RBX: ffff88018e06b348 RCX: ffffc90001e34000
>> RDX: 0000000000040000 RSI: ffffffff81d44df2 RDI: 0000000000000007
>> RBP: ffff8801913be760 R08: ffff8801b465c540 R09: ffffed003b5e46d6
>> R10: 0000000000000003 R11: 0000000000000006 R12: dffffc0000000000
>> R13: 0000000000000042 R14: 0000000000000001 R15: 0000000000000020
>> FS:  00007f53ece9c700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000119f218 CR3: 00000001ba743000 CR4: 00000000001406e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  init_page_buffers+0x3e2/0x530 fs/buffer.c:904
>>  grow_dev_page fs/buffer.c:947 [inline]
>>  grow_buffers fs/buffer.c:1009 [inline]
>>  __getblk_slow fs/buffer.c:1036 [inline]
>>  __getblk_gfp+0x906/0xb10 fs/buffer.c:1313
>>  __bread_gfp+0x2d/0x310 fs/buffer.c:1347
>>  sb_bread include/linux/buffer_head.h:307 [inline]
>>  fat12_ent_bread+0x14e/0x3d0 fs/fat/fatent.c:75
>>  fat_ent_read_block fs/fat/fatent.c:441 [inline]
>>  fat_alloc_clusters+0x8ce/0x16e0 fs/fat/fatent.c:489
>>  fat_add_cluster+0x7a/0x150 fs/fat/inode.c:101
>>  __fat_get_block fs/fat/inode.c:148 [inline]
>>  fat_get_block+0x375/0xaf0 fs/fat/inode.c:183
>>  __block_write_begin_int+0x50d/0x1b00 fs/buffer.c:1958
>>  __block_write_begin fs/buffer.c:2008 [inline]
>>  block_write_begin+0xda/0x370 fs/buffer.c:2067
>>  cont_write_begin+0x569/0x860 fs/buffer.c:2417
>>  fat_write_begin+0x8d/0x120 fs/fat/inode.c:229
>>  generic_perform_write+0x3ae/0x6c0 mm/filemap.c:3139
>>  __generic_file_write_iter+0x26e/0x630 mm/filemap.c:3264
>>  generic_file_write_iter+0x438/0x870 mm/filemap.c:3292
>>  call_write_iter include/linux/fs.h:1793 [inline]
>>  new_sync_write fs/read_write.c:474 [inline]
>>  __vfs_write+0x6c6/0x9f0 fs/read_write.c:487
>>  __kernel_write+0x10c/0x380 fs/read_write.c:506
>>  do_acct_process+0x1148/0x1660 kernel/acct.c:520
>>  acct_pin_kill+0x2e/0x100 kernel/acct.c:174
>>  pin_kill+0x29f/0xb60 fs/fs_pin.c:50
>>  acct_on+0x63b/0x8b0 kernel/acct.c:254
>>  __do_sys_acct kernel/acct.c:286 [inline]
>>  __se_sys_acct kernel/acct.c:273 [inline]
>>  __x64_sys_acct+0xc2/0x1f0 kernel/acct.c:273
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
