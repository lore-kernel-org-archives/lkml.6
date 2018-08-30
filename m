Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AB4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1299A2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1299A2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeHaBhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:37:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727423AbeHaBhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:37:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ULTgfw073857
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:32:57 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m6nm46xa2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 17:32:57 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 30 Aug 2018 17:32:57 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Aug 2018 17:32:53 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ULWoCh25428042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Aug 2018 21:32:50 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E28EE124052;
        Thu, 30 Aug 2018 18:33:27 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09C57124053;
        Thu, 30 Aug 2018 18:33:27 -0400 (EDT)
Received: from oc6728276242.ibm.com (unknown [9.85.221.248])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 18:33:26 -0400 (EDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux@roeck-us.net, joel@jms.id.au, benh@kernel.crashing.org,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v5 03/10] Documentation: hwmon: Add OCC documentation
Date:   Thu, 30 Aug 2018 16:32:34 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1535664761-86018-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18083021-0040-0000-0000-000004680A7A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009641; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01081201; UDB=6.00557772; IPR=6.00861186;
 MB=3.00023023; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-30 21:32:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18083021-0041-0000-0000-0000086F255F
Message-Id: <1535664761-86018-4-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808300216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the hwmon interface for the OCC.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 Documentation/hwmon/occ | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/hwmon/occ

diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
new file mode 100644
index 0000000..adc2fa4
--- /dev/null
+++ b/Documentation/hwmon/occ
@@ -0,0 +1,112 @@
+Kernel driver occ-hwmon
+=======================
+
+Supported chips:
+  * POWER8
+  * POWER9
+
+Author: Eddie James <eajames@linux.vnet.ibm.com>
+
+Description
+-----------
+
+This driver supports hardware monitoring for the On-Chip Controller (OCC)
+embedded on POWER processors. The OCC is a device that collects and aggregates
+sensor data from the processor and the system. The OCC can provide the raw
+sensor data as well as perform thermal and power management on the system.
+
+The P8 version of this driver is a client driver of I2C. It may be probed
+manually if an "ibm,p8-occ-hwmon" compatible device is found under the
+appropriate I2C bus node in the device-tree.
+
+The P9 version of this driver is a client driver of the FSI-based OCC driver.
+It will be probed automatically by the FSI-based OCC driver.
+
+Sysfs entries
+-------------
+
+The following attributes are supported. All attributes are read-only unless
+specified.
+
+The OCC sensor ID is an integer that represents the unique identififer of the
+sensor with respect to the OCC. For example, a temperature sensor for the 3rd
+DIMM slot in the system may have a sensor ID of 7. This mapping is unavailable
+to the device driver, which must therefore export the sensor ID as-is.
+
+Some entries are only present with certain OCC sensor versions or only on
+certain OCCs in the system. The version number is not exported to the user
+but can be inferred.
+
+temp[1-n]_label		OCC sensor ID.
+[with temperature sensor version 1]
+    temp[1-n]_input	Measured temperature of the component in millidegrees
+			Celsius.
+[with temperature sensor version >= 2]
+    temp[1-n]_type		The FRU (Field Replaceable Unit) type
+				(represented by an integer) for the component
+				that this sensor measures.
+    temp[1-n]_fault		Temperature sensor fault boolean; 1 to indicate
+				that a fault is present or 0 to indicate that
+				no fault is present.
+    [with type == 3 (FRU type is VRM)]
+        temp[1-n]_alarm		VRM temperature alarm boolean; 1 to indicate
+				alarm, 0 to indicate no alarm
+    [else]
+        temp[1-n]_input		Measured temperature of the component in
+				millidegrees Celsius.
+
+freq[1-n]_label		OCC sensor ID.
+freq[1-n]_input		Measured frequency of the component in MHz.
+
+power[1-n]_input	Latest measured power reading of the component in
+			microwatts.
+power[1-n]_average	Average power of the component in microwatts.
+power[1-n]_average_interval	The amount of time over which the power average
+				was taken in microseconds.
+[with power sensor version < 2]
+    power[1-n]_label	OCC sensor ID.
+[with power sensor version >= 2]
+    power[1-n]_label	OCC sensor ID + function ID + channel in the form
+			of a string, delimited by underscores, i.e. "0_15_1".
+			Both the function ID and channel are integers that
+			further identify the power sensor.
+[with power sensor version 0xa0]
+    power[1-n]_label	OCC sensor ID + sensor type in the form of a string,
+			delimited by an underscore, i.e. "0_system". Sensor
+			type will be one of "system", "proc", "vdd" or "vdn".
+			For this sensor version, OCC sensor ID will be the same
+			for all power sensors.
+[present only on "master" OCC; represents the whole system power; only one of
+ this type of power sensor will be present]
+    power[1-n]_label		"system"
+    power[1-n]_input		Latest system output power in microwatts.
+    power[1-n]_cap		Current system power cap in microwatts.
+    power[1-n]_cap_not_redundant	System power cap in microwatts when
+					there is not redundant power.
+    power[1-n]_cap_max		Maximum power cap that the OCC can enforce in
+				microwatts.
+    power[1-n]_cap_min		Minimum power cap that the OCC can enforce in
+				microwatts.
+    power[1-n]_cap_user		The power cap set by the user, in microwatts.
+				This attribute will return 0 if no user power
+				cap has been set. This attribute is read-write,
+				but writing any precision below watts will be
+				ignored, i.e. requesting a power cap of
+				500900000 microwatts will result in a power cap
+				request of 500 watts.
+    [with caps sensor version > 1]
+        power[1-n]_cap_user_source	Indicates how the user power cap was
+					set. This is an integer that maps to
+					system or firmware components that can
+					set the user power cap.
+
+The following "extn" sensors are exported as a way for the OCC to provide data
+that doesn't fit anywhere else. The meaning of these sensors is entirely
+dependent on their data, and cannot be statically defined.
+
+extn[1-n]_label		ASCII ID or OCC sensor ID.
+extn[1-n]_flags		This is one byte hexadecimal value. Bit 7 indicates the
+			type of the label attribute; 1 for sensor ID, 0 for
+			ASCII ID. Other bits are reserved.
+extn[1-n]_input		6 bytes of hexadecimal data, with a meaning defined by
+			the sensor ID.
-- 
1.8.3.1

