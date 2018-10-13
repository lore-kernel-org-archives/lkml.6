Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F0EC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE62920868
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 01:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WJkTxUQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE62920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJMJXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:23:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeJMJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gD/QKutRUSLejxsVnyMD34cm256QQlC6Rfc5jm7lTPg=; b=WJkTxUQys8QpIueidp4u5D5zeq
        2sFdoFtierbVv2dhR6xJkIr0+Tgup2GvsdVvJlDJlL/BmoWKFrZj4lUUAF2zFq7Fs9Wk755vjQr+/
        CuCvh/mOxCyCAsG0NxDJn3LEQTfAQkS3zNHQ3RaStYnor9g735hB+QfGXXcMHAisuypLiBXVCCgKW
        ey8Y8RvCkxfyHC5nVbJvGH2wIw1wz1hRxM05SPcoqXofM8O/O1QZiuudaZ3J+6fnspxyMbVCNtmxs
        UR2Kqifwv8mQvJwl1CC3HEuTbvuQIYDMS2HgMyjdzcwFhZ38+bTPSZ29nHZ/vZBLEx32vsKdeDEEZ
        VMsaBZeQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gB92j-00049V-P3; Sat, 13 Oct 2018 01:48:38 +0000
To:     linux-mtd@lists.infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: ubifs: WARNINGs
Message-ID: <44aa413b-cc4c-c1c5-ebc4-895d07b5a159@infradead.org>
Date:   Fri, 12 Oct 2018 18:48:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linux 4.19-rc7, x86_64 laptop.

I don't have an ubifs filesystem.  When I just modprobe ubifs and then
rmmod ubifs, I get 2 WARNINGs from these 2 lines:

static void __exit ubifs_exit(void)
{
	WARN_ON(list_empty(&ubifs_infos));
	WARN_ON(atomic_long_read(&ubifs_clean_zn_cnt) == 0);

Is this normal/expected?



[  977.091170] calling  init_mtd+0x0/0x100 [mtd] @ 3187
[  977.092365] initcall init_mtd+0x0/0x100 [mtd] returned 0 after 251 usecs
[  977.146490] calling  ubi_init+0x0/0x249 [ubi] @ 3187
[  977.148351] initcall ubi_init+0x0/0x249 [ubi] returned 0 after 896 usecs
[  977.260504] calling  ubifs_init+0x0/0xae [ubifs] @ 3187
[  977.261976] initcall ubifs_init+0x0/0xae [ubifs] returned 0 after 516 usecs
[  987.695589] WARNING: CPU: 2 PID: 3217 at ../fs/ubifs/super.c:2340 ubifs_exit+0xf/0x488 [ubifs]
[  987.697142] Modules linked in: ubifs(-) ubi mtd fuse xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip_set nfnetlink af_packet ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek btrfs snd_hda_codec_generic xor coretemp zstd_compress hwmon i915 raid6_pq uvcvideo intel_rapl x86_pkg_temp_thermal intel_powerclamp libcrc32c zstd_decompress xxhash videobuf2_vmalloc kvm_intel videobuf2_memops crct10dif_pclmul videobuf2_v4l2 videobuf2_common hid_generic
[  987.709985]  videodev arc4 usbmouse crc32_pclmul usbhid iwldvm media crc32c_intel hid ghash_clmulni_intel pcbc mac80211 msr aesni_intel aes_x86_64 crypto_simd cryptd glue_helper iwlwifi kvmgt vfio_mdev mdev vfio_iommu_type1 vfio intel_cstate snd_hda_intel snd_hda_codec gpio_ich sdhci_pci iTCO_wdt kvm iTCO_vendor_support snd_hda_core cqhci cfg80211 intel_uncore intel_rapl_perf snd_hwdep sdhci snd_pcm irqbypass joydev mei_me mmc_core mei toshiba_acpi evdev sparse_keymap e1000e mousedev snd_timer input_leds mac_hid sr_mod snd uio_pdrv_genirq lpc_ich uio rfkill wmi serio_raw led_class industrialio cdrom thermal video soundcore button pcc_cpufreq ac pcspkr toshiba_haps battery sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[  987.721976] CPU: 2 PID: 3217 Comm: rmmod Not tainted 4.19.0-rc7mod #2
[  987.723150] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[  987.724583] RIP: 0010:ubifs_exit+0xf/0x488 [ubifs]
[  987.725377] Code: c3 8b 97 24 0a 00 00 6a 00 45 31 c9 41 b8 10 00 00 00 31 c9 e8 3a 32 ff ff 5a c3 48 8b 05 b1 e6 01 00 48 3d 30 62 fb c0 75 02 <0f> 0b 48 8b 05 f0 3b 02 00 48 85 c0 75 02 0f 0b e8 44 b9 ff ff e8
[  987.728689] RSP: 0018:ffffa3a18286fed0 EFLAGS: 00010246
[  987.729608] RAX: ffffffffc0fb6230 RBX: ffffffffc0fbb400 RCX: 0000000000000001
[  987.730907] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000246
[  987.732211] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[  987.733512] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000800
[  987.734807] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  987.736103] FS:  00007fd2ded67b80(0000) GS:ffff88664ae00000(0000) knlGS:0000000000000000
[  987.737527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  987.738571] CR2: 000055b4d9cd4ed8 CR3: 00000001352b4004 CR4: 00000000000606e0
[  987.739869] Call Trace:
[  987.740292]  __x64_sys_delete_module+0x157/0x240
[  987.741086]  ? task_work_run+0x6e/0xb0
[  987.741757]  do_syscall_64+0x60/0x180
[  987.742426]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  987.743346] RIP: 0033:0x7fd2de453f87
[  987.744013] Code: 73 01 c3 48 8b 0d 11 af 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 ae 2b 00 f7 d8 64 89 01 48
[  987.747326] RSP: 002b:00007ffe66c1a6d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  987.748624] RAX: ffffffffffffffda RBX: 00007ffe66c1a738 RCX: 00007fd2de453f87
[  987.749919] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b4d9cca7e8
[  987.751215] RBP: 000055b4d9cca780 R08: 00007ffe66c19651 R09: 0000000000000000
[  987.752512] R10: 00007fd2de4c31e0 R11: 0000000000000206 R12: 00007ffe66c1a900
[  987.753808] R13: 00007ffe66c1c256 R14: 000055b4d9cca260 R15: 000055b4d9cca780
[  987.755111] ---[ end trace 512f0dc2470230e0 ]---
[  987.755997] WARNING: CPU: 2 PID: 3217 at ../fs/ubifs/super.c:2341 ubifs_exit+0x1d/0x488 [ubifs]
[  987.756383] systemd-journald[142]: Compressed data object 804 -> 577 using LZ4
[  987.757553] Modules linked in: ubifs(-) ubi mtd fuse xt_tcpudp ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ip_set nfnetlink af_packet ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat_ipv4 nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter snd_hda_codec_hdmi snd_hda_codec_realtek btrfs snd_hda_codec_generic xor coretemp zstd_compress hwmon i915 raid6_pq uvcvideo intel_rapl x86_pkg_temp_thermal intel_powerclamp libcrc32c zstd_decompress xxhash videobuf2_vmalloc kvm_intel videobuf2_memops crct10dif_pclmul videobuf2_v4l2 videobuf2_common hid_generic
[  987.758925]  videodev arc4 usbmouse crc32_pclmul usbhid iwldvm media crc32c_intel hid ghash_clmulni_intel pcbc mac80211 msr aesni_intel aes_x86_64 crypto_simd cryptd glue_helper iwlwifi kvmgt vfio_mdev mdev
[  987.759101] systemd-journald[142]: Compressed data object 745 -> 658 using LZ4
[  987.776401]  vfio_iommu_type1 vfio intel_cstate snd_hda_intel snd_hda_codec gpio_ich sdhci_pci iTCO_wdt kvm iTCO_vendor_support snd_hda_core cqhci cfg80211 intel_uncore intel_rapl_perf snd_hwdep sdhci snd_pcm irqbypass joydev mei_me mmc_core mei toshiba_acpi evdev sparse_keymap e1000e mousedev snd_timer input_leds mac_hid sr_mod snd uio_pdrv_genirq lpc_ich uio rfkill wmi serio_raw led_class industrialio cdrom thermal video soundcore button pcc_cpufreq ac pcspkr toshiba_haps battery sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua autofs4
[  987.776472] CPU: 2 PID: 3217 Comm: rmmod Tainted: G        W         4.19.0-rc7mod #2
[  987.776473] Hardware name: TOSHIBA PORTEGE R835/Portable PC, BIOS Version 4.10   01/08/2013
[  987.776480] RIP: 0010:ubifs_exit+0x1d/0x488 [ubifs]
[  987.776482] Code: 10 00 00 00 31 c9 e8 3a 32 ff ff 5a c3 48 8b 05 b1 e6 01 00 48 3d 30 62 fb c0 75 02 0f 0b 48 8b 05 f0 3b 02 00 48 85 c0 75 02 <0f> 0b e8 44 b9 ff ff e8 5f d2 fe ff 48 c7 c7 c0 62 fb c0 e8 c3 d3
[  987.776483] RSP: 0018:ffffa3a18286fed0 EFLAGS: 00010246
[  987.776486] RAX: 0000000000000000 RBX: ffffffffc0fbb400 RCX: 0000000000000001
[  987.776487] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000246
[  987.776488] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[  987.776489] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000800
[  987.776490] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  987.776492] FS:  00007fd2ded67b80(0000) GS:ffff88664ae00000(0000) knlGS:0000000000000000
[  987.776493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  987.776494] CR2: 000055b4d9cd4ed8 CR3: 00000001352b4004 CR4: 00000000000606e0
[  987.776495] Call Trace:
[  987.776499]  __x64_sys_delete_module+0x157/0x240
[  987.776502]  ? task_work_run+0x6e/0xb0
[  987.776508]  do_syscall_64+0x60/0x180
[  987.776512]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  987.776513] RIP: 0033:0x7fd2de453f87
[  987.776515] Code: 73 01 c3 48 8b 0d 11 af 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 ae 2b 00 f7 d8 64 89 01 48
[  987.776516] RSP: 002b:00007ffe66c1a6d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  987.776518] RAX: ffffffffffffffda RBX: 00007ffe66c1a738 RCX: 00007fd2de453f87
[  987.776519] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b4d9cca7e8
[  987.776520] RBP: 000055b4d9cca780 R08: 00007ffe66c19651 R09: 0000000000000000
[  987.776522] R10: 00007fd2de4c31e0 R11: 0000000000000206 R12: 00007ffe66c1a900
[  987.776523] R13: 00007ffe66c1c256 R14: 000055b4d9cca260 R15: 000055b4d9cca780
[  987.776533] ---[ end trace 512f0dc2470230e1 ]---


thanks,
-- 
~Randy
