Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AD6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618912146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXlqDA/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618912146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeKPMkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 07:40:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38174 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeKPMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 07:40:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id u3so14926919ota.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 18:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZjRkEFVinMKLbpsM4lwImJJvpAq8L2mCVpMECVoXe7k=;
        b=vXlqDA/12hATZE+G3KCQvIE3zEMGuwpge0/LhsL0C9WCOcGdXM5W9uYQbrQMI0MB5L
         E9U/voeHeVwHk+h1KcpeLnmqmEyGpNiKnzszhTrJdCPokTkqaf7WfmFhyEyomzoF5vjA
         30vepSLydBZaCPpqVP2korS+czdb89KL+dhe5/7MxHIJSrN0+z/hOTCkAM7nFZYPrl59
         BYVHmTOXgPu2tf3DZNMs4IHQHPaqQYa4SXymAjJpGOMtHcVOOrbDF0gNMkSaGy/PeuZQ
         7KPrgqGoq2Quhi4jcgZoUMMPJK1clkg53dExRhwiKfsROjMlQsTSGu06SEH7IyCsLdWv
         H40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZjRkEFVinMKLbpsM4lwImJJvpAq8L2mCVpMECVoXe7k=;
        b=A5ovhu28TOti/L7nsB5dFQOKfcUKrFX3uO8br5xYv5f4gyg0CVVLdzpJ0zIl8Iozjb
         mC2Q8cewaeqG7FBSJ76815o6EO/boNwCE3Ir22eZwB1+MLBvtA7BpAFCOmTG+Jhb18/k
         uCAZKK0U13H5l9FT4ecjPMwBq61n1FFoN/AlDoiXloQUOpGMMb57h0sjB1x7hZNwW1H+
         g9VdYVmmobY8T4acthxI6AJRhbai1C34ibIQOjjMW3lgEvdelEknn7urBOLtIG0wBi1M
         Bekc0z9h+ENblZaOJgHnTJQeg4Rmf3ws2MkHpYMkhO3gLxVazpOVpWntHIQXbPryg/zO
         2Vvw==
X-Gm-Message-State: AGRZ1gLd+NTcLfyxB9dnq8T3qApwvMZwpTjom9SDDyt/tWt2ITm3CVJC
        yca8SF08hhhIDMSOwrLrUYUU4/hoVodfWPUGheUv2xR2
X-Google-Smtp-Source: AJdET5e9avKhkTQznsWHnWxBJaYdR7211AUWNoHhkIS0iiI3PiSpanH1dfQBsr5lNRd9q6BqHDj8rf8g13VX6LWUlP8=
X-Received: by 2002:a9d:2990:: with SMTP id n16mr5020505otb.19.1542335388139;
 Thu, 15 Nov 2018 18:29:48 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Sanderson <kyle.leet@gmail.com>
Date:   Thu, 15 Nov 2018 18:29:37 -0800
Message-ID: <CACsaVZ+vw7X12dimJ20SCgv2Bryt8hBSc736tHqAHXVNUi4o6Q@mail.gmail.com>
Subject: Oops: 0003 [#1] PREEMPT SMP NOPTI
To:     Linux-Kernal <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2008(!) dual-core Atom box.
model name      : Intel(R) Atom(TM) CPU  330   @ 1.60GHz

[1027540.690329] perf: interrupt took too long (12579 > 12560),
lowering kernel.perf_event_max_sample_rate to 15000
[1027540.774026] perf: interrupt took too long (15754 > 15723),
lowering kernel.perf_event_max_sample_rate to 12000
[1027541.963573] BUG: unable to handle kernel paging request at ffffffffb0428a44
[1027541.963647] IP: format_decode+0x20/0x3d0
[1027541.963676] PGD 2100c067 P4D 2100c067 PUD 2100d063 PMD 8000000020e001e1
[1027541.963723] Oops: 0003 [#1] PREEMPT SMP NOPTI
[1027541.963752] Modules linked in: af_packet_diag sctp_diag sctp
tcp_diag udp_diag dccp_diag dccp inet_diag unix_diag nfsd auth_rpcgss
nfs_acl tda18271 s5h1411 cfg80211 rfkill 8021q garp stp llc
xt_hashlimit iptable_filter ip_tables xt_length nf_conntrack_ipv6
nf_defrag_ipv6 xt_conntrack ip6table_filter ip6_tables ipv6 crc_ccitt
cachefiles snd_hda_codec_hdmi snd_hda_codec_realtek nouveau
snd_hda_codec_generic mxm_wmi video ttm wmi_bmof saa7164
nf_conntrack_ftp drm_kms_helper nf_conntrack tveeprom dvb_core bcache
drm videodev snd_hda_intel coretemp media syscopyarea sysfillrect
snd_hda_codec pcspkr serio_raw sysimgblt snd_hda_core fb_sys_fops
snd_hwdep snd_pcm snd_timer snd forcedeth soundcore i2c_nforce2 wmi
xts crypto_simd glue_helper cryptd aes_x86_64 crc32_generic cbc
sha256_generic ixgb ixgbe tulip
[1027541.964143]  cxgb3 cxgb mdio cxgb4 vxge bonding vxlan
ip6_udp_tunnel udp_tunnel macvlan vmxnet3 tg3 sky2 r8169 pcnet32 mii
igb ptp pps_core dca i2c_algo_bit i2c_core e1000 bnx2 atl1c msdos fat
configfs cramfs squashfs fuse xfs nfs lockd grace sunrpc fscache jfs
reiserfs btrfs zstd_decompress zstd_compress xxhash ext4 jbd2 ext2
mbcache linear raid10 raid1 raid0 dm_zero dm_verity reed_solomon
dm_thin_pool dm_switch dm_snapshot dm_raid raid456 async_raid6_recov
async_memcpy async_pq raid6_pq dm_mirror dm_region_hash dm_log_writes
dm_log_userspace dm_log dm_integrity async_xor async_tx xor dm_flakey
dm_era dm_delay dm_crypt dm_cache_smq dm_cache dm_persistent_data
libcrc32c dm_bufio dm_bio_prison dm_mod dax firewire_core crc_itu_t
sl811_hcd xhci_pci xhci_hcd usb_storage mpt3sas raid_class aic94xx
libsas
[1027541.964537]  lpfc qla2xxx megaraid_sas megaraid_mbox megaraid_mm
aacraid sx8 hpsa 3w_9xxx 3w_xxxx 3w_sas mptsas scsi_transport_sas
mptfc scsi_transport_fc mptspi mptscsih mptbase imm parport sym53c8xx
initio arcmsr aic7xxx aic79xx scsi_transport_spi sr_mod cdrom sg
sd_mod pdc_adma sata_inic162x sata_mv ata_piix ahci libahci sata_qstor
sata_vsc sata_uli sata_sis sata_sx4 sata_nv sata_via sata_svw
sata_sil24 sata_sil sata_promise pata_via pata_jmicron pata_marvell
pata_sis pata_netcell pata_pdc202xx_old pata_atiixp pata_amd pata_ali
pata_it8213 pata_pcmcia pata_serverworks pata_oldpiix pata_artop
pata_it821x pata_hpt3x2n pata_hpt3x3 pata_hpt37x pata_hpt366
pata_cmd64x pata_sil680 pata_pdc2027x nvme nvme_core virtio_net
virtio_crypto crypto_engine virtio_mmio virtio_pci virtio_balloon
virtio_rng virtio_console
[1027541.964933]  virtio_blk virtio_scsi virtio_ring virtio
[1027541.964981] CPU: 2 PID: 11405 Comm: atop Not tainted 4.14.65-gentoo #1
[1027541.965013] Hardware name: To Be Filled By O.E.M. To Be Filled By
O.E.M./To be filled by O.E.M., BIOS 080015  11/05/2009
[1027541.965072] task: ffff928755972400 task.stack: ffff9e8c02264000
[1027541.965114] RIP: 0010:format_decode+0x20/0x3d0
[1027541.965144] RSP: 0018:ffff9e8c02267ba0 EFLAGS: 00010216
[1027541.965177] RAX: 0000000000000020 RBX: ffff928687ae307b RCX:
0000000000000014
[1027541.965212] RDX: 0000000000000014 RSI: ffffffffb0428a44 RDI:
ffff928687ae307b
[1027541.965245] RBP: ffffffffb0428a44 R08: 6e72654b0a426b20 R09:
6953656761506c65
[1027541.965278] R10: 61506c656e72654b R11: 203a657a69536567 R12:
0000000000000f9d
[1027541.965327] R13: ffff9e8c02267c28 R14: ffffffffb0428a44 R15:
ffffffffb0428a58
[1027541.965363] FS:  00007f8f05183680(0000) GS:ffff92875bb00000(0000)
knlGS:0000000000000000
[1027541.965398] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1027541.965430] CR2: ffffffffb0428a44 CR3: 0000000081e1e000 CR4:
00000000000006e0
[1027541.965463] Call Trace:
[1027541.965501]  vsnprintf+0x56/0x4d0
[1027541.965533]  ? vsnprintf+0xda/0x4d0
[1027541.965587]  ? seq_vprintf+0x30/0x50
[1027541.965619]  ? seq_printf+0x45/0x50
[1027541.965657]  ? show_smap.isra.34+0x19f/0x3e0
[1027541.965693]  ? smaps_hugetlb_range+0x120/0x120
[1027541.965728]  ? pagemap_pmd_range+0x640/0x640
[1027541.965768]  ? seq_read+0xed/0x3b0
[1027541.965800]  ? __vfs_read+0x25/0x130
[1027541.965832]  ? vfs_read+0x94/0x140
[1027541.965863]  ? SyS_read+0x46/0xa0
[1027541.965893]  ? do_syscall_64+0x6a/0x120
[1027541.965927]  ? entry_SYSCALL_64_after_hwframe+0x42/0xb7
[1027541.965965] Code: e8 a1 86 a2 ff 0f 0b eb c6 66 90 55 48 8d 2e 53
48 8d 1f 48 8d 64 24 f8 0f b6 06 48 89 3c 24 3c 01 74 4c 3c 02 0f 84
a2 01 00 00 <c6> 06 00 0f b6 07 84 c0 0f 84 db 02 00 00 3c 25 0f 84 3b
03 00
[1027541.966170] RIP: format_decode+0x20/0x3d0 RSP: ffff9e8c02267ba0
[1027541.966201] CR2: ffffffffb0428a44
[1027541.966231] ---[ end trace cf7753a559ea0416 ]---
