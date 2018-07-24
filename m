Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2890C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E3320852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryyoDkeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E3320852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeGXEuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:50:10 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39842 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbeGXEuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:50:10 -0400
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so1113627plt.6;
        Mon, 23 Jul 2018 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ah10RAO1Co6RTCKf3AjDGwwvS+aQt8y+xGQg1xtu+Z0=;
        b=ryyoDkeWSWaI4D44X8boURgO4Toj0eYY6YtX/otM0/z+5desSpcelrmi0SIJ8h0+/J
         v/r8z2TZE0D4c2j5F8roLzB83zgm2u9aktyPcnhGBN7aNCaaZihW86qyYSLtsq5b/k1P
         6dIc5sFUfqz0jvsgrw4LGd0Ju1npw+eu1OMMWdS7XUzmJNEVdv7Oaqp0BlAsJgErSKb3
         pSUGAiLUO8CTGQK3Eh1Z+w28zJi3JBKKG8100Vr1r5KuPtOC3qHfR2G7flbyeb8fPWuT
         gAC0XyvJQcEXRBwABCufTkOrYfuFJCEV4feKfWUxHT77flp1bxHQ2d7Yxj7XpP1EXLnY
         MwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ah10RAO1Co6RTCKf3AjDGwwvS+aQt8y+xGQg1xtu+Z0=;
        b=KqiP8v0JUVhLhPRMAjNUuFddjqiIFSXuf5SruHtcIDi2GS5+7/B5VONAPnfD6edsyQ
         zx2e6V8p8VH+6z5XChabYn43gnZRFoKvHfTQFGdAiJ1eRHHt24DDArepafme7tpATlxx
         Nsg+l0fP2MIcIRt62Qo5w0YqKX8TNJbSiZeMT0RiZ5IEoOXbdlz8wkmJtsooyWtFxfbw
         Z2k1lAiT/dOiGfzkF2O1xzjBpdMfQSMHWq2w/h+sh4tb9bYOjJ8UjjC4w61dN6GxjuyL
         Hfm2x8mazEpteXg7lIY/alVcUmeIRv2QO5/bnXLg1BLPYuXYCaPRQvquqJEox3kLMKIo
         yhvA==
X-Gm-Message-State: AOUpUlH/CYh/MXmzQfwxjZm7Ol64D1Idb6kW9e1LNL3Gmz1umfDrQx7/
        RuurO42NyHkJn7oysRb488CJ+fRJ
X-Google-Smtp-Source: AAOMgpctzLQZWSQAKDpdqDzc+9ZIji0w89/IWH3huLatw1HSVIxvT0gs7CVqcBHQLbbyDFHBaGP5AA==
X-Received: by 2002:a17:902:bd93:: with SMTP id q19-v6mr15266223pls.238.1532403947189;
        Mon, 23 Jul 2018 20:45:47 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id a20-v6sm13389293pfi.124.2018.07.23.20.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 20:45:46 -0700 (PDT)
Date:   Tue, 24 Jul 2018 12:45:42 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        byoungyoung@purdue.edu, kt0755@gmail.com, bammanag@purdue.edu
Subject: KASAN: use-after-free Read in link_path_walk
Message-ID: <20180724034542.GA19283@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting the crash: KASAN: use-after-free Read in link_path_walk

This crash has been found in v4.17-rc1 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report. Our analysis shows that the race occurs when invoking two
syscalls concurrently, open() and chroot().

Diagnosis:
We think that it is possible that link_path_walk() dereferences a
freed pointer when cleanup_mnt() is executed between path_init() and
link_path_walk().

Since I'm not an expert on a file system and don't fully understand
the crash, please see a executed program and a crash log below in
case that my understanding is wrong.


Executed Program:
Thread0                     Thread1
mkdir("./file0")
     |--------------------------|
     |                      mount("./file0", "./file0", "devpts", 0x0, "")
     |                          |
openat(AT_FDCWD,            chroot("./file0")
"/dev/vcs", 0x200, 0x0)     umount("./file0", 0x2)

openat(), chroot(), umount() syscalls are executed after mount() syscall.
We think a race occurs between openat() and chroot() because RaceFuzzer
executed openat() and chroot() concurrently.


(Possible) Thread interleaving:
CPU0 (path_openat)                      CPU1 (cleanup_mnt)
=====                                   =====
s = path_init(nd, flags);
if (IS_ERR(s)) {
          put_filp(file);
                  return ERR_CAST(s);
}

                                        deactivate_super(mnt->mnt.mnt_sb);

while (!(error = link_path_walk(s, nd)) &&

// (in link_path_walk())
struct dentry *parent = nd->path.dentry;
nd->flags &= ~LOOKUP_JUMPED;
if (unlikely(parent->d_flags & DCACHE_OP_HASH)) { // UAF occured


Crash log:
==================================================================
BUG: KASAN: use-after-free in link_path_walk+0x46e/0xcd0 fs/namei.c:2061
Read of size 4 at addr ffff8801cbe6cb80 by task syz-executor0/28699

CPU: 0 PID: 28699 Comm: syz-executor0 Not tainted 4.17.0-rc1 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x166/0x21c lib/dump_stack.c:113
 print_address_description+0x73/0x250 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x23f/0x360 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load4+0x78/0x80 mm/kasan/kasan.c:698
 link_path_walk+0x46e/0xcd0 fs/namei.c:2061
 path_openat+0x23c/0x2040 fs/namei.c:3500
 do_filp_open+0x175/0x230 fs/namei.c:3535
 do_sys_open+0x3c7/0x4a0 fs/open.c:1093
 __do_sys_open fs/open.c:1111 [inline]
 __se_sys_open fs/open.c:1106 [inline]
 __x64_sys_open+0x4c/0x60 fs/open.c:1106
 do_syscall_64+0x15f/0x4a0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x410601
RSP: 002b:00007f7345489660 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: cccccccccccccccd RCX: 0000000000410601
RDX: 0000000000000000 RSI: 0000000000010180 RDI: 00007f7345489710
RBP: 00000000000006e1 R08: 236573756f6d2f74 R09: 0000000000000000
R10: 00000000200004c0 R11: 0000000000000293 R12: 00007f734548a6d4
R13: 00000000ffffffff R14: 00000000006ff5b8 R15: 0000000000000000

Allocated by task 28699:
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

Freed by task 28700:
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

The buggy address belongs to the object at ffff8801cbe6cb80
 which belongs to the cache dentry(17:syz0) of size 288
The buggy address is located 0 bytes inside of
 288-byte region [ffff8801cbe6cb80, ffff8801cbe6cca0)
The buggy address belongs to the page:
page:ffffea00072f9b00 count:1 mapcount:0 mapping:ffff8801cbe6c080 index:0x0
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffff8801cbe6c080 0000000000000000 000000010000000b
raw: ffffea00072f8ca0 ffffea00072f8da0 ffff8801dc812c80 ffff8801de41a740
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8801de41a740

Memory state around the buggy address:
 ffff8801cbe6ca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8801cbe6cb00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff8801cbe6cb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8801cbe6cc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8801cbe6cc80: fb fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb
==================================================================


= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).

RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
repro's scheduling synchronization should be performed at the user
space, its reproducibility is limited (reproduction may take from 1
second to 10 minutes (or even more), depending on a bug). This is
because, while RaceFuzzer precisely interleaves the scheduling at the
kernel's instruction level when finding this bug, C repro cannot fully
utilize such a feature. Please disregard all code related to
"should_hypercall" in the C repro, as this is only for our debugging
purposes using our own hypervisor.
