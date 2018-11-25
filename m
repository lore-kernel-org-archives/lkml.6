Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0F8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1BB20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1BB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elektron.elka.pw.edu.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeKZCu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 21:50:28 -0500
Received: from elektron.elka.pw.edu.pl ([194.29.160.103]:46084 "EHLO
        elektron.elka.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKZCu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 21:50:27 -0500
Received: from [172.19.1.1] (178235205188.warszawa.vectranet.pl [178.235.205.188])
        (Authenticated sender: wzabolot@elektron.elka.pw.edu.pl)
        by elektron.elka.pw.edu.pl (Postfix) with ESMTPSA id C896C68B613
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 16:58:59 +0100 (CET)
To:     LKML <linux-kernel@vger.kernel.org>
From:   "wzabolot@elektron.elka.pw.edu.pl" <wzabolot@elektron.elka.pw.edu.pl>
Subject: The "udl" driver crashes the kernel.
Openpgp: preference=signencrypt
Autocrypt: addr=wzabolot@elektron.elka.pw.edu.pl; prefer-encrypt=mutual;
 keydata=
 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
Message-ID: <31dc20a5-66f4-051c-dfec-73924b00c0f8@elektron.elka.pw.edu.pl>
Date:   Sun, 25 Nov 2018 16:58:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I connect my Displaylink DL-165 adapter to my Debian/testing
machine, the "udl" driver is loaded and the following error messages
appears in kernel logs:


Nov  7 20:47:30 wzdell kernel: [  205.871354] usb 4-1.2: new high-speed
USB device number 4 using ehci-pci
Nov  7 20:47:35 wzdell kernel: [  211.209020] usb 4-1.2: New USB device
found, idVendor=17e9, idProduct=0290, bcdDevice= 0.01
Nov  7 20:47:35 wzdell kernel: [  211.209027] usb 4-1.2: New USB device
strings: Mfr=1, Product=2, SerialNumber=3
Nov  7 20:47:35 wzdell kernel: [  211.209032] usb 4-1.2: Product: DL-165
Adapter
Nov  7 20:47:35 wzdell kernel: [  211.209036] usb 4-1.2: Manufacturer:
DisplayLink
Nov  7 20:47:35 wzdell kernel: [  211.209040] usb 4-1.2: SerialNumber:
102140
Nov  7 20:47:35 wzdell mtp-probe: checking bus 4, device 4:
"/sys/devices/pci0000:00/0000:00:1d.0/usb4/4-1/4-1.2"
Nov  7 20:47:35 wzdell mtp-probe: bus: 4, device: 4 was not an MTP device
Nov  7 20:47:35 wzdell kernel: [  211.269753] [drm] vendor descriptor
length:22 data:22 5f 01 00 20 05 00 01 03 04 02
Nov  7 20:47:35 wzdell kernel: [  211.320940] [drm] Cannot find any crtc
or sizes
Nov  7 20:47:35 wzdell kernel: [  211.320962] [drm] Supports vblank
timestamp caching Rev 2 (21.10.2013).
Nov  7 20:47:35 wzdell kernel: [  211.320963] [drm] No driver support
for vblank timestamp query.
Nov  7 20:47:35 wzdell kernel: [  211.320999] [drm] Initialized udl
0.0.1 20120220 for 4-1.2:1.0 on minor 1
Nov  7 20:47:35 wzdell kernel: [  211.321002] [drm] Initialized udl on
minor 1
Nov  7 20:47:35 wzdell kernel: [  211.321078] usbcore: registered new
interface driver udl
Nov  7 20:47:37 wzdell kernel: [  212.700722] WARNING: CPU: 0 PID: 1024
at /build/linux-iActNR/linux-4.18.10/drivers/gpu/drm/drm_gem.c:893
drm_gem_object_put+0x34/0x40 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.700726] Modules linked in: udl
rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave
bnep bbswitch(O) nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4
nf_defrag_ipv4 nft_counter xt_owner xt_state xt_conntrack nf_conntrack
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
uvcvideo arc4 iwldvm videobuf2_vmalloc mac80211 videobuf2_memops
videobuf2_v4l2 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
videobuf2_common snd_hda_codec videodev snd_hda_core snd_hwdep snd_pcm
snd_timer media snd soundcore i915 btusb btrtl btbcm btintel bluetooth
iwlwifi dell_laptop dell_wmi dell_smbios mei_me drbg ansi_cprng mei
ecdh_generic wmi_bmof dcdbas cfg80211 drm_kms_helper sparse_keymap
dell_wmi_descriptor
Nov  7 20:47:37 wzdell kernel: [  212.700822]  intel_cstate drm
intel_uncore intel_rapl_perf dell_smm_hwmon evdev iTCO_wdt
iTCO_vendor_support joydev rfkill video serio_raw i2c_algo_bit pcspkr sg
pcc_cpufreq wmi dell_smo8800 button battery ac parport_pc ppdev lp
parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
crc32c_generic fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod
cdrom sd_mod ums_realtek uas usb_storage crct10dif_pclmul crc32_pclmul
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci
aes_x86_64 ehci_pci crypto_simd libata xhci_hcd ehci_hcd cryptd
glue_helper psmouse scsi_mod i2c_i801 r8169 lpc_ich mii usbcore
usb_common thermal
Nov  7 20:47:37 wzdell kernel: [  212.700925] CPU: 0 PID: 1024 Comm:
Xorg Tainted: G           O      4.18.0-2-amd64 #1 Debian 4.18.10-2
Nov  7 20:47:37 wzdell kernel: [  212.700927] Hardware name: Dell
Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
Nov  7 20:47:37 wzdell kernel: [  212.700955] RIP:
0010:drm_gem_object_put+0x34/0x40 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.700957] Code: 53 48 8b 47 08 48 8b
40 68 48 a9 f8 ff ff ff 74 19 48 89 fb e8 7d c3 02 de 84 c0 75 02 5b c3
48 89 df 5b e9 ee fc ff ff f3 c3 <0f> 0b eb e3 0f 1f 84 00 00 00 00 00
66 66 66 66 90 48 8b 42 08 48
Nov  7 20:47:37 wzdell kernel: [  212.701035] RSP: 0018:ffffac86826bbd00
EFLAGS: 00010246
Nov  7 20:47:37 wzdell kernel: [  212.701039] RAX: 0000000000000000 RBX:
ffff95fc65313800 RCX: 0000000000000000
Nov  7 20:47:37 wzdell kernel: [  212.701042] RDX: ffffffffffffffff RSI:
ffff95fc662b0610 RDI: ffff95fc65313800
Nov  7 20:47:37 wzdell kernel: [  212.701045] RBP: ffff95fc31f1a020 R08:
ffff95fc662b0610 R09: ffff95fc662b06c0
Nov  7 20:47:37 wzdell kernel: [  212.701047] R10: 0000000000100000 R11:
0000000000000040 R12: 0000000000000000
Nov  7 20:47:37 wzdell kernel: [  212.701050] R13: ffffac86826bbdc8 R14:
ffffac86826bbdc0 R15: 00000000000000b3
Nov  7 20:47:37 wzdell kernel: [  212.701054] FS: 
00007f78c0ceba80(0000) GS:ffff95fc7e400000(0000) knlGS:0000000000000000
Nov  7 20:47:37 wzdell kernel: [  212.701057] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Nov  7 20:47:37 wzdell kernel: [  212.701060] CR2: 00007f78abdfac94 CR3:
00000004287fe002 CR4: 00000000000606f0
Nov  7 20:47:37 wzdell kernel: [  212.701063] Call Trace:
Nov  7 20:47:37 wzdell kernel: [  212.701080]  udl_gem_mmap+0x58/0xb0 [udl]
Nov  7 20:47:37 wzdell kernel: [  212.701112]  ?
drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.701138] 
drm_ioctl_kernel+0xa1/0xf0 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.701164]  drm_ioctl+0x2eb/0x390 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.701193]  ?
drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.701203]  ? datagram_poll+0x28/0xf0
Nov  7 20:47:37 wzdell kernel: [  212.701209]  ? sock_poll+0x7b/0xb0
Nov  7 20:47:37 wzdell kernel: [  212.701216]  ?
ep_item_poll.isra.13+0x3f/0xb0
Nov  7 20:47:37 wzdell kernel: [  212.701221]  ? sock_poll+0x7b/0xb0
Nov  7 20:47:37 wzdell kernel: [  212.701230]  do_vfs_ioctl+0xa4/0x640
Nov  7 20:47:37 wzdell kernel: [  212.701237]  ?
__x64_sys_epoll_ctl+0xf2/0x590
Nov  7 20:47:37 wzdell kernel: [  212.701243]  ksys_ioctl+0x70/0x80
Nov  7 20:47:37 wzdell kernel: [  212.701250]  __x64_sys_ioctl+0x16/0x20
Nov  7 20:47:37 wzdell kernel: [  212.701257]  do_syscall_64+0x55/0x110
Nov  7 20:47:37 wzdell kernel: [  212.701265] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Nov  7 20:47:37 wzdell kernel: [  212.701271] RIP: 0033:0x7f78c1c09067
Nov  7 20:47:37 wzdell kernel: [  212.701272] Code: b3 66 90 48 8b 05 21
7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00
00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d
f1 7d 0c 00 f7 d8 64 89 01 48
Nov  7 20:47:37 wzdell kernel: [  212.701349] RSP: 002b:00007ffc9ddc4ef8
EFLAGS: 00003246 ORIG_RAX: 0000000000000010
Nov  7 20:47:37 wzdell kernel: [  212.701354] RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f78c1c09067
Nov  7 20:47:37 wzdell kernel: [  212.701356] RDX: 00007ffc9ddc4f30 RSI:
00000000c01064b3 RDI: 0000000000000037
Nov  7 20:47:37 wzdell kernel: [  212.701359] RBP: 00007ffc9ddc4f30 R08:
0000000000000000 R09: 000055bbb6541fe0
Nov  7 20:47:37 wzdell kernel: [  212.701361] R10: 00007ffc9ddc4edc R11:
0000000000003246 R12: 00000000c01064b3
Nov  7 20:47:37 wzdell kernel: [  212.701364] R13: 0000000000000037 R14:
000055bbb6580d90 R15: 0000000000000001
Nov  7 20:47:37 wzdell kernel: [  212.701369] ---[ end trace
6b30e2bd6c85b37b ]---
Nov  7 20:47:37 wzdell kernel: [  212.703507] WARNING: CPU: 0 PID: 1024
at /build/linux-iActNR/linux-4.18.10/drivers/gpu/drm/drm_gem.c:893
drm_gem_object_put+0x34/0x40 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.703509] Modules linked in: udl
rfcomm ctr ccm cpufreq_userspace cpufreq_conservative cpufreq_powersave
bnep bbswitch(O) nf_conntrack_ipv6 nf_defrag_ipv6 nf_conntrack_ipv4
nf_defrag_ipv4 nft_counter xt_owner xt_state xt_conntrack nf_conntrack
libcrc32c nft_compat nf_tables nfnetlink binfmt_misc intel_rapl
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
uvcvideo arc4 iwldvm videobuf2_vmalloc mac80211 videobuf2_memops
videobuf2_v4l2 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel
videobuf2_common snd_hda_codec videodev snd_hda_core snd_hwdep snd_pcm
snd_timer media snd soundcore i915 btusb btrtl btbcm btintel bluetooth
iwlwifi dell_laptop dell_wmi dell_smbios mei_me drbg ansi_cprng mei
ecdh_generic wmi_bmof dcdbas cfg80211 drm_kms_helper sparse_keymap
dell_wmi_descriptor
Nov  7 20:47:37 wzdell kernel: [  212.703595]  intel_cstate drm
intel_uncore intel_rapl_perf dell_smm_hwmon evdev iTCO_wdt
iTCO_vendor_support joydev rfkill video serio_raw i2c_algo_bit pcspkr sg
pcc_cpufreq wmi dell_smo8800 button battery ac parport_pc ppdev lp
parport ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2
crc32c_generic fscrypto ecb algif_skcipher af_alg dm_crypt dm_mod sr_mod
cdrom sd_mod ums_realtek uas usb_storage crct10dif_pclmul crc32_pclmul
crc32c_intel ghash_clmulni_intel pcbc ahci libahci aesni_intel xhci_pci
aes_x86_64 ehci_pci crypto_simd libata xhci_hcd ehci_hcd cryptd
glue_helper psmouse scsi_mod i2c_i801 r8169 lpc_ich mii usbcore
usb_common thermal
Nov  7 20:47:37 wzdell kernel: [  212.703696] CPU: 0 PID: 1024 Comm:
Xorg Tainted: G        W  O      4.18.0-2-amd64 #1 Debian 4.18.10-2
Nov  7 20:47:37 wzdell kernel: [  212.703698] Hardware name: Dell
Inc.          Dell System Vostro 3750/0VP036, BIOS A14 09/26/2012
Nov  7 20:47:37 wzdell kernel: [  212.703723] RIP:
0010:drm_gem_object_put+0x34/0x40 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.703724] Code: 53 48 8b 47 08 48 8b
40 68 48 a9 f8 ff ff ff 74 19 48 89 fb e8 7d c3 02 de 84 c0 75 02 5b c3
48 89 df 5b e9 ee fc ff ff f3 c3 <0f> 0b eb e3 0f 1f 84 00 00 00 00 00
66 66 66 66 90 48 8b 42 08 48
Nov  7 20:47:37 wzdell kernel: [  212.703801] RSP: 0018:ffffac86826bbd00
EFLAGS: 00010246
Nov  7 20:47:37 wzdell kernel: [  212.703805] RAX: 0000000000000000 RBX:
ffff95fc65313e00 RCX: 0000000000000000
Nov  7 20:47:37 wzdell kernel: [  212.703807] RDX: ffffffffffffffff RSI:
ffff95fc662b0610 RDI: ffff95fc65313e00
Nov  7 20:47:37 wzdell kernel: [  212.703810] RBP: ffff95fc31f1a020 R08:
ffff95fc662b0610 R09: ffff95fc65313868
Nov  7 20:47:37 wzdell kernel: [  212.703812] R10: 0000000000100004 R11:
0000000000000040 R12: 0000000000000000
Nov  7 20:47:37 wzdell kernel: [  212.703815] R13: ffffac86826bbdc8 R14:
ffffac86826bbdc0 R15: 00000000000000b3
Nov  7 20:47:37 wzdell kernel: [  212.703819] FS: 
00007f78c0ceba80(0000) GS:ffff95fc7e400000(0000) knlGS:0000000000000000
Nov  7 20:47:37 wzdell kernel: [  212.703822] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Nov  7 20:47:37 wzdell kernel: [  212.703825] CR2: 00007f78abdfac94 CR3:
00000004287fe002 CR4: 00000000000606f0
Nov  7 20:47:37 wzdell kernel: [  212.703827] Call Trace:
Nov  7 20:47:37 wzdell kernel: [  212.703837]  udl_gem_mmap+0x58/0xb0 [udl]
Nov  7 20:47:37 wzdell kernel: [  212.703867]  ?
drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.703902] 
drm_ioctl_kernel+0xa1/0xf0 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.703928]  drm_ioctl+0x2eb/0x390 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.703956]  ?
drm_mode_create_dumb_ioctl+0x90/0x90 [drm]
Nov  7 20:47:37 wzdell kernel: [  212.703963]  ? do_mmap+0x3f9/0x5c0
Nov  7 20:47:37 wzdell kernel: [  212.703971]  do_vfs_ioctl+0xa4/0x640
Nov  7 20:47:37 wzdell kernel: [  212.703978]  ksys_ioctl+0x70/0x80
Nov  7 20:47:37 wzdell kernel: [  212.703985]  __x64_sys_ioctl+0x16/0x20
Nov  7 20:47:37 wzdell kernel: [  212.703991]  do_syscall_64+0x55/0x110
Nov  7 20:47:37 wzdell kernel: [  212.703998] 
entry_SYSCALL_64_after_hwframe+0x44/0xa9
Nov  7 20:47:37 wzdell kernel: [  212.704002] RIP: 0033:0x7f78c1c09067
Nov  7 20:47:37 wzdell kernel: [  212.704003] Code: b3 66 90 48 8b 05 21
7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00
00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d
f1 7d 0c 00 f7 d8 64 89 01 48
Nov  7 20:47:37 wzdell kernel: [  212.704080] RSP: 002b:00007ffc9ddc4ef8
EFLAGS: 00003246 ORIG_RAX: 0000000000000010
Nov  7 20:47:37 wzdell kernel: [  212.704084] RAX: ffffffffffffffda RBX:
0000000000000000 RCX: 00007f78c1c09067
Nov  7 20:47:37 wzdell kernel: [  212.704087] RDX: 00007ffc9ddc4f30 RSI:
00000000c01064b3 RDI: 0000000000000037
Nov  7 20:47:37 wzdell kernel: [  212.704089] RBP: 00007ffc9ddc4f30 R08:
0000000000000037 R09: 0000000100000000
Nov  7 20:47:37 wzdell kernel: [  212.704092] R10: 0000000000000001 R11:
0000000000003246 R12: 00000000c01064b3
Nov  7 20:47:37 wzdell kernel: [  212.704094] R13: 0000000000000037 R14:
000055bbb6580d90 R15: 0000000000000001
Nov  7 20:47:37 wzdell kernel: [  212.704099] ---[ end trace
6b30e2bd6c85b37c ]---

-- 
Regards,
Wojtek
