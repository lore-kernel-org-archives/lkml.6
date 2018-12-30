Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DFEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B2020836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 19:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSjvYKQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeL3TJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:09:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32973 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeL3TJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 14:09:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so28952392wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrzgMOeWvrWbWgvlrrUbeJV31cMFl3Lz0Bs1qIH13K0=;
        b=cSjvYKQ/aDZtFx5+p1VkIVuISABwlLv+pEgl8TPxCjbQcIoX0v2h23TLDbfu9OPYtm
         p6bp9/PdXxTPbfisf7BZ+7BLHYWKKh9uB2GY4+GxCoykjQzqe1JDaVpcinskpeGzwK3z
         mpDWkjgziq0bHuGE45O4gKPl00BVw32CimqE4SD9zzYg+mP3+413UUFtlq2AR/CVp47+
         2JUc7z93jF3+06mXQyUJZ0GKwXhK0yHEpejUqz6il2ktBh/7C7zsts/NBt01RXHHFzLT
         ZU+K7kkNOoUzBuwQDoXOEsn+DyO9YjaVjVvP1MnpgiVnlYSu4hqVG8V0xKJfiYmjqegA
         kjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrzgMOeWvrWbWgvlrrUbeJV31cMFl3Lz0Bs1qIH13K0=;
        b=GNrHYNjosUh3UaQYg7QwWrVCOf/sdN4i+JmsPxRSC2l8llafPy7ODiYnNrfwfIMuDj
         V5sz0V/dYeQRAhW2v9fLbE2DvuSW9i3ap2aWVanyDI0hUC1xl+p+55qdI52Ho1KeCDmK
         bVTlvMXHj591Cd+b87N983d912AhhNhPIYTZsGnB3Dk8gQYzZZ8Ck4MapBQd+Nx37rAc
         UBvwF/O6f7odtaW2whqQOcXW7jlFw+tBcvAiOlN9lgspLg77NAaUZ79BV9uLRwSz6sPQ
         TsZTaeoB+f9SidEeLJaczZFR2Ya/+krP9S/vvUkZa2IvmSA7ez7CFG9N3bxwRIPDASm/
         HfkQ==
X-Gm-Message-State: AA+aEWYV0ZhD4jhbmxNmFWyWlRTbuSlhw4EBKJILo6OxuNPH1q+JmWUT
        L5tGaCYCgJJrswwj+S1CIXzocp+l
X-Google-Smtp-Source: ALg8bN7/eVXoR160whL3NGTxArpoR2WWDfRVulo7l6DMammAZ1fto3eGxkk8VxuN20n17/wD+JuMJw==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr28017539wmj.129.1546196966885;
        Sun, 30 Dec 2018 11:09:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id q9sm27276127wrv.26.2018.12.30.11.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 11:09:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     insafonov@gmail.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
Date:   Sun, 30 Dec 2018 19:39:18 +0100
Message-Id: <20181230183918.3888-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
is causing hardfreeze whenever the driver tries to connect to my wifi
network. That makes the driver unusable on my system. Reverting the
commit fixes the issue and the driver works properly.

Dec 29 19:21:17 gentoo kernel: BUG: scheduling while atomic: swapper/6/0/0x00000100
Dec 29 19:21:17 gentoo kernel: Modules linked in: vfat r8188eu(C) lib80211 cfg80211 rfkill snd_hda_codec_realtek amdgpu
snd_hda_codec_generic snd_hda_codec_hdmi mfd_core chash edac_mce_amd gpu_sched snd_hda_intel ttm wmi_bmof kvm
drm_kms_helper snd_hda_codec irqbypass snd_hwdep crc32c_intel snd_hda_core drm snd_pcm ghash_clmulni_intel snd_timer
syscopyarea cryptd snd sysfillrect pcspkr sysimgblt k10temp fb_sys_fops soundcore wmi video xts cbc ixgb ixgbe tulip
cxgb3 cxgb mdio cxgb4 vxge bonding vxlan ip6_udp_tunnel udp_tunnel macvlan vmxnet3 tg3 sky2 r8169 libphy pcnet32 mii igb
dca i2c_algo_bit i2c_core e1000 bnx2 atl1c msdos fat efivarfs configfs cramfs squashfs fuse nfs lockd grace sunrpc
fscache ext4 jbd2 ext2 mbcache linear raid10 raid1 raid0 dm_zero dm_verity reed_solomon dm_thin_pool dm_switch
dm_snapshot dm_raid raid456 async_raid6_recov async_memcpy async_pq raid6_pq dm_mirror dm_region_hash dm_log_writes
dm_log_userspace dm_log dm_integrity async_xor xor async_tx dm_flakey dm_era dm_delay dm_crypt
Dec 29 19:21:17 gentoo kernel:  dm_cache_smq dm_cache dm_persistent_data libcrc32c dm_bufio dm_bio_prison dm_mod
firewire_core crc_itu_t sl811_hcd xhci_pci xhci_hcd usb_storage mpt3sas raid_class aic94xx libsas lpfc qla2xxx
megaraid_sas megaraid_mbox megaraid_mm aacraid sx8 hpsa 3w_9xxx 3w_xxxx 3w_sas mptsas scsi_transport_sas mptfc
scsi_transport_fc mptspi mptscsih mptbase imm parport sym53c8xx initio arcmsr aic7xxx aic79xx scsi_transport_spi sr_mod
cdrom sg sd_mod pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor sata_vsc sata_uli sata_sis sata_sx4
sata_nv sata_via sata_svw sata_sil24 sata_sil sata_promise pata_via pata_jmicron pata_marvell pata_sis pata_netcell
pata_pdc202xx_old pata_atiixp pata_amd pata_ali pata_it8213 pata_pcmcia pata_serverworks pata_oldpiix pata_artop
pata_it821x pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366 pata_cmd64x pata_sil680 pata_pdc2027x nvme nvme_core
virtio_net net_failover failover virtio_crypto crypto_engine virtio_mmio virtio_pci virtio_balloon virtio_rng
Dec 29 19:21:17 gentoo kernel:  virtio_console virtio_blk virtio_scsi virtio_ring virtio
Dec 29 19:21:17 gentoo kernel: CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        WC        4.20.0-gentoo #1
Dec 29 19:21:17 gentoo kernel: Hardware name: Gigabyte Technology Co., Ltd. A320M-S2H/A320M-S2H-CF, BIOS F23 08/08/2018
Dec 29 19:21:17 gentoo kernel: Call Trace:
Dec 29 19:21:17 gentoo kernel:  <IRQ>
Dec 29 19:21:17 gentoo kernel:  dump_stack+0x67/0x9b
Dec 29 19:21:17 gentoo kernel:  __schedule_bug+0x4c/0x70
Dec 29 19:21:17 gentoo kernel:  __schedule+0x6d7/0x840
Dec 29 19:21:17 gentoo kernel:  ? enqueue_task_fair+0xa8/0x6d0
Dec 29 19:21:17 gentoo kernel:  schedule+0x28/0x80
Dec 29 19:21:17 gentoo kernel:  schedule_timeout+0x1f9/0x440
Dec 29 19:21:17 gentoo kernel:  ? _raw_spin_unlock_irqrestore+0x21/0x30
Dec 29 19:21:17 gentoo kernel:  ? wait_for_common+0xb5/0x180
Dec 29 19:21:17 gentoo kernel:  wait_for_common+0xbe/0x180
Dec 29 19:21:17 gentoo kernel:  ? wake_up_q+0x80/0x80
Dec 29 19:21:17 gentoo kernel:  ? rtw_aes_decrypt+0x1b9/0x200 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  wait_for_completion_killable+0x19/0x30
Dec 29 19:21:17 gentoo kernel:  call_usermodehelper_exec+0xeb/0x170
Dec 29 19:21:17 gentoo kernel:  __request_module+0x1a1/0x430
Dec 29 19:21:17 gentoo kernel:  ? fetch_pte.isra.1+0x5/0x180
Dec 29 19:21:17 gentoo kernel:  ? iommu_unmap_page+0x6b/0x100
Dec 29 19:21:17 gentoo kernel:  ? _raw_spin_unlock_irqrestore+0x16/0x30
Dec 29 19:21:17 gentoo kernel:  rtw_aes_decrypt+0x1b9/0x200 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  recv_func_posthandle+0x346/0x960 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  rtw_recv_entry+0x48e/0x980 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  rtl8188eu_recv_tasklet+0xac/0x5b0 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  ? tasklet_action_common.isra.5+0x2e/0xb0
Dec 29 19:21:17 gentoo kernel:  ? tasklet_action_common.isra.5+0x4c/0xb0
Dec 29 19:21:17 gentoo kernel:  tasklet_action_common.isra.5+0x4c/0xb0
Dec 29 19:21:17 gentoo kernel:  __do_softirq+0x104/0x365
Dec 29 19:21:17 gentoo kernel:  irq_exit+0xd1/0xe0
Dec 29 19:21:17 gentoo kernel:  do_IRQ+0x85/0xd0
Dec 29 19:21:17 gentoo kernel:  common_interrupt+0xf/0xf
Dec 29 19:21:17 gentoo kernel:  </IRQ>
Dec 29 19:21:17 gentoo kernel: RIP: 0010:cpuidle_enter_state+0xba/0x320
Dec 29 19:21:17 gentoo kernel: Code: 1f 44 00 00 31 ff e8 75 89 b3 ff 45 84 f6 74 12 9c 58 f6 c4 02 0f 85 3b 02 00 00 31
ff e8 9e dd b8 ff e8 e9 ad bd ff fb 85 ed <0f> 88 19 02 00 00 4c 29 fb 48 ba cf f7 53 e3 a5 9b c4 20 48 89 d8
Dec 29 19:21:17 gentoo kernel: RSP: 0018:ffffb6fd800c3ea0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffdd
Dec 29 19:21:17 gentoo kernel: RAX: 0000000080000000 RBX: 00000016a9699495 RCX: 000000000000001f
Dec 29 19:21:17 gentoo kernel: RDX: 00000016a9699495 RSI: 0000000000000000 RDI: ffffffffb395c087
Dec 29 19:21:17 gentoo kernel: RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000020b80
Dec 29 19:21:17 gentoo kernel: R10: ffffb6fd800c3e88 R11: 000000000000008f R12: ffffffffb4521378
Dec 29 19:21:17 gentoo kernel: R13: ffff92191187c400 R14: 0000000000000000 R15: 00000016a963fe0a
Dec 29 19:21:17 gentoo kernel:  ? cpuidle_enter_state+0xb7/0x320
Dec 29 19:21:17 gentoo kernel:  do_idle+0x1ec/0x260
Dec 29 19:21:17 gentoo kernel:  cpu_startup_entry+0x19/0x20
Dec 29 19:21:17 gentoo kernel:  start_secondary+0x19a/0x1e0
Dec 29 19:21:17 gentoo kernel:  secondary_startup_64+0xa4/0xb0
Dec 29 19:21:17 gentoo kernel: bad: scheduling from the idle thread!
Dec 29 19:21:17 gentoo kernel: CPU: 6 PID: 0 Comm: swapper/6 Tainted: G        WC        4.20.0-gentoo #1
Dec 29 19:21:17 gentoo kernel: Hardware name: Gigabyte Technology Co., Ltd. A320M-S2H/A320M-S2H-CF, BIOS F23 08/08/2018
Dec 29 19:21:17 gentoo kernel: Call Trace:
Dec 29 19:21:17 gentoo kernel:  <IRQ>
Dec 29 19:21:17 gentoo kernel:  dump_stack+0x67/0x9b
Dec 29 19:21:17 gentoo kernel:  dequeue_task_idle+0x23/0x30
Dec 29 19:21:17 gentoo kernel:  __schedule+0x386/0x840
Dec 29 19:21:17 gentoo kernel:  ? enqueue_task_fair+0xa8/0x6d0
Dec 29 19:21:17 gentoo kernel:  schedule+0x28/0x80
Dec 29 19:21:17 gentoo kernel:  schedule_timeout+0x1f9/0x440
Dec 29 19:21:17 gentoo kernel:  ? _raw_spin_unlock_irqrestore+0x21/0x30
Dec 29 19:21:17 gentoo kernel:  ? wait_for_common+0xb5/0x180
Dec 29 19:21:17 gentoo kernel:  wait_for_common+0xbe/0x180
Dec 29 19:21:17 gentoo kernel:  ? wake_up_q+0x80/0x80
Dec 29 19:21:17 gentoo kernel:  ? rtw_aes_decrypt+0x1b9/0x200 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  wait_for_completion_killable+0x19/0x30
Dec 29 19:21:17 gentoo kernel:  call_usermodehelper_exec+0xeb/0x170
Dec 29 19:21:17 gentoo kernel:  __request_module+0x1a1/0x430
Dec 29 19:21:17 gentoo kernel:  ? fetch_pte.isra.1+0x5/0x180
Dec 29 19:21:17 gentoo kernel:  ? iommu_unmap_page+0x6b/0x100
Dec 29 19:21:17 gentoo kernel:  ? _raw_spin_unlock_irqrestore+0x16/0x30
Dec 29 19:21:17 gentoo kernel:  rtw_aes_decrypt+0x1b9/0x200 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  recv_func_posthandle+0x346/0x960 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  rtw_recv_entry+0x48e/0x980 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  rtl8188eu_recv_tasklet+0xac/0x5b0 [r8188eu]
Dec 29 19:21:17 gentoo kernel:  ? tasklet_action_common.isra.5+0x2e/0xb0
Dec 29 19:21:17 gentoo kernel:  ? tasklet_action_common.isra.5+0x4c/0xb0
Dec 29 19:21:17 gentoo kernel:  tasklet_action_common.isra.5+0x4c/0xb0
Dec 29 19:21:17 gentoo kernel:  __do_softirq+0x104/0x365
Dec 29 19:21:17 gentoo kernel:  irq_exit+0xd1/0xe0
Dec 29 19:21:17 gentoo kernel:  do_IRQ+0x85/0xd0
Dec 29 19:21:17 gentoo kernel:  common_interrupt+0xf/0xf
Dec 29 19:21:17 gentoo kernel:  </IRQ>
Dec 29 19:21:17 gentoo kernel: RIP: 0010:cpuidle_enter_state+0xba/0x320
Dec 29 19:21:17 gentoo kernel: Code: 1f 44 00 00 31 ff e8 75 89 b3 ff 45 84 f6 74 12 9c 58 f6 c4 02 0f 85 3b 02 00 00 31
ff e8 9e dd b8 ff e8 e9 ad bd ff fb 85 ed <0f> 88 19 02 00 00 4c 29 fb 48 ba cf f7 53 e3 a5 9b c4 20 48 89 d8
Dec 29 19:21:17 gentoo kernel: RSP: 0018:ffffb6fd800c3ea0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffdd
Dec 29 19:21:17 gentoo kernel: RAX: 0000000080000000 RBX: 00000016a9699495 RCX: 000000000000001f
Dec 29 19:21:17 gentoo kernel: RDX: 00000016a9699495 RSI: 0000000000000000 RDI: ffffffffb395c087
Dec 29 19:21:17 gentoo kernel: RBP: 0000000000000001 R08: 0000000000000002 R09: 0000000000020b80
Dec 29 19:21:17 gentoo kernel: R10: ffffb6fd800c3e88 R11: 000000000000008f R12: ffffffffb4521378
Dec 29 19:21:17 gentoo kernel: R13: ffff92191187c400 R14: 0000000000000000 R15: 00000016a963fe0a
Dec 29 19:21:17 gentoo kernel:  ? cpuidle_enter_state+0xb7/0x320
Dec 29 19:21:17 gentoo kernel:  do_idle+0x1ec/0x260
Dec 29 19:21:17 gentoo kernel:  cpu_startup_entry+0x19/0x20
Dec 29 19:21:17 gentoo kernel:  start_secondary+0x19a/0x1e0
Dec 29 19:21:17 gentoo kernel:  secondary_startup_64+0xa4/0xb0
Dec 29 19:21:17 gentoo kernel: lib80211_crypt: registered algorithm 'CCMP'
Dec 29 19:21:17 gentoo kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000000

Fixes: 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/Kconfig             |   1 -
 drivers/staging/rtl8188eu/core/rtw_security.c | 266 ++++++++++++++----
 2 files changed, 216 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
index ff7832798a77..d787a091d3c1 100644
--- a/drivers/staging/rtl8188eu/Kconfig
+++ b/drivers/staging/rtl8188eu/Kconfig
@@ -6,7 +6,6 @@ config R8188EU
 	select WEXT_PRIV
 	select LIB80211
 	select LIB80211_CRYPT_WEP
-	select LIB80211_CRYPT_CCMP
 	---help---
 	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
 	If built as a module, it will be called r8188eu.
diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 364d6ea14bf8..bca4157cb224 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -1276,24 +1276,217 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	return res;
 }
 
-u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
+static int aes_decipher(u8 *key, uint	hdrlen,
+			u8 *pframe, uint plen)
 {
-	struct rx_pkt_attrib *prxattrib = &((struct recv_frame *)precvframe)->attrib;
-	u32 res = _SUCCESS;
+	static u8	message[MAX_MSG_SIZE];
+	uint	qc_exists, a4_exists, i, j, payload_remainder,
+			num_blocks, payload_index;
+	int res = _SUCCESS;
+
+	u8 pn_vector[6];
+	u8 mic_iv[16];
+	u8 mic_header1[16];
+	u8 mic_header2[16];
+	u8 ctr_preload[16];
+
+	/* Intermediate Buffers */
+	u8 chain_buffer[16];
+	u8 aes_out[16];
+	u8 padded_buffer[16];
+	u8 mic[8];
+
+/*	uint	offset = 0; */
+	uint	frtype  = GetFrameType(pframe);
+	uint	frsubtype  = GetFrameSubType(pframe);
+	frsubtype >>= 4;
+
+	memset(mic_iv, 0, 16);
+	memset(mic_header1, 0, 16);
+	memset(mic_header2, 0, 16);
+	memset(ctr_preload, 0, 16);
+	memset(chain_buffer, 0, 16);
+	memset(aes_out, 0, 16);
+	memset(padded_buffer, 0, 16);
+
+	/* start to decrypt the payload */
+
+	num_blocks = (plen-8) / 16; /* plen including llc, payload_length and mic) */
+
+	payload_remainder = (plen-8) % 16;
+
+	pn_vector[0]  = pframe[hdrlen];
+	pn_vector[1]  = pframe[hdrlen+1];
+	pn_vector[2]  = pframe[hdrlen+4];
+	pn_vector[3]  = pframe[hdrlen+5];
+	pn_vector[4]  = pframe[hdrlen+6];
+	pn_vector[5]  = pframe[hdrlen+7];
+
+	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
+		a4_exists = 0;
+	else
+		a4_exists = 1;
+
+	if ((frtype == WIFI_DATA_CFACK) || (frtype == WIFI_DATA_CFPOLL) ||
+	    (frtype == WIFI_DATA_CFACKPOLL)) {
+			qc_exists = 1;
+			if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
+				hdrlen += 2;
+	} else if ((frsubtype == 0x08) || (frsubtype == 0x09) ||
+		   (frsubtype == 0x0a) || (frsubtype == 0x0b)) {
+		if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
+			hdrlen += 2;
+		qc_exists = 1;
+	} else {
+		qc_exists = 0;
+	}
+
+	/*  now, decrypt pframe with hdrlen offset and plen long */
+
+	payload_index = hdrlen + 8; /*  8 is for extiv */
+
+	for (i = 0; i < num_blocks; i++) {
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, i+1);
+
+		aes128k128d(key, ctr_preload, aes_out);
+		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
+
+		for (j = 0; j < 16; j++)
+			pframe[payload_index++] = chain_buffer[j];
+	}
+
+	if (payload_remainder > 0) {    /* If there is a short final block, then pad it,*/
+					/* encrypt it and copy the unpadded part back   */
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe, pn_vector, num_blocks+1);
+
+		for (j = 0; j < 16; j++)
+			padded_buffer[j] = 0x00;
+		for (j = 0; j < payload_remainder; j++)
+			padded_buffer[j] = pframe[payload_index+j];
+		aes128k128d(key, ctr_preload, aes_out);
+		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		for (j = 0; j < payload_remainder; j++)
+			pframe[payload_index++] = chain_buffer[j];
+	}
+
+	/* start to calculate the mic */
+	if ((hdrlen+plen+8) <= MAX_MSG_SIZE)
+		memcpy(message, pframe, (hdrlen + plen+8)); /* 8 is for ext iv len */
+
+	pn_vector[0] = pframe[hdrlen];
+	pn_vector[1] = pframe[hdrlen+1];
+	pn_vector[2] = pframe[hdrlen+4];
+	pn_vector[3] = pframe[hdrlen+5];
+	pn_vector[4] = pframe[hdrlen+6];
+	pn_vector[5] = pframe[hdrlen+7];
+	construct_mic_iv(mic_iv, qc_exists, a4_exists, message, plen-8, pn_vector);
+
+	construct_mic_header1(mic_header1, hdrlen, message);
+	construct_mic_header2(mic_header2, message, a4_exists, qc_exists);
+
+	payload_remainder = (plen-8) % 16;
+	num_blocks = (plen-8) / 16;
+
+	/* Find start of payload */
+	payload_index = hdrlen + 8;
+
+	/* Calculate MIC */
+	aes128k128d(key, mic_iv, aes_out);
+	bitwise_xor(aes_out, mic_header1, chain_buffer);
+	aes128k128d(key, chain_buffer, aes_out);
+	bitwise_xor(aes_out, mic_header2, chain_buffer);
+	aes128k128d(key, chain_buffer, aes_out);
+
+	for (i = 0; i < num_blocks; i++) {
+		bitwise_xor(aes_out, &message[payload_index], chain_buffer);
+
+		payload_index += 16;
+		aes128k128d(key, chain_buffer, aes_out);
+	}
+
+	/* Add on the final payload block if it needs padding */
+	if (payload_remainder > 0) {
+		for (j = 0; j < 16; j++)
+			padded_buffer[j] = 0x00;
+		for (j = 0; j < payload_remainder; j++)
+			padded_buffer[j] = message[payload_index++];
+		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		aes128k128d(key, chain_buffer, aes_out);
+	}
 
+	for (j = 0 ; j < 8; j++)
+		mic[j] = aes_out[j];
+
+	/* Insert MIC into payload */
+	for (j = 0; j < 8; j++)
+		message[payload_index+j] = mic[j];
+
+	payload_index = hdrlen + 8;
+	for (i = 0; i < num_blocks; i++) {
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, i+1);
+		aes128k128d(key, ctr_preload, aes_out);
+		bitwise_xor(aes_out, &message[payload_index], chain_buffer);
+		for (j = 0; j < 16; j++)
+			message[payload_index++] = chain_buffer[j];
+	}
+
+	if (payload_remainder > 0) { /* If there is a short final block, then pad it,*/
+		/* encrypt it and copy the unpadded part back   */
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, num_blocks+1);
+
+		for (j = 0; j < 16; j++)
+			padded_buffer[j] = 0x00;
+		for (j = 0; j < payload_remainder; j++)
+			padded_buffer[j] = message[payload_index+j];
+		aes128k128d(key, ctr_preload, aes_out);
+		bitwise_xor(aes_out, padded_buffer, chain_buffer);
+		for (j = 0; j < payload_remainder; j++)
+			message[payload_index++] = chain_buffer[j];
+	}
+
+	/* Encrypt the MIC */
+	construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message, pn_vector, 0);
+
+	for (j = 0; j < 16; j++)
+		padded_buffer[j] = 0x00;
+	for (j = 0; j < 8; j++)
+		padded_buffer[j] = message[j+hdrlen+8+plen-8];
+
+	aes128k128d(key, ctr_preload, aes_out);
+	bitwise_xor(aes_out, padded_buffer, chain_buffer);
+	for (j = 0; j < 8; j++)
+		message[payload_index++] = chain_buffer[j];
+
+	/* compare the mic */
+	for (i = 0; i < 8; i++) {
+		if (pframe[hdrlen+8+plen-8+i] != message[hdrlen+8+plen-8+i]) {
+			RT_TRACE(_module_rtl871x_security_c_, _drv_err_,
+				 ("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
+				 i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]));
+			DBG_88E("aes_decipher:mic check error mic[%d]: pframe(%x)!=message(%x)\n",
+				i, pframe[hdrlen+8+plen-8+i], message[hdrlen+8+plen-8+i]);
+			res = _FAIL;
+		}
+	}
+	return res;
+}
+
+u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
+{	/*  exclude ICV */
+	/* Intermediate Buffers */
+	int		length;
+	u8	*pframe, *prwskey;	/*  *payload,*iv */
+	struct	sta_info		*stainfo;
+	struct	rx_pkt_attrib	 *prxattrib = &((struct recv_frame *)precvframe)->attrib;
+	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
+	u32	res = _SUCCESS;
+
+	pframe = (unsigned char *)((struct recv_frame *)precvframe)->pkt->data;
 	/* 4 start to encrypt each fragment */
 	if (prxattrib->encrypt == _AES_) {
-		struct sta_info *stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
-
+		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 		if (stainfo != NULL) {
-			int key_idx;
-			const int key_length = 16, iv_len = 8, icv_len = 8;
-			struct sk_buff *skb = ((struct recv_frame *)precvframe)->pkt;
-			void *crypto_private = NULL;
-			u8 *key, *pframe = skb->data;
-			struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("CCMP"), "lib80211_crypt_ccmp");
-			struct security_priv *psecuritypriv = &padapter->securitypriv;
-			char iv[8], icv[8];
+			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
 
 			if (is_multicast_ether_addr(prxattrib->ra)) {
 				/* in concurrent we should use sw descrypt in group key, so we remove this message */
@@ -1302,45 +1495,18 @@ u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 					DBG_88E("%s:rx bc/mc packets, but didn't install group key!!!!!!!!!!\n", __func__);
 					goto exit;
 				}
-				key_idx = psecuritypriv->dot118021XGrpKeyid;
-				key = psecuritypriv->dot118021XGrpKey[key_idx].skey;
+				prwskey = psecuritypriv->dot118021XGrpKey[prxattrib->key_index].skey;
+				if (psecuritypriv->dot118021XGrpKeyid != prxattrib->key_index) {
+					DBG_88E("not match packet_index=%d, install_index=%d\n",
+						prxattrib->key_index, psecuritypriv->dot118021XGrpKeyid);
+					res = _FAIL;
+					goto exit;
+				}
 			} else {
-				key_idx = 0;
-				key = stainfo->dot118021x_UncstKey.skey;
-			}
-
-			if (!crypto_ops) {
-				res = _FAIL;
-				goto exit_lib80211_ccmp;
-			}
-
-			memcpy(iv, pframe + prxattrib->hdrlen, iv_len);
-			memcpy(icv, pframe + skb->len - icv_len, icv_len);
-
-			crypto_private = crypto_ops->init(key_idx);
-			if (!crypto_private) {
-				res = _FAIL;
-				goto exit_lib80211_ccmp;
-			}
-			if (crypto_ops->set_key(key, key_length, NULL, crypto_private) < 0) {
-				res = _FAIL;
-				goto exit_lib80211_ccmp;
-			}
-			if (crypto_ops->decrypt_mpdu(skb, prxattrib->hdrlen, crypto_private)) {
-				res = _FAIL;
-				goto exit_lib80211_ccmp;
+				prwskey = &stainfo->dot118021x_UncstKey.skey[0];
 			}
-
-			memmove(pframe, pframe + iv_len, prxattrib->hdrlen);
-			skb_push(skb, iv_len);
-			skb_put(skb, icv_len);
-
-			memcpy(pframe + prxattrib->hdrlen, iv, iv_len);
-			memcpy(pframe + skb->len - icv_len, icv, icv_len);
-
-exit_lib80211_ccmp:
-			if (crypto_ops && crypto_private)
-				crypto_ops->deinit(crypto_private);
+			length = ((struct recv_frame *)precvframe)->pkt->len-prxattrib->hdrlen-prxattrib->iv_len;
+			res = aes_decipher(prwskey, prxattrib->hdrlen, pframe, length);
 		} else {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo==NULL!!!\n"));
 			res = _FAIL;
-- 
2.20.1

