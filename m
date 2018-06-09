Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eG8KEGzUG1vsFAAAmS7hNA
	; Sat, 09 Jun 2018 13:23:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 514B5608B8; Sat,  9 Jun 2018 13:23:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aowii5Ii"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 309A3600D0;
	Sat,  9 Jun 2018 13:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 309A3600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeFINXq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:23:46 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36805 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeFINXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:23:40 -0400
Received: by mail-lf0-f48.google.com with SMTP id u4-v6so24120389lff.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:user-agent:mime-version:message-id;
        bh=8mcl/jTWiaKx0OThzSAusYAszCMdSnh6GMZU8hNijeE=;
        b=aowii5IiuxGL0jmi+v+RG9qZRpPGZzxCA6RhKR1zjbTtYsi6lUdGpr/Vu2VH238GXE
         N7if/xNCDhgHUaNa1KGDXyJArAMwskuVF2wff3FN/lkR3XxDLrp5aFG/8a79bku16wK8
         yZv4FzS5UcuHufkI5Ghs612P2YDGSEEJ1LihWaxaC4kB33TkstkTNNqGPbynAiPLpqeQ
         efM2bG62r2YulhgPS+LHTxt3VRO75pyUhG3GpTt18F+S8yDPt0kRvBxuAfBI1y9WmXSN
         FQkhfB3w3GpOQaqFR3szeWafG1IkwghZuy3DlF5d1vkNSFnHDP0k0q/OHe2wlhb7uWM9
         S2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:user-agent:mime-version
         :message-id;
        bh=8mcl/jTWiaKx0OThzSAusYAszCMdSnh6GMZU8hNijeE=;
        b=aylClEaszRQVhapEegpCpzDitHBRlhT2YhEqtVALq1CCmC1Ma9q5lKe5yYh5VQhGI3
         0j03HzBNaSNctlN2G12YQAfEref4f5CN5r8rprA9jUsujmwdpZB9yZ9nwduub7hHsc0S
         JQmMZXJ4rFROpYvjpxH5dQPB/2FvGzLVMQSs4EFY04qi4MCwGCxljMX2fDT7aI0s7Car
         QC1oEhpMXM4bJYfAdjmAYH6esGx67Jb+lsIfyC7/XUNcBBpyYZl7Z0JjSpG1SdPPmUEh
         bSDPgsWU1GaEbDaLf3kkSBaPqzughsXO69LgZ/KZlNMoeoqP14lPINUy62hySxcxoKRE
         wCyg==
X-Gm-Message-State: APt69E1+6f5zhXcnZwpIIxMansE5bWoV2NXdXFAz3Cl/W7ZG/T78/NMb
        ikPAZz59pA6P/erTSU41a076kw==
X-Google-Smtp-Source: ADUXVKLBDdnj1zjeYLSH78AJ7P2D2QAnuc/XW6Ju6eIJtxq8jgs6AC6hmLhrxcjx5BdtW5jEeYZfEQ==
X-Received: by 2002:a19:428c:: with SMTP id p134-v6mr6041530lfa.4.1528550618268;
        Sat, 09 Jun 2018 06:23:38 -0700 (PDT)
Received: from [192.168.1.100] ([176.116.252.109])
        by smtp.gmail.com with ESMTPSA id c74-v6sm7899782lfh.78.2018.06.09.06.23.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 06:23:37 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at drivers/scsi/scsi_error.c:197! - git 4.17.0-x64-08428-g7d3bf613e99a
Date: Sat, 9 Jun 2018 16:06:50 +0300
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rD9Gb/LkA3KajWW"
Message-Id: <201806091606.51078.randrianasulu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_rD9Gb/LkA3KajWW
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, everyone!

I was trying to test not-yet-completed 4.18-rc1, and run into this bug, probably 
due to HAL (yes, I still use this) trying to poll empty DVD-RW drive:

[   35.040167] ------------[ cut here ]------------
[   35.040171] kernel BUG at drivers/scsi/scsi_error.c:197!
[   35.040196] invalid opcode: 0000 [#1] SMP NOPTI
[   35.040210] CPU: 2 PID: 117 Comm: kworker/2:1H Not tainted 
4.17.0-x64-08428-g7d3bf613e99a-dirty #18
[   35.040225] Hardware name: MSI MS-7693/970A-G46 (MS-7693), BIOS V2.8 
01/08/2016
[   35.040244] Workqueue: kblockd blk_mq_timeout_work
[   35.040283] RIP: 0010:scsi_times_out+0xe9/0x1a6 [scsi_mod]
[   35.040287] Code: 03 76 18 48 c7 c2 f9 c2 01 a0 48 89 ee 48 c7 c7 14 be 01 a0 
31 c0 e8 76 ad 00 00 48 8b 83 98 01 00 00 a8 01 0f 84 a5 00 00 00 <0f> 0b 49 8b 
7c 24 38 e8 8f ba 4b e1 41 83 bc 24 2c 01
 00 00 ff 74
[   35.040312] RSP: 0018:ffffc90000293d98 EFLAGS: 00010202
[   35.040318] RAX: ffff88031f240605 RBX: ffff88031eed8500 RCX: 00000000fffefd40
[   35.040323] RDX: ffffc90000293e80 RSI: 0000000000002007 RDI: ffff88031eed8638
[   35.040327] RBP: ffff88031eed8638 R08: ffff88031eed85d8 R09: 0000000000000000
[   35.040332] R10: 0000000000000040 R11: fefefefefefefeff R12: ffff88031f2a8800
[   35.040336] R13: ffff88031f2a8800 R14: ffff88031f29e910 R15: 0000000000000001
[   35.040341] FS:  0000000000000000(0000) GS:ffff88032ed00000(0000) 
knlGS:0000000000000000
[   35.040346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.040350] CR2: 00000000f7ea83c0 CR3: 000000031e194000 CR4: 00000000000406e0
[   35.040354] Call Trace:
[   35.040360]  blk_mq_check_expired+0xdc/0x10c
[   35.040365]  bt_iter+0x42/0x45
[   35.040369]  __sbitmap_for_each_set.constprop.12+0x83/0xac
[   35.040374]  ? blk_mq_update_nr_requests+0xad/0xad
[   35.040595]  ? blk_mq_exit_hctx+0xda/0xda
[   35.041595]  blk_mq_queue_tag_busy_iter+0xa3/0xb4
[   35.042578]  ? blk_mq_exit_hctx+0xda/0xda
[   35.043550]  blk_mq_timeout_work+0x6b/0xca
[   35.044505]  process_one_work+0x17c/0x2a6
[   35.045445]  worker_thread+0x19f/0x243
[   35.046393]  ? rescuer_thread+0x262/0x262
[   35.047346]  kthread+0x100/0x108
[   35.048290]  ? kthread_destroy_worker+0x3e/0x3e
[   35.049242]  ret_from_fork+0x27/0x50
[   35.050192] Modules linked in: bridge stp llc bnep rfcomm hidp snd_aloop ipv6 
pcmcia pcmcia_core xfs libcrc32c lp parport f71882fg input_leds mousedev 
hid_generic usbhid hid btusb btintel btbcm btrtl bluetooth nouveau ecdh_generic 
rfkill morus1280_sse2 morus1280_glue morus640_sse2 morus640_glue ttm 
drm_kms_helper ghash_clmulni_intel drm crct10dif_pclmul crc32_pclmul 
drm_panel_orientation_quirks crc32c_intel aegis256_aesni cfbcopyarea 
fb_sys_fops sysimgblt pcbc sysfillrect cfbimgblt syscopyarea cfbfillrect 
aesni_intel glue_helper i2c_algo_bit crypto_simd aes_x86_64 ohci_pci 
snd_hda_codec_realtek aegis128l_aesni pktcdvd aegis128_aesni agpgart ohci_hcd 
snd_hda_codec_generic cryptd xhci_pci kvm_amd xhci_hcd ehci_pci snd_hda_intel 
ehci_hcd snd_hda_codec kvm usbcore led_class snd_hda_core video usb_common
[   35.055814]  backlight irqbypass fb snd_hwdep snd_pcm mxm_wmi r8169 fbdev 
mac_hid fam15h_power k10temp mii snd_timer ccp evdev snd rng_core hwmon wmi 
i2c_piix4 sha1_generic sha256_generic button soundcore font sr_mod acpi_cpufreq 
rtc_cmos sg i2c_core cdrom edac_mce_amd sd_mod ahci libahci libata scsi_mod 
[last unloaded: pcmcia_core]
[   35.058426] ---[ end trace fdc9e8c678138a75 ]---
[   35.059725] RIP: 0010:scsi_times_out+0xe9/0x1a6 [scsi_mod]
[   35.059726] Code: 03 76 18 48 c7 c2 f9 c2 01 a0 48 89 ee 48 c7 c7 14 be 01 a0 
31 c0 e8 76 ad 00 00 48 8b 83 98 01 00 00 a8 01 0f 84 a5 00 00 00 <0f> 0b 49 8b 
7c 24 38 e8 8f ba 4b e1 41 83 bc 24 2c 01 00 00 ff 74
[   35.063794] RSP: 0018:ffffc90000293d98 EFLAGS: 00010202
[   35.063796] RAX: ffff88031f240605 RBX: ffff88031eed8500 RCX: 00000000fffefd40
[   35.063797] RDX: ffffc90000293e80 RSI: 0000000000002007 RDI: ffff88031eed8638
[   35.063798] RBP: ffff88031eed8638 R08: ffff88031eed85d8 R09: 0000000000000000
[   35.069198] R10: 0000000000000040 R11: fefefefefefefeff R12: ffff88031f2a8800
[   35.069198] R13: ffff88031f2a8800 R14: ffff88031f29e910 R15: 0000000000000001
[   35.069200] FS:  0000000000000000(0000) GS:ffff88032ed00000(0000) 
knlGS:0000000000000000
[   35.073191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.073192] CR2: 00000000f7ea83c0 CR3: 000000031e194000 CR4: 00000000000406e0


and this resulted later on in failure to enter suspend-to-ram:

[  181.912985] PM: suspend entry (deep)
[  181.912993] PM: Syncing filesystems ... done.
[  182.026561] Freezing user space processes ...
[  202.029084] Freezing of tasks failed after 20.002 seconds (1 tasks refusing 
to freeze, wq_busy=0):
[  202.029106] hald-addon-stor D    0   909    849 0x20020004
[  202.029113] Call Trace:
[  202.029128]  ? __schedule+0x37f/0x57f
[  202.029134]  ? usleep_range+0x51/0x51
[  202.029139]  schedule+0x7f/0x89
[  202.029144]  schedule_timeout+0x21/0xc7
[  202.029151]  ? check_preempt_curr+0x2e/0x68
[  202.029157]  do_wait_for_common+0x102/0x133
[  202.029163]  ? wake_up_q+0x47/0x47
[  202.029169]  wait_for_common+0x36/0x4e
[  202.029174]  flush_work+0x12e/0x14b
[  202.029179]  ? wake_up_worker+0x25/0x25
[  202.029185]  __cancel_work_timer+0xfb/0x14f
[  202.029190]  ? kobj_lookup+0xfc/0x130
[  202.029196]  disk_block_events+0x5f/0x78
[  202.029202]  __blkdev_get+0xaa/0x3f7
[  202.029207]  blkdev_get+0x83/0x2a3
[  202.029211]  ? bdgrab+0x12/0x17
[  202.029216]  ? bd_acquire+0x3a/0xad
[  202.029220]  ? bd_acquire+0xad/0xad
[  202.029226]  do_dentry_open.isra.22+0x16b/0x22d
[  202.029232]  path_openat+0x98f/0xb27
[  202.029238]  ? _raw_spin_unlock_irqrestore+0x18/0x23
[  202.029243]  do_filp_open+0x4d/0xa3
[  202.029249]  ? __blkdev_put+0x154/0x170
[  202.029254]  ? _cond_resched+0x25/0x29
[  202.029260]  ? slab_pre_alloc_hook+0x2d/0x53
[  202.029265]  ? slab_post_alloc_hook.isra.62+0xa/0x1a
[  202.029270]  ? kmem_cache_alloc+0xa0/0x10b
[  202.029277]  ? do_sys_open+0x6a/0xef
[  202.029281]  do_sys_open+0x6a/0xef
[  202.029287]  do_int80_syscall_32+0x52/0x5f
[  202.029293]  entry_INT80_compat+0x85/0x90
[  202.029316] OOM killer enabled.
[  202.029318] Restarting tasks ... done.
[  202.035210] PM: suspend exit

full dmesg attached

--Boundary-00=_rD9Gb/LkA3KajWW
Content-Type: text/x-log;
  charset="iso 8859-1";
  name="dmesg_4.17-git.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg_4.17-git.log"

[    0.000000] Linux version 4.17.0-x64-08428-g7d3bf613e99a-dirty (guest@slax) (gcc version 4.9.2 (GCC)) #18 SMP Sat Jun 9 10:59:47 MSK 2018
[    0.000000] Command line: BOOT_IMAGE=Lin-4.17-x64 ro root=802 nocd vt.default_utf8=0 scsi_mod.use_blk_mq=1 nouveau.debug=pci=debug log_buf_len=1M
[    0.000000] random: get_random_u32 called from bsp_init_amd+0xd0/0x1af with crng_init=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cd9a8fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd9a9000-0x00000000cdb33fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cdb34000-0x00000000cde7cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cde7d000-0x00000000cea42fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cea43000-0x00000000cea43fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cea44000-0x00000000cec49fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cec4a000-0x00000000cf06dfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cf06e000-0x00000000cf7eefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cf7ef000-0x00000000cf7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec20000-0x00000000fec20fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed61000-0x00000000fed70fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100001000-0x000000032effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: MSI MS-7693/970A-G46 (MS-7693), BIOS V2.8 01/08/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] last_pfn = 0x32f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-CCFFF write-protect
[    0.000000]   CD000-EBFFF uncachable
[    0.000000]   EC000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 base 0000CF800000 mask FFFFFF800000 uncachable
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 000000032f000000 aka 13040M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xcf800000-0xffffffff] usable ==> reserved
[    0.000000] last_pfn = 0xcf800 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd830-0x000fd83f] mapped at [(____ptrval____)]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x02267000, 0x02267fff] PGTABLE
[    0.000000] BRK [0x02268000, 0x02268fff] PGTABLE
[    0.000000] BRK [0x02269000, 0x02269fff] PGTABLE
[    0.000000] BRK [0x0226a000, 0x0226afff] PGTABLE
[    0.000000] BRK [0x0226b000, 0x0226bfff] PGTABLE
[    0.000000] BRK [0x0226c000, 0x0226cfff] PGTABLE
[    0.000000] log_buf_len: 1048576 bytes
[    0.000000] early log buf free: 126604(96%)
[    0.000000] RAMDISK: [mem 0x7fdfe000-0x7fffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000CDE6D070 00005C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CDE73528 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20180508/tbfadt-624)
[    0.000000] ACPI: DSDT 0x00000000CDE6D160 0063C2 (v02 ALASKA A M I    00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000CDE76080 000040
[    0.000000] ACPI: APIC 0x00000000CDE73638 00007E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CDE736B8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000CDE73700 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000CDE73740 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: SSDT 0x00000000CDE73778 000B9C (v01 AMD    POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: IVRS 0x00000000CDE74318 0000C0 (v01 AMD    RD890S   00202031 AMD  00000000)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000032effffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000cd9a8fff]
[    0.000000]   node   0: [mem 0x00000000cea43000-0x00000000cea43fff]
[    0.000000]   node   0: [mem 0x00000000cec4a000-0x00000000cf06dfff]
[    0.000000]   node   0: [mem 0x00000000cf7ef000-0x00000000cf7fffff]
[    0.000000]   node   0: [mem 0x0000000100001000-0x000000032effffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000032effffff]
[    0.000000] On node 0 totalpages: 3132795
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13112 pages used for memmap
[    0.000000]   DMA32 zone: 839135 pages, LIFO batch:31
[    0.000000]   Normal zone: 35776 pages used for memmap
[    0.000000]   Normal zone: 2289663 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 99 pages
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 5, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 6, version 33, address 0xfec20000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcd9a9000-0xcdb33fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcdb34000-0xcde7cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcde7d000-0xcea42fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcea44000-0xcec49fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcf06e000-0xcf7eefff]
[    0.000000] PM: Registered nosave memory: [mem 0xcf800000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfec1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec20000-0xfec20fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec21000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed60fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed61000-0xfed70fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed71000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xffffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x100000000-0x100000fff]
[    0.000000] [mem 0xcf800000-0xfebfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 43 pages/cpu @(____ptrval____) s135384 r8192 d32552 u524288
[    0.000000] pcpu-alloc: s135384 r8192 d32552 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 3083822
[    0.000000] Kernel command line: BOOT_IMAGE=Lin-4.17-x64 ro root=802 nocd vt.default_utf8=0 scsi_mod.use_blk_mq=1 nouveau.debug=pci=debug log_buf_len=1M
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] AGP: Node 0: aperture [bus addr 0x00000000-0x01ffffff] (32MB)
[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM
[    0.000000] AGP: Mapping aperture over RAM [mem 0xc4000000-0xc7ffffff] (65536KB)
[    0.000000] PM: Registered nosave memory: [mem 0xc4000000-0xc7ffffff]
[    0.000000] Memory: 12155708K/12531180K available (8204K kernel code, 979K rwdata, 2564K rodata, 1244K init, 388K bss, 375472K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 27777 entries in 109 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 4352, nr_irqs: 1000, preallocated irqs: 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20180508
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.024000] tsc: Fast TSC calibration using PIT
[    0.028000] tsc: Detected 3800.082 MHz processor
[    0.028000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6d8d4c2c97f, max_idle_ns: 881591139999 ns
[    0.028000] Calibrating delay loop (skipped), value calculated using timer frequency.. 7600.16 BogoMIPS (lpj=15200328)
[    0.028000] pid_max: default: 32768 minimum: 301
[    0.028000] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.028000] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.028000] CPU: Physical Processor ID: 0
[    0.028000] CPU: Processor Core ID: 0
[    0.028000] mce: CPU supports 7 MCE banks
[    0.028000] LVT offset 1 assigned for vector 0xf9
[    0.028000] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.028000] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.028000] Spectre V2 : Vulnerable: Minimal AMD ASM retpoline
[    0.028000] Spectre V2 : Spectre v2 mitigation: Filling RSB on context switch
[    0.028000] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.028000] Freeing SMP alternatives memory: 16K
[    0.036000] smpboot: CPU0: AMD FX(tm)-4300 Quad-Core Processor (family: 0x15, model: 0x2, stepping: 0x0)
[    0.036039] Performance Events: Fam15h core perfctr, AMD PMU driver.
[    0.036098] ... version:                0
[    0.036150] ... bit width:              48
[    0.036201] ... generic registers:      6
[    0.036253] ... value mask:             0000ffffffffffff
[    0.036307] ... max period:             00007fffffffffff
[    0.036360] ... fixed-purpose events:   0
[    0.036412] ... event mask:             000000000000003f
[    0.036497] Hierarchical SRCU implementation.
[    0.036692] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.036761] smp: Bringing up secondary CPUs ...
[    0.036914] x86: Booting SMP configuration:
[    0.036966] .... node  #0, CPUs:      #1 #2 #3
[    0.044025] smp: Brought up 1 node, 4 CPUs
[    0.044109] smpboot: Max logical packages: 1
[    0.044161] smpboot: Total of 4 processors activated (30400.65 BogoMIPS)
[    0.048252] devtmpfs: initialized
[    0.048252] PM: Registering ACPI NVS region [mem 0xcdb34000-0xcde7cfff] (3444736 bytes)
[    0.048252] PM: Registering ACPI NVS region [mem 0xcea44000-0xcec49fff] (2121728 bytes)
[    0.048311] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.048385] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.048484] pinctrl core: initialized pinctrl subsystem
[    0.048688] NET: Registered protocol family 16
[    0.048831] audit: initializing netlink subsys (disabled)
[    0.048889] audit: type=2000 audit(1528543143.048:1): state=initialized audit_enabled=0 res=1
[    0.048889] cpuidle: using governor ladder
[    0.048889] cpuidle: using governor menu
[    0.048889] ACPI: bus type PCI registered
[    0.048889] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.048889] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.048889] PCI: not using MMCONFIG
[    0.048889] PCI: Using configuration type 1 for base access
[    0.048889] PCI: Using configuration type 1 for extended access
[    0.048889] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.048889] ACPI: Added _OSI(Module Device)
[    0.048889] ACPI: Added _OSI(Processor Device)
[    0.048889] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.048889] ACPI: Added _OSI(Processor Aggregator Device)
[    0.048889] ACPI: Added _OSI(Linux-Dell-Video)
[    0.054601] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.056059] ACPI: Interpreter enabled
[    0.056124] ACPI: (supports S0 S3 S4 S5)
[    0.056177] ACPI: Using IOAPIC for interrupt routing
[    0.056376] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.056479] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.056562] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.056777] ACPI: Enabled 11 GPEs in block 00 to 1F
[    0.062200] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.062259] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.062357] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.062632] PCI host bridge to bus 0000:00
[    0.062686] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.062742] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.062798] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.062854] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.062911] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.062979] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.063048] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xffffffff window]
[    0.063116] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.063177] pci 0000:00:00.0: [1002:5a14] type 00 class 0x060000
[    0.063282] pci 0000:00:00.2: [1002:5a23] type 00 class 0x080600
[    0.063379] pci 0000:00:02.0: [1002:5a16] type 01 class 0x060400
[    0.063394] pci 0000:00:02.0: enabling Extended Tags
[    0.063466] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.063549] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
[    0.063564] pci 0000:00:04.0: enabling Extended Tags
[    0.063635] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.063723] pci 0000:00:11.0: [1002:4391] type 00 class 0x010601
[    0.063739] pci 0000:00:11.0: reg 0x10: [io  0xf040-0xf047]
[    0.063745] pci 0000:00:11.0: reg 0x14: [io  0xf030-0xf033]
[    0.063752] pci 0000:00:11.0: reg 0x18: [io  0xf020-0xf027]
[    0.063759] pci 0000:00:11.0: reg 0x1c: [io  0xf010-0xf013]
[    0.063765] pci 0000:00:11.0: reg 0x20: [io  0xf000-0xf00f]
[    0.063772] pci 0000:00:11.0: reg 0x24: [mem 0xfd30b000-0xfd30b3ff]
[    0.063869] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.063882] pci 0000:00:12.0: reg 0x10: [mem 0xfd30a000-0xfd30afff]
[    0.063993] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.064011] pci 0000:00:12.2: reg 0x10: [mem 0xfd309000-0xfd3090ff]
[    0.064069] pci 0000:00:12.2: supports D1 D2
[    0.064070] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.064147] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.064160] pci 0000:00:13.0: reg 0x10: [mem 0xfd308000-0xfd308fff]
[    0.064271] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.064286] pci 0000:00:13.2: reg 0x10: [mem 0xfd307000-0xfd3070ff]
[    0.064344] pci 0000:00:13.2: supports D1 D2
[    0.064345] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.064421] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.064538] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.064557] pci 0000:00:14.2: reg 0x10: [mem 0xfd300000-0xfd303fff 64bit]
[    0.064605] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.064676] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.064794] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.064890] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.064903] pci 0000:00:14.5: reg 0x10: [mem 0xfd306000-0xfd306fff]
[    0.065016] pci 0000:00:15.0: [1002:43a0] type 01 class 0x060400
[    0.065044] pci 0000:00:15.0: enabling Extended Tags
[    0.065128] pci 0000:00:15.0: supports D1 D2
[    0.065213] pci 0000:00:16.0: [1002:4397] type 00 class 0x0c0310
[    0.065226] pci 0000:00:16.0: reg 0x10: [mem 0xfd305000-0xfd305fff]
[    0.065336] pci 0000:00:16.2: [1002:4396] type 00 class 0x0c0320
[    0.065351] pci 0000:00:16.2: reg 0x10: [mem 0xfd304000-0xfd3040ff]
[    0.065409] pci 0000:00:16.2: supports D1 D2
[    0.065410] pci 0000:00:16.2: PME# supported from D0 D1 D2 D3hot
[    0.065486] pci 0000:00:18.0: [1022:1600] type 00 class 0x060000
[    0.065559] pci 0000:00:18.1: [1022:1601] type 00 class 0x060000
[    0.065626] pci 0000:00:18.2: [1022:1602] type 00 class 0x060000
[    0.065693] pci 0000:00:18.3: [1022:1603] type 00 class 0x060000
[    0.065763] pci 0000:00:18.4: [1022:1604] type 00 class 0x060000
[    0.065829] pci 0000:00:18.5: [1022:1605] type 00 class 0x060000
[    0.065930] pci 0000:01:00.0: [10de:0606] type 00 class 0x030000
[    0.065942] pci 0000:01:00.0: reg 0x10: [mem 0xfc000000-0xfcffffff]
[    0.065948] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.065955] pci 0000:01:00.0: reg 0x1c: [mem 0xfa000000-0xfbffffff 64bit]
[    0.065988] pci 0000:01:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.065992] pci 0000:01:00.0: reg 0x30: [mem 0xfd000000-0xfd01ffff pref]
[    0.065996] pci 0000:01:00.0: enabling Extended Tags
[    0.066122] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.066177] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.066179] pci 0000:00:02.0:   bridge window [mem 0xfa000000-0xfd0fffff]
[    0.066181] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.066217] pci 0000:02:00.0: [1b21:1042] type 00 class 0x0c0330
[    0.066240] pci 0000:02:00.0: reg 0x10: [mem 0xfd200000-0xfd207fff 64bit]
[    0.066328] pci 0000:02:00.0: PME# supported from D3hot
[    0.066391] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.066447] pci 0000:00:04.0:   bridge window [mem 0xfd200000-0xfd2fffff]
[    0.066456] pci_bus 0000:03: extended config space not accessible
[    0.066560] pci 0000:00:14.4: PCI bridge to [bus 03] (subtractive decode)
[    0.066621] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.066623] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.066625] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.066626] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.066627] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.066628] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.066629] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xffffffff window] (subtractive decode)
[    0.066676] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.066702] pci 0000:04:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.066727] pci 0000:04:00.0: reg 0x18: [mem 0xfd104000-0xfd104fff 64bit pref]
[    0.066742] pci 0000:04:00.0: reg 0x20: [mem 0xfd100000-0xfd103fff 64bit pref]
[    0.066824] pci 0000:04:00.0: supports D1 D2
[    0.066825] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.066919] pci 0000:00:15.0: PCI bridge to [bus 04]
[    0.066975] pci 0000:00:15.0:   bridge window [io  0xd000-0xdfff]
[    0.066978] pci 0000:00:15.0:   bridge window [mem 0xfd100000-0xfd1fffff]
[    0.066995] pci_bus 0000:00: on NUMA node 0
[    0.067316] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 10 11 14 15) *0
[    0.067427] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 10 11 14 15) *0
[    0.067542] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 11 14 15) *0
[    0.067653] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 10 11 14 15) *0
[    0.067754] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 10 11 14 15) *0
[    0.067846] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 10 11 14 15) *0
[    0.067937] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7 10 11 14 15) *0
[    0.068033] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 14 15) *0
[    0.068220] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.068220] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.068220] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.068220] vgaarb: loaded
[    0.068306] pps_core: LinuxPPS API ver. 1 registered
[    0.068360] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.068433] PTP clock support registered
[    0.068487] EDAC MC: Ver: 3.0.0
[    0.068599] PCI: Using ACPI for IRQ routing
[    0.073445] PCI: pci_cache_line_size set to 64 bytes
[    0.073487] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    0.073488] e820: reserve RAM buffer [mem 0xcd9a9000-0xcfffffff]
[    0.073489] e820: reserve RAM buffer [mem 0xcea44000-0xcfffffff]
[    0.073490] e820: reserve RAM buffer [mem 0xcf06e000-0xcfffffff]
[    0.073491] e820: reserve RAM buffer [mem 0xcf800000-0xcfffffff]
[    0.073491] e820: reserve RAM buffer [mem 0x32f000000-0x32fffffff]
[    0.073620] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.073675] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.076002] clocksource: Switched to clocksource tsc-early
[    0.086679] VFS: Disk quotas dquot_6.6.0
[    0.086746] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.086839] pnp: PnP ACPI init
[    0.087006] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
[    0.087066] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.087282] system 00:01: [io  0x040b] has been reserved
[    0.087337] system 00:01: [io  0x04d6] has been reserved
[    0.087391] system 00:01: [io  0x0c00-0x0c01] has been reserved
[    0.087476] system 00:01: [io  0x0c14] has been reserved
[    0.087530] system 00:01: [io  0x0c50-0x0c51] has been reserved
[    0.087585] system 00:01: [io  0x0c52] has been reserved
[    0.087639] system 00:01: [io  0x0c6c] has been reserved
[    0.087694] system 00:01: [io  0x0c6f] has been reserved
[    0.087748] system 00:01: [io  0x0cd0-0x0cd1] has been reserved
[    0.087803] system 00:01: [io  0x0cd2-0x0cd3] has been reserved
[    0.087858] system 00:01: [io  0x0cd4-0x0cd5] has been reserved
[    0.087913] system 00:01: [io  0x0cd6-0x0cd7] has been reserved
[    0.087968] system 00:01: [io  0x0cd8-0x0cdf] has been reserved
[    0.088023] system 00:01: [io  0x0800-0x089f] has been reserved
[    0.088078] system 00:01: [io  0x0b20-0x0b3f] has been reserved
[    0.088133] system 00:01: [io  0x0900-0x090f] has been reserved
[    0.088188] system 00:01: [io  0x0910-0x091f] has been reserved
[    0.088246] system 00:01: [io  0xfe00-0xfefe] has been reserved
[    0.088302] system 00:01: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.088359] system 00:01: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.088416] system 00:01: [mem 0xfed80000-0xfed8ffff] has been reserved
[    0.088472] system 00:01: [mem 0xfed61000-0xfed70fff] has been reserved
[    0.088528] system 00:01: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.088585] system 00:01: [mem 0xfed00000-0xfed00fff] could not be reserved
[    0.088671] system 00:01: [mem 0xff800000-0xffffffff] has been reserved
[    0.088729] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.088839] system 00:02: [io  0x0480-0x0481] has been reserved
[    0.088897] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.089063] pnp 00:03: [dma 0 disabled]
[    0.089099] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.089122] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.089171] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.089229] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.089265] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.089388] system 00:07: [mem 0xfeb20000-0xfeb23fff] could not be reserved
[    0.089447] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.089533] system 00:08: [mem 0xfec20000-0xfec200ff] could not be reserved
[    0.089592] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.089684] pnp: PnP ACPI: found 9 devices
[    0.095802] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.095890] pci 0000:00:02.0: PCI bridge to [bus 01]
[    0.095945] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    0.096030] pci 0000:00:02.0:   bridge window [mem 0xfa000000-0xfd0fffff]
[    0.096087] pci 0000:00:02.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.096157] pci 0000:00:04.0: PCI bridge to [bus 02]
[    0.096212] pci 0000:00:04.0:   bridge window [mem 0xfd200000-0xfd2fffff]
[    0.096272] pci 0000:00:14.4: PCI bridge to [bus 03]
[    0.096333] pci 0000:00:15.0: PCI bridge to [bus 04]
[    0.096387] pci 0000:00:15.0:   bridge window [io  0xd000-0xdfff]
[    0.096444] pci 0000:00:15.0:   bridge window [mem 0xfd100000-0xfd1fffff]
[    0.096505] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.096506] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.096507] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.096508] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.096510] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.096511] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.096512] pci_bus 0000:00: resource 10 [mem 0xd0000000-0xffffffff window]
[    0.096513] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.096514] pci_bus 0000:01: resource 1 [mem 0xfa000000-0xfd0fffff]
[    0.096515] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.096516] pci_bus 0000:02: resource 1 [mem 0xfd200000-0xfd2fffff]
[    0.096517] pci_bus 0000:03: resource 4 [io  0x0000-0x03af window]
[    0.096518] pci_bus 0000:03: resource 5 [io  0x03e0-0x0cf7 window]
[    0.096519] pci_bus 0000:03: resource 6 [io  0x03b0-0x03df window]
[    0.096520] pci_bus 0000:03: resource 7 [io  0x0d00-0xffff window]
[    0.096521] pci_bus 0000:03: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.096522] pci_bus 0000:03: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.096523] pci_bus 0000:03: resource 10 [mem 0xd0000000-0xffffffff window]
[    0.096524] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.096525] pci_bus 0000:04: resource 1 [mem 0xfd100000-0xfd1fffff]
[    0.096574] NET: Registered protocol family 2
[    0.096738] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes)
[    0.096851] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.097209] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.097537] TCP: Hash tables configured (established 131072 bind 65536)
[    0.097637] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.097766] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.097905] NET: Registered protocol family 1
[    0.188304] pci 0000:00:12.0: quirk_usb_early_handoff+0x0/0x615 took 88210 usecs
[    0.276294] pci 0000:00:13.0: quirk_usb_early_handoff+0x0/0x615 took 85745 usecs
[    0.364289] pci 0000:00:14.5: quirk_usb_early_handoff+0x0/0x615 took 85745 usecs
[    0.452285] pci 0000:00:16.0: quirk_usb_early_handoff+0x0/0x615 took 85859 usecs
[    0.452506] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.452694] PCI: CLS 64 bytes, default 64
[    0.452728] Trying to unpack rootfs image as initramfs...
[    0.480026] Freeing initrd memory: 2056K
[    0.480525] iommu: Adding device 0000:00:00.0 to group 0
[    0.480641] iommu: Adding device 0000:00:02.0 to group 1
[    0.480751] iommu: Adding device 0000:00:04.0 to group 2
[    0.480871] iommu: Adding device 0000:00:11.0 to group 3
[    0.480992] iommu: Adding device 0000:00:12.0 to group 4
[    0.481057] iommu: Adding device 0000:00:12.2 to group 4
[    0.481183] iommu: Adding device 0000:00:13.0 to group 5
[    0.481249] iommu: Adding device 0000:00:13.2 to group 5
[    0.485241] iommu: Adding device 0000:00:14.0 to group 6
[    0.485394] iommu: Adding device 0000:00:14.2 to group 7
[    0.485514] iommu: Adding device 0000:00:14.3 to group 8
[    0.485636] iommu: Adding device 0000:00:14.4 to group 9
[    0.485759] iommu: Adding device 0000:00:14.5 to group 10
[    0.485894] iommu: Adding device 0000:00:15.0 to group 11
[    0.486016] iommu: Adding device 0000:00:16.0 to group 12
[    0.486083] iommu: Adding device 0000:00:16.2 to group 12
[    0.486204] iommu: Adding device 0000:01:00.0 to group 13
[    0.486318] iommu: Adding device 0000:02:00.0 to group 14
[    0.486383] iommu: Adding device 0000:04:00.0 to group 11
[    0.526932] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[    0.526986] AMD-Vi: Interrupt remapping enabled
[    0.527120] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.528879] amd_uncore: AMD NB counters detected
[    0.528998] LVT offset 0 assigned for vector 0x400
[    0.529082] perf: AMD IBS detected (0x000000ff)
[    0.529454] Scanning for low memory corruption every 60 seconds
[    0.529859] Initialise system trusted keyrings
[    0.529942] workingset: timestamp_bits=46 max_order=22 bucket_order=0
[    0.531101] pstore: using deflate compression
[    0.531608] Key type asymmetric registered
[    0.531660] Asymmetric key parser 'x509' registered
[    0.531761] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.531868] io scheduler noop registered
[    0.531948] io scheduler cfq registered (default)
[    0.532001] io scheduler mq-deadline registered
[    0.532054] io scheduler kyber registered
[    0.532122] io scheduler bfq registered
[    0.535305] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.555726] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.556626] brd: module loaded
[    0.556865] i8042: PNP: No PS/2 controller found.
[    0.556998] NET: Registered protocol family 17
[    0.557432] microcode: CPU0: patch_level=0x06000822
[    0.557491] microcode: CPU1: patch_level=0x06000822
[    0.557547] microcode: CPU2: patch_level=0x06000822
[    0.557606] microcode: CPU3: patch_level=0x06000822
[    0.557683] microcode: Microcode Update Driver: v2.2.
[    0.557691] sched_clock: Marking stable (557679715, 0)->(639006682, -81326967)
[    0.557936] registered taskstats version 1
[    0.557993] Loading compiled-in X.509 certificates
[    0.558967] zswap: default zpool zbud not available
[    0.559022] zswap: pool creation failed
[    0.559256] hctosys: unable to open rtc device (rtc0)
[    0.560915] Freeing unused kernel memory: 1244K
[    0.578248] Write protecting the kernel read-only data: 14336k
[    0.578946] Freeing unused kernel memory: 2020K
[    0.582853] Freeing unused kernel memory: 1532K
[    0.602656] SCSI subsystem initialized
[    0.615970] libata version 3.00 loaded.
[    0.620017] ahci 0000:00:11.0: version 3.0
[    0.620185] ahci 0000:00:11.0: AHCI 0001.0200 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    0.620258] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part 
[    0.620907] scsi host0: ahci
[    0.621102] scsi host1: ahci
[    0.621275] scsi host2: ahci
[    0.621448] scsi host3: ahci
[    0.621628] scsi host4: ahci
[    0.621795] scsi host5: ahci
[    0.621916] ata1: SATA max UDMA/133 abar m1024@0xfd30b000 port 0xfd30b100 irq 19
[    0.622015] ata2: SATA max UDMA/133 abar m1024@0xfd30b000 port 0xfd30b180 irq 19
[    0.622083] ata3: SATA max UDMA/133 abar m1024@0xfd30b000 port 0xfd30b200 irq 19
[    0.622152] ata4: SATA max UDMA/133 abar m1024@0xfd30b000 port 0xfd30b280 irq 19
[    0.622221] ata5: SATA max UDMA/133 abar m1024@0xfd30b000 port 0xfd30b300 irq 19
[    0.622302] ata6: SATA max UDMA/133 abar m1024@0xfd30b000 port 0xfd30b380 irq 19
[    0.936280] ata3: SATA link down (SStatus 0 SControl 300)
[    0.938235] ata4: SATA link down (SStatus 0 SControl 300)
[    0.940280] ata6: SATA link down (SStatus 0 SControl 300)
[    0.942235] ata5: SATA link down (SStatus 0 SControl 300)
[    1.105775] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.106786] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.106947] ata2.00: ATAPI: DRW-24D5MT, 1.00, max UDMA/133
[    1.108774] ata2.00: configured for UDMA/133
[    1.110919] ata1.00: ATA-7: SAMSUNG HD300LJ, ZT100-12, max UDMA7
[    1.110975] ata1.00: 586072368 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.115227] ata1.00: configured for UDMA/133
[    1.115548] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD300LJ  0-12 PQ: 0 ANSI: 5
[    1.116437] scsi 1:0:0:0: CD-ROM            ASUS     DRW-24D5MT       1.00 PQ: 0 ANSI: 5
[    1.150180] sd 0:0:0:0: [sda] 586072368 512-byte logical blocks: (300 GB/279 GiB)
[    1.150254] sd 0:0:0:0: [sda] Write Protect is off
[    1.150308] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.150316] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.166200]  sda: sda1 sda2 sda3
[    1.166713] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.504086] tsc: Refined TSC clocksource calibration: 3800.108 MHz
[    1.504168] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d8d7b0e4ce, max_idle_ns: 881590614467 ns
[    1.504286] clocksource: Switched to clocksource tsc
[    2.200168] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    2.448880] random: fast init done
[    3.959852] udev[154]: starting version 165
[    4.307107] MCE: In-kernel MCE decoding enabled.
[    4.369329] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.369459] scsi 1:0:0:0: Attached scsi generic sg1 type 5
[    4.370505] rtc_cmos 00:04: RTC can wake from S4
[    4.370691] rtc_cmos 00:04: registered as rtc0
[    4.370770] rtc_cmos 00:04: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    4.387223] acpi_cpufreq: overriding BIOS provided _PSD data
[    4.421453] EDAC amd64: Node 0: DRAM ECC disabled.
[    4.421509] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
[    4.421509]  Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
[    4.421509]  (Note that use of the override may cause unknown side effects.)
[    4.434869] sr 1:0:0:0: [sr0] scsi3-mmc drive: 48x/12x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.434942] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.435185] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    4.460291] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    4.460388] ACPI: Power Button [PWRB]
[    4.460523] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    4.460607] ACPI: Power Button [PWRF]
[    4.521896] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    4.521972] piix4_smbus 0000:00:14.0: Using register 0x2c for SMBus port selection
[    4.522124] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    4.741039] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    4.741132] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[    4.741795] r8169 0000:04:00.0 eth0: RTL8168evl/8111evl, d8:cb:8a:56:80:48, XID 2c900800, IRQ 27
[    4.741866] r8169 0000:04:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    4.986952] r8169 0000:04:00.0 eth6: renamed from eth0
[    5.000196] udev[157]: renamed network interface eth0 to eth6
[    5.052556] ACPI: bus type USB registered
[    5.052829] usbcore: registered new interface driver usbfs
[    5.052980] usbcore: registered new interface driver hub
[    5.053188] usbcore: registered new device driver usb
[    5.119078] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.136366] ehci-pci: EHCI PCI platform driver
[    5.136557] QUIRK: Enable AMD PLL fix
[    5.136576] ehci-pci 0000:00:12.2: EHCI Host Controller
[    5.136635] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    5.136709] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    5.136786] ehci-pci 0000:00:12.2: debug port 1
[    5.136875] ehci-pci 0000:00:12.2: irq 17, io mem 0xfd309000
[    5.144049] kvm: Nested Virtualization enabled
[    5.144107] kvm: Nested Paging enabled
[    5.156017] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    5.156269] hub 1-0:1.0: USB hub found
[    5.156329] hub 1-0:1.0: 5 ports detected
[    5.156568] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    5.156600] cryptd: max_cpu_qlen set to 1000
[    5.156631] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
[    5.166355] xhci_hcd 0000:02:00.0: hcc params 0x0200f180 hci version 0x96 quirks 0x0000000000080000
[    5.166734] hub 2-0:1.0: USB hub found
[    5.166793] hub 2-0:1.0: 2 ports detected
[    5.166952] ehci-pci 0000:00:13.2: EHCI Host Controller
[    5.166964] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    5.167041] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 3
[    5.167104] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 4
[    5.167171] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    5.167238] xhci_hcd 0000:02:00.0: Host supports USB 3.0  SuperSpeed
[    5.167341] ehci-pci 0000:00:13.2: debug port 1
[    5.167421] ehci-pci 0000:00:13.2: irq 17, io mem 0xfd307000
[    5.167480] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    5.167666] hub 4-0:1.0: USB hub found
[    5.167725] hub 4-0:1.0: 2 ports detected
[    5.183858] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.184016] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    5.184273] hub 3-0:1.0: USB hub found
[    5.184566] hub 3-0:1.0: 5 ports detected
[    5.184890] ehci-pci 0000:00:16.2: EHCI Host Controller
[    5.184948] ehci-pci 0000:00:16.2: new USB bus registered, assigned bus number 5
[    5.185019] ehci-pci 0000:00:16.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    5.185097] ehci-pci 0000:00:16.2: debug port 1
[    5.185175] ehci-pci 0000:00:16.2: irq 17, io mem 0xfd304000
[    5.193439] Linux agpgart interface v0.103
[    5.200305] ehci-pci 0000:00:16.2: USB 2.0 started, EHCI 1.00
[    5.200707] hub 5-0:1.0: USB hub found
[    5.200775] hub 5-0:1.0: 4 ports detected
[    5.280118] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC892: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[    5.280197] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    5.280266] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    5.280335] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    5.280398] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[    5.280454] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    5.280484] pktcdvd: pktcdvd0: writer mapped to sr0
[    5.280511] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    5.280651] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    5.280708] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    5.286430] ohci-pci: OHCI PCI platform driver
[    5.286613] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    5.286702] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 6
[    5.286809] ohci-pci 0000:00:12.0: irq 18, io mem 0xfd30a000
[    5.296570] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input2
[    5.296711] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input3
[    5.297101] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input4
[    5.297258] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input5
[    5.297398] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input6
[    5.297813] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[    5.297959] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[    5.298319] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[    5.348184] hub 6-0:1.0: USB hub found
[    5.348250] hub 6-0:1.0: 5 ports detected
[    5.348541] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    5.348599] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 7
[    5.348688] ohci-pci 0000:00:13.0: irq 18, io mem 0xfd308000
[    5.412179] hub 7-0:1.0: USB hub found
[    5.412241] hub 7-0:1.0: 5 ports detected
[    5.412529] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    5.412587] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 8
[    5.412678] ohci-pci 0000:00:14.5: irq 18, io mem 0xfd306000
[    5.417674] AVX version of gcm_enc/dec engaged.
[    5.417730] AES CTR mode by8 optimization enabled
[    5.476247] hub 8-0:1.0: USB hub found
[    5.476311] hub 8-0:1.0: 2 ports detected
[    5.476573] ohci-pci 0000:00:16.0: OHCI PCI host controller
[    5.476633] ohci-pci 0000:00:16.0: new USB bus registered, assigned bus number 9
[    5.476721] ohci-pci 0000:00:16.0: irq 18, io mem 0xfd305000
[    5.544178] hub 9-0:1.0: USB hub found
[    5.544262] hub 9-0:1.0: 4 ports detected
[    5.716098] usb 6-2: new full-speed USB device number 2 using ohci-pci
[    6.160247] MXM: GUID detected in BIOS
[    6.160496] nouveau 0000:01:00.0: NVIDIA G92 (092300a2)
[    6.160613] nouveau 0000:01:00.0: pci: MSI enabled
[    6.249011] Bluetooth: Core ver 2.22
[    6.249320] NET: Registered protocol family 31
[    6.249615] Bluetooth: HCI device and connection manager initialized
[    6.249944] Bluetooth: HCI socket layer initialized
[    6.250238] Bluetooth: L2CAP socket layer initialized
[    6.250535] Bluetooth: SCO socket layer initialized
[    6.270104] nouveau 0000:01:00.0: bios: version 62.92.1f.00.09
[    6.290467] nouveau 0000:01:00.0: pci: pcie max speed: 5.0GT/s
[    6.290550] nouveau 0000:01:00.0: fb: 384 MiB GDDR3
[    6.351654] [TTM] Zone  kernel: Available graphics memory: 6114264 kiB
[    6.351711] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    6.351766] [TTM] Initializing pool allocator
[    6.351822] [TTM] Initializing DMA pool allocator
[    6.351884] nouveau 0000:01:00.0: DRM: VRAM: 384 MiB
[    6.351938] nouveau 0000:01:00.0: DRM: GART: 1048576 MiB
[    6.351994] nouveau 0000:01:00.0: DRM: TMDS table version 2.0
[    6.352059] nouveau 0000:01:00.0: DRM: DCB version 4.0
[    6.352114] nouveau 0000:01:00.0: DRM: DCB outp 00: 02000300 00000028
[    6.352170] nouveau 0000:01:00.0: DRM: DCB outp 01: 01000302 00000030
[    6.352255] nouveau 0000:01:00.0: DRM: DCB outp 02: 02011312 00020010
[    6.352311] nouveau 0000:01:00.0: DRM: DCB outp 03: 010223f1 00c0c083
[    6.352367] nouveau 0000:01:00.0: DRM: DCB conn 00: 00001030
[    6.352421] nouveau 0000:01:00.0: DRM: DCB conn 01: 00002130
[    6.352475] nouveau 0000:01:00.0: DRM: DCB conn 02: 00000210
[    6.352530] nouveau 0000:01:00.0: DRM: DCB conn 03: 00000211
[    6.352584] nouveau 0000:01:00.0: DRM: DCB conn 04: 00000213
[    6.352638] nouveau 0000:01:00.0: DRM: DCB conn 05: 00000362
[    6.363876] nouveau 0000:01:00.0: DRM: failed to create encoder 0/1/0: -19
[    6.363935] nouveau 0000:01:00.0: DRM: TV-1 has no encoders, removing
[    6.364031] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    6.364088] [drm] Driver supports precise vblank timestamp query.
[    6.365767] nouveau 0000:01:00.0: DRM: MM: using CRYPT for buffer copies
[    6.396429] nouveau 0000:01:00.0: DRM: allocated 1440x900 fb: 0x50000, bo (____ptrval____)
[    6.396764] usbcore: registered new interface driver btusb
[    6.397245] fbcon: nouveaufb (fb0) is primary device
[    6.496895] Console: switching to colour frame buffer device 180x56
[    6.500171] nouveau 0000:01:00.0: fb0: nouveaufb frame buffer device
[    6.520116] [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 0
[    6.600088] usb 6-3: new low-speed USB device number 3 using ohci-pci
[    6.852945] hidraw: raw HID events driver (C) Jiri Kosina
[    6.874177] usbcore: registered new interface driver usbhid
[    6.874185] usbhid: USB HID core driver
[    6.891000] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb6/6-3/6-3:1.0/0003:046D:C077.0001/input/input10
[    6.891081] hid-generic 0003:046D:C077.0001: input,hidraw0: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:00:12.0-3/input0
[    6.904947] mousedev: PS/2 mouse device common for all mice
[    7.380090] usb 6-4: new low-speed USB device number 4 using ohci-pci
[    7.583517] input: SONiX USB Keyboard as /devices/pci0000:00/0000:00:12.0/usb6/6-4/6-4:1.0/0003:0C45:760B.0002/input/input11
[    7.640364] hid-generic 0003:0C45:760B.0002: input,hidraw1: USB HID v1.11 Keyboard [SONiX USB Keyboard] on usb-0000:00:12.0-4/input0
[    7.644527] input: SONiX USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:12.0/usb6/6-4/6-4:1.1/0003:0C45:760B.0003/input/input12
[    7.704348] input: SONiX USB Keyboard System Control as /devices/pci0000:00/0000:00:12.0/usb6/6-4/6-4:1.1/0003:0C45:760B.0003/input/input13
[    7.704491] hid-generic 0003:0C45:760B.0003: input,hidraw2: USB HID v1.11 Device [SONiX USB Keyboard] on usb-0000:00:12.0-4/input1
[    8.325832] Adding 1172476k swap on /dev/sda1.  Priority:-2 extents:1 across:1172476k FS
[    8.341306] EXT4-fs (sda2): re-mounted. Opts: (null)
[    8.955364] f71882fg: Found f71889a chip at 0x480, revision 49
[    8.955698] f71882fg f71882fg.1152: Fan: 1 is in duty-cycle mode
[    8.956384] f71882fg f71882fg.1152: Fan: 2 is in duty-cycle mode
[    8.957439] f71882fg f71882fg.1152: Fan: 3 is in duty-cycle mode
[    8.958500] f71882fg f71882fg.1152: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    9.008267] lp: driver loaded but no devices found
[    9.153141] SGI XFS with ACLs, security attributes, no debug enabled
[    9.185840] XFS (sda3): Mounting V4 Filesystem
[    9.389083] XFS (sda3): Ending clean mount
[    9.629369] random: dd: uninitialized urandom read (4096 bytes read)
[   11.469440] r8169 0000:04:00.0 eth6: link down
[   11.469496] r8169 0000:04:00.0 eth6: link down
[   13.121361] r8169 0000:04:00.0 eth6: link up
[   13.168386] random: dhcpcd: uninitialized urandom read (120 bytes read)
[   19.740857] NET: Registered protocol family 10
[   19.741198] Segment Routing with IPv6
[   19.741681] random: cupsd: uninitialized urandom read (4096 bytes read)
[   20.628267] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   20.754361] random: dbus-daemon: uninitialized urandom read (12 bytes read)
[   21.325745] random: hald: uninitialized urandom read (10 bytes read)
[   21.325846] random: hald: uninitialized urandom read (12 bytes read)
[   24.965287] microcode: CPU1: new patch_level=0x06000852
[   24.980044] microcode: CPU3: new patch_level=0x06000852
[   24.980110] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
[   24.980112] x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
[   25.203441] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[   25.203445] Bluetooth: HIDP socket layer initialized
[   25.387047] Bluetooth: RFCOMM TTY layer initialized
[   25.387051] Bluetooth: RFCOMM socket layer initialized
[   25.387055] Bluetooth: RFCOMM ver 1.11
[   25.387356] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   25.387357] Bluetooth: BNEP filters: protocol multicast
[   25.387360] Bluetooth: BNEP socket layer initialized
[   25.474022] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   27.037402] random: crng init done
[   27.037406] random: 2 urandom warning(s) missed due to ratelimiting
[   35.040167] ------------[ cut here ]------------
[   35.040171] kernel BUG at drivers/scsi/scsi_error.c:197!
[   35.040196] invalid opcode: 0000 [#1] SMP NOPTI
[   35.040210] CPU: 2 PID: 117 Comm: kworker/2:1H Not tainted 4.17.0-x64-08428-g7d3bf613e99a-dirty #18
[   35.040225] Hardware name: MSI MS-7693/970A-G46 (MS-7693), BIOS V2.8 01/08/2016
[   35.040244] Workqueue: kblockd blk_mq_timeout_work
[   35.040283] RIP: 0010:scsi_times_out+0xe9/0x1a6 [scsi_mod]
[   35.040287] Code: 03 76 18 48 c7 c2 f9 c2 01 a0 48 89 ee 48 c7 c7 14 be 01 a0 31 c0 e8 76 ad 00 00 48 8b 83 98 01 00 00 a8 01 0f 84 a5 00 00 00 <0f> 0b 49 8b 7c 24 38 e8 8f ba 4b e1 41 83 bc 24 2c 01 00 00 ff 74 
[   35.040312] RSP: 0018:ffffc90000293d98 EFLAGS: 00010202
[   35.040318] RAX: ffff88031f240605 RBX: ffff88031eed8500 RCX: 00000000fffefd40
[   35.040323] RDX: ffffc90000293e80 RSI: 0000000000002007 RDI: ffff88031eed8638
[   35.040327] RBP: ffff88031eed8638 R08: ffff88031eed85d8 R09: 0000000000000000
[   35.040332] R10: 0000000000000040 R11: fefefefefefefeff R12: ffff88031f2a8800
[   35.040336] R13: ffff88031f2a8800 R14: ffff88031f29e910 R15: 0000000000000001
[   35.040341] FS:  0000000000000000(0000) GS:ffff88032ed00000(0000) knlGS:0000000000000000
[   35.040346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.040350] CR2: 00000000f7ea83c0 CR3: 000000031e194000 CR4: 00000000000406e0
[   35.040354] Call Trace:
[   35.040360]  blk_mq_check_expired+0xdc/0x10c
[   35.040365]  bt_iter+0x42/0x45
[   35.040369]  __sbitmap_for_each_set.constprop.12+0x83/0xac
[   35.040374]  ? blk_mq_update_nr_requests+0xad/0xad
[   35.040595]  ? blk_mq_exit_hctx+0xda/0xda
[   35.041595]  blk_mq_queue_tag_busy_iter+0xa3/0xb4
[   35.042578]  ? blk_mq_exit_hctx+0xda/0xda
[   35.043550]  blk_mq_timeout_work+0x6b/0xca
[   35.044505]  process_one_work+0x17c/0x2a6
[   35.045445]  worker_thread+0x19f/0x243
[   35.046393]  ? rescuer_thread+0x262/0x262
[   35.047346]  kthread+0x100/0x108
[   35.048290]  ? kthread_destroy_worker+0x3e/0x3e
[   35.049242]  ret_from_fork+0x27/0x50
[   35.050192] Modules linked in: bridge stp llc bnep rfcomm hidp snd_aloop ipv6 pcmcia pcmcia_core xfs libcrc32c lp parport f71882fg input_leds mousedev hid_generic usbhid hid btusb btintel btbcm btrtl bluetooth nouveau ecdh_generic rfkill morus1280_sse2 morus1280_glue morus640_sse2 morus640_glue ttm drm_kms_helper ghash_clmulni_intel drm crct10dif_pclmul crc32_pclmul drm_panel_orientation_quirks crc32c_intel aegis256_aesni cfbcopyarea fb_sys_fops sysimgblt pcbc sysfillrect cfbimgblt syscopyarea cfbfillrect aesni_intel glue_helper i2c_algo_bit crypto_simd aes_x86_64 ohci_pci snd_hda_codec_realtek aegis128l_aesni pktcdvd aegis128_aesni agpgart ohci_hcd snd_hda_codec_generic cryptd xhci_pci kvm_amd xhci_hcd ehci_pci snd_hda_intel ehci_hcd snd_hda_codec kvm usbcore led_class snd_hda_core video usb_common
[   35.055814]  backlight irqbypass fb snd_hwdep snd_pcm mxm_wmi r8169 fbdev mac_hid fam15h_power k10temp mii snd_timer ccp evdev snd rng_core hwmon wmi i2c_piix4 sha1_generic sha256_generic button soundcore font sr_mod acpi_cpufreq rtc_cmos sg i2c_core cdrom edac_mce_amd sd_mod ahci libahci libata scsi_mod [last unloaded: pcmcia_core]
[   35.058426] ---[ end trace fdc9e8c678138a75 ]---
[   35.059725] RIP: 0010:scsi_times_out+0xe9/0x1a6 [scsi_mod]
[   35.059726] Code: 03 76 18 48 c7 c2 f9 c2 01 a0 48 89 ee 48 c7 c7 14 be 01 a0 31 c0 e8 76 ad 00 00 48 8b 83 98 01 00 00 a8 01 0f 84 a5 00 00 00 <0f> 0b 49 8b 7c 24 38 e8 8f ba 4b e1 41 83 bc 24 2c 01 00 00 ff 74 
[   35.063794] RSP: 0018:ffffc90000293d98 EFLAGS: 00010202
[   35.063796] RAX: ffff88031f240605 RBX: ffff88031eed8500 RCX: 00000000fffefd40
[   35.063797] RDX: ffffc90000293e80 RSI: 0000000000002007 RDI: ffff88031eed8638
[   35.063798] RBP: ffff88031eed8638 R08: ffff88031eed85d8 R09: 0000000000000000
[   35.069198] R10: 0000000000000040 R11: fefefefefefefeff R12: ffff88031f2a8800
[   35.069198] R13: ffff88031f2a8800 R14: ffff88031f29e910 R15: 0000000000000001
[   35.069200] FS:  0000000000000000(0000) GS:ffff88032ed00000(0000) knlGS:0000000000000000
[   35.073191] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.073192] CR2: 00000000f7ea83c0 CR3: 000000031e194000 CR4: 00000000000406e0
[   96.255633] start_kdeinit (1054): /proc/1054/oom_adj is deprecated, please use /proc/1054/oom_score_adj instead.
[  181.912985] PM: suspend entry (deep)
[  181.912993] PM: Syncing filesystems ... done.
[  182.026561] Freezing user space processes ... 
[  202.029084] Freezing of tasks failed after 20.002 seconds (1 tasks refusing to freeze, wq_busy=0):
[  202.029106] hald-addon-stor D    0   909    849 0x20020004
[  202.029113] Call Trace:
[  202.029128]  ? __schedule+0x37f/0x57f
[  202.029134]  ? usleep_range+0x51/0x51
[  202.029139]  schedule+0x7f/0x89
[  202.029144]  schedule_timeout+0x21/0xc7
[  202.029151]  ? check_preempt_curr+0x2e/0x68
[  202.029157]  do_wait_for_common+0x102/0x133
[  202.029163]  ? wake_up_q+0x47/0x47
[  202.029169]  wait_for_common+0x36/0x4e
[  202.029174]  flush_work+0x12e/0x14b
[  202.029179]  ? wake_up_worker+0x25/0x25
[  202.029185]  __cancel_work_timer+0xfb/0x14f
[  202.029190]  ? kobj_lookup+0xfc/0x130
[  202.029196]  disk_block_events+0x5f/0x78
[  202.029202]  __blkdev_get+0xaa/0x3f7
[  202.029207]  blkdev_get+0x83/0x2a3
[  202.029211]  ? bdgrab+0x12/0x17
[  202.029216]  ? bd_acquire+0x3a/0xad
[  202.029220]  ? bd_acquire+0xad/0xad
[  202.029226]  do_dentry_open.isra.22+0x16b/0x22d
[  202.029232]  path_openat+0x98f/0xb27
[  202.029238]  ? _raw_spin_unlock_irqrestore+0x18/0x23
[  202.029243]  do_filp_open+0x4d/0xa3
[  202.029249]  ? __blkdev_put+0x154/0x170
[  202.029254]  ? _cond_resched+0x25/0x29
[  202.029260]  ? slab_pre_alloc_hook+0x2d/0x53
[  202.029265]  ? slab_post_alloc_hook.isra.62+0xa/0x1a
[  202.029270]  ? kmem_cache_alloc+0xa0/0x10b
[  202.029277]  ? do_sys_open+0x6a/0xef
[  202.029281]  do_sys_open+0x6a/0xef
[  202.029287]  do_int80_syscall_32+0x52/0x5f
[  202.029293]  entry_INT80_compat+0x85/0x90
[  202.029316] OOM killer enabled.
[  202.029318] Restarting tasks ... done.
[  202.035210] PM: suspend exit
[  211.694115] PM: suspend entry (deep)
[  211.694124] PM: Syncing filesystems ... done.
[  211.836685] Freezing user space processes ... 
[  231.845010] Freezing of tasks failed after 20.008 seconds (1 tasks refusing to freeze, wq_busy=0):
[  231.845032] hald-addon-stor D    0   909    849 0x20020004
[  231.845039] Call Trace:
[  231.845053]  ? __schedule+0x37f/0x57f
[  231.845059]  ? usleep_range+0x51/0x51
[  231.845065]  schedule+0x7f/0x89
[  231.845069]  schedule_timeout+0x21/0xc7
[  231.845076]  ? check_preempt_curr+0x2e/0x68
[  231.845082]  do_wait_for_common+0x102/0x133
[  231.845088]  ? wake_up_q+0x47/0x47
[  231.845094]  wait_for_common+0x36/0x4e
[  231.845099]  flush_work+0x12e/0x14b
[  231.845104]  ? wake_up_worker+0x25/0x25
[  231.845110]  __cancel_work_timer+0xfb/0x14f
[  231.845115]  ? kobj_lookup+0xfc/0x130
[  231.845121]  disk_block_events+0x5f/0x78
[  231.845127]  __blkdev_get+0xaa/0x3f7
[  231.845133]  blkdev_get+0x83/0x2a3
[  231.845137]  ? bdgrab+0x12/0x17
[  231.845141]  ? bd_acquire+0x3a/0xad
[  231.845146]  ? bd_acquire+0xad/0xad
[  231.845152]  do_dentry_open.isra.22+0x16b/0x22d
[  231.845158]  path_openat+0x98f/0xb27
[  231.845164]  ? _raw_spin_unlock_irqrestore+0x18/0x23
[  231.845169]  do_filp_open+0x4d/0xa3
[  231.845175]  ? __blkdev_put+0x154/0x170
[  231.845180]  ? _cond_resched+0x25/0x29
[  231.845186]  ? slab_pre_alloc_hook+0x2d/0x53
[  231.845191]  ? slab_post_alloc_hook.isra.62+0xa/0x1a
[  231.845196]  ? kmem_cache_alloc+0xa0/0x10b
[  231.845203]  ? do_sys_open+0x6a/0xef
[  231.845207]  do_sys_open+0x6a/0xef
[  231.845213]  do_int80_syscall_32+0x52/0x5f
[  231.845218]  entry_INT80_compat+0x85/0x90
[  231.845242] OOM killer enabled.
[  231.845244] Restarting tasks ... done.
[  231.849297] PM: suspend exit
[ 1419.229450] traps: kio_thumbnail[3069] general protection ip:f5005a88 sp:ed718034 error:0 in libavcodec.so.56.60.100[f4840000+b58000]
[ 1442.535747] traps: kio_thumbnail[3092] general protection ip:f5135a88 sp:ee6ff1c4 error:0
[ 1446.531162] traps: kio_thumbnail[3108] general protection ip:f516c97f sp:ee8ff034 error:0 in libavcodec.so.56.60.100[f4970000+b58000]

--Boundary-00=_rD9Gb/LkA3KajWW--
