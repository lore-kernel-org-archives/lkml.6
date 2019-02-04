Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC481C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7353D20820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfBDX6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:58:06 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:44962 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbfBDX6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:58:04 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14Ntxk8014594;
        Mon, 4 Feb 2019 23:57:43 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2qev95s76k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Feb 2019 23:57:43 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 690E277;
        Mon,  4 Feb 2019 23:57:42 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 077223A;
        Mon,  4 Feb 2019 23:57:41 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog: Update sysfs documentation.
Date:   Mon,  4 Feb 2019 16:57:36 -0700
Message-Id: <1549324656-78660-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=521 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the sysfs attributes:
	pretimeout
	pretimeout_available_governors
	pretimeout_governor

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 Documentation/ABI/testing/sysfs-class-watchdog | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
index 736046b..6317ade 100644
--- a/Documentation/ABI/testing/sysfs-class-watchdog
+++ b/Documentation/ABI/testing/sysfs-class-watchdog
@@ -49,3 +49,26 @@ Contact:	Wim Van Sebroeck <wim@iguana.be>
 Description:
 		It is a read only file. It is read to know about current
 		value of timeout programmed.
+
+What:		/sys/class/watchdog/watchdogn/pretimeout
+Date:		December 2016
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It specifies the time in seconds before
+		timeout when the pretimeout interrupt is delivered.  Pretimeout
+		is an optional feature.
+
+What:		/sys/class/watchdog/watchdogn/pretimeout_avaialable_governors
+Date:		February 2017
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read only file. It shows the pretimeout governors
+		available for this watchdog.
+
+What:		/sys/class/watchdog/watchdogn/pretimeout_governor
+Date:		February 2017
+Contact:	Wim Van Sebroeck <wim@iguana.be>
+Description:
+		It is a read/write file. When read, the currently assigned
+		pretimeout governor is returned.  When written, it sets
+		the pretimeout governor.
-- 
1.8.3.1

