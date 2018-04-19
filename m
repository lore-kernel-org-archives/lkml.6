Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753242AbeDSFcy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:32:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:4758 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbeDSFcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:32:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="43024741"
Date: Thu, 19 Apr 2018 13:32:40 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        Liu Bo <bo.li.liu@oracle.com>, Jeff Mahoney <jeffm@suse.com>,
        Omar Sandoval <osandov@fb.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: [btrfs_put_block_group] WARNING: CPU: 1 PID: 14674 at
 fs/btrfs/disk-io.c:3675 free_fs_root+0xc2/0xd0 [btrfs]
Message-ID: <20180419053240.b65vnukgdkt37qmd@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tknyj4ydszzi42v5"
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tknyj4ydszzi42v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

FYI this happens in mainline kernel and at least dates back to v4.16 .

It's rather rare error and happens when running xfstests.

[  438.327552] BTRFS: error (device dm-0) in __btrfs_free_extent:6962: errno=-5 IO failure
[  438.336415] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:3070: errno=-5 IO failure
[  438.345590] BTRFS error (device dm-0): pending csums is 1028096
[  438.369254] BTRFS error (device dm-0): cleaner transaction attach returned -30
[  438.377674] BTRFS info (device dm-0): at unmount delalloc count 98304
[  438.385166] WARNING: CPU: 1 PID: 14674 at fs/btrfs/disk-io.c:3675 free_fs_root+0xc2/0xd0 [btrfs]
[  438.396562] Modules linked in: dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey dm_mod netconsole btrfs xor zstd_decompress zstd_compress xxhash raid6_pq sd_mod sg snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ata_generic pata_acpi intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp snd_hda_intel kvm_intel snd_hda_codec kvm irqbypass crct10dif_pclmul eeepc_wmi crc32_pclmul crc32c_intel ghash_clmulni_intel pata_via asus_wmi sparse_keymap snd_hda_core ata_piix snd_hwdep ppdev rfkill wmi_bmof i915 pcbc snd_pcm snd_timer drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops snd aesni_intel parport_pc crypto_simd pcspkr libata soundcore cryptd glue_helper drm wmi parport video shpchp ip_tables
[  438.467607] CPU: 1 PID: 14674 Comm: umount Not tainted 4.17.0-rc1 #1
[  438.474798] Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 1002 04/01/2011
[  438.484804] RIP: 0010:free_fs_root+0xc2/0xd0 [btrfs]
[  438.490590] RSP: 0018:ffffc90008b0fda8 EFLAGS: 00010282
[  438.496641] RAX: ffff88017c5954b0 RBX: ffff880137f6d800 RCX: 0000000180100003
[  438.504652] RDX: 0000000000000001 RSI: ffffea0006e93600 RDI: 0000000000000000
[  438.512679] RBP: ffff88017b360000 R08: ffff8801ba4dd000 R09: 0000000180100003
[  438.520644] R10: ffffc90008b0fc70 R11: 0000000000000000 R12: ffffc90008b0fdd0
[  438.528657] R13: ffff88017b360080 R14: ffffc90008b0fdc8 R15: 0000000000000000
[  438.536662] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfa80000(0000) knlGS:0000000000000000
[  438.545582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.552157] CR2: 00007f06c12b0260 CR3: 000000017d3de004 CR4: 00000000000606e0
[  438.642653] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c1359cf7
[  438.793559] CPU: 1 PID: 14674 Comm: umount Tainted: G        W         4.17.0-rc1 #1
[  438.802152] Hardware name: System manufacturer System Product Name/P8H67-M PRO, BIOS 1002 04/01/2011
[  438.812108] RIP: 0010:btrfs_put_block_group+0x41/0x60 [btrfs]
[  438.819364] RSP: 0018:ffffc90008b0fde0 EFLAGS: 00010206
[  438.825378] RAX: 0000000000000000 RBX: ffff8801abf63000 RCX: e38e38e38e38e38f
[  438.833307] RDX: 0000000000000001 RSI: 00000000000009f6 RDI: ffff8801abf63000
[  438.841230] RBP: ffff88017b360000 R08: ffff88017d3b7750 R09: 0000000180380010
[  438.849133] R10: ffffc90008b0fca0 R11: 0000000000000000 R12: ffff8801abf63000
[  438.857047] R13: ffff88017b3600a0 R14: ffff8801abf630e0 R15: dead000000000100
[  438.864943] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfa80000(0000) knlGS:0000000000000000
[  438.873793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.880320] CR2: 00007f06c12b0260 CR3: 000000017d3de004 CR4: 00000000000606e0
[  438.888226] Call Trace:
[  438.891454]  btrfs_free_block_groups+0x138/0x3d0 [btrfs]
[  438.897569]  close_ctree+0x13b/0x2f0 [btrfs]
[  438.902618]  generic_shutdown_super+0x6c/0x120:
						__read_once_size at include/linux/compiler.h:188
						 (inlined by) list_empty at include/linux/list.h:203
						 (inlined by) generic_shutdown_super at fs/super.c:442
[  438.907801]  kill_anon_super+0xe/0x20:
						kill_anon_super at fs/super.c:1038
[  438.912223]  btrfs_kill_super+0x13/0x100 [btrfs]
[  438.917598]  deactivate_locked_super+0x3f/0x70:
						deactivate_locked_super at fs/super.c:320
[  438.922757]  cleanup_mnt+0x3b/0x70:
						cleanup_mnt at fs/namespace.c:1174
[  438.926879]  task_work_run+0xa3/0xe0:
						task_work_run at kernel/task_work.c:115 (discriminator 1)
[  438.931205]  exit_to_usermode_loop+0x9e/0xa0:
						tracehook_notify_resume at include/linux/tracehook.h:191
						 (inlined by) exit_to_usermode_loop at arch/x86/entry/common.c:166
[  438.936226]  do_syscall_64+0x16c/0x180:
						prepare_exit_to_usermode at arch/x86/entry/common.c:196
						 (inlined by) syscall_return_slowpath at arch/x86/entry/common.c:265
						 (inlined by) do_syscall_64 at arch/x86/entry/common.c:290
[  438.940717]  entry_SYSCALL_64_after_hwframe+0x44/0xa9:
						entry_SYSCALL_64_after_hwframe at arch/x86/entry/entry_64.S:247
[  438.946507] RIP: 0033:0x7f06c1359cf7
[  438.950798] RSP: 002b:00007ffc6a59c608 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  438.959137] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c1359cf7
[  438.967056] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 000000000234a4b0
[  438.974937] RBP: 000000000234a4b0 R08: 0000000000000005 R09: 000000000234b510
[  438.982801] R10: 00000000000006f4 R11: 0000000000000246 R12: 00007f06c1865e44
[  438.990695] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc6a59c890
[  438.998600] Code: 2a 48 8b 83 e8 01 00 00 48 85 c0 75 2c 48 8b bb d8 00 00 00 e8 c1 1e b8 e0 48 89 df 5b e9 b8 1e b8 e0 0f 0b 48 83 7b 50 00 74 d6 <0f> 0b 48 8b 83 e8 01 00 00 48 85 c0 74 d4 0f 0b eb d0 0f 1f 00
[  439.019082] ---[ end trace 9263ab2c46fd437a ]---
[  439.030057] WARNING: CPU: 2 PID: 14674 at fs/btrfs/extent-tree.c:9898 btrfs_free_block_groups+0x2a2/0x3d0 [btrfs]

Attached the full dmesg, kconfig and reproduce scripts.

Thanks,
Fengguang

--tknyj4ydszzi42v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-snb-drag:20180417000154:x86_64-rhel-7.2:gcc-7:4.17.0-rc1-wt-ath-04728-g6bab68d:1"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Command line: ip=3D::::snb-drag::dhcp root=3D/dev/ram0 user=
=3Dlkp job=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-group5-deb=
ian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml ARCH=3D=
x86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-20180416=
14 commit=3D60cc43fc888428bb2f18f08997432d426a243338 BOOT_IMAGE=3D/pkg/linu=
x/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.=
17.0-rc1 max_uptime=3D7200 RESULT_ROOT=3D/result/xfstests/4HDD-btrfs-generi=
c-group5/snb-drag/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/60cc43=
fc888428bb2f18f08997432d426a243338/0 LKP_SERVER=3Dinn debug apic=3Ddebug sy=
srq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 pri=
ntk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=
=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.l=
og_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200 co=
nsole=3DttyS0,115200 vga=3Dnormal rw
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000020000000-0x00000000201fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000020200000-0x000000003fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000040000000-0x00000000401fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000040200000-0x00000000bac1dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bac1e000-0x00000000bac76fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bac77000-0x00000000bada9fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000badaa000-0x00000000badbafff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000badbb000-0x00000000badcefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000badcf000-0x00000000badd0fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000badd1000-0x00000000badd1fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000badd2000-0x00000000badd9fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000badda000-0x00000000bade3fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bade4000-0x00000000bae3dfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000bae3e000-0x00000000bae80fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000bae81000-0x00000000baffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb800000-0x00000000bf9fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001bfdfffff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] found SMP MP-table at [mem 0x000fcdd0-0x000fcddf] mapped at =
[        (ptrval)]
[    0.000000]   mpc: fcaa0-fcd54
[    0.000000] Base memory trampoline at [        (ptrval)] 97000 size 24576
[    0.000000] reserving inaccessible SNB gfx pages
[    0.000000] BRK [0x1bef4b000, 0x1bef4bfff] PGTABLE
[    0.000000] BRK [0x1bef4c000, 0x1bef4cfff] PGTABLE
[    0.000000] BRK [0x1bef4d000, 0x1bef4dfff] PGTABLE
[    0.000000] BRK [0x1bef4e000, 0x1bef4efff] PGTABLE
[    0.000000] BRK [0x1bef4f000, 0x1bef4ffff] PGTABLE
[    0.000000] BRK [0x1bef50000, 0x1bef50fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x1a6b7f000-0x1bcffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0420 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000BAC69068 00004C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000BAC72FA0 0000F4 (v04 ALASKA A M I    01=
072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000BAC69140 009E5F (v02 ALASKA A M I    00=
000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000BADDBF80 000040
[    0.000000] ACPI: APIC 0x00000000BAC73098 000072 (v03 ALASKA A M I    01=
072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000BAC73110 000102 (v01 AMICPU PROC     00=
000001 MSFT 03000001)
[    0.000000] ACPI: MCFG 0x00000000BAC73218 00003C (v01 ALASKA A M I    01=
072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000BAC73258 000038 (v01 ALASKA A M I    01=
072009 AMI. 00000004)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x00000001bfdfffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x1bfdd1000-0x1bfdfbfff]
[    0.000000] cma: Reserved 200 MiB at 0x000000019a000000
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001bfdfffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000001fffffff]
[    0.000000]   node   0: [mem 0x0000000020200000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000040200000-0x00000000bac1dfff]
[    0.000000]   node   0: [mem 0x00000000badcf000-0x00000000badd0fff]
[    0.000000]   node   0: [mem 0x00000000bae81000-0x00000000baffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001bfdfffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000001bfdff=
fff]
[    0.000000] On node 0 totalpages: 1550140
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 157 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11879 pages used for memmap
[    0.000000]   DMA32 zone: 760223 pages, LIFO batch:31
[    0.000000]   Normal zone: 12280 pages used for memmap
[    0.000000]   Normal zone: 785920 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 104 pages
[    0.000000] Reserving Intel graphics memory at [mem 0xbba00000-0xbf9ffff=
f]
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC =
INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC =
INT 09
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC =
INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC =
INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC =
INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 0, APIC =
INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC =
INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC =
INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC =
INT 08
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 0, APIC =
INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 0, APIC =
INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC =
INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC =
INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC =
INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC =
INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x20000000-0x201fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x40000000-0x401fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbac1e000-0xbac76fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbac77000-0xbada9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbadaa000-0xbadbafff]
[    0.000000] PM: Registered nosave memory: [mem 0xbadbb000-0xbadcefff]
[    0.000000] PM: Registered nosave memory: [mem 0xbadd1000-0xbadd1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbadd2000-0xbadd9fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbadda000-0xbade3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbade4000-0xbae3dfff]
[    0.000000] PM: Registered nosave memory: [mem 0xbae3e000-0xbae80fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb000000-0xbb7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbb800000-0xbf9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbfa00000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xbfa00000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr=
_node_ids:1
[    0.000000] percpu: Embedded 45 pages/cpu @        (ptrval) s147032 r819=
2 d29096 u524288
[    0.000000] pcpu-alloc: s147032 r8192 d29096 u524288 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3=20
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 15257=
60
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ip=3D::::snb-drag::dhcp root=3D/dev/ram=
0 user=3Dlkp job=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-grou=
p5-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml A=
RCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-20=
18041614 commit=3D60cc43fc888428bb2f18f08997432d426a243338 BOOT_IMAGE=3D/pk=
g/linux/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmli=
nuz-4.17.0-rc1 max_uptime=3D7200 RESULT_ROOT=3D/result/xfstests/4HDD-btrfs-=
generic-group5/snb-drag/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/=
60cc43fc888428bb2f18f08997432d426a243338/0 LKP_SERVER=3Dinn debug apic=3Dde=
bug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=
=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpan=
ic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 sy=
stemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,11=
5200 console=3DttyS0,115200 vga=3Dnormal rw
[    0.000000] sysrq: sysrq always enabled.
[    0.000000] Memory: 5432776K/6200560K available (12300K kernel code, 259=
2K rwdata, 4168K rodata, 2384K init, 2472K bss, 562984K reserved, 204800K c=
ma-reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 39726 entries in 156 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D4.
[    0.000000] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    0.000000] 	Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.000000] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
[    0.000000] 	Offload RCU callbacks from CPUs: (none).
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] bootconsole [earlyser0] disabled
[    0.000000] ACPI: Core revision 20180313
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.001000] APIC: Switch to symmetric I/O mode setup
[    0.002000] enabled ExtINT on CPU#0
[    0.003000] ENABLING IO-APIC IRQs
[    0.004000] init IO_APIC IRQs
[    0.005000]  apic 0 pin 0 not connected
[    0.006000] IOAPIC[0]: Set routing entry (0-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-5 -> 0xef -> IRQ 5 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-10 -> 0xef -> IRQ 10 Mode:0 =
Active:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-11 -> 0xef -> IRQ 11 Mode:0 =
Active:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    0.007000] IOAPIC[0]: Set routing entry (0-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    0.007000]  apic 0 pin 16 not connected
[    0.007000]  apic 0 pin 17 not connected
[    0.007000]  apic 0 pin 18 not connected
[    0.007000]  apic 0 pin 19 not connected
[    0.007000]  apic 0 pin 20 not connected
[    0.007000]  apic 0 pin 21 not connected
[    0.007000]  apic 0 pin 22 not connected
[    0.007000]  apic 0 pin 23 not connected
[    0.007000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.012000] tsc: Fast TSC calibration using PIT
[    0.013000] tsc: Detected 3311.052 MHz processor
[    0.014000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2fba14ed876, max_idle_ns: 440795351825 ns
[    0.015002] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6622.10 BogoMIPS (lpj=3D3311052)
[    0.016001] pid_max: default: 32768 minimum: 301
[    0.017013] Security Framework initialized
[    0.018001] SELinux:  Initializing.
[    0.019009] SELinux:  Starting in permissive mode
[    0.021748] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.022630] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.024005] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s)
[    0.025021] Mountpoint-cache hash table entries: 16384 (order: 5, 131072=
 bytes)
[    0.026158] CPU: Physical Processor ID: 0
[    0.027001] CPU: Processor Core ID: 0
[    0.028007] mce: CPU supports 9 MCE banks
[    0.029006] CPU0: Thermal monitoring enabled (TM1)
[    0.030006] process: using mwait in idle threads
[    0.031002] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.032000] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.033003] Spectre V2 : Mitigation: Full generic retpoline
[    0.034074] Freeing SMP alternatives memory: 40K
[    0.036187] TSC deadline timer enabled
[    0.037000] smpboot: CPU0: Intel(R) Core(TM) i5-2500K CPU @ 3.30GHz (fam=
ily: 0x6, model: 0x2a, stepping: 0x7)
[    0.037060] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep =
LBR, full-width counters, Intel PMU driver.
[    0.038003] ... version:                3
[    0.039001] ... bit width:              48
[    0.040000] ... generic registers:      8
[    0.041001] ... value mask:             0000ffffffffffff
[    0.042000] ... max period:             00007fffffffffff
[    0.043000] ... fixed-purpose events:   3
[    0.044000] ... event mask:             00000007000000ff
[    0.045031] Hierarchical SRCU implementation.
[    0.046761] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.047018] smp: Bringing up secondary CPUs ...
[    0.048061] x86: Booting SMP configuration:
[    0.049003] .... node  #0, CPUs:      #1
[    0.001000] masked ExtINT on CPU#1
[    0.057083]  #2
[    0.001000] masked ExtINT on CPU#2
[    0.063083]  #3
[    0.001000] masked ExtINT on CPU#3
[    0.069021] smp: Brought up 1 node, 4 CPUs
[    0.070002] smpboot: Max logical packages: 1
[    0.071001] smpboot: Total of 4 processors activated (26488.41 BogoMIPS)
[    0.073196] devtmpfs: initialized
[    0.074044] x86/mm: Memory block size: 128MB
[    0.075935] Built 1 zonelists, mobility grouping on.  Total pages: 14094=
04
[    0.076002] Policy zone: Normal
[    0.077098] evm: security.selinux
[    0.078001] evm: security.ima
[    0.079000] evm: security.capability
[    0.080128] PM: Registering ACPI NVS region [mem 0xbac1e000-0xbac76fff] =
(364544 bytes)
[    0.081007] PM: Registering ACPI NVS region [mem 0xbadaa000-0xbadbafff] =
(69632 bytes)
[    0.082002] PM: Registering ACPI NVS region [mem 0xbadda000-0xbade3fff] =
(40960 bytes)
[    0.083001] PM: Registering ACPI NVS region [mem 0xbae3e000-0xbae80fff] =
(274432 bytes)
[    0.084038] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    0.085006] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.086040] pinctrl core: initialized pinctrl subsystem
[    0.087079] NET: Registered protocol family 16
[    0.088171] audit: initializing netlink subsys (disabled)
[    0.089006] audit: type=3D2000 audit(1142250824.089:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.097002] cpuidle: using governor menu
[    0.101151] ACPI: bus type PCI registered
[    0.105002] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.112052] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000=
-0xe3ffffff] (base 0xe0000000)
[    0.121003] PCI: not using MMCONFIG
[    0.125001] PCI: Using configuration type 1 for base access
[    0.131027] core: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT=
 off
[    0.139095] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.140051] ACPI: Added _OSI(Module Device)
[    0.144002] ACPI: Added _OSI(Processor Device)
[    0.148001] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.154001] ACPI: Added _OSI(Processor Aggregator Device)
[    0.159001] ACPI: Added _OSI(Linux-Dell-Video)
[    0.168765] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.176827] ACPI: Dynamic OEM Table Load:
[    0.181004] ACPI: SSDT 0xFFFF880192D5D800 00038C (v01 AMI    IST      00=
000001 MSFT 03000001)
[    0.189216] ACPI: Dynamic OEM Table Load:
[    0.194003] ACPI: SSDT 0xFFFF880193354600 000084 (v01 AMI    CST      00=
000001 MSFT 03000001)
[    0.202780] ACPI: Interpreter enabled
[    0.207016] ACPI: (supports S0 S1 S3 S4 S5)
[    0.211001] ACPI: Using IOAPIC for interrupt routing
[    0.216027] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xe0000000=
-0xe3ffffff] (base 0xe0000000)
[    0.225071] PCI: MMCONFIG at [mem 0xe0000000-0xe3ffffff] reserved in ACP=
I motherboard resources
[    0.234004] pmd_set_huge: Cannot satisfy [mem 0xe0000000-0xe0200000] wit=
h a huge-page mapping due to MTRR override.
[    0.245056] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.254204] ACPI: Enabled 7 GPEs in block 00 to 3F
[    0.259209] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.270866] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.277006] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    0.286163] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplu=
g]
[    0.293151] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapabili=
ty]
[    0.300010] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-3f] only partially covers this bridge
[    0.311112] acpi PNP0A08:00: ignoring host bridge window [mem 0x000c8000=
-0x000dffff window] (conflicts with Video ROM [mem 0x000c0000-0x000cd7ff])
[    0.324148] PCI host bridge to bus 0000:00
[    0.328003] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.335002] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.342002] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.349002] pci_bus 0000:00: root bus resource [mem 0xbfa00000-0xfffffff=
f window]
[    0.357002] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.363007] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.369075] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.375028] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.381067] pci 0000:00:02.0: [8086:0112] type 00 class 0x030000
[    0.387009] pci 0000:00:02.0: reg 0x10: [mem 0xfe000000-0xfe3fffff 64bit]
[    0.394005] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    0.401004] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.407088] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.413023] pci 0000:00:16.0: reg 0x10: [mem 0xfe607000-0xfe60700f 64bit]
[    0.420068] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.426074] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    0.432021] pci 0000:00:1a.0: reg 0x10: [mem 0xfe606000-0xfe6063ff]
[    0.439078] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.445072] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    0.451020] pci 0000:00:1b.0: reg 0x10: [mem 0xfe600000-0xfe603fff 64bit]
[    0.458068] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.464067] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.470078] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.476079] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    0.482078] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.489076] pci 0000:00:1c.5: [8086:1c1a] type 01 class 0x060400
[    0.495078] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.501076] pci 0000:00:1c.6: [8086:1c1c] type 01 class 0x060400
[    0.507078] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.513076] pci 0000:00:1c.7: [8086:244e] type 01 class 0x060401
[    0.520079] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.526078] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    0.532021] pci 0000:00:1d.0: reg 0x10: [mem 0xfe605000-0xfe6053ff]
[    0.538078] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.545071] pci 0000:00:1f.0: [8086:1c4a] type 00 class 0x060100
[    0.551161] pci 0000:00:1f.2: [8086:1c00] type 00 class 0x01018f
[    0.557015] pci 0000:00:1f.2: reg 0x10: [io  0xf110-0xf117]
[    0.563007] pci 0000:00:1f.2: reg 0x14: [io  0xf100-0xf103]
[    0.568007] pci 0000:00:1f.2: reg 0x18: [io  0xf0f0-0xf0f7]
[    0.574007] pci 0000:00:1f.2: reg 0x1c: [io  0xf0e0-0xf0e3]
[    0.579007] pci 0000:00:1f.2: reg 0x20: [io  0xf0d0-0xf0df]
[    0.585007] pci 0000:00:1f.2: reg 0x24: [io  0xf0c0-0xf0cf]
[    0.591086] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.597017] pci 0000:00:1f.3: reg 0x10: [mem 0xfe604000-0xfe6040ff 64bit]
[    0.604019] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.609072] pci 0000:00:1f.5: [8086:1c08] type 00 class 0x010185
[    0.616015] pci 0000:00:1f.5: reg 0x10: [io  0xf0b0-0xf0b7]
[    0.621007] pci 0000:00:1f.5: reg 0x14: [io  0xf0a0-0xf0a3]
[    0.627007] pci 0000:00:1f.5: reg 0x18: [io  0xf090-0xf097]
[    0.632007] pci 0000:00:1f.5: reg 0x1c: [io  0xf080-0xf083]
[    0.638007] pci 0000:00:1f.5: reg 0x20: [io  0xf070-0xf07f]
[    0.644007] pci 0000:00:1f.5: reg 0x24: [io  0xf060-0xf06f]
[    0.649101] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.654039] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.660070] pci 0000:03:00.0: [1106:0415] type 00 class 0x010185
[    0.666033] pci 0000:03:00.0: reg 0x10: [io  0xe040-0xe047]
[    0.671014] pci 0000:03:00.0: reg 0x14: [io  0xe030-0xe033]
[    0.677014] pci 0000:03:00.0: reg 0x18: [io  0xe020-0xe027]
[    0.683014] pci 0000:03:00.0: reg 0x1c: [io  0xe010-0xe013]
[    0.688014] pci 0000:03:00.0: reg 0x20: [io  0xe000-0xe00f]
[    0.694026] pci 0000:03:00.0: reg 0x30: [mem 0xfe500000-0xfe50ffff pref]
[    0.701078] pci 0000:03:00.0: supports D1 D2
[    0.705002] pci 0000:03:00.0: PME# supported from D1 D2 D3hot
[    0.714018] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.719004] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    0.725004] pci 0000:00:1c.4:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.732062] pci 0000:04:00.0: [1b21:1042] type 00 class 0x0c0330
[    0.738040] pci 0000:04:00.0: reg 0x10: [mem 0xfe400000-0xfe407fff 64bit]
[    0.745157] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.751086] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.756006] pci 0000:00:1c.5:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.763057] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
[    0.769034] pci 0000:05:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.775032] pci 0000:05:00.0: reg 0x18: [mem 0xd0004000-0xd0004fff 64bit=
 pref]
[    0.782020] pci 0000:05:00.0: reg 0x20: [mem 0xd0000000-0xd0003fff 64bit=
 pref]
[    0.789110] pci 0000:05:00.0: supports D1 D2
[    0.794001] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.801101] pci 0000:00:1c.6: PCI bridge to [bus 05]
[    0.806003] pci 0000:00:1c.6:   bridge window [io  0xd000-0xdfff]
[    0.812007] pci 0000:00:1c.6:   bridge window [mem 0xd0000000-0xd00fffff=
 64bit pref]
[    0.820059] pci 0000:06:00.0: [1b21:1080] type 01 class 0x060401
[    0.826146] pci 0000:00:1c.7: PCI bridge to [bus 06-07] (subtractive dec=
ode)
[    0.833010] pci 0000:00:1c.7:   bridge window [io  0x0000-0x0cf7 window]=
 (subtractive decode)
[    0.842002] pci 0000:00:1c.7:   bridge window [io  0x0d00-0xffff window]=
 (subtractive decode)
[    0.850002] pci 0000:00:1c.7:   bridge window [mem 0x000a0000-0x000bffff=
 window] (subtractive decode)
[    0.860002] pci 0000:00:1c.7:   bridge window [mem 0xbfa00000-0xffffffff=
 window] (subtractive decode)
[    0.869105] pci 0000:06:00.0: PCI bridge to [bus 07] (subtractive decode)
[    0.876021] pci 0000:06:00.0:   bridge window [io  0x0000-0x0cf7 window]=
 (subtractive decode)
[    0.884002] pci 0000:06:00.0:   bridge window [io  0x0d00-0xffff window]=
 (subtractive decode)
[    0.893002] pci 0000:06:00.0:   bridge window [mem 0x000a0000-0x000bffff=
 window] (subtractive decode)
[    0.902001] pci 0000:06:00.0:   bridge window [mem 0xbfa00000-0xffffffff=
 window] (subtractive decode)
[    0.912551] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14=
 15), disabled.
[    0.920052] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14=
 15), disabled.
[    0.928051] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 1=
5), disabled.
[    0.936051] ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 10 11 12 14 1=
5), disabled.
[    0.944051] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 *7 10 11 12 14=
 15), disabled.
[    0.952051] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *10 11 12 14=
 15), disabled.
[    0.961051] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 14=
 15), disabled.
[    0.969052] ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 12 14=
 15), disabled.
[    0.977101] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.978000] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.992004] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.997001] vgaarb: loaded
[    1.000054] SCSI subsystem initialized
[    1.004016] ACPI: bus type USB registered
[    1.008011] usbcore: registered new interface driver usbfs
[    1.014006] usbcore: registered new interface driver hub
[    1.024016] pps_core: LinuxPPS API ver. 1 registered
[    1.029001] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    1.038003] PTP clock support registered
[    1.042011] EDAC MC: Ver: 3.0.0
[    1.046070] PCI: Using ACPI for IRQ routing
[    1.051364] PCI: pci_cache_line_size set to 64 bytes
[    1.056047] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    1.063001] e820: reserve RAM buffer [mem 0xbac1e000-0xbbffffff]
[    1.069002] e820: reserve RAM buffer [mem 0xbadd1000-0xbbffffff]
[    1.075001] e820: reserve RAM buffer [mem 0xbb000000-0xbbffffff]
[    1.081001] e820: reserve RAM buffer [mem 0x1bfe00000-0x1bfffffff]
[    1.087070] NetLabel: Initializing
[    1.090001] NetLabel:  domain hash size =3D 128
[    1.095001] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    1.101014] NetLabel:  unlabeled traffic allowed by default
[    1.106146] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.113002] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.121011] clocksource: Switched to clocksource tsc-early
[    1.135581] VFS: Disk quotas dquot_6.6.0
[    1.139590] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.146577] pnp: PnP ACPI init
[    1.149839] system 00:00: [mem 0xfed10000-0xfed19fff] has been reserved
[    1.156517] system 00:00: [mem 0xe0000000-0xe3ffffff] has been reserved
[    1.163195] system 00:00: [mem 0xfed90000-0xfed93fff] has been reserved
[    1.169871] system 00:00: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.176552] system 00:00: [mem 0xfee00000-0xfee0ffff] has been reserved
[    1.183238] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.190174] system 00:01: [io  0x0290-0x029f] has been reserved
[    1.196159] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.203275] pnp 00:02: [dma 0 disabled]
[    1.207268] pnp 00:02: Plug and Play ACPI device, IDs PNP0400 (active)
[    1.213884] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.220517] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    1.226501] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.233553] pnp 00:05: [dma 0 disabled]
[    1.237488] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.244272] system 00:06: [io  0x0400-0x0453] has been reserved
[    1.250257] system 00:06: [io  0x0458-0x047f] has been reserved
[    1.256244] system 00:06: [io  0x0500-0x057f] has been reserved
[    1.262224] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.268897] system 00:06: [mem 0xfec00000-0xfecfffff] could not be reser=
ved
[    1.275917] system 00:06: [mem 0xfed08000-0xfed08fff] has been reserved
[    1.282590] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    1.289268] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.296174] system 00:07: [io  0x0454-0x0457] has been reserved
[    1.302163] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    1.309962] pnp: PnP ACPI: found 8 devices
[    1.319670] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    1.328681] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.333710] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    1.338751] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    1.343779] pci 0000:00:1c.4:   bridge window [io  0xe000-0xefff]
[    1.349934] pci 0000:00:1c.4:   bridge window [mem 0xfe500000-0xfe5fffff]
[    1.356796] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    1.361824] pci 0000:00:1c.5:   bridge window [mem 0xfe400000-0xfe4fffff]
[    1.368677] pci 0000:00:1c.6: PCI bridge to [bus 05]
[    1.373706] pci 0000:00:1c.6:   bridge window [io  0xd000-0xdfff]
[    1.379865] pci 0000:00:1c.6:   bridge window [mem 0xd0000000-0xd00fffff=
 64bit pref]
[    1.387699] pci 0000:06:00.0: PCI bridge to [bus 07]
[    1.392745] pci 0000:00:1c.7: PCI bridge to [bus 06-07]
[    1.512958] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4,=
 65536 bytes)
[    1.520909] TCP established hash table entries: 65536 (order: 7, 524288 =
bytes)
[    1.528316] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.535218] TCP: Hash tables configured (established 65536 bind 65536)
[    1.541837] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.548020] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.554652] NET: Registered protocol family 1
[    1.559145] RPC: Registered named UNIX socket transport module.
[    1.565133] RPC: Registered udp transport module.
[    1.569905] RPC: Registered tcp transport module.
[    1.574673] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.581182] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    1.589689] IOAPIC[0]: Set routing entry (0-23 -> 0xef -> IRQ 23 Mode:1 =
Active:1 Dest:1)
[    1.597979] IOAPIC[0]: Set routing entry (0-23 -> 0xef -> IRQ 23 Mode:1 =
Active:1 Dest:1)
[    1.606254] IOAPIC[0]: Set routing entry (0-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:1)
[    1.614463] IOAPIC[0]: Set routing entry (0-17 -> 0xef -> IRQ 17 Mode:1 =
Active:1 Dest:1)
[    1.622688] pci 0000:04:00.0: quirk_usb_early_handoff+0x0/0x6a0 took 160=
83 usecs
[    1.630176] PCI: CLS 64 bytes, default 64
[    1.634274] Unpacking initramfs...
[    6.191281] Freeing initrd memory: 365060K
[    6.195445] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    6.201947] software IO TLB [mem 0xb6c1e000-0xbac1e000] (64MB) mapped at=
 [000000009ea20922-00000000ba44f00f]
[    6.212024] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840=
 ms ovfl timer
[    6.220028] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    6.225839] RAPL PMU: hw unit of domain package 2^-16 Joules
[    6.231560] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    6.238131] Initialise system trusted keyrings
[    6.242668] workingset: timestamp_bits=3D36 max_order=3D21 bucket_order=
=3D0
[    6.250126] zbud: loaded
[    6.253121] 9p: Installing v9fs 9p2000 file system support
[    6.258684] pstore: using deflate compression
[    6.263138] SELinux:  Registering netfilter hooks
[    6.268583] NET: Registered protocol family 38
[    6.273091] Key type asymmetric registered
[    6.277250] Asymmetric key parser 'x509' registered
[    6.282211] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[    6.289706] io scheduler noop registered
[    6.293691] io scheduler deadline registered (default)
[    6.298921] io scheduler cfq registered
[    6.302816] io scheduler mq-deadline registered (default)
[    6.308279] io scheduler kyber registered
[    6.312370] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[    6.319600] IOAPIC[0]: Set routing entry (0-17 -> 0xef -> IRQ 17 Mode:1 =
Active:1 Dest:1)
[    6.328065] IOAPIC[0]: Set routing entry (0-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[    6.336331] pcieport 0000:00:01.0: Signaling PME with IRQ 24
[    6.342071] pcieport 0000:00:1c.0: Signaling PME with IRQ 25
[    6.470688] emc: device handler registered
[    6.474880] alua: device handler registered
[    6.479132] MACsec IEEE 802.1AE
[    6.482384] libphy: Fixed MDIO Bus: probed
[    6.486585] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    6.493697] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    6.499519] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    6.505421] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    6.511423] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.=
0-k
[    6.518449] igb: Copyright (c) 2007-2014 Intel Corporation.
[    6.524098] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - vers=
ion 5.1.0-k
[    6.531847] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    6.537844] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    6.544052] r8169 0000:05:00.0 eth0: RTL8168e/8111e at 0x00000000ca86cf5=
c, 20:cf:30:f4:b6:f7, XID 0c200000 IRQ 30
[    6.554407] r8169 0000:05:00.0 eth0: jumbo features [frames: 9200 bytes,=
 tx checksumming: ko]
[    6.563051] usbcore: registered new interface driver catc
[    6.568521] usbcore: registered new interface driver kaweth
[    6.574158] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Etherne=
t driver
[    6.581652] usbcore: registered new interface driver pegasus
[    6.587379] usbcore: registered new interface driver rtl8150
[    6.593109] usbcore: registered new interface driver asix
[    6.598577] usbcore: registered new interface driver cdc_ether
[    6.604480] usbcore: registered new interface driver cdc_eem
[    6.610206] usbcore: registered new interface driver dm9601
[    6.615852] usbcore: registered new interface driver smsc75xx
[    6.621669] usbcore: registered new interface driver smsc95xx
[    6.627488] usbcore: registered new interface driver gl620a
[    6.633133] usbcore: registered new interface driver net1080
[    6.638862] usbcore: registered new interface driver plusb
[    6.644888] usbcore: registered new interface driver rndis_host
[    6.650883] usbcore: registered new interface driver cdc_subset
[    6.656871] usbcore: registered new interface driver zaurus
[    6.662513] usbcore: registered new interface driver MOSCHIP usb-etherne=
t driver
[    6.670004] usbcore: registered new interface driver int51x1
[    6.675739] usbcore: registered new interface driver ipheth
[    6.681382] usbcore: registered new interface driver sierra_net
[    6.687473] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.694074] ehci-pci: EHCI PCI platform driver
[    6.698664] IOAPIC[0]: Set routing entry (0-23 -> 0xef -> IRQ 23 Mode:1 =
Active:1 Dest:1)
[    6.706865] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    6.712267] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus =
number 1
[    6.719772] ehci-pci 0000:00:1a.0: debug port 2
[    6.728302] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    6.735165] ehci-pci 0000:00:1a.0: irq 23, io mem 0xfe606000
[    6.747063] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    6.752929] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.17
[    6.878227] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.884483] ohci-pci: OHCI PCI platform driver
[    6.888998] uhci_hcd: USB Universal Host Controller Interface driver
[    6.895516] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    6.900963] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus =
number 3
[    6.915435] xhci_hcd 0000:04:00.0: hcc params 0x0200f180 hci version 0x9=
6 quirks 0x00080000
[    6.924085] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 4.17
[    6.932445] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    6.939755] usb usb3: Product: xHCI Host Controller
[    6.944702] usb usb3: Manufacturer: Linux 4.17.0-rc1 xhci-hcd
[    6.950518] usb usb3: SerialNumber: 0000:04:00.0
[    6.955416] hub 3-0:1.0: USB hub found
[    6.959249] hub 3-0:1.0: 2 ports detected
[    6.963428] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    6.968876] xhci_hcd 0000:04:00.0: new USB bus registered, assigned bus =
number 4
[    6.976382] xhci_hcd 0000:04:00.0: Host supports USB 3.0  SuperSpeed
[    6.982832] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    6.991062] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 4.17
[    6.999422] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    7.006735] usb usb4: Product: xHCI Host Controller
[    7.011681] usb usb4: Manufacturer: Linux 4.17.0-rc1 xhci-hcd
[    7.017497] usb usb4: SerialNumber: 0000:04:00.0
[    7.022327] hub 4-0:1.0: USB hub found
[    7.026156] hub 4-0:1.0: 2 ports detected
[    7.030357] usbcore: registered new interface driver usbserial_generic
[    7.036964] usbserial: USB Serial support registered for generic
[    7.043059] i8042: PNP: No PS/2 controller found.
[    7.047900] mousedev: PS/2 mouse device common for all mice
[    7.053739] rtc_cmos 00:03: RTC can wake from S4
[    7.058601] rtc_cmos 00:03: registered as rtc0
[    7.063123] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[    7.070973] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    7.076964] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    7.082621] iTCO_wdt: Found a Cougar Point TCO device (Version=3D2, TCOB=
ASE=3D0x0460)
[    7.090590] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    7.096683] iTCO_vendor_support: vendor-support=3D0
[    7.101459] intel_pstate: Intel P-state driver initializing
[    7.107752] hidraw: raw HID events driver (C) Jiri Kosina
[    7.113359] usbcore: registered new interface driver usbhid
[    7.119013] usbhid: USB HID core driver
[    7.123033] drop_monitor: Initializing network drop monitor service
[    7.129460] Initializing XFRM netlink socket
[    7.133862] NET: Registered protocol family 10
[    7.138669] Segment Routing with IPv6
[    7.142404] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    7.146030] NET: Registered protocol family 17
[    7.153772] 9pnet: Installing 9P2000 support
[    7.159072] microcode: sig=3D0x206a7, pf=3D0x2, revision=3D0x2d
[    7.164694] microcode: Microcode Update Driver: v2.2.
[    7.164761] ... APIC ID:      00000000 (0)
[    7.165759] ... APIC VERSION: 01060015
[    7.165759] 000000000000000000000000000000000000000000000000000000000000=
0000
[    7.183030] 000000000000002400040000000000000000000000000000000000000000=
0000
[    7.183030] 000000000000000000000000000000000000000000000000000000000000=
1000
[    7.199177] number of MP IRQ sources: 15.
[    7.203249] number of IO-APIC #0 registers: 24.
[    7.207840] testing the IO APIC.......................
[    7.210017] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    7.213048] IO APIC #0......
[    7.222572] .... register #00: 00000000
[    7.226475] .......    : physical APIC id: 00
[    7.230895] .......    : Delivery Type: 0
[    7.234967] .......    : LTS          : 0
[    7.239042] .... register #01: 00170020
[    7.242941] .......     : max redirection entries: 17
[    7.248058] .......     : PRQ implemented: 0
[    7.252387] .......     : IO APIC version: 20
[    7.256808] .... IRQ redirection table:
[    7.260708] IOAPIC 0:
[    7.263019] tsc: Refined TSC clocksource calibration: 3311.143 MHz
[    7.263060]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.269306] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fb=
a6a927c6, max_idle_ns: 440795300754 ns
[    7.277218]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.277223]  pin02, enabled , edge , high, V(30), IRR(0), S(0), logical =
, D(01), M(0)
[    7.277228]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.311053]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.318975]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.326896]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.334820]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.342740]  pin08, enabled , edge , high, V(24), IRR(0), S(0), logical =
, D(04), M(0)
[    7.350662]  pin09, enabled , level, high, V(21), IRR(0), S(0), logical =
, D(02), M(0)
[    7.358583]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.366504]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.374425]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.382347]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.390270]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.398192]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.406114]  pin10, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.414035]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.421956]  pin12, enabled , level, low , V(24), IRR(0), S(0), logical =
, D(08), M(0)
[    7.429877]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.437798]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.445721]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[    7.453641]  pin16, disabled, edge , high, V(0A), IRR(0), S(0), logical =
, D(FF), M(2)
[    7.461567]  pin17, enabled , level, low , V(22), IRR(0), S(0), logical =
, D(01), M(0)
[    7.469482] IRQ to pin mappings:
[    7.472770] IRQ0 -> 0:2
[    7.475281] IRQ1 -> 0:1
[    7.477796] IRQ3 -> 0:3
[    7.480310] IRQ4 -> 0:4
[    7.482824] IRQ5 -> 0:5
[    7.485802] IRQ6 -> 0:6
[    7.488317] IRQ7 -> 0:7
[    7.490830] IRQ8 -> 0:8
[    7.493343] IRQ9 -> 0:9
[    7.495858] IRQ10 -> 0:10
[    7.498544] IRQ11 -> 0:11
[    7.501233] IRQ12 -> 0:12
[    7.503919] IRQ13 -> 0:13
[    7.506604] IRQ14 -> 0:14
[    7.509292] IRQ15 -> 0:15
[    7.511978] IRQ16 -> 0:16
[    7.514664] IRQ17 -> 0:17
[    7.517352] IRQ18 -> 0:18
[    7.520040] IRQ21 -> 0:21
[    7.522727] IRQ23 -> 0:23
[    7.525413] .................................... done.
[    7.530620] clocksource: Switched to clocksource tsc
[    7.530626] sched_clock: Marking stable (7530614973, 0)->(7776196469, -2=
45581496)
[    7.542382] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024, bcdDevice=3D 0.00
[    7.551482] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    7.558932] hub 1-1:1.0: USB hub found
[    7.562841] hub 1-1:1.0: 6 ports detected
[    7.562960] registered taskstats version 1
[    7.566919] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0024, bcdDevice=3D 0.00
[    7.566921] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    7.571081] Loading compiled-in X.509 certificates
[    7.571093] zswap: loaded using pool lzo/zbud
[    7.582014] usb 3-1: new full-speed USB device number 2 using xhci_hcd
[    7.602443] hub 2-1:1.0: USB hub found
[    7.606537] hub 2-1:1.0: 8 ports detected
[    7.608547] Key type big_key registered
[    7.625562] ima: No TPM chip found, activating TPM-bypass! (rc=3D-19)
[    7.631902] ima: Allocated hash algorithm: sha1
[    7.636508] evm: HMAC attrs: 0x1
[    7.640113] rtc_cmos 00:03: setting system clock to 2006-03-13 11:53:52 =
UTC (1142250832)
[    7.648557] r8169 0000:05:00.0: Direct firmware load for rtl_nic/rtl8168=
e-2.fw failed with error -2
[    7.657692] r8169 0000:05:00.0: Falling back to user helper
[    7.810711] usb 3-1: New USB device found, idVendor=3D14dd, idProduct=3D=
1005, bcdDevice=3D 0.00
[    7.819008] usb 3-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    7.826210] usb 3-1: Product: D2CIM-VUSB
[    7.830202] usb 3-1: Manufacturer: Raritan
[    7.834363] usb 3-1: SerialNumber: 7C07478CDFA42B6
[    7.851222] input: Raritan D2CIM-VUSB as /devices/pci0000:00/0000:00:1c.=
5/0000:04:00.0/usb3/3-1/3-1:1.0/0003:14DD:1005.0001/input/input2
[    7.915565] hid-generic 0003:14DD:1005.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [Raritan D2CIM-VUSB] on usb-0000:04:00.0-1/input0
[   70.623091] r8169 0000:05:00.0 eth0: unable to load firmware patch rtl_n=
ic/rtl8168e-2.fw (-11)
[   70.645843] r8169 0000:05:00.0 eth0: link down
[   70.650383] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   72.749522] r8169 0000:05:00.0 eth0: link up
[   72.753881] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   72.762059] Sending DHCP requests .., OK
[   75.492080] IP-Config: Got DHCP answer from 192.168.1.1, my address is 1=
92.168.1.171
[   75.499934] IP-Config: Complete:
[   75.503228]      device=3Deth0, hwaddr=3D20:cf:30:f4:b6:f7, ipaddr=3D192=
=2E168.1.171, mask=3D255.255.255.0, gw=3D192.168.1.1
[   75.513487]      host=3Dsnb-drag, domain=3Dlkp.intel.com, nis-domain=3D(=
none)
[   75.520169]      bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, roo=
tpath=3D     nameserver0=3D192.168.1.1
[   75.531364] Freeing unused kernel memory: 2384K
[   75.535964] Write protecting the kernel read-only data: 20480k
[   75.542424] Freeing unused kernel memory: 2012K
[   75.550091] Freeing unused kernel memory: 1976K
[   75.554687] rodata_test: all tests were successful
[   75.561947] systemd[1]: RTC configured in localtime, applying delta of 4=
80 minutes to system time.
[   75.572389] systemd[1]: System time before build time, advancing clock.
[   75.666838] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   75.694983] cryptd: max_cpu_qlen set to 1000
[   75.704413] input: PC Speaker as /devices/platform/pcspkr/input/input3
[   75.713386] parport_pc 00:02: reported by Plug and Play ACPI
[   75.713414] AVX version of gcm_enc/dec engaged.
[   75.719366] parport0: PC-style at 0x378
[   75.725207] AES CTR mode by8 optimization enabled
[   75.736693] , irq 5 [PCSPP]
[   75.742756] libata version 3.00 loaded.
[   75.748597] Error: Driver 'pcspkr' is already registered, aborting...
[   75.755994] pata_via 0000:03:00.0: version 0.3.4
[   75.761470] ppdev: user-space parallel port driver
[   75.767830] asus_wmi: ASUS WMI generic driver loaded
[   75.772076] scsi host0: pata_via
[   75.778952] ata_piix 0000:00:1f.2: version 2.13
[   75.784844] scsi host1: pata_via
[   75.786544] IOAPIC[0]: Set routing entry (0-20 -> 0xef -> IRQ 20 Mode:1 =
Active:1 Dest:1)
[   75.789532] ata1: PATA max UDMA/133 cmd 0xe040 ctl 0xe030 bmdma 0xe000 i=
rq 16
[   75.799030] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   75.807582] ata2: PATA max UDMA/133 cmd 0xe020 ctl 0xe010 bmdma 0xe008 i=
rq 16
[   75.827767] asus_wmi: Initialization: 0x0
[   75.832496] asus_wmi: BIOS WMI version: 0.9
[   75.838134] asus_wmi: SFUN value: 0x0
[   75.843622] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/inp=
ut/input4
[   75.853986] asus_wmi: Number of fans: 1
[   75.861611] intel_rapl: Found RAPL domain package
[   75.867785] intel_rapl: Found RAPL domain core
[   75.873648] intel_rapl: Found RAPL domain uncore
[   75.879680] intel_rapl: RAPL package 0 domain package locked by BIOS
[   75.977286] scsi host2: ata_piix
[   75.982329] scsi host3: ata_piix
[   75.986724] ata3: SATA max UDMA/133 cmd 0xf110 ctl 0xf100 bmdma 0xf0d0 i=
rq 20
[   75.995256] ata4: SATA max UDMA/133 cmd 0xf0f0 ctl 0xf0e0 bmdma 0xf0d8 i=
rq 20
[   76.003962] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[   76.168935] scsi host4: ata_piix
[   76.173260] scsi host5: ata_piix
[   76.176676] ata5: SATA max UDMA/133 cmd 0xf0b0 ctl 0xf0a0 bmdma 0xf070 i=
rq 20
[   76.185189] ata6: SATA max UDMA/133 cmd 0xf090 ctl 0xf080 bmdma 0xf078 i=
rq 20
[   76.194423] [drm] Replacing VGA console driver
[   76.200137] Console: switching to colour dummy device 80x25
[   76.207479] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   76.214484] [drm] Driver supports precise vblank timestamp query.
[   76.221164] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[   76.234995] [drm] Initialized i915 1.6.0 20180308 for 0000:00:02.0 on mi=
nor 0
[   76.243108] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[   76.250643] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input5
[   76.261344] IOAPIC[0]: Set routing entry (0-22 -> 0xef -> IRQ 22 Mode:1 =
Active:1 Dest:1)
[   76.334245] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   76.340805] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   76.347692] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   76.354242] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   76.354243] 	[00] BAD  ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[   76.505038] snd_hda_intel 0000:00:1b.0: bound 0000:00:02.0 (ops i915_aud=
io_component_bind_ops [i915])
[   76.514424] fbcon: inteldrmfb (fb0) is primary device
[   76.533402] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: li=
ne_outs=3D4 (0x14/0x15/0x16/0x17/0x0) type:line
[   76.533405] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[   76.533406] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x1b/0x0/=
0x0/0x0/0x0)
[   76.533407] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
[   76.533408] snd_hda_codec_realtek hdaudioC0D0:    dig-out=3D0x11/0x1e
[   76.533409] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   76.533411] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
[   76.533412] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
[   76.533413] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x1a
[   76.555483] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:0=
0:1b.0/sound/card0/input6
[   76.555522] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00=
:1b.0/sound/card0/input7
[   76.555556] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.=
0/sound/card0/input8
[   76.555588] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0=
000:00:1b.0/sound/card0/input9
[   76.555621] input: HDA Intel PCH Line Out Surround as /devices/pci0000:0=
0/0000:00:1b.0/sound/card0/input10
[   76.555653] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/00=
00:00:1b.0/sound/card0/input11
[   76.555684] input: HDA Intel PCH Line Out Side as /devices/pci0000:00/00=
00:00:1b.0/sound/card0/input12
[   76.555715] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input13
[   76.555748] input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input14
[   76.579465] Console: switching to colour frame buffer device 128x48
[   76.756152] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   77.039034] ata4.00: failed to resume link (SControl 0)
[   77.231017] ata6: failed to resume link (SControl 0)
[   77.246925] ata6: SATA link down (SStatus 4 SControl 0)
[   77.343066] ata3.01: failed to resume link (SControl 0)
[   77.503098] ata3.00: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   77.510249] ata3.01: SATA link down (SStatus 0 SControl 0)
[   77.519180] ata3.00: ATA-9: WDC WD20EZRX-00D8PB0, 80.00A80, max UDMA/133
[   77.526750] ata3.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   77.537330] ata3.00: configured for UDMA/133
[   77.542515] scsi 2:0:0:0: Direct-Access     ATA      WDC WD20EZRX-00D 0A=
80 PQ: 0 ANSI: 5
[   78.079038] ata4.01: failed to resume link (SControl 0)
[   78.095953] ata4.00: SATA link down (SStatus 4 SControl 0)
[   78.102255] ata4.01: SATA link down (SStatus 0 SControl 0)
[   78.510211] ata5: SATA link down (SStatus 1 SControl 300)
[   78.523862] scsi 2:0:0:0: Attached scsi generic sg0 type 0
[   78.531887] sd 2:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 =
TB/1.82 TiB)
[   78.540453] sd 2:0:0:0: [sda] 4096-byte physical blocks
[   78.546599] sd 2:0:0:0: [sda] Write Protect is off
[   78.552217] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   78.558257] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   79.309260]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 s=
da11 >
[   79.318603] sd 2:0:0:0: [sda] Attached SCSI disk
[   80.066588] random: crng init done
[   80.933014] raid6: sse2x1   gen()  8894 MB/s
[   80.955015] raid6: sse2x1   xor()  7023 MB/s
[   80.977013] raid6: sse2x2   gen() 11144 MB/s
[   80.999016] raid6: sse2x2   xor()  8001 MB/s
[   81.021017] raid6: sse2x4   gen() 13222 MB/s
[   81.043011] raid6: sse2x4   xor()  7242 MB/s
[   81.048055] raid6: using algorithm sse2x4 gen() 13222 MB/s
[   81.054345] raid6: .... xor() 7242 MB/s, rmw enabled
[   81.060120] raid6: using ssse3x2 recovery algorithm
[   81.076192] xor: automatically using best checksumming function   avx   =
   =20
[   81.112920] Btrfs loaded, crc32c=3Dcrc32c-generic
[   81.119107] BTRFS: device fsid 1a996b8e-731b-4544-a67e-610f318a6ee5 devi=
d 4 transid 5 /dev/sda9
[   81.129061] BTRFS: device fsid a33c612a-1ae1-4374-90cf-3ece9125b30c devi=
d 1 transid 19 /dev/sda5
[   81.139162] BTRFS: device fsid d3a01489-3aca-4195-af4b-c375d8853726 devi=
d 1 transid 9 /dev/sda6
[   81.150661] BTRFS: device fsid 1a996b8e-731b-4544-a67e-610f318a6ee5 devi=
d 5 transid 5 /dev/sda10
[   81.161195] BTRFS: device fsid 9c7df7b4-1795-4117-b623-5953f4157900 devi=
d 1 transid 17892 /dev/sda2
[   82.451900] Kernel tests: Boot OK!
[   82.451904]=20
[   83.738953] BTRFS info (device sda2): disk space caching is enabled
[   83.745875] BTRFS info (device sda2): has skinny extents
[   84.208452] netpoll: netconsole: local port 6665
[   84.213687] netpoll: netconsole: local IPv4 address 0.0.0.0
[   84.219869] netpoll: netconsole: interface 'eth0'
[   84.225184] netpoll: netconsole: remote port 6648
[   84.230506] netpoll: netconsole: remote IPv4 address 192.168.1.1
[   84.237122] netpoll: netconsole: remote ethernet address ff:ff:ff:ff:ff:=
ff
[   84.244604] netpoll: netconsole: local IP 192.168.1.171
[   84.252724] console [netcon0] enabled
[   84.256948] netconsole: network logging started
[   85.911941] install debs round one: dpkg -i --force-confdef --force-depe=
nds /opt/deb/mime-support_3.60_all.deb
[   85.911944]=20
[   85.925395] /opt/deb/libssl1.1_1.1.0g-2_amd64.deb
[   85.925396]=20
[   85.933663] /opt/deb/gawk_1%3a4.1.4+dfsg-1+b1_amd64.deb
[   85.933664]=20
[   85.942409] /opt/deb/libattr1_1%3a2.4.47-2+b2_amd64.deb
[   85.942410]=20
[   85.951610] /opt/deb/attr_1%3a2.4.47-2+b2_amd64.deb
[   85.951613]=20
[   85.961344] /opt/deb/gawk_1%3a4.1.4+dfsg-1_amd64.deb
[   85.961347]=20
[   85.970906] /opt/deb/sysstat_11.6.0-1_amd64.deb
[   85.970909]=20
[   85.980977] Selecting previously unselected package mime-support.
[   85.980979]=20
[   85.991391] (Reading database ... 2202 files and directories currently i=
nstalled.)
[   85.991394]=20
[   86.002796] Preparing to unpack .../deb/mime-support_3.60_all.deb ...
[   86.002797]=20
[   86.012557] Unpacking mime-support (3.60) ...
[   86.012558]=20
[   86.021604] Selecting previously unselected package libssl1.1:amd64.
[   86.021607]=20
[   86.032667] Preparing to unpack .../libssl1.1_1.1.0g-2_amd64.deb ...
[   86.032668]=20
[   86.042771] Unpacking libssl1.1:amd64 (1.1.0g-2) ...
[   86.042773]=20
[   86.052774] Preparing to unpack .../gawk_1%3a4.1.4+dfsg-1+b1_amd64.deb .=
=2E.
[   86.052776]=20
[   86.063954] Unpacking gawk (1:4.1.4+dfsg-1+b1) over (1:4.1.1+dfsg-1) ...
[   86.063957]=20
[   86.076126] Preparing to unpack .../libattr1_1%3a2.4.47-2+b2_amd64.deb .=
=2E.
[   86.076129]=20
[   86.087104] Unpacking libattr1:amd64 (1:2.4.47-2+b2) over (1:2.4.47-2) .=
=2E.
[   86.087105]=20
[   86.098050] Selecting previously unselected package attr.
[   86.098052]=20
[   86.108260] Preparing to unpack .../attr_1%3a2.4.47-2+b2_amd64.deb ...
[   86.108262]=20
[   86.118769] Unpacking attr (1:2.4.47-2+b2) ...
[   86.118770]=20
[   86.128169] Preparing to unpack .../gawk_1%3a4.1.4+dfsg-1_amd64.deb ...
[   86.128170]=20
[   86.138809] Unpacking gawk (1:4.1.4+dfsg-1) over (1:4.1.4+dfsg-1+b1) ...
[   86.138811]=20
[   86.149418] Selecting previously unselected package sysstat.
[   86.149420]=20
[   86.159854] Preparing to unpack .../deb/sysstat_11.6.0-1_amd64.deb ...
[   86.159855]=20
[   86.169793] Unpacking sysstat (11.6.0-1) ...
[   86.169795]=20
[   86.178861] More than one copy of package gawk has been unpacked
[   86.178862]=20
[   86.188718]  in this run !  Only configuring it once.
[   86.188720]=20
[   86.198020] Setting up mime-support (3.60) ...
[   86.198022]=20
[   86.206678] Setting up libssl1.1:amd64 (1.1.0g-2) ...
[   86.206681]=20
[   86.216713] Setting up libattr1:amd64 (1:2.4.47-2+b2) ...
[   86.216715]=20
[   86.226608] Setting up attr (1:2.4.47-2+b2) ...
[   86.226610]=20
[   86.236319] Setting up sysstat (11.6.0-1) ...
[   86.236321]=20
[   86.244703] Setting up gawk (1:4.1.4+dfsg-1) ...
[   86.244704]=20
[   86.253028] Processing triggers for libc-bin (2.23-5) ...
[   86.253030]=20
[   86.262652] Processing triggers for systemd (231-5) ...
[   86.262654]=20
[   86.273884] 16 Apr 23:53:39 ntpdate[518]: step time server 192.168.1.1 o=
ffset 54417823.981575 sec
[   86.273886]=20
[   86.286007] /lkp/lkp/src/bin/run-lkp
[   86.286008]=20
[   88.531749] RESULT_ROOT=3D/result/xfstests/4HDD-btrfs-generic-group5/snb=
-drag/debian-x86_64-2016-08-31.cgz/x86_64-rhel-7.2/gcc-7/60cc43fc888428bb2f=
18f08997432d426a243338/0
[   88.531753]=20
[   88.553235] job=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gr=
oup5-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml
[   88.553236]=20
[   88.570163] mount.nfs: try 1 time...
[   88.570164]=20
[  103.719014] run-job /lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-=
group5-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.ya=
ml
[  103.719017]=20
[  103.928611] device-mapper: uevent: version 1.0.3
[  103.933983] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised:=
 dm-devel@redhat.com
[  105.656829] BTRFS: device fsid 94606b37-26d5-404a-81a3-955885bb5cd6 devi=
d 1 transid 5 /dev/sda8
[  105.681385] BTRFS: device fsid 3357a0a7-5e02-4b53-a95b-af8077bb0375 devi=
d 1 transid 5 /dev/sda6
[  105.955468] BTRFS: device fsid 46774a73-16eb-4b74-8395-bf5b2c51e3b0 devi=
d 1 transid 5 /dev/sda7
[  106.177401] BTRFS: device fsid 89291dba-ecd5-414c-8699-7fd0cfff4956 devi=
d 1 transid 5 /dev/sda5
[  106.336609] BTRFS info (device sda5): disk space caching is enabled
[  106.339081] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gro=
up5-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml&=
job_state=3Drunning -o /dev/null
[  106.343553] BTRFS info (device sda5): has skinny extents
[  106.343554] BTRFS info (device sda5): flagging fs with big metadata feat=
ure
[  106.380838]=20
[  106.385459] microcode current_version: 0x2d, target_version: 0x2d
[  106.385461]=20
[  106.396869] 2018-04-16 23:53:59 dmsetup remove_all
[  106.396872]=20
[  106.407288] 2018-04-16 23:53:59 wipefs -a --force /dev/sda5
[  106.407289]=20
[  106.417701] /dev/sda5: 8 bytes were erased at offset 0x00010040 (btrfs):=
 5f 42 48 52 66 53 5f 4d
[  106.417702]=20
[  106.430540] 2018-04-16 23:54:00 wipefs -a --force /dev/sda6
[  106.430541]=20
[  106.440972] /dev/sda6: 8 bytes were erased at offset 0x00010040 (btrfs):=
 5f 42 48 52 66 53 5f 4d
[  106.440973]=20
[  106.453902] 2018-04-16 23:54:00 wipefs -a --force /dev/sda7
[  106.453903]=20
[  106.468092] 2018-04-16 23:54:00 wipefs -a --force /dev/sda8
[  106.468095]=20
[  106.469714] BTRFS info (device sda5): creating UUID tree
[  106.475618] 2018-04-16 23:54:00 mkfs -t btrfs /dev/sda5
[  106.482985]=20
[  106.492281] 2018-04-16 23:54:00 mkfs -t btrfs /dev/sda6
[  106.492282]=20
[  106.501469] 2018-04-16 23:54:00 mkfs -t btrfs /dev/sda7
[  106.501470]=20
[  106.510620] 2018-04-16 23:54:00 mkfs -t btrfs /dev/sda8
[  106.510621]=20
[  106.519287] btrfs-progs v4.7.3
[  106.519288]=20
[  106.526491] See http://btrfs.wiki.kernel.org for more information.
[  106.526492]=20
[  106.535622]=20
[  106.538402] Label:              (null)
[  106.538403]=20
[  106.545198] BTRFS info (device sda6): disk space caching is enabled
[  106.545522] UUID:              =20
[  106.552170]=20
[  106.552172] BTRFS info (device sda6): has skinny extents
[  106.556653] Node size:          16384
[  106.558233] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  106.571928] BTRFS info (device sda6): creating UUID tree
[  106.576203]=20
[  106.576759] Sector size:        4096
[  106.584375]=20
[  106.591438] Filesystem size:    200.00GiB
[  106.591439]=20
[  106.598626] Block group profiles:
[  106.598627]=20
[  106.605578]   Data:             single            8.00MiB
[  106.605579]=20
[  106.614608]   Metadata:         DUP               1.00GiB
[  106.614610]=20
[  106.623589]   System:           DUP               8.00MiB
[  106.623590]=20
[  106.631789] BTRFS info (device sda7): disk space caching is enabled
[  106.632158] SSD detected:       no
[  106.638609]=20
[  106.638612] BTRFS info (device sda7): has skinny extents
[  106.643569] Incompat features:  extref, skinny-metadata
[  106.644570] BTRFS info (device sda7): flagging fs with big metadata feat=
ure
[  106.663661]=20
[  106.666162] Number of devices:  1
[  106.666163]=20
[  106.672173] Devices:
[  106.672174]=20
[  106.676884] BTRFS info (device sda7): creating UUID tree
[  106.677404]    ID        SIZE  PATH
[  106.768039]   Data:             single            8.00MiB
[  106.778445]=20
[  106.787272]   Metadata:         DUP               1.00GiB
[  106.787273]=20
[  106.796064]   System:           DUP               8.00MiB
[  106.796065]=20
[  106.804285] SSD detected:       no
[  106.804286]=20
[  106.810931] Incompat features:  extref, skinny-metadata
[  106.810933]=20
[  106.818999] Number of devices:  1
[  106.819000]=20
[  106.824833] Devices:
[  106.824834]=20
[  106.829950]    ID        SIZE  PATH
[  106.829952]=20
[  106.836488]     1   200.00GiB  /dev/sda6
[  106.836490]=20
[  106.844082]=20
[  106.846414] btrfs-progs v4.7.3
[  106.846415]=20
[  106.853126] See http://btrfs.wiki.kernel.org for more information.
[  106.853127]=20
[  106.862783]=20
[  106.865519] Label:              (null)
[  106.865520]=20
[  106.865658] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.870156] UUID:              =20
[  106.871581] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.884166]=20
[  106.884732] Node size:          16384
[  106.903394] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.904299]=20
[  106.908439] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.921714] Sector size:        4096
[  106.937737]=20
[  106.938703] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.942630] Filesystem size:    200.00GiB
[  106.944001] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.959515] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.963313]=20
[  106.976207] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  106.989664] Block group profiles:
[  107.006090]=20
[  107.006768] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.011140]   Data:             single            8.00MiB
[  107.012277] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.025361]=20
[  107.047009] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.049718]   Metadata:         DUP               1.00GiB
[  107.061925] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.077519] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.084446]=20
[  107.097832] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.101182]   System:           DUP               8.00MiB
[  107.113658]=20
[  107.123820] SSD detected:       no
[  107.123821]=20
[  107.128725] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.131950] Incompat features:  extref, skinny-metadata
[  107.144543]=20
[  107.144547] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.151159] Number of devices:  1
[  107.168317]=20
[  107.168373] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.172712] Devices:
[  107.174902] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.188431]=20
[  107.206857] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.209699]    ID        SIZE  PATH
[  107.222738] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.238388] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.242599]=20
[  107.256167] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.259197]     1   200.00GiB  /dev/sda7
[  107.272106]=20
[  107.280117]=20
[  107.283199] btrfs-progs v4.7.3
[  107.283200]=20
[  107.287098] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.288790] See http://btrfs.wiki.kernel.org for more information.
[  107.289880] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.303349]=20
[  107.325728] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.341441]=20
[  107.341443] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.344379] Label:              (null)
[  107.357215]=20
[  107.365344] UUID:              =20
[  107.365345]=20
[  107.372197] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.372909] Node size:          16384
[  107.385757]=20
[  107.385760] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.390821] Sector size:        4096
[  107.407692]=20
[  107.407977] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.412767] Filesystem size:    200.00GiB
[  107.414448] x86/PAT: bmc-watchdog:880 map pfn expected mapping type unca=
ched-minus for [mem 0xbac69000-0xbac69fff], got write-back
[  107.427777]=20
[  107.448893] Block group profiles:
[  107.448895]=20
[  107.456338]   Data:             single            8.00MiB
[  107.456339]=20
[  107.465851]   Metadata:         DUP               1.00GiB
[  107.465852]=20
[  107.475358]   System:           DUP               8.00MiB
[  107.475359]=20
[  107.484490] SSD detected:       no
[  107.484493]=20
[  107.492580] Incompat features:  extref, skinny-metadata
[  107.492582]=20
[  107.501258] Number of devices:  1
[  107.501259]=20
[  107.507600] Devices:
[  107.507602]=20
[  107.513122]    ID        SIZE  PATH
[  107.513124]=20
[  107.520036]     1   200.00GiB  /dev/sda5
[  107.520037]=20
[  107.526712]=20
[  107.529633] 2018-04-16 23:54:01 mkdir -p /fs/sda5
[  107.529634]=20
[  107.538231] 2018-04-16 23:54:01 mount -t btrfs /dev/sda5 /fs/sda5
[  107.538232]=20
[  107.547828] 2018-04-16 23:54:01 mkdir -p /fs/sda6
[  107.547829]=20
[  107.556415] 2018-04-16 23:54:01 mount -t btrfs /dev/sda6 /fs/sda6
[  107.556416]=20
[  107.565900] 2018-04-16 23:54:02 mkdir -p /fs/sda7
[  107.565901]=20
[  107.574385] 2018-04-16 23:54:02 mount -t btrfs /dev/sda7 /fs/sda7
[  107.574386]=20
[  107.583983] 2018-04-16 23:54:02 mkdir -p /fs/sda8
[  107.583984]=20
[  107.592447] 2018-04-16 23:54:02 mount -t btrfs /dev/sda8 /fs/sda8
[  107.592448]=20
[  108.176606] 2018-04-16 23:54:03 export TEST_DIR=3D/fs/sda5
[  108.176609]=20
[  108.185735] 2018-04-16 23:54:03 export TEST_DEV=3D/dev/sda5
[  108.185737]=20
[  108.194826] 2018-04-16 23:54:03 export FSTYP=3Dbtrfs
[  108.194828]=20
[  108.203480] 2018-04-16 23:54:03 export SCRATCH_MNT=3D/fs/scratch
[  108.203482]=20
[  108.212980] 2018-04-16 23:54:03 mkdir /fs/scratch -p
[  108.212982]=20
[  108.222421] 2018-04-16 23:54:03 export SCRATCH_DEV_POOL=3D"/dev/sda6 /de=
v/sda7 /dev/sda8"
[  108.222430]=20
[  108.236307] 2018-04-16 23:54:03 sed "s:^:generic/:" /lkp/lkp/src/pack/xf=
stests-addon/tests/generic-group5 | grep -F -f merged_ignored_files
[  108.236310]=20
[  108.252470] generic/458
[  108.252471]=20
[  108.257814] generic/476
[  108.257815]=20
[  108.263575] ignored by lkp: generic/458
[  108.263577]=20
[  108.270697] ignored by lkp: generic/476
[  108.270699]=20
[  108.280483] 2018-04-16 23:54:03 sed "s:^:generic/:" /lkp/lkp/src/pack/xf=
stests-addon/tests/generic-group5 | grep -v -F -f merged_ignored_files
[  108.280486]=20
[  108.297030] generic/445
[  108.297031]=20
[  108.302468] generic/446
[  108.302470]=20
[  108.307936] generic/447
[  108.307938]=20
[  108.313378] generic/448
[  108.313379]=20
[  108.318792] generic/449
[  108.318793]=20
[  108.324150] generic/450
[  108.324151]=20
[  108.329533] generic/451
[  108.329535]=20
[  108.334853] generic/452
[  108.334854]=20
[  108.340145] generic/453
[  108.340147]=20
[  108.345381] generic/454
[  108.345383]=20
[  108.350617] generic/456
[  108.350618]=20
[  108.355792] generic/459
[  108.355793]=20
[  108.360902] generic/460
[  108.360903]=20
[  108.366009] generic/461
[  108.366010]=20
[  108.371070] generic/463
[  108.371072]=20
[  108.376094] generic/464
[  108.376095]=20
[  108.381063] generic/465
[  108.381064]=20
[  108.385944] generic/466
[  108.385946]=20
[  108.390780] generic/467
[  108.390782]=20
[  108.395670] generic/468
[  108.395672]=20
[  108.400556] generic/469
[  108.400557]=20
[  108.405416] generic/471
[  108.405417]=20
[  108.410279] generic/472
[  108.410280]=20
[  108.415035] generic/473
[  108.415036]=20
[  108.419794] generic/474
[  108.419795]=20
[  108.424538] generic/475
[  108.424540]=20
[  108.429285] generic/477
[  108.429286]=20
[  108.434070] generic/478
[  108.434071]=20
[  108.438833] generic/479
[  108.438834]=20
[  108.443630] generic/480
[  108.443631]=20
[  108.448418] generic/481
[  108.448419]=20
[  109.077787] 512+0 records in
[  109.077790]=20
[  109.136519] 512+0 records out
[  109.136521]=20
[  110.344475] BTRFS info (device sda5): disk space caching is enabled
[  110.351183] BTRFS info (device sda5): has skinny extents
[  111.415912] 262144 bytes (262 kB, 256 KiB) copied, 0.00874669 s, 30.0 MB=
/s
[  111.415915]=20
[  111.425451] 512+0 records in
[  111.425453]=20
[  111.430934] 512+0 records out
[  111.430936]=20
[  111.437598] 262144 bytes (262 kB, 256 KiB) copied, 0.0136695 s, 19.2 MB/s
[  111.437599]=20
[  111.447081] 512+0 records in
[  111.447082]=20
[  111.452625] 512+0 records out
[  111.452627]=20
[  111.459301] 262144 bytes (262 kB, 256 KiB) copied, 0.0222052 s, 11.8 MB/s
[  111.459303]=20
[  112.146743] 2018-04-16 23:54:03 ./check generic/445 generic/446 generic/=
447 generic/448 generic/449 generic/450 generic/451 generic/452 generic/453=
 generic/454 generic/456 generic/459 generic/460 generic/461 generic/463 ge=
neric/464 generic/465 generic/466 generic/467 generic/468 generic/469 gener=
ic/471 generic/472 generic/473 generic/474 generic/475 generic/477 generic/=
478 generic/479 generic/480 generic/481
[  112.146746]=20
[  112.261968] FSTYP         -- btrfs
[  112.261971]=20
[  112.274577] PLATFORM      -- Linux/x86_64 snb-drag 4.17.0-rc1
[  112.274579]=20
[  112.283527] MKFS_OPTIONS  -- /dev/sda6
[  112.283528]=20
[  112.290647] MOUNT_OPTIONS -- /dev/sda6 /fs/scratch
[  112.290648]=20
[  112.298110]=20
[  112.471669] BTRFS: device fsid bae269a6-e6af-40d1-b80f-5a3cf968aa64 devi=
d 1 transid 5 /dev/sda6
[  112.489403] BTRFS info (device sda6): disk space caching is enabled
[  112.496285] BTRFS info (device sda6): has skinny extents
[  112.502182] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  112.511328] BTRFS info (device sda6): creating UUID tree
[  112.755531] BTRFS info (device sda5): disk space caching is enabled
[  112.762464] BTRFS info (device sda5): has skinny extents
[  112.791214] run fstests generic/445 at 2018-04-16 23:54:08
[  113.342680] generic/445	 0s
[  113.342684]=20
[  113.478658] BTRFS info (device sda5): disk space caching is enabled
[  113.485629] BTRFS info (device sda5): has skinny extents
[  113.527272] run fstests generic/446 at 2018-04-16 23:54:08
[  114.085440] BTRFS: device fsid 9141b5da-f5a8-4a16-ade0-63b16eff71df devi=
d 1 transid 5 /dev/sda6
[  114.102858] BTRFS info (device sda6): disk space caching is enabled
[  114.109835] BTRFS info (device sda6): has skinny extents
[  114.115807] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  114.125058] BTRFS info (device sda6): creating UUID tree
[  116.720366] generic/446	 4s
[  116.720369]=20
[  116.841017] run fstests generic/447 at 2018-04-16 23:54:12
[  117.136952] BTRFS: device fsid 1cef7385-84e3-4c2a-90c7-a52d7ef49f8c devi=
d 1 transid 5 /dev/sda6
[  117.154031] BTRFS info (device sda6): disk space caching is enabled
[  117.161037] BTRFS info (device sda6): has skinny extents
[  117.167080] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  117.176391] BTRFS info (device sda6): creating UUID tree
[  117.482190] BTRFS: device fsid 34739b11-5d73-438f-9071-0d1b7042dc89 devi=
d 1 transid 5 /dev/sda6
[  117.499745] BTRFS info (device sda6): disk space caching is enabled
[  117.506803] BTRFS info (device sda6): has skinny extents
[  117.512795] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  117.522062] BTRFS info (device sda6): creating UUID tree
[  167.438091] generic/447	IPMI BMC is not supported on this machine, skip =
bmc-watchdog setup!
[  167.438094]=20
[  197.639162] BTRFS info (device sda6): disk space caching is enabled
[  197.646110] BTRFS info (device sda6): has skinny extents
[  197.763843]  81s
[  197.763847]=20
[  225.771216] BTRFS info (device sda6): disk space caching is enabled
[  225.778568] BTRFS info (device sda6): has skinny extents
[  225.841313] run fstests generic/448 at 2018-04-16 23:56:01
[  226.031246] generic/448	 0s
[  226.031249]=20
[  226.272285] BTRFS info (device sda5): disk space caching is enabled
[  226.279197] BTRFS info (device sda5): has skinny extents
[  226.311468] run fstests generic/449 at 2018-04-16 23:56:01
[  226.767114] BTRFS: device fsid 7521a5d2-a1f3-4190-ac60-6f5e23d3702a devi=
d 1 transid 5 /dev/sda6
[  226.797609] BTRFS info (device sda6): disk space caching is enabled
[  226.804542] BTRFS info (device sda6): has skinny extents
[  226.811922] BTRFS info (device sda6): creating UUID tree
[  228.749660] generic/449	 3s
[  228.749664]=20
[  228.868766] BTRFS info (device sda5): disk space caching is enabled
[  228.875672] BTRFS info (device sda5): has skinny extents
[  229.023890] BTRFS info (device sda6): disk space caching is enabled
[  229.030769] BTRFS info (device sda6): has skinny extents
[  229.114976] run fstests generic/450 at 2018-04-16 23:56:04
[  229.357530] generic/450	 0s
[  229.357535]=20
[  229.502759] BTRFS info (device sda5): disk space caching is enabled
[  229.509665] BTRFS info (device sda5): has skinny extents
[  229.558691] run fstests generic/451 at 2018-04-16 23:56:04
[  229.742226] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.754132] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 8738 Comm: a=
io-dio-cycle-w
[  229.788629] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.800898] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  229.814963] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.826632] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  229.859063] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.870691] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  229.893340] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.905026] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  229.920415] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.932162] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  229.950688] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.962412] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  229.979958] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  229.991748] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  230.008609] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  230.020389] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  230.065668] Page cache invalidation failure on direct I/O.  Possible dat=
a corruption due to collision with buffered I/O!
[  230.077443] File: /fs/sda5/tst-aio-dio-cycle-write.451 PID: 4 Comm: kwor=
ker/0:0
[  259.762874] generic/451	 31s
[  259.762877]=20
[  259.998790] BTRFS info (device sda5): disk space caching is enabled
[  260.005922] BTRFS info (device sda5): has skinny extents
[  260.060012] run fstests generic/452 at 2018-04-16 23:56:35
[  260.427035] BTRFS: device fsid 71380e0d-31bc-4e4d-a98e-3103b393ac02 devi=
d 1 transid 5 /dev/sda6
[  260.447382] BTRFS info (device sda6): disk space caching is enabled
[  260.454684] BTRFS info (device sda6): has skinny extents
[  260.460985] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  260.470927] BTRFS info (device sda6): creating UUID tree
[  260.566231] BTRFS info (device sda6): disk space caching is enabled
[  260.647242] generic/452	 1s
[  260.647245]=20
[  260.725329] BTRFS info (device sda6): disk space caching is enabled
[  260.732479] BTRFS info (device sda6): has skinny extents
[  260.786931] run fstests generic/453 at 2018-04-16 23:56:36
[  261.096723] BTRFS: device fsid 60e621a3-21e8-4c9c-9815-a53d87b52620 devi=
d 1 transid 5 /dev/sda6
[  261.115589] BTRFS info (device sda6): disk space caching is enabled
[  261.122746] BTRFS info (device sda6): has skinny extents
[  261.128921] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  261.138190] BTRFS info (device sda6): creating UUID tree
[  261.302450] generic/453	 0s
[  261.302454]=20
[  261.416061] BTRFS info (device sda6): disk space caching is enabled
[  261.423474] BTRFS info (device sda6): has skinny extents
[  261.511374] run fstests generic/454 at 2018-04-16 23:56:36
[  261.840301] BTRFS: device fsid 2aed2d5a-72b3-4e86-8464-01e568e0ed41 devi=
d 1 transid 5 /dev/sda6
[  261.861219] BTRFS info (device sda6): disk space caching is enabled
[  261.868357] BTRFS info (device sda6): has skinny extents
[  261.874520] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  261.884063] BTRFS info (device sda6): creating UUID tree
[  262.068519] generic/454	 1s
[  262.068522]=20
[  262.181097] BTRFS info (device sda6): disk space caching is enabled
[  262.188131] BTRFS info (device sda6): has skinny extents
[  262.278572] run fstests generic/456 at 2018-04-16 23:56:37
[  262.693602] BTRFS: device fsid 8cce1375-71e5-4155-a7bf-8171c4f34a8e devi=
d 1 transid 5 /dev/sda6
[  262.728094] BTRFS info (device dm-0): disk space caching is enabled
[  262.735778] BTRFS info (device dm-0): has skinny extents
[  262.742455] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[  262.752060] BTRFS info (device dm-0): creating UUID tree
[  262.902433] BTRFS info (device dm-0): disk space caching is enabled
[  262.909501] BTRFS info (device dm-0): has skinny extents
[  262.976158] BTRFS info (device dm-0): checking UUID tree
[  263.115546] generic/456	 1s
[  263.115550]=20
[  263.171080] run fstests generic/459 at 2018-04-16 23:56:38
[  263.590048] BTRFS: device fsid 1d1bbe87-356f-4b9e-a37f-b7c2b2703b77 devi=
d 1 transid 5 /dev/sda6
[  264.226373] device-mapper: thin: Data device (dm-1) discard unsupported:=
 Disabling discard passdown.
[  264.450302] device-mapper: thin: Data device (dm-1) discard unsupported:=
 Disabling discard passdown.
[  264.660442] BTRFS: device fsid 6b978baa-45c9-4f47-b0d7-55c88bfabd69 devi=
d 1 transid 5 /dev/mapper/vg_459-lv_459
[  264.816718] BTRFS info (device dm-5): disk space caching is enabled
[  264.823810] BTRFS info (device dm-5): has skinny extents
[  264.829864] BTRFS info (device dm-5): flagging fs with big metadata feat=
ure
[  264.839356] BTRFS info (device dm-5): creating UUID tree
[  265.791280] device-mapper: thin: 252:2: reached low water mark for data =
device: sending event.
[  265.848294] device-mapper: thin: 252:2: switching pool to out-of-data-sp=
ace (error IO) mode
[  265.878332] BTRFS: error (device dm-5) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  265.891414] BTRFS info (device dm-5): forced readonly
[  265.897198] BTRFS warning (device dm-5): Skipping commit of aborted tran=
saction.
[  265.905274] BTRFS: error (device dm-5) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  265.913964] BTRFS info (device dm-5): delayed_refs has NO entry
[  265.926013] VFS:Filesystem freeze failed
[  275.935392] device-mapper: thin: Data device (dm-1) discard unsupported:=
 Disabling discard passdown.
[  275.945435] device-mapper: thin: 252:2: switching pool to write mode
[  275.952618] device-mapper: thin: 252:2: growing the data device from 160=
0 to 3200 blocks
[  276.005251] BTRFS error (device dm-5): cleaner transaction attach return=
ed -30
[  276.366172] generic/459	 13s
[  276.366176]=20
[  276.401392] run fstests generic/460 at 2018-04-16 23:56:51
[  276.726924] BTRFS: device fsid e3dfb28f-2f93-4e19-862c-f08a1c5dd7f7 devi=
d 1 transid 5 /dev/sda6
[  276.748116] BTRFS info (device sda6): disk space caching is enabled
[  276.755115] BTRFS info (device sda6): has skinny extents
[  276.761140] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  276.794364] BTRFS info (device sda6): creating UUID tree
[  277.118292] generic/460	 1s
[  277.118296]=20
[  285.782215] BTRFS info (device sda6): disk space caching is enabled
[  285.789202] BTRFS info (device sda6): has skinny extents
[  285.866438] run fstests generic/461 at 2018-04-16 23:57:01
[  286.185554] BTRFS: device fsid e3f6337f-bf36-407f-88e7-0bc881c56498 devi=
d 1 transid 5 /dev/sda6
[  286.204591] BTRFS info (device sda6): disk space caching is enabled
[  286.211592] BTRFS info (device sda6): has skinny extents
[  286.217609] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  286.226992] BTRFS info (device sda6): creating UUID tree
[  286.329480] generic/461	 [not run] btrfs does not support shutdown
[  286.329485]=20
[  286.350913] run fstests generic/463 at 2018-04-16 23:57:01
[  286.592926] generic/463	 0s
[  286.592929]=20
[  286.799078] BTRFS info (device sda5): disk space caching is enabled
[  286.806082] BTRFS info (device sda5): has skinny extents
[  286.889058] run fstests generic/464 at 2018-04-16 23:57:02
[  287.105754] BTRFS: device fsid d791f210-8187-4d8a-9c76-5e01a01d44f0 devi=
d 1 transid 5 /dev/sda6
[  287.222957] BTRFS info (device sda6): disk space caching is enabled
[  287.230029] BTRFS info (device sda6): has skinny extents
[  287.236090] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  287.245385] BTRFS info (device sda6): creating UUID tree
[  293.703817] BTRFS info (device sda6): disk space caching is enabled
[  293.710769] BTRFS info (device sda6): has skinny extents
[  300.794755] BTRFS info (device sda6): disk space caching is enabled
[  300.801789] BTRFS info (device sda6): has skinny extents
[  308.456926] BTRFS info (device sda6): disk space caching is enabled
[  308.463874] BTRFS info (device sda6): has skinny extents
[  315.814643] BTRFS info (device sda6): disk space caching is enabled
[  315.821614] BTRFS info (device sda6): has skinny extents
[  323.849187] BTRFS info (device sda6): disk space caching is enabled
[  323.856129] BTRFS info (device sda6): has skinny extents
[  332.226620] BTRFS info (device sda6): disk space caching is enabled
[  332.233522] BTRFS info (device sda6): has skinny extents
[  339.521815] BTRFS info (device sda6): disk space caching is enabled
[  339.528829] BTRFS info (device sda6): has skinny extents
[  346.722261] BTRFS info (device sda6): disk space caching is enabled
[  346.729208] BTRFS info (device sda6): has skinny extents
[  355.167033] BTRFS info (device sda6): disk space caching is enabled
[  355.173952] BTRFS info (device sda6): has skinny extents
[  361.834284] BTRFS info (device sda6): disk space caching is enabled
[  361.841240] BTRFS info (device sda6): has skinny extents
[  361.940586] generic/464	 75s
[  361.940591]=20
[  361.984297] run fstests generic/465 at 2018-04-16 23:58:17
[  373.104752] generic/465	 11s
[  373.104755]=20
[  373.136873] run fstests generic/466 at 2018-04-16 23:58:28
[  373.544531] BTRFS: device fsid d1c16bb7-563e-4db6-a043-22434c286c4e devi=
d 1 transid 5 /dev/sda6
[  373.564829] BTRFS info (device sda6): disk space caching is enabled
[  373.571675] BTRFS info (device sda6): has skinny extents
[  373.577561] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  373.587070] BTRFS info (device sda6): creating UUID tree
[  373.817953] BTRFS: device fsid 6bb5b12b-ea5c-4a2f-a717-d40ca0a3557f devi=
d 1 transid 5 /dev/sda6
[  373.833222] BTRFS info (device sda6): disk space caching is enabled
[  373.840104] BTRFS info (device sda6): has skinny extents
[  373.846030] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  373.855108] BTRFS info (device sda6): creating UUID tree
[  374.051272] BTRFS: device fsid c49a9ea6-8c5f-4a9e-a771-73b4542cd396 devi=
d 1 transid 5 /dev/sda6
[  374.066537] BTRFS info (device sda6): disk space caching is enabled
[  374.073704] BTRFS info (device sda6): has skinny extents
[  374.079878] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  374.089211] BTRFS info (device sda6): creating UUID tree
[  374.295550] BTRFS: device fsid 69bde0df-b8ec-4f9b-9324-71496fbbf659 devi=
d 1 transid 5 /dev/sda6
[  374.310295] BTRFS info (device sda6): disk space caching is enabled
[  374.317182] BTRFS info (device sda6): has skinny extents
[  374.323071] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  374.332218] BTRFS info (device sda6): creating UUID tree
[  374.463877] BTRFS info (device sda6): disk space caching is enabled
[  374.470818] BTRFS info (device sda6): has skinny extents
[  374.712384] BTRFS info (device sda6): disk space caching is enabled
[  374.719247] BTRFS info (device sda6): has skinny extents
[  374.884726] BTRFS: device fsid 7c4f6177-afc6-4e6f-9f4b-415081c41868 devi=
d 1 transid 5 /dev/sda6
[  374.900068] BTRFS info (device sda6): disk space caching is enabled
[  374.907004] BTRFS info (device sda6): has skinny extents
[  374.912943] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  374.922224] BTRFS info (device sda6): creating UUID tree
[  375.150999] BTRFS: device fsid 886c0d42-b84d-4749-8e91-2ab9cc8d50df devi=
d 1 transid 5 /dev/sda6
[  375.166878] BTRFS info (device sda6): disk space caching is enabled
[  375.173834] BTRFS info (device sda6): has skinny extents
[  375.179790] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  375.189024] BTRFS info (device sda6): creating UUID tree
[  375.395670] BTRFS: device fsid aab0d8c9-7db8-411b-8e6c-c53c3d6eb290 devi=
d 1 transid 5 /dev/sda6
[  375.411484] BTRFS info (device sda6): disk space caching is enabled
[  375.418402] BTRFS info (device sda6): has skinny extents
[  375.424343] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  375.433994] BTRFS info (device sda6): creating UUID tree
[  375.651063] BTRFS: device fsid 6dc44357-0735-47df-9ac6-894d785705e7 devi=
d 1 transid 5 /dev/sda6
[  375.666718] BTRFS info (device sda6): disk space caching is enabled
[  375.673647] BTRFS info (device sda6): has skinny extents
[  375.679600] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  375.688985] BTRFS info (device sda6): creating UUID tree
[  375.731757] generic/466	 3s
[  375.731761]=20
[  375.765820] run fstests generic/467 at 2018-04-16 23:58:31
[  376.180312] sh (8475): drop_caches: 3
[  376.287612] sh (8482): drop_caches: 3
[  376.477527] sh (8489): drop_caches: 3
[  376.624520] sh (8496): drop_caches: 3
[  376.740200] sh (8501): drop_caches: 3
[  376.913506] sh (8508): drop_caches: 3
[  377.028126] sh (8517): drop_caches: 3
[  377.158940] sh (8527): drop_caches: 3
[  377.178549] generic/467	 1s
[  377.178554]=20
[  377.333958] BTRFS info (device sda5): disk space caching is enabled
[  377.340889] BTRFS info (device sda5): has skinny extents
[  377.397996] run fstests generic/468 at 2018-04-16 23:58:32
[  377.907736] BTRFS: device fsid 199c5d20-cba8-4755-82f6-7219707ab45a devi=
d 1 transid 5 /dev/sda6
[  377.953461] BTRFS info (device sda6): disk space caching is enabled
[  377.960803] BTRFS info (device sda6): has skinny extents
[  377.967176] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  378.004726] BTRFS info (device sda6): creating UUID tree
[  378.071986] generic/468	 [not run] btrfs does not support shutdown
[  378.071989]=20
[  378.101314] run fstests generic/469 at 2018-04-16 23:58:33
[  378.473559] generic/469	 0s
[  378.473564]=20
[  378.632235] BTRFS info (device sda5): disk space caching is enabled
[  378.639107] BTRFS info (device sda5): has skinny extents
[  378.695634] run fstests generic/471 at 2018-04-16 23:58:34
[  378.871532] generic/471	 [not run] xfs_io pwrite failed (old kernel/wron=
g fs?)
[  378.871539]=20
[  378.892649] run fstests generic/472 at 2018-04-16 23:58:34
[  379.241332] BTRFS: device fsid dc3a7bd3-aba2-4a04-ba75-de37008d8c1e devi=
d 1 transid 5 /dev/sda6
[  379.256759] BTRFS info (device sda6): disk space caching is enabled
[  379.263670] BTRFS info (device sda6): has skinny extents
[  379.269588] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  379.279049] BTRFS info (device sda6): creating UUID tree
[  380.691097] generic/472	 - output mismatch (see /lkp/benchmarks/xfstests=
/results//generic/472.out.bad)
[  380.691103]=20
[  380.704834]     --- tests/generic/472.out	2018-03-28 13:46:17.000000000 =
+0800
[  380.704836]=20
[  380.716976]     +++ /lkp/benchmarks/xfstests/results//generic/472.out.ba=
d	2018-04-16 23:58:36.094904632 +0800
[  380.716977]=20
[  380.730045]     @@ -2,8 +2,9 @@
[  380.730046]=20
[  380.736480]      Reformat with 320M size
[  380.736482]=20
[  380.743631]      Fill the filesystem
[  380.743632]=20
[  380.750738]      pwrite: No space left on device
[  380.750740]=20
[  380.758830]     -pwrite wrote more than zero bytes.
[  380.758831]=20
[  380.768468]     -00000000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb=
 bb  ................
[  380.768470]=20
[  380.780545]     +pwrite: No space left on device
[  380.780546]=20
[  380.788510]     +pwrite wrote zero bytes
[  380.788511]=20
[  380.795342]     ...
[  380.795343]=20
[  380.803049]     (Run 'diff -u tests/generic/472.out /lkp/benchmarks/xfst=
ests/results//generic/472.out.bad'  to see the entire diff)
[  380.803051]=20
[  380.855590] BTRFS info (device sda6): disk space caching is enabled
[  380.862595] BTRFS info (device sda6): has skinny extents
[  380.918032] run fstests generic/473 at 2018-04-16 23:58:36
[  381.243330] generic/473	 0s
[  381.243335]=20
[  381.386871] BTRFS info (device sda5): disk space caching is enabled
[  381.393792] BTRFS info (device sda5): has skinny extents
[  381.451968] run fstests generic/474 at 2018-04-16 23:58:36
[  381.848899] BTRFS: device fsid b2ac8d46-7820-4805-8734-ab1e28a75161 devi=
d 1 transid 5 /dev/sda6
[  381.879812] BTRFS info (device sda6): disk space caching is enabled
[  381.886723] BTRFS info (device sda6): has skinny extents
[  381.892661] BTRFS info (device sda6): flagging fs with big metadata feat=
ure
[  381.957806] BTRFS info (device sda6): creating UUID tree
[  382.014621] generic/474	 [not run] btrfs does not support shutdown
[  382.014625]=20
[  382.043865] run fstests generic/475 at 2018-04-16 23:58:37
[  382.437822] BTRFS: device fsid 5e8181ff-6aa5-4feb-8e3a-39befa434dcc devi=
d 1 transid 5 /dev/sda6
[  382.607809] BTRFS info (device dm-0): disk space caching is enabled
[  382.614767] BTRFS info (device dm-0): has skinny extents
[  382.620717] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[  382.679994] BTRFS info (device dm-0): creating UUID tree
[  383.812328] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  383.818617] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  383.822426] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  383.822435] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 1, flush 0, corrupt 0, gen 0
[  383.822437] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  383.822440] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  383.822442] BTRFS info (device dm-0): forced readonly
[  383.822444] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  383.823018] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 2, flush 0, corrupt 0, gen 0
[  383.823025] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 3, flush 0, corrupt 0, gen 0
[  383.823057] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 3, flush 0, corrupt 0, gen 0
[  383.823062] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 3, flush 0, corrupt 0, gen 0
[  383.823064] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 3, flush 0, corrupt 0, gen 0
[  383.823071] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 3, flush 0, corrupt 0, gen 0
[  383.823077] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 3, flush 0, corrupt 0, gen 0
[  383.823083] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 3, flush 0, corrupt 0, gen 0
[  383.823664] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  383.823666] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  383.987702] BTRFS info (device dm-0): delayed_refs has NO entry
[  384.020763] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  384.064921] BTRFS info (device dm-0): disk space caching is enabled
[  384.071829] BTRFS info (device dm-0): has skinny extents
[  384.134538] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  384.144028] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  384.213913] BTRFS info (device dm-0): checking UUID tree
[  385.237233] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  385.243115] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  385.247360] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  385.265203] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  385.273699] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  385.285355] BTRFS info (device dm-0): forced readonly
[  385.291154] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  385.299308] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  385.308071] BTRFS info (device dm-0): delayed_refs has NO entry
[  385.337516] BTRFS error (device dm-0): pending csums is 8192
[  385.344154] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  385.389036] BTRFS info (device dm-0): disk space caching is enabled
[  385.396110] BTRFS info (device dm-0): has skinny extents
[  385.410842] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  387.437765] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  387.438778] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  387.459340] BTRFS info (device dm-0): forced readonly
[  387.465167] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  387.473335] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  387.482117] BTRFS info (device dm-0): delayed_refs has NO entry
[  387.488853] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  387.497055] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  387.505970] BTRFS info (device dm-0): delayed_refs has NO entry
[  387.542232] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  387.584320] BTRFS info (device dm-0): disk space caching is enabled
[  387.591516] BTRFS info (device dm-0): has skinny extents
[  387.643493] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  387.653269] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  387.731501] BTRFS info (device dm-0): checking UUID tree
[  388.780759] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  388.788289] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  388.791191] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  388.809195] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  388.817997] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  388.829550] BTRFS info (device dm-0): forced readonly
[  388.835470] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  388.843759] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  388.852630] BTRFS info (device dm-0): delayed_refs has NO entry
[  388.859542] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  388.867829] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  388.876819] BTRFS info (device dm-0): delayed_refs has NO entry
[  388.900874] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  388.961298] BTRFS info (device dm-0): disk space caching is enabled
[  388.968510] BTRFS info (device dm-0): has skinny extents
[  389.010728] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  389.020687] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  389.085642] BTRFS info (device dm-0): checking UUID tree
[  389.109972] btrfs_dev_stat_print_on_error: 143 callbacks suppressed
[  389.117123] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  389.118175] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  389.127991] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 1, flush 0, corrupt 0, gen 0
[  389.128145] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 2, flush 0, corrupt 0, gen 0
[  389.128192] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 3, flush 0, corrupt 0, gen 0
[  389.128218] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 4, flush 0, corrupt 0, gen 0
[  389.128264] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 5, flush 0, corrupt 0, gen 0
[  389.128280] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 6, flush 0, corrupt 0, gen 0
[  389.128288] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 7, flush 0, corrupt 0, gen 0
[  389.128301] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 8, flush 0, corrupt 0, gen 0
[  389.128308] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 9, flush 0, corrupt 0, gen 0
[  389.129825] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  389.129826] BTRFS info (device dm-0): forced readonly
[  389.129827] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  389.129828] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  389.129829] BTRFS info (device dm-0): delayed_refs has NO entry
[  389.312855] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  389.372059] BTRFS info (device dm-0): disk space caching is enabled
[  389.379931] BTRFS info (device dm-0): has skinny extents
[  389.413720] BTRFS info (device dm-0): checking UUID tree
[  391.491576] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  391.498094] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  391.502025] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  391.520004] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  391.528826] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  391.540167] BTRFS info (device dm-0): forced readonly
[  391.546008] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  391.554211] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  391.562996] BTRFS info (device dm-0): delayed_refs has NO entry
[  391.569740] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  391.577913] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  391.586757] BTRFS info (device dm-0): delayed_refs has NO entry
[  391.619876] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  391.663300] BTRFS info (device dm-0): disk space caching is enabled
[  391.671034] BTRFS info (device dm-0): has skinny extents
[  391.721170] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  391.731071] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  391.786952] BTRFS info (device dm-0): checking UUID tree
[  391.836130] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  391.836428] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  391.857709] BTRFS info (device dm-0): forced readonly
[  391.863558] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  391.871726] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  391.880530] BTRFS info (device dm-0): delayed_refs has NO entry
[  391.887269] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  391.895482] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  391.904360] BTRFS info (device dm-0): delayed_refs has NO entry
[  391.932544] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  391.973388] BTRFS info (device dm-0): disk space caching is enabled
[  391.980510] BTRFS info (device dm-0): has skinny extents
[  392.036306] BTRFS info (device dm-0): checking UUID tree
[  393.101633] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  393.103163] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  393.123409] BTRFS info (device dm-0): forced readonly
[  393.129307] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  393.137575] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  393.146430] BTRFS info (device dm-0): delayed_refs has NO entry
[  393.153235] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  393.161495] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  393.170426] BTRFS info (device dm-0): delayed_refs has NO entry
[  393.195933] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  393.261084] BTRFS info (device dm-0): disk space caching is enabled
[  393.268258] BTRFS info (device dm-0): has skinny extents
[  393.315596] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  393.324886] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  394.372542] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  394.377524] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  394.383302] btrfs_dev_stat_print_on_error: 97 callbacks suppressed
[  394.383305] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  394.409656] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  394.419486] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  394.430372] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  394.430374] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 1, flush 0, corrupt 0, gen 0
[  394.430379] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 1, flush 0, corrupt 0, gen 0
[  394.438980] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  394.455905] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 1, flush 0, corrupt 0, gen 0
[  394.460700] BTRFS info (device dm-0): forced readonly
[  394.460702] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  394.460704] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  394.460705] BTRFS info (device dm-0): delayed_refs has NO entry
[  394.513114] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 1, flush 0, corrupt 0, gen 0
[  394.524940] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 1, flush 0, corrupt 0, gen 0
[  394.536189] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 1, flush 0, corrupt 0, gen 0
[  394.547428] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 8, rd 1, flush 0, corrupt 0, gen 0
[  394.558422] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 9, rd 1, flush 0, corrupt 0, gen 0
[  394.569448] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  394.582788] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  394.591042] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  394.599890] BTRFS info (device dm-0): delayed_refs has NO entry
[  394.633345] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  394.678491] BTRFS info (device dm-0): disk space caching is enabled
[  394.685880] BTRFS info (device dm-0): has skinny extents
[  395.724434] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  395.727189] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  395.734390] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  395.751300] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  395.762658] BTRFS info (device dm-0): forced readonly
[  395.768552] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  395.777010] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  395.785271] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  395.818231] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  395.858664] BTRFS info (device dm-0): disk space caching is enabled
[  395.866032] BTRFS info (device dm-0): has skinny extents
[  395.922894] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  395.974640] BTRFS info (device dm-0): checking UUID tree
[  396.016927] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  396.017334] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  396.038714] BTRFS info (device dm-0): forced readonly
[  396.044617] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  396.052868] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  396.061786] BTRFS info (device dm-0): delayed_refs has NO entry
[  396.068577] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  396.076824] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  396.085758] BTRFS info (device dm-0): delayed_refs has NO entry
[  396.115044] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  396.160015] BTRFS info (device dm-0): disk space caching is enabled
[  396.167086] BTRFS info (device dm-0): has skinny extents
[  396.175964] BTRFS info (device dm-0): checking UUID tree
[  396.218750] BTRFS error (device dm-0): error reading free space cache
[  396.221121] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  396.226016] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  396.248525] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  396.261885] BTRFS info (device dm-0): forced readonly
[  396.267757] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  396.275985] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  396.284798] BTRFS info (device dm-0): delayed_refs has NO entry
[  396.326328] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  396.382480] BTRFS info (device dm-0): disk space caching is enabled
[  396.389594] BTRFS info (device dm-0): has skinny extents
[  396.402601] BTRFS info (device dm-0): checking UUID tree
[  397.445555] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  397.450574] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  397.456174] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  397.474243] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  397.482903] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  397.494452] BTRFS info (device dm-0): forced readonly
[  397.500359] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  397.508614] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  397.517474] BTRFS info (device dm-0): delayed_refs has NO entry
[  397.524298] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  397.532575] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  397.541484] BTRFS info (device dm-0): delayed_refs has NO entry
[  397.579682] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  397.628532] BTRFS info (device dm-0): disk space caching is enabled
[  397.635742] BTRFS info (device dm-0): has skinny extents
[  397.719081] BTRFS info (device dm-0): checking UUID tree
[  398.770621] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  398.778196] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  398.781309] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  398.799440] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  398.808055] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  398.819414] BTRFS info (device dm-0): forced readonly
[  398.825287] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  398.833507] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  398.842356] BTRFS info (device dm-0): delayed_refs has NO entry
[  398.849151] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  398.857429] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  398.866352] BTRFS info (device dm-0): delayed_refs has NO entry
[  398.893580] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  398.949763] BTRFS info (device dm-0): disk space caching is enabled
[  398.956915] BTRFS info (device dm-0): has skinny extents
[  399.001325] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  399.011133] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  399.141315] BTRFS info (device dm-0): checking UUID tree
[  400.169391] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  400.180135] btrfs_dev_stat_print_on_error: 162 callbacks suppressed
[  400.180138] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  400.181920] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  400.187245] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  400.215053] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  400.226463] BTRFS info (device dm-0): forced readonly
[  400.232374] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  400.240834] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 1, flush 0, corrupt 0, gen 0
[  400.241970] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  400.251717] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 1, flush 0, corrupt 0, gen 0
[  400.260006] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  400.279876] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 1, flush 0, corrupt 0, gen 0
[  400.324904] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  400.366105] BTRFS info (device dm-0): disk space caching is enabled
[  400.373304] BTRFS info (device dm-0): has skinny extents
[  402.447198] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  402.451890] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  402.459152] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  402.478754] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 0, flush 0, corrupt 0, gen 0
[  402.489698] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 0, flush 0, corrupt 0, gen 0
[  402.500720] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 0, flush 0, corrupt 0, gen 0
[  402.511692] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 0, flush 0, corrupt 0, gen 0
[  402.522731] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  402.536200] BTRFS info (device dm-0): forced readonly
[  402.542169] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  402.550446] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  402.559344] BTRFS info (device dm-0): delayed_refs has NO entry
[  402.566216] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  402.574529] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  402.583492] BTRFS info (device dm-0): delayed_refs has NO entry
[  402.613501] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  402.657401] BTRFS info (device dm-0): disk space caching is enabled
[  402.664674] BTRFS info (device dm-0): has skinny extents
[  402.729091] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  404.729552] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  404.730497] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  404.751403] BTRFS info (device dm-0): forced readonly
[  404.757333] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  404.765609] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  404.774524] BTRFS info (device dm-0): delayed_refs has NO entry
[  404.781366] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  404.789790] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  404.798867] BTRFS info (device dm-0): delayed_refs has NO entry
[  404.833570] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  404.879918] BTRFS info (device dm-0): disk space caching is enabled
[  404.887116] BTRFS info (device dm-0): has skinny extents
[  404.943305] BTRFS error (device dm-0): error reading free space cache
[  404.944578] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  404.950584] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  404.952785] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  404.983857] BTRFS info (device dm-0): forced readonly
[  404.989764] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  404.998016] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  405.006844] BTRFS info (device dm-0): delayed_refs has NO entry
[  405.032304] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  405.081441] BTRFS info (device dm-0): disk space caching is enabled
[  405.088679] BTRFS info (device dm-0): has skinny extents
[  407.230073] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  407.237319] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  407.240628] btrfs_dev_stat_print_on_error: 140 callbacks suppressed
[  407.240631] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  407.266780] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  407.276566] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  407.287401] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  407.287403] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 0, flush 0, corrupt 0, gen 0
[  407.307080] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  407.318483] BTRFS info (device dm-0): forced readonly
[  407.324402] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  407.324597] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 0, flush 0, corrupt 0, gen 0
[  407.332672] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  407.343836] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 0, flush 0, corrupt 0, gen 0
[  407.352424] BTRFS info (device dm-0): delayed_refs has NO entry
[  407.370240] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 0, flush 0, corrupt 0, gen 0
[  407.381169] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 0, flush 0, corrupt 0, gen 0
[  407.393486] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 8, rd 0, flush 0, corrupt 0, gen 0
[  407.404746] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 9, rd 0, flush 0, corrupt 0, gen 0
[  407.416032] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 10, rd 0, flush 0, corrupt 0, gen 0
[  407.427440] BTRFS info (device dm-0): delayed_refs has NO entry
[  407.457152] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  407.501072] BTRFS info (device dm-0): disk space caching is enabled
[  407.509056] BTRFS info (device dm-0): has skinny extents
[  407.564582] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  407.620318] BTRFS info (device dm-0): checking UUID tree
[  407.694982] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  407.696758] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  407.716735] BTRFS info (device dm-0): forced readonly
[  407.722656] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  407.730905] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  407.739778] BTRFS info (device dm-0): delayed_refs has NO entry
[  407.746657] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  407.755210] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  407.764341] BTRFS info (device dm-0): delayed_refs has NO entry
[  407.793571] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  407.835909] BTRFS info (device dm-0): disk space caching is enabled
[  407.843274] BTRFS info (device dm-0): has skinny extents
[  407.852272] BTRFS info (device dm-0): checking UUID tree
[  407.873227] BTRFS error (device dm-0): error reading free space cache
[  407.874917] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  407.880510] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  408.421000] BTRFS: error (device dm-0) in __btrfs_free_extent:6962: errn=
o=3D-5 IO failure
[  408.429871] BTRFS info (device dm-0): forced readonly
[  408.435765] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:3070: e=
rrno=3D-5 IO failure
[  408.444905] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  408.453178] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  408.462111] BTRFS error (device dm-0): pending csums is 45056
[  408.493213] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  408.536566] BTRFS info (device dm-0): disk space caching is enabled
[  408.543744] BTRFS info (device dm-0): has skinny extents
[  408.553483] BTRFS info (device dm-0): checking UUID tree
[  408.578561] BTRFS error (device dm-0): error reading free space cache
[  408.579586] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  408.585795] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  408.607782] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  408.621097] BTRFS info (device dm-0): forced readonly
[  408.626941] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  408.635179] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  408.643996] BTRFS info (device dm-0): delayed_refs has NO entry
[  408.677222] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  408.726995] BTRFS info (device dm-0): disk space caching is enabled
[  408.734093] BTRFS info (device dm-0): has skinny extents
[  408.791428] BTRFS info (device dm-0): checking UUID tree
[  410.966837] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  410.975871] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  410.977861] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  410.984907] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  411.000204] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  411.010797] BTRFS info (device dm-0): forced readonly
[  411.015879] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  411.023324] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  411.031367] BTRFS info (device dm-0): delayed_refs has NO entry
[  411.037406] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  411.044853] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  411.077347] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  411.126722] BTRFS info (device dm-0): disk space caching is enabled
[  411.133048] BTRFS info (device dm-0): has skinny extents
[  412.210090] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  412.217351] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  412.219118] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  412.235624] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  412.243409] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  412.253954] BTRFS info (device dm-0): forced readonly
[  412.259078] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  412.266529] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  412.274574] BTRFS info (device dm-0): delayed_refs has NO entry
[  412.280575] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  412.288034] BTRFS warning (device dm-0): cleanup_transaction:1854: Abort=
ing unused transaction(IO failure).
[  412.297899] BTRFS info (device dm-0): delayed_refs has NO entry
[  412.327380] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  412.382991] BTRFS info (device dm-0): disk space caching is enabled
[  412.389324] BTRFS info (device dm-0): has skinny extents
[  412.438406] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  412.497039] BTRFS info (device dm-0): checking UUID tree
[  414.519437] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  414.524721] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  414.528464] btrfs_dev_stat_print_on_error: 194 callbacks suppressed
[  414.528467] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  414.552332] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  414.561332] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  414.571411] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  414.571413] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 0, flush 0, corrupt 0, gen 0
[  414.571421] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 0, flush 0, corrupt 0, gen 0
[  414.579190] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  414.609846] BTRFS info (device dm-0): forced readonly
[  414.614924] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  414.615161] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 0, flush 0, corrupt 0, gen 0
[  414.622356] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  414.632415] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 0, flush 0, corrupt 0, gen 0
[  414.641309] BTRFS info (device dm-0): delayed_refs has NO entry
[  414.659157] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 0, flush 0, corrupt 0, gen 0
[  414.670092] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 8, rd 0, flush 0, corrupt 0, gen 0
[  414.681587] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 9, rd 0, flush 0, corrupt 0, gen 0
[  414.692912] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 10, rd 0, flush 0, corrupt 0, gen 0
[  414.705427] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  414.718932] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  414.727228] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  414.736144] BTRFS info (device dm-0): delayed_refs has NO entry
[  414.764986] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  414.816795] BTRFS info (device dm-0): disk space caching is enabled
[  414.898481] BTRFS info (device dm-0): checking UUID tree
[  415.928181] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  415.941467] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  415.954964] BTRFS info (device dm-0): forced readonly
[  415.960904] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  415.969195] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  415.978061] BTRFS info (device dm-0): delayed_refs has NO entry
[  416.004629] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  416.161340] BTRFS info (device dm-0): disk space caching is enabled
[  416.168774] BTRFS info (device dm-0): has skinny extents
[  418.411031] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  418.418334] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  418.420857] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  418.439103] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  418.447874] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  418.459404] BTRFS info (device dm-0): forced readonly
[  418.465364] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  418.473654] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  418.482545] BTRFS info (device dm-0): delayed_refs has NO entry
[  418.489373] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  418.497692] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  418.506662] BTRFS info (device dm-0): delayed_refs has NO entry
[  418.538070] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  418.592589] BTRFS info (device dm-0): disk space caching is enabled
[  418.600527] BTRFS info (device dm-0): has skinny extents
[  418.649445] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  418.719878] BTRFS info (device dm-0): checking UUID tree
[  419.756089] btrfs_dev_stat_print_on_error: 39 callbacks suppressed
[  419.756094] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  419.761225] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  419.764006] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  419.795341] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 0, flush 0, corrupt 0, gen 0
[  419.806368] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 0, flush 0, corrupt 0, gen 0
[  419.817380] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 0, flush 0, corrupt 0, gen 0
[  419.828312] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 0, flush 0, corrupt 0, gen 0
[  419.839132] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 0, flush 0, corrupt 0, gen 0
[  419.850130] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 8, rd 0, flush 0, corrupt 0, gen 0
[  419.860924] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 9, rd 0, flush 0, corrupt 0, gen 0
[  419.871777] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 10, rd 0, flush 0, corrupt 0, gen 0
[  419.882847] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  419.896100] BTRFS info (device dm-0): forced readonly
[  419.901902] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  419.910088] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  419.918855] BTRFS info (device dm-0): delayed_refs has NO entry
[  419.947510] BTRFS error (device dm-0): pending csums is 1253376
[  419.954420] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  420.017030] BTRFS info (device dm-0): disk space caching is enabled
[  420.024142] BTRFS info (device dm-0): has skinny extents
[  420.131486] BTRFS info (device dm-0): checking UUID tree
[  421.219274] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  421.222565] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  421.229677] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  421.247571] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  421.256069] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  421.267350] BTRFS info (device dm-0): forced readonly
[  421.273165] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  421.281325] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  421.290088] BTRFS info (device dm-0): delayed_refs has NO entry
[  421.296804] BTRFS error (device dm-0): pending csums is 1187840
[  421.327028] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  421.383483] BTRFS info (device dm-0): disk space caching is enabled
[  421.390556] BTRFS info (device dm-0): has skinny extents
[  421.437198] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  422.500570] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  422.505280] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  422.510758] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  422.528641] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  422.537140] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  422.548429] BTRFS info (device dm-0): forced readonly
[  422.554255] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  422.562398] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  422.571174] BTRFS info (device dm-0): delayed_refs has NO entry
[  422.577880] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  422.586056] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  422.594901] BTRFS info (device dm-0): delayed_refs has NO entry
[  422.625182] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  422.671926] BTRFS info (device dm-0): disk space caching is enabled
[  422.679739] BTRFS info (device dm-0): has skinny extents
[  422.731459] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  422.741114] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  423.730925] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  423.733394] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  423.744390] BTRFS info (device dm-0): forced readonly
[  423.758612] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  423.766863] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  423.775720] BTRFS info (device dm-0): delayed_refs has NO entry
[  423.782538] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  423.790801] BTRFS warning (device dm-0): cleanup_transaction:1854: Abort=
ing unused transaction(IO failure).
[  423.801411] BTRFS info (device dm-0): delayed_refs has NO entry
[  423.836587] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  423.882813] BTRFS info (device dm-0): disk space caching is enabled
[  423.889865] BTRFS info (device dm-0): has skinny extents
[  424.141763] BTRFS info (device dm-0): checking UUID tree
[  424.171261] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  424.173046] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  424.181103] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  424.198040] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  424.209414] BTRFS info (device dm-0): forced readonly
[  424.215314] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  424.223796] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  424.232058] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  424.241104] BTRFS error (device dm-0): pending csums is 1282048
[  424.269290] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  424.326272] BTRFS info (device dm-0): disk space caching is enabled
[  424.334288] BTRFS info (device dm-0): has skinny extents
[  424.449634] BTRFS info (device dm-0): checking UUID tree
[  425.487113] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  425.697283] btrfs_dev_stat_print_on_error: 91 callbacks suppressed
[  425.697285] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  425.715172] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  425.726069] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 0, flush 0, corrupt 0, gen 0
[  425.736953] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 0, flush 0, corrupt 0, gen 0
[  425.747818] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 0, flush 0, corrupt 0, gen 0
[  425.758640] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 0, flush 0, corrupt 0, gen 0
[  425.769519] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 0, flush 0, corrupt 0, gen 0
[  425.780297] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 8, rd 0, flush 0, corrupt 0, gen 0
[  425.791145] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 9, rd 0, flush 0, corrupt 0, gen 0
[  425.801883] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 10, rd 0, flush 0, corrupt 0, gen 0
[  425.814963] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  425.828191] BTRFS info (device dm-0): forced readonly
[  425.833950] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  425.842084] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  425.850815] BTRFS info (device dm-0): delayed_refs has NO entry
[  425.881808] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  425.927072] BTRFS info (device dm-0): disk space caching is enabled
[  427.536804] BTRFS error (device dm-0): error reading free space cache
[  427.543945] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  427.557717] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  427.570874] BTRFS info (device dm-0): forced readonly
[  427.576652] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  427.584789] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  427.593525] BTRFS info (device dm-0): delayed_refs has NO entry
[  427.617207] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  427.659886] BTRFS info (device dm-0): disk space caching is enabled
[  427.666922] BTRFS info (device dm-0): has skinny extents
[  427.697015] BTRFS error (device dm-0): error reading free space cache
[  427.698741] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  427.704184] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  427.726013] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  427.739236] BTRFS info (device dm-0): forced readonly
[  427.745011] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  427.753147] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  427.761869] BTRFS info (device dm-0): delayed_refs has NO entry
[  427.799240] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  427.842066] BTRFS info (device dm-0): disk space caching is enabled
[  427.849072] BTRFS info (device dm-0): has skinny extents
[  429.945090] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  429.949185] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  429.955255] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  429.973186] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  429.981736] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  429.993040] BTRFS info (device dm-0): forced readonly
[  429.998846] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  430.007031] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  430.015822] BTRFS info (device dm-0): delayed_refs has NO entry
[  430.022617] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  430.030867] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  430.039851] BTRFS info (device dm-0): delayed_refs has NO entry
[  430.071946] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  430.128095] BTRFS info (device dm-0): disk space caching is enabled
[  430.135306] BTRFS info (device dm-0): has skinny extents
[  430.254433] BTRFS info (device dm-0): checking UUID tree
[  432.336356] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  432.347067] btrfs_dev_stat_print_on_error: 283 callbacks suppressed
[  432.347070] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  432.348887] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  432.354176] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  432.383299] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  432.394209] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  432.402860] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  432.414285] BTRFS info (device dm-0): forced readonly
[  432.420236] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  432.420900] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 0, flush 0, corrupt 0, gen 0
[  432.428513] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  432.428515] BTRFS info (device dm-0): delayed_refs has NO entry
[  432.428522] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 4, rd 0, flush 0, corrupt 0, gen 0
[  432.440046] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 0, flush 0, corrupt 0, gen 0
[  432.448300] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 0, flush 0, corrupt 0, gen 0
[  432.455663] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 0, flush 0, corrupt 0, gen 0
[  432.498791] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 8, rd 0, flush 0, corrupt 0, gen 0
[  432.509676] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 9, rd 0, flush 0, corrupt 0, gen 0
[  432.520690] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 10, rd 0, flush 0, corrupt 0, gen 0
[  432.531949] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  432.545360] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  432.553604] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  432.562459] BTRFS info (device dm-0): delayed_refs has NO entry
[  432.593102] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  432.649447] BTRFS info (device dm-0): disk space caching is enabled
[  432.656602] BTRFS info (device dm-0): has skinny extents
[  432.688079] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  432.697413] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  433.702149] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  433.750121] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  433.763591] BTRFS info (device dm-0): forced readonly
[  433.769492] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  433.777755] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  433.786645] BTRFS info (device dm-0): delayed_refs has NO entry
[  433.811584] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  433.860604] BTRFS info (device dm-0): disk space caching is enabled
[  433.867775] BTRFS info (device dm-0): has skinny extents
[  433.918658] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  433.928813] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  434.037350] BTRFS info (device dm-0): checking UUID tree
[  435.232434] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  435.242791] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  435.244494] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  435.252811] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  435.269610] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  435.280928] BTRFS info (device dm-0): forced readonly
[  435.286832] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  435.295119] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  435.303949] BTRFS info (device dm-0): delayed_refs has NO entry
[  435.310760] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  435.319007] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  435.355186] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  435.405507] BTRFS info (device dm-0): disk space caching is enabled
[  435.412557] BTRFS info (device dm-0): has skinny extents
[  435.593008] BTRFS info (device dm-0): checking UUID tree
[  435.640574] BTRFS: error (device dm-0) in __btrfs_free_extent:6962: errn=
o=3D-5 IO failure
[  435.641940] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  435.649371] BTRFS info (device dm-0): forced readonly
[  435.663456] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:3070: e=
rrno=3D-5 IO failure
[  435.672661] BTRFS error (device dm-0): pending csums is 2891776
[  435.703655] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  435.760253] BTRFS info (device dm-0): disk space caching is enabled
[  435.768149] BTRFS info (device dm-0): has skinny extents
[  435.777312] BTRFS info (device dm-0): checking UUID tree
[  435.802580] BTRFS: error (device dm-0) in __btrfs_free_extent:6962: errn=
o=3D-5 IO failure
[  435.803004] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  435.811435] BTRFS info (device dm-0): forced readonly
[  435.825594] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:3070: e=
rrno=3D-5 IO failure
[  435.834699] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  435.842920] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  435.852420] BTRFS error (device dm-0): pending csums is 262144
[  435.883842] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  435.923082] BTRFS info (device dm-0): disk space caching is enabled
[  435.930163] BTRFS info (device dm-0): has skinny extents
[  435.940069] BTRFS info (device dm-0): checking UUID tree
[  435.962701] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  435.964586] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  435.972538] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  435.989332] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  436.000657] BTRFS info (device dm-0): forced readonly
[  436.006505] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  436.569237] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  436.612556] BTRFS info (device dm-0): disk space caching is enabled
[  436.619660] BTRFS info (device dm-0): has skinny extents
[  436.629188] BTRFS info (device dm-0): checking UUID tree
[  437.786332] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  437.792887] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  437.796675] btrfs_dev_stat_print_on_error: 398 callbacks suppressed
[  437.796678] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  437.822792] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  437.822793] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  437.822819] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 3, rd 0, flush 0, corrupt 0, gen 0
[  437.831351] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  437.864251] BTRFS info (device dm-0): forced readonly
[  437.870079] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  437.878527] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  437.886734] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  437.895669] BTRFS info (device dm-0): delayed_refs has NO entry
[  437.921430] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  437.965629] BTRFS info (device dm-0): disk space caching is enabled
[  437.972961] BTRFS info (device dm-0): has skinny extents
[  438.151735] BTRFS info (device dm-0): checking UUID tree
[  438.199479] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  438.204097] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  438.209244] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  438.228322] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  438.228323] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 1, flush 0, corrupt 0, gen 0
[  438.228328] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 2, flush 0, corrupt 0, gen 0
[  438.228599] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 2, flush 0, corrupt 0, gen 0
[  438.236853] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  438.236855] BTRFS info (device dm-0): forced readonly
[  438.247706] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 3, flush 0, corrupt 0, gen 0
[  438.258459] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  438.305705] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 4, flush 0, corrupt 0, gen 0
[  438.316619] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 5, flush 0, corrupt 0, gen 0
[  438.327552] BTRFS: error (device dm-0) in __btrfs_free_extent:6962: errn=
o=3D-5 IO failure
[  438.336415] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:3070: e=
rrno=3D-5 IO failure
[  438.345590] BTRFS error (device dm-0): pending csums is 1028096
[  438.369254] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  438.377674] BTRFS info (device dm-0): at unmount delalloc count 98304
[  438.385166] WARNING: CPU: 1 PID: 14674 at fs/btrfs/disk-io.c:3675 free_f=
s_root+0xc2/0xd0 [btrfs]
[  438.396562] Modules linked in: dm_snapshot dm_thin_pool dm_persistent_da=
ta dm_bio_prison dm_bufio dm_flakey dm_mod netconsole btrfs xor zstd_decomp=
ress zstd_compress xxhash raid6_pq sd_mod sg snd_hda_codec_hdmi snd_hda_cod=
ec_realtek snd_hda_codec_generic ata_generic pata_acpi intel_rapl x86_pkg_t=
emp_thermal intel_powerclamp coretemp snd_hda_intel kvm_intel snd_hda_codec=
 kvm irqbypass crct10dif_pclmul eeepc_wmi crc32_pclmul crc32c_intel ghash_c=
lmulni_intel pata_via asus_wmi sparse_keymap snd_hda_core ata_piix snd_hwde=
p ppdev rfkill wmi_bmof i915 pcbc snd_pcm snd_timer drm_kms_helper syscopya=
rea sysfillrect sysimgblt fb_sys_fops snd aesni_intel parport_pc crypto_sim=
d pcspkr libata soundcore cryptd glue_helper drm wmi parport video shpchp i=
p_tables
[  438.467607] CPU: 1 PID: 14674 Comm: umount Not tainted 4.17.0-rc1 #1
[  438.474798] Hardware name: System manufacturer System Product Name/P8H67=
-M PRO, BIOS 1002 04/01/2011
[  438.484804] RIP: 0010:free_fs_root+0xc2/0xd0 [btrfs]
[  438.490590] RSP: 0018:ffffc90008b0fda8 EFLAGS: 00010282
[  438.496641] RAX: ffff88017c5954b0 RBX: ffff880137f6d800 RCX: 00000001801=
00003
[  438.504652] RDX: 0000000000000001 RSI: ffffea0006e93600 RDI: 00000000000=
00000
[  438.512679] RBP: ffff88017b360000 R08: ffff8801ba4dd000 R09: 00000001801=
00003
[  438.520644] R10: ffffc90008b0fc70 R11: 0000000000000000 R12: ffffc90008b=
0fdd0
[  438.528657] R13: ffff88017b360080 R14: ffffc90008b0fdc8 R15: 00000000000=
00000
[  438.536662] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfa80000(0000) knlGS:=
0000000000000000
[  438.545582] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.552157] CR2: 00007f06c12b0260 CR3: 000000017d3de004 CR4: 00000000000=
606e0
[  438.642653] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c13=
59cf7
[  438.793559] CPU: 1 PID: 14674 Comm: umount Tainted: G        W         4=
=2E17.0-rc1 #1
[  438.802152] Hardware name: System manufacturer System Product Name/P8H67=
-M PRO, BIOS 1002 04/01/2011
[  438.812108] RIP: 0010:btrfs_put_block_group+0x41/0x60 [btrfs]
[  438.819364] RSP: 0018:ffffc90008b0fde0 EFLAGS: 00010206
[  438.825378] RAX: 0000000000000000 RBX: ffff8801abf63000 RCX: e38e38e38e3=
8e38f
[  438.833307] RDX: 0000000000000001 RSI: 00000000000009f6 RDI: ffff8801abf=
63000
[  438.841230] RBP: ffff88017b360000 R08: ffff88017d3b7750 R09: 00000001803=
80010
[  438.849133] R10: ffffc90008b0fca0 R11: 0000000000000000 R12: ffff8801abf=
63000
[  438.857047] R13: ffff88017b3600a0 R14: ffff8801abf630e0 R15: dead0000000=
00100
[  438.864943] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfa80000(0000) knlGS:=
0000000000000000
[  438.873793] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.880320] CR2: 00007f06c12b0260 CR3: 000000017d3de004 CR4: 00000000000=
606e0
[  438.888226] Call Trace:
[  438.891454]  btrfs_free_block_groups+0x138/0x3d0 [btrfs]
[  438.897569]  close_ctree+0x13b/0x2f0 [btrfs]
[  438.902618]  generic_shutdown_super+0x6c/0x120
[  438.907801]  kill_anon_super+0xe/0x20
[  438.912223]  btrfs_kill_super+0x13/0x100 [btrfs]
[  438.917598]  deactivate_locked_super+0x3f/0x70
[  438.922757]  cleanup_mnt+0x3b/0x70
[  438.926879]  task_work_run+0xa3/0xe0
[  438.931205]  exit_to_usermode_loop+0x9e/0xa0
[  438.936226]  do_syscall_64+0x16c/0x180
[  438.940717]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  438.946507] RIP: 0033:0x7f06c1359cf7
[  438.950798] RSP: 002b:00007ffc6a59c608 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6
[  438.959137] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c13=
59cf7
[  438.967056] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000023=
4a4b0
[  438.974937] RBP: 000000000234a4b0 R08: 0000000000000005 R09: 00000000023=
4b510
[  438.982801] R10: 00000000000006f4 R11: 0000000000000246 R12: 00007f06c18=
65e44
[  438.990695] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc6a5=
9c890
[  438.998600] Code: 2a 48 8b 83 e8 01 00 00 48 85 c0 75 2c 48 8b bb d8 00 =
00 00 e8 c1 1e b8 e0 48 89 df 5b e9 b8 1e b8 e0 0f 0b 48 83 7b 50 00 74 d6 =
<0f> 0b 48 8b 83 e8 01 00 00 48 85 c0 74 d4 0f 0b eb d0 0f 1f 00=20
[  439.019082] ---[ end trace 9263ab2c46fd437a ]---
[  439.030057] WARNING: CPU: 2 PID: 14674 at fs/btrfs/extent-tree.c:9898 bt=
rfs_free_block_groups+0x2a2/0x3d0 [btrfs]
[  439.044178] Modules linked in: dm_snapshot dm_thin_pool dm_persistent_da=
ta dm_bio_prison dm_bufio dm_flakey dm_mod netconsole btrfs xor zstd_decomp=
ress zstd_compress xxhash raid6_pq sd_mod sg snd_hda_codec_hdmi snd_hda_cod=
ec_realtek snd_hda_codec_generic ata_generic pata_acpi intel_rapl x86_pkg_t=
emp_thermal intel_powerclamp coretemp snd_hda_intel kvm_intel snd_hda_codec=
 kvm irqbypass crct10dif_pclmul eeepc_wmi crc32_pclmul crc32c_intel ghash_c=
lmulni_intel pata_via asus_wmi sparse_keymap snd_hda_core ata_piix snd_hwde=
p ppdev rfkill wmi_bmof i915 pcbc snd_pcm snd_timer drm_kms_helper syscopya=
rea sysfillrect sysimgblt fb_sys_fops snd aesni_intel parport_pc crypto_sim=
d pcspkr libata soundcore cryptd glue_helper drm wmi parport video shpchp i=
p_tables
[  439.116243] CPU: 2 PID: 14674 Comm: umount Tainted: G        W         4=
=2E17.0-rc1 #1
[  439.124990] Hardware name: System manufacturer System Product Name/P8H67=
-M PRO, BIOS 1002 04/01/2011
[  439.135133] RIP: 0010:btrfs_free_block_groups+0x2a2/0x3d0 [btrfs]
[  439.142218] RSP: 0018:ffffc90008b0fdf0 EFLAGS: 00010206
[  439.148415] RAX: ffff88017a675a88 RBX: ffff88017a675a88 RCX: 00000000000=
00001
[  439.156513] RDX: 0000000000000001 RSI: ffff88017b36cb10 RDI: ffff88017a6=
75e00
[  439.164603] RBP: ffff88017b360000 R08: 0000000000000000 R09: ffff88017a6=
75ea8
[  439.172675] R10: 0000000000000002 R11: ffff88017a675eb8 R12: ffff8801abf=
61c00
[  439.180737] R13: ffff88017b3600a0 R14: 0000000000000000 R15: dead0000000=
00100
[  439.188805] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfb00000(0000) knlGS:=
0000000000000000
[  439.197825] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.204507] CR2: 00007fb6b66729f4 CR3: 000000017d3de005 CR4: 00000000000=
606e0
[  439.212582] Call Trace:
[  439.215985]  close_ctree+0x13b/0x2f0 [btrfs]
[  439.221199]  generic_shutdown_super+0x6c/0x120
[  439.226573]  kill_anon_super+0xe/0x20
[  439.231160]  btrfs_kill_super+0x13/0x100 [btrfs]
[  439.237730]  deactivate_locked_super+0x3f/0x70
[  439.243079]  cleanup_mnt+0x3b/0x70
[  439.247382]  task_work_run+0xa3/0xe0
[  439.251849]  exit_to_usermode_loop+0x9e/0xa0
[  439.257015]  do_syscall_64+0x16c/0x180
[  439.261659]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  439.267606] RIP: 0033:0x7f06c1359cf7
[  439.272077] RSP: 002b:00007ffc6a59c608 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6
[  439.280555] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c13=
59cf7
[  439.288606] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000023=
4a4b0
[  439.296660] RBP: 000000000234a4b0 R08: 0000000000000005 R09: 00000000023=
4b510
[  439.304708] R10: 00000000000006f4 R11: 0000000000000246 R12: 00007f06c18=
65e44
[  439.312761] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc6a5=
9c890
[  439.320807] Code: 8b 85 10 cb 00 00 48 39 c6 0f 84 bc 00 00 00 49 bf 00 =
01 00 00 00 00 ad de 48 8b 9d 10 cb 00 00 48 83 7b 90 00 0f 84 b1 00 00 00 =
<0f> 0b 48 8d b3 78 ff ff ff 31 c9 31 d2 48 89 ef e8 19 65 ff ff=20
[  439.341579] ---[ end trace 9263ab2c46fd437b ]---
[  439.347181] BTRFS info (device dm-0): space_info 1 has 930922496 free, i=
s not full
[  439.355583] BTRFS info (device dm-0): space_info total=3D1082130432, use=
d=3D151076864, pinned=3D0, reserved=3D32768, may_use=3D98304, readonly=3D0
[  439.369408] WARNING: CPU: 1 PID: 14674 at fs/btrfs/extent-tree.c:9898 bt=
rfs_free_block_groups+0x2a2/0x3d0 [btrfs]
[  439.384450] Modules linked in: dm_snapshot dm_thin_pool dm_persistent_da=
ta dm_bio_prison dm_bufio dm_flakey dm_mod netconsole btrfs xor zstd_decomp=
ress zstd_compress xxhash raid6_pq sd_mod sg snd_hda_codec_hdmi snd_hda_cod=
ec_realtek snd_hda_codec_generic ata_generic pata_acpi intel_rapl x86_pkg_t=
emp_thermal intel_powerclamp coretemp snd_hda_intel kvm_intel snd_hda_codec=
 kvm irqbypass crct10dif_pclmul eeepc_wmi crc32_pclmul crc32c_intel ghash_c=
lmulni_intel pata_via asus_wmi sparse_keymap snd_hda_core ata_piix snd_hwde=
p ppdev rfkill wmi_bmof i915 pcbc snd_pcm snd_timer drm_kms_helper syscopya=
rea sysfillrect sysimgblt fb_sys_fops snd aesni_intel parport_pc crypto_sim=
d pcspkr libata soundcore cryptd glue_helper drm wmi parport video shpchp i=
p_tables
[  439.459196] CPU: 1 PID: 14674 Comm: umount Tainted: G        W         4=
=2E17.0-rc1 #1
[  439.478964] RIP: 0010:btrfs_free_block_groups+0x2a2/0x3d0 [btrfs]
[  439.486479] RSP: 0018:ffffc90008b0fdf0 EFLAGS: 00010206
[  439.493108] RAX: ffff88017a675e88 RBX: ffff88017a675e88 RCX: 00000001820=
001ae
[  439.501633] RDX: 00000001820001af RSI: ffffea0005117cc0 RDI: 00000000400=
00000
[  439.510149] RBP: ffff88017b360000 R08: ffff8801445f3cb8 R09: 00000001820=
001ae
[  439.518668] R10: ffffc90008b0fd30 R11: 0000000000000000 R12: ffff88017a6=
75bf8
[  439.527179] R13: ffff88017a675bf8 R14: 0000000000000000 R15: dead0000000=
00100
[  439.535690] FS:  00007f06c1a80fc0(0000) GS:ffff8801bfa80000(0000) knlGS:=
0000000000000000
[  439.545167] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  439.552296] CR2: 00007f06c12b0260 CR3: 000000017d3de004 CR4: 00000000000=
606e0
[  439.560762] Call Trace:
[  439.564490]  close_ctree+0x13b/0x2f0 [btrfs]
[  439.569590]  generic_shutdown_super+0x6c/0x120
[  439.574827]  kill_anon_super+0xe/0x20
[  439.579310]  btrfs_kill_super+0x13/0x100 [btrfs]
[  439.584739]  deactivate_locked_super+0x3f/0x70
[  439.589997]  cleanup_mnt+0x3b/0x70
[  439.594216]  task_work_run+0xa3/0xe0
[  439.598601]  exit_to_usermode_loop+0x9e/0xa0
[  439.603691]  do_syscall_64+0x16c/0x180
[  439.608255]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  439.614118] RIP: 0033:0x7f06c1359cf7
[  439.618495] RSP: 002b:00007ffc6a59c608 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000a6
[  439.626877] RAX: 0000000000000000 RBX: 000000000234a2d0 RCX: 00007f06c13=
59cf7
[  439.634828] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000023=
4a4b0
[  439.642790] RBP: 000000000234a4b0 R08: 0000000000000005 R09: 00000000023=
4b510
[  439.650753] R10: 00000000000006f4 R11: 0000000000000246 R12: 00007f06c18=
65e44
[  439.658698] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc6a5=
9c890
[  439.667189] Code: 8b 85 10 cb 00 00 48 39 c6 0f 84 bc 00 00 00 49 bf 00 =
01 00 00 00 00 ad de 48 8b 9d 10 cb 00 00 48 83 7b 90 00 0f 84 b1 00 00 00 =
<0f> 0b 48 8d b3 78 ff ff ff 31 c9 31 d2 48 89 ef e8 19 65 ff ff=20
[  439.688915] ---[ end trace 9263ab2c46fd437c ]---
[  439.695001] BTRFS info (device dm-0): space_info 4 has 1070989312 free, =
is not full
[  439.703516] BTRFS info (device dm-0): space_info total=3D1073741824, use=
d=3D1638400, pinned=3D0, reserved=3D0, may_use=3D1048576, readonly=3D65536
[  439.717402] VFS: Busy inodes after unmount of dm-0. Self-destruct in 5 s=
econds.  Have a nice day...
[  439.752378] BTRFS info (device dm-0): disk space caching is enabled
[  439.759520] BTRFS info (device dm-0): has skinny extents
[  439.791414] BTRFS info (device dm-0): checking UUID tree
[  439.829566] BTRFS error (device dm-0): error reading free space cache
[  439.830480] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  439.836826] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  442.850467] btrfs_dev_stat_print_on_error: 46 callbacks suppressed
[  442.850470] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 5, rd 41, flush 0, corrupt 0, gen 0
[  442.868563] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 6, rd 41, flush 0, corrupt 0, gen 0
[  442.879538] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 7, rd 41, flush 0, corrupt 0, gen 0
[  442.890406] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 8, rd 41, flush 0, corrupt 0, gen 0
[  442.901330] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 9, rd 41, flush 0, corrupt 0, gen 0
[  442.912146] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 10, rd 41, flush 0, corrupt 0, gen 0
[  442.923128] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 11, rd 41, flush 0, corrupt 0, gen 0
[  442.934054] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 12, rd 41, flush 0, corrupt 0, gen 0
[  442.944991] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 13, rd 41, flush 0, corrupt 0, gen 0
[  442.955864] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 14, rd 41, flush 0, corrupt 0, gen 0
[  442.969341] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  442.982480] BTRFS info (device dm-0): forced readonly
[  442.988223] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  442.996330] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  443.005038] BTRFS info (device dm-0): delayed_refs has NO entry
[  443.036216] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  443.076868] BTRFS info (device dm-0): disk space caching is enabled
[  445.131816] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  445.137794] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  445.142288] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  445.160289] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  445.168790] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  445.180067] BTRFS info (device dm-0): forced readonly
[  445.185900] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  445.194080] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  445.202861] BTRFS info (device dm-0): delayed_refs has NO entry
[  445.209671] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  445.217856] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  445.226848] BTRFS info (device dm-0): delayed_refs has NO entry
[  445.259488] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  445.316269] BTRFS info (device dm-0): disk space caching is enabled
[  445.323308] BTRFS info (device dm-0): has skinny extents
[  445.404329] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  447.370720] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  447.373183] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  447.392254] BTRFS info (device dm-0): forced readonly
[  447.398087] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  447.406243] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  447.415029] BTRFS info (device dm-0): delayed_refs has NO entry
[  447.421767] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  447.429921] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  447.438784] BTRFS info (device dm-0): delayed_refs has NO entry
[  447.469296] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  447.538536] BTRFS info (device dm-0): disk space caching is enabled
[  447.545604] BTRFS info (device dm-0): has skinny extents
[  447.597558] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  447.607240] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  449.608945] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  449.613314] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  449.619548] btrfs_dev_stat_print_on_error: 130 callbacks suppressed
[  449.619551] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  449.645727] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  449.645728] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 1, flush 0, corrupt 0, gen 0
[  449.665185] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  449.676568] BTRFS info (device dm-0): forced readonly
[  449.682486] BTRFS: error (device dm-0) in btrfs_sync_log:3101: errno=3D-=
5 IO failure
[  449.690976] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  449.699252] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  449.729291] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  449.848244] BTRFS info (device dm-0): disk space caching is enabled
[  449.855436] BTRFS info (device dm-0): has skinny extents
[  449.901231] BTRFS warning (device dm-0): block group 29360128 has wrong =
amount of free space
[  449.911366] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 29360128, rebuilding it now
[  449.950130] BTRFS warning (device dm-0): block group 1103101952 has wron=
g amount of free space
[  449.960139] BTRFS warning (device dm-0): failed to load free space cache=
 for block group 1103101952, rebuilding it now
[  450.049104] BTRFS info (device dm-0): checking UUID tree
[  451.070707] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  451.076237] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  451.081535] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 1, rd 0, flush 0, corrupt 0, gen 0
[  451.100770] BTRFS warning (device dm-0): lost page write due to IO error=
 on /dev/mapper/error-test
[  451.110629] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 2, rd 0, flush 0, corrupt 0, gen 0
[  451.121541] BTRFS error (device dm-0): error writing primary super block=
 to device 1
[  451.130208] BTRFS: error (device dm-0) in write_all_supers:3637: errno=
=3D-5 IO failure (1 errors while writing supers)
[  451.141633] BTRFS info (device dm-0): forced readonly
[  451.147561] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  451.155858] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  451.164808] BTRFS info (device dm-0): delayed_refs has NO entry
[  451.195462] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  451.249709] BTRFS info (device dm-0): disk space caching is enabled
[  451.256957] BTRFS info (device dm-0): has skinny extents
[  451.296124] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 0, rd 1, flush 0, corrupt 0, gen 0
[  451.302251] Buffer I/O error on dev dm-0, logical block 52428784, async =
page read
[  451.307072] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 0, rd 2, flush 0, corrupt 0, gen 0
[  451.326371] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 0, rd 3, flush 0, corrupt 0, gen 0
[  451.337342] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 0, rd 4, flush 0, corrupt 0, gen 0
[  451.348363] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 0, rd 5, flush 0, corrupt 0, gen 0
[  451.359385] BTRFS error (device dm-0): bdev /dev/mapper/error-test errs:=
 wr 0, rd 6, flush 0, corrupt 0, gen 0
[  451.392491] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  451.404474] BTRFS: error (device dm-0) in btrfs_commit_transaction:2244:=
 errno=3D-5 IO failure (Error while writing out transaction)
[  451.417840] BTRFS info (device dm-0): forced readonly
[  451.423726] BTRFS warning (device dm-0): Skipping commit of aborted tran=
saction.
[  451.431938] BTRFS: error (device dm-0) in cleanup_transaction:1854: errn=
o=3D-5 IO failure
[  451.440774] BTRFS info (device dm-0): delayed_refs has NO entry
[  451.447637] BTRFS error (device dm-0): cleaner transaction attach return=
ed -30
[  451.490262] BTRFS info (device dm-0): disk space caching is enabled
[  451.497484] BTRFS info (device dm-0): has skinny extents
[  451.533219] BTRFS info (device dm-0): the free space cache file (1103101=
952) is invalid, skip it
[  451.632923] generic/475	 70s
[  451.632926]=20
[  451.881516] _check_dmesg: something found in dmesg (see /lkp/benchmarks/=
xfstests/results//generic/475.dmesg)
[  451.881520]=20
[  451.901186] run fstests generic/477 at 2018-04-16 23:59:47
[  452.585533] BTRFS info (device sda5): disk space caching is enabled
[  452.592728] BTRFS info (device sda5): has skinny extents
[  452.669166] sh (16189): drop_caches: 3
[  452.890951] BTRFS info (device sda5): disk space caching is enabled
[  452.898128] BTRFS info (device sda5): has skinny extents
[  452.974342] sh (16225): drop_caches: 3
[  453.131022] BTRFS info (device sda5): disk space caching is enabled
[  453.138110] BTRFS info (device sda5): has skinny extents
[  453.203295] sh (16261): drop_caches: 3
[  453.396525] BTRFS info (device sda5): disk space caching is enabled
[  453.403689] BTRFS info (device sda5): has skinny extents
[  453.476538] sh (16298): drop_caches: 3
[  453.496777] generic/477	 1s
[  453.496782]=20
[  453.683757] BTRFS info (device sda5): disk space caching is enabled
[  453.690745] BTRFS info (device sda5): has skinny extents
[  453.758703] run fstests generic/478 at 2018-04-16 23:59:49
[  455.045995] generic/478	 1s
[  455.045999]=20
[  455.231358] BTRFS info (device sda5): disk space caching is enabled
[  455.238317] BTRFS info (device sda5): has skinny extents
[  455.309615] run fstests generic/479 at 2018-04-16 23:59:50
[  455.707468] BTRFS: device fsid 203ef42b-7349-4350-897d-9011c75c57e9 devi=
d 1 transid 5 /dev/sda6
[  455.771089] BTRFS info (device dm-0): disk space caching is enabled
[  455.778143] BTRFS info (device dm-0): has skinny extents
[  455.784141] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[  455.793311] BTRFS info (device dm-0): creating UUID tree
[  456.236678] BTRFS info (device dm-0): disk space caching is enabled
[  456.243608] BTRFS info (device dm-0): has skinny extents
[  456.291582] BTRFS info (device dm-0): checking UUID tree
[  456.593182] BTRFS: device fsid f13de3f9-2efe-4603-909f-588dd32b7979 devi=
d 1 transid 5 /dev/sda6
[  456.627319] BTRFS info (device dm-0): disk space caching is enabled
[  456.634378] BTRFS info (device dm-0): has skinny extents
[  456.640413] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[  456.649895] BTRFS info (device dm-0): creating UUID tree
[  456.895246] BTRFS info (device dm-0): disk space caching is enabled
[  456.902362] BTRFS info (device dm-0): has skinny extents
[  456.947183] BTRFS info (device dm-0): checking UUID tree
[  457.207646] BTRFS: device fsid 27543091-6f9d-4cd8-bfd4-a3362030d135 devi=
d 1 transid 5 /dev/sda6
[  457.238704] BTRFS info (device dm-0): disk space caching is enabled
[  457.245626] BTRFS info (device dm-0): has skinny extents
[  457.251583] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[  457.261051] BTRFS info (device dm-0): creating UUID tree
[  457.512530] BTRFS info (device dm-0): disk space caching is enabled
[  457.519511] BTRFS info (device dm-0): has skinny extents
[  457.558312] BTRFS info (device dm-0): checking UUID tree
[  457.689120] generic/479	 3s
[  457.689124]=20
[  457.774062] run fstests generic/480 at 2018-04-16 23:59:53
[  458.104311] BTRFS: device fsid 84d31d62-1fe8-4ae0-82a6-5c21cc047cd2 devi=
d 1 transid 5 /dev/sda6
[  458.137170] BTRFS info (device dm-0): disk space caching is enabled
[  458.144067] BTRFS info (device dm-0): has skinny extents
[  458.149951] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[  458.159206] BTRFS info (device dm-0): creating UUID tree
[  458.402986] BTRFS info (device dm-0): disk space caching is enabled
[  458.410453] BTRFS info (device dm-0): has skinny extents
[  458.458254] BTRFS info (device dm-0): checking UUID tree
[  458.581430] generic/480	 0s
[  458.581434]=20
[  458.675191] run fstests generic/481 at 2018-04-16 23:59:54
[  459.015439] BTRFS: device fsid 7692dc27-9b30-4819-a628-a5f819bb314d devi=
d 1 transid 5 /dev/sda6
[  459.051330] BTRFS info (device dm-0): disk space caching is enabled
[  459.058258] BTRFS info (device dm-0): has skinny extents
[  459.064170] BTRFS info (device dm-0): flagging fs with big metadata feat=
ure
[  459.073215] BTRFS info (device dm-0): creating UUID tree
[  459.247181] BTRFS info (device dm-0): disk space caching is enabled
[  459.254047] BTRFS info (device dm-0): has skinny extents
[  459.320163] BTRFS info (device dm-0): checking UUID tree
[  459.462134] generic/481	 0s
[  459.462139]=20
[  459.523352] Ran: generic/445 generic/446 generic/447 generic/448 generic=
/449 generic/450 generic/451 generic/452 generic/453 generic/454 generic/45=
6 generic/459 generic/460 generic/463 generic/464 generic/465 generic/466 g=
eneric/467 generic/469 generic/472 generic/473 generic/475 generic/477 gene=
ric/478 generic/479 generic/480 generic/481
[  459.523356]=20
[  459.558606] Not run: generic/461 generic/468 generic/471 generic/474
[  459.558607]=20
[  459.568660] Failures: generic/472 generic/475
[  459.568661]=20
[  459.576140] Failed 2 of 27 tests
[  459.576141]=20
[  459.581985]=20
[  459.996266] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gro=
up5-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml&=
job_state=3Dpost_run -o /dev/null
[  459.996270]=20
[  461.214792] kill 851 vmstat --timestamp -n 10=20
[  461.214797]=20
[  461.223734] kill 849 dmesg --follow --decode=20
[  461.223736]=20
[  461.231774] wait for background monitors: 854 oom-killer
[  461.231776]=20
[  466.337853] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gro=
up5-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml&=
loadavg=3D6.79%207.37%203.36%201/153%2018057&start_time=3D1523894043&end_ti=
me=3D1523894395&version=3D/lkp/lkp/.src-20180416-220206& -o /dev/null
[  466.337856]=20
[  466.582518] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gro=
up5-debian-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml&=
job_state=3Dfailed -o /dev/null
[  466.582522]=20
[  466.858089] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-post-run?j=
ob_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-group5-debian=
-x86_64-2016-08-31.cgz-CYCLIC_BASE-20180407-59436-1nzfgnb-0.yaml -o /dev/nu=
ll
[  466.858094]=20
[  467.234235] getting new job...
[  467.234239]=20
[  467.248042] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/gpxelinux.cgi?=
hostname=3Dsnb-drag&mac=3D20:cf:30:f4:b6:f7&last_kernel=3D/pkg/linux/x86_64=
-rhel-7.2/gcc-7/60cc43fc888428bb2f18f08997432d426a243338/vmlinuz-4.17.0-rc1=
&lkp_wtmp -o /tmp/next-job-lkp
[  467.248045]=20
[  469.546513] /usr/bin/curl -sSf http://inn:80/~lkp//lkp/scheduled/snb-dra=
g/xfstests-4HDD-btrfs-generic-group5-debian-x86_64-2016-08-31.cgz-CYCLIC_HE=
AD-20180407-59436-1f9r2pv-0.cgz -o /tmp/next-job.cgz
[  469.546516]=20
[  469.552561] 22 blocks
[  469.568262]=20
[  469.577948] downloading kernel image ...
[  469.577952]=20
[  469.591899] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gro=
up5-debian-x86_64-2016-08-31.cgz-CYCLIC_HEAD-20180407-59436-1f9r2pv-0.yaml&=
job_state=3Dwget_kernel -o /dev/null
[  469.591901]=20
[  470.745441] /usr/bin/curl -sSf http://inn:80/~lkp/pkg/linux/x86_64-rhel-=
7.2/gcc-7/6bab68d02ac0da487fdb4551ff192755306df5f1/vmlinuz-4.17.0-rc1-wt-at=
h-04728-g6bab68d -o /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.2/gcc-7/6bab68d=
02ac0da487fdb4551ff192755306df5f1/vmlinuz-4.17.0-rc1-wt-ath-04728-g6bab68d =
-z /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.2/gcc-7/6bab68d02ac0da487fdb4551=
ff192755306df5f1/vmlinuz-4.17.0-rc1-wt-ath-04728-g6bab68d
[  470.745444]=20
[  470.789747] downloading initrds ...
[  470.789749]=20
[  470.802947] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gro=
up5-debian-x86_64-2016-08-31.cgz-CYCLIC_HEAD-20180407-59436-1f9r2pv-0.yaml&=
job_state=3Dwget_initrd -o /dev/null
[  470.802949]=20
[  470.836263] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/debian/debian-=
x86_64-2016-08-31.cgz -o /opt/rootfs/tmp/osimage/debian/debian-x86_64-2016-=
08-31.cgz -z /opt/rootfs/tmp/osimage/debian/debian-x86_64-2016-08-31.cgz
[  470.836266]=20
[  473.811965] 868655 blocks
[  473.811972]=20
[  473.830342] /usr/bin/curl -sSf http://inn:80/~lkp/lkp/scheduled/snb-drag=
/xfstests-4HDD-btrfs-generic-group5-debian-x86_64-2016-08-31.cgz-CYCLIC_HEA=
D-20180407-59436-1f9r2pv-0.cgz -o /opt/rootfs/tmp/lkp/scheduled/snb-drag/xf=
stests-4HDD-btrfs-generic-group5-debian-x86_64-2016-08-31.cgz-CYCLIC_HEAD-2=
0180407-59436-1f9r2pv-0.cgz
[  473.830345]=20
[  475.080241] 22 blocks
[  475.080246]=20
[  475.091141] /usr/bin/curl -sSf http://inn:80/~lkp/lkp/lkp/lkp-x86_64.cgz=
 -o /opt/rootfs/tmp/lkp/lkp/lkp-x86_64.cgz -z /opt/rootfs/tmp/lkp/lkp/lkp-x=
86_64.cgz
[  475.091144]=20
[  475.170915] 15449 blocks
[  475.170918]=20
[  475.182576] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz -o /opt/rootfs/tmp/osimage/=
deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz -z /opt/rootf=
s/tmp/osimage/deps/debian-x86_64-2016-08-31.cgz/run-ipconfig_2016-11-15.cgz
[  475.182579]=20
[  475.209919] 1077 blocks
[  475.213881]=20
[  475.219723] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/lkp_2017-12-14.cgz -o /opt/rootfs/tmp/osimage/deps/debi=
an-x86_64-2016-08-31.cgz/lkp_2017-12-14.cgz -z /opt/rootfs/tmp/osimage/deps=
/debian-x86_64-2016-08-31.cgz/lkp_2017-12-14.cgz
[  475.219725]=20
[  475.252470] 4350 blocks
[  475.252473]=20
[  475.264088] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz -o /opt/rootfs/tmp/osimage/=
deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz -z /opt/rootf=
s/tmp/osimage/deps/debian-x86_64-2016-08-31.cgz/rsync-rootfs_2016-11-15.cgz
[  475.264091]=20
[  475.307031] 8266 blocks
[  475.307034]=20
[  475.324758] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/fs_2016-11-15.cgz -o /opt/rootfs/tmp/osimage/deps/debia=
n-x86_64-2016-08-31.cgz/fs_2016-11-15.cgz -z /opt/rootfs/tmp/osimage/deps/d=
ebian-x86_64-2016-08-31.cgz/fs_2016-11-15.cgz
[  475.324761]=20
[  475.448963] 18404 blocks
[  475.448967]=20
[  475.473863] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/xfstests_2018-03-14.cgz -o /opt/rootfs/tmp/osimage/deps=
/debian-x86_64-2016-08-31.cgz/xfstests_2018-03-14.cgz -z /opt/rootfs/tmp/os=
image/deps/debian-x86_64-2016-08-31.cgz/xfstests_2018-03-14.cgz
[  475.473866]=20
[  476.492360] 294194 blocks
[  476.492363]=20
[  476.520821] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/pkg/debian-x86=
_64-2016-08-31.cgz/xfstests-x86_64-545e7ca6_2018-03-28.cgz -o /opt/rootfs/t=
mp/osimage/pkg/debian-x86_64-2016-08-31.cgz/xfstests-x86_64-545e7ca6_2018-0=
3-28.cgz -z /opt/rootfs/tmp/osimage/pkg/debian-x86_64-2016-08-31.cgz/xfstes=
ts-x86_64-545e7ca6_2018-03-28.cgz
[  476.520824]=20
[  476.762739] 66401 blocks
[  476.762742]=20
[  476.773835] /usr/bin/curl -sSf http://inn:80/~lkp/osimage/deps/debian-x8=
6_64-2016-08-31.cgz/hw_2016-11-15.cgz -o /opt/rootfs/tmp/osimage/deps/debia=
n-x86_64-2016-08-31.cgz/hw_2016-11-15.cgz -z /opt/rootfs/tmp/osimage/deps/d=
ebian-x86_64-2016-08-31.cgz/hw_2016-11-15.cgz
[  476.773839]=20
[  476.949369] 31441 blocks
[  476.949372]=20
[  476.963188] /usr/bin/curl -sSf http://inn:80/~lkp/pkg/linux/x86_64-rhel-=
7.2/gcc-7/6bab68d02ac0da487fdb4551ff192755306df5f1/modules.cgz -o /opt/root=
fs/tmp/pkg/linux/x86_64-rhel-7.2/gcc-7/6bab68d02ac0da487fdb4551ff192755306d=
f5f1/modules.cgz -z /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.2/gcc-7/6bab68d=
02ac0da487fdb4551ff192755306df5f1/modules.cgz
[  476.963192]=20
[  480.776657] 1142346 blocks
[  480.776660]=20
[  481.544310] /usr/bin/curl -sSf http://inn:80/~lkp/cgi-bin/lkp-jobfile-ap=
pend-var?job_file=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-gro=
up5-debian-x86_64-2016-08-31.cgz-CYCLIC_HEAD-20180407-59436-1f9r2pv-0.yaml&=
job_state=3Dbooting -o /dev/null
[  481.544313]=20
[  481.778800] LKP: kexec loading...
[  481.778804]=20
[  481.794975] kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-7.2/g=
cc-7/6bab68d02ac0da487fdb4551ff192755306df5f1/vmlinuz-4.17.0-rc1-wt-ath-047=
28-g6bab68d --initrd=3D/opt/rootfs/tmp/initrd-concatenated
[  481.794979]=20
[  485.810321] --append=3Dip=3D::::snb-drag::dhcp root=3D/dev/ram0 user=3Dl=
kp job=3D/lkp/scheduled/snb-drag/xfstests-4HDD-btrfs-generic-group5-debian-=
x86_64-2016-08-31.cgz-CYCLIC_HEAD-20180407-59436-1f9r2pv-0.yaml ARCH=3Dx86_=
64 kconfig=3Dx86_64-rhel-7.2 branch=3Dlinux-devel/devel-hourly-2018041614 c=
ommit=3D6bab68d02ac0da487fdb4551ff192755306df5f1 BOOT_IMAGE=3D/pkg/linux/x8=
6_64-rhel-7.2/gcc-7/6bab68d02ac0da487fdb4551ff192755306df5f1/vmlinuz-4.17.0=
-rc1-wt-ath-04728-g6bab68d max_uptime=3D7200 RESULT_ROOT=3D/result/xfstests=
/4HDD-btrfs-generic-group5/snb-drag/debian-x86_64-2016-08-31.cgz/x86_64-rhe=
l-7.2/gcc-7/6bab68d02ac0da487fdb4551ff192755306df5f1/0 LKP_SERVER=3Dinn deb=
ug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 n=
et.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watc=
hdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_co=
unt=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earl
[  485.896624]=20
[  486.881806] Unknown type (Reserved) while parsing /sys/firmware/memmap/2=
1/type. Please report this as bug. Using RANGE_RESERVED now.
[  486.881810]=20
[  486.900723] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
1/type. Please report this as bug. Using RANGE_RESERVED now.
[  486.900726]=20
[  486.919707] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  486.919710]=20
[  486.938682] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
6/type. Please report this as bug. Using RANGE_RESERVED now.
[  486.938685]=20
[  486.957666] Unknown type (Reserved) while parsing /sys/firmware/memmap/6=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  486.957669]=20
[  486.976597] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
4/type. Please report this as bug. Using RANGE_RESERVED now.
[  486.976599]=20
[  486.995583] Unknown type (Reserved) while parsing /sys/firmware/memmap/4=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  486.995585]=20
[  487.014509] Unknown type (Reserved) while parsing /sys/firmware/memmap/2=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  487.014511]=20
[  487.033542] Unknown type (Reserved) while parsing /sys/firmware/memmap/2=
0/type. Please report this as bug. Using RANGE_RESERVED now.
[  487.033545]=20
[  487.052694] Unknown type (Reserved) while parsing /sys/firmware/memmap/1=
9/type. Please report this as bug. Using RANGE_RESERVED now.
[  487.052696]=20
[  487.071849] Unknown type (Reserved) while parsing /sys/firmware/memmap/9=
/type. Please report this as bug. Using RANGE_RESERVED now.
[  487.071851]=20
[  488.105330] umount: /tmp: target is busy
[  488.105332]=20
[  488.114052]         (In some cases useful info about processes that
[  488.114054]=20
[  488.125026]          use the device is found by lsof(8) or fuser(1).)
[  488.125027]=20
[  488.237590] umount: /sys/fs/cgroup/systemd: target is busy
[  488.237594]=20
[  488.250048]         (In some cases useful info about processes that
[  488.250049]=20
[  488.260842]          use the device is found by lsof(8) or fuser(1).)
[  488.260843]=20
[  488.271379] umount: /sys/fs/cgroup: target is busy
[  488.271380]=20
[  488.280606]         (In some cases useful info about processes that
[  488.280607]=20
[  488.291316]          use the device is found by lsof(8) or fuser(1).)
[  488.291317]=20
[  488.301542] umount: /run: target is busy
[  488.301543]=20

--tknyj4ydszzi42v5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.17.0-rc1 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUDIT_WATCH=y
CONFIG_AUDIT_TREE=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_RCU_NOCB_CPU=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_BLK_CGROUP=y
# CONFIG_DEBUG_BLK_CGROUP is not set
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
# CONFIG_CC_STACKPROTECTOR_AUTO is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_CFQ_GROUP_IOSCHED=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
# CONFIG_QUEUED_LOCK_STAT is not set
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
# CONFIG_HMM_MIRROR is not set
# CONFIG_DEVICE_PRIVATE is not set
# CONFIG_DEVICE_PUBLIC is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
# CONFIG_EFI_MIXED is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_INTEL_IDLE=y

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_PCI_DOMAINS=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIE_ECRC=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
# CONFIG_PCI_HYPERV is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=m

#
# Cadence PCIe controllers support
#

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT is not set

#
# PCI host controller drivers
#
# CONFIG_VMD is not set

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_AOUT is not set
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_XFRM_MODE_TRANSPORT=m
CONFIG_INET_XFRM_MODE_TUNNEL=m
CONFIG_INET_XFRM_MODE_BEET=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
# CONFIG_TCP_CONG_DCTCP is not set
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET6_XFRM_MODE_TRANSPORT=m
CONFIG_INET6_XFRM_MODE_TUNNEL=m
CONFIG_INET6_XFRM_MODE_BEET=m
CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=m
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_PROTO_DCCP=y
CONFIG_NF_NAT_PROTO_UDPLITE=y
CONFIG_NF_NAT_PROTO_SCTP=y
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=m
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
CONFIG_NFT_EXTHDR=m
CONFIG_NFT_META=m
# CONFIG_NFT_RT is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
# CONFIG_NFT_SET_RBTREE is not set
# CONFIG_NFT_SET_HASH is not set
# CONFIG_NFT_SET_BITMAP is not set
CONFIG_NFT_COUNTER=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=m
# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_QUEUE is not set
# CONFIG_NFT_QUOTA is not set
# CONFIG_NFT_REJECT is not set
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
# CONFIG_IP_SET_HASH_NETPORTNET is not set
CONFIG_IP_SET_HASH_NET=m
# CONFIG_IP_SET_HASH_NETNET is not set
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_CONNTRACK_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_IPV4=m
CONFIG_NF_NAT_MASQUERADE_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PROTO_GRE=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_CONNTRACK_IPV6=m
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_NF_NAT_IPV6=m
# CONFIG_NF_NAT_MASQUERADE_IPV6 is not set
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
# CONFIG_IP6_NF_NAT is not set
# CONFIG_NF_TABLES_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_FQ is not set
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_VLAN is not set
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_CLS_IND=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
# CONFIG_VIRTIO_VSOCKETS is not set
# CONFIG_HYPERV_VSOCKETS is not set
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_LEDS is not set
# CONFIG_CAN_C_CAN is not set
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
# CONFIG_CAN_SJA1000 is not set
# CONFIG_CAN_SOFTING is not set

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set

#
# CAN USB interfaces
#
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_MINSTREL_HT=y
# CONFIG_MAC80211_RC_MINSTREL_VHT is not set
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
# CONFIG_XEN_BLKDEV_BACKEND is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
# CONFIG_BLK_DEV_RBD is not set
CONFIG_BLK_DEV_RSXX=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_SGI_IOC4=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
# CONFIG_TCM_QLA2XXX is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
CONFIG_SCSI_OSD_INITIATOR=m
CONFIG_SCSI_OSD_ULD=m
CONFIG_SCSI_OSD_DPRINT_SENSE=1
# CONFIG_SCSI_OSD_DEBUG is not set
CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_MQ_DEFAULT is not set
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_ERA is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
# CONFIG_ISCSI_TARGET_CXGB4 is not set
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=m
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
CONFIG_SKGE_DEBUG=y
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
CONFIG_SKY2_DEBUG=y
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_QLGE=m
CONFIG_NETXEN_NIC=m
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=m
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x2E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PEARL_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_DSCC4 is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=m
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_IPPP_FILTER=y
# CONFIG_ISDN_PPP_BSDCOMP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

#
# ISDN feature submodules
#
CONFIG_ISDN_DIVERSION=m

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPIDRV=m
# CONFIG_ISDN_CAPI_CAPIDRV_VERBOSE is not set

#
# CAPI hardware drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
# CONFIG_CAPI_EICON is not set
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=m
# CONFIG_SPI_DW_PCI is not set
# CONFIG_SPI_DW_MMIO is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=y
CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=m
# CONFIG_GPIO_MB86S7X is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VX855 is not set

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LTC3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SHT15 is not set
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_SILENT is not set
# CONFIG_SSB_DEBUG is not set
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
# CONFIG_IR_IMON_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
# CONFIG_RC_LOOPBACK is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_VIDEOBUF_DVB=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_FRIIO=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m

#
# Camera sensor devices
#

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_MEDIA_TUNER=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_GP8PSK_FE=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m

#
# Tools to develop new frontends
#

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
# CONFIG_DRM_DEBUG_MM_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_TTM=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_VGEM=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_TINYDRM is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
# CONFIG_SND_HDA_RECONFIG is not set
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
# CONFIG_SND_SOC is not set
CONFIG_SND_X86=y
# CONFIG_HDMI_LPE_AUDIO is not set
CONFIG_SND_SYNTH_EMUX=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GOOGLE_HAMMER is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=y
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
CONFIG_USB_DWC3_GADGET=y
# CONFIG_USB_DWC3_DUAL_ROLE is not set

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
# CONFIG_USB_DUMMY_HCD is not set
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_MASS_STORAGE=m
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_MASS_STORAGE=m
# CONFIG_USB_GADGET_TARGET is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
# CONFIG_EDAC_GHES is not set
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
# CONFIG_EDAC_IE31200 is not set
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_PND2 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV8803 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
# CONFIG_VFIO_MDEV is not set
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TSCPAGE=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_SELFBALLOONING is not set
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=m
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
# CONFIG_XEN_SCSI_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_STAGING=y
# CONFIG_IPX is not set
# CONFIG_NCP_FS is not set
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_R8822BE is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_CRYPTO_SKEIN is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_GREYBUS is not set

#
# USB Power Delivery and Type-C drivers
#
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set
# CONFIG_MTK_MMC is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_LAPTOP is not set
# CONFIG_DELL_WMI is not set
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_HP_WIRELESS is not set
CONFIG_HP_WMI=m
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_INTEL_WMI_THUNDERBOLT is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_PVPANIC=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IOVA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_NVMEM=y

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
CONFIG_DCDBAS=m
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_UEFI_CPER=y

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EXOFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_ACL=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_HAVE_ARCH_KASAN=y
# CONFIG_KASAN is not set
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAIL_FUTEX is not set
# CONFIG_FAIL_FUNCTION is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_TRACING_EVENTS_GPIO=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=m
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
CONFIG_RBTREE_TEST=m
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_ASYNC_RAID6_TEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
CONFIG_TEST_UDELAY=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_EFI is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_DEFAULT_SECURITY="selinux"
CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA1_MB=m
CONFIG_CRYPTO_SHA256_MB=m
CONFIG_CRYPTO_SHA512_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
CONFIG_CRYPTO_SALSA20_X86_64=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_SPECK is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
# CONFIG_CRYPTO_DEV_CHELSIO is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
# CONFIG_VHOST_VSOCK is not set
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=m
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
CONFIG_DMA_DIRECT_OPS=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set

--tknyj4ydszzi42v5--
