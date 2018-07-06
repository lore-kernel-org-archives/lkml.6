Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5518B23FBA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5518B23FBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeGFL43 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:56:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932851AbeGFL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:56:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66Bs6hi130590
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 07:56:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k24m5g7vp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:56:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Fri, 6 Jul 2018 12:56:25 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 12:56:21 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w66BuKkd36831432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 11:56:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EE9C4203F;
        Fri,  6 Jul 2018 14:56:45 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3550642042;
        Fri,  6 Jul 2018 14:56:43 +0100 (BST)
Received: from oc4502181600.ibm.com (unknown [9.77.202.248])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 14:56:42 +0100 (BST)
From:   Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To:     linux@roeck-us.net, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 3/3] hwmon: Document the sensor enable attribute
Date:   Fri,  6 Jul 2018 17:26:06 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070611-4275-0000-0000-00000295DFBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070611-4276-0000-0000-0000379D6CF6
Message-Id: <1530878166-12589-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 Documentation/hwmon/sysfs-interface | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index fc337c3..f865dd7 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -171,6 +171,15 @@ in[0-*]_label	Suggested voltage channel label.
 		user-space.
 		RO
 
+in[0-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 cpu[0-*]_vid	CPU core reference voltage.
 		Unit: millivolt
 		RO
@@ -236,6 +245,15 @@ fan[1-*]_label	Suggested fan channel label.
 		In all other cases, the label is provided by user-space.
 		RO
 
+fan[1-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 Also see the Alarms section for status flags associated with fans.
 
 
@@ -409,6 +427,15 @@ temp_reset_history
 		Reset temp_lowest and temp_highest for all sensors
 		WO
 
+temp[1-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 Some chips measure temperature using external thermistors and an ADC, and
 report the temperature measurement as a voltage. Converting this voltage
 back to a temperature (or the other way around for limits) requires
@@ -468,6 +495,15 @@ curr_reset_history
 		Reset currX_lowest and currX_highest for all sensors
 		WO
 
+curr[1-*]_enable
+		Enable or disable the sensors.
+		When disabled the sensor read will return -ENODATA. This
+		attribute can be used as per-sensor or per-sub-group attribute
+		depending on what is supported by the hardware.
+		1: Enable
+		0: Disable
+		RW
+
 Also see the Alarms section for status flags associated with currents.
 
 *********
@@ -566,6 +602,15 @@ power[1-*]_crit			Critical maximum power.
 				Unit: microWatt
 				RW
 
+power[1-*]_enable		Enable or disable the sensors.
+				When disabled the sensor read will return
+				-ENODATA. This attribute can be used as
+				per-sensor or per-sub-group attribute depending
+				on what is supported by the hardware.
+				1: Enable
+				0: Disable
+				RW
+
 Also see the Alarms section for status flags associated with power readings.
 
 **********
@@ -576,6 +621,14 @@ energy[1-*]_input		Cumulative energy use
 				Unit: microJoule
 				RO
 
+energy[1-*]_enable		Enable or disable the sensors.
+				When disabled the sensor read will return
+				-ENODATA. This attribute can be used as
+				per-sensor or per-sub-group attribute depending
+				on what is supported by the hardware.
+				1: Enable
+				0: Disable
+				RW
 
 ************
 * Humidity *
@@ -586,6 +639,15 @@ humidity[1-*]_input		Humidity
 				RO
 
 
+humidity[1-*]_enable		Enable or disable the sensors
+				When disabled the sensor read will return
+				-ENODATA. This attribute can be used as
+				per-sensor or per-sub-group attribute depending
+				on what is supported by the hardware.
+				1: Enable
+				0: Disable
+				RW
+
 **********
 * Alarms *
 **********
-- 
1.8.3.1

