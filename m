Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28AAC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547EE20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547EE20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390415AbeGKVIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:08:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390322AbeGKVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BL1lUh059621
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:02:02 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5sex00mh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:02:01 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 15:02:01 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 15:01:56 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BL1tLk11796844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:01:55 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E2E06E052;
        Wed, 11 Jul 2018 15:01:55 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A829E6E04E;
        Wed, 11 Jul 2018 15:01:54 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 15:01:54 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        benh@kernel.crashing.org, linux@roeck-us.net, jdelvare@suse.com,
        mark.rutland@arm.com, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v4 7/9] hwmon (occ): Add sensor types and versions
Date:   Wed, 11 Jul 2018 16:01:36 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071121-8235-0000-0000-00000DD12EC0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059946; UDB=6.00544035; IPR=6.00837867;
 MB=3.00022107; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 21:02:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071121-8236-0000-0000-000041D8D3FB
Message-Id: <1531342898-15790-8-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807110221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add structures to define all sensor types and versions. Add sysfs show
and store functions for each sensor type. Add a method to construct the
"set user power cap" command and send it to the OCC. Add rate limit to
polling the OCC (in case user-space reads our hwmon entries rapidly).

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/hwmon/occ/common.c | 648 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/occ/common.h |   5 +
 2 files changed, 653 insertions(+)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 73f62aa..1719536 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -11,10 +11,119 @@
  */
 
 #include <linux/device.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <asm/unaligned.h>
 
 #include "common.h"
 
+#define OCC_UPDATE_FREQUENCY		msecs_to_jiffies(1000)
+
+#define OCC_TEMP_SENSOR_FAULT		0xFF
+
+#define OCC_FRU_TYPE_VRM		0x3
+
+/* OCC sensor type and version definitions */
+
+struct temp_sensor_1 {
+	u16 sensor_id;
+	u16 value;
+} __packed;
+
+struct temp_sensor_2 {
+	u32 sensor_id;
+	u8 fru_type;
+	u8 value;
+} __packed;
+
+struct freq_sensor_1 {
+	u16 sensor_id;
+	u16 value;
+} __packed;
+
+struct freq_sensor_2 {
+	u32 sensor_id;
+	u16 value;
+} __packed;
+
+struct power_sensor_1 {
+	u16 sensor_id;
+	u32 update_tag;
+	u32 accumulator;
+	u16 value;
+} __packed;
+
+struct power_sensor_2 {
+	u32 sensor_id;
+	u8 function_id;
+	u8 apss_channel;
+	u16 reserved;
+	u32 update_tag;
+	u64 accumulator;
+	u16 value;
+} __packed;
+
+struct power_sensor_data {
+	u16 value;
+	u32 update_tag;
+	u64 accumulator;
+} __packed;
+
+struct power_sensor_data_and_time {
+	u16 update_time;
+	u16 value;
+	u32 update_tag;
+	u64 accumulator;
+} __packed;
+
+struct power_sensor_a0 {
+	u32 sensor_id;
+	struct power_sensor_data_and_time system;
+	u32 reserved;
+	struct power_sensor_data_and_time proc;
+	struct power_sensor_data vdd;
+	struct power_sensor_data vdn;
+} __packed;
+
+struct caps_sensor_1 {
+	u16 curr_powercap;
+	u16 curr_powerreading;
+	u16 norm_powercap;
+	u16 max_powercap;
+	u16 min_powercap;
+	u16 user_powerlimit;
+} __packed;
+
+struct caps_sensor_2 {
+	u16 curr_powercap;
+	u16 curr_powerreading;
+	u16 norm_powercap;
+	u16 max_powercap;
+	u16 min_powercap;
+	u16 user_powerlimit;
+	u8 user_powerlimit_source;
+} __packed;
+
+struct caps_sensor_3 {
+	u16 curr_powercap;
+	u16 curr_powerreading;
+	u16 norm_powercap;
+	u16 max_powercap;
+	u16 hard_min_powercap;
+	u16 soft_min_powercap;
+	u16 user_powerlimit;
+	u8 user_powerlimit_source;
+} __packed;
+
+struct extended_sensor {
+	u8 name[4];
+	u8 flags;
+	u8 reserved;
+	u8 data[6];
+} __packed;
+
 static int occ_poll(struct occ *occ)
 {
 	u16 checksum = occ->poll_cmd_data + 1;
@@ -30,9 +139,545 @@ static int occ_poll(struct occ *occ)
 	cmd[6] = checksum & 0xFF;	/* checksum lsb */
 	cmd[7] = 0;
 
+	/* mutex should already be locked if necessary */
 	return occ->send_cmd(occ, cmd);
 }
 
+static int occ_set_user_power_cap(struct occ *occ, u16 user_power_cap)
+{
+	int rc;
+	u8 cmd[8];
+	u16 checksum = 0x24;
+	__be16 user_power_cap_be = cpu_to_be16(user_power_cap);
+
+	cmd[0] = 0;
+	cmd[1] = 0x22;
+	cmd[2] = 0;
+	cmd[3] = 2;
+
+	memcpy(&cmd[4], &user_power_cap_be, 2);
+
+	checksum += cmd[4] + cmd[5];
+	cmd[6] = checksum >> 8;
+	cmd[7] = checksum & 0xFF;
+
+	rc = mutex_lock_interruptible(&occ->lock);
+	if (rc)
+		return rc;
+
+	rc = occ->send_cmd(occ, cmd);
+
+	mutex_unlock(&occ->lock);
+
+	return rc;
+}
+
+static int occ_update_response(struct occ *occ)
+{
+	int rc = mutex_lock_interruptible(&occ->lock);
+
+	if (rc)
+		return rc;
+
+	/* limit the maximum rate of polling the OCC */
+	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
+		rc = occ_poll(occ);
+		occ->last_update = jiffies;
+	}
+
+	mutex_unlock(&occ->lock);
+	return rc;
+}
+
+static ssize_t occ_show_temp_1(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct temp_sensor_1 *temp;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	temp = ((struct temp_sensor_1 *)sensors->temp.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&temp->sensor_id);
+		break;
+	case 1:
+		/* millidegrees */
+		val = get_unaligned_be16(&temp->value) * 1000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_temp_2(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct temp_sensor_2 *temp;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	temp = ((struct temp_sensor_2 *)sensors->temp.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&temp->sensor_id);
+		break;
+	case 1:
+		val = temp->value;
+		if (val == OCC_TEMP_SENSOR_FAULT)
+			return -EREMOTEIO;
+
+		if (temp->fru_type != OCC_FRU_TYPE_VRM) {
+			/* sensor not ready */
+			if (val == 0)
+				return -EAGAIN;
+
+			val *= 1000;	/* millidegrees */
+		}
+		break;
+	case 2:
+		val = temp->fru_type;
+		break;
+	case 3:
+		val = temp->value == OCC_TEMP_SENSOR_FAULT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_freq_1(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u16 val = 0;
+	struct freq_sensor_1 *freq;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	freq = ((struct freq_sensor_1 *)sensors->freq.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&freq->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be16(&freq->value);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_freq_2(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u32 val = 0;
+	struct freq_sensor_2 *freq;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	freq = ((struct freq_sensor_2 *)sensors->freq.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&freq->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be16(&freq->value);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_power_1(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct power_sensor_1 *power;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	power = ((struct power_sensor_1 *)sensors->power.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&power->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be32(&power->update_tag);
+		break;
+	case 2:
+		val = get_unaligned_be32(&power->accumulator);
+		break;
+	case 3:
+		/* microwatts */
+		val = get_unaligned_be16(&power->value) * 1000000ULL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static ssize_t occ_show_power_2(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct power_sensor_2 *power;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	power = ((struct power_sensor_2 *)sensors->power.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&power->sensor_id);
+		break;
+	case 1:
+		val = get_unaligned_be32(&power->update_tag);
+		break;
+	case 2:
+		val = get_unaligned_be64(&power->accumulator);
+		break;
+	case 3:
+		/* microwatts */
+		val = get_unaligned_be16(&power->value) * 1000000ULL;
+		break;
+	case 4:
+		val = power->function_id;
+		break;
+	case 5:
+		val = power->apss_channel;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static ssize_t occ_show_power_a0(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u64 val = 0;
+	struct power_sensor_a0 *power;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	power = ((struct power_sensor_a0 *)sensors->power.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be32(&power->sensor_id);
+		break;
+	case 1:
+		return snprintf(buf, PAGE_SIZE - 1, "system\n");
+	case 2:
+		val = get_unaligned_be16(&power->system.update_time);
+		break;
+	case 3:
+		/* microwatts */
+		val = get_unaligned_be16(&power->system.value) * 1000000ULL;
+		break;
+	case 4:
+		val = get_unaligned_be32(&power->system.update_tag);
+		break;
+	case 5:
+		val = get_unaligned_be64(&power->system.accumulator);
+		break;
+	case 6:
+		return snprintf(buf, PAGE_SIZE - 1, "proc\n");
+	case 7:
+		val = get_unaligned_be16(&power->proc.update_time);
+		break;
+	case 8:
+		/* microwatts */
+		val = get_unaligned_be16(&power->proc.value) * 1000000ULL;
+		break;
+	case 9:
+		val = get_unaligned_be32(&power->proc.update_tag);
+		break;
+	case 10:
+		val = get_unaligned_be64(&power->proc.accumulator);
+		break;
+	case 11:
+		return snprintf(buf, PAGE_SIZE - 1, "vdd\n");
+	case 12:
+		/* microwatts */
+		val = get_unaligned_be16(&power->vdd.value) * 1000000ULL;
+		break;
+	case 13:
+		val = get_unaligned_be32(&power->vdd.update_tag);
+		break;
+	case 14:
+		val = get_unaligned_be64(&power->vdd.accumulator);
+		break;
+	case 15:
+		return snprintf(buf, PAGE_SIZE - 1, "vdn\n");
+	case 16:
+		/* microwatts */
+		val = get_unaligned_be16(&power->vdn.value) * 1000000ULL;
+		break;
+	case 17:
+		val = get_unaligned_be32(&power->vdn.update_tag);
+		break;
+	case 18:
+		val = get_unaligned_be64(&power->vdn.accumulator);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%llu\n", val);
+}
+
+static ssize_t occ_show_caps_1(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u16 val = 0;
+	struct caps_sensor_1 *caps;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	caps = ((struct caps_sensor_1 *)sensors->caps.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&caps->curr_powercap);
+		break;
+	case 1:
+		val = get_unaligned_be16(&caps->curr_powerreading);
+		break;
+	case 2:
+		val = get_unaligned_be16(&caps->norm_powercap);
+		break;
+	case 3:
+		val = get_unaligned_be16(&caps->max_powercap);
+		break;
+	case 4:
+		val = get_unaligned_be16(&caps->min_powercap);
+		break;
+	case 5:
+		val = get_unaligned_be16(&caps->user_powerlimit);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_caps_2(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u16 val = 0;
+	struct caps_sensor_2 *caps;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	caps = ((struct caps_sensor_2 *)sensors->caps.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&caps->curr_powercap);
+		break;
+	case 1:
+		val = get_unaligned_be16(&caps->curr_powerreading);
+		break;
+	case 2:
+		val = get_unaligned_be16(&caps->norm_powercap);
+		break;
+	case 3:
+		val = get_unaligned_be16(&caps->max_powercap);
+		break;
+	case 4:
+		val = get_unaligned_be16(&caps->min_powercap);
+		break;
+	case 5:
+		val = get_unaligned_be16(&caps->user_powerlimit);
+		break;
+	case 6:
+		val = caps->user_powerlimit_source;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_show_caps_3(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int rc;
+	u16 val = 0;
+	struct caps_sensor_3 *caps;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	caps = ((struct caps_sensor_3 *)sensors->caps.data) + sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		val = get_unaligned_be16(&caps->curr_powercap);
+		break;
+	case 1:
+		val = get_unaligned_be16(&caps->curr_powerreading);
+		break;
+	case 2:
+		val = get_unaligned_be16(&caps->norm_powercap);
+		break;
+	case 3:
+		val = get_unaligned_be16(&caps->max_powercap);
+		break;
+	case 4:
+		val = get_unaligned_be16(&caps->hard_min_powercap);
+		break;
+	case 5:
+		val = get_unaligned_be16(&caps->user_powerlimit);
+		break;
+	case 6:
+		val = caps->user_powerlimit_source;
+		break;
+	case 7:
+		val = get_unaligned_be16(&caps->soft_min_powercap);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE - 1, "%u\n", val);
+}
+
+static ssize_t occ_store_caps_user(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int rc;
+	u16 user_power_cap;
+	struct occ *occ = dev_get_drvdata(dev);
+
+	rc = kstrtou16(buf, 0, &user_power_cap);
+	if (rc)
+		return rc;
+
+	rc = occ_set_user_power_cap(occ, user_power_cap);
+	if (rc)
+		return rc;
+
+	return count;
+}
+
+static ssize_t occ_show_extended(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	int rc;
+	struct extended_sensor *extn;
+	struct occ *occ = dev_get_drvdata(dev);
+	struct occ_sensors *sensors = &occ->sensors;
+	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
+
+	rc = occ_update_response(occ);
+	if (rc)
+		return rc;
+
+	extn = ((struct extended_sensor *)sensors->extended.data) +
+		sattr->index;
+
+	switch (sattr->nr) {
+	case 0:
+		rc = snprintf(buf, PAGE_SIZE - 1, "%02x%02x%02x%02x\n",
+			      extn->name[0], extn->name[1], extn->name[2],
+			      extn->name[3]);
+		break;
+	case 1:
+		rc = snprintf(buf, PAGE_SIZE - 1, "%02x\n", extn->flags);
+		break;
+	case 2:
+		rc = snprintf(buf, PAGE_SIZE - 1, "%02x%02x%02x%02x%02x%02x\n",
+			      extn->data[0], extn->data[1], extn->data[2],
+			      extn->data[3], extn->data[4], extn->data[5]);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rc;
+}
+
 /* only need to do this once at startup, as OCC won't change sensors on us */
 static void occ_parse_poll_response(struct occ *occ)
 {
@@ -95,6 +740,9 @@ int occ_setup(struct occ *occ, const char *name)
 {
 	int rc;
 
+	mutex_init(&occ->lock);
+
+	/* no need to lock */
 	rc = occ_poll(occ);
 	if (rc == -ESHUTDOWN) {
 		dev_info(occ->bus_dev, "host is not ready\n");
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index cfcd353..f697adb 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -12,6 +12,8 @@
 #ifndef OCC_COMMON_H
 #define OCC_COMMON_H
 
+#include <linux/mutex.h>
+
 struct device;
 
 #define OCC_RESP_DATA_BYTES		4089
@@ -91,6 +93,9 @@ struct occ {
 
 	u8 poll_cmd_data;		/* to perform OCC poll command */
 	int (*send_cmd)(struct occ *occ, u8 *cmd);
+
+	unsigned long last_update;
+	struct mutex lock;		/* lock OCC access */
 };
 
 int occ_setup(struct occ *occ, const char *name);
-- 
1.8.3.1

