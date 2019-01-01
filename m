Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F123D21871
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvhtaScS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfAATRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 14:17:19 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:37084 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfAATRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 14:17:18 -0500
Received: by mail-qt1-f174.google.com with SMTP id t33so31688860qtt.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 11:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Db7+yfIYPwcHbB7FPP8uJsqRzk4flW3JuWLIZjhdRL4=;
        b=DvhtaScSslzSeeVGjRT56wYjlSdPIxeLFQ/Np0IOjGN9EZP0q+NNZ4zB0M6jsK1U4/
         Ln2HfbHtBih9A4ujf2xu2RulXmBohuR9ftkkhQZZFgjuizBz9asN8c8ogc/1cxiDOMY6
         +rJohydoqCCO0mfRJwY6NjPkr2+bJu7L9sH6DbH4f09Dtjs1La1M0XafDqnqpI5zVOHV
         DTYYbb+O+UDHR8y9JHjLYZbJVs3arh/hTf5AKHN7WdO9bhzbfPOQ4UmeyVS5Y8JS57J7
         6V3vjkLAzVWCqYa8yuC6Fq8OsPHTlrJNTHhFxLwbTO+84QWqLukcmvt9E1yeb+r4JAp+
         /ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Db7+yfIYPwcHbB7FPP8uJsqRzk4flW3JuWLIZjhdRL4=;
        b=kXsVgJnjSR27jnmEUwDYckDScn/mpms3mDqsV/5rVeFE8m7Sh48nYnDMHaFwjew9tR
         dkoqcDM/vJcEHoeFgSAhAU3FLIVqHnMw+FGF+4yevQinSKkBTwKmo1GvV3dkMtdVwX7+
         bBSzsxLfv8TRFHP1NkzppeWfWDS4QLSDqwbC362PoNSdUeFO+C3492H6PWj4plMXH8GX
         PUgRUJbPdKdzAs0Xbn40BuLTaJjnJ7sxumDgtEWAUBLfsj3Tx2ayvuKHdwxRvWI6O/Wg
         /qpkcB80yQ30CW/l+Hk8zP7pyHfjRXRvPh9BA3b5I70K20sUPfNidtcoCJH6WQx/sgcU
         4HCw==
X-Gm-Message-State: AJcUukfHtd1QslO9eI23ubdSWDyGiNN3wSKMP/j1TZA24IG++v7yGFT9
        2QBQZ5P4Sr3OiNoOg8TqjyQapEMeDUm7CdDjd7kDVWSv
X-Google-Smtp-Source: AFSGD/Wvb+NTxGHyEB0FANh5qN5vhmjNfbLM9TwGLd3FO3yEqzV9q+phgcZ55oKZJFBjoN4c7OLTr+KojMC3zEsK0FI=
X-Received: by 2002:ac8:71d0:: with SMTP id i16mr41046283qtp.386.1546370236916;
 Tue, 01 Jan 2019 11:17:16 -0800 (PST)
MIME-Version: 1.0
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 1 Jan 2019 13:17:06 -0600
Message-ID: <CALaQ_hpCKoLxp-0cgxw9TqPGBSzY7RhrnFZ0jGAQ11HbOZkZ3w@mail.gmail.com>
Subject: kmemleak: Cannot allocate a kmemleak_object structure - Kernel 4.19.13
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, catalin.marinas@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 4.19.13

*****
Jan 01 02:04:20 computername kernel: xhci_hcd 0000:00:14.0: ERROR
unknown event type 37
Jan 01 02:04:20 computername kernel: WARNING: CPU: 2 PID: 2236 at
mm/page_alloc.c:4254 __alloc_pages_nodemask+0xf52/0xfb0
Jan 01 02:04:20 computername kernel: Modules linked in: rfcomm ccm
bnep nct6775 hwmon_vid nls_iso8859_1 nls_cp437 vfat fat tda18271
au8522_dig au8522_common au0828 snd_usb_audio tveeprom snd_usbmidi_lib
dvb_core mousedev snd_rawmidi snd_seq_device btusb v4l2_common btrtl
vide>
Jan 01 02:04:20 computername kernel:  llc intel_rapl_perf soundcore
alx i2c_i801 mdio evdev lpc_ich mei_me mei pcc_cpufreq mac_hid
crypto_user ip_tables x_tables serpent_avx2 serpent_avx_x86_64
serpent_sse2_x86_64 serpent_generic xts algif_skcipher af_alg uas
usb_storage dm_c>
Jan 01 02:04:20 computername kernel: CPU: 2 PID: 2236 Comm:
MainLoopThread Tainted: G        W         4.19.13-dirty #2
Jan 01 02:04:20 computername kernel: Hardware name: To Be Filled By
O.E.M. To Be Filled By O.E.M./H97M-ITX/ac, BIOS P1.80 07/27/2015
Jan 01 02:04:20 computername kernel: RIP:
0010:__alloc_pages_nodemask+0xf52/0xfb0
Jan 01 02:04:20 computername kernel: Code: c7 44 24 54 00 00 00 00 25
ff ff f7 ff 89 44 24 18 e9 ea f3 ff ff 48 89 9c 24 80 00 00 00 e9 ad
f3 ff ff 0f 0b e9 dc fc ff ff <0f> 0b 48 8b b4 24 80 00 00 00 8b 7c 24
18 44 89 f1 48 c7 c2 40 9e
Jan 01 02:04:20 computername kernel: RSP: 0018:ffffaf9f81066e90 EFLAGS: 00010046
Jan 01 02:04:20 computername kernel: RAX: 0000000000000000 RBX:
0000000000400000 RCX: 0000000000000000
Jan 01 02:04:20 computername kernel: RDX: 0000000000000000 RSI:
0000000000000002 RDI: ffff9d26dfdfc000
Jan 01 02:04:20 computername kernel: RBP: 0000000000000000 R08:
0000000000000040 R09: 0000000000000f82
Jan 01 02:04:20 computername kernel: R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
Jan 01 02:04:20 computername kernel: R13: 0000000000000000 R14:
0000000000000000 R15: 0000000000000000
Jan 01 02:04:20 computername kernel: FS:  00007f7db94d5700(0000)
GS:ffff9d26d8100000(0000) knlGS:0000000000000000
Jan 01 02:04:20 computername kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 01 02:04:20 computername kernel: CR2: 0000000092c9da10 CR3:
00000001baefe002 CR4: 00000000001626e0
Jan 01 02:04:20 computername kernel: Call Trace:
Jan 01 02:04:20 computername kernel:  ?
__dm_make_request.isra.18+0x3f/0xa0 [dm_mod]
Jan 01 02:04:20 computername kernel:  ? orc_find+0x108/0x190
Jan 01 02:04:20 computername kernel:  ? do_try_to_free_pages+0xc6/0x370
Jan 01 02:04:20 computername kernel:  new_slab+0x2fb/0x6f0
Jan 01 02:04:20 computername kernel:  ? _raw_spin_lock+0x13/0x40
Jan 01 02:04:20 computername kernel:  ? deactivate_slab.isra.27+0x5b4/0x690
Jan 01 02:04:20 computername kernel:  ___slab_alloc+0x43f/0x630
Jan 01 02:04:20 computername kernel:  ? create_object+0x43/0x2a0
Jan 01 02:04:20 computername kernel:  ? ___slab_alloc+0x58d/0x630
Jan 01 02:04:20 computername kernel:  ? create_object+0x43/0x2a0
Jan 01 02:04:20 computername kernel:  __slab_alloc.isra.28+0x52/0x70
Jan 01 02:04:20 computername kernel:  ? create_object+0x43/0x2a0
Jan 01 02:04:20 computername kernel:  kmem_cache_alloc+0x1c5/0x210
Jan 01 02:04:20 computername kernel:  ? mempool_alloc+0x65/0x180
Jan 01 02:04:20 computername kernel:  create_object+0x43/0x2a0
Jan 01 02:04:20 computername kernel:  ? mempool_alloc+0x65/0x180
Jan 01 02:04:20 computername kernel:  kmem_cache_alloc+0x1a6/0x210
Jan 01 02:04:20 computername kernel:  ? wait_woken+0x80/0x80
Jan 01 02:04:20 computername kernel:  mempool_alloc+0x65/0x180
Jan 01 02:04:20 computername kernel:  ? __process_bio+0x170/0x170 [dm_mod]
Jan 01 02:04:20 computername kernel:  bio_alloc_bioset+0x14c/0x220
Jan 01 02:04:20 computername kernel:  ? create_object+0x249/0x2a0
Jan 01 02:04:20 computername kernel:  ? __process_bio+0x170/0x170 [dm_mod]
Jan 01 02:04:20 computername kernel:  alloc_io+0x24/0x120 [dm_mod]
Jan 01 02:04:20 computername kernel:
__split_and_process_bio+0x53/0x1a0 [dm_mod]
Jan 01 02:04:20 computername kernel:  ? generic_make_request_checks+0x49a/0x6f0
Jan 01 02:04:20 computername kernel:  ? blk_queue_enter+0x233/0x260
Jan 01 02:04:20 computername kernel:
__dm_make_request.isra.18+0x3f/0xa0 [dm_mod]
Jan 01 02:04:20 computername kernel:  generic_make_request+0x1b9/0x3d0
Jan 01 02:04:20 computername kernel:  ? __se_sys_madvise.cold.2+0xbd/0xbd
Jan 01 02:04:20 computername kernel:  submit_bio+0x45/0x140
Jan 01 02:04:20 computername kernel:  __swap_writepage+0x133/0x3c0
Jan 01 02:04:20 computername kernel:  ? __frontswap_store+0x6e/0xf0
Jan 01 02:04:20 computername kernel:  shmem_writepage+0x229/0x310
Jan 01 02:04:20 computername kernel:  pageout.isra.11+0x117/0x350
Jan 01 02:04:20 computername kernel:  shrink_page_list+0x7ea/0xc80
Jan 01 02:04:20 computername kernel:  shrink_inactive_list+0x29f/0x6b0
Jan 01 02:04:20 computername kernel:  shrink_node_memcg+0x20f/0x780
Jan 01 02:04:20 computername kernel:  shrink_node+0xcf/0x4a0
Jan 01 02:04:20 computername kernel:  do_try_to_free_pages+0xc6/0x370
Jan 01 02:04:20 computername kernel:  try_to_free_pages+0xca/0x1e0
Jan 01 02:04:20 computername kernel:  __alloc_pages_nodemask+0x616/0xfb0
Jan 01 02:04:20 computername kernel:  ? reweight_entity+0x15b/0x1a0
Jan 01 02:04:20 computername kernel:  ? check_preempt_wakeup+0x113/0x230
Jan 01 02:04:20 computername kernel:  __get_free_pages+0xd/0x30
Jan 01 02:04:20 computername kernel:  __pollwait+0x8a/0xd0
Jan 01 02:04:20 computername kernel:  tcp_poll+0x3a/0x260
Jan 01 02:04:20 computername kernel:  sock_poll+0x83/0xb0
Jan 01 02:04:20 computername kernel:  do_sys_poll+0x252/0x520
Jan 01 02:04:20 computername kernel:  ? ioapic_service+0x117/0x140 [kvm]
Jan 01 02:04:20 computername kernel:  ? poll_initwait+0x40/0x40
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  ?
compat_poll_select_copy_remaining+0x150/0x150
Jan 01 02:04:20 computername kernel:  __se_sys_ppoll+0x154/0x180
Jan 01 02:04:20 computername kernel:  ? ksys_ioctl+0x71/0x90
Jan 01 02:04:20 computername kernel:  do_syscall_64+0x5b/0x170
Jan 01 02:04:20 computername kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Jan 01 02:04:20 computername kernel: RIP: 0033:0x7f7dc5d22d16
Jan 01 02:04:20 computername kernel: Code: 7c 24 08 e8 6c 84 01 00 41
b8 08 00 00 00 4c 8b 54 24 18 48 89 da 41 89 c1 48 8b 74 24 10 48 8b
7c 24 08 b8 0f 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 25 44 89 cf 89 44
24 08 e8 96 84 01 00 8b 44
Jan 01 02:04:20 computername kernel: RSP: 002b:00007f7db94d4540
EFLAGS: 00000293 ORIG_RAX: 000000000000010f
Jan 01 02:04:20 computername kernel: RAX: ffffffffffffffda RBX:
00007f7db94d4560 RCX: 00007f7dc5d22d16
Jan 01 02:04:20 computername kernel: RDX: 00007f7db94d4560 RSI:
000000000000001d RDI: 00007f7da80ae750
Jan 01 02:04:20 computername kernel: RBP: 0000000000000000 R08:
0000000000000008 R09: 0000000000000000
Jan 01 02:04:20 computername kernel: R10: 0000000000000000 R11:
0000000000000293 R12: 00007f7db94d45bc
Jan 01 02:04:20 computername kernel: R13: 00000000023c31c8 R14:
00007f7da80a92a0 R15: 00000000009826c9
Jan 01 02:04:20 computername kernel: ---[ end trace 8ed9f92f3ae55658 ]---
Jan 01 02:04:20 computername kernel: kmemleak: Cannot allocate a
kmemleak_object structure
Jan 01 02:04:20 computername kernel: kmemleak: Kernel memory leak
detector disabled
Jan 01 02:04:20 computername kernel: kmemleak: Automatic memory
scanning thread ended
Jan 01 02:04:20 computername kernel: kmemleak: Kmemleak disabled
without freeing internal data. Reclaim the memory with "echo clear >
/sys/kernel/debug/kmemleak".
Jan 01 02:04:20 computername kernel: xhci_hcd 0000:00:14.0: ERROR
unknown event type 37
*****

Reference Mail: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event
type 37 - Kernel 4.19.13

I had a leak somewhere and I was directed to look into SUnreclaim
which was 5.5 GB after an uptime of a little over 1 month on an 8 GB
system. kmalloc-2048 was a problem.
I just had enough and needed to find out the cause for my lagging system.

I finally upgraded from 4.18.16 to 4.19.13 and enabled kmemleak to
hunt for the culprit. I don't think a day had elapsed before kmemleak
crashed and disabled itself.

I'm thinking my USB TV tuner or Intel USB controller may have been too
much for kmemleak given it occured in the middle of one of the
"unknown event type 37" log spams.
