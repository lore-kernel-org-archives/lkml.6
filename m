Return-Path: <prvs=568516f6c=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x22599pBbk98dDVqTFW9xhGmGmKbBtPgUd5feAGF543p+wwoD4B7quj2wVI/IYeQuwxdZr2Bs
ARC-Seal: i=1; a=rsa-sha256; t=1517933211; cv=none;
        d=google.com; s=arc-20160816;
        b=fhDtZUXfF6AdIsnX5WyPn42gbYHoCLGQExxCNfnbmr+JDzgzk9IuZreRGm0uw0U7qh
         Ls8kK8n3ka7y+HtrOVI7dUUVU1k+8HmZVD1fJj7/XKo3gY3fMYsIFZpm1BeWIATzJ3yq
         /wpLbPAU4y4PMb6Rx165Z+XODQHSzX576QF0OQGGjvn0IW/RSXeGfmaLhBoXDLrSRCpx
         LtsBsTo5iLNqenlVCScEnf04PoP+2jKP/o8Cl9nh8oW28pmjC90n5oAAst/7u6/mJ2FZ
         jJNbr3uivxeKhNWIvnQAk5GVhYduErBuO1CRflP5Wv2vyLaf5o1IYfur4RH5CTnVQLHP
         RMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=h5dNiV5Op2UunDV0oGUZiVMexXO6MIiUxbvZGF8cNgg=;
        b=mOHmFgFAq+etGRAEcKNqtLlnCpDYtgIiwSpL2fduIeonUBuMIw1OwjPTRG6J7AWgGF
         122NLaXs9i86TXJSh+A1hatJu/R5keR7xXmnBIyzVuJp0u56vdBS6TndfcBP+7fXaroK
         Fu0GqfKXQE8fGSVsPw/GUH2+FFgeHKRI6vnve78sy5Y6McbVHarJgqpJ77mnJ5IOnPsY
         1INsMWey4P5E+psMgJyHTghQbKXYMIS8eagWgpIkRezfh7Ot8kyVoE+ZZZlhhYrORix1
         OeyonzVCVGFBqFXL6hILvNzvGpUeYIjzrZHwQCEg62dm+fU6sGtHw9mb/HJXNG7uQkjd
         v+3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=oGLbTHf0;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=oGLbTHf0;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,469,1511798400";
   d="scan'208";a="167144247"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v5 10/11] scsi: ufs: sysfs: flags
Date: Tue,  6 Feb 2018 18:06:22 +0200
Message-Id: <1517933183-30892-11-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668334865757207?=
X-GMAIL-MSGID: =?utf-8?q?1591668334865757207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a sysfs group entry for the UFS flags. The group adds
"flags" folder under the UFS driver sysfs entry
(/sys/bus/platform/drivers/ufshcd/*). The flags are shown as boolean value
("true" or "false"). The full information about the UFS flags could be
found at UFS specifications 2.1.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 65 ++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               | 39 ++++++++++++++++++
 drivers/scsi/ufs/ufs.h                     | 14 +++++--
 3 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 57c6a90..f4f49e2 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -598,3 +598,68 @@ Description:	This file shows the granularity of the LUN. This is one of
 		the UFS unit descriptor parameters. The full information
 		about the descriptor could be found at UFS specifications 2.1.
 		The file is read only.
+
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/device_init
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the device init status. The full information
+		about the flag could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/permanent_wpe
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether permanent write protection is enabled.
+		The full information about the flag could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/power_on_wpe
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether write protection is enabled on all
+		logical units configured as power on write protected. The
+		full information about the flag could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/bkops_enable
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether the device background operations are
+		enabled. The full information about the flag could be
+		found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/life_span_mode_enable
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether the device life span mode is enabled.
+		The full information about the flag could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/phy_resource_removal
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether physical resource removal is enable.
+		The full information about the flag could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/busy_rtc
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether the device is executing internal
+		operation related to real time clock. The full information
+		about the flag could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/disable_fw_update
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows whether the device FW update is permanently
+		disabled. The full information about the flag could be found
+		at UFS specifications 2.1.
+		The file is read only.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index fc43583..258fb75 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -538,6 +538,44 @@ static const struct attribute_group ufs_sysfs_string_descriptors_group = {
 	.attrs = ufs_sysfs_string_descriptors,
 };
 
+#define UFS_FLAG(_name, _uname)						\
+static ssize_t _name##_show(struct device *dev,				\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	bool flag;							\
+	struct ufs_hba *hba = dev_get_drvdata(dev);			\
+	if (ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,		\
+		QUERY_FLAG_IDN##_uname, &flag))				\
+		return -EINVAL;						\
+	return sprintf(buf, "%s\n", flag ? "true" : "false");		\
+}									\
+static DEVICE_ATTR_RO(_name)
+
+UFS_FLAG(device_init, _FDEVICEINIT);
+UFS_FLAG(permanent_wpe, _PERMANENT_WPE);
+UFS_FLAG(power_on_wpe, _PWR_ON_WPE);
+UFS_FLAG(bkops_enable, _BKOPS_EN);
+UFS_FLAG(life_span_mode_enable, _LIFE_SPAN_MODE_ENABLE);
+UFS_FLAG(phy_resource_removal, _FPHYRESOURCEREMOVAL);
+UFS_FLAG(busy_rtc, _BUSY_RTC);
+UFS_FLAG(disable_fw_update, _PERMANENTLY_DISABLE_FW_UPDATE);
+
+static struct attribute *ufs_sysfs_device_flags[] = {
+	&dev_attr_device_init.attr,
+	&dev_attr_permanent_wpe.attr,
+	&dev_attr_power_on_wpe.attr,
+	&dev_attr_bkops_enable.attr,
+	&dev_attr_life_span_mode_enable.attr,
+	&dev_attr_phy_resource_removal.attr,
+	&dev_attr_busy_rtc.attr,
+	&dev_attr_disable_fw_update.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_flags_group = {
+	.name = "flags",
+	.attrs = ufs_sysfs_device_flags,
+};
 
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
@@ -547,6 +585,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_health_descriptor_group,
 	&ufs_sysfs_power_descriptor_group,
 	&ufs_sysfs_string_descriptors_group,
+	&ufs_sysfs_flags_group,
 	NULL,
 };
 
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 7387059..df5e73e 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -130,9 +130,17 @@ enum {
 
 /* Flag idn for Query Requests*/
 enum flag_idn {
-	QUERY_FLAG_IDN_FDEVICEINIT      = 0x01,
-	QUERY_FLAG_IDN_PWR_ON_WPE	= 0x03,
-	QUERY_FLAG_IDN_BKOPS_EN         = 0x04,
+	QUERY_FLAG_IDN_FDEVICEINIT			= 0x01,
+	QUERY_FLAG_IDN_PERMANENT_WPE			= 0x02,
+	QUERY_FLAG_IDN_PWR_ON_WPE			= 0x03,
+	QUERY_FLAG_IDN_BKOPS_EN				= 0x04,
+	QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE		= 0x05,
+	QUERY_FLAG_IDN_PURGE_ENABLE			= 0x06,
+	QUERY_FLAG_IDN_RESERVED2			= 0x07,
+	QUERY_FLAG_IDN_FPHYRESOURCEREMOVAL		= 0x08,
+	QUERY_FLAG_IDN_BUSY_RTC				= 0x09,
+	QUERY_FLAG_IDN_RESERVED3			= 0x0A,
+	QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE	= 0x0B,
 };
 
 /* Attribute idn for Query requests */
-- 
2.7.4
