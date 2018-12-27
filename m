Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C417CC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809F121741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 10:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=frugalware.org header.i=@frugalware.org header.b="YsgzLFP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbeL0KRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 05:17:15 -0500
Received: from andromeda.frugalware.org ([85.10.194.195]:56702 "EHLO
        andromeda.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbeL0KRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 05:17:15 -0500
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Dec 2018 05:17:13 EST
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frugalware.org;
        s=2018; t=1545905298; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=uR3UYhMeGuMErjqKXp20Pmj8rCOOz79Lk6GUrq5q6i4=;
        b=YsgzLFP5e/LOUUFdSyyGzv/MrlPK57VvaOICy22MpgA7tBbmnykiET2cI8lTvtDqF6fNB7
        xFSDjJ/Bn0i8szothQztr/wvebKT7QALQLYgvDQ3NiLlVb0aP1k3nOs663qRtXZ4qFfMp9
        I3kqnCcInsCpYGJhE0+APjqtIVBk6A0=
Date:   Thu, 27 Dec 2018 10:08:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Gabriel C" <crazy@frugalware.org>
Message-ID: <de26281344602d5edbd3600e0ef4afd3@frugalware.org>
Subject: ath10_pci: WARN(() on resume from S3
To:     "Kalle Valo" <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dex77@frugalware.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, nix.or.die@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=frugalware.org;
        s=2018; t=1545905298; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=uR3UYhMeGuMErjqKXp20Pmj8rCOOz79Lk6GUrq5q6i4=;
        b=Qly7cZ0I5oieSU3fFK/FyOrYVRR4fGTltiloMzzS/lwbh+3e87dErjRlITroRz2nmiCUJC
        xperbhSo4+bclZjHDNdkMEU2VQNuL1lVCOblgT0MLmySrNkWwAWhC/68vB96R3XlTalumv
        /62tBiURtF7nNc9dQWQVM0IbXAocLM0=
ARC-Seal: i=1; s=2018; d=frugalware.org; t=1545905298; a=rsa-sha256;
        cv=none;
        b=rcId8M4oJWhqXY5zl0A2u9aso7CBXOrG6heIYobsdi9RDiyg0n88P2SniAYXNc7CsHjAA6
        vo/rLHoAQf/ZYFXKfaZxT6KG827qLlOoSzzGvz8dBXNYSd2fCLKOos8X58hX9CKeib5PuO
        QyjkKJJ+v0uXMH+nKinQtbSC0b8kMrQ=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=crazy@frugalware.org smtp.mailfrom=crazy@frugalware.org
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=crazy@frugalware.org smtp.mailfrom=crazy@frugalware.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,=0A=0Aon a QCA9377 card I hit WARN() on each resume from S3.=0A=0A=
This is on kernel 4.19.X and now on 4.20.0 too.=0AOn kernel 4.19.x I see =
just the first WARN() while on=0A4.20.0 I see now two.=0A=0AAlso I see Un=
known eventid: xxx and on 4.20.0=0Aa unsupported HTC service id: xxx mess=
age(s).=0A=0A=0A...=0A=0A[   45.740910] ACPI: Waking up from system sleep=
 state S3=0A[   45.743781] ACPI: EC: interrupt unblocked=0A[   46.125319]=
 ACPI: EC: event unblocked=0A[   46.125659] sd 0:0:0:0: [sda] Starting di=
sk=0A[   46.357351] usb 1-6: reset high-speed USB device number 3 using x=
hci_hcd=0A[   46.432399] ata1: SATA link up 6.0 Gbps (SStatus 133 SContro=
l 300)=0A[   46.432718] ata1.00: supports DRM functions and may not be fu=
lly accessible=0A[   46.432792] ata2: SATA link up 1.5 Gbps (SStatus 113 =
SControl 300)=0A[   46.434757] ata2.00: configured for UDMA/133=0A[   46.=
435943] ata1.00: supports DRM functions and may not be fully accessible=
=0A[   46.438678] ata1.00: configured for UDMA/133=0A[   46.438718] ata1.=
00: Enabling discard_zeroes_data=0A[   46.485511] r8169 0000:02:00.0 enp2=
s0: Link is Down=0A[   46.597393] usb 1-5: reset high-speed USB device nu=
mber 2 using xhci_hcd=0A[   46.837432] usb 1-7: reset full-speed USB devi=
ce number 4 using xhci_hcd=0A[   48.375066] ath10k_pci 0000:03:00.0: unsu=
pported HTC service id: 1536=0A[   48.390223] ath10k_pci 0000:03:00.0: Un=
known eventid: 118809=0A[   48.393133] ath10k_pci 0000:03:00.0: Unknown e=
ventid: 90118=0A[   48.415625] WARNING: CPU: 2 PID: 1251 at drivers/net/w=
ireless/ath/ath10k/mac.c:5650 ath10k_bss_info_changed+0xc8b/0xef0 [ath10k=
_core]=0A[   48.415626] Modules linked in: ctr ccm cmac af_packet arc4 am=
dgpu chash amd_iommu_v2 gpu_sched joydev snd_hda_codec_hdmi snd_hda_codec=
_conexant bnep snd_hda_codec_generic radeon ath10k_pci ath10k_core ath iT=
CO_wdt iTCO_vendor_support i915 mac80211 coretemp snd_soc_skl intel_rapl =
x86_pkg_temp_thermal intel_powerclamp snd_soc_hdac_hda snd_hda_ext_core b=
tusb snd_soc_skl_ipc btrtl btbcm snd_soc_sst_ipc btintel snd_soc_sst_dsp =
kvm_intel kvmgt snd_soc_acpi_intel_match snd_soc_acpi vfio_mdev mdev nls_=
utf8 bluetooth vfio_iommu_type1 vfio uvcvideo nls_cp437 vfat videobuf2_vm=
alloc fat snd_soc_core ttm videobuf2_memops videobuf2_v4l2 kvm cec snd_co=
mpress rc_core snd_pcm_dmaengine videobuf2_common snd_hda_intel drm_kms_h=
elper videodev rtsx_usb_ms ecdh_generic snd_hda_codec memstick cfg80211 d=
rm irqbypass efi_pstore pcspkr psmouse intel_gtt media r8169 snd_hda_core=
 agpgart evdev mac_hid snd_hwdep intel_wmi_thunderbolt efivars i2c_i801 i=
2c_algo_bit hwmon libphy ideapad_laptop fb_sys_fops syscopyarea=0A[   48.=
415659]  sparse_keymap sysfillrect rfkill sysimgblt battery i2c_core ac i=
ntel_pch_thermal acpi_pad button thermal pcc_cpufreq ppdev sch_fq_codel f=
use snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss snd_seq_m=
idi_event snd_seq snd_seq_device snd_timer snd soundcore lp parport_pc pa=
rport binfmt_misc sg ext4 crc32c_generic crc16 mbcache jbd2 fscrypto rtsx=
_usb_sdmmc mmc_core rtsx_usb sr_mod sd_mod cdrom crct10dif_pclmul crc32_p=
clmul crc32c_intel ghash_clmulni_intel ahci libahci libata xhci_pci xhci_=
hcd aesni_intel scsi_mod usbcore aes_x86_64 crypto_simd cryptd glue_helpe=
r serio_raw wmi video dm_mirror dm_region_hash dm_log dm_mod efivarfs uni=
x sha256_ssse3 sha256_generic sha1_ssse3 sha1_generic hmac ipv6 autofs4=
=0A[   48.415688] CPU: 2 PID: 1251 Comm: kworker/u8:19 Not tainted 4.20-f=
w1 #1=0A[   48.415689] Hardware name: LENOVO 80UD/LNVNB161216, BIOS 1TCN2=
7WW(V2.08) 07/06/2018=0A[   48.415692] Workqueue: events_unbound async_ru=
n_entry_fn=0A[   48.415698] RIP: 0010:ath10k_bss_info_changed+0xc8b/0xef0=
 [ath10k_core]=0A[   48.415700] Code: ff ff b8 a1 ff ff ff e9 a9 f4 ff ff=
 b8 a1 ff ff ff e9 05 f6 ff ff b8 a1 ff ff ff e9 3f f5 ff ff b8 a1 ff ff =
ff e9 6e f6 ff ff <0f> 0b e9 da f6 ff ff b8 a1 ff ff ff e9 73 f9 ff ff b8=
 a1 ff ff ff=0A[   48.415701] RSP: 0000:ffffaadd43597cd8 EFLAGS: 00010282=
=0A[   48.415702] RAX: 00000000fffffffe RBX: ffff8fa9f27a1380 RCX: 000000=
0000000000=0A[   48.415703] RDX: 0000000000000001 RSI: ffffaadd43597cf8 R=
DI: ffff8fa9f27a1380=0A[   48.415704] RBP: 00000000030674ff R08: 00000000=
00200000 R09: 0000000000000000=0A[   48.415705] R10: 000000000000001f R11=
: ffff8fa9cf7cf500 R12: ffff8fa9f27a1388=0A[   48.415706] R13: ffff8fa9ee=
552558 R14: ffff8fa9ee551580 R15: ffff8fa9ee551580=0A[   48.415707] FS:  =
0000000000000000(0000) GS:ffff8fa9f7300000(0000) knlGS:0000000000000000=
=0A[   48.415708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A[  =
 48.415709] CR2: 0000000000000000 CR3: 000000011700a001 CR4: 000000000036=
06e0=0A[   48.415710] Call Trace:=0A[   48.415717]  ? ath10k_conf_tx+0x12=
d/0x4c0 [ath10k_core]=0A[   48.415729]  ieee80211_bss_info_change_notify+=
0xa9/0x1c0 [mac80211]=0A[   48.415744]  ieee80211_reconfig+0xa4f/0x1560 [=
mac80211]=0A[   48.415757]  wiphy_resume+0x7e/0x150 [cfg80211]=0A[   48.4=
15767]  ? wiphy_namespace+0x10/0x10 [cfg80211]=0A[   48.415770]  dpm_run_=
callback+0x2e/0x130=0A[   48.415772]  device_resume+0x97/0x190=0A[   48.4=
15774]  async_resume+0x19/0x40=0A[   48.415776]  async_run_entry_fn+0x37/=
0xe0=0A[   48.415779]  process_one_work+0x1e9/0x410=0A[   48.415782]  wor=
ker_thread+0x2d/0x3d0=0A[   48.415785]  ? process_one_work+0x410/0x410=0A=
[   48.415786]  kthread+0x113/0x130=0A[   48.415788]  ? kthread_park+0x90=
/0x90=0A[   48.415791]  ret_from_fork+0x35/0x40=0A[   48.415794] ---[ end=
 trace 965780d03f252ba4 ]---=0A[   48.415810] WARNING: CPU: 2 PID: 1251 a=
t drivers/net/wireless/ath/ath10k/mac.c:5688 ath10k_bss_info_changed+0xae=
9/0xef0 [ath10k_core]=0A[   48.415811] Modules linked in: ctr ccm cmac af=
_packet arc4 amdgpu chash amd_iommu_v2 gpu_sched joydev snd_hda_codec_hdm=
i snd_hda_codec_conexant bnep snd_hda_codec_generic radeon ath10k_pci ath=
10k_core ath iTCO_wdt iTCO_vendor_support i915 mac80211 coretemp snd_soc_=
skl intel_rapl x86_pkg_temp_thermal intel_powerclamp snd_soc_hdac_hda snd=
_hda_ext_core btusb snd_soc_skl_ipc btrtl btbcm snd_soc_sst_ipc btintel s=
nd_soc_sst_dsp kvm_intel kvmgt snd_soc_acpi_intel_match snd_soc_acpi vfio=
_mdev mdev nls_utf8 bluetooth vfio_iommu_type1 vfio uvcvideo nls_cp437 vf=
at videobuf2_vmalloc fat snd_soc_core ttm videobuf2_memops videobuf2_v4l2=
 kvm cec snd_compress rc_core snd_pcm_dmaengine videobuf2_common snd_hda_=
intel drm_kms_helper videodev rtsx_usb_ms ecdh_generic snd_hda_codec mems=
tick cfg80211 drm irqbypass efi_pstore pcspkr psmouse intel_gtt media r81=
69 snd_hda_core agpgart evdev mac_hid snd_hwdep intel_wmi_thunderbolt efi=
vars i2c_i801 i2c_algo_bit hwmon libphy ideapad_laptop fb_sys_fops syscop=
yarea=0A[   48.415837]  sparse_keymap sysfillrect rfkill sysimgblt batter=
y i2c_core ac intel_pch_thermal acpi_pad button thermal pcc_cpufreq ppdev=
 sch_fq_codel fuse snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_se=
q_oss snd_seq_midi_event snd_seq snd_seq_device snd_timer snd soundcore l=
p parport_pc parport binfmt_misc sg ext4 crc32c_generic crc16 mbcache jbd=
2 fscrypto rtsx_usb_sdmmc mmc_core rtsx_usb sr_mod sd_mod cdrom crct10dif=
_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci libahci libata=
 xhci_pci xhci_hcd aesni_intel scsi_mod usbcore aes_x86_64 crypto_simd cr=
yptd glue_helper serio_raw wmi video dm_mirror dm_region_hash dm_log dm_m=
od efivarfs unix sha256_ssse3 sha256_generic sha1_ssse3 sha1_generic hmac=
 ipv6 autofs4=0A[   48.415860] CPU: 2 PID: 1251 Comm: kworker/u8:19 Taint=
ed: G        W         4.20-fw1 #1=0A[   48.415860] Hardware name: LENOVO=
 80UD/LNVNB161216, BIOS 1TCN27WW(V2.08) 07/06/2018=0A[   48.415863] Workq=
ueue: events_unbound async_run_entry_fn=0A[   48.415868] RIP: 0010:ath10k=
_bss_info_changed+0xae9/0xef0 [ath10k_core]=0A[   48.415870] Code: c1 48 =
c7 c6 70 5f ee c0 4c 89 ff e8 e1 35 00 00 e9 ea f5 ff ff 66 83 f8 0a 0f 8=
5 31 fc ff ff 41 bc 40 00 00 00 e9 29 fc ff ff <0f> 0b 4c 89 ef e8 dd 1f =
7d fd e9 34 f9 ff ff 89 c2 48 c7 c6 d0 5f=0A[   48.415871] RSP: 0000:ffff=
aadd43597cd8 EFLAGS: 00010282=0A[   48.415872] RAX: 00000000fffffffe RBX:=
 ffff8fa9f27a1380 RCX: 0000000000000000=0A[   48.415873] RDX: 00000000000=
00001 RSI: ffffaadd43597cf8 RDI: ffff8fa9f27a1380=0A[   48.415874] RBP: 0=
000000000000020 R08: 0000000000200000 R09: 0000000000000000=0A[   48.4158=
75] R10: 000000000000001f R11: ffff8fa9cf7cf500 R12: ffff8fa9f27a1388=0A[=
   48.415876] R13: ffff8fa9ee552558 R14: ffff8fa9ee551580 R15: ffff8fa9ee=
551580=0A[   48.415877] FS:  0000000000000000(0000) GS:ffff8fa9f7300000(0=
000) knlGS:0000000000000000=0A[   48.415878] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033=0A[   48.415879] CR2: 0000000000000000 CR3: 0000000=
11700a001 CR4: 00000000003606e0=0A[   48.415879] Call Trace:=0A[   48.415=
884]  ? ath10k_conf_tx+0x12d/0x4c0 [ath10k_core]=0A[   48.415893]  ieee80=
211_bss_info_change_notify+0xa9/0x1c0 [mac80211]=0A[   48.415906]  ieee80=
211_reconfig+0xa4f/0x1560 [mac80211]=0A[   48.415918]  wiphy_resume+0x7e/=
0x150 [cfg80211]=0A[   48.415927]  ? wiphy_namespace+0x10/0x10 [cfg80211]=
=0A[   48.415929]  dpm_run_callback+0x2e/0x130=0A[   48.415931]  device_r=
esume+0x97/0x190=0A[   48.415933]  async_resume+0x19/0x40=0A[   48.415935=
]  async_run_entry_fn+0x37/0xe0=0A[   48.415937]  process_one_work+0x1e9/=
0x410=0A[   48.415939]  worker_thread+0x2d/0x3d0=0A[   48.415942]  ? proc=
ess_one_work+0x410/0x410=0A[   48.415943]  kthread+0x113/0x130=0A[   48.4=
15945]  ? kthread_park+0x90/0x90=0A[   48.415946]  ret_from_fork+0x35/0x4=
0=0A[   48.415948] ---[ end trace 965780d03f252ba5 ]---=0A=0A...=0A=0APle=
ase let me know if more infos are needed.=0A=0ABR,=0A=0AGabriel=20C
