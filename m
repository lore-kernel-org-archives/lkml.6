Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeBXJnI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 04:43:08 -0500
Received: from outbound-protection.loswebos.de ([213.187.84.183]:34164 "EHLO
        outbound-protection.loswebos.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750974AbeBXJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 04:43:04 -0500
X-loswebos-BaruwaFW-From: marc@osknowledge.org
X-loswebos-BaruwaFW-SpamScore: s
X-loswebos-BaruwaFW: Found to be clean
X-loswebos-BaruwaFW-ID: 1epVzy-0007p7-Q8
X-loswebos-BaruwaFW-Information: Please contact loswebos.de GmbH for more information
Date: Sat, 24 Feb 2018 10:20:02 +0100
From: Marc Burkhardt <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: [4.4.116+] BUG: unable to handle kernel paging request at
 ffff88063a9e10c0
Message-ID: <20180224092002.GA5708@local.marc.ngoe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D195 09B3 EC7D 718A 6B59 6E14 C7BE 7B2B 71E5 A099
X-Operating-System: Linux marc 4.4.116local64
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Baruwa-Relayed-From: 213.187.93.205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI everyone,

udev-237 seems to be crashing reproducibly on kernel 4.4.116+. I rebuilt it using gcc-7.3.0 and binutils 2.30, formerly using gcc-6.4.0 and binutils 2.29.1. This might as well be .config related, as I changed some stuff there as well.

The .config change is CONFIG_INTEL_TXT is not set -> CONFIG_INTEL_TXT=y.

The .config for 4.4.117 is attached (no changes except the above).

Afterwards I do not have any USB mouse available and "lsusb" stalls forever.

Feel free to let me know what I could do to debug this further.

Feb 24 10:06:05 marc kernel: [    9.410782] BUG: unable to handle kernel paging request at ffff88063a9e10c0
Feb 24 10:06:05 marc kernel: [    9.410788] IP: [<ffffffff8159723e>] input_leds_connect+0x1be/0x2d0
Feb 24 10:06:05 marc kernel: [    9.410798] PGD 1efe067 PUD 63a887063 PMD 63a886063 PTE 800000063a9e1061
Feb 24 10:06:05 marc kernel: [    9.410805] Oops: 0003 [#1] PREEMPT SMP 
Feb 24 10:06:05 marc kernel: [    9.410810] Modules linked in: btusb btintel bluetooth usbhid(+) ip6table_filter ip6_tables iptable_filter ip_tables x_tables snd_hda_codec_realtek snd_hda_codec_generic iwlmvm i915 ipv6 mac80211 cpufreq_ondemand snd_hda_codec_hdmi cpufreq_userspace msr iwlwifi intel_gtt vboxpci(O) snd_hda_intel vboxnetadp(O) vboxnetflt(O) snd_hda_codec cfg80211 snd_hwdep xhci_pci snd_hda_core vboxdrv(O) xhci_hcd x86_pkg_temp_thermal coretemp crc32_pclmul snd_pcm crc32c_intel usbcore loop(O) thinkpad_acpi drbg snd_timer ansi_cprng snd aesni_intel i2c_i801 usb_common soundcore rfkill tpm_tis evdev ac battery tpm thermal button
Feb 24 10:06:05 marc kernel: [    9.410866] CPU: 6 PID: 2141 Comm: systemd-udevd Tainted: G           O    4.4.116local64 #1
Feb 24 10:06:05 marc kernel: [    9.410870] Hardware name: LENOVO 20EN0006GE/20EN0006GE, BIOS N1EET75W (1.48 ) 12/13/2017
Feb 24 10:06:05 marc kernel: [    9.410873] task: ffff8806315540c0 ti: ffff880632834000 task.ti: ffff880632834000
Feb 24 10:06:05 marc kernel: [    9.410876] RIP: 0010:[<ffffffff8159723e>]  [<ffffffff8159723e>] input_leds_connect+0x1be/0x2d0
Feb 24 10:06:05 marc kernel: [    9.410883] RSP: 0018:ffff8806328376e8  EFLAGS: 00010282
Feb 24 10:06:05 marc kernel: [    9.410886] RAX: ffff88063a9e0f20 RBX: 000000000000000b RCX: 000000000000000b
Feb 24 10:06:05 marc kernel: [    9.410889] RDX: 000000000000000b RSI: 0000000000000010 RDI: ffff8806396b08a8
Feb 24 10:06:05 marc kernel: [    9.410891] RBP: ffff880632837738 R08: fffffffffffff800 R09: 0000000000003fff
Feb 24 10:06:05 marc kernel: [    9.410893] R10: 000000000000000b R11: ffff88063648e91c R12: ffff88063a9e0000
Feb 24 10:06:05 marc kernel: [    9.410896] R13: ffffffff818d1260 R14: 000000000000000b R15: 000000000000000b
Feb 24 10:06:05 marc kernel: [    9.410899] FS:  0000000000000000(0000) GS:ffff880653d80000(0063) knlGS:00000000f73b1780
Feb 24 10:06:05 marc kernel: [    9.410902] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
Feb 24 10:06:05 marc kernel: [    9.410905] CR2: ffff88063a9e10c0 CR3: 00000006308bc000 CR4: 0000000000360670
Feb 24 10:06:05 marc kernel: [    9.410907] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Feb 24 10:06:05 marc kernel: [    9.410910] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Feb 24 10:06:05 marc kernel: [    9.410911] Stack:
Feb 24 10:06:05 marc kernel: [    9.410914]  0000000081592cd4 ffff8806396b0a28 ffff8806396b08a8 000000000000000a
Feb 24 10:06:05 marc kernel: [    9.410919]  ffff8806396b0800 ffffffff818d10e0 ffff8806396b0830 ffffffff81ce64e0
Feb 24 10:06:05 marc kernel: [    9.410923]  7fffffffffffffff ffff8806396b0800 ffff880632837778 ffffffff815938b9
Feb 24 10:06:05 marc kernel: [    9.410928] Call Trace:
Feb 24 10:06:05 marc kernel: [    9.410936]  [<ffffffff815938b9>] input_attach_handler+0x199/0x1e0
Feb 24 10:06:05 marc kernel: [    9.410940]  [<ffffffff81593e04>] input_register_device+0x434/0x4a0
Feb 24 10:06:05 marc kernel: [    9.410946]  [<ffffffff815cdbe3>] hidinput_connect+0x7b3/0x3920
Feb 24 10:06:05 marc kernel: [    9.410950]  [<ffffffff815cad8f>] hid_connect+0x32f/0x410
Feb 24 10:06:05 marc kernel: [    9.410955]  [<ffffffff8153cbb8>] ? device_set_wakeup_enable+0x28/0x30
Feb 24 10:06:05 marc kernel: [    9.410959]  [<ffffffff815cb1c0>] hid_device_probe+0x110/0x150
Feb 24 10:06:05 marc kernel: [    9.410964]  [<ffffffff8152db1d>] driver_probe_device+0x14d/0x310
Feb 24 10:06:05 marc kernel: [    9.410969]  [<ffffffff8152dde1>] __device_attach_driver+0x71/0xa0
Feb 24 10:06:05 marc kernel: [    9.410973]  [<ffffffff8152dd70>] ? __driver_attach+0x90/0x90
Feb 24 10:06:05 marc kernel: [    9.410977]  [<ffffffff8152bd0b>] bus_for_each_drv+0x5b/0x90
Feb 24 10:06:05 marc kernel: [    9.410982]  [<ffffffff8152d91a>] __device_attach+0xba/0x120
Feb 24 10:06:05 marc kernel: [    9.410986]  [<ffffffff8152de53>] device_initial_probe+0x13/0x20
Feb 24 10:06:05 marc kernel: [    9.410990]  [<ffffffff8152cdb2>] bus_probe_device+0x92/0xa0
Feb 24 10:06:05 marc kernel: [    9.410996]  [<ffffffff8152aba9>] device_add+0x349/0x650
Feb 24 10:06:05 marc kernel: [    9.411003]  [<ffffffff812ea043>] ? debugfs_create_file+0xd3/0x110
Feb 24 10:06:05 marc kernel: [    9.411007]  [<ffffffff815cc2ca>] hid_add_device+0xca/0x290
Feb 24 10:06:05 marc kernel: [    9.411013]  [<ffffffff811da9bb>] ? kmem_cache_alloc_trace+0x18b/0x190
Feb 24 10:06:05 marc kernel: [    9.411022]  [<ffffffffc01372d4>] usbhid_probe+0x2e4/0x420 [usbhid]
Feb 24 10:06:05 marc kernel: [    9.411043]  [<ffffffffc00e2271>] usb_probe_interface+0x101/0x270 [usbcore]
Feb 24 10:06:05 marc kernel: [    9.411048]  [<ffffffff8152dc09>] driver_probe_device+0x239/0x310
Feb 24 10:06:05 marc kernel: [    9.411052]  [<ffffffff8152dd64>] __driver_attach+0x84/0x90
Feb 24 10:06:05 marc kernel: [    9.411056]  [<ffffffff8152dce0>] ? driver_probe_device+0x310/0x310
Feb 24 10:06:05 marc kernel: [    9.411060]  [<ffffffff8152bc50>] bus_for_each_dev+0x60/0xa0
Feb 24 10:06:05 marc kernel: [    9.411064]  [<ffffffff8152d48e>] driver_attach+0x1e/0x20
Feb 24 10:06:05 marc kernel: [    9.411068]  [<ffffffff8152d018>] bus_add_driver+0x118/0x210
Feb 24 10:06:05 marc kernel: [    9.411073]  [<ffffffff8152e670>] driver_register+0x60/0xe0
Feb 24 10:06:05 marc kernel: [    9.411090]  [<ffffffffc00e0eb1>] usb_register_driver+0x81/0x140 [usbcore]
Feb 24 10:06:05 marc kernel: [    9.411094]  [<ffffffffc014b000>] ? 0xffffffffc014b000
Feb 24 10:06:05 marc kernel: [    9.411101]  [<ffffffffc014b031>] hid_init+0x31/0x1000 [usbhid]
Feb 24 10:06:05 marc kernel: [    9.411107]  [<ffffffff810003c9>] do_one_initcall+0x99/0x1d0
Feb 24 10:06:05 marc kernel: [    9.411113]  [<ffffffff8118a8be>] do_init_module+0x5f/0x1d1
Feb 24 10:06:05 marc kernel: [    9.411118]  [<ffffffff811386eb>] load_module+0x1e1b/0x2470
Feb 24 10:06:05 marc kernel: [    9.411122]  [<ffffffff81135500>] ? show_taint+0x30/0x30
Feb 24 10:06:05 marc kernel: [    9.411129]  [<ffffffff811ec431>] ? kernel_read+0x41/0x60
Feb 24 10:06:05 marc kernel: [    9.411135]  [<ffffffff81138f04>] SyS_finit_module+0x94/0xa0
Feb 24 10:06:05 marc kernel: [    9.411141]  [<ffffffff81001e8c>] do_fast_syscall_32+0x9c/0x1d0
Feb 24 10:06:05 marc kernel: [    9.411147]  [<ffffffff8169ffc5>] sysenter_flags_fixed+0x8/0x12
Feb 24 10:06:05 marc kernel: [    9.411150] Code: be 10 00 00 00 e8 33 95 dd ff 41 89 c6 83 f8 0f 0f 87 c8 00 00 00 49 63 df 45 89 f2 48 8d 04 9b 48 8d 04 43 48 c1 e0 05 4c 01 e0 <4c> 89 a0 a0 01 00 00 44 89 b0 a8 01 00 00 4c 89 d0 48 c1 e0 04 
Feb 24 10:06:05 marc kernel: [    9.411203] RIP  [<ffffffff8159723e>] input_leds_connect+0x1be/0x2d0
Feb 24 10:06:05 marc kernel: [    9.411210]  RSP <ffff8806328376e8>
Feb 24 10:06:05 marc kernel: [    9.411212] CR2: ffff88063a9e10c0
Feb 24 10:06:05 marc kernel: [    9.411216] ---[ end trace 417dd9842a8eef90 ]---


-- 
Marc Burkhardt
