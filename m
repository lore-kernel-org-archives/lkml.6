Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7827C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B50F20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B50F20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbeGKVIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:08:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390064AbeGKVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:08:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BL0XYb011344
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:01:54 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k5npn10rv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:01:51 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Wed, 11 Jul 2018 15:01:50 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Jul 2018 15:01:46 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6BL1jnQ10551674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jul 2018 14:01:45 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F4726E058;
        Wed, 11 Jul 2018 15:01:45 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0006E052;
        Wed, 11 Jul 2018 15:01:44 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 11 Jul 2018 15:01:44 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        benh@kernel.crashing.org, linux@roeck-us.net, jdelvare@suse.com,
        mark.rutland@arm.com, openbmc@lists.ozlabs.org, robh+dt@kernel.org,
        joel@jms.id.au, Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v4 2/9] Documentation: hwmon: Add OCC documentation
Date:   Wed, 11 Jul 2018 16:01:31 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18071121-0036-0000-0000-00000A0DD7D2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009352; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059946; UDB=6.00544035; IPR=6.00837866;
 MB=3.00022107; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-11 21:01:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071121-0037-0000-0000-00004811018A
Message-Id: <1531342898-15790-3-git-send-email-eajames@linux.vnet.ibm.com>
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

Document the hwmon interface for the OCC.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 Documentation/hwmon/occ | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/hwmon/occ

diff --git a/Documentation/hwmon/occ b/Documentation/hwmon/occ
new file mode 100644
index 0000000..465fa1a
--- /dev/null
+++ b/Documentation/hwmon/occ
@@ -0,0 +1,73 @@
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
+temp[1-n]_label		OCC sensor id.
+temp[1-n]_input		Measured temperature in millidegrees C.
+[with temperature sensor version 2+]
+    temp[1-n]_fru_type		Given FRU (Field Replaceable Unit) type.
+    temp[1-n]_fault		Temperature sensor fault.
+
+freq[1-n]_label		OCC sensor id.
+freq[1-n]_input		Measured frequency.
+
+power[1-n]_label	OCC sensor id.
+power[1-n]_input	Measured power in microwatts.
+power[1-n]_update_tag	Number of 250us samples represented in accumulator.
+power[1-n]_accumulator	Accumulation of 250us power readings.
+[with power sensor version 2+]
+    power[1-n]_function_id	Identifies what the power reading is for.
+    power[1-n]_apss_channel	Indicates APSS channel.
+
+[power version 0xa0 only]
+power1_id			OCC sensor id.
+power[1-n]_label		Sensor type, "system", "proc", "vdd", or "vdn".
+power[1-n]_input		Most recent power reading in microwatts.
+power[1-n]_update_tag		Number of samples in the accumulator.
+power[1-n]_accumulator		Accumulation of power readings.
+[with sensor type "system" and "proc" only]
+    power[1-n]_update_time	Time in us that the power value is read.
+
+caps1_current		Current OCC power cap in watts.
+caps1_reading		Current system output power in watts.
+caps1_norm		Power cap without redundant power.
+caps1_max		Maximum power cap.
+[caps version 1 and 2 only]
+    caps1_min		Minimum power cap.
+[caps version 3+]
+    caps1_min_hard		Hard minimum cap that can be set and held.
+    caps1_min_soft		Soft minimum cap below hard, not guaranteed.
+caps1_user		The powercap specified by the user. Will be 0 if no
+			user powercap exists. This attribute is read-write.
+[caps version 1+]
+    caps1_user_source	Indicates how the user power limit was set.
+
+extn[1-n]_label		ASCII id or sensor id.
+extn[1-n]_flags		Indicates type of label attribute.
+extn[1-n]_input		Data.
-- 
1.8.3.1

