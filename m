Return-Path: <prvs=57756532b=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x227kID9liYAbI5pfYib5CvWEWXgcDDim0iZSPV79mCjBlvhz+rGH2dPeqeKM5fDL41v/PsKv
ARC-Seal: i=1; a=rsa-sha256; t=1518696884; cv=none;
        d=google.com; s=arc-20160816;
        b=MXITBIctZtGROhLtUk7gBTIr0slMcr9e1zHcoP3KYn4R69u6gjrKaGNUV+hqo3WA64
         A/cUTGENC/Yc+f6qYlzBYpi6zuwXZgzELkfe0xxG/xWLNb9lxq7JZ8CqLn6ZzHlW9U5E
         rH4vkRFfafcRJgx4U7zqlI3KuMjqosAUVHhwyUECKwPigQyAFA5cYeAmx9gmPl6xq6Ba
         U+32ROr+2BSunBDX0OqgRU75RIX+O46+QOhs4zceVkYJPBex3lVRRylbCzyQKhZr0xLW
         XsAn3wljP3Nq69bDyrh/NOwJbn2GehVs0Ar2kzWZLx/oG8xvQJu/jkXpC6DTRsQX6/Nu
         3mXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=DMBqSh4UcpvdT7tQRREmG8HdgMBmVt3/o2bdpNuqsy4=;
        b=ruRCvoqINwDTq+madjDFJmYLMtcWIUgr4V9gFQx8AKS+KXcY+1IW/sEI38621lvCwo
         wGqnFckBt6BI1++1KR2sbY3QqXlkIwRT7stYa5SLS7tAeDqj2JxkealVKZFaseTv80He
         3I1JenTxgrIiWC8tkhnIM+3ztpIcnsPERmwj84F0aG8W7tVmElvQXHqF5jMjenI2Nthf
         lloP7yg8KQDtICwU8pJFfyEeE2fkHhmhfDocnWuHYqJ55cMgAjr81rq5WzbS4MF/dpTm
         51KIK0BC0fXU9Ap4p4BvcHOVAdpuqBSaxc5ImEfU5mGVfrwQq+19fys8o8mgM8ZiSYwu
         HrRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=WU0ZETg4;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=WU0ZETg4;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,517,1511798400";
   d="scan'208";a="71975478"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org,
	Bart.VanAssche@wdc.com
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v6 11/11] scsi: ufs: sysfs: attributes
Date: Thu, 15 Feb 2018 14:14:11 +0200
Message-Id: <1518696851-6730-12-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592469104293221478?=
X-GMAIL-MSGID: =?utf-8?q?1592469104293221478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a sysfs group entry for the UFS attributes. The
group adds "attributes" folder under the UFS driver sysfs entry
(/sys/bus/platform/drivers/ufshcd/*). The attributes are shown
as hexadecimal numbers. The full information about the attributes could
be found at UFS specifications 2.1.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 139 +++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               |  80 +++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.h               |   1 +
 drivers/scsi/ufs/ufs.h                     |  27 +++++-
 drivers/scsi/ufs/ufshcd.c                  |   5 +-
 drivers/scsi/ufs/ufshcd.h                  |   3 +-
 6 files changed, 248 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index f4f49e2..07f1c2f 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -663,3 +663,142 @@ Description:	This file shows whether the device FW update is permanently
 		disabled. The full information about the flag could be found
 		at UFS specifications 2.1.
 		The file is read only.
+
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/boot_lun_enabled
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the boot lun enabled UFS device attribute.
+		The full information about the attribute could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/current_power_mode
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the current power mode UFS device attribute.
+		The full information about the attribute could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/active_icc_level
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the active icc level UFS device attribute.
+		The full information about the attribute could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ooo_data_enabled
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the out of order data transfer enabled UFS
+		device attribute. The full information about the attribute
+		could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/bkops_status
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the background operations status UFS device
+		attribute. The full information about the attribute could
+		be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/purge_status
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the purge operation status UFS device
+		attribute. The full information about the attribute could
+		be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_in_size
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the maximum data size in a DATA IN
+		UPIU. The full information about the attribute could
+		be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_out_size
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the maximum number of bytes that can be
+		requested with a READY TO TRANSFER UPIU. The full information
+		about the attribute could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/reference_clock_frequency
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the reference clock frequency UFS device
+		attribute. The full information about the attribute could
+		be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/configuration_descriptor_lock
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether the configuration descriptor is locked.
+		The full information about the attribute could be found at
+		UFS specifications 2.1. The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_number_of_rtt
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the maximum current number of
+		outstanding RTTs in device that is allowed. The full
+		information about the attribute could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_control
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the exception event control UFS device
+		attribute. The full information about the attribute could
+		be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_status
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the exception event status UFS device
+		attribute. The full information about the attribute could
+		be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ffu_status
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file provides the ffu status UFS device attribute.
+		The full information about the attribute could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_state
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file show the PSA feature status. The full information
+		about the attribute could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_data_size
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the amount of data that the host plans to
+		load to all logical units in pre-soldering state.
+		The full information about the attribute could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+
+What:		/sys/class/scsi_device/*/device/dyn_cap_needed
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the The amount of physical memory needed
+		to be removed from the physical memory resources pool of
+		the particular logical unit. The full information about
+		the attribute could be found at UFS specifications 2.1.
+		The file is read only.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index a09a8a2e..cd7174d 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -577,6 +577,61 @@ static const struct attribute_group ufs_sysfs_flags_group = {
 	.attrs = ufs_sysfs_device_flags,
 };
 
+#define UFS_ATTRIBUTE(_name, _uname)					\
+static ssize_t _name##_show(struct device *dev,				\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	struct ufs_hba *hba = dev_get_drvdata(dev);			\
+	u32 value;							\
+	if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,		\
+		QUERY_ATTR_IDN##_uname, 0, 0, &value))			\
+		return -EINVAL;						\
+	return sprintf(buf, "0x%08X\n", value);				\
+}									\
+static DEVICE_ATTR_RO(_name)
+
+UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
+UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
+UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
+UFS_ATTRIBUTE(ooo_data_enabled, _OOO_DATA_EN);
+UFS_ATTRIBUTE(bkops_status, _BKOPS_STATUS);
+UFS_ATTRIBUTE(purge_status, _PURGE_STATUS);
+UFS_ATTRIBUTE(max_data_in_size, _MAX_DATA_IN);
+UFS_ATTRIBUTE(max_data_out_size, _MAX_DATA_OUT);
+UFS_ATTRIBUTE(reference_clock_frequency, _REF_CLK_FREQ);
+UFS_ATTRIBUTE(configuration_descriptor_lock, _CONF_DESC_LOCK);
+UFS_ATTRIBUTE(max_number_of_rtt, _MAX_NUM_OF_RTT);
+UFS_ATTRIBUTE(exception_event_control, _EE_CONTROL);
+UFS_ATTRIBUTE(exception_event_status, _EE_STATUS);
+UFS_ATTRIBUTE(ffu_status, _FFU_STATUS);
+UFS_ATTRIBUTE(psa_state, _PSA_STATE);
+UFS_ATTRIBUTE(psa_data_size, _PSA_DATA_SIZE);
+
+static struct attribute *ufs_sysfs_attributes[] = {
+	&dev_attr_boot_lun_enabled.attr,
+	&dev_attr_current_power_mode.attr,
+	&dev_attr_active_icc_level.attr,
+	&dev_attr_ooo_data_enabled.attr,
+	&dev_attr_bkops_status.attr,
+	&dev_attr_purge_status.attr,
+	&dev_attr_max_data_in_size.attr,
+	&dev_attr_max_data_out_size.attr,
+	&dev_attr_reference_clock_frequency.attr,
+	&dev_attr_configuration_descriptor_lock.attr,
+	&dev_attr_max_number_of_rtt.attr,
+	&dev_attr_exception_event_control.attr,
+	&dev_attr_exception_event_status.attr,
+	&dev_attr_ffu_status.attr,
+	&dev_attr_psa_state.attr,
+	&dev_attr_psa_data_size.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_attributes_group = {
+	.name = "attributes",
+	.attrs = ufs_sysfs_attributes,
+};
+
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_device_descriptor_group,
@@ -586,6 +641,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_power_descriptor_group,
 	&ufs_sysfs_string_descriptors_group,
 	&ufs_sysfs_flags_group,
+	&ufs_sysfs_attributes_group,
 	NULL,
 };
 
@@ -642,6 +698,30 @@ const struct attribute_group ufs_sysfs_unit_descriptor_group = {
 	.attrs = ufs_sysfs_unit_descriptor,
 };
 
+static ssize_t dyn_cap_needed_attribute_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	u32 value;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ufs_hba *hba = shost_priv(sdev->host);
+	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
+
+	if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_DYN_CAP_NEEDED, lun, 0, &value))
+		return -EINVAL;
+	return sprintf(buf, "0x%08X\n", value);
+}
+static DEVICE_ATTR_RO(dyn_cap_needed_attribute);
+
+static struct attribute *ufs_sysfs_lun_attributes[] = {
+	&dev_attr_dyn_cap_needed_attribute.attr,
+	NULL,
+};
+
+const struct attribute_group ufs_sysfs_lun_attributes_group = {
+	.attrs = ufs_sysfs_lun_attributes,
+};
+
 void ufs_sysfs_add_nodes(struct device *dev)
 {
 	int ret;
diff --git a/drivers/scsi/ufs/ufs-sysfs.h b/drivers/scsi/ufs/ufs-sysfs.h
index 2afce16..e5621e5 100644
--- a/drivers/scsi/ufs/ufs-sysfs.h
+++ b/drivers/scsi/ufs/ufs-sysfs.h
@@ -13,4 +13,5 @@ void ufs_sysfs_add_nodes(struct device *dev);
 void ufs_sysfs_remove_nodes(struct device *dev);
 
 extern const struct attribute_group ufs_sysfs_unit_descriptor_group;
+extern const struct attribute_group ufs_sysfs_lun_attributes_group;
 #endif
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index df5e73e..14e5bf7 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -145,10 +145,29 @@ enum flag_idn {
 
 /* Attribute idn for Query requests */
 enum attr_idn {
-	QUERY_ATTR_IDN_ACTIVE_ICC_LVL	= 0x03,
-	QUERY_ATTR_IDN_BKOPS_STATUS	= 0x05,
-	QUERY_ATTR_IDN_EE_CONTROL	= 0x0D,
-	QUERY_ATTR_IDN_EE_STATUS	= 0x0E,
+	QUERY_ATTR_IDN_BOOT_LU_EN		= 0x00,
+	QUERY_ATTR_IDN_RESERVED			= 0x01,
+	QUERY_ATTR_IDN_POWER_MODE		= 0x02,
+	QUERY_ATTR_IDN_ACTIVE_ICC_LVL		= 0x03,
+	QUERY_ATTR_IDN_OOO_DATA_EN		= 0x04,
+	QUERY_ATTR_IDN_BKOPS_STATUS		= 0x05,
+	QUERY_ATTR_IDN_PURGE_STATUS		= 0x06,
+	QUERY_ATTR_IDN_MAX_DATA_IN		= 0x07,
+	QUERY_ATTR_IDN_MAX_DATA_OUT		= 0x08,
+	QUERY_ATTR_IDN_DYN_CAP_NEEDED		= 0x09,
+	QUERY_ATTR_IDN_REF_CLK_FREQ		= 0x0A,
+	QUERY_ATTR_IDN_CONF_DESC_LOCK		= 0x0B,
+	QUERY_ATTR_IDN_MAX_NUM_OF_RTT		= 0x0C,
+	QUERY_ATTR_IDN_EE_CONTROL		= 0x0D,
+	QUERY_ATTR_IDN_EE_STATUS		= 0x0E,
+	QUERY_ATTR_IDN_SECONDS_PASSED		= 0x0F,
+	QUERY_ATTR_IDN_CNTX_CONF		= 0x10,
+	QUERY_ATTR_IDN_CORR_PRG_BLK_NUM		= 0x11,
+	QUERY_ATTR_IDN_RESERVED2		= 0x12,
+	QUERY_ATTR_IDN_RESERVED3		= 0x13,
+	QUERY_ATTR_IDN_FFU_STATUS		= 0x14,
+	QUERY_ATTR_IDN_PSA_STATE		= 0x15,
+	QUERY_ATTR_IDN_PSA_DATA_SIZE		= 0x16,
 };
 
 /* Descriptor idn for Query requests */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index ace3acd..1fbb17b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2689,8 +2689,8 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
  *
  * Returns 0 for success, non-zero in case of failure
 */
-static int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
-			enum attr_idn idn, u8 index, u8 selector, u32 *attr_val)
+int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val)
 {
 	struct ufs_query_req *request = NULL;
 	struct ufs_query_res *response = NULL;
@@ -6468,6 +6468,7 @@ static enum blk_eh_timer_return ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 
 static const struct attribute_group *ufshcd_driver_groups[] = {
 	&ufs_sysfs_unit_descriptor_group,
+	&ufs_sysfs_lun_attributes_group,
 	NULL,
 };
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index f4cb31b..deb3c5d 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -847,13 +847,14 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
 				  enum desc_idn idn, u8 index,
 				  u8 selector,
 				  u8 *desc_buf, int *buf_len);
-
 int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   enum desc_idn desc_id,
 			   int desc_index,
 			   u8 param_offset,
 			   u8 *param_read_buf,
 			   u8 param_size);
+int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, bool *flag_res);
 int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
-- 
2.7.4
