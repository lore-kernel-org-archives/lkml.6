Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F729C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4B8208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4B8208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbeHAHZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:25:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733098AbeHAHZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:25:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w715dGjN023613
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 01:42:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kk6c7153r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 01:42:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Wed, 1 Aug 2018 06:41:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 06:41:57 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w715fuhH40894568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 05:41:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93E734C040;
        Wed,  1 Aug 2018 08:42:08 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B16EA4C050;
        Wed,  1 Aug 2018 08:42:07 +0100 (BST)
Received: from oc4502181600.in.ibm.com (unknown [9.124.35.143])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Aug 2018 08:42:07 +0100 (BST)
From:   Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ego@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] powernv: opal-sensor-groups: Add attributes to disable/enable sensors
Date:   Wed,  1 Aug 2018 11:11:53 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18080105-0016-0000-0000-000001EF2645
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080105-0017-0000-0000-000032444A7A
Message-Id: <1533102113-27487-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support to disable and enable plaform specific
sensor groups like performance, utilization and frequency which are
currently not supported in hwmon.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
This patch is based on 
https://git.kernel.org/powerpc/c/04baaf28f40c68c35a413cd9d0db71

 .../ABI/testing/sysfs-firmware-opal-sensor-groups  | 33 ++++++++
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 99 +++++++++++++++-------
 2 files changed, 100 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups

diff --git a/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
new file mode 100644
index 0000000..a236686
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups
@@ -0,0 +1,33 @@
+What:		/sys/firmware/opal/sensor_groups
+Date:		August 2017
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sensor groups directory for POWER9 powernv servers
+
+		Each folder in this directory contains a sensor group
+		which are classified based on type of the sensor
+		like power, temperature, frequency, current, etc. They
+		can also indicate the group of sensors belonging to
+		different owners like CSM, Profiler, Job-Scheduler
+
+What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/clear
+Date:		August 2017
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sysfs file to clear the min-max of all the sensors
+		belonging to the group.
+
+		Writing 1 to this file will clear the minimum and
+		maximum values of all the sensors in the group.
+		In POWER9, the min-max of a sensor is the historical minimum
+		and maximum value of the sensor cached by OCC.
+
+What:		/sys/firmware/opal/sensor_groups/<sensor_group_name>/enable
+Date:		August 2018
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	Sysfs file to enable/disable the sensor-group
+
+		Writing 0 to this file will disable all the sensors
+		belonging to the group and writing 1 will enable the
+		sensors.
+		In POWER9, by default all the sensor-groups are enabled and
+		will be copied to main memory by OCC. This file can be used
+		to increase the update frequency of selective sensor-groups.
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index f7d04b6..8bf6c86 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -24,6 +24,8 @@
 struct sg_attr {
 	u32 handle;
 	struct kobj_attribute attr;
+	u32 opal_no;
+	bool enable;
 };
 
 static struct sensor_group {
@@ -60,34 +62,17 @@ int sensor_group_enable(u32 handle, bool enable)
 }
 EXPORT_SYMBOL_GPL(sensor_group_enable);
 
-static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
-			const char *buf, size_t count)
+static int sensor_group_clear(u32 handle)
 {
-	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
 	struct opal_msg msg;
-	u32 data;
-	int ret, token;
-
-	ret = kstrtoint(buf, 0, &data);
-	if (ret)
-		return ret;
-
-	if (data != 1)
-		return -EINVAL;
+	int token, ret;
 
 	token = opal_async_get_token_interruptible();
-	if (token < 0) {
-		pr_devel("Failed to get token\n");
+	if (token < 0)
 		return token;
-	}
-
-	ret = mutex_lock_interruptible(&sg_mutex);
-	if (ret)
-		goto out_token;
 
-	ret = opal_sensor_group_clear(sattr->handle, token);
-	switch (ret) {
-	case OPAL_ASYNC_COMPLETION:
+	ret = opal_sensor_group_clear(handle, token);
+	if (ret == OPAL_ASYNC_COMPLETION) {
 		ret = opal_async_wait_response(token, &msg);
 		if (ret) {
 			pr_devel("Failed to wait for the async response\n");
@@ -95,20 +80,57 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 			goto out;
 		}
 		ret = opal_error_code(opal_get_async_rc(msg));
-		if (!ret)
-			ret = count;
+	} else {
+		ret = opal_error_code(ret);
+	}
+
+out:
+	opal_async_release_token(token);
+	return ret;
+}
+
+static ssize_t sgroup_show(struct kobject *kobj, struct kobj_attribute *attr,
+			   char *buf)
+{
+	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+
+	return sprintf(buf, "%u\n", sattr->enable);
+}
+
+static ssize_t sgroup_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct sg_attr *sattr = container_of(attr, struct sg_attr, attr);
+	bool data;
+	int ret;
+
+	ret = kstrtobool(buf, &data);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&sg_mutex);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+	switch (sattr->opal_no) {
+	case OPAL_SENSOR_GROUP_CLEAR:
+		if (data)
+			ret = sensor_group_clear(sattr->handle);
 		break;
-	case OPAL_SUCCESS:
-		ret = count;
+	case OPAL_SENSOR_GROUP_ENABLE:
+		ret = sensor_group_enable(sattr->handle, data);
+		if (!ret)
+			sattr->enable = data;
 		break;
 	default:
-		ret = opal_error_code(ret);
+		break;
 	}
 
-out:
+	if (!ret)
+		ret = count;
+
 	mutex_unlock(&sg_mutex);
-out_token:
-	opal_async_release_token(token);
 	return ret;
 }
 
@@ -117,17 +139,25 @@ static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 	const char *attr_name;
 	ssize_t (*store)(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *buf, size_t count);
+	ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr,
+			char *buf);
 } ops_info[] = {
-	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sg_store },
+	{ OPAL_SENSOR_GROUP_CLEAR, "clear", sgroup_store, NULL},
+	{ OPAL_SENSOR_GROUP_ENABLE, "enable", sgroup_store, sgroup_show},
 };
 
 static void add_attr(int handle, struct sg_attr *attr, int index)
 {
 	attr->handle = handle;
+	attr->opal_no = ops_info[index].opal_no;
 	sysfs_attr_init(&attr->attr.attr);
 	attr->attr.attr.name = ops_info[index].attr_name;
-	attr->attr.attr.mode = 0220;
+	if (ops_info[index].show)
+		attr->attr.attr.mode = 0664;
+	else
+		attr->attr.attr.mode = 0220;
 	attr->attr.store = ops_info[index].store;
+	attr->attr.show = ops_info[index].show;
 }
 
 static int add_attr_group(const __be32 *ops, int len, struct sensor_group *sg,
@@ -142,6 +172,7 @@ static int add_attr_group(const __be32 *ops, int len, struct sensor_group *sg,
 				add_attr(handle, &sg->sgattrs[count], j);
 				sg->sg.attrs[count] =
 					&sg->sgattrs[count].attr.attr;
+				sg->sgattrs[count].enable = true;
 				count++;
 			}
 
@@ -186,6 +217,10 @@ void __init opal_sensor_groups_init(void)
 		const __be32 *ops;
 		u32 sgid, len, nr_attrs, chipid;
 
+		/* Skip sensor groups that are handled in HWMON */
+		if (of_device_is_compatible(node, "ibm,opal-sensor"))
+			continue;
+
 		ops = of_get_property(node, "ops", &len);
 		if (!ops)
 			continue;
-- 
1.8.3.1

