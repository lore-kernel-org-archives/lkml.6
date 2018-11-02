Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7FC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD02E2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyD2/LjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD02E2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeKCCRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:17:51 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:38320 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:17:51 -0400
Received: by mail-qk1-f171.google.com with SMTP id d19so4171646qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpwNrMQwNf/+alMN2n1T20tWTmCL0wGWq/49himhSp0=;
        b=hyD2/LjZpYw/Gi5Tgka+IcRUeSky41gmiOXXL8eNcrwGS6rYtYXEobfqdILPk6ubaZ
         t1zlrAPOb4a2H0aCwuqZhTYnkzxs5Izi1Z3hMI0TFAWmny9VmU2Fb95RvYX/upAx9xfe
         CMYWPfF7vX5ckkde4Jv4rqh5P9h6DrhzJv8Dq9SbWWpcMtDUfQX8OBNwMXD7Uw48KJR7
         LHafgG44qVoFITKDWCudvNpW6fIFi2MrwvMqs5KWPAXaFWMS/SX/9TaktfuMlztylM48
         s4WWQLVoSvHQnHK8cwW7AfigGaeEqSYO/iYtvGBZ6GCywP5PnZl9ckaOWI4NMox8IuJj
         PD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpwNrMQwNf/+alMN2n1T20tWTmCL0wGWq/49himhSp0=;
        b=EeW1WY7xX8CtAhClsAbH7Uzmrgh4tOSWEDzh7qHdBlMjG+Wq9MjphKgskj56NQnlfn
         nbW9gQAWgXr9Op+WNVrhehpdanCtNxxxEF8fwQpNlDvGDJeafVmNtL6iqxgSYnk5CM7V
         OZAhDJGa3a66+/xPkuS9US8KEBBvQy9Wp+L/j90BKaALzIwQ210ahqHFO3yh+u3tfAoZ
         zQ1y+ZlTMg5GbIan+afbdRAakCbdX8K9IVX/et+UDUynuO6Fhmbp64GC48fXJLyr6fpZ
         Y4BgdhQH9qNV45qyJIr8JZHxiyX29YLgL06NyKmCbc0ZLb0TxJtNAwuDQrcyifxfDhZU
         lXzw==
X-Gm-Message-State: AGRZ1gIiTlxvi0ZgwSf1wyMfdEi0AwK5l0ByoQddsjq4zTSYyZpqc2mf
        yTuQu5VNOd17EuN9N75WaS7wihco
X-Google-Smtp-Source: AJdET5cTdFKe8HnfP7oa7bpBHTPOBRE9cdVV7BCK5J7AjnbRIe/1S72d+zy1shAiOaAp9sy461Fkow==
X-Received: by 2002:a37:6a01:: with SMTP id f1-v6mr11299026qkc.8.1541178598265;
        Fri, 02 Nov 2018 10:09:58 -0700 (PDT)
Received: from ubuntu.PreTalen.local (cpe-75-186-43-45.cinci.res.rr.com. [75.186.43.45])
        by smtp.gmail.com with ESMTPSA id h25-v6sm23638523qta.89.2018.11.02.10.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:09:57 -0700 (PDT)
From:   Paul Sorensen <paulsorensen5@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Sorensen <paulsorensen5@gmail.com>
Subject: [PATCH] Correct comparison statements in documentation
Date:   Fri,  2 Nov 2018 10:09:52 -0700
Message-Id: <20181102170952.46303-1-paulsorensen5@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instances of "less then" or "greater then" are corrected to "less than" or
"greater than", respectively.

Signed-off-by: Paul Sorensen <paulsorensen5@gmail.com>
---
 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt  | 6 +++---
 Documentation/hwmon/abituguru-datasheet                   | 2 +-
 Documentation/isdn/syncPPP.FAQ                            | 2 +-
 Documentation/scsi/ChangeLog.lpfc                         | 2 +-
 Documentation/usb/mass-storage.txt                        | 2 +-
 arch/sh/lib/memcpy-sh4.S                                  | 2 +-
 arch/x86/lib/copy_user_64.S                               | 4 ++--
 drivers/char/bsr.c                                        | 2 +-
 drivers/char/pcmcia/synclink_cs.c                         | 2 +-
 drivers/crypto/axis/artpec6_crypto.c                      | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c         | 2 +-
 drivers/input/rmi4/rmi_f11.c                              | 2 +-
 drivers/input/touchscreen/mxs-lradc-ts.c                  | 4 ++--
 drivers/misc/sgi-xp/xp_main.c                             | 2 +-
 drivers/mtd/devices/pmc551.c                              | 2 +-
 drivers/mtd/nand/raw/vf610_nfc.c                          | 2 +-
 drivers/mtd/ubi/debug.c                                   | 2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h         | 2 +-
 drivers/net/ethernet/ti/cpsw.c                            | 2 +-
 drivers/net/wireless/ath/wil6210/main.c                   | 2 +-
 drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c      | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c         | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00link.c           | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00queue.c          | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c       | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c       | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c       | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c       | 2 +-
 drivers/of/base.c                                         | 2 +-
 drivers/platform/x86/dell_rbu.c                           | 2 +-
 drivers/s390/char/vmlogrdr.c                              | 2 +-
 drivers/scsi/isci/init.c                                  | 2 +-
 drivers/scsi/lpfc/lpfc_init.c                             | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c               | 2 +-
 drivers/spi/spi-qup.c                                     | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c         | 2 +-
 drivers/tty/synclink.c                                    | 2 +-
 drivers/tty/synclinkmp.c                                  | 2 +-
 drivers/video/fbdev/omap/sossi.c                          | 4 ++--
 fs/btrfs/ioctl.c                                          | 2 +-
 fs/exofs/ore.c                                            | 2 +-
 fs/jffs2/jffs2_fs_sb.h                                    | 2 +-
 fs/jffs2/nodemgmt.c                                       | 2 +-
 fs/reiserfs/journal.c                                     | 2 +-
 include/linux/mlx4/device.h                               | 2 +-
 include/linux/power/max17042_battery.h                    | 2 +-
 include/linux/usb/gadget.h                                | 4 ++--
 include/sound/vx_core.h                                   | 2 +-
 kernel/bpf/verifier.c                                     | 2 +-
 kernel/sched/fair.c                                       | 2 +-
 kernel/sched/topology.c                                   | 2 +-
 mm/compaction.c                                           | 2 +-
 mm/slab_common.c                                          | 2 +-
 net/decnet/dn_neigh.c                                     | 2 +-
 net/sctp/input.c                                          | 4 ++--
 net/sctp/sm_statefuns.c                                   | 2 +-
 net/sctp/ulpqueue.c                                       | 2 +-
 sound/pci/hda/patch_hdmi.c                                | 2 +-
 59 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index 0ec68141f85a..8266e798d3c3 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -69,7 +69,7 @@ Following properties relate to DDR timing:
 
 - rockchip,ddr3_odt_dis_freq :	  When the DRAM type is DDR3, this parameter defines
 				  the ODT disable frequency in MHz (Mega Hz).
-				  when the DDR frequency is  less then ddr3_odt_dis_freq,
+				  when the DDR frequency is  less than ddr3_odt_dis_freq,
 				  the ODT on the DRAM side and controller side are
 				  both disabled.
 
@@ -96,7 +96,7 @@ Following properties relate to DDR timing:
 
 - rockchip,lpddr3_odt_dis_freq : When the DRAM type is LPDDR3, this parameter defines
 				  then ODT disable frequency in MHz (Mega Hz).
-				  When DDR frequency is less then ddr3_odt_dis_freq,
+				  When DDR frequency is less than ddr3_odt_dis_freq,
 				  the ODT on the DRAM side and controller side are
 				  both disabled.
 
@@ -124,7 +124,7 @@ Following properties relate to DDR timing:
 
 - rockchip,lpddr4_odt_dis_freq : When the DRAM type is LPDDR4, this parameter
 				  defines the ODT disable frequency in
-				  MHz (Mega Hz). When the DDR frequency is less then
+				  MHz (Mega Hz). When the DDR frequency is less than
 				  ddr3_odt_dis_freq, the ODT on the DRAM side and
 				  controller side are both disabled.
 
diff --git a/Documentation/hwmon/abituguru-datasheet b/Documentation/hwmon/abituguru-datasheet
index 86c0b1251c81..4158aecc90e9 100644
--- a/Documentation/hwmon/abituguru-datasheet
+++ b/Documentation/hwmon/abituguru-datasheet
@@ -61,7 +61,7 @@ in a bank for a sensor is one or more bytes large.
 
 The number of bytes is fixed for a given bank, you should always read or write
 that many bytes, reading / writing more will fail, the results when writing
-less then the number of bytes for a given bank are undetermined.
+less than the number of bytes for a given bank are undetermined.
 
 See below for all known bank addresses, numbers of sensors in that bank,
 number of bytes data per sensor and contents/meaning of those bytes.
diff --git a/Documentation/isdn/syncPPP.FAQ b/Documentation/isdn/syncPPP.FAQ
index 3257a4bc0786..f8b39c2ac5e7 100644
--- a/Documentation/isdn/syncPPP.FAQ
+++ b/Documentation/isdn/syncPPP.FAQ
@@ -194,7 +194,7 @@ Q11: I can't connect. How can I check where the problem is.
 
 A: A good help log is the debug output from the ipppd...
    Check whether you can find there:
-   - only a few LCP-conf-req SENT messages (less then 10)
+   - only a few LCP-conf-req SENT messages (less than 10)
      and then a Term-REQ:
      -> check whether your ISDN card is well configured
         it seems, that your machine doesn't dial
diff --git a/Documentation/scsi/ChangeLog.lpfc b/Documentation/scsi/ChangeLog.lpfc
index 2f6d595f95e1..de97925b547d 100644
--- a/Documentation/scsi/ChangeLog.lpfc
+++ b/Documentation/scsi/ChangeLog.lpfc
@@ -808,7 +808,7 @@ Changes from 20040908 to 20040920
 	  void - move lpfc_do_dpc and lpfc_disc_done to lpfc_hbadisc.c -
 	  remove checking of list emptiness before calling lpfc_disc_done,
 	  it handles the empty list case just fine and the additional
-	  instructions cost less then the bustlocked spinlock operations.
+	  instructions cost less than the bustlocked spinlock operations.
 	* Integrated patch from Christoph Hellwig: This adds a new 64bit
 	  counter instead, brd_no isn't reused anymore.  Also some tiny
 	  whitespace cleanups in surrounding code.
diff --git a/Documentation/usb/mass-storage.txt b/Documentation/usb/mass-storage.txt
index e89803a5a960..b2a6879b3880 100644
--- a/Documentation/usb/mass-storage.txt
+++ b/Documentation/usb/mass-storage.txt
@@ -121,7 +121,7 @@
     capped.
 
     If this parameter is provided, and the number of files specified
-    in “file” argument is greater then the value of “luns”, all excess
+    in “file” argument is greater than the value of “luns”, all excess
     files will be ignored.
 
     If this parameter is not present, the number of logical units will
diff --git a/arch/sh/lib/memcpy-sh4.S b/arch/sh/lib/memcpy-sh4.S
index a2435c0f6302..3e5cd4385a4a 100644
--- a/arch/sh/lib/memcpy-sh4.S
+++ b/arch/sh/lib/memcpy-sh4.S
@@ -570,7 +570,7 @@ ENTRY(memcpy)
 
 	.balign	32
 .Lcase2:
-	! Size is 16 or greater and less then 64, but may have trailing bytes
+	! Size is 16 or greater and less than 64, but may have trailing bytes
 
 2:	mov	r5, r6		!   5 MT (latency=0)
 	add	#-2,r5		!  50 EX
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index db4e5aa0858b..2d9457931bf7 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -32,7 +32,7 @@
 ENTRY(copy_user_generic_unrolled)
 	ASM_STAC
 	cmpl $8,%edx
-	jb 20f		/* less then 8 bytes, go to byte copy loop */
+	jb 20f		/* less than 8 bytes, go to byte copy loop */
 	ALIGN_DESTINATION
 	movl %edx,%ecx
 	andl $63,%edx
@@ -176,7 +176,7 @@ EXPORT_SYMBOL(copy_user_generic_string)
 ENTRY(copy_user_enhanced_fast_string)
 	ASM_STAC
 	cmpl $64,%edx
-	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
+	jb .L_copy_short_string	/* less than 64 bytes, avoid the costly 'rep' */
 	movl %edx,%ecx
 1:	rep
 	movsb
diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index a6cef548e01e..053b59c5c471 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -222,7 +222,7 @@ static int bsr_add_node(struct device_node *bn)
 		cur->bsr_stride = bsr_stride[i];
 		cur->bsr_dev    = MKDEV(bsr_major, i + total_bsr_devs);
 
-		/* if we have a bsr_len of > 4k and less then PAGE_SIZE (64k pages) */
+		/* if we have a bsr_len of > 4k and less than PAGE_SIZE (64k pages) */
 		/* we can only map 4k of it, so only advertise the 4k in sysfs */
 		if (cur->bsr_len > 4096 && cur->bsr_len < PAGE_SIZE)
 			cur->bsr_len = 4096;
diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 82f9a6a814ae..2bc7275318a4 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1452,7 +1452,7 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 	bits_per_char = info->params.data_bits +
 			info->params.stop_bits + 1;
 
-	/* if port data rate is set to 460800 or less then
+	/* if port data rate is set to 460800 or less than
 	 * allow tty settings to override, otherwise keep the
 	 * current data rate.
 	 */
diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index f3442c2bdbdc..5524f8bdfc37 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -697,7 +697,7 @@ artpec6_crypto_dma_unmap_all(struct artpec6_crypto_req_common *common)
  * @dst: The virtual address of the data
  * @len: The length of the data
  * @eop: True if this is the last buffer in the packet
- * @use_short: If this is true and the data length is 7 bytes or less then
+ * @use_short: If this is true and the data length is 7 bytes or less than
  *	a short descriptor will be used
  *
  * @return 0 on success
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b6fe29b9fb65..f85fb361671a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2037,7 +2037,7 @@ enum dc_status resource_map_pool_resources(
 		/*
 		 * Audio assigned in order first come first get.
 		 * There are asics which has number of audio
-		 * resources less then number of pipes
+		 * resources less than number of pipes
 		 */
 		if (pipe_ctx->stream_res.audio)
 			update_audio_usage(&context->res_ctx, pool,
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index df64d6aed4f7..063b32a996d7 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1278,7 +1278,7 @@ static irqreturn_t rmi_f11_attention(int irq, void *ctx)
 
 	if (drvdata->attn_data.data) {
 		/*
-		 * The valid data in the attention report is less then
+		 * The valid data in the attention report is less than
 		 * expected. Only process the complete fingers.
 		 */
 		if (f11->sensor.attn_size > drvdata->attn_data.size)
diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index c850b517854e..6bd7c1ec2b1f 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -119,7 +119,7 @@ static void mxs_lradc_setup_ts_channel(struct mxs_lradc_ts *ts, unsigned int ch)
 	 *
 	 * from the datasheet:
 	 * "The ACCUMULATE bit in the appropriate channel register
-	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater then 0;
+	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater than 0;
 	 * otherwise, the IRQs will not fire."
 	 */
 	writel(LRADC_CH_ACCUMULATE |
@@ -176,7 +176,7 @@ static void mxs_lradc_setup_ts_pressure(struct mxs_lradc_ts *ts,
 	 *
 	 * from the datasheet:
 	 * "The ACCUMULATE bit in the appropriate channel register
-	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater then 0;
+	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater than 0;
 	 * otherwise, the IRQs will not fire."
 	 */
 	reg = LRADC_CH_ACCUMULATE |
diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 6d7f557fd1c1..eaf4f0912ed4 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -122,7 +122,7 @@ EXPORT_SYMBOL_GPL(xpc_clear_interface);
  *		       this large enough to hold their largest message.
  *	nentries - max #of XPC message entries a message queue can contain.
  *		   The actual number, which is determined when a connection
- * 		   is established and may be less then requested, will be
+ * 		   is established and may be less than requested, will be
  *		   passed to the user via the xpConnected callout.
  *	assigned_limit - max number of kthreads allowed to be processing
  * 			 messages (per connection) at any given instant.
diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index 5d842cbca3de..d59d5f4e89dc 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -40,7 +40,7 @@
  *	reloaded.  Soooo, to help, the module supports an msize
  *	option to allow the specification of the onboard memory, and
  *	an asize option, to allow the specification of the aperture
- *	size.  The aperture must be equal to or less then the memory
+ *	size.  The aperture must be equal to or less than the memory
  *	size, the driver will correct this if you screw it up.  This
  *	problem is not relevant for compiled in drivers as compiled
  *	in drivers only init once.
diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index 9814fd4a84cf..58190c2f38c3 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -538,7 +538,7 @@ static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat,
 
 	/*
 	 * On an erased page, bit count (including OOB) should be zero or
-	 * at least less then half of the ECC strength.
+	 * at least less than half of the ECC strength.
 	 */
 	return nand_check_erased_ecc_chunk(dat, nfc->chip.ecc.size, oob,
 					   mtd->oobsize, NULL, 0,
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 7bc96294ae4d..116f9f68c5ae 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -398,7 +398,7 @@ static const struct file_operations dfs_fops = {
 	.owner  = THIS_MODULE,
 };
 
-/* As long as the position is less then that total number of erase blocks,
+/* As long as the position is less than that total number of erase blocks,
  * we still have more to print.
  */
 static void *eraseblk_count_seq_start(struct seq_file *s, loff_t *pos)
diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
index c61f260e18a4..9ee6a6a24965 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
@@ -42,7 +42,7 @@ struct sxgbe_mtl_ops;
 #define SXGBE_RX_QUEUES   16
 
 /* Calculated based how much time does it take to fill 256KB Rx memory
- * at 10Gb speed at 156MHz clock rate and considered little less then
+ * at 10Gb speed at 156MHz clock rate and considered little less than
  * the actual value.
  */
 #define SXGBE_MAX_DMA_RIWT	0x70
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 500f7ed8c58c..85b9078d7886 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -883,7 +883,7 @@ static void cpsw_split_res(struct net_device *ndev)
 	} else {
 		max_rate = cpsw->speed * 1000;
 
-		/* if max_rate is less then expected due to reduced link speed,
+		/* if max_rate is less than expected due to reduced link speed,
 		 * split proportionally according next potential max speed
 		 */
 		if (max_rate < consumed_rate)
diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 398900a1c29e..7532d6a57e54 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -461,7 +461,7 @@ static void wil_fw_error_worker(struct work_struct *work)
 	}
 	wdev = ndev->ieee80211_ptr;
 
-	/* increment @recovery_count if less then WIL6210_FW_RECOVERY_TO
+	/* increment @recovery_count if less than WIL6210_FW_RECOVERY_TO
 	 * passed since last recovery attempt
 	 */
 	if (time_is_after_jiffies(wil->last_fw_recovery +
diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 8e63d14c1e1c..4471e255948c 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -591,7 +591,7 @@ int mwifiex_11n_rx_reorder_pkt(struct mwifiex_private *priv,
 		end_win = ((start_win + win_size) - 1) & (MAX_TID_VALUE - 1);
 	} else {
 		/*
-		 * If seq_num is less then starting win then ignore and drop
+		 * If seq_num is less than starting win then ignore and drop
 		 * the packet
 		 */
 		if ((start_win + TWOPOW11) > (MAX_TID_VALUE - 1)) {
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c b/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
index a2fd05ba25ca..074c19e7a8f8 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00crypto.c
@@ -190,7 +190,7 @@ void rt2x00crypto_rx_insert_iv(struct sk_buff *skb,
 	 * Make room for new data. There are 2 possibilities
 	 * either the alignment is already present between
 	 * the 802.11 header and payload. In that case we
-	 * we have to move the header less then the iv_len
+	 * we have to move the header less than the iv_len
 	 * since we can use the already available l2pad bytes
 	 * for the iv data.
 	 * When the alignment must be added manually we must
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
index 2010a7715f21..6929ff970823 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00link.c
@@ -28,7 +28,7 @@
 #include "rt2x00lib.h"
 
 /*
- * When we lack RSSI information return something less then -80 to
+ * When we lack RSSI information return something less than -80 to
  * tell the driver to tune the device to maximum sensitivity.
  */
 #define DEFAULT_RSSI		-128
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
index 92ddc19e7bf7..a205df606c70 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00queue.c
@@ -557,7 +557,7 @@ static void rt2x00queue_kick_tx_queue(struct data_queue *queue,
 	 *	   by another frame which in some way are related to eachother.
 	 *	   This is true for fragments, RTS or CTS-to-self frames.
 	 *	2) Rule 1 can be broken when the available entries
-	 *	   in the queue are less then a certain threshold.
+	 *	   in the queue are less than a certain threshold.
 	 */
 	if (rt2x00queue_threshold(queue) ||
 	    !test_bit(ENTRY_TXD_BURST, &txdesc->flags))
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
index 63874512598b..9846ff2d8185 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
@@ -70,7 +70,7 @@ static void _rtl88e_write_fw(struct ieee80211_hw *hw,
 	remainsize = size % FW_8192C_PAGE_SIZE;
 
 	if (pagenums > 8)
-		pr_err("Page numbers should not greater then 8\n");
+		pr_err("Page numbers should not greater than 8\n");
 
 	for (page = 0; page < pagenums; page++) {
 		offset = page * FW_8192C_PAGE_SIZE;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
index f3bff66e85d0..1ba7ddb01589 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
@@ -89,7 +89,7 @@ static void _rtl92c_write_fw(struct ieee80211_hw *hw,
 		remainsize = size % FW_8192C_PAGE_SIZE;
 
 		if (pageNums > 4)
-			pr_err("Page numbers should not greater then 4\n");
+			pr_err("Page numbers should not greater than 4\n");
 
 		for (page = 0; page < pageNums; page++) {
 			offset = page * FW_8192C_PAGE_SIZE;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
index 85cedd083d2b..4c495f7777c1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
@@ -75,7 +75,7 @@ static void _rtl92d_write_fw(struct ieee80211_hw *hw,
 	pagenums = size / FW_8192D_PAGE_SIZE;
 	remainsize = size % FW_8192D_PAGE_SIZE;
 	if (pagenums > 8)
-		pr_err("Page numbers should not greater then 8\n");
+		pr_err("Page numbers should not greater than 8\n");
 	for (page = 0; page < pagenums; page++) {
 		offset = page * FW_8192D_PAGE_SIZE;
 		rtl_fw_page_write(hw, page, (bufferptr + offset),
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c
index 84a0d0eb72e1..68ad736e3300 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c
@@ -66,7 +66,7 @@ static void _rtl92ee_write_fw(struct ieee80211_hw *hw,
 	remainsize = size % FW_8192C_PAGE_SIZE;
 
 	if (pagenums > 8)
-		pr_err("Page numbers should not greater then 8\n");
+		pr_err("Page numbers should not greater than 8\n");
 
 	for (page = 0; page < pagenums; page++) {
 		offset = page * FW_8192C_PAGE_SIZE;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c
index d868a034659f..be75dea164c9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c
@@ -69,7 +69,7 @@ static void _rtl8821ae_write_fw(struct ieee80211_hw *hw,
 	remainsize = size % FW_8821AE_PAGE_SIZE;
 
 	if (pagenums > 8)
-		pr_err("Page numbers should not greater then 8\n");
+		pr_err("Page numbers should not greater than 8\n");
 
 	for (page = 0; page < pagenums; page++) {
 		offset = page * FW_8821AE_PAGE_SIZE;
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..51b07a90eb46 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1995,7 +1995,7 @@ EXPORT_SYMBOL_GPL(of_alias_get_id);
  * device match structures and alias stem.
  *
  * Return:	0 or -ENOSYS when !CONFIG_OF or
- *		-EOVERFLOW if alias ID is greater then allocated nbits
+ *		-EOVERFLOW if alias ID is greater than allocated nbits
  */
 int of_alias_get_alias_list(const struct of_device_id *matches,
 			     const char *stem, unsigned long *bitmap,
diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
index ccefa84f7305..495df117fafd 100644
--- a/drivers/platform/x86/dell_rbu.c
+++ b/drivers/platform/x86/dell_rbu.c
@@ -403,7 +403,7 @@ static void img_update_free(void)
  * values are stored globally and on every call to this function the new
  * size is checked to see if more data is required than the existing size.
  * If true the previous memory is freed and new allocation is done to
- * accommodate the new size. If the incoming size is less then than the
+ * accommodate the new size. If the incoming size is less than than the
  * already allocated size, then that memory is reused. This function is
  * called with lock held and returns with lock held.
  */
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 58333cb4503f..0566fd08ddf4 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -44,7 +44,7 @@ MODULE_LICENSE("GPL");
  * The size of the buffer for iucv data transfer is one page,
  * but in addition to the data we read from iucv we also
  * place an integer and some characters into that buffer,
- * so the maximum size for record data is a little less then
+ * so the maximum size for record data is a little less than
  * one page.
  */
 #define NET_BUFFER_SIZE	(PAGE_SIZE - sizeof(int) - sizeof(FENCE))
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 08c7b1e25fe4..1c91f6235df1 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -486,7 +486,7 @@ static void sci_oem_defaults(struct isci_host *ihost)
 
 		/* Previous Vitesse based expanders had a arbitration issue that
 		 * is worked around by having the upper 32-bits of SAS address
-		 * with a value greater then the Vitesse company identifier.
+		 * with a value greater than the Vitesse company identifier.
 		 * Hence, usage of 0x5FCFFFFF.
 		 */
 		oem->phys[i].sas_address.low = 0x1 + ihost->id;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 20fa6785a0e2..ecc3f7930e59 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -218,7 +218,7 @@ lpfc_config_port_prep(struct lpfc_hba *phba)
 	vp->rev.postKernRev = mb->un.varRdRev.postKernRev;
 	vp->rev.opFwRev = mb->un.varRdRev.opFwRev;
 
-	/* If the sli feature level is less then 9, we must
+	/* If the sli feature level is less than 9, we must
 	 * tear down all RPIs and VPIs on link down if NPIV
 	 * is enabled.
 	 */
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index f74b5ea24f0f..a809e3c65f07 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1857,7 +1857,7 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 
 	/*
 	 * NVMe uses one PRP for each page (or part of a page)
-	 * look at the data length - if 4 pages or less then IEEE is OK
+	 * look at the data length - if 4 pages or less than IEEE is OK
 	 * if  > 5 pages then we need to build a native SGL
 	 * if > 4 and <= 5 pages, then check physical address of 1st SG entry
 	 * if this first size in the page is >= the residual beyond 4 pages
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..4d25a7d3eacc 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -123,7 +123,7 @@
 
 #define SPI_MAX_XFER			(SZ_64K - 64)
 
-/* high speed mode is when bus rate is greater then 26MHz */
+/* high speed mode is when bus rate is greater than 26MHz */
 #define SPI_HS_MIN_RATE			26000000
 #define SPI_MAX_RATE			50000000
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c7e55618b9a8..a37e0502be6d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -158,7 +158,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 	u8 *bufferPtr = buffer;
 
 	pageNums = size / MAX_DLFW_PAGE_SIZE;
-	/* RT_ASSERT((pageNums <= 4), ("Page numbers should not greater then 4\n")); */
+	/* RT_ASSERT((pageNums <= 4), ("Page numbers should not greater than 4\n")); */
 	remainSize = size % MAX_DLFW_PAGE_SIZE;
 
 	for (page = 0; page < pageNums; page++) {
diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index d55c858d6058..0b08e599a316 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -1949,7 +1949,7 @@ static void mgsl_change_params(struct mgsl_struct *info)
 	bits_per_char = info->params.data_bits + 
 			info->params.stop_bits + 1;
 
-	/* if port data rate is set to 460800 or less then
+	/* if port data rate is set to 460800 or less than
 	 * allow tty settings to override, otherwise keep the
 	 * current data rate.
 	 */
diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
index fcb91bf7a15b..dc64e160c1db 100644
--- a/drivers/tty/synclinkmp.c
+++ b/drivers/tty/synclinkmp.c
@@ -2784,7 +2784,7 @@ static void change_params(SLMP_INFO *info)
 	bits_per_char = info->params.data_bits +
 			info->params.stop_bits + 1;
 
-	/* if port data rate is set to 460800 or less then
+	/* if port data rate is set to 460800 or less than
 	 * allow tty settings to override, otherwise keep the
 	 * current data rate.
 	 */
diff --git a/drivers/video/fbdev/omap/sossi.c b/drivers/video/fbdev/omap/sossi.c
index d4e7684e7045..0dcde793ee86 100644
--- a/drivers/video/fbdev/omap/sossi.c
+++ b/drivers/video/fbdev/omap/sossi.c
@@ -157,7 +157,7 @@ static int calc_rd_timings(struct extif_timings *t)
 		recyc = reoff + 1;
 
 	tw1 = recyc - tw0;
-	/* values less then 3 result in the SOSSI block resetting itself */
+	/* values less than 3 result in the SOSSI block resetting itself */
 	if (tw1 < 3)
 		tw1 = 3;
 	if (tw1 > 0x40)
@@ -206,7 +206,7 @@ static int calc_wr_timings(struct extif_timings *t)
 		wecyc = weoff + 1;
 
 	tw1 = wecyc - tw0;
-	/* values less then 3 result in the SOSSI block resetting itself */
+	/* values less than 3 result in the SOSSI block resetting itself */
 	if (tw1 < 3)
 		tw1 = 3;
 	if (tw1 > 0x40)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a990a9045139..f436d7f16b3e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3759,7 +3759,7 @@ static void clone_update_extent_map(struct btrfs_inode *inode,
  * with NO_HOLES enabled). If we find our destination inode only has one inline
  * extent, just overwrite it with the source inline extent if its size is less
  * than the source extent's size, or we could copy the source inline extent's
- * data into the destination inode's inline extent if the later is greater then
+ * data into the destination inode's inline extent if the later is greater than
  * the former.
  */
 static int clone_copy_inline_extent(struct inode *dst,
diff --git a/fs/exofs/ore.c b/fs/exofs/ore.c
index 5331a15a61f1..79a9a17ca265 100644
--- a/fs/exofs/ore.c
+++ b/fs/exofs/ore.c
@@ -241,7 +241,7 @@ int  _ore_get_io_state(struct ore_layout *layout,
  *
  * If a user needs to call ore_read/write() this version must be used becase it
  * allocates extra stuff for striping and raid.
- * The ore might decide to only IO less then @length bytes do to alignmets
+ * The ore might decide to only IO less than @length bytes do to alignmets
  * and constrains as follows:
  * - The IO cannot cross group boundary.
  * - In raid5/6 The end of the IO must align at end of a stripe eg.
diff --git a/fs/jffs2/jffs2_fs_sb.h b/fs/jffs2/jffs2_fs_sb.h
index 778275f48a87..3190f729fbb1 100644
--- a/fs/jffs2/jffs2_fs_sb.h
+++ b/fs/jffs2/jffs2_fs_sb.h
@@ -37,7 +37,7 @@ struct jffs2_mount_opts {
 	 * space which may only be used by root cannot be used by the other
 	 * users. This is implemented simply by means of not allowing the
 	 * latter users to write to the file system if the amount if the
-	 * available space is less then 'rp_size'. */
+	 * available space is less than 'rp_size'. */
 	unsigned int rp_size;
 };
 
diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
index a7bbe879cfc3..cc8c123ee7b2 100644
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -87,7 +87,7 @@ int jffs2_reserve_space(struct jffs2_sb_info *c, uint32_t minsize,
 	spin_lock(&c->erase_completion_lock);
 
 	/*
-	 * Check if the free space is greater then size of the reserved pool.
+	 * Check if the free space is greater than size of the reserved pool.
 	 * If not, only allow root to proceed with writing.
 	 */
 	if (prio != ALLOC_DELETION && !jffs2_rp_can_write(c)) {
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 8a76f9d14bc6..630cb25fce3a 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2665,7 +2665,7 @@ static int journal_init_dev(struct super_block *super,
  * blocksize/standard_blocksize.
  *
  * For blocks >= standard_blocksize transaction size should
- * be not less then JOURNAL_TRANS_MIN_DEFAULT, and not more
+ * be not less than JOURNAL_TRANS_MIN_DEFAULT, and not more
  * then JOURNAL_TRANS_MAX_DEFAULT.
  *
  * For blocks < standard_blocksize these boundaries should be
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index dca6ab4eaa99..938091d0a12b 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -54,7 +54,7 @@
 
 #define MLX4_MAX_100M_UNITS_VAL		255	/*
 						 * work around: can't set values
-						 * greater then this value when
+						 * greater than this value when
 						 * using 100 Mbps units.
 						 */
 #define MLX4_RATELIMIT_100M_UNITS	3	/* 100 Mbps */
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index a7ed29baf44a..0cd2e8f00a36 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -31,7 +31,7 @@
 #define MAX17042_DEFAULT_TEMP_MIN	(0)    /* For sys without temp sensor */
 #define MAX17042_DEFAULT_TEMP_MAX	(700)  /* 70 degrees Celcius */
 
-/* Consider RepCap which is less then 10 units below FullCAP full */
+/* Consider RepCap which is less than 10 units below FullCAP full */
 #define MAX17042_FULL_THRESHOLD		10
 
 #define MAX17042_CHARACTERIZATION_DATA_SIZE 48
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e5cd84a0f84a..cba64de572d5 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -284,9 +284,9 @@ static inline void usb_ep_fifo_flush(struct usb_ep *ep)
 
 struct usb_dcd_config_params {
 	__u8  bU1devExitLat;	/* U1 Device exit Latency */
-#define USB_DEFAULT_U1_DEV_EXIT_LAT	0x01	/* Less then 1 microsec */
+#define USB_DEFAULT_U1_DEV_EXIT_LAT	0x01	/* Less than 1 microsec */
 	__le16 bU2DevExitLat;	/* U2 Device exit Latency */
-#define USB_DEFAULT_U2_DEV_EXIT_LAT	0x1F4	/* Less then 500 microsec */
+#define USB_DEFAULT_U2_DEV_EXIT_LAT	0x1F4	/* Less than 500 microsec */
 };
 
 
diff --git a/include/sound/vx_core.h b/include/sound/vx_core.h
index cae9c9d4ef22..246a4055a1ee 100644
--- a/include/sound/vx_core.h
+++ b/include/sound/vx_core.h
@@ -510,7 +510,7 @@ enum {
 #define HEADER_FMT_16BITS		0x00002000
 #define HEADER_FMT_24BITS		0x00004000
 #define HEADER_FMT_UPTO11		0x00000200	/* frequency is less or equ. to 11k.*/
-#define HEADER_FMT_UPTO32		0x00000100	/* frequency is over 11k and less then 32k.*/
+#define HEADER_FMT_UPTO32		0x00000100	/* frequency is over 11k and less than 32k.*/
 
 /* Constants used to access the Codec */
 #define XX_CODEC_SELECTOR               0x20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1971ca325fb4..f81f3754468f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -49,7 +49,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
  * The second pass is all possible path descent from the 1st insn.
  * Since it's analyzing all pathes through the program, the length of the
  * analysis is limited to 64k insn, which may be hit even if total number of
- * insn is less then 4K, but there are too many branches that change stack/regs.
+ * insn is less than 4K, but there are too many branches that change stack/regs.
  * Number of 'branches to be analyzed' is limited to 1k
  *
  * On entry to each instruction, each register has a type, and the instruction
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb661cc..95354a8a92d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5531,7 +5531,7 @@ static unsigned long cpu_avg_load_per_task(int cpu)
 static void record_wakee(struct task_struct *p)
 {
 	/*
-	 * Only decay a single time; tasks that have less then 1 wakeup per
+	 * Only decay a single time; tasks that have less than 1 wakeup per
 	 * jiffy will not have built up many flips.
 	 */
 	if (time_after(jiffies, current->wakee_flip_decay_ts + HZ)) {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9d74371e4aad..b267962c3c73 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1398,7 +1398,7 @@ void sched_init_numa(void)
 	/*
 	 * Here, we should temporarily reset sched_domains_numa_levels to 0.
 	 * If it fails to allocate memory for array sched_domains_numa_masks[][],
-	 * the array will contain less then 'level' members. This could be
+	 * the array will contain less than 'level' members. This could be
 	 * dangerous when we use it to iterate array sched_domains_numa_masks[][]
 	 * in other functions.
 	 *
diff --git a/mm/compaction.c b/mm/compaction.c
index 7c607479de4a..762214c52b24 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -586,7 +586,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
  * undo its actions and return zero.
  *
  * Otherwise, function returns one-past-the-last PFN of isolated page
- * (which may be greater then end_pfn if end fell in a middle of
+ * (which may be greater than end_pfn if end fell in a middle of
  * a free page).
  */
 unsigned long
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7eb8dc136c1c..5e5aaee89e10 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -270,7 +270,7 @@ static unsigned int calculate_alignment(slab_flags_t flags,
 	 * suggestion if the object is sufficiently large.
 	 *
 	 * The hardware cache alignment cannot override the specified
-	 * alignment though. If that is greater then use it.
+	 * alignment though. If that is greater than use it.
 	 */
 	if (flags & SLAB_HWCACHE_ALIGN) {
 		unsigned int ralign;
diff --git a/net/decnet/dn_neigh.c b/net/decnet/dn_neigh.c
index 94b306f6d551..145c119e2cf4 100644
--- a/net/decnet/dn_neigh.c
+++ b/net/decnet/dn_neigh.c
@@ -148,7 +148,7 @@ static int dn_neigh_construct(struct neighbour *neigh)
 
 	/*
 	 * Make an estimate of the remote block size by assuming that its
-	 * two less then the device mtu, which it true for ethernet (and
+	 * two less than the device mtu, which it true for ethernet (and
 	 * other things which support long format headers) since there is
 	 * an extra length field (of 16 bits) which isn't part of the
 	 * ethernet headers and which the DECnet specs won't admit is part
diff --git a/net/sctp/input.c b/net/sctp/input.c
index 5c36a99882ed..9030fd800390 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -680,7 +680,7 @@ static int sctp_rcv_ootb(struct sk_buff *skb)
 
 		ch = skb_header_pointer(skb, offset, sizeof(*ch), &_ch);
 
-		/* Break out if chunk length is less then minimal. */
+		/* Break out if chunk length is less than minimal. */
 		if (ntohs(ch->length) < sizeof(_ch))
 			break;
 
@@ -1156,7 +1156,7 @@ static struct sctp_association *__sctp_rcv_walk_lookup(struct net *net,
 	 */
 	ch = (struct sctp_chunkhdr *)skb->data;
 	do {
-		/* Break out if chunk length is less then minimal. */
+		/* Break out if chunk length is less than minimal. */
 		if (ntohs(ch->length) < sizeof(*ch))
 			break;
 
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index c9ae3404b1bb..d38136712372 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -3549,7 +3549,7 @@ enum sctp_disposition sctp_sf_ootb(struct net *net,
 
 	ch = (struct sctp_chunkhdr *)chunk->chunk_hdr;
 	do {
-		/* Report violation if the chunk is less then minimal */
+		/* Report violation if the chunk is less than minimal */
 		if (ntohs(ch->length) < sizeof(*ch))
 			return sctp_sf_violation_chunklen(net, ep, asoc, type, arg,
 						  commands);
diff --git a/net/sctp/ulpqueue.c b/net/sctp/ulpqueue.c
index 331cc734e3db..abfbe4662cb5 100644
--- a/net/sctp/ulpqueue.c
+++ b/net/sctp/ulpqueue.c
@@ -719,7 +719,7 @@ void sctp_ulpq_reasm_flushtsn(struct sctp_ulpq *ulpq, __u32 fwd_tsn)
 
 		/* Since the entire message must be abandoned by the
 		 * sender (item A3 in Section 3.5, RFC 3758), we can
-		 * free all fragments on the list that are less then
+		 * free all fragments on the list that are less than
 		 * or equal to ctsn_point
 		 */
 		if (TSN_lte(tsn, fwd_tsn)) {
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 67099cbb6be2..db54f9e91845 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -946,7 +946,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 }
 
 /* Try to find an available converter
- * If pin_idx is less then zero, just try to find an available converter.
+ * If pin_idx is less than zero, just try to find an available converter.
  * Otherwise, try to find an available converter and get the cvt mux index
  * of the pin.
  */
-- 
2.17.1

