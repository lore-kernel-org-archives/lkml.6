Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA6CC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2DA240BD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2DA240BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeGENv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:51:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753782AbeGENvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:51:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65DoHlF036964
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 09:51:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1jh1wvre-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 09:51:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 14:51:51 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 14:51:48 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65Dpl7p37879854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 13:51:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B98A85205F;
        Thu,  5 Jul 2018 16:52:11 +0100 (BST)
Received: from oc4502181600.ibm.com (unknown [9.79.199.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1076352067;
        Thu,  5 Jul 2018 16:52:09 +0100 (BST)
From:   Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To:     linux@roeck-us.net, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 3/3] hwmon: Document the sensor enable attribute and update ibmpowernv
Date:   Thu,  5 Jul 2018 19:21:29 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070513-4275-0000-0000-000002957D30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070513-4276-0000-0000-0000379D066C
Message-Id: <1530798689-27742-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 Documentation/hwmon/ibmpowernv      | 35 +++++++++++++++-
 Documentation/hwmon/sysfs-interface | 82 +++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
index 8826ba2..77ddba7 100644
--- a/Documentation/hwmon/ibmpowernv
+++ b/Documentation/hwmon/ibmpowernv
@@ -33,9 +33,40 @@ fanX_input		Measured RPM value.
 fanX_min		Threshold RPM for alert generation.
 fanX_fault		0: No fail condition
 			1: Failing fan
+
 tempX_input		Measured ambient temperature.
 tempX_max		Threshold ambient temperature for alert generation.
-inX_input		Measured power supply voltage
+tempX_highest		Historical maximum temperature
+tempX_lowest		Historical minimum temperature
+temp1_enable		Enable/disable all temperature sensors
+			1: Enable
+			0: Disable
+temp[2-N]_enable	State of the sensor (enabled/disabled)
+
+inX_input		Measured power supply voltage (millivolt)
 inX_fault		0: No fail condition.
 			1: Failing power supply.
-power1_input		System power consumption (microWatt)
+inX_highest		Historical maximum voltage
+inX_lowest		Historical minimum voltage
+in1_enable		Enable/disable all voltage sensors
+			1: Enable
+			0: Disable
+in[2-N]_enable		State of the sensor (enabled/disabled)
+
+powerX_input		Power consumption (microWatt)
+powerX_input_highest	Historical maximum power
+powerX_input_lowest	Historical minimum power
+power1_enable		Enable/disable all power sensors
+			1: Enable
+			0: Disable
+power[2-N]_enable	State of the sensor (enabled/disabled)
+
+currX_input		Measured current (milliampere)
+currX_highest		Historical maximum current
+currX_lowest		Historical minimum current
+curr1_enable		Enable/disable all current sensors
+			1: Enable
+			0: Disable
+curr[2-N]_enable	State of the sensor (enabled/disabled)
+
+energyX_input		Cumulative energy (microJoule)
diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index fc337c3..d81109c 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -171,6 +171,17 @@ in[0-*]_label	Suggested voltage channel label.
 		user-space.
 		RO
 
+in[0-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 cpu[0-*]_vid	CPU core reference voltage.
 		Unit: millivolt
 		RO
@@ -236,6 +247,17 @@ fan[1-*]_label	Suggested fan channel label.
 		In all other cases, the label is provided by user-space.
 		RO
 
+fan[1-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 Also see the Alarms section for status flags associated with fans.
 
 
@@ -409,6 +431,17 @@ temp_reset_history
 		Reset temp_lowest and temp_highest for all sensors
 		WO
 
+temp[1-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 Some chips measure temperature using external thermistors and an ADC, and
 report the temperature measurement as a voltage. Converting this voltage
 back to a temperature (or the other way around for limits) requires
@@ -468,6 +501,17 @@ curr_reset_history
 		Reset currX_lowest and currX_highest for all sensors
 		WO
 
+curr[1-*]_enable
+		Enable or disable the sensor.
+		When disabled the sensor read will return -ENODATA. For chips
+		which do not have the capability to disable/enable single sensor
+		but have support for sensor-group disable/enable, will only have
+		the first attribute with write permission. In such cases write
+		to the first attribute will affect all the sensors of this type.
+		1: Enable
+		0: Disable
+		RW/RO
+
 Also see the Alarms section for status flags associated with currents.
 
 *********
@@ -566,6 +610,19 @@ power[1-*]_crit			Critical maximum power.
 				Unit: microWatt
 				RW
 
+power[1-*]_enable		Enable or disable the sensor.
+				When disabled the sensor read will return
+				-ENODATA. For chips which do not have the
+				capability to disable/enable single sensor but
+				have support for sensor-group disable/enable,
+				will only have the first attribute with write
+				permission. In such cases write	to the first
+				attribute will affect all the sensors of this
+				type.
+				1: Enable
+				0: Disable
+				RW/RO
+
 Also see the Alarms section for status flags associated with power readings.
 
 **********
@@ -576,6 +633,18 @@ energy[1-*]_input		Cumulative energy use
 				Unit: microJoule
 				RO
 
+energy[1-*]_enable		Enable or disable the sensor.
+				When disabled the sensor read will return
+				-ENODATA. For chips which do not have the
+				capability to disable/enable single sensor but
+				have support for sensor-group disable/enable,
+				will only have the first attribute with write
+				permission. In such cases write	to the first
+				attribute will affect all the sensors of this
+				type.
+				1: Enable
+				0: Disable
+				RW/RO
 
 ************
 * Humidity *
@@ -586,6 +655,19 @@ humidity[1-*]_input		Humidity
 				RO
 
 
+humidity[1-*]_enable		Enable or disable the sensor.
+				When disabled the sensor read will return
+				-ENODATA. For chips which do not have the
+				capability to disable/enable single sensor but
+				have support for sensor-group disable/enable,
+				will only have the first attribute with write
+				permission. In such cases write	to the first
+				attribute will affect all the sensors of this
+				type.
+				1: Enable
+				0: Disable
+				RW/RO
+
 **********
 * Alarms *
 **********
-- 
1.8.3.1

