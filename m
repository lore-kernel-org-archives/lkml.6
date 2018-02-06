Return-Path: <prvs=568516f6c=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x2263a7k+cobIBOp2cSeY1d10ITVLNcqjQquzdQAX9dorYqVjRF6OPl3if+oh2EJJTBmSlUa5
ARC-Seal: i=1; a=rsa-sha256; t=1517933205; cv=none;
        d=google.com; s=arc-20160816;
        b=yrrZxE+HQwb59RbKKKiJ+5veBlijbqrMY0//F2xEZds3h5GQUGHY7i76Mwcx08hsfq
         8R5ybgxwI6AN3w4rCANToNvFMoNOAWiE/kl+apGvONcBMtwM1ATF6916xq+IcfqJ5KXd
         7wXkftKQlMd1SVzVtkAcN5Ab8dR/f9FHnFBRZSbomCrnlBUgj2unTbWQ2jZ2b+F5ZXnA
         veJYtbOMXvcjcPyi7+HSNzUazoGoMdgzEu0ZPk2IrDwIvEPlT5NYfOom+wN/F3+2MjWJ
         3ZfrQzC4QC1joGQABKwXUeRHGk5Ied0agMAazD9K8PVw5Jannf7mx4GcpO//Lmna4yJK
         3wuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=u0BKtiPnKSrKZGqWTMCi36zt3iNlPiU2z1bizsc79sU=;
        b=JghDGbQzak1HlTIIfA9RoEDa1YQRp1PKTKLwOAj+Ig5W9h8lvYRhmOhjYORy3Htfps
         npoG+LeAMC5/B0WJctDo0u1TsGs0XDHcdKDmyZQbpHHT2dd1nWu22NODjr0jSs+NOOWO
         zhGP6KYQe0jOl3zJ8g2CTE5EqbiEglOFoWg4EdT8we8dYfspKgSLHOXDyVTnTRCyPrCA
         O/0hkweJwocErLeMIwRJI3wi2BM6aWk5Cd3CxfaCaJPyRgStwrhFQK/qJn6RKF4EiFm2
         UFOLNnA0WR90mHm4Bsx7JSpv7PJAFfH3mllO4U2rXF9TpWSGuGO/tf9CnDZOr5psarWP
         dZ5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=oZa+M5ls;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=oZa+M5ls;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,469,1511798400";
   d="scan'208";a="167144228"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v5 07/11] scsi: ufs: sysfs: string descriptors
Date: Tue,  6 Feb 2018 18:06:19 +0200
Message-Id: <1517933183-30892-8-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668328420126784?=
X-GMAIL-MSGID: =?utf-8?q?1591668328420126784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a sysfs group entry for the UFS string descriptors.
The group adds "string_descriptors" folder under the UFS driver
sysfs entry (/sys/bus/platform/drivers/ufshcd/*). The folder will contain
5 files that will show string values defined by the UFS spec:
a manufacturer name, a product name, an OEM id, a serial number and a
product revision.  The full information about the string descriptors
could be found at UFS specifications 2.1.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 39 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               | 56 ++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                  | 14 ++++----
 drivers/scsi/ufs/ufshcd.h                  |  9 +++++
 4 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 7460566..c17a968 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -451,3 +451,42 @@ Description:	This file shows maximum VCC, VCCQ and VCCQ2 value for
 		power descriptor parameters. The full information about
 		the descriptor could be found at UFS specifications 2.1.
 		The file is read only.
+
+
+What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/manufacturer_name
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file contains a device manufactureer name string.
+		The full information about the descriptor could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/product_name
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file contains a product name string. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/oem_id
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file contains a OEM ID string. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/serial_number
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file contains a device serial number string. The full
+		information about the descriptor could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/string_descriptors/product_revision
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file contains a product revision string. The full
+		information about the descriptor could be found at
+		UFS specifications 2.1.
+		The file is read only.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 43f965a..7130e0d 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -484,6 +484,61 @@ static const struct attribute_group ufs_sysfs_power_descriptor_group = {
 	.attrs = ufs_sysfs_power_descriptor,
 };
 
+#define UFS_STRING_DESCRIPTOR(_name, _pname)				\
+static ssize_t _name##_show(struct device *dev,				\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	u8 index;							\
+	struct ufs_hba *hba = dev_get_drvdata(dev);			\
+	int ret;							\
+	int desc_len = QUERY_DESC_MAX_SIZE;				\
+	u8 *desc_buf;							\
+	desc_buf = kzalloc(QUERY_DESC_MAX_SIZE, GFP_ATOMIC);		\
+	if (!desc_buf)							\
+		return -ENOMEM;						\
+	ret = ufshcd_query_descriptor_retry(hba,			\
+		UPIU_QUERY_OPCODE_READ_DESC, QUERY_DESC_IDN_DEVICE,	\
+		0, 0, desc_buf, &desc_len);				\
+	if (ret) {							\
+		ret = -EINVAL;						\
+		goto out;						\
+	}								\
+	index = desc_buf[DEVICE_DESC_PARAM##_pname];			\
+	memset(desc_buf, 0, QUERY_DESC_MAX_SIZE);			\
+	if (ufshcd_read_string_desc(hba, index, desc_buf,		\
+		QUERY_DESC_MAX_SIZE, true)) {				\
+		ret = -EINVAL;						\
+		goto out;						\
+	}								\
+	ret = snprintf(buf, PAGE_SIZE, "%s\n",				\
+		desc_buf + QUERY_DESC_HDR_SIZE);			\
+out:									\
+	kfree(desc_buf);						\
+	return ret;							\
+}									\
+static DEVICE_ATTR_RO(_name)
+
+UFS_STRING_DESCRIPTOR(manufacturer_name, _MANF_NAME);
+UFS_STRING_DESCRIPTOR(product_name, _PRDCT_NAME);
+UFS_STRING_DESCRIPTOR(oem_id, _OEM_ID);
+UFS_STRING_DESCRIPTOR(serial_number, _SN);
+UFS_STRING_DESCRIPTOR(product_revision, _PRDCT_REV);
+
+static struct attribute *ufs_sysfs_string_descriptors[] = {
+	&dev_attr_manufacturer_name.attr,
+	&dev_attr_product_name.attr,
+	&dev_attr_oem_id.attr,
+	&dev_attr_serial_number.attr,
+	&dev_attr_product_revision.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_string_descriptors_group = {
+	.name = "string_descriptors",
+	.attrs = ufs_sysfs_string_descriptors,
+};
+
+
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_device_descriptor_group,
@@ -491,6 +546,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_geometry_descriptor_group,
 	&ufs_sysfs_health_descriptor_group,
 	&ufs_sysfs_power_descriptor_group,
+	&ufs_sysfs_string_descriptors_group,
 	NULL,
 };
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b88fcf7..9cfdd8e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2873,11 +2873,11 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
  * The buf_len parameter will contain, on return, the length parameter
  * received on the response.
  */
-static int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
-					 enum query_opcode opcode,
-					 enum desc_idn idn, u8 index,
-					 u8 selector,
-					 u8 *desc_buf, int *buf_len)
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
+				  enum query_opcode opcode,
+				  enum desc_idn idn, u8 index,
+				  u8 selector,
+				  u8 *desc_buf, int *buf_len)
 {
 	int err;
 	int retries;
@@ -3093,8 +3093,8 @@ static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
  * Return 0 in case of success, non-zero otherwise
  */
 #define ASCII_STD true
-static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
-				   u8 *buf, u32 size, bool ascii)
+int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
+			    u8 *buf, u32 size, bool ascii)
 {
 	int err = 0;
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 515c6e6..2dad9da 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -842,6 +842,12 @@ static inline bool ufshcd_is_hs_mode(struct ufs_pa_layer_attr *pwr_info)
 }
 
 /* Expose Query-Request API */
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
+				  enum query_opcode opcode,
+				  enum desc_idn idn, u8 index,
+				  u8 selector,
+				  u8 *desc_buf, int *buf_len);
+
 int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   enum desc_idn desc_id,
 			   int desc_index,
@@ -850,6 +856,9 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 			   u8 param_size);
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	enum flag_idn idn, bool *flag_res);
+int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
+			    u8 *buf, u32 size, bool ascii);
+
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
 
-- 
2.7.4
