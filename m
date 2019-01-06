Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903E0C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544620830
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdP4uZy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfAFTRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:17:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38129 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfAFTRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:17:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id a1so24282254qkc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnXakli20QNkOKzaCmcDWDELA18OccEd2xBITCuhxDM=;
        b=JdP4uZy7VWPc6x0BZHXpv9HIfVQYtAFZIRCXYF46OxnmzZkBfnDOLFbJWBryLccwXJ
         OVAgxE45W1FebkkxdiPZPq3u4eBbvUHGO/ef1+safAGpimxyCKzru/2LZ1sqbr/zmt2d
         SoNL1da9jeywkkjF5+vDbmrhIWA+ZH1D3xIKU6+6JC2bhZxn8eQrDHVHIBE0JNrgc0NC
         QMI3cb2ZY5hjDYfaigbHaORXnoubGTXOnWKdJofue70q1vctggzkhdEN9SofUYh+iDn3
         UlKntLHjov2lDbh6Sr67D+2gMMw5F08Xo4IN7DibzOHzY2rlkqzBPbyHPB08a66O/mMW
         ZE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnXakli20QNkOKzaCmcDWDELA18OccEd2xBITCuhxDM=;
        b=bxVo/Hg/YZMJtDOh0IeqpsdE9FIt7yYN4iF82YMLuOan602zftXpOT4pkDlmg6Hb+K
         EG05qHrCeN/s0NDcW2s/rUDYdh6t3kpFNUpFW86l98PWKAViM1ltfmomsgJr69XEg8Ha
         K2nU+2XBSaJlKISLjCQu72wpwRXu1SjJrctQ/KKLmLDrS92k33mf7sx58JJ49oI3llMY
         CvwmBnzX+JTIaFd/2b0h46Esxtkz64tfwUz5xa4QrBe4/SH1FUxb4y6XCiDPXskWSsu+
         i4+7GYRMoqcIfUAmnsC4Gpl/Q6aDBlO7qH2gWw6/N2Xu4/scgYrlG22k5GzTy9bnNokb
         ScQw==
X-Gm-Message-State: AJcUukdh5auUqwy6qEsIjgX8KViyOJrtGG302laZvl9dkj2GUMFIGIhB
        6OJZwBxEk7Q3MqT3hk+SV1HWI1MYVdIyIdj+5eB8XR/k
X-Google-Smtp-Source: ALg8bN59cI4bP8kY9F7XlzLFieHc93ibPxSt3CkWZbSwks95grZiLxgeO7ZhQ0RVUFxkrYx2LMp5zLIcU867UFHwe1I=
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr54638659qkc.186.1546802236778;
 Sun, 06 Jan 2019 11:17:16 -0800 (PST)
MIME-Version: 1.0
References: <CALaQ_hpCKoLxp-0cgxw9TqPGBSzY7RhrnFZ0jGAQ11HbOZkZ3w@mail.gmail.com>
 <CALaQ_hpfSBM7sY0dW-k32K2wDyTHuYJm_V1gMc46nG7ZBiPazQ@mail.gmail.com>
In-Reply-To: <CALaQ_hpfSBM7sY0dW-k32K2wDyTHuYJm_V1gMc46nG7ZBiPazQ@mail.gmail.com>
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Sun, 6 Jan 2019 13:17:04 -0600
Message-ID: <CALaQ_hppes_dHvxsp5V045MVjS2Poq=GLp6UMhJYZavf5eC60Q@mail.gmail.com>
Subject: Re: kmemleak: Cannot allocate a kmemleak_object structure - Kernel 4.19.13
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now it just looks like it crashes on it's own with no issues from
anything else (note the surrounding event entries which is just the
temperature sensor.):
*****
Jan 06 03:27:03 computername plasmashell[1065]: qml: temp unit: 0
Jan 06 03:27:09 computername plasmashell[1065]: qml: temp unit: 0
Jan 06 03:27:12 computername plasmashell[1065]: qml: temp unit: 0
Jan 06 03:27:14 computername kernel: WARNING: CPU: 0 PID: 24136 at
mm/page_alloc.c:4254 __alloc_pages_nodemask+0xf52/0xfb0
Jan 06 03:27:16 computername kernel: Modules linked in: ext4 mbcache
jbd2 fscrypto rfcomm ccm bnep nct6775 hwmon_vid nls_iso8859_1
nls_cp437 vfat fat tda18271 au8522_dig au8522_common au0828 tveeprom
dvb_core v4l2_common videobuf2_vmalloc videobuf2_memops arc4
videobuf2_v4l2 >
Jan 06 03:27:16 computername kernel:  snd_pcm_dmaengine snd_hwdep
snd_pcm snd_timer mdio i2c_i801 snd evdev pcc_cpufreq mac_hid mei_me
lpc_ich soundcore mei crypto_user ip_tables x_tables serpent_avx2
serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic xts
algif_skcipher a>
Jan 06 03:27:16 computername kernel: CPU: 0 PID: 24136 Comm:
kworker/u9:2 Tainted: G        W         4.19.13-dirty #2
Jan 06 03:27:16 computername kernel: Hardware name: To Be Filled By
O.E.M. To Be Filled By O.E.M./H97M-ITX/ac, BIOS P1.80 07/27/2015
Jan 06 03:27:16 computername kernel: Workqueue: kcryptd kcryptd_crypt [dm_crypt]
Jan 06 03:27:16 computername kernel: RIP:
0010:__alloc_pages_nodemask+0xf52/0xfb0
Jan 06 03:27:16 computername kernel: Code: c7 44 24 54 00 00 00 00 25
ff ff f7 ff 89 44 24 18 e9 ea f3 ff ff 48 89 9c 24 80 00 00 00 e9 ad
f3 ff ff 0f 0b e9 dc fc ff ff <0f> 0b 48 8b b4 24 80 00 00 00 8b 7c 24
18 44 89 f1 48 c7 c2 40 9e
Jan 06 03:27:16 computername kernel: RSP: 0018:ffffae528d43f9d0 EFLAGS: 00010046
Jan 06 03:27:16 computername kernel: RAX: 0000000000000000 RBX:
0000000000400000 RCX: 0000000000000000
Jan 06 03:27:16 computername kernel: RDX: 0000000000000000 RSI:
0000000000000002 RDI: ffff9fa15fdfc000
Jan 06 03:27:16 computername kernel: RBP: 0000000000000000 R08:
0000000000000040 R09: 0000000000000f82
Jan 06 03:27:16 computername kernel: R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jan 06 03:27:16 computername kernel: R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jan 06 03:27:16 computername kernel: FS:  0000000000000000(0000)
GS:ffff9fa158000000(0000) knlGS:0000000000000000
Jan 06 03:27:16 computername kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 06 03:27:16 computername kernel: CR2: 00007f4770001a90 CR3:
000000018c80a006 CR4: 00000000001606f0
Jan 06 03:27:16 computername kernel: Call Trace:
Jan 06 03:27:16 computername kernel:  ? __switch_to_asm+0x34/0x70
Jan 06 03:27:16 computername kernel:  ? kcryptd_crypt+0x1d1/0x3a0 [dm_crypt]
Jan 06 03:27:16 computername kernel:  ? kcryptd_crypt+0x1d1/0x3a0 [dm_crypt]
Jan 06 03:27:16 computername kernel:  ? orc_find+0x108/0x190
Jan 06 03:27:16 computername kernel:  ? ret_from_fork+0x35/0x40
Jan 06 03:27:16 computername kernel:  new_slab+0x2fb/0x6f0
Jan 06 03:27:16 computername kernel:  ? _raw_spin_lock+0x13/0x40
Jan 06 03:27:16 computername kernel:  ? deactivate_slab.isra.27+0x5b4/0x690
Jan 06 03:27:16 computername kernel:  ___slab_alloc+0x43f/0x630
Jan 06 03:27:16 computername kernel:  ? create_object+0x43/0x2a0
Jan 06 03:27:16 computername kernel:  ? ___slab_alloc+0x58d/0x630
Jan 06 03:27:16 computername kernel:  ? create_object+0x43/0x2a0
Jan 06 03:27:16 computername kernel:  __slab_alloc.isra.28+0x52/0x70
Jan 06 03:27:16 computername kernel:  ? create_object+0x43/0x2a0
Jan 06 03:27:16 computername kernel:  kmem_cache_alloc+0x1c5/0x210
Jan 06 03:27:16 computername kernel:  ? mempool_alloc+0x65/0x180
Jan 06 03:27:16 computername kernel:  create_object+0x43/0x2a0
Jan 06 03:27:16 computername kernel:  ? mempool_alloc+0x65/0x180
Jan 06 03:27:16 computername kernel:  kmem_cache_alloc+0x1a6/0x210
Jan 06 03:27:16 computername kernel:  ? wait_woken+0x80/0x80
Jan 06 03:27:16 computername kernel:  mempool_alloc+0x65/0x180
Jan 06 03:27:16 computername kernel:  ? wait_woken+0x80/0x80
Jan 06 03:27:16 computername kernel:  ? mempool_alloc+0x65/0x180
Jan 06 03:27:16 computername kernel:  ? tracing_record_taskinfo+0xe/0xa0
Jan 06 03:27:16 computername kernel:  bvec_alloc+0x82/0xe0
Jan 06 03:27:16 computername kernel:  bio_alloc_bioset+0x1b6/0x220
Jan 06 03:27:16 computername kernel:  kcryptd_crypt+0x1d1/0x3a0 [dm_crypt]
Jan 06 03:27:16 computername kernel:  process_one_work+0x1eb/0x410
Jan 06 03:27:16 computername kernel:  worker_thread+0x2d/0x3d0
Jan 06 03:27:16 computername kernel:  ? process_one_work+0x410/0x410
Jan 06 03:27:16 computername kernel:  kthread+0x112/0x130
Jan 06 03:27:16 computername kernel:  ? kthread_park+0x80/0x80
Jan 06 03:27:16 computername kernel:  ret_from_fork+0x35/0x40
Jan 06 03:27:16 computername kernel: ---[ end trace ded91f3b1e5201b6 ]---
Jan 06 03:27:16 computername kernel: kmemleak: Cannot allocate a
kmemleak_object structure
Jan 06 03:27:16 computername kernel: kmemleak: Kernel memory leak
detector disabled
Jan 06 03:27:16 computername kernel: kmemleak: Automatic memory
scanning thread ended
Jan 06 03:27:16 computername kernel: kmemleak: Kmemleak disabled
without freeing internal data. Reclaim the memory with "echo clear >
/sys/kernel/debug/kmemleak".
Jan 06 03:27:15 computername plasmashell[1065]: qml: temp unit: 0
Jan 06 03:27:21 computername plasmashell[1065]: qml: temp unit: 0
Jan 06 03:27:24 computername plasmashell[1065]: qml: temp unit: 0
*****

On Tue, Jan 1, 2019 at 7:04 PM Nathan Royce <nroycea+kernel@gmail.com> wrote:
>
> It was unrelated to my USB issue. It happened again after I rebooted
> within 4 hours of uptime.
> This time there were 2 traces, one right after the other and included
> another line number.
> *****
> Jan 01 17:47:54 computername plasmashell[1048]: qt.qpa.xcb:
> QXcbConnection: XCB error: 2 (BadValue), sequence: 45625, resource id:
> 69206018, major code: 142 (Unknown), minor code: 3
> Jan 01 17:50:14 computername kernel: WARNING: CPU: 3 PID: 2154 at
> mm/page_alloc.c:4262 __alloc_pages_nodemask+0xf74/0xfb0
> Jan 01 17:50:15 computername kernel: Modules linked in: rfcomm ccm
> bnep nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat tda18271
> au8522_dig au8522_common au0828 tveeprom dvb_core arc4 v4l2_common
> intel_rapl snd_soc_rt5640 iTCO_wdt rtl8821ae x86_pkg_temp_thermal
> btcoexist i>
> Jan 01 17:50:16 computername kernel:  soundcore mei_me lpc_ich mei
> crypto_user ip_tables x_tables serpent_avx2 serpent_avx_x86_64
> serpent_sse2_x86_64 serpent_generic xts algif_skcipher af_alg uas
> usb_storage dm_crypt dm_mod sr_mod cdrom sd_mod hid_logitech_hidpp
> hid_logitech_>
> Jan 01 17:50:16 computername kernel: CPU: 3 PID: 2154 Comm:
> PeripBusCEC Not tainted 4.19.13-dirty #2
> Jan 01 17:50:16 computername kernel: Hardware name: To Be Filled By
> O.E.M. To Be Filled By O.E.M./H97M-ITX/ac, BIOS P1.80 07/27/2015
> Jan 01 17:50:16 computername kernel: RIP:
> 0010:__alloc_pages_nodemask+0xf74/0xfb0
> Jan 01 17:50:16 computername kernel: Code: ff 0f 0b e9 dc fc ff ff 0f
> 0b 48 8b b4 24 80 00 00 00 8b 7c 24 18 44 89 f1 48 c7 c2 40 9e 4a b6
> e8 91 ef ff ff e9 d3 f1 ff ff <0f> 0b e9 a9 fc ff ff e8 c0 7f ea ff 85
> d2 0f 85 15 fd ff ff 48 c7
> Jan 01 17:50:16 computername kernel: RSP: 0018:ffff999e032731e0 EFLAGS: 00010202
> Jan 01 17:50:16 computername kernel: RAX: ffff8bbcbabc0040 RBX:
> 0000000000400000 RCX: 0000000000200000
> Jan 01 17:50:16 computername kernel: RDX: 0000000000000000 RSI:
> 0000000000000002 RDI: ffff8bbd9fdfc000
> Jan 01 17:50:16 computername kernel: RBP: 0000000000200000 R08:
> 0000000000000040 R09: 0000000000000f82
> Jan 01 17:50:16 computername kernel: R10: 0000000000200000 R11:
> 0000000000000000 R12: 0000000000000000
> Jan 01 17:50:16 computername kernel: R13: 0000000000000000 R14:
> 0000000000000000 R15: 0000000000000000
> Jan 01 17:50:16 computername kernel: FS:  00007f9515642700(0000)
> GS:ffff8bbd98180000(0000) knlGS:0000000000000000
> Jan 01 17:50:16 computername kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 01 17:50:16 computername kernel: CR2: 00007fdbd95b1000 CR3:
> 000000011087c003 CR4: 00000000001626e0
> Jan 01 17:50:16 computername kernel: Call Trace:
> Jan 01 17:50:16 computername kernel:  ? ___slab_alloc+0x43f/0x630
> Jan 01 17:50:16 computername kernel:  ? orc_find+0x108/0x190
> Jan 01 17:50:16 computername kernel:  ? kmem_cache_alloc+0x1c5/0x210
> Jan 01 17:50:16 computername kernel:  ? unwind_next_frame+0x2f8/0x460
> Jan 01 17:50:16 computername kernel:  new_slab+0x2fb/0x6f0
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_unlock+0x16/0x30
> Jan 01 17:50:16 computername kernel:  ? deactivate_slab.isra.27+0x5b4/0x690
> Jan 01 17:50:16 computername kernel:  ___slab_alloc+0x43f/0x630
> Jan 01 17:50:16 computername kernel:  ? alloc_extent_state+0x1f/0xd0 [btrfs]
> Jan 01 17:50:16 computername kernel:  ? create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  ? ___slab_alloc+0x58d/0x630
> Jan 01 17:50:16 computername kernel:  ? create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  __slab_alloc.isra.28+0x52/0x70
> Jan 01 17:50:16 computername kernel:  ? create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  kmem_cache_alloc+0x1c5/0x210
> Jan 01 17:50:16 computername kernel:  ? alloc_extent_state+0x1f/0xd0 [btrfs]
> Jan 01 17:50:16 computername kernel:  create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  ? alloc_extent_state+0x1f/0xd0 [btrfs]
> Jan 01 17:50:16 computername kernel:  kmem_cache_alloc+0x1a6/0x210
> Jan 01 17:50:16 computername kernel:  alloc_extent_state+0x1f/0xd0 [btrfs]
> Jan 01 17:50:16 computername kernel:  __clear_extent_bit+0x297/0x390 [btrfs]
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_unlock+0x16/0x30
> Jan 01 17:50:16 computername kernel:
> try_release_extent_mapping+0x1b4/0x220 [btrfs]
> Jan 01 17:50:16 computername kernel:  btrfs_releasepage+0x45/0x60 [btrfs]
> Jan 01 17:50:16 computername kernel:  shrink_page_list+0xb20/0xc80
> Jan 01 17:50:16 computername kernel:  shrink_inactive_list+0x29f/0x6b0
> Jan 01 17:50:16 computername kernel:  shrink_node_memcg+0x20f/0x780
> Jan 01 17:50:16 computername kernel:  shrink_node+0xcf/0x4a0
> Jan 01 17:50:16 computername kernel:  do_try_to_free_pages+0xc6/0x370
> Jan 01 17:50:16 computername kernel:  try_to_free_pages+0xca/0x1e0
> Jan 01 17:50:16 computername kernel:  __alloc_pages_nodemask+0x616/0xfb0
> Jan 01 17:50:16 computername kernel:  ? __kernel_text_address+0xe/0x30
> Jan 01 17:50:16 computername kernel:  ? unwind_get_return_address+0x1b/0x30
> Jan 01 17:50:16 computername kernel:  ? __save_stack_trace+0x92/0x100
> Jan 01 17:50:16 computername kernel:  new_slab+0x2fb/0x6f0
> Jan 01 17:50:16 computername kernel:  ___slab_alloc+0x43f/0x630
> Jan 01 17:50:16 computername kernel:  ? __alloc_file+0x2a/0xe0
> Jan 01 17:50:16 computername kernel:  ? unwind_get_return_address+0x1b/0x30
> Jan 01 17:50:16 computername kernel:  ? preempt_count_add+0x79/0xb0
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_lock+0x13/0x40
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_unlock+0x16/0x30
> Jan 01 17:50:16 computername kernel:  ? deactivate_slab.isra.27+0x5b4/0x690
> Jan 01 17:50:16 computername kernel:  ? __alloc_file+0x2a/0xe0
> Jan 01 17:50:16 computername kernel:  __slab_alloc.isra.28+0x52/0x70
> Jan 01 17:50:16 computername kernel:  ? __alloc_file+0x2a/0xe0
> Jan 01 17:50:16 computername kernel:  kmem_cache_alloc+0x1c5/0x210
> Jan 01 17:50:16 computername kernel:  __alloc_file+0x2a/0xe0
> Jan 01 17:50:16 computername kernel:  alloc_empty_file+0x43/0xc0
> Jan 01 17:50:16 computername kernel:  ? getname_flags+0x4a/0x1e0
> Jan 01 17:50:16 computername kernel:  path_openat+0x4c/0x14e0
> Jan 01 17:50:16 computername kernel:  ? is_bpf_text_address+0x1e/0x30
> Jan 01 17:50:16 computername kernel:  ? kernel_text_address+0xe5/0xf0
> Jan 01 17:50:16 computername kernel:  ? __kernel_text_address+0xe/0x30
> Jan 01 17:50:16 computername kernel:  ? unwind_get_return_address+0x1b/0x30
> Jan 01 17:50:16 computername kernel:  ? __save_stack_trace+0x92/0x100
> Jan 01 17:50:16 computername kernel:  do_filp_open+0x93/0x100
> Jan 01 17:50:16 computername kernel:  ? preempt_count_add+0x79/0xb0
> Jan 01 17:50:16 computername kernel:  ? _raw_write_lock_irqsave+0x25/0x50
> Jan 01 17:50:16 computername kernel:  ? _raw_write_unlock_irqrestore+0x1c/0x30
> Jan 01 17:50:16 computername kernel:  ? create_object+0x249/0x2a0
> Jan 01 17:50:16 computername kernel:  ? __check_object_size+0x102/0x189
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_unlock+0x16/0x30
> Jan 01 17:50:16 computername kernel:  do_sys_open+0x186/0x210
> Jan 01 17:50:16 computername kernel:  do_syscall_64+0x5b/0x170
> Jan 01 17:50:16 computername kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> Jan 01 17:50:16 computername kernel: RIP: 0033:0x7f9551bb8976
> Jan 01 17:50:16 computername kernel: Code: 89 54 24 08 e8 7b f4 ff ff
> 8b 74 24 0c 48 8b 3c 24 41 89 c0 44 8b 54 24 08 b8 01 01 00 00 89 f2
> 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 30 44 89 c7 89 44
> 24 08 e8 a6 f4 ff ff 8b 44
> Jan 01 17:50:16 computername kernel: RSP: 002b:00007f951563c0d0
> EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> Jan 01 17:50:16 computername kernel: RAX: ffffffffffffffda RBX:
> 00007f94f80adb40 RCX: 00007f9551bb8976
> Jan 01 17:50:16 computername kernel: RDX: 00000000002a0000 RSI:
> 00007f954f9693da RDI: 00000000ffffff9c
> Jan 01 17:50:16 computername kernel: RBP: 00007f951563c2b0 R08:
> 0000000000000000 R09: 0000000000000018
> Jan 01 17:50:16 computername kernel: R10: 0000000000000000 R11:
> 0000000000000293 R12: 0000000000000000
> Jan 01 17:50:16 computername kernel: R13: 00007f94f80e4640 R14:
> 0000000000000001 R15: 000000000000000a
> Jan 01 17:50:16 computername kernel: ---[ end trace 2a9048666fdb2310 ]---
> Jan 01 17:50:16 computername kernel: WARNING: CPU: 0 PID: 12528 at
> mm/page_alloc.c:4254 __alloc_pages_nodemask+0xf52/0xfb0
> Jan 01 17:50:16 computername kernel: Modules linked in: rfcomm ccm
> bnep nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat tda18271
> au8522_dig au8522_common au0828 tveeprom dvb_core arc4 v4l2_common
> intel_rapl snd_soc_rt5640 iTCO_wdt rtl8821ae x86_pkg_temp_thermal
> btcoexist i>
> Jan 01 17:50:16 computername kernel:  soundcore mei_me lpc_ich mei
> crypto_user ip_tables x_tables serpent_avx2 serpent_avx_x86_64
> serpent_sse2_x86_64 serpent_generic xts algif_skcipher af_alg uas
> usb_storage dm_crypt dm_mod sr_mod cdrom sd_mod hid_logitech_hidpp
> hid_logitech_>
> Jan 01 17:50:16 computername kernel: CPU: 0 PID: 12528 Comm:
> kworker/u9:5 Tainted: G        W         4.19.13-dirty #2
> Jan 01 17:50:16 computername kernel: Hardware name: To Be Filled By
> O.E.M. To Be Filled By O.E.M./H97M-ITX/ac, BIOS P1.80 07/27/2015
> Jan 01 17:50:16 computername kernel: Workqueue: kcryptd kcryptd_crypt [dm_crypt]
> Jan 01 17:50:16 computername kernel: RIP:
> 0010:__alloc_pages_nodemask+0xf52/0xfb0
> Jan 01 17:50:16 computername kernel: Code: c7 44 24 54 00 00 00 00 25
> ff ff f7 ff 89 44 24 18 e9 ea f3 ff ff 48 89 9c 24 80 00 00 00 e9 ad
> f3 ff ff 0f 0b e9 dc fc ff ff <0f> 0b 48 8b b4 24 80 00 00 00 8b 7c 24
> 18 44 89 f1 48 c7 c2 40 9e
> Jan 01 17:50:16 computername kernel: RSP: 0018:ffff999e030ef9f0 EFLAGS: 00010046
> Jan 01 17:50:16 computername kernel: RAX: 0000000000000000 RBX:
> 0000000000400000 RCX: 0000000000000000
> Jan 01 17:50:16 computername kernel: RDX: 0000000000000000 RSI:
> 0000000000000002 RDI: ffff8bbd9fdfc000
> Jan 01 17:50:16 computername kernel: RBP: 0000000000000000 R08:
> 0000000000000040 R09: 0000000000000f82
> Jan 01 17:50:16 computername kernel: R10: 0000000000000000 R11:
> 0000000000000000 R12: 0000000000000000
> Jan 01 17:50:16 computername kernel: R13: 0000000000000000 R14:
> 0000000000000000 R15: 0000000000000000
> Jan 01 17:50:16 computername kernel: FS:  0000000000000000(0000)
> GS:ffff8bbd98000000(0000) knlGS:0000000000000000
> Jan 01 17:50:16 computername kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> 0000000080050033
> Jan 01 17:50:16 computername kernel: CR2: 00005636c5b233d0 CR3:
> 0000000150a0a006 CR4: 00000000001626f0
> Jan 01 17:50:16 computername kernel: Call Trace:
> Jan 01 17:50:16 computername kernel:  ? orc_find+0x108/0x190
> Jan 01 17:50:16 computername kernel:  ? unwind_next_frame+0x121/0x460
> Jan 01 17:50:16 computername kernel:  ? kcryptd_crypt+0x1d1/0x3a0 [dm_crypt]
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_lock+0x2e/0x40
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_unlock+0x16/0x30
> Jan 01 17:50:16 computername kernel:  new_slab+0x2fb/0x6f0
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_lock+0x13/0x40
> Jan 01 17:50:16 computername kernel:  ? deactivate_slab.isra.27+0x5b4/0x690
> Jan 01 17:50:16 computername kernel:  ___slab_alloc+0x43f/0x630
> Jan 01 17:50:16 computername kernel:  ? create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  ? ___slab_alloc+0x58d/0x630
> Jan 01 17:50:16 computername kernel:  ? create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  __slab_alloc.isra.28+0x52/0x70
> Jan 01 17:50:16 computername kernel:  ? create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  kmem_cache_alloc+0x1c5/0x210
> Jan 01 17:50:16 computername kernel:  ? mempool_alloc+0x65/0x180
> Jan 01 17:50:16 computername kernel:  create_object+0x43/0x2a0
> Jan 01 17:50:16 computername kernel:  ? mempool_alloc+0x65/0x180
> Jan 01 17:50:16 computername kernel:  kmem_cache_alloc+0x1a6/0x210
> Jan 01 17:50:16 computername kernel:  ? wait_woken+0x80/0x80
> Jan 01 17:50:16 computername kernel:  mempool_alloc+0x65/0x180
> Jan 01 17:50:16 computername kernel:  ? crypt_convert+0x96b/0xf50 [dm_crypt]
> Jan 01 17:50:16 computername kernel:  bio_alloc_bioset+0x14c/0x220
> Jan 01 17:50:16 computername kernel:  ? _raw_spin_lock_irqsave+0x25/0x50
> Jan 01 17:50:16 computername kernel:  kcryptd_crypt+0x1d1/0x3a0 [dm_crypt]
> Jan 01 17:50:16 computername kernel:  process_one_work+0x1eb/0x410
> Jan 01 17:50:16 computername kernel:  worker_thread+0x2d/0x3d0
> Jan 01 17:50:16 computername kernel:  ? process_one_work+0x410/0x410
> Jan 01 17:50:16 computername kernel:  kthread+0x112/0x130
> Jan 01 17:50:16 computername kernel:  ? kthread_park+0x80/0x80
> Jan 01 17:50:16 computername kernel:  ret_from_fork+0x35/0x40
> Jan 01 17:50:16 computername kernel: ---[ end trace 2a9048666fdb2311 ]---
> Jan 01 17:50:16 computername kernel: kmemleak: Cannot allocate a
> kmemleak_object structure
> Jan 01 17:50:16 computername kernel: kmemleak: Kernel memory leak
> detector disabled
> Jan 01 17:50:16 computername kernel: kmemleak: Automatic memory
> scanning thread ended
> Jan 01 17:50:16 computername kernel: kmemleak: Kmemleak disabled
> without freeing internal data. Reclaim the memory with "echo clear >
> /sys/kernel/debug/kmemleak".
> Jan 01 17:50:25 computername plasmashell[1048]: qt.qpa.xcb:
> QXcbConnection: XCB error: 2 (BadValue), sequence: 47417, resource id:
> 71303170, major code: 142 (Unknown), minor code: 3
> *****
>
> On Tue, Jan 1, 2019 at 1:17 PM Nathan Royce <nroycea+kernel@gmail.com> wrote:
> >
> > Kernel 4.19.13
> >
> > *****
> > Jan 01 02:04:20 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> > unknown event type 37
> > Jan 01 02:04:20 computername kernel: WARNING: CPU: 2 PID: 2236 at
> > mm/page_alloc.c:4254 __alloc_pages_nodemask+0xf52/0xfb0
> > Jan 01 02:04:20 computername kernel: Modules linked in: rfcomm ccm
> > bnep nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat tda18271
> > au8522_dig au8522_common au0828 snd_usb_audio tveeprom snd_usbmidi_lib
> > dvb_core mousedev snd_rawmidi snd_seq_device btusb v4l2_common btrtl
> > vide>
> > Jan 01 02:04:20 computername kernel:  llc intel_rapl_perf soundcore
> > alx i2c_i801 mdio evdev lpc_ich mei_me mei pcc_cpufreq mac_hid
> > crypto_user ip_tables x_tables serpent_avx2 serpent_avx_x86_64
> > serpent_sse2_x86_64 serpent_generic xts algif_skcipher af_alg uas
> > usb_storage dm_c>
> > Jan 01 02:04:20 computername kernel: CPU: 2 PID: 2236 Comm:
> > MainLoopThread Tainted: G        W         4.19.13-dirty #2
> > Jan 01 02:04:20 computername kernel: Hardware name: To Be Filled By
> > O.E.M. To Be Filled By O.E.M./H97M-ITX/ac, BIOS P1.80 07/27/2015
> > Jan 01 02:04:20 computername kernel: RIP:
> > 0010:__alloc_pages_nodemask+0xf52/0xfb0
> > Jan 01 02:04:20 computername kernel: Code: c7 44 24 54 00 00 00 00 25
> > ff ff f7 ff 89 44 24 18 e9 ea f3 ff ff 48 89 9c 24 80 00 00 00 e9 ad
> > f3 ff ff 0f 0b e9 dc fc ff ff <0f> 0b 48 8b b4 24 80 00 00 00 8b 7c 24
> > 18 44 89 f1 48 c7 c2 40 9e
> > Jan 01 02:04:20 computername kernel: RSP: 0018:ffffaf9f81066e90 EFLAGS: 00010046
> > Jan 01 02:04:20 computername kernel: RAX: 0000000000000000 RBX:
> > 0000000000400000 RCX: 0000000000000000
> > Jan 01 02:04:20 computername kernel: RDX: 0000000000000000 RSI:
> > 0000000000000002 RDI: ffff9d26dfdfc000
> > Jan 01 02:04:20 computername kernel: RBP: 0000000000000000 R08:
> > 0000000000000040 R09: 0000000000000f82
> > Jan 01 02:04:20 computername kernel: R10: 0000000000000000 R11:
> > 0000000000000000 R12: 0000000000000000
> > Jan 01 02:04:20 computername kernel: R13: 0000000000000000 R14:
> > 0000000000000000 R15: 0000000000000000
> > Jan 01 02:04:20 computername kernel: FS:  00007f7db94d5700(0000)
> > GS:ffff9d26d8100000(0000) knlGS:0000000000000000
> > Jan 01 02:04:20 computername kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
> > 0000000080050033
> > Jan 01 02:04:20 computername kernel: CR2: 0000000092c9da10 CR3:
> > 00000001baefe002 CR4: 00000000001626e0
> > Jan 01 02:04:20 computername kernel: Call Trace:
> > Jan 01 02:04:20 computername kernel:  ?
> > __dm_make_request.isra.18+0x3f/0xa0 [dm_mod]
> > Jan 01 02:04:20 computername kernel:  ? orc_find+0x108/0x190
> > Jan 01 02:04:20 computername kernel:  ? do_try_to_free_pages+0xc6/0x370
> > Jan 01 02:04:20 computername kernel:  new_slab+0x2fb/0x6f0
> > Jan 01 02:04:20 computername kernel:  ? _raw_spin_lock+0x13/0x40
> > Jan 01 02:04:20 computername kernel:  ? deactivate_slab.isra.27+0x5b4/0x690
> > Jan 01 02:04:20 computername kernel:  ___slab_alloc+0x43f/0x630
> > Jan 01 02:04:20 computername kernel:  ? create_object+0x43/0x2a0
> > Jan 01 02:04:20 computername kernel:  ? ___slab_alloc+0x58d/0x630
> > Jan 01 02:04:20 computername kernel:  ? create_object+0x43/0x2a0
> > Jan 01 02:04:20 computername kernel:  __slab_alloc.isra.28+0x52/0x70
> > Jan 01 02:04:20 computername kernel:  ? create_object+0x43/0x2a0
> > Jan 01 02:04:20 computername kernel:  kmem_cache_alloc+0x1c5/0x210
> > Jan 01 02:04:20 computername kernel:  ? mempool_alloc+0x65/0x180
> > Jan 01 02:04:20 computername kernel:  create_object+0x43/0x2a0
> > Jan 01 02:04:20 computername kernel:  ? mempool_alloc+0x65/0x180
> > Jan 01 02:04:20 computername kernel:  kmem_cache_alloc+0x1a6/0x210
> > Jan 01 02:04:20 computername kernel:  ? wait_woken+0x80/0x80
> > Jan 01 02:04:20 computername kernel:  mempool_alloc+0x65/0x180
> > Jan 01 02:04:20 computername kernel:  ? __process_bio+0x170/0x170 [dm_mod]
> > Jan 01 02:04:20 computername kernel:  bio_alloc_bioset+0x14c/0x220
> > Jan 01 02:04:20 computername kernel:  ? create_object+0x249/0x2a0
> > Jan 01 02:04:20 computername kernel:  ? __process_bio+0x170/0x170 [dm_mod]
> > Jan 01 02:04:20 computername kernel:  alloc_io+0x24/0x120 [dm_mod]
> > Jan 01 02:04:20 computername kernel:
> > __split_and_process_bio+0x53/0x1a0 [dm_mod]
> > Jan 01 02:04:20 computername kernel:  ? generic_make_request_checks+0x49a/0x6f0
> > Jan 01 02:04:20 computername kernel:  ? blk_queue_enter+0x233/0x260
> > Jan 01 02:04:20 computername kernel:
> > __dm_make_request.isra.18+0x3f/0xa0 [dm_mod]
> > Jan 01 02:04:20 computername kernel:  generic_make_request+0x1b9/0x3d0
> > Jan 01 02:04:20 computername kernel:  ? __se_sys_madvise.cold.2+0xbd/0xbd
> > Jan 01 02:04:20 computername kernel:  submit_bio+0x45/0x140
> > Jan 01 02:04:20 computername kernel:  __swap_writepage+0x133/0x3c0
> > Jan 01 02:04:20 computername kernel:  ? __frontswap_store+0x6e/0xf0
> > Jan 01 02:04:20 computername kernel:  shmem_writepage+0x229/0x310
> > Jan 01 02:04:20 computername kernel:  pageout.isra.11+0x117/0x350
> > Jan 01 02:04:20 computername kernel:  shrink_page_list+0x7ea/0xc80
> > Jan 01 02:04:20 computername kernel:  shrink_inactive_list+0x29f/0x6b0
> > Jan 01 02:04:20 computername kernel:  shrink_node_memcg+0x20f/0x780
> > Jan 01 02:04:20 computername kernel:  shrink_node+0xcf/0x4a0
> > Jan 01 02:04:20 computername kernel:  do_try_to_free_pages+0xc6/0x370
> > Jan 01 02:04:20 computername kernel:  try_to_free_pages+0xca/0x1e0
> > Jan 01 02:04:20 computername kernel:  __alloc_pages_nodemask+0x616/0xfb0
> > Jan 01 02:04:20 computername kernel:  ? reweight_entity+0x15b/0x1a0
> > Jan 01 02:04:20 computername kernel:  ? check_preempt_wakeup+0x113/0x230
> > Jan 01 02:04:20 computername kernel:  __get_free_pages+0xd/0x30
> > Jan 01 02:04:20 computername kernel:  __pollwait+0x8a/0xd0
> > Jan 01 02:04:20 computername kernel:  tcp_poll+0x3a/0x260
> > Jan 01 02:04:20 computername kernel:  sock_poll+0x83/0xb0
> > Jan 01 02:04:20 computername kernel:  do_sys_poll+0x252/0x520
> > Jan 01 02:04:20 computername kernel:  ? ioapic_service+0x117/0x140 [kvm]
> > Jan 01 02:04:20 computername kernel:  ? poll_initwait+0x40/0x40
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  ?
> > compat_poll_select_copy_remaining+0x150/0x150
> > Jan 01 02:04:20 computername kernel:  __se_sys_ppoll+0x154/0x180
> > Jan 01 02:04:20 computername kernel:  ? ksys_ioctl+0x71/0x90
> > Jan 01 02:04:20 computername kernel:  do_syscall_64+0x5b/0x170
> > Jan 01 02:04:20 computername kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > Jan 01 02:04:20 computername kernel: RIP: 0033:0x7f7dc5d22d16
> > Jan 01 02:04:20 computername kernel: Code: 7c 24 08 e8 6c 84 01 00 41
> > b8 08 00 00 00 4c 8b 54 24 18 48 89 da 41 89 c1 48 8b 74 24 10 48 8b
> > 7c 24 08 b8 0f 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 25 44 89 cf 89 44
> > 24 08 e8 96 84 01 00 8b 44
> > Jan 01 02:04:20 computername kernel: RSP: 002b:00007f7db94d4540
> > EFLAGS: 00000293 ORIG_RAX: 000000000000010f
> > Jan 01 02:04:20 computername kernel: RAX: ffffffffffffffda RBX:
> > 00007f7db94d4560 RCX: 00007f7dc5d22d16
> > Jan 01 02:04:20 computername kernel: RDX: 00007f7db94d4560 RSI:
> > 000000000000001d RDI: 00007f7da80ae750
> > Jan 01 02:04:20 computername kernel: RBP: 0000000000000000 R08:
> > 0000000000000008 R09: 0000000000000000
> > Jan 01 02:04:20 computername kernel: R10: 0000000000000000 R11:
> > 0000000000000293 R12: 00007f7db94d45bc
> > Jan 01 02:04:20 computername kernel: R13: 00000000023c31c8 R14:
> > 00007f7da80a92a0 R15: 00000000009826c9
> > Jan 01 02:04:20 computername kernel: ---[ end trace 8ed9f92f3ae55658 ]---
> > Jan 01 02:04:20 computername kernel: kmemleak: Cannot allocate a
> > kmemleak_object structure
> > Jan 01 02:04:20 computername kernel: kmemleak: Kernel memory leak
> > detector disabled
> > Jan 01 02:04:20 computername kernel: kmemleak: Automatic memory
> > scanning thread ended
> > Jan 01 02:04:20 computername kernel: kmemleak: Kmemleak disabled
> > without freeing internal data. Reclaim the memory with "echo clear >
> > /sys/kernel/debug/kmemleak".
> > Jan 01 02:04:20 computername kernel: xhci_hcd 0000:00:14.0: ERROR
> > unknown event type 37
> > *****
> >
> > Reference Mail: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event
> > type 37 - Kernel 4.19.13
> >
> > I had a leak somewhere and I was directed to look into SUnreclaim
> > which was 5.5 GB after an uptime of a little over 1 month on an 8 GB
> > system. kmalloc-2048 was a problem.
> > I just had enough and needed to find out the cause for my lagging system.
> >
> > I finally upgraded from 4.18.16 to 4.19.13 and enabled kmemleak to
> > hunt for the culprit. I don't think a day had elapsed before kmemleak
> > crashed and disabled itself.
> >
> > I'm thinking my USB TV tuner or Intel USB controller may have been too
> > much for kmemleak given it occured in the middle of one of the
> > "unknown event type 37" log spams.
