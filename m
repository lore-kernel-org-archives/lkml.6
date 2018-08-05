Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90467C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EA2218C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKtnRuVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EA2218C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeHESoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 14:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbeHESoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 14:44:54 -0400
Received: from localhost (c-67-160-202-76.hsd1.ca.comcast.net [67.160.202.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC77821898;
        Sun,  5 Aug 2018 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533487183;
        bh=bO5+U+V3LGxbBbVGLXaQSPdkL2IwRqVgTKdN2cpJLwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKtnRuVmfc1ffdUdZJ78ud1rT1R8MaXZm25SpT47ckMGVK0Rl5px0FbGrIwxld9Hz
         Cd/9Y0easMvKbgz6JnDbvKTQOQ9lW7bu1QLrxw5niQI2uBWZFeRmC+5IUPtPYEgTD1
         WdqJxmcj8dsEZuMw91TtaI8UwhtFeBcK2mRH3a0I=
Date:   Sun, 5 Aug 2018 09:39:42 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to do sanity check with inline
 flags
Message-ID: <20180805163942.GC55836@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180628161925.25860-1-chao@kernel.org>
 <2931f2db-3a45-6641-8f4f-07e757b811d8@kernel.org>
 <20180723131708.GA23437@jaegeuk-macbookpro.roam.corp.google.com>
 <0add4210-2250-55fa-7d30-4811fc0b4456@kernel.org>
 <20180723132728.GB23437@jaegeuk-macbookpro.roam.corp.google.com>
 <20757a67-2ac1-f7b7-7cce-1e3743fd3324@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20757a67-2ac1-f7b7-7cce-1e3743fd3324@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05, Chao Yu wrote:
> On 2018/7/23 21:27, Jaegeuk Kim wrote:
> > On 07/23, Chao Yu wrote:
> >> On 2018/7/23 21:17, Jaegeuk Kim wrote:
> >>> On 07/15, Chao Yu wrote:
> >>>> Hi Jaegeuk,
> >>>>
> >>>> Could you try this v2 to see whether it can solve the error injection problem?
> 
> Hi Jaegeuk,
> 
> I still can not reproduce your issue, could you reproduce it, and provider more
> info including xfstest env and kernel dmesg?
> 
> And, to make sure you apply the correct patch, could you check below condition
> in your tree:
> 
> if (f2fs_has_inline_data(inode) &&
> 	(!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))) {

Hmm, I don't see the error in the latest branch having this patch. Will keep an
eye on the test results. :P

> 
> Thanks,
> 
> >>>
> >>> That doesn't work still.
> >>
> >> Any dmesg there?
> > 
> > Just hit the below inline_data case and failed to mount the disk.
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>> On 2018/6/29 0:19, Chao Yu wrote:
> >>>>> From: Chao Yu <yuchao0@huawei.com>
> >>>>>
> >>>>> https://bugzilla.kernel.org/show_bug.cgi?id=200221
> >>>>>
> >>>>> - Overview
> >>>>> BUG() in clear_inode() when mounting and un-mounting a corrupted f2fs image
> >>>>>
> >>>>> - Reproduce
> >>>>>
> >>>>> - Kernel message
> >>>>> [  538.601448] F2FS-fs (loop0): Invalid segment/section count (31, 24 x 1376257)
> >>>>> [  538.601458] F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
> >>>>> [  538.724091] F2FS-fs (loop0): Try to recover 2th superblock, ret: 0
> >>>>> [  538.724102] F2FS-fs (loop0): Mounted with checkpoint version = 2
> >>>>> [  540.970834] ------------[ cut here ]------------
> >>>>> [  540.970838] kernel BUG at fs/inode.c:512!
> >>>>> [  540.971750] invalid opcode: 0000 [#1] SMP KASAN PTI
> >>>>> [  540.972755] CPU: 1 PID: 1305 Comm: umount Not tainted 4.18.0-rc1+ #4
> >>>>> [  540.974034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> >>>>> [  540.982913] RIP: 0010:clear_inode+0xc0/0xd0
> >>>>> [  540.983774] Code: 8d a3 30 01 00 00 4c 89 e7 e8 1c ec f8 ff 48 8b 83 30 01 00 00 49 39 c4 75 1a 48 c7 83 a0 00 00 00 60 00 00 00 5b 41 5c 5d c3 <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 1f 40 00 66 66 66 66 90 55
> >>>>> [  540.987570] RSP: 0018:ffff8801e34a7b70 EFLAGS: 00010002
> >>>>> [  540.988636] RAX: 0000000000000000 RBX: ffff8801e9b744e8 RCX: ffffffffb840eb3a
> >>>>> [  540.990063] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8801e9b746b8
> >>>>> [  540.991499] RBP: ffff8801e34a7b80 R08: ffffed003d36e8ce R09: ffffed003d36e8ce
> >>>>> [  540.992923] R10: 0000000000000001 R11: ffffed003d36e8cd R12: ffff8801e9b74668
> >>>>> [  540.994360] R13: ffff8801e9b74760 R14: ffff8801e9b74528 R15: ffff8801e9b74530
> >>>>> [  540.995786] FS:  00007f4662bdf840(0000) GS:ffff8801f6f00000(0000) knlGS:0000000000000000
> >>>>> [  540.997403] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> [  540.998571] CR2: 000000000175c568 CR3: 00000001dcfe6000 CR4: 00000000000006e0
> >>>>> [  541.000015] Call Trace:
> >>>>> [  541.000554]  f2fs_evict_inode+0x253/0x630
> >>>>> [  541.001381]  evict+0x16f/0x290
> >>>>> [  541.002015]  iput+0x280/0x300
> >>>>> [  541.002654]  dentry_unlink_inode+0x165/0x1e0
> >>>>> [  541.003528]  __dentry_kill+0x16a/0x260
> >>>>> [  541.004300]  dentry_kill+0x70/0x250
> >>>>> [  541.005018]  dput+0x154/0x1d0
> >>>>> [  541.005635]  do_one_tree+0x34/0x40
> >>>>> [  541.006354]  shrink_dcache_for_umount+0x3f/0xa0
> >>>>> [  541.007285]  generic_shutdown_super+0x43/0x1c0
> >>>>> [  541.008192]  kill_block_super+0x52/0x80
> >>>>> [  541.008978]  kill_f2fs_super+0x62/0x70
> >>>>> [  541.009750]  deactivate_locked_super+0x6f/0xa0
> >>>>> [  541.010664]  deactivate_super+0x5e/0x80
> >>>>> [  541.011450]  cleanup_mnt+0x61/0xa0
> >>>>> [  541.012151]  __cleanup_mnt+0x12/0x20
> >>>>> [  541.012893]  task_work_run+0xc8/0xf0
> >>>>> [  541.013635]  exit_to_usermode_loop+0x125/0x130
> >>>>> [  541.014555]  do_syscall_64+0x138/0x170
> >>>>> [  541.015340]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>>>> [  541.016375] RIP: 0033:0x7f46624bf487
> >>>>> [  541.017104] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 c9 2b 00 f7 d8 64 89 01 48
> >>>>> [  541.020923] RSP: 002b:00007fff5e12e9a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> >>>>> [  541.022452] RAX: 0000000000000000 RBX: 0000000001753030 RCX: 00007f46624bf487
> >>>>> [  541.023885] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000000175a1e0
> >>>>> [  541.025318] RBP: 000000000175a1e0 R08: 0000000000000000 R09: 0000000000000014
> >>>>> [  541.026755] R10: 00000000000006b2 R11: 0000000000000246 R12: 00007f46629c883c
> >>>>> [  541.028186] R13: 0000000000000000 R14: 0000000001753210 R15: 00007fff5e12ec30
> >>>>> [  541.029626] Modules linked in: snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hwdep snd_hda_core snd_pcm snd_timer snd mac_hid i2c_piix4 soundcore ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx raid1 raid0 multipath linear 8139too crct10dif_pclmul crc32_pclmul qxl drm_kms_helper syscopyarea aesni_intel sysfillrect sysimgblt fb_sys_fops ttm drm aes_x86_64 crypto_simd cryptd 8139cp glue_helper mii pata_acpi floppy
> >>>>> [  541.039445] ---[ end trace 4ce02f25ff7d3df5 ]---
> >>>>> [  541.040392] RIP: 0010:clear_inode+0xc0/0xd0
> >>>>> [  541.041240] Code: 8d a3 30 01 00 00 4c 89 e7 e8 1c ec f8 ff 48 8b 83 30 01 00 00 49 39 c4 75 1a 48 c7 83 a0 00 00 00 60 00 00 00 5b 41 5c 5d c3 <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 0b 0f 1f 40 00 66 66 66 66 90 55
> >>>>> [  541.045042] RSP: 0018:ffff8801e34a7b70 EFLAGS: 00010002
> >>>>> [  541.046099] RAX: 0000000000000000 RBX: ffff8801e9b744e8 RCX: ffffffffb840eb3a
> >>>>> [  541.047537] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8801e9b746b8
> >>>>> [  541.048965] RBP: ffff8801e34a7b80 R08: ffffed003d36e8ce R09: ffffed003d36e8ce
> >>>>> [  541.050402] R10: 0000000000000001 R11: ffffed003d36e8cd R12: ffff8801e9b74668
> >>>>> [  541.051832] R13: ffff8801e9b74760 R14: ffff8801e9b74528 R15: ffff8801e9b74530
> >>>>> [  541.053263] FS:  00007f4662bdf840(0000) GS:ffff8801f6f00000(0000) knlGS:0000000000000000
> >>>>> [  541.054891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> [  541.056039] CR2: 000000000175c568 CR3: 00000001dcfe6000 CR4: 00000000000006e0
> >>>>> [  541.058506] ==================================================================
> >>>>> [  541.059991] BUG: KASAN: stack-out-of-bounds in update_stack_state+0x38c/0x3e0
> >>>>> [  541.061513] Read of size 8 at addr ffff8801e34a7970 by task umount/1305
> >>>>>
> >>>>> [  541.063302] CPU: 1 PID: 1305 Comm: umount Tainted: G      D           4.18.0-rc1+ #4
> >>>>> [  541.064838] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
> >>>>> [  541.066778] Call Trace:
> >>>>> [  541.067294]  dump_stack+0x7b/0xb5
> >>>>> [  541.067986]  print_address_description+0x70/0x290
> >>>>> [  541.068941]  kasan_report+0x291/0x390
> >>>>> [  541.069692]  ? update_stack_state+0x38c/0x3e0
> >>>>> [  541.070598]  __asan_load8+0x54/0x90
> >>>>> [  541.071315]  update_stack_state+0x38c/0x3e0
> >>>>> [  541.072172]  ? __read_once_size_nocheck.constprop.7+0x20/0x20
> >>>>> [  541.073340]  ? vprintk_func+0x27/0x60
> >>>>> [  541.074096]  ? printk+0xa3/0xd3
> >>>>> [  541.074762]  ? __save_stack_trace+0x5e/0x100
> >>>>> [  541.075634]  unwind_next_frame.part.5+0x18e/0x490
> >>>>> [  541.076594]  ? unwind_dump+0x290/0x290
> >>>>> [  541.077368]  ? __show_regs+0x2c4/0x330
> >>>>> [  541.078142]  __unwind_start+0x106/0x190
> >>>>> [  541.085422]  __save_stack_trace+0x5e/0x100
> >>>>> [  541.086268]  ? __save_stack_trace+0x5e/0x100
> >>>>> [  541.087161]  ? unlink_anon_vmas+0xba/0x2c0
> >>>>> [  541.087997]  save_stack_trace+0x1f/0x30
> >>>>> [  541.088782]  save_stack+0x46/0xd0
> >>>>> [  541.089475]  ? __alloc_pages_slowpath+0x1420/0x1420
> >>>>> [  541.090477]  ? flush_tlb_mm_range+0x15e/0x220
> >>>>> [  541.091364]  ? __dec_node_state+0x24/0xb0
> >>>>> [  541.092180]  ? lock_page_memcg+0x85/0xf0
> >>>>> [  541.092979]  ? unlock_page_memcg+0x16/0x80
> >>>>> [  541.093812]  ? page_remove_rmap+0x198/0x520
> >>>>> [  541.094674]  ? mark_page_accessed+0x133/0x200
> >>>>> [  541.095559]  ? _cond_resched+0x1a/0x50
> >>>>> [  541.096326]  ? unmap_page_range+0xcd4/0xe50
> >>>>> [  541.097179]  ? rb_next+0x58/0x80
> >>>>> [  541.097845]  ? rb_next+0x58/0x80
> >>>>> [  541.098518]  __kasan_slab_free+0x13c/0x1a0
> >>>>> [  541.099352]  ? unlink_anon_vmas+0xba/0x2c0
> >>>>> [  541.100184]  kasan_slab_free+0xe/0x10
> >>>>> [  541.100934]  kmem_cache_free+0x89/0x1e0
> >>>>> [  541.101724]  unlink_anon_vmas+0xba/0x2c0
> >>>>> [  541.102534]  free_pgtables+0x101/0x1b0
> >>>>> [  541.103299]  exit_mmap+0x146/0x2a0
> >>>>> [  541.103996]  ? __ia32_sys_munmap+0x50/0x50
> >>>>> [  541.104829]  ? kasan_check_read+0x11/0x20
> >>>>> [  541.105649]  ? mm_update_next_owner+0x322/0x380
> >>>>> [  541.106578]  mmput+0x8b/0x1d0
> >>>>> [  541.107191]  do_exit+0x43a/0x1390
> >>>>> [  541.107876]  ? mm_update_next_owner+0x380/0x380
> >>>>> [  541.108791]  ? deactivate_super+0x5e/0x80
> >>>>> [  541.109610]  ? cleanup_mnt+0x61/0xa0
> >>>>> [  541.110351]  ? __cleanup_mnt+0x12/0x20
> >>>>> [  541.111115]  ? task_work_run+0xc8/0xf0
> >>>>> [  541.111879]  ? exit_to_usermode_loop+0x125/0x130
> >>>>> [  541.112817]  rewind_stack_do_exit+0x17/0x20
> >>>>> [  541.113666] RIP: 0033:0x7f46624bf487
> >>>>> [  541.114404] Code: Bad RIP value.
> >>>>> [  541.115094] RSP: 002b:00007fff5e12e9a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> >>>>> [  541.116605] RAX: 0000000000000000 RBX: 0000000001753030 RCX: 00007f46624bf487
> >>>>> [  541.118034] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000000175a1e0
> >>>>> [  541.119472] RBP: 000000000175a1e0 R08: 0000000000000000 R09: 0000000000000014
> >>>>> [  541.120890] R10: 00000000000006b2 R11: 0000000000000246 R12: 00007f46629c883c
> >>>>> [  541.122321] R13: 0000000000000000 R14: 0000000001753210 R15: 00007fff5e12ec30
> >>>>>
> >>>>> [  541.124061] The buggy address belongs to the page:
> >>>>> [  541.125042] page:ffffea00078d29c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
> >>>>> [  541.126651] flags: 0x2ffff0000000000()
> >>>>> [  541.127418] raw: 02ffff0000000000 dead000000000100 dead000000000200 0000000000000000
> >>>>> [  541.128963] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> >>>>> [  541.130516] page dumped because: kasan: bad access detected
> >>>>>
> >>>>> [  541.131954] Memory state around the buggy address:
> >>>>> [  541.132924]  ffff8801e34a7800: 00 f1 f1 f1 f1 00 f4 f4 f4 f3 f3 f3 f3 00 00 00
> >>>>> [  541.134378]  ffff8801e34a7880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>>>> [  541.135814] >ffff8801e34a7900: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
> >>>>> [  541.137253]                                                              ^
> >>>>> [  541.138637]  ffff8801e34a7980: f1 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >>>>> [  541.140075]  ffff8801e34a7a00: 00 00 00 00 00 00 00 00 f3 00 00 00 00 00 00 00
> >>>>> [  541.141509] ==================================================================
> >>>>>
> >>>>> - Location
> >>>>> https://elixir.bootlin.com/linux/v4.18-rc1/source/fs/inode.c#L512
> >>>>> 	BUG_ON(inode->i_data.nrpages);
> >>>>>
> >>>>> The root cause is root directory inode is corrupted, it has both
> >>>>> inline_data and inline_dentry flag, and its nlink is zero, so in
> >>>>> ->evict(), after dropping all page cache, it grabs page #0 for inline
> >>>>> data truncation, result in panic in later clear_inode() where we will
> >>>>> check inode->i_data.nrpages value.
> >>>>>
> >>>>> This patch adds inline flags check in sanity_check_inode, in addition,
> >>>>> do sanity check with root inode's nlink.
> >>>>>
> >>>>> Reported-by Wen Xu <wen.xu@gatech.edu>
> >>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>>> ---
> >>>>> v2:
> >>>>> - fix wrong condition of inode type.
> >>>>>  fs/f2fs/inode.c | 20 ++++++++++++++++++++
> >>>>>  fs/f2fs/super.c |  3 ++-
> >>>>>  2 files changed, 22 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >>>>> index 24d9c93941d4..cd183c135e3d 100644
> >>>>> --- a/fs/f2fs/inode.c
> >>>>> +++ b/fs/f2fs/inode.c
> >>>>> @@ -229,6 +229,26 @@ static bool sanity_check_inode(struct inode *inode)
> >>>>>  			return false;
> >>>>>  		}
> >>>>>  	}
> >>>>> +
> >>>>> +	if (f2fs_has_inline_data(inode) &&
> >>>>> +			(!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))) {
> >>>>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>>> +		f2fs_msg(sbi->sb, KERN_WARNING,
> >>>>> +			"%s: inode (ino=%lx, mode=%u) should not have "
> >>>>> +			"inline_data, run fsck to fix",
> >>>>> +			__func__, inode->i_ino, inode->i_mode);
> >>>>> +		return false;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (f2fs_has_inline_dentry(inode) && !S_ISDIR(inode->i_mode)) {
> >>>>> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
> >>>>> +		f2fs_msg(sbi->sb, KERN_WARNING,
> >>>>> +			"%s: inode (ino=%lx, mode=%u) should not have "
> >>>>> +			"inline_dentry, run fsck to fix",
> >>>>> +			__func__, inode->i_ino, inode->i_mode);
> >>>>> +		return false;
> >>>>> +	}
> >>>>> +
> >>>>>  	return true;
> >>>>>  }
> >>>>>  
> >>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>>>> index a64fee9137dc..a61dd0cf6cc5 100644
> >>>>> --- a/fs/f2fs/super.c
> >>>>> +++ b/fs/f2fs/super.c
> >>>>> @@ -2933,7 +2933,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>>>>  		err = PTR_ERR(root);
> >>>>>  		goto free_stats;
> >>>>>  	}
> >>>>> -	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
> >>>>> +	if (!S_ISDIR(root->i_mode) || !root->i_blocks ||
> >>>>> +			!root->i_size || !root->i_nlink) {
> >>>>>  		iput(root);
> >>>>>  		err = -EINVAL;
> >>>>>  		goto free_stats;
> >>>>>
