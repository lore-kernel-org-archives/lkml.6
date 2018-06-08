Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OhLkBmBjGlsVHgAAmS7hNA
	; Fri, 08 Jun 2018 11:07:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5EB30608BF; Fri,  8 Jun 2018 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528456038;
	bh=abz67/x/qgi7O0XM5vb/G5luB5qDIaGSZ7DLb4NYwfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=URXFjVi6Ie+cm0rU95LikI4dIQHfA0V6WFuDInXqINQ/xbrw1wPMLg/6LZMdU4Yqe
	 OQu5Tl+/2yjmtVuxeVe6Cc8dMPPvxHdcFViIAEdJGMVB3E0nlNW1JZUniynVLoS4hU
	 1ap8GR5Ve3Xfg2WqXm326H2TXqrnmGku2ejF8nNI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AA8B5607A4;
	Fri,  8 Jun 2018 11:07:17 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L+quvW2a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mX+XnYyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA8B5607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeFHLHQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:07:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeFHLHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:07:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 440D1608BF; Fri,  8 Jun 2018 11:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528456031;
        bh=abz67/x/qgi7O0XM5vb/G5luB5qDIaGSZ7DLb4NYwfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+quvW2auPyS3eW5IEbLkzyuRQGAOX0hxaBZPHjyRbERsScFfiLxVvOWng7Rgy+ii
         y4FUwpN+OD/3gzS9tkPuAPQ7sMbzDjViSUOfmPPoMbLebDV38O7hxJ3qiAy6DnWCbQ
         cbHe3c3nrkGahg12T2HwZEae5NQ1sMfWe5JNLrvg=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA54960590;
        Fri,  8 Jun 2018 11:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528456029;
        bh=abz67/x/qgi7O0XM5vb/G5luB5qDIaGSZ7DLb4NYwfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mX+XnYyg+yrMjLhpvFGmFiXuj67q813+cIsAuoziPCAToRnlYJBLuwboAlbWfXfUx
         7a3HXT+zt5+ZOpkjLc/bcAmNjZy6xNzf1OITIrjSPilwoKXe4oxnGu3UbZrnxt31LL
         NCp1G9IWEEnPCGSaliJLddnNe0VCje6CUSFNM2qI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA54960590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From: Sayali Lokhande <sayalil@codeaurora.org>
To: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org
Cc: linux-scsi@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Date: Fri,  8 Jun 2018 16:36:28 +0530
Message-Id: <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
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
---
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
 drivers/scsi/ufs/ufs.h                             |  9 ++++
 drivers/scsi/ufs/ufshcd-pltfrm.c                   | 24 ++++++++++
 drivers/scsi/ufs/ufshcd.c                          | 52 ++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h                          |  1 +
 5 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
index c39dfef..4522434 100644
--- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
@@ -41,6 +41,12 @@ Optional properties:
 -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
 			  Note that it is assume same number of lanes is used both
 			  directions at once. If not specified, default is 2 lanes per direction.
+- dev-ref-clk-freq	: Specify the device reference clock frequency, must be one of the following:
+			  0: 19.2 MHz
+			  1: 26 MHz
+			  2: 38.4 MHz
+			  3: 52 MHz
+			  Defaults to 26 MHz if not specified.
 
 Note: If above properties are not defined it can be assumed that the supply
 regulators or clocks are always on.
@@ -66,4 +72,5 @@ Example:
 		freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
+		dev-ref-clk-freq = <0>; /* reference clock freq: 19.2 MHz */
 	};
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 14e5bf7..e15deb0 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -378,6 +378,15 @@ enum query_opcode {
 	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
 };
 
+/* bRefClkFreq attribute values */
+enum ref_clk_freq {
+	REF_CLK_FREQ_19_2_MHZ	= 0x0,
+	REF_CLK_FREQ_26_MHZ	= 0x1,
+	REF_CLK_FREQ_38_4_MHZ	= 0x2,
+	REF_CLK_FREQ_52_MHZ	= 0x3,
+	REF_CLK_FREQ_MAX	= REF_CLK_FREQ_52_MHZ,
+};
+
 /* Query response result code */
 enum {
 	QUERY_RESULT_SUCCESS                    = 0x00,
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index e82bde0..6c877f3 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -221,6 +221,28 @@ static int ufshcd_parse_regulator_info(struct ufs_hba *hba)
 	return err;
 }
 
+static void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba)
+{
+	struct device *dev = hba->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	if (!np)
+		return;
+
+	ret = of_property_read_u32(np, "dev-ref-clk-freq",
+				   &hba->dev_ref_clk_freq);
+	if (ret ||
+	    (hba->dev_ref_clk_freq < 0) ||
+	    (hba->dev_ref_clk_freq > REF_CLK_FREQ_52_MHZ)) {
+		dev_err(hba->dev,
+		"%s: invalid ref_clk setting = %d, set to default\n",
+		__func__, hba->dev_ref_clk_freq);
+		/* default setting */
+		hba->dev_ref_clk_freq = REF_CLK_FREQ_26_MHZ;
+	}
+}
+
 #ifdef CONFIG_PM
 /**
  * ufshcd_pltfrm_suspend - suspend power management function
@@ -343,6 +365,8 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	ufshcd_parse_dev_ref_clk_freq(hba);
+
 	ufshcd_init_lanes_per_dir(hba);
 
 	err = ufshcd_init(hba, mmio_base, irq);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c5b1bf1..4abc7ae 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6297,6 +6297,53 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 }
 
 /**
+ * ufshcd_set_dev_ref_clk - set the device bRefClkFreq
+ * @hba: per-adapter instance
+ *
+ * Read the current value of the bRefClkFreq attribute from device and update it
+ * if host is supplying different reference clock frequency than one mentioned
+ * in bRefClkFreq attribute.
+ *
+ * Returns zero on success, non-zero error value on failure.
+ */
+static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
+{
+	int err = 0;
+	int ref_clk = -1;
+	static const char * const ref_clk_freqs[] = {"19.2 MHz", "26 MHz",
+						     "38.4 MHz", "52 MHz"};
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &ref_clk);
+
+	if (err) {
+		dev_err(hba->dev, "%s: failed reading bRefClkFreq. err = %d\n",
+			 __func__, err);
+		goto out;
+	}
+
+	if (ref_clk == hba->dev_ref_clk_freq)
+		goto out; /* nothing to update */
+
+	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
+			QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0,
+			&hba->dev_ref_clk_freq);
+
+	if (err)
+		dev_err(hba->dev, "%s: bRefClkFreq setting to %s failed\n",
+			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
+	/*
+	 * It is good to print this out here to debug any later failures
+	 * related to gear switch.
+	 */
+	dev_dbg(hba->dev, "%s: bRefClkFreq setting to %s succeeded\n",
+			__func__, ref_clk_freqs[hba->dev_ref_clk_freq]);
+
+out:
+	return err;
+}
+
+/**
  * ufshcd_probe_hba - probe hba to detect device and initialize
  * @hba: per-adapter instance
  *
@@ -6361,6 +6408,11 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 			"%s: Failed getting max supported power mode\n",
 			__func__);
 	} else {
+		/*
+		 * Set the right value to bRefClkFreq before attempting to
+		 * switch to HS gears.
+		 */
+		ufshcd_set_dev_ref_clk(hba);
 		ret = ufshcd_config_pwr_mode(hba, &hba->max_pwr_info.info);
 		if (ret) {
 			dev_err(hba->dev, "%s: Failed setting power mode, err = %d\n",
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 8110dcd..b026ad8 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -548,6 +548,7 @@ struct ufs_hba {
 	void *priv;
 	unsigned int irq;
 	bool is_irq_enabled;
+	u32 dev_ref_clk_freq;
 
 	/* Interrupt aggregation support is broken */
 	#define UFSHCD_QUIRK_BROKEN_INTR_AGGR			0x1
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
