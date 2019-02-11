Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE74C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748F6214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfBKVKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:10:13 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:48337 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfBKVKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:10:13 -0500
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Meelis Roos <mroos@linux.ee>
Subject: Undefined behaviour in drivers/gpu/drm/radeon/r200.c:480:34 - shift
 exponent 4096 is too large
Message-ID: <c49920e2-adf8-515c-89ae-9f6ffe7752f7@linux.ee>
Date:   Mon, 11 Feb 2019 23:10:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got UBSAN warning from Dell D600 running 5.0.0-rc4-00218-g12491ed354d2.
The warning did not happen on bootup but during xfce session start or console switch.

[   15.323113] radeon 0000:01:00.0: putting AGP V2 device into 4x mode
[   15.323134] radeon 0000:01:00.0: GTT: 128M 0xE0000000 - 0xE7FFFFFF
[   15.323142] radeon 0000:01:00.0: VRAM: 128M 0x00000000E8000000 - 0x00000000EFFFFFFF (32M used)
[   15.323459] [drm] Detected VRAM RAM=128M, BAR=128M
[   15.323463] [drm] RAM width 64bits DDR
[   15.323566] [TTM] Zone  kernel: Available graphics memory: 412446 kiB
[   15.323567] [TTM] Initializing pool allocator
[   15.323580] [TTM] Initializing DMA pool allocator
[   15.323609] [drm] radeon: 32M of VRAM memory ready
[   15.323611] [drm] radeon: 128M of GTT memory ready.
[   15.323621] [drm] radeon: power management initialized
[   15.331289] radeon 0000:01:00.0: WB disabled
[   15.331296] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x00000000e0000000 and cpu addr 0x712386dd
[   15.331299] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   15.331300] [drm] Driver supports precise vblank timestamp query.
[   15.331315] [drm] radeon: irq initialized.
[   15.331317] [drm] Loading R200 Microcode
[...]
[   15.795041] [drm] radeon: ring at 0x00000000E0001000
[   15.795073] [drm] ring test succeeded in 1 usecs
[   15.795316] [drm] ib test succeeded in 0 usecs
[   15.801857] [drm] Panel ID String: 2K077141X13
[   15.801861] [drm] Panel Size 1024x768
[   15.801938] [drm] No TV DAC info found in BIOS
[   15.802012] [drm] Radeon Display Connectors
[   15.802015] [drm] Connector 0:
[   15.802017] [drm]   VGA-1
[   15.802023] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[   15.802024] [drm]   Encoders:
[   15.802027] [drm]     CRT1: INTERNAL_DAC1
[   15.802030] [drm] Connector 1:
[   15.802031] [drm]   DVI-D-1
[   15.802033] [drm]   HPD1
[   15.802038] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[   15.802040] [drm]   Encoders:
[   15.802042] [drm]     DFP1: INTERNAL_TMDS1
[   15.802044] [drm] Connector 2:
[   15.802046] [drm]   LVDS-1
[   15.802047] [drm]   Encoders:
[   15.802049] [drm]     LCD1: INTERNAL_LVDS
[   15.802051] [drm] Connector 3:
[   15.802053] [drm]   SVIDEO-1
[   15.802054] [drm]   Encoders:
[   15.802056] [drm]     TV1: INTERNAL_DAC2
[   15.845987] [drm] fb mappable at 0xE8040000
[   15.845988] [drm] vram apper at 0xE8000000
[   15.845989] [drm] size 1572864
[   15.845990] [drm] fb depth is 16
[   15.845990] [drm]    pitch is 2048
[   15.848183] fbcon: radeondrmfb (fb0) is primary device
[   15.892233] Console: switching to colour frame buffer device 128x48
[   15.901408] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[   15.905786] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[...]
[  447.146334] ================================================================================
[  447.146347] UBSAN: Undefined behaviour in drivers/gpu/drm/radeon/r200.c:480:34
[  447.146351] shift exponent 4096 is too large for 32-bit type 'int'
[  447.146357] CPU: 0 PID: 386 Comm: Xorg Not tainted 5.0.0-rc4-00218-g12491ed354d2 #7
[  447.146358] Hardware name: Dell Computer Corporation Latitude D600                   /0X2034, BIOS A16 06/29/2005
[  447.146359] Call Trace:
[  447.146375]  dump_stack+0x16/0x19
[  447.146379]  ubsan_epilogue+0xb/0x29
[  447.146381]  __ubsan_handle_shift_out_of_bounds.cold.14+0x26/0x80
[  447.146486]  ? radeon_cs_packet_next_reloc+0x3c/0x150 [radeon]
[  447.146521]  ? r100_reloc_pitch_offset+0x27/0x150 [radeon]
[  447.146551]  r200_packet0_check.cold.0+0xf/0x45 [radeon]
[  447.146592]  ? r200_copy_dma+0x430/0x430 [radeon]
[  447.146626]  r100_cs_parse_packet0+0x53/0xe0 [radeon]
[  447.146661]  r100_cs_parse+0x12e/0x440 [radeon]
[  447.146700]  ? r200_copy_dma+0x430/0x430 [radeon]
[  447.146734]  radeon_cs_ioctl+0x256/0x890 [radeon]
[  447.146743]  ? ttm_bo_init_reserved+0x338/0x390 [ttm]
[  447.146779]  ? radeon_cs_parser_init+0x550/0x550 [radeon]
[  447.146804]  drm_ioctl_kernel+0x96/0xe0 [drm]
[  447.146816]  drm_ioctl+0x25f/0x530 [drm]
[  447.146850]  ? radeon_cs_parser_init+0x550/0x550 [radeon]
[  447.146855]  ? ktime_get_mono_fast_ns+0xb6/0x1f0
[  447.146880]  radeon_drm_ioctl+0x40/0x80 [radeon]
[  447.146905]  ? radeon_pci_shutdown+0x30/0x30 [radeon]
[  447.146909]  do_vfs_ioctl+0x90/0x6c0
[  447.146913]  ? handle_mm_fault+0xa48/0xfe0
[  447.146918]  ? vm_mmap_pgoff+0x88/0xd0
[  447.146923]  ? ktime_get_ts64+0x5f/0x1e0
[  447.146925]  ksys_ioctl+0x39/0x70
[  447.146927]  sys_ioctl+0x11/0x13
[  447.146930]  do_fast_syscall_32+0x95/0x1d0
[  447.146934]  entry_SYSENTER_32+0x6b/0xbd
[  447.146936] EIP: 0xb7f937cd
[  447.146939] Code: 54 cd ff ff 85 d2 8b 98 58 cd ff ff 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[  447.146941] EAX: ffffffda EBX: 0000000e ECX: c0206466 EDX: 02311c40
[  447.146943] ESI: 02311a00 EDI: c0206466 EBP: 0000000e ESP: bff73058
[  447.146945] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00203292
[  447.146947] ================================================================================
