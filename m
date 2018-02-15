Return-Path: <prvs=57756532b=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x227GnS+xHYdmEydCEUC19CK/FbrK8FDcbvvPlTPhFhNezGGiPzzzjUVCoug8pLBAey51MqK3
ARC-Seal: i=1; a=rsa-sha256; t=1518696864; cv=none;
        d=google.com; s=arc-20160816;
        b=erAVNulk/4oP7aZLTbMV8eOsBR/ruYPWsI7MP2YMrH2/YhvwcyqjRm2pUAH72LQVYz
         6e58uBhQReWYDzP6kj1KzspTy+CgiFtugEgWYz72op0Bv6Z3qp3OtGsbKnbuDT+eNYkL
         SwLI4caGACRoGRDGbgcRLLFSunB/6uSgFCyicgsVKA4jXRutYKL7t0ZKGOT/d6K80sWT
         kWxuZIjqrVzK7RdIA0Rgsep4jDrXOX09J1CCS2S/FrhANk53lQ8zM3Y+Af3DbvZcP/6f
         3QiescBj7EL8rzsH0+KeQTmjbPIHI0BQ7IjfclHno8PRf8jW43Q7w+zeXmrsvDvdx31j
         kxUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4JeNUjYgJEhzeRlLNwUvBD8QbN4vuM4hjM02o9daM8Q=;
        b=bVSJtmqrRAclg5qhvcpt+L3ANigebgh/UuteTV3o6b7PAnMc2JBKgyLdiiIMrCd1S1
         COVqHBIWhW9MgLIgDXmLwyjAYxE7fW5GP0J7wQC38TQH2n8xXn1YpHSbKEx0S0bqfCYm
         jmY8sHcbAgKcoMo57uqsdkOYzpxQDDiQmV70BTcCCjkOsSlMl+g/f19jcUeNqxrRQFJR
         9Onirxhat15r0RX4U/RzfSxZVj2CHKx7SwWYIFI1VZf2re1zYWtFuld8poynt70X2Ger
         XSkTR/8FJBOrAB2B+yvB6acvvH1MGJHEDYox/Lu2NaNVsC1lVC3fsSO26Oy4PIj9OmMI
         nHgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=NiVpcT09;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=NiVpcT09;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,517,1511798400";
   d="scan'208";a="71975446"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org,
	Bart.VanAssche@wdc.com
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v6 03/11] scsi: ufs: sysfs: interconnect descriptor
Date: Thu, 15 Feb 2018 14:14:03 +0200
Message-Id: <1518696851-6730-4-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592469083595688817?=
X-GMAIL-MSGID: =?utf-8?q?1592469083595688817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a sysfs group entry for the UFS interconnect
descriptor parameters. The group adds "interconnect_descriptor" folder
under the UFS driver sysfs entry (/sys/bus/platform/drivers/ufshcd/*).
The parameters are shown as hexadecimal numbers. The full information
about the parameters could be found at UFS specifications 2.1.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 19 +++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               | 18 ++++++++++++++++++
 drivers/scsi/ufs/ufs.h                     |  8 ++++++++
 3 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 8da7b84..099e6fa 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -221,3 +221,22 @@ Description:	This file shows the command maximum timeout for a change
 		parameters. The full information about the descriptor could
 		be found at UFS specifications 2.1.
 		The file is read only.
+
+
+What:		/sys/bus/platform/drivers/ufshcd/*/interconnect_descriptor/unipro_version
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the MIPI UniPro version number in BCD format.
+		This is one of the UFS interconnect descriptor parameters.
+		The full information about the descriptor could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/interconnect_descriptor/mphy_version
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the MIPI M-PHY version number in BCD format.
+		This is one of the UFS interconnect descriptor parameters.
+		The full information about the descriptor could be found at
+		UFS specifications 2.1.
+		The file is read only.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 440b94e..ba229d9 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -249,9 +249,27 @@ static const struct attribute_group ufs_sysfs_device_descriptor_group = {
 	.attrs = ufs_sysfs_device_descriptor,
 };
 
+#define UFS_INTERCONNECT_DESC_PARAM(_name, _uname, _size)		\
+	UFS_DESC_PARAM(_name, _uname, INTERCONNECT, _size)
+
+UFS_INTERCONNECT_DESC_PARAM(unipro_version, _UNIPRO_VER, 2);
+UFS_INTERCONNECT_DESC_PARAM(mphy_version, _MPHY_VER, 2);
+
+static struct attribute *ufs_sysfs_interconnect_descriptor[] = {
+	&dev_attr_unipro_version.attr,
+	&dev_attr_mphy_version.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_interconnect_descriptor_group = {
+	.name = "interconnect_descriptor",
+	.attrs = ufs_sysfs_interconnect_descriptor,
+};
+
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_device_descriptor_group,
+	&ufs_sysfs_interconnect_descriptor_group,
 	NULL,
 };
 
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 6ae1e08..773c049 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -230,6 +230,14 @@ enum device_desc_param {
 	DEVICE_DESC_PARAM_PRDCT_REV		= 0x2A,
 };
 
+/* Interconnect descriptor parameters offsets in bytes*/
+enum interconnect_desc_param {
+	INTERCONNECT_DESC_PARAM_LEN		= 0x0,
+	INTERCONNECT_DESC_PARAM_TYPE		= 0x1,
+	INTERCONNECT_DESC_PARAM_UNIPRO_VER	= 0x2,
+	INTERCONNECT_DESC_PARAM_MPHY_VER	= 0x4,
+};
+
 /*
  * Logical Unit Write Protect
  * 00h: LU not write protected
-- 
2.7.4
