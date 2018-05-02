Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbeEBGM0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 02:12:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:22929 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeEBGMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 02:12:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="51648505"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Larry Finger <Larry.Finger@lwfinger.net>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Warning for driver i915 for 4.17.0-rcX
In-Reply-To: <a16d75eb-56ad-6b10-502b-b9f5174b6e21@lwfinger.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <a16d75eb-56ad-6b10-502b-b9f5174b6e21@lwfinger.net>
Date: Wed, 02 May 2018 09:12:21 +0300
Message-ID: <87o9hyd1ru.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> With kernel 4.17.0-rc3, I noted the following warning from driver i915.
>
> kernel: ------------[ cut here ]------------
> kernel: Could not determine valid watermarks for inherited state
> kernel: WARNING: CPU: 3 PID: 224 at drivers/gpu/drm/i915/intel_display.c:14584 
> intel_modeset_init+0x3be/0x1060 [i915]

Please try [1], see also the related bug [2].

BR,
Jani.

[1] http://patchwork.freedesktop.org/patch/msgid/20180426163015.14232-1-ville.syrjala@linux.intel.com
[2] https://bugs.freedesktop.org/show_bug.cgi?id=105992


> kernel: Modules linked in: i915(+) xhci_pci i2c_algo_bit ehci_pci xhci_hcd 
> serio_raw drm_kms_helper ehci_hcd syscopyarea sysfillrect sysimgblt
> kernel: CPU: 3 PID: 224 Comm: systemd-udevd Not tainted 
> 4.17.0-rc0-08000-g2f39cfca0161-dirty #188
> kernel: Hardware name: TOSHIBA TECRA A50-A/TECRA A50-A, BIOS Version 4.50 
> 09/29/2014
> kernel: RIP: 0010:intel_modeset_init+0x3be/0x1060 [i915]
> kernel: RSP: 0018:ffffc9000112fab8 EFLAGS: 00010296
> kernel: RAX: 0000000000000038 RBX: ffff88021dc10000 RCX: 0000000000000006
> kernel: RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff88022f2d5bd0
> kernel: RBP: ffff88021c8b3000 R08: 0000000000000289 R09: 0000000000000004
> kernel: R10: ffffc9000112f948 R11: 0000000000000001 R12: ffff88021ef3d800
> kernel: R13: 00000000ffffffea R14: 0000000000000000 R15: ffff88021dc10358
> kernel: FS:  00007f830913c940(0000) GS:ffff88022f2c0000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00007ffc91722f58 CR3: 000000021e940003 CR4: 00000000001606e0
> kernel: Call Trace:
> kernel:  i915_driver_load+0xa87/0xed0 [i915]
> kernel:  local_pci_probe+0x42/0xa0
> kernel:  pci_device_probe+0x125/0x190
> kernel:  driver_probe_device+0x30b/0x480
> kernel:  __driver_attach+0xb8/0xe0
> kernel:  ? driver_probe_device+0x40/0x480
> kernel:  ? driver_probe_device+0x480/0x480
> kernel:  bus_for_each_dev+0x65/0x90
> kernel:  bus_add_driver+0x161/0x260
> kernel:  ? 0xffffffffa0149000
> kernel:  driver_register+0x57/0xc0
> kernel:  ? 0xffffffffa0149000
> kernel:  do_one_initcall+0x4e/0x18d
> kernel:  ? kmem_cache_alloc_trace+0xfe/0x210
> kernel:  ? do_init_module+0x22/0x20a
> kernel:  do_init_module+0x5b/0x20a
> kernel:  load_module+0x18a1/0x1e20
> kernel:  ? SYSC_finit_module+0xb7/0xd0
> kernel:  SYSC_finit_module+0xb7/0xd0
> kernel:  do_syscall_64+0x6e/0x120
> kernel:  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> kernel: RIP: 0033:0x7f8307f67529
> kernel: RSP: 002b:00007ffc91737ab8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> kernel: RAX: ffffffffffffffda RBX: 0000559b3cf6f350 RCX: 00007f8307f67529
> kernel: RDX: 0000000000000000 RSI: 00007f83088cd83d RDI: 0000000000000014
> kernel: RBP: 00007f83088cd83d R08: 0000000000000000 R09: 0000559b3cf44f50
> kernel: R10: 0000000000000014 R11: 0000000000000246 R12: 0000000000020000
> kernel: R13: 0000559b3cf634a0 R14: 0000000000000000 R15: 0000000003938700
> kernel: Code: 00 f7 c6 00 00 18 00 0f 84 d7 0a 00 00 85 c9 0f 94 c1 41 88 8c 24 
> 8d 02 00 00 e9 f6 08 00 00 48 c7 c7 b0 2f 41 a0 e8 f2 9b cd e0
> kernel: ---[ end trace c0feea6402f4c999 ]---
>
> This warning was bisected to
>
> commit a2936e3d9a9cb2ce192455cdec3a8cfccc26b486 (refs/bisect/bad)
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Date:   Thu Nov 23 21:04:49 2017 +0200
>
>      drm/i915: Use drm_mode_get_hv_timing() to populate plane clip rectangle
>
>      Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>      Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
>      Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>      Reviewed-by: Thierry Reding <treding@nvidia.com>
>
> The output of 'lspci -nn -vvv' for the gracpics device is as follows:
>
> 00:02.0 VGA compatible controller [0300]: Intel Corporation 4th Gen Core 
> Processor Integrated Graphics Controller [8086:0416] (rev 06) (prog-if 00 [VGA 
> controller])
>          Subsystem: Toshiba America Info Systems Device [1179:0002]
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B- DisINTx+
>          Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR- INTx-
>          Latency: 0
>          Interrupt: pin A routed to IRQ 28
>          Region 0: Memory at e0000000 (64-bit, non-prefetchable) [size=4M]
>          Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
>          Region 4: I/O ports at 4000 [size=64]
>          [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
>          Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
>                  Address: fee00018  Data: 0000
>          Capabilities: [d0] Power Management version 2
>                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>          Capabilities: [a4] PCI Advanced Features
>                  AFCap: TP+ FLR+
>                  AFCtrl: FLR-
>                  AFStatus: TP-
>          Kernel driver in use: i915
>          Kernel modules: i915
>
> This warning does not seem to cause any problems.
>
> Thanks,
>
> Larry

-- 
Jani Nikula, Intel Open Source Technology Center
