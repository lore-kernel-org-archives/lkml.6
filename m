Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1QmLAIBjGlvXHgAAmS7hNA
	; Fri, 08 Jun 2018 11:07:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DAB5E608B8; Fri,  8 Jun 2018 11:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528456063;
	bh=QpR22BHqa6/VoeV3wxGae//TEruglNFFSCovC1qw2SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZswagObnTGw4fKm/p9cpA4WS3QzpFz6hrt8I4eVmhY0eK1XuB5rHyOp9D5incVXa4
	 qTHjyvj1qGoBmvwfWLV6lENHnVW51CpQWnOgCOoiewJxWXVOCgBvVXD/eLf44iuFJF
	 NqVBrmTMOKiOrTgTopMttOCU/JkTFCtVLjsbTGJs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E6063607A4;
	Fri,  8 Jun 2018 11:07:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T3iyCU8a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OmJIwK+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E6063607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeFHLHl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:07:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48740 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeFHLHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:07:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CAFCF608CD; Fri,  8 Jun 2018 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528456057;
        bh=QpR22BHqa6/VoeV3wxGae//TEruglNFFSCovC1qw2SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3iyCU8aDdP2UF96hVrn7SdcWxGsAmfuP5t5SeJdOT4fWLR9EXSc07c8Yjhdoq/qD
         73AUAozvqf15hN0TuBtIHnz6U/MRix7wJh57dM5pIxOm1fJcGhgrdXCfn6ItivjFNr
         RGbQrk6wPkfUiWr+ly+024AbSFiA2Z4LFwCoAvLo=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 414CF60590;
        Fri,  8 Jun 2018 11:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528456056;
        bh=QpR22BHqa6/VoeV3wxGae//TEruglNFFSCovC1qw2SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OmJIwK+ZV56SDv5TuS2ITFsUUqyeeAkFbJVBuewQviArtRJaTc4fd/tboSENJWlBa
         Yti6G+ZqAL+J1q+XOQTHrG3C6PXewMxZShQJ5C6nkGGlfAkm4l6iiu5kA0YcT0jOcH
         Nyd4smr69qKbur/09OzW1BErc/duP64Z0Rw+qXkY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 414CF60590
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
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 3/3] scsi: ufs: Add sysfs support for ufs provision
Date: Fri,  8 Jun 2018 16:36:30 +0530
Message-Id: <1528455990-24572-4-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs support to trigger ufs provisioning at runtime.
Usage : echo <desc_buf> > /sys/bus/platform/drivers/*/
	config_descriptor/ufs_provision
To check provisioning status:
cat /sys/bus/platform/drivers/*/config_descriptor/ufs_provision
1- > Success (Reboot device to check updated provisioning)

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  16 ++++
 drivers/scsi/ufs/ufs-sysfs.c               |  25 ++++++
 drivers/scsi/ufs/ufs.h                     |   2 +
 drivers/scsi/ufs/ufshcd.c                  | 128 +++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.h                  |   5 ++
 5 files changed, 176 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 016724e..43419b5 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -883,3 +883,19 @@ Contact:	Subhash Jadavani <subhashj@codeaurora.org>
 Description:	This entry shows the target state of an UFS UIC link
 		for the chosen system power management level.
 		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/config_descriptor/ufs_provision
+Date:		February 2018
+Contact:	Sayali Lokhande <sayalil@codeaurora.org>
+Description:	This file shows the status of runtime ufs provisioning.
+		This can be used to provision ufs device if bConfigDescrLock is 0.
+		Configuration buffer needs to be written in space separated format
+		specificied as:
+		echo <bNumberLU> <bBootEnable> <bDescrAccessEn> <bInitPowerMode>
+		<bHighPriorityLUN> <bSecureRemovalType> <bInitActiveICCLevel>
+		<wPeriodicRTCUpdate> <bConfigDescrLock> <LUNum> <bLUEnable>
+		<bBootLunID> <size_in_kb> <bDataReliability> <bLUWriteProtect>
+		<bMemoryType> <bLogicalBlockSize> <bProvisioningType>
+		<wContextCapabilities> > ufs_provision
+		To check updated configuration check unit_descriptor and
+		device_descriptor sysfs fields.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 8d9332b..8b68813 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -252,6 +252,30 @@ static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
 	return ret;
 }
 
+static ssize_t ufs_provision_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return ufshcd_desc_config_show(dev, attr, buf);
+}
+
+static ssize_t ufs_provision_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	return ufshcd_desc_config_store(dev, attr, buf, count);
+}
+
+DEVICE_ATTR_RW(ufs_provision);
+
+static struct attribute *ufs_sysfs_config_descriptor[] = {
+	&dev_attr_ufs_provision.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_config_descriptor_group = {
+	.name = "config_descriptor",
+	.attrs = ufs_sysfs_config_descriptor,
+};
+
 #define UFS_DESC_PARAM(_name, _puname, _duname, _size)			\
 static ssize_t _name##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
@@ -713,6 +737,7 @@ static DEVICE_ATTR_RO(_name)
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_device_descriptor_group,
+	&ufs_sysfs_config_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
 	&ufs_sysfs_geometry_descriptor_group,
 	&ufs_sysfs_health_descriptor_group,
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 1f99904..0b497fc 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -427,6 +427,7 @@ enum {
 };
 
 struct ufs_unit_desc {
+	u8	   LUNum;
 	u8     bLUEnable;              /* 1 for enabled LU */
 	u8     bBootLunID;             /* 0 for using this LU for boot */
 	u8     bLUWriteProtect;        /* 1 = power on WP, 2 = permanent WP */
@@ -451,6 +452,7 @@ struct ufs_config_descr {
 	u32    qVendorConfigCode;      /* Vendor specific configuration code */
 	struct ufs_unit_desc unit[8];
 	u8	lun_to_grow;
+	u8 num_luns;
 };
 
 /* Task management service response */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8975449..26b39c8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1581,6 +1581,131 @@ void ufshcd_release(struct ufs_hba *hba)
 }
 EXPORT_SYMBOL_GPL(ufshcd_release);
 
+ssize_t ufshcd_desc_config_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "provision_enabled = %d\n",
+		hba->provision_enabled);
+}
+
+ssize_t ufshcd_desc_config_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	struct ufs_config_descr *cfg = &hba->cfgs;
+	char *strbuf;
+	char *strbuf_copy;
+	int desc_buf[count];
+	int *pt;
+	char *token;
+	int i, ret;
+	int value, commit = 0;
+	int num_luns = 0;
+	int KB_per_block = 4;
+
+	/* reserve one byte for null termination */
+	strbuf = kmalloc(count + 1, GFP_KERNEL);
+	if (!strbuf)
+		return -ENOMEM;
+
+	strbuf_copy = strbuf;
+	strlcpy(strbuf, buf, count + 1);
+	memset(desc_buf, 0, count);
+
+	/* Just return if bConfigDescrLock is already set */
+	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_CONF_DESC_LOCK, 0, 0, &cfg->bConfigDescrLock);
+	if (ret) {
+		dev_err(hba->dev, "%s: Failed reading bConfigDescrLock %d, cannot re-provision device!\n",
+			__func__, ret);
+		hba->provision_enabled = 0;
+		goto out;
+	}
+	if (cfg->bConfigDescrLock == 1) {
+		dev_err(hba->dev, "%s: bConfigDescrLock already set to %u, cannot re-provision device!\n",
+		__func__, cfg->bConfigDescrLock);
+		hba->provision_enabled = 0;
+		goto out;
+	}
+
+	for (i = 0; i < count; i++) {
+		token = strsep(&strbuf, " ");
+		if (!token && i) {
+			num_luns = desc_buf[i-1];
+			dev_dbg(hba->dev, "%s: token %s, num_luns %d\n",
+				__func__, token, num_luns);
+			if (num_luns > 8) {
+				dev_err(hba->dev, "%s: Invalid num_luns %d\n",
+				__func__, num_luns);
+				hba->provision_enabled = 0;
+				goto out;
+			}
+			break;
+		}
+
+		ret = kstrtoint(token, 0, &value);
+		if (ret) {
+			dev_err(hba->dev, "%s: kstrtoint failed %d %s\n",
+				__func__, ret, token);
+			break;
+		}
+		desc_buf[i] = value;
+		dev_dbg(hba->dev, " desc_buf[%d] 0x%x", i, desc_buf[i]);
+	}
+
+	/* Fill in the descriptors with parsed configuration data */
+	pt = desc_buf;
+	cfg->bNumberLU = *pt++;
+	cfg->bBootEnable = *pt++;
+	cfg->bDescrAccessEn = *pt++;
+	cfg->bInitPowerMode = *pt++;
+	cfg->bHighPriorityLUN = *pt++;
+	cfg->bSecureRemovalType = *pt++;
+	cfg->bInitActiveICCLevel = *pt++;
+	cfg->wPeriodicRTCUpdate = *pt++;
+	cfg->bConfigDescrLock = *pt++;
+	dev_dbg(hba->dev, "%s: %u %u %u %u %u %u %u %u %u\n", __func__,
+	cfg->bNumberLU, cfg->bBootEnable, cfg->bDescrAccessEn,
+	cfg->bInitPowerMode, cfg->bHighPriorityLUN, cfg->bSecureRemovalType,
+	cfg->bInitActiveICCLevel, cfg->wPeriodicRTCUpdate,
+	cfg->bConfigDescrLock);
+
+	for (i = 0; i < num_luns; i++) {
+		cfg->unit[i].LUNum = *pt++;
+		cfg->unit[i].bLUEnable = *pt++;
+		cfg->unit[i].bBootLunID = *pt++;
+		/* dNumAllocUnits = size_in_kb/KB_per_block */
+		cfg->unit[i].dNumAllocUnits = (u32)(*pt++ / KB_per_block);
+		cfg->unit[i].bDataReliability = *pt++;
+		cfg->unit[i].bLUWriteProtect = *pt++;
+		cfg->unit[i].bMemoryType = *pt++;
+		cfg->unit[i].bLogicalBlockSize = *pt++;
+		cfg->unit[i].bProvisioningType = *pt++;
+		cfg->unit[i].wContextCapabilities = *pt++;
+	}
+
+	cfg->lun_to_grow = *pt++;
+	commit = *pt++;
+	cfg->num_luns = *pt;
+	dev_dbg(hba->dev, "%s: lun_to_grow %u, commit %u num_luns %u\n",
+		__func__, cfg->lun_to_grow, commit, cfg->num_luns);
+	if (commit == 1) {
+		ret = ufshcd_do_config_device(hba);
+		if (!ret) {
+			hba->provision_enabled = 1;
+			dev_err(hba->dev,
+			"%s: UFS Provisioning completed,num_luns %u, reboot now !\n",
+			__func__, cfg->num_luns);
+		}
+	} else
+		dev_err(hba->dev, "%s: Invalid commit %u\n", __func__, commit);
+out:
+	kfree(strbuf_copy);
+	return count;
+}
+
 static ssize_t ufshcd_clkgate_delay_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -6503,6 +6628,9 @@ static int ufshcd_do_config_device(struct ufs_hba *hba)
 		pt = pt + 5; // Reserved fields set to 0
 	}
 
+	for (i = 0; i < buff_len; i++)
+		dev_dbg(hba->dev, " desc_buf[%d] 0x%x", i, desc_buf[i]);
+
 	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_WRITE_DESC,
 		QUERY_DESC_IDN_CONFIGURATION, 0, 0, desc_buf, &buff_len);
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 982bfdf..1b8304f 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -651,6 +651,7 @@ struct ufs_hba {
 	struct ufs_pwr_mode_info max_pwr_info;
 
 	struct ufs_clk_gating clk_gating;
+	bool provision_enabled;
 	/* Control to enable/disable host capabilities */
 	u32 caps;
 	/* Allow dynamic clk gating */
@@ -867,6 +868,10 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
+ssize_t ufshcd_desc_config_show(struct device *dev,
+		struct device_attribute *attr, char *buf);
+ssize_t ufshcd_desc_config_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count);
 
 int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 	int *desc_length);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
