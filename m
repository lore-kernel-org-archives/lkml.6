Return-Path: <prvs=563541312=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224WzBMiO1HY61Dc05t8KKQ+MT8KtrahlJGrvaZXfElSWWbnSvCaMDgeFRePHXs26fPpJjOQ
ARC-Seal: i=1; a=rsa-sha256; t=1517501763; cv=none;
        d=google.com; s=arc-20160816;
        b=Z0XqfIQDy3pjHXkSJm2V4eh33Ij1+3P71RDKewPnICY1SLnKXrc0vq2fVC0zUMemDv
         0+BQOUHCpfyntGkkS4zm715N1QPYyuUEZWkdr5wzsSxjRFxrImJuJUqqkxF/Pr5aHGGL
         HKq5GQdwnK7WciLW+Tv2cr2Wpn8jj8ChoaXl6L4huYdlTlynI/stTBx9ZIuGfFzgAMUm
         rAj5KWAQQkQhkzaaBZ4JWWKw9ZoqXp5BrQ+ZF2VAFX/L7t8TMoiNC8HVphPPo6zdiamN
         cQKWumsPsQvGn2CghBl8y5LeCF7zgXdK7ByEKjORj0DeidDjCSV1Wj4ZRCGEH728/s82
         1hKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=mw6L/Qe4ltMRYufAuEuESkfnA8ZIMi6G9TjqxmUtvO0=;
        b=GUXC2/wSSmYROMMz1wQGG9kB1dMQpLLv4mtxfQ6XsUNGYAwbtk0gI1FUcNsi50bPjI
         VhVH+3t+abXy1QHpzjjRmW8TmeQ0aSNkQQBnnSjZ4ccpukMbe+mo5pIL65z7dzb0YsnD
         888/CrZxfQeR3fbylmEpVinoZW6COYWKLhMkaoyRcjtkkj93A+LNECLZyG346yAhEljG
         m0/HWn/B5Sz8DlApZagrVmYRLXTPTqZAjA9FzZnmds8fRWI6oTS401rQR0JxRIxze3ah
         hhJF6PgnPyXNInmWibJig53Ltc7yUlipPSRbtyJKDa/jErZA36tB8rgON4DjznZCi2vy
         Mkhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=KpMnmrn2;
       spf=pass (google.com: domain of prvs=563541312=stanislav.nijnikov@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=563541312=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=KpMnmrn2;
       spf=pass (google.com: domain of prvs=563541312=stanislav.nijnikov@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=563541312=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511798400";
   d="scan'208";a="173298257"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v4 06/10] ufs: sysfs: power descriptor
Date: Thu,  1 Feb 2018 18:15:42 +0200
Message-Id: <1517501746-19075-7-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215928853575753?=
X-GMAIL-MSGID: =?utf-8?q?1591215928853575753?=
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
 drivers/scsi/ufs/ufs-sysfs.c               | 118 +++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

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
index 1c89009..d2e6b49 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -383,12 +383,130 @@ static const struct attribute_group ufs_sysfs_health_descriptor_group = {
 	.attrs = ufs_sysfs_health_descriptor,
 };
 
+#define UFS_POWER_DESC_PARAM(_name, _uname, _index)                           \
+static ssize_t _name##_index##_show(struct device *dev,                       \
+	struct device_attribute *attr, char *buf)                             \
+{                                                                             \
+	struct ufs_hba *hba = dev_get_drvdata(dev);                           \
+	return ufs_sysfs_read_desc_param(hba, QUERY_DESC_IDN_POWER, 0,        \
+		PWR_DESC##_uname##_0 + _index * UFS_PARAM_WORD_SIZE,          \
+		buf, UFS_PARAM_WORD_SIZE);                                    \
+}                                                                             \
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
