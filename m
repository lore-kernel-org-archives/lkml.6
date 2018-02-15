Return-Path: <prvs=57756532b=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x226qU5TBLn2kzdPLe0rObfGnSIz1Yev333n7UnzcZq9ZQO/TiCfbdkMro4nM9DONrQECst40
ARC-Seal: i=1; a=rsa-sha256; t=1518696872; cv=none;
        d=google.com; s=arc-20160816;
        b=KbOtyGp9ZvlOCCDbm5Lgow6dLuV9ZMMAsGsL5GYTIahpoK8MutvCVLxQso3YJCW2tI
         nN6F/o7aetDCwvsZPkCJzGMRqqTW1ssOszjYAuU8ZY+hZ6A6TqtgMwun/skGBEtPmrrK
         y6MlAvdmhLsQ0h0NiGMvRjkKKDelciCHnwseE8Nrw7cz+N47zXaTVk98sCXnFx3M0zlg
         5DysuaFvvEg2pRPT5o5V7jFCnogd3nils8onhrNWqbHjEonIIv+2m4/ARXg7HD+r8X1k
         etd1i9IG/V9FQmeAHxz3Jb0RzgsK5V6zLUEjqhAXU8jP67sO8C9ARuLfZlgN0NRqhRuc
         PdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YvQG1o5MJtc6YRzwGXGdSIuunZSqMIBoAc0s7wGv7vk=;
        b=xrAXaOe9/1Im/Z4GyQOf0sGs0qvA5AczDTt1d/y3jxuXEaCv9+FWvyazAQjuBljFUY
         AcOaVX4nUYNOqgkd+FWLrCDoEZeY4NRpq3fg6MkyFKVp3qr73e4nqFdELdiFdPnLtNQu
         2ZnJJstvR/CDz+A9PyH2BJ3GcZLL3TSSCe02xyDCo7hoi39cA2oqLuj0LeeVRKzidX79
         Fdd5ZqJgP8ceus6fb3xK8k6HOYc6zdRhg1m9+TzgZXoE6rzV2Hq3xTQhr7rjOfyXQFqM
         1wu0dP+gEoTKjwH37yTXVUk/+xTBJtwFR8PlO0gHN2Uo80BW+M8HJCrd3hQbRawkkoW4
         SkgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=FBkATAI6;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=FBkATAI6;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,517,1511798400";
   d="scan'208";a="71975460"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org,
	Bart.VanAssche@wdc.com
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v6 06/11] scsi: ufs: sysfs: power descriptor
Date: Thu, 15 Feb 2018 14:14:06 +0200
Message-Id: <1518696851-6730-7-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592469091785170120?=
X-GMAIL-MSGID: =?utf-8?q?1592469091785170120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a sysfs group entry for the UFS power descriptor
parameters. The group adds "power_descriptor" folder under the UFS driver
sysfs entry (/sys/bus/platform/drivers/ufshcd/*). The parameters are shown
as hexadecimal numbers. The full information about the parameters could be
found at UFS specifications 2.1.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  10 +++
 drivers/scsi/ufs/ufs-sysfs.c               | 117 +++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index ddb012b..7460566 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -441,3 +441,13 @@ Description:	This file shows indication of the device life time
 		parameters. The full information about the descriptor
 		could be found at UFS specifications 2.1.
 		The file is read only.
+
+
+What:		/sys/bus/platform/drivers/ufshcd/*/power_descriptor/active_icc_levels_vcc*
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows maximum VCC, VCCQ and VCCQ2 value for
+		active ICC levels from 0 to 15. This is one of the UFS
+		power descriptor parameters. The full information about
+		the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index c4f18b0..16e357a 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -368,12 +368,129 @@ static const struct attribute_group ufs_sysfs_health_descriptor_group = {
 	.attrs = ufs_sysfs_health_descriptor,
 };
 
+#define UFS_POWER_DESC_PARAM(_name, _uname, _index)			\
+static ssize_t _name##_index##_show(struct device *dev,			\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	struct ufs_hba *hba = dev_get_drvdata(dev);			\
+	return ufs_sysfs_read_desc_param(hba, QUERY_DESC_IDN_POWER, 0,	\
+		PWR_DESC##_uname##_0 + _index * 2, buf, 2);		\
+}									\
+static DEVICE_ATTR_RO(_name##_index)
+
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 0);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 1);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 2);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 3);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 4);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 5);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 6);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 7);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 8);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 9);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 10);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 11);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 12);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 13);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 14);
+UFS_POWER_DESC_PARAM(active_icc_levels_vcc, _ACTIVE_LVLS_VCC, 15);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 0);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 1);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 2);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 3);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 4);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 5);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 6);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 7);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 8);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 9);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 10);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 11);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 12);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 13);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 14);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq, _ACTIVE_LVLS_VCCQ, 15);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 0);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 1);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 2);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 3);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 4);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 5);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 6);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 7);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 8);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 9);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 10);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 11);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 12);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 13);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 14);
+UFS_POWER_DESC_PARAM(active_icc_levels_vccq2, _ACTIVE_LVLS_VCCQ2, 15);
+
+static struct attribute *ufs_sysfs_power_descriptor[] = {
+	&dev_attr_active_icc_levels_vcc0.attr,
+	&dev_attr_active_icc_levels_vcc1.attr,
+	&dev_attr_active_icc_levels_vcc2.attr,
+	&dev_attr_active_icc_levels_vcc3.attr,
+	&dev_attr_active_icc_levels_vcc4.attr,
+	&dev_attr_active_icc_levels_vcc5.attr,
+	&dev_attr_active_icc_levels_vcc6.attr,
+	&dev_attr_active_icc_levels_vcc7.attr,
+	&dev_attr_active_icc_levels_vcc8.attr,
+	&dev_attr_active_icc_levels_vcc9.attr,
+	&dev_attr_active_icc_levels_vcc10.attr,
+	&dev_attr_active_icc_levels_vcc11.attr,
+	&dev_attr_active_icc_levels_vcc12.attr,
+	&dev_attr_active_icc_levels_vcc13.attr,
+	&dev_attr_active_icc_levels_vcc14.attr,
+	&dev_attr_active_icc_levels_vcc15.attr,
+	&dev_attr_active_icc_levels_vccq0.attr,
+	&dev_attr_active_icc_levels_vccq1.attr,
+	&dev_attr_active_icc_levels_vccq2.attr,
+	&dev_attr_active_icc_levels_vccq3.attr,
+	&dev_attr_active_icc_levels_vccq4.attr,
+	&dev_attr_active_icc_levels_vccq5.attr,
+	&dev_attr_active_icc_levels_vccq6.attr,
+	&dev_attr_active_icc_levels_vccq7.attr,
+	&dev_attr_active_icc_levels_vccq8.attr,
+	&dev_attr_active_icc_levels_vccq9.attr,
+	&dev_attr_active_icc_levels_vccq10.attr,
+	&dev_attr_active_icc_levels_vccq11.attr,
+	&dev_attr_active_icc_levels_vccq12.attr,
+	&dev_attr_active_icc_levels_vccq13.attr,
+	&dev_attr_active_icc_levels_vccq14.attr,
+	&dev_attr_active_icc_levels_vccq15.attr,
+	&dev_attr_active_icc_levels_vccq20.attr,
+	&dev_attr_active_icc_levels_vccq21.attr,
+	&dev_attr_active_icc_levels_vccq22.attr,
+	&dev_attr_active_icc_levels_vccq23.attr,
+	&dev_attr_active_icc_levels_vccq24.attr,
+	&dev_attr_active_icc_levels_vccq25.attr,
+	&dev_attr_active_icc_levels_vccq26.attr,
+	&dev_attr_active_icc_levels_vccq27.attr,
+	&dev_attr_active_icc_levels_vccq28.attr,
+	&dev_attr_active_icc_levels_vccq29.attr,
+	&dev_attr_active_icc_levels_vccq210.attr,
+	&dev_attr_active_icc_levels_vccq211.attr,
+	&dev_attr_active_icc_levels_vccq212.attr,
+	&dev_attr_active_icc_levels_vccq213.attr,
+	&dev_attr_active_icc_levels_vccq214.attr,
+	&dev_attr_active_icc_levels_vccq215.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_power_descriptor_group = {
+	.name = "power_descriptor",
+	.attrs = ufs_sysfs_power_descriptor,
+};
+
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_device_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
 	&ufs_sysfs_geometry_descriptor_group,
 	&ufs_sysfs_health_descriptor_group,
+	&ufs_sysfs_power_descriptor_group,
 	NULL,
 };
 
-- 
2.7.4
