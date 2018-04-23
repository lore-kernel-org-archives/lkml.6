Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932108AbeDWQC4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:02:56 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:54422 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeDWQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:02:54 -0400
Date: Mon, 23 Apr 2018 11:27:13 -0400
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Subject: 4.17-rc2: Could not determine valid watermarks for inherited state
Message-ID: <20180423152713.2rrwwye3wfstbv5v@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Note: SpamAssassin invocation failed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning just started appearing during boot on a machine I upgraded
to 4.17-rc2.  The warning seems to have been there since 2015, but it
has never triggered before today.

	Dave

[    1.158500] fb: switching to inteldrmfb from EFI VGA
[    1.159073] Console: switching to colour dummy device 80x25
[    1.159523] checking generic (a0000 10000) vs hw (e0000000 10000000)
[    1.159539] fb: switching to inteldrmfb from VGA16 VGA
[    1.159752] [drm] Replacing VGA console driver
[    1.164454] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.164472] [drm] Driver supports precise vblank timestamp query.
[    1.167285] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    1.170212] ------------[ cut here ]------------
[    1.170230] Could not determine valid watermarks for inherited state
[    1.170267] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/i915/intel_display.c:14584 sanitize_watermarks+0x17b/0x1c0
[    1.170291] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc2+ #1
[    1.170308] Hardware name: Shuttle Inc. SH87R/FH87, BIOS 2.03 06/19/2014
[    1.170325] RIP: 0010:sanitize_watermarks+0x17b/0x1c0
[    1.170338] RSP: 0000:ffffa944c0023bf0 EFLAGS: 00010246
[    1.170352] RAX: 0000000000000000 RBX: ffff9193508c0000 RCX: 0000000000000000
[    1.170369] RDX: 0000000000000001 RSI: ffffffff990b7399 RDI: ffffffff990b7399
[    1.170385] RBP: ffff9193508c0000 R08: 0000000000000001 R09: 0000000000000001
[    1.170401] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffea
[    1.170418] R13: ffff9193508faa88 R14: ffff919350823528 R15: ffff9193508c0a08
[    1.170434] FS:  0000000000000000(0000) GS:ffff919356400000(0000) knlGS:0000000000000000
[    1.170453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.170466] CR2: 0000000000000000 CR3: 000000011d224001 CR4: 00000000000606e0
[    1.170483] Call Trace:
[    1.170493]  intel_modeset_init+0x769/0x18f0
[    1.170506]  i915_driver_load+0x9b9/0xf30
[    1.170519]  ? _raw_spin_unlock_irqrestore+0x3f/0x70
[    1.170534]  pci_device_probe+0xa3/0x120
[    1.170546]  driver_probe_device+0x28a/0x320
[    1.170557]  __driver_attach+0x9e/0xb0
[    1.170568]  ? driver_probe_device+0x320/0x320
[    1.170581]  bus_for_each_dev+0x68/0xc0
[    1.170592]  bus_add_driver+0x11d/0x210
[    1.170604]  ? mipi_dsi_bus_init+0x11/0x11
[    1.170615]  driver_register+0x5b/0xd0
[    1.170627]  do_one_initcall+0x10b/0x33f
[    1.170638]  ? do_early_param+0x8b/0x8b
[    1.170651]  ? rcu_read_lock_sched_held+0x66/0x70
[    1.170663]  ? do_early_param+0x8b/0x8b
[    1.170674]  kernel_init_freeable+0x1c3/0x249
[    1.170687]  ? rest_init+0xc0/0xc0
[    1.170697]  kernel_init+0xa/0x100
[    1.170707]  ret_from_fork+0x24/0x30
[    1.170717] Code: 00 00 00 65 48 33 04 25 28 00 00 00 75 4f 48 8d a4 24 88 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 48 c7 c7 e0 5d 04 9a e8 25 33 b1 ff <0f> 0b eb a4 48 c7 c6 d5 73 04 9a 48 c7 c7 0f c6 fe 99 e8 0e 33 
[    1.170847] irq event stamp: 1449710
[    1.170858] hardirqs last  enabled at (1449709): [<ffffffff990b6f8b>] console_unlock+0x51b/0x6b0
[    1.170879] hardirqs last disabled at (1449710): [<ffffffff99a00ff6>] error_entry+0x86/0x100
[    1.170900] softirqs last  enabled at (1449580): [<ffffffff99c003dd>] __do_softirq+0x3dd/0x521
[    1.170922] softirqs last disabled at (1449563): [<ffffffff9905d327>] irq_exit+0xb7/0xc0


00:02.0 VGA compatible controller: Intel Corporation Xeon E3-1200 v3/4th Gen Core Processor Integrated Graphics Controller (rev 06)

(That's 8086:0402 fwiw)
