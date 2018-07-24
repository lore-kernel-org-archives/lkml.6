Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64810C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F9F20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljPah7wH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F9F20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbeGXFMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:12:52 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54016 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388144AbeGXFMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:12:51 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so1959283itw.3;
        Mon, 23 Jul 2018 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DBUrq5j0eBI9YgP5Mteg/s+yuabK05a8b9uqT51YdH8=;
        b=ljPah7wH1GWWr6SLNtYNs2m+/ZqAxCVrkLbiBbLcuyzekw9bUaPqWJD7QBxync0Nn4
         Cp2dBWotszjjXnPmBTPJDI7sQI8iMOUut0AKrR7ZgLC842QdrLcD9lIhIjvMJR+cQ8ax
         7GMsJ5eCBFkVMSmXH1muDCMniVhoG74glAAkCtyyPxRt9d68IS40+f4Z5T+X2cV5jZyk
         Ne5tzH+rqRtbgg1dn/zcDangQT5oAdZI8QG2NgKtULdxeI0XVwOmT4HOCEuX0m6/HQh8
         jSdFF/f6CG5VxKKFVW5pNqirEFVmEbbaPWLnGT8/PDSwuLx219/sBbyXHgf6di1N3eOH
         oD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DBUrq5j0eBI9YgP5Mteg/s+yuabK05a8b9uqT51YdH8=;
        b=bZ6FxO2Q4JRd99FwzKYoS2lImzw3bsd0DhiEYOoaF+2ZM5R4Gy9TsoLsIfYbNRK251
         j9UCenMU3zDZhm59HQhwgasXtJ9b6CXSi7Jv5l/5vGJ58l5rG0CBi0JoGvYQTWIs6ZlI
         IYXttYbXFFOV2WkUwSj3voyRv0irXL7sMlDr4d6KlgopAVmxkyZpFTss1R/4yyiEL4i3
         IunvkWFl88B14ppqs7cgUt/BgYCn/5EGI5ueeTqpCW/YnBsA/cL73cjOfdR0jLUg015E
         kiGySq/853buu2hZya7GTKW7h+yZHXxfy1irSVyu343FN610HgtwyMOVeBkYPy2MdAOz
         5Cig==
X-Gm-Message-State: AOUpUlESbD3ET2TA+/nsVOBhR2+ECc7ieliFzZuGX0jpeJpOTLLIjpto
        jV8OH+NGJp/2uLz7vzPg4KejYrYrb6TkuspMZ+o=
X-Google-Smtp-Source: AAOMgpfl4eK7fFmmBhPURqY0f0JRF4fcFIWF4PMQivm9whZjQwMh5/aCdEJREbJvsBEj4vEhnv0sRosOPNuv7QFvWGo=
X-Received: by 2002:a24:1c09:: with SMTP id c9-v6mr1452276itc.38.1532405303595;
 Mon, 23 Jul 2018 21:08:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:e305:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 21:08:22
 -0700 (PDT)
In-Reply-To: <20180724034542.GA19283@dragonet>
References: <20180724034542.GA19283@dragonet>
From:   DaeRyong Jeong <threeearcat@gmail.com>
Date:   Tue, 24 Jul 2018 13:08:22 +0900
Message-ID: <CACsK=jfrqPuL1UphZ6_j6A1o5t5EZOQZaEG9p3H=PXseGWEfsQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in link_path_walk
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Byoungyoung Lee <byoungyoung@purdue.edu>,
        Kyungtae Kim <kt0755@gmail.com>, bammanag@purdue.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think that below two crashes are also related to the same race issue.

KASAN: use-after-free Read in nd_jump_root, found in v4.17-rc1
KASAN: use-after-free in set_root, found in v4.18-rc3


==================================================================
BUG: KASAN: use-after-free in nd_jump_root+0x69/0x160 fs/namei.c:852
Read of size 8 at addr ffff8801eb677e58 by task syz-executor0/20521

CPU: 0 PID: 20521 Comm: syz-executor0 Not tainted 4.17.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x166/0x21c lib/dump_stack.c:113
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23f/0x360 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load8+0x54/0x90 mm/kasan/kasan.c:699
 nd_jump_root+0x69/0x160 fs/namei.c:852
 path_init+0x9ca/0x1190 fs/namei.c:2165
 path_openat+0x140/0x2040 fs/namei.c:3495
 do_filp_open+0x175/0x230 fs/namei.c:3535
 do_sys_open+0x3c7/0x4a0 fs/open.c:1093
 __do_sys_openat fs/open.c:1120 [inline]
 __se_sys_openat fs/open.c:1114 [inline]
 __x64_sys_openat+0x59/0x70 fs/open.c:1114
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456419
RSP: 002b:00007fb317cd2b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000072bee0 RCX: 0000000000456419
RDX: 0000000000000101 RSI: 00000000200001c0 RDI: ffffffffffffff9c
RBP: 0000000000000497 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb317cd36d4
R13: 00000000ffffffff R14: 00000000006fbec8 R15: 0000000000000000

Allocated by task 20521:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xae/0xe0 mm/kasan/kasan.c:553
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
 kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
 __d_alloc+0xc0/0x6e0 fs/dcache.c:1638
 d_alloc_anon fs/dcache.c:1742 [inline]
 d_make_root+0x2d/0x70 fs/dcache.c:1934
 devpts_fill_super+0x23b/0x500 fs/devpts/inode.c:482
 mount_nodev+0x59/0xd0 fs/super.c:1211
 devpts_mount+0x2c/0x40 fs/devpts/inode.c:509
 mount_fs+0x50/0x200 fs/super.c:1268
 vfs_kern_mount.part.26+0xbc/0x2c0 fs/namespace.c:1037
 vfs_kern_mount fs/namespace.c:2514 [inline]
 do_new_mount fs/namespace.c:2517 [inline]
 do_mount+0xb82/0x1bb0 fs/namespace.c:2847
 ksys_mount+0xab/0x120 fs/namespace.c:3063
 __do_sys_mount fs/namespace.c:3077 [inline]
 __se_sys_mount fs/namespace.c:3074 [inline]
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3074
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 20522:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kmem_cache_free+0x83/0x2a0 mm/slab.c:3756
 __d_free fs/dcache.c:257 [inline]
 dentry_free+0x8c/0xe0 fs/dcache.c:347
 __dentry_kill+0x3d6/0x440 fs/dcache.c:582
 dentry_kill+0x8f/0x320 fs/dcache.c:686
 dput.part.22+0x430/0x4e0 fs/dcache.c:850
 dput fs/dcache.c:830 [inline]
 do_one_tree+0x43/0x50 fs/dcache.c:1523
 shrink_dcache_for_umount+0xa5/0x1c0 fs/dcache.c:1537
 generic_shutdown_super+0xb0/0x330 fs/super.c:425
 kill_anon_super fs/super.c:1037 [inline]
 kill_litter_super+0x48/0x60 fs/super.c:1047
 devpts_kill_sb+0x49/0x50 fs/devpts/inode.c:519
 deactivate_locked_super+0x71/0xb0 fs/super.c:313
 deactivate_super+0x10f/0x150 fs/super.c:344
 cleanup_mnt+0x6b/0xc0 fs/namespace.c:1173
 __cleanup_mnt+0x16/0x20 fs/namespace.c:1180
 task_work_run+0x152/0x1b0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:191 [inline]
 exit_to_usermode_loop+0x262/0x270 arch/x86/entry/common.c:166
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
 do_syscall_64+0x473/0x4a0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801eb677e00
 which belongs to the cache dentry(17:syz0) of size 288
The buggy address is located 88 bytes inside of
 288-byte region [ffff8801eb677e00, ffff8801eb677f20)
The buggy address belongs to the page:
page:ffffea0007ad9dc0 count:1 mapcount:0 mapping:ffff8801eb677040 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801eb677040 0000000000000000 000000010000000b
raw: ffffea0007b9d2a0 ffffea0007b9ed20 ffff8801ef225300 ffff8801ed0249c0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801ed0249c0

Memory state around the buggy address:
 ffff8801eb677d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8801eb677d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8801eb677e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8801eb677e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8801eb677f00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================




==================================================================
BUG: KASAN: use-after-free in __read_once_size
include/linux/compiler.h:188 [inline]
BUG: KASAN: use-after-free in __read_seqcount_begin
include/linux/seqlock.h:113 [inline]
BUG: KASAN: use-after-free in set_root+0x252/0x3f0 fs/namei.c:820
Read of size 4 at addr ffff88019e5d4b88 by task syz-executor0/30297

CPU: 1 PID: 30297 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x16e/0x22c lib/dump_stack.c:113
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x259/0x380 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load4+0x78/0x80 mm/kasan/kasan.c:698
 __read_once_size include/linux/compiler.h:188 [inline]
 __read_seqcount_begin include/linux/seqlock.h:113 [inline]
 set_root+0x252/0x3f0 fs/namei.c:820
 path_init+0x9dd/0x11b0 fs/namei.c:2164
 path_openat+0x147/0x1fb0 fs/namei.c:3534
 do_filp_open+0x181/0x250 fs/namei.c:3574
 do_sys_open+0x3da/0x4b0 fs/open.c:1101
 __do_sys_openat fs/open.c:1128 [inline]
 __se_sys_openat fs/open.c:1122 [inline]
 __x64_sys_openat+0x59/0x70 fs/open.c:1122
 do_syscall_64+0x167/0x4b0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x456469
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5e06564b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000072bfa0 RCX: 0000000000456469
RDX: 0000000000000080 RSI: 0000000020000140 RDI: ffffffffffffff9c
RBP: 00000000000004e4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5e065656d4
R13: 00000000ffffffff R14: 00000000006fc600 R15: 0000000000000000

Allocated by task 30296:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xae/0xe0 mm/kasan/kasan.c:553
 kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
 kmem_cache_alloc+0x12e/0x750 mm/slab.c:3554
 __d_alloc+0xc2/0x720 fs/dcache.c:1616
 d_alloc_anon fs/dcache.c:1720 [inline]
 d_make_root+0x2d/0x70 fs/dcache.c:1934
 devpts_fill_super+0x23b/0x500 fs/devpts/inode.c:482
 mount_nodev+0x59/0xd0 fs/super.c:1220
 devpts_mount+0x2c/0x40 fs/devpts/inode.c:509
 mount_fs+0x50/0x200 fs/super.c:1277
 vfs_kern_mount.part.26+0xc4/0x2d0 fs/namespace.c:1037
 vfs_kern_mount fs/namespace.c:2515 [inline]
 do_new_mount fs/namespace.c:2518 [inline]
 do_mount+0xbd7/0x1c90 fs/namespace.c:2848
 ksys_mount+0xab/0x120 fs/namespace.c:3064
 __do_sys_mount fs/namespace.c:3078 [inline]
 __se_sys_mount fs/namespace.c:3075 [inline]
 __x64_sys_mount+0x67/0x80 fs/namespace.c:3075
 do_syscall_64+0x167/0x4b0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 30296:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 __cache_free mm/slab.c:3498 [inline]
 kmem_cache_free+0x83/0x2a0 mm/slab.c:3756
 __d_free fs/dcache.c:257 [inline]
 dentry_free+0x8c/0xe0 fs/dcache.c:347
 __dentry_kill+0x3fe/0x470 fs/dcache.c:582
 dentry_kill+0x8f/0x320 fs/dcache.c:687
 dput+0x450/0x4e0 fs/dcache.c:848
 do_one_tree+0x37/0x40 fs/dcache.c:1531
 shrink_dcache_for_umount+0xad/0x1d0 fs/dcache.c:1545
 generic_shutdown_super+0xb8/0x340 fs/super.c:438
 kill_anon_super fs/super.c:1046 [inline]
 kill_litter_super+0x48/0x60 fs/super.c:1056
 devpts_kill_sb+0x49/0x50 fs/devpts/inode.c:519
 deactivate_locked_super+0x71/0xb0 fs/super.c:326
 deactivate_super+0x11d/0x160 fs/super.c:357
 cleanup_mnt+0x6b/0xc0 fs/namespace.c:1174
 __cleanup_mnt+0x16/0x20 fs/namespace.c:1181
 task_work_run+0x15a/0x1c0 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:192 [inline]
 exit_to_usermode_loop+0x2a3/0x2b0 arch/x86/entry/common.c:166
 prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
 do_syscall_64+0x485/0x4b0 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88019e5d4b80
 which belongs to the cache dentry(17:syz0) of size 288
The buggy address is located 8 bytes inside of
 288-byte region [ffff88019e5d4b80, ffff88019e5d4ca0)
The buggy address belongs to the page:
page:ffffea0006797500 count:1 mapcount:0 mapping:ffff8801ec05d7c0 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea0006796148 ffffea00067cd648 ffff8801ec05d7c0
raw: 0000000000000000 ffff88019e5d4080 000000010000000b ffff8801dc63e8c0
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801dc63e8c0

Memory state around the buggy address:
 ffff88019e5d4a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88019e5d4b00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88019e5d4b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88019e5d4c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88019e5d4c80: fb fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb
==================================================================

On Tue, Jul 24, 2018 at 12:45 PM, Dae R. Jeong <threeearcat@gmail.com> wrote:
> Reporting the crash: KASAN: use-after-free Read in link_path_walk
>
> This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
> version of Syzkaller), which we describe more at the end of this
> report. Our analysis shows that the race occurs when invoking two
> syscalls concurrently, open() and chroot().
>
> Diagnosis:
> We think that it is possible that link_path_walk() dereferences a
> freed pointer when cleanup_mnt() is executed between path_init() and
> link_path_walk().
>
> Since I'm not an expert on a file system and don't fully understand
> the crash, please see a executed program and a crash log below in
> case that my understanding is wrong.
>
>
> Executed Program:
> Thread0                     Thread1
> mkdir("./file0")
>      |--------------------------|
>      |                      mount("./file0", "./file0", "devpts", 0x0, "")
>      |                          |
> openat(AT_FDCWD,            chroot("./file0")
> "/dev/vcs", 0x200, 0x0)     umount("./file0", 0x2)
>
> openat(), chroot(), umount() syscalls are executed after mount() syscall.
> We think a race occurs between openat() and chroot() because RaceFuzzer
> executed openat() and chroot() concurrently.
>
>
> (Possible) Thread interleaving:
> CPU0 (path_openat)                      CPU1 (cleanup_mnt)
> =====                                   =====
> s = path_init(nd, flags);
> if (IS_ERR(s)) {
>           put_filp(file);
>                   return ERR_CAST(s);
> }
>
>                                         deactivate_super(mnt->mnt.mnt_sb);
>
> while (!(error = link_path_walk(s, nd)) &&
>
> // (in link_path_walk())
> struct dentry *parent = nd->path.dentry;
> nd->flags &= ~LOOKUP_JUMPED;
> if (unlikely(parent->d_flags & DCACHE_OP_HASH)) { // UAF occured
>
>
> Crash log:
> ==================================================================
> BUG: KASAN: use-after-free in link_path_walk+0x46e/0xcd0 fs/namei.c:2061
> Read of size 4 at addr ffff8801cbe6cb80 by task syz-executor0/28699
>
> CPU: 0 PID: 28699 Comm: syz-executor0 Not tainted 4.17.0-rc1 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x166/0x21c lib/dump_stack.c:113
>  print_address_description+0x73/0x250 mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report+0x23f/0x360 mm/kasan/report.c:412
>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>  __asan_load4+0x78/0x80 mm/kasan/kasan.c:698
>  link_path_walk+0x46e/0xcd0 fs/namei.c:2061
>  path_openat+0x23c/0x2040 fs/namei.c:3500
>  do_filp_open+0x175/0x230 fs/namei.c:3535
>  do_sys_open+0x3c7/0x4a0 fs/open.c:1093
>  __do_sys_open fs/open.c:1111 [inline]
>  __se_sys_open fs/open.c:1106 [inline]
>  __x64_sys_open+0x4c/0x60 fs/open.c:1106
>  do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x410601
> RSP: 002b:00007f7345489660 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: cccccccccccccccd RCX: 0000000000410601
> RDX: 0000000000000000 RSI: 0000000000010180 RDI: 00007f7345489710
> RBP: 00000000000006e1 R08: 236573756f6d2f74 R09: 0000000000000000
> R10: 00000000200004c0 R11: 0000000000000293 R12: 00007f734548a6d4
> R13: 00000000ffffffff R14: 00000000006ff5b8 R15: 0000000000000000
>
> Allocated by task 28699:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xae/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
>  __d_alloc+0xc0/0x6e0 fs/dcache.c:1638
>  d_alloc_anon fs/dcache.c:1742 [inline]
>  d_make_root+0x2d/0x70 fs/dcache.c:1934
>  devpts_fill_super+0x23b/0x500 fs/devpts/inode.c:482
>  mount_nodev+0x59/0xd0 fs/super.c:1211
>  devpts_mount+0x2c/0x40 fs/devpts/inode.c:509
>  mount_fs+0x50/0x200 fs/super.c:1268
>  vfs_kern_mount.part.26+0xbc/0x2c0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:2514 [inline]
>  do_new_mount fs/namespace.c:2517 [inline]
>  do_mount+0xb82/0x1bb0 fs/namespace.c:2847
>  ksys_mount+0xab/0x120 fs/namespace.c:3063
>  __do_sys_mount fs/namespace.c:3077 [inline]
>  __se_sys_mount fs/namespace.c:3074 [inline]
>  __x64_sys_mount+0x67/0x80 fs/namespace.c:3074
>  do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> Freed by task 28700:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kmem_cache_free+0x83/0x2a0 mm/slab.c:3756
>  __d_free fs/dcache.c:257 [inline]
>  dentry_free+0x8c/0xe0 fs/dcache.c:347
>  __dentry_kill+0x3d6/0x440 fs/dcache.c:582
>  dentry_kill+0x8f/0x320 fs/dcache.c:686
>  dput.part.22+0x430/0x4e0 fs/dcache.c:850
>  dput fs/dcache.c:830 [inline]
>  do_one_tree+0x43/0x50 fs/dcache.c:1523
>  shrink_dcache_for_umount+0xa5/0x1c0 fs/dcache.c:1537
>  generic_shutdown_super+0xb0/0x330 fs/super.c:425
>  kill_anon_super fs/super.c:1037 [inline]
>  kill_litter_super+0x48/0x60 fs/super.c:1047
>  devpts_kill_sb+0x49/0x50 fs/devpts/inode.c:519
>  deactivate_locked_super+0x71/0xb0 fs/super.c:313
>  deactivate_super+0x10f/0x150 fs/super.c:344
>  cleanup_mnt+0x6b/0xc0 fs/namespace.c:1173
>  __cleanup_mnt+0x16/0x20 fs/namespace.c:1180
>  task_work_run+0x152/0x1b0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:191 [inline]
>  exit_to_usermode_loop+0x262/0x270 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>  do_syscall_64+0x473/0x4a0 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> The buggy address belongs to the object at ffff8801cbe6cb80
>  which belongs to the cache dentry(17:syz0) of size 288
> The buggy address is located 0 bytes inside of
>  288-byte region [ffff8801cbe6cb80, ffff8801cbe6cca0)
> The buggy address belongs to the page:
> page:ffffea00072f9b00 count:1 mapcount:0 mapping:ffff8801cbe6c080 index:0x0
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffff8801cbe6c080 0000000000000000 000000010000000b
> raw: ffffea00072f8ca0 ffffea00072f8da0 ffff8801dc812c80 ffff8801de41a740
> page dumped because: kasan: bad access detected
> page->mem_cgroup:ffff8801de41a740
>
> Memory state around the buggy address:
>  ffff8801cbe6ca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cbe6cb00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>>ffff8801cbe6cb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                    ^
>  ffff8801cbe6cc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cbe6cc80: fb fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb
> ==================================================================
>
>
> = About RaceFuzzer
>
> RaceFuzzer is a customized version of Syzkaller, specifically tailored
> to find race condition bugs in the Linux kernel. While we leverage
> many different technique, the notable feature of RaceFuzzer is in
> leveraging a custom hypervisor (QEMU/KVM) to interleave the
> scheduling. In particular, we modified the hypervisor to intentionally
> stall a per-core execution, which is similar to supporting per-core
> breakpoint functionality. This allows RaceFuzzer to force the kernel
> to deterministically trigger racy condition (which may rarely happen
> in practice due to randomness in scheduling).
>
> RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
> repro's scheduling synchronization should be performed at the user
> space, its reproducibility is limited (reproduction may take from 1
> second to 10 minutes (or even more), depending on a bug). This is
> because, while RaceFuzzer precisely interleaves the scheduling at the
> kernel's instruction level when finding this bug, C repro cannot fully
> utilize such a feature. Please disregard all code related to
> "should_hypercall" in the C repro, as this is only for our debugging
> purposes using our own hypervisor.
