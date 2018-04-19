Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeDSGmU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:42:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:46153 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbeDSGmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:42:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="221614938"
Subject: Re: [i915] WARNING: CPU: 2 PID: 183 at
 drivers/gpu/drm/i915/intel_display.c:14584 intel_modeset_init+0x3be/0x1060
To: Fengguang Wu <fengguang.wu@intel.com>, intel-gfx@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Imre Deak <imre.deak@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Ben Widawsky <ben@bwidawsk.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkp@01.org
References: <20180419025256.vtt37aljreb2wzrj@wfg-t540p.sh.intel.com>
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <0427eb0b-0382-db2c-72c5-0cbc867d4370@linux.intel.com>
Date: Thu, 19 Apr 2018 08:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419025256.vtt37aljreb2wzrj@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Op 19-04-18 om 04:52 schreef Fengguang Wu:
> Hello,
>
> FYI this happens in mainline kernel and at least dates back to v4.13 .
>
> [   75.245840]
> [   75.247783] /opt/deb/gawk_1%3a4.1.4+dfsg-1_amd64.deb
> [   75.247785]
> [   75.248145] ------------[ cut here ]------------
> [   75.248446] Could not determine valid watermarks for inherited state
> [   75.248889] WARNING: CPU: 2 PID: 183 at drivers/gpu/drm/i915/intel_display.c:14584 intel_modeset_init+0x3be/0x1060 [i915]
> [   75.249372] /opt/deb/sysstat_11.6.0-1_amd64.deb
> [   75.249617] Modules linked in:
> [   75.249619]
> [   75.249883]  crc32c_intel(+) ghash_clmulni_intel pcbc wmi_bmof ahci libahci snd_hda_intel i915(+) uvcvideo videobuf2_vmalloc aesni_intel crypto_simd cryptd videobuf2_memops glue_helper snd_hda_codec videobuf2_v4l2 pcspkr videobuf2_common serio_raw drm_kms_helper snd_hda_core snd_hwdep libata snd_pcm syscopyarea sysfillrect sysimgblt fb_sys_fops bcma snd_timer snd soundcore drm videodev shpchp ideapad_laptop wmi sparse_keymap rfkill video ip_tables
> [   75.252346] CPU: 2 PID: 183 Comm: systemd-udevd Not tainted 4.17.0-rc1 #1
> [   75.252718] Hardware name: LENOVO IdeaPad U410    /Lenovo          , BIOS 65CN15WW 06/05/2012
> [   75.253140] (Reading database ... 2202 files and directories currently installed.)
> [   75.253229] RIP: 0010:intel_modeset_init+0x3be/0x1060 [i915]
> [   75.253230]
> [   75.254044] RSP: 0018:ffffc900009f7af0 EFLAGS: 00010282
> [   75.254339] RAX: 0000000000000038 RBX: ffff88011bfc0000 RCX: 0000000000000006
> [   75.254731] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff88011f296910
> [   75.255121] RBP: ffff88011933e400 R08: 0000000000000363 R09: 000000000000000a
> [   75.255512] R10: ffffc900009f7988 R11: ffffffff82d4e10d R12: ffff88011933fc00
> [   75.255898] R13: 00000000ffffffea R14: 0000000000000000 R15: ffff88011bfc0358
> [   75.256290] FS:  00007f0b39a7d8c0(0000) GS:ffff88011f280000(0000) knlGS:0000000000000000
> [   75.256731] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   75.257050] CR2: 00007f599dcec750 CR3: 000000011bdcc004 CR4: 00000000001606e0
> [   75.257111] Preparing to unpack .../opt/deb/debconf_1.5.66_all.deb ...
> [   75.257449] Call Trace:
> [   75.257450]
> [   75.258115]  i915_driver_load+0xa99/0xee0 [i915]
> [   75.258388]  ? acpi_dev_found+0x5f/0x70:
> 						acpi_dev_found at drivers/acpi/utils.c:737
> [   75.258616]  local_pci_probe+0x42/0xa0:
> 						local_pci_probe at drivers/pci/pci-driver.c:304
> [   75.258835]  ? _cond_resched+0x19/0x30:
> 						_cond_resched at kernel/sched/core.c:4982
> [   75.259055]  pci_device_probe+0x11d/0x180:
> 						pci_call_probe at drivers/pci/pci-driver.c:358
> 						 (inlined by) __pci_device_probe at drivers/pci/pci-driver.c:383
> 						 (inlined by) pci_device_probe at drivers/pci/pci-driver.c:423
> [   75.259287]  driver_probe_device+0x30b/0x480:
> 						really_probe at drivers/base/dd.c:449
> 						 (inlined by) driver_probe_device at drivers/base/dd.c:590
> [   75.259531]  __driver_attach+0xb8/0xe0:
> 						__driver_attach at drivers/base/dd.c:824
> [   75.259661] Unpacking debconf (1.5.66) over (1.5.59) ...
> [   75.259748]  ? driver_probe_device+0x480/0x480:
> 						__driver_attach at drivers/base/dd.c:794
> [   75.259749]
> [   75.260394]  bus_for_each_dev+0x65/0x90:
> 						bus_for_each_dev at drivers/base/bus.c:310
> [   75.260624]  bus_add_driver+0x161/0x260:
> 						bus_add_driver at drivers/base/bus.c:668
> [   75.260849]  ? 0xffffffffa0553000
> [   75.261042]  driver_register+0x57/0xc0:
> 						driver_register at drivers/base/driver.c:167
> [   75.261259]  ? 0xffffffffa0553000
> [   75.261451]  do_one_initcall+0x36/0x1bb:
> 						do_one_initcall at init/main.c:883
> [   75.261676]  ? _cond_resched+0x19/0x30:
> 						_cond_resched at kernel/sched/core.c:4982
> [   75.261898]  ? kmem_cache_alloc_trace+0x3e/0x1e0:
> 						slab_pre_alloc_hook at mm/slab.h:423
> 						 (inlined by) slab_alloc_node at mm/slub.c:2667
> 						 (inlined by) slab_alloc at mm/slub.c:2749
> 						 (inlined by) kmem_cache_alloc_trace at mm/slub.c:2766
> [   75.262166]  do_init_module+0x5b/0x1f8:
> 						do_init_module at kernel/module.c:3459
> [   75.262379]  load_module+0x1465/0x1b50:
> 						load_module at kernel/module.c:3782
> [   75.262598]  ? kernel_read_file+0x165/0x180:
> 						kernel_read_file at fs/exec.c:946
> [   75.262838]  ? __do_sys_finit_module+0xb7/0xd0:
> 						__do_sys_finit_module at kernel/module.c:3876
> [   75.263093]  __do_sys_finit_module+0xb7/0xd0:
> 						__do_sys_finit_module at kernel/module.c:3876
> [   75.263338]  do_syscall_64+0x5b/0x180:
> 						do_syscall_64 at arch/x86/entry/common.c:287
> [   75.263554]  entry_SYSCALL_64_after_hwframe+0x44/0xa9:
> 						entry_SYSCALL_64_after_hwframe at arch/x86/entry/entry_64.S:247
> [   75.263843] RIP: 0033:0x7f0b388f8d49
> [   75.264046] RSP: 002b:00007ffe26652b48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> [   75.264473] RAX: ffffffffffffffda RBX: 000055c9b781efa0 RCX: 00007f0b388f8d49
> [   75.264871] RDX: 0000000000000000 RSI: 00007f0b392142d5 RDI: 0000000000000014
> [   75.265268] RBP: 00007f0b392142d5 R08: 0000000000000000 R09: 00007ffe266530c0
> [   75.265672] R10: 0000000000000014 R11: 0000000000000246 R12: 0000000000000000
> [   75.266074] R13: 000055c9b7833400 R14: 0000000000020000 R15: 000055c9b64d95b3
> [   75.266469] Code: 00 f7 c6 00 00 18 00 0f 84 d7 0a 00 00 85 c9 0f 94 c1 41 88 8c 24 8d 02 00 00 e9 f6 08 00 00 48 c7 c7 60 c5 4b a0 e8 b2 54 c4 e0 <0f> 0b f0 41 ff 0c 24 0f 88 7d 8e 04 00 75 08 4c 89 e7 e8 8b 89
> [   75.266657] Preparing to unpack .../libtext-charwidth-perl_0.04-7.1_amd64.deb ...
> [   75.267544] ---[ end trace 9612bbbc31991c71 ]---
> [   75.268238]
>
> Attached the full dmesg, kconfig and reproduce scripts.
What extra dmesg output do you get when you boot with drm.debug=0x1f ?

~Maarten
