Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D7C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4D52083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gn2sJh8O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="knUcDVk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4D52083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeJPQte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:49:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJPQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:49:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A6DC612EE; Tue, 16 Oct 2018 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539680408;
        bh=NIOJpwgDUUXMO6O0whbnVn/BN9AOFAXAOKffahxjlqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gn2sJh8OvLdMgC8ESomNy1Owu7VUqVX0jp54GruU7YKCALiD+Ya0xlKBJLWlPjDFX
         U5X5k670u6mgD+31MlcE4vjLeE8ks+cyEvHxYQqtXH46v9zGprnpFB6awelky7chci
         DBYGnX9UYJ2M5ZwWC0LDe5Cx7BpemvXs30yQnG4Y=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 162A560F39;
        Tue, 16 Oct 2018 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539680406;
        bh=NIOJpwgDUUXMO6O0whbnVn/BN9AOFAXAOKffahxjlqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knUcDVk/kR7WBXyaq6TYDLkZWQeqdl6gx/rHgNXwPEpf6ldLBw5I9rv9nce5jxcAW
         588Ij48dI7PQlvlfvTThxjWxVDHXOLOyh951gyXUPmO4ZAz0gLiO3Zy88dqMAf1iJN
         d1Epy+Li5tuN4wFZjGcEO/xih8t+tasOMxQlqR5I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 162A560F39
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org
Cc:     stummala@codeaurora.org, adrian.hunter@intel.com,
        jlbec@evilplan.org, linux-scsi@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V15 1/2] scsi: ufs: set the device reference clock setting
Date:   Tue, 16 Oct 2018 14:29:41 +0530
Message-Id: <1539680382-31136-2-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539680382-31136-1-git-send-email-sayalil@codeaurora.org>
References: <1539680382-31136-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

UFS host supplies the reference clock to UFS device and UFS device
specification allows host to provide one of the 4 frequencies (19.2 MHz,
26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
device reference clock frequency setting in the device based on what
frequency it is supplying to UFS device.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  6 ++
 drivers/scsi/ufs/ufs.h                             | 14 ++++
 drivers/scsi/ufs/ufshcd.c                          | 83 ++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h                          |  2 +
 4 files changed, 105 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index c39dfef..88a1d24 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -33,6 +33,12 @@ Optional properties:
 - clocks                : List of phandle and clock specifier pairs
 - clock-names           : List of clock input name strings sorted in the same
                           order as the clocks property.
+			  "ref_clk" indicates reference clock frequency.
+			  UFS host supplies reference clock to UFS device and UFS device
+			  specification allows host to provide one of the 4 frequencies (19.2 MHz,
+			  26 MHz, 38.4 MHz, 52MHz) for reference clock. This "ref_clk" entry is
+			  parsed and used to update the reference clock setting in device.
+			  Defaults to 26 MHz(as per specification) if not specified by host.
 - freq-table-hz		: Array of <min max> operating frequencies stored in the same
                           order as the clocks property. If this property is not
 			  defined or a value in the array is "0" then it is assumed
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 14e5bf7..b3aaea8 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -378,6 +378,20 @@ enum query_opcode {
 	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
 };
 
+/* bRefClkFreq attribute values */
+enum ufs_ref_clk_freq {
+	REF_CLK_FREQ_19_2_MHZ	= 0,
+	REF_CLK_FREQ_26_MHZ	= 1,
+	REF_CLK_FREQ_38_4_MHZ	= 2,
+	REF_CLK_FREQ_52_MHZ	= 3,
+	REF_CLK_FREQ_INVAL	= -1,
+};
+
+struct ufs_ref_clk {
+	unsigned long freq_hz;
+	enum ufs_ref_clk_freq val;
+};
+
 /* Query response result code */
 enum {
 	QUERY_RESULT_SUCCESS                    = 0x00,
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c5b1bf1..9be9fa1 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6296,6 +6296,74 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
+static struct ufs_ref_clk ufs_ref_clk_freqs[] = {
+	{19200000, REF_CLK_FREQ_19_2_MHZ},
+	{26000000, REF_CLK_FREQ_26_MHZ},
+	{38400000, REF_CLK_FREQ_38_4_MHZ},
+	{52000000, REF_CLK_FREQ_52_MHZ},
+	{0, REF_CLK_FREQ_INVAL},
+};
+
+static enum ufs_ref_clk_freq
+ufs_get_bref_clk_from_hz(unsigned long freq)
+{
+	int i;
+
+	for (i = 0; ufs_ref_clk_freqs[i].freq_hz; i++)
+		if (ufs_ref_clk_freqs[i].freq_hz == freq)
+			return ufs_ref_clk_freqs[i].val;
+
+	return REF_CLK_FREQ_INVAL;
+}
+
+void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk)
+{
+	unsigned long freq;
+
+	freq = clk_get_rate(refclk);
+
+	hba->dev_ref_clk_freq =
+		ufs_get_bref_clk_from_hz(freq);
+
+	if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
+		dev_err(hba->dev,
+		"invalid ref_clk setting = %ld\n", freq);
+}
+
+static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
+{
+	int err;
+	u32 ref_clk;
+	u32 freq = hba->dev_ref_clk_freq;
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
+
+	if (err) {
+		dev_err(hba->dev, "failed reading bRefClkFreq. err = %d\n",
+			err);
+		goto out;
+	}
+
+	if (ref_clk == freq)
+		goto out; /* nothing to update */
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &freq);
+
+	if (err) {
+		dev_err(hba->dev, "bRefClkFreq setting to %lu Hz failed\n",
+			ufs_ref_clk_freqs[freq].freq_hz);
+		goto out;
+	}
+
+	dev_dbg(hba->dev, "bRefClkFreq setting to %lu Hz succeeded\n",
+			ufs_ref_clk_freqs[freq].freq_hz);
+
+out:
+	return err;
+}
+
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize
  * @hba: per-adapter instance
@@ -6361,6 +6429,12 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 			"%s: Failed getting max supported power mode\n",
 			__func__);
 	} else {
+		/*
+		 * Set the right value to bRefClkFreq before attempting to
+		 * switch to HS gears.
+		 */
+		if (hba->dev_ref_clk_freq != REF_CLK_FREQ_INVAL)
+			ufshcd_set_dev_ref_clk(hba);
 		ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
 		if (ret) {
 			dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n",
@@ -6837,6 +6911,14 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
 			goto out;
 		}
 
+		/*
+		 * Parse device ref clk freq as per device tree "ref_clk".
+		 * Default dev_ref_clk_freq is set to REF_CLK_FREQ_INVAL
+		 * in ufshcd_alloc_host().
+		 */
+		if (!strcmp(clki->name, "ref_clk"))
+			ufshcd_parse_dev_ref_clk_freq(hba, clki->clk);
+
 		if (clki->max_freq) {
 			ret = clk_set_rate(clki->clk, clki->max_freq);
 			if (ret) {
@@ -7690,6 +7772,7 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 	hba->host = host;
 	hba->dev = dev;
 	*hba_handle = hba;
+	hba->dev_ref_clk_freq = REF_CLK_FREQ_INVAL;
 
 	INIT_LIST_HEAD(&hba->clk_list_head);
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 8110dcd..4b5584b 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -548,6 +548,7 @@ struct ufs_hba {
 	void *priv;
 	unsigned int irq;
 	bool is_irq_enabled;
+	enum ufs_ref_clk_freq dev_ref_clk_freq;
 
 	/* Interrupt aggregation support is broken */
 	#define UFSHCD_QUIRK_BROKEN_INTR_AGGR			0x1
@@ -746,6 +747,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 int ufshcd_wait_for_register(struct ufs_hba *hba, u32 reg, u32 mask,
 				u32 val, unsigned long interval_us,
 				unsigned long timeout_ms, bool can_sleep);
+void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk);
 
 static inline void check_upiu_size(void)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

