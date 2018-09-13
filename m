Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC7C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22102086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22102086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeINAkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:40:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeINAkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:40:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8DJTPox103972
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:29:38 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mfwrsrnx5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:29:37 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 13 Sep 2018 13:29:37 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Sep 2018 13:29:32 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8DJTWZg42270792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Sep 2018 12:29:32 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0879B7805F;
        Thu, 13 Sep 2018 13:29:32 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F3FD7805E;
        Thu, 13 Sep 2018 13:29:30 -0600 (MDT)
Received: from oc6728276242.ibm.com (unknown [9.85.164.21])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Sep 2018 13:29:30 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] dt-bindings: media: Add Aspeed Video Engine binding documentation
Date:   Thu, 13 Sep 2018 14:29:23 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536866964-71593-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1536866964-71593-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091319-0004-0000-0000-000014896B7A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009715; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087845; UDB=6.00561774; IPR=6.00867856;
 MB=3.00023274; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-13 19:29:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091319-0005-0000-0000-000088CCE62F
Message-Id: <1536866964-71593-2-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809130196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 .../devicetree/bindings/media/aspeed-video.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt

diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
new file mode 100644
index 0000000..f1af528
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
@@ -0,0 +1,26 @@
+* Device tree bindings for Aspeed Video Engine
+
+The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs can
+capture and compress video data from digital or analog sources.
+
+Required properties:
+ - compatible:		"aspeed,ast2400-video-engine" or
+			"aspeed,ast2500-video-engine"
+ - reg:			contains the offset and length of the VE memory region
+ - clocks:		clock specifiers for the syscon clocks associated with
+			the VE (ordering must match the clock-names property)
+ - clock-names:		"vclk" and "eclk"
+ - resets:		reset specifier for the syscon reset associaated with
+			the VE
+ - interrupts:		the interrupt associated with the VE on this platform
+
+Example:
+
+video-engine@1e700000 {
+    compatible = "aspeed,ast2500-video-engine";
+    reg = <0x1e700000 0x20000>;
+    clocks = <&syscon ASPEED_CLK_GATE_VCLK>, <&syscon ASPEED_CLK_GATE_ECLK>;
+    clock-names = "vclk", "eclk";
+    resets = <&syscon ASPEED_RESET_VIDEO>;
+    interrupts = <7>;
+};
-- 
1.8.3.1

