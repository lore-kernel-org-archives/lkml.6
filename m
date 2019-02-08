Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07AC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52BA20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfBHRtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:49:11 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:42616 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbfBHRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:49:10 -0500
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18Hf0wR001475;
        Fri, 8 Feb 2019 17:48:49 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2qhdy0g7p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Feb 2019 17:48:49 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 66F97AE;
        Fri,  8 Feb 2019 17:48:48 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id C31DF3A;
        Fri,  8 Feb 2019 17:48:47 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog/hpwdt: Update Kconfig documentation
Date:   Fri,  8 Feb 2019 10:48:03 -0700
Message-Id: <1549648083-9501-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=563 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation relating to HPWDT_NMI_DECODING to reflect its
current usage.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 57f017d..846dd07 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1145,7 +1145,7 @@ config HP_WATCHDOG
 	select WATCHDOG_CORE
 	depends on X86 && PCI
 	help
-	  A software monitoring watchdog and NMI sourcing driver. This driver
+	  A software monitoring watchdog and NMI handling driver. This driver
 	  will detect lockups and provide a stack trace. This is a driver that
 	  will only load on an HP ProLiant system with a minimum of iLO2 support.
 	  To compile this driver as a module, choose M here: the module will be
@@ -1163,12 +1163,13 @@ config KEMPLD_WDT
 	  called kempld_wdt.
 
 config HPWDT_NMI_DECODING
-	bool "NMI decoding support for the HP ProLiant iLO2+ Hardware Watchdog Timer"
+	bool "NMI support for the HP ProLiant iLO2+ Hardware Watchdog Timer"
 	depends on HP_WATCHDOG
 	default y
 	help
-	  When an NMI occurs this feature will make the necessary BIOS calls to
-	  log the cause of the NMI.
+	  Enables the NMI handler for the watchdog pretimeout NMI and the iLO
+	  "Generate NMI to System" virtual button.  When an NMI is claimed
+	  by the driver, panic is called.
 
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
-- 
1.8.3.1

