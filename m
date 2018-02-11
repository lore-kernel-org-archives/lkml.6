Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325765-2-12067138451688973393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325764; b=tKAan2hRSlAlzIbhdd7l6H8sfDIjEGQDshvLF4XOF0kBm2M
    AxZZeq3TXojXbQwD04g5lSads9eCv9DENBIfO3w/kdHbubwQWUOSKH4txhTCjdKL
    h/lzKn6cO4wTw6pDxlFDrVZSd1XBk/mES8Li4v5PkjUJtgvDPem7yhL3b9YS5sa4
    W41imJzYsHO2dyNOELAzUUltHBsd/tCoce+A1c9j9K3GQ/Wa0Z0krfFlqERJJjNO
    ca3A8mH+QuAEp1BnaoijZhiMzxp4tlZ0UjSE6exzZY8LJMSCZGL7irG6MBPcfKnu
    a93YoMBse5GwOPln+HqgqsQ+OghzUyfgZEQhczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325764; bh=nbRRLxpSeu1nzgk3Ged
    iXZRmmrBIECHd/wL+2k9Og+I=; b=kjcRk/vlMcH1ONy7EHM2Lh8YIYmoNLD8Uj0
    dxLY8YQOGzDXwiuLNh2OmmxJwqjA+kRyr94LEzE4NMfwduU1ciKrZugOtIHk3mBM
    Y9XE2uKPAOXzSXjllyE7UiYDFUED28k9AKSG7jOTOHN2WVbYsq8gtxumFKuDIYmK
    89axXc/HdFHy/5UBgIx6PatBD0BAPmhsQ/P4PUdWAuHrIrsq02OqWhFKEGk2rGmd
    chBtR9zsvG9KQvbhgdXhpvnfIyycRbfoLqpvA/wcG/9TRB430CHeZCRZ1GiDqb+H
    D0Qz7UfkgSrT6AqFG95o/k+sJouMQtMhhjjBUT2MwbAT13ihcig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeBKFH2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:07:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41469 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752659AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Michele Baldessari" <michele@acksyn.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.130883530@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 28/79] media: Don't do DMA on stack for firmware
 upload in the AS102 driver
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michele Baldessari <michele@acksyn.org>

commit b3120d2cc447ee77b9d69bf4ad7b452c9adb4d39 upstream.

Firmware load on AS102 is using the stack which is not allowed any
longer. We currently fail with:

kernel: transfer buffer not dma capable
kernel: ------------[ cut here ]------------
kernel: WARNING: CPU: 0 PID: 598 at drivers/usb/core/hcd.c:1595 usb_hcd_map_urb_for_dma+0x41d/0x620
kernel: Modules linked in: amd64_edac_mod(-) edac_mce_amd as102_fe dvb_as102(+) kvm_amd kvm snd_hda_codec_realtek dvb_core snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_hda_codec irqbypass crct10dif_pclmul crc32_pclmul snd_hda_core snd_hwdep snd_seq ghash_clmulni_intel sp5100_tco fam15h_power wmi k10temp i2c_piix4 snd_seq_device snd_pcm snd_timer parport_pc parport tpm_infineon snd tpm_tis soundcore tpm_tis_core tpm shpchp acpi_cpufreq xfs libcrc32c amdgpu amdkfd amd_iommu_v2 radeon hid_logitech_hidpp i2c_algo_bit drm_kms_helper crc32c_intel ttm drm r8169 mii hid_logitech_dj
kernel: CPU: 0 PID: 598 Comm: systemd-udevd Not tainted 4.13.10-200.fc26.x86_64 #1
kernel: Hardware name: ASUS All Series/AM1I-A, BIOS 0505 03/13/2014
kernel: task: ffff979933b24c80 task.stack: ffffaf83413a4000
kernel: RIP: 0010:usb_hcd_map_urb_for_dma+0x41d/0x620
systemd-fsck[659]: /dev/sda2: clean, 49/128016 files, 268609/512000 blocks
kernel: RSP: 0018:ffffaf83413a7728 EFLAGS: 00010282
systemd-udevd[604]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
kernel: RAX: 000000000000001f RBX: ffff979930bce780 RCX: 0000000000000000
kernel: RDX: 0000000000000000 RSI: ffff97993ec0e118 RDI: ffff97993ec0e118
kernel: RBP: ffffaf83413a7768 R08: 000000000000039a R09: 0000000000000000
kernel: R10: 0000000000000001 R11: 00000000ffffffff R12: 00000000fffffff5
kernel: R13: 0000000001400000 R14: 0000000000000001 R15: ffff979930806800
kernel: FS:  00007effaca5c8c0(0000) GS:ffff97993ec00000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007effa9fca962 CR3: 0000000233089000 CR4: 00000000000406f0
kernel: Call Trace:
kernel:  usb_hcd_submit_urb+0x493/0xb40
kernel:  ? page_cache_tree_insert+0x100/0x100
kernel:  ? xfs_iunlock+0xd5/0x100 [xfs]
kernel:  ? xfs_file_buffered_aio_read+0x57/0xc0 [xfs]
kernel:  usb_submit_urb+0x22d/0x560
kernel:  usb_start_wait_urb+0x6e/0x180
kernel:  usb_bulk_msg+0xb8/0x160
kernel:  as102_send_ep1+0x49/0xe0 [dvb_as102]
kernel:  ? devres_add+0x3f/0x50
kernel:  as102_firmware_upload.isra.0+0x1dc/0x210 [dvb_as102]
kernel:  as102_fw_upload+0xb6/0x1f0 [dvb_as102]
kernel:  as102_dvb_register+0x2af/0x2d0 [dvb_as102]
kernel:  as102_usb_probe+0x1f3/0x260 [dvb_as102]
kernel:  usb_probe_interface+0x124/0x300
kernel:  driver_probe_device+0x2ff/0x450
kernel:  __driver_attach+0xa4/0xe0
kernel:  ? driver_probe_device+0x450/0x450
kernel:  bus_for_each_dev+0x6e/0xb0
kernel:  driver_attach+0x1e/0x20
kernel:  bus_add_driver+0x1c7/0x270
kernel:  driver_register+0x60/0xe0
kernel:  usb_register_driver+0x81/0x150
kernel:  ? 0xffffffffc0807000
kernel:  as102_usb_driver_init+0x1e/0x1000 [dvb_as102]
kernel:  do_one_initcall+0x50/0x190
kernel:  ? __vunmap+0x81/0xb0
kernel:  ? kfree+0x154/0x170
kernel:  ? kmem_cache_alloc_trace+0x15f/0x1c0
kernel:  ? do_init_module+0x27/0x1e9
kernel:  do_init_module+0x5f/0x1e9
kernel:  load_module+0x2602/0x2c30
kernel:  SYSC_init_module+0x170/0x1a0
kernel:  ? SYSC_init_module+0x170/0x1a0
kernel:  SyS_init_module+0xe/0x10
kernel:  do_syscall_64+0x67/0x140
kernel:  entry_SYSCALL64_slow_path+0x25/0x25
kernel: RIP: 0033:0x7effab6cf3ea
kernel: RSP: 002b:00007fff5cfcbbc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
kernel: RAX: ffffffffffffffda RBX: 00005569e0b83760 RCX: 00007effab6cf3ea
kernel: RDX: 00007effac2099c5 RSI: 0000000000009a13 RDI: 00005569e0b98c50
kernel: RBP: 00007effac2099c5 R08: 00005569e0b83ed0 R09: 0000000000001d80
kernel: R10: 00007effab98db00 R11: 0000000000000246 R12: 00005569e0b98c50
kernel: R13: 00005569e0b81c60 R14: 0000000000020000 R15: 00005569dfadfdf7
kernel: Code: 48 39 c8 73 30 80 3d 59 60 9d 00 00 41 bc f5 ff ff ff 0f 85 26 ff ff ff 48 c7 c7 b8 6b d0 92 c6 05 3f 60 9d 00 01 e8 24 3d ad ff <0f> ff 8b 53 64 e9 09 ff ff ff 65 48 8b 0c 25 00 d3 00 00 48 8b
kernel: ---[ end trace c4cae366180e70ec ]---
kernel: as10x_usb: error during firmware upload part1

Let's allocate the the structure dynamically so we can get the firmware
loaded correctly:
[   14.243057] as10x_usb: firmware: as102_data1_st.hex loaded with success
[   14.500777] as10x_usb: firmware: as102_data2_st.hex loaded with success

Signed-off-by: Michele Baldessari <michele@acksyn.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/media/as102/as102_fw.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/drivers/staging/media/as102/as102_fw.c
+++ b/drivers/staging/media/as102/as102_fw.c
@@ -106,20 +106,25 @@ static int as102_firmware_upload(struct
 				 unsigned char *cmd,
 				 const struct firmware *firmware) {
 
-	struct as10x_fw_pkt_t fw_pkt;
+	struct as10x_fw_pkt_t *fw_pkt;
 	int total_read_bytes = 0, errno = 0;
 	unsigned char addr_has_changed = 0;
 
 	ENTER();
 
+	fw_pkt = kmalloc(sizeof(*fw_pkt), GFP_KERNEL);
+	if (!fw_pkt)
+		return -ENOMEM;
+
+
 	for (total_read_bytes = 0; total_read_bytes < firmware->size; ) {
 		int read_bytes = 0, data_len = 0;
 
 		/* parse intel hex line */
 		read_bytes = parse_hex_line(
 				(u8 *) (firmware->data + total_read_bytes),
-				fw_pkt.raw.address,
-				fw_pkt.raw.data,
+				fw_pkt->raw.address,
+				fw_pkt->raw.data,
 				&data_len,
 				&addr_has_changed);
 
@@ -129,28 +134,28 @@ static int as102_firmware_upload(struct
 		/* detect the end of file */
 		total_read_bytes += read_bytes;
 		if (total_read_bytes == firmware->size) {
-			fw_pkt.u.request[0] = 0x00;
-			fw_pkt.u.request[1] = 0x03;
+			fw_pkt->u.request[0] = 0x00;
+			fw_pkt->u.request[1] = 0x03;
 
 			/* send EOF command */
 			errno = bus_adap->ops->upload_fw_pkt(bus_adap,
 							     (uint8_t *)
-							     &fw_pkt, 2, 0);
+							     fw_pkt, 2, 0);
 			if (errno < 0)
 				goto error;
 		} else {
 			if (!addr_has_changed) {
 				/* prepare command to send */
-				fw_pkt.u.request[0] = 0x00;
-				fw_pkt.u.request[1] = 0x01;
+				fw_pkt->u.request[0] = 0x00;
+				fw_pkt->u.request[1] = 0x01;
 
-				data_len += sizeof(fw_pkt.u.request);
-				data_len += sizeof(fw_pkt.raw.address);
+				data_len += sizeof(fw_pkt->u.request);
+				data_len += sizeof(fw_pkt->raw.address);
 
 				/* send cmd to device */
 				errno = bus_adap->ops->upload_fw_pkt(bus_adap,
 								     (uint8_t *)
-								     &fw_pkt,
+								     fw_pkt,
 								     data_len,
 								     0);
 				if (errno < 0)
@@ -159,6 +164,7 @@ static int as102_firmware_upload(struct
 		}
 	}
 error:
+	kfree(fw_pkt);
 	LEAVE();
 	return (errno == 0) ? total_read_bytes : errno;
 }
