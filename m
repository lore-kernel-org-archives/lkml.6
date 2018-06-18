Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06683C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CBB20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CBB20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbeFRHDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:03:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45305 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754983AbeFRHDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:03:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2401BAF81;
        Mon, 18 Jun 2018 07:03:20 +0000 (UTC)
Subject: Re: general protection fault in find_device
To:     clm@fb.com, dsterba@suse.com, jbacik@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000e5da7e056ee43449@google.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <45200a61-58c3-b7f0-d8e4-5108f8369ac5@suse.com>
Date:   Mon, 18 Jun 2018 10:03:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000e5da7e056ee43449@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Anand to CC list since he's been doing devices-related work]

On 18.06.2018 08:55, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ce397d215ccd Linux 4.18-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e765f8400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f390986c4f7cd566
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=923aa93978c7ad27a9b1
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+923aa93978c7ad27a9b1@syzkaller.appspotmail.com
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 0 PID: 14460 Comm: syz-executor5 Not tainted 4.18.0-rc1+ #107
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:find_device+0x94/0x130 fs/btrfs/volumes.c:366
> Code: 42 80 3c 28 00 0f 85 9d 00 00 00 48 8b 1b 4c 39 f3 0f 84 86 00 00
> 00 e8 6a 79 b1 fe 48 8d bb c0 00 00 00 48 89 f8 48 c1 e8 03 <42> 80 3c
> 28 00 75 70 4c 8b bb c0 00 00 00 4c 89 e6 4c 89 ff e8 f3
> RSP: 0018:ffff8801d880ee70 EFLAGS: 00010206
> RAX: 0000000000000018 RBX: 0000000000000000 RCX: ffffc9000d8a5000
> RDX: 0000000000002d14 RSI: ffffffff82ca3136 RDI: 00000000000000c0
> RBP: ffff8801d880eea8 R08: ffff8801abee0240 R09: fffffbfff123dea8
> R10: ffff8801d880f178 R11: ffffffff891ef547 R12: 231f7dc339e55e1c
> R13: dffffc0000000000 R14: ffff8801d7a65b98 R15: 0000000000000000
> FS:  00007faa9dcb2700(0000) GS:ffff8801dae00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000093002d CR3: 00000001bd208000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  device_list_add+0x230/0x1530 fs/btrfs/volumes.c:771
>  btrfs_scan_one_device+0x474/0xb00 fs/btrfs/volumes.c:1247
>  btrfs_mount_root+0x3ae/0x1e90 fs/btrfs/super.c:1542
>  mount_fs+0xae/0x328 fs/super.c:1277
>  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>  vfs_kern_mount+0x40/0x60 fs/namespace.c:1027
>  btrfs_mount+0x4a9/0x215e fs/btrfs/super.c:1661
>  mount_fs+0xae/0x328 fs/super.c:1277
>  vfs_kern_mount.part.34+0xdc/0x4e0 fs/namespace.c:1037
>  vfs_kern_mount fs/namespace.c:1027 [inline]
>  do_new_mount fs/namespace.c:2518 [inline]
>  do_mount+0x581/0x30e0 fs/namespace.c:2848
>  ksys_mount+0x12d/0x140 fs/namespace.c:3064
>  __do_sys_mount fs/namespace.c:3078 [inline]
>  __se_sys_mount fs/namespace.c:3075 [inline]
>  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3075
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45855a
> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 dd 8f fb ff c3 66 2e
> 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
> f0 ff ff 0f 83 ba 8f fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007faa9dcb1a88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000020000428 RCX: 000000000045855a
> RDX: 00007faa9dcb1ad0 RSI: 00000000200000c0 RDI: 00007faa9dcb1af0
> RBP: 0000000000000001 R08: 00007faa9dcb1b30 R09: 00007faa9dcb1ad0
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000013
> R13: 0000000000000001 R14: 00000000004d2d78 R15: 0000000000000000


So this suggests some inconsistency on fs_devices->devices list. On a
quick look indeed it doesn't seem clear what the locking rules for this
list are. In device_list_add in the !device case a device is added with
fs_devices->device_list_Mutex held and using list_add_rcu. In the same
function if we want to read the list ie invoke find_devices (because we
have found an fsid) we are using plain list_for_each_entry (ie not the
_rcu version and i don't see device_list_mutex being held while
iterating the list). Additionally in btrfs_free_extra_devids the
fs_devices->devices list is iterated with uuid_mutex being held and not
device_list_mutex. In open_fs_devices we don't get any protection
whatsoever while reading the list. Same thing in
btrfs_find_next_active_device. If the list is supposed to be
RCU-protected then the rules are:

1. There needs to be an out of band (ie not RCU) mutual exclusion of
modifiers
2. Iterating the list should use _rcu list primitives.

Currently I don't see those 2 invariants being enforced in every code path.
