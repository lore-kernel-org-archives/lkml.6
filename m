Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D58C65BBE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A026221477
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A026221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeJFC6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:58:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728877AbeJFC6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:58:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95JtLrc029241
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 15:57:58 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mxehnr2gb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 15:57:58 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Fri, 5 Oct 2018 15:57:56 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 5 Oct 2018 15:57:52 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w95JvprZ28442818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Oct 2018 19:57:51 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0CB912405A;
        Fri,  5 Oct 2018 16:57:43 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1DD7124055;
        Fri,  5 Oct 2018 16:57:42 -0400 (EDT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Oct 2018 16:57:42 -0400 (EDT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au,
        openbmc@lists.ozlabs.org, hverkuil@xs4all.nl, robh+dt@kernel.org,
        mchehab@kernel.org, linux-media@vger.kernel.org, joel@jms.id.au,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v4 1/2] dt-bindings: media: Add Aspeed Video Engine binding documentation
Date:   Fri,  5 Oct 2018 14:57:45 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1538769466-14860-1-git-send-email-eajames@linux.ibm.com>
References: <1538769466-14860-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18100519-0060-0000-0000-000002BBFA6D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009825; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01098369; UDB=6.00568106; IPR=6.00878409;
 MB=3.00023633; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-05 19:57:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100519-0061-0000-0000-000046BEA109
Message-Id: <1538769466-14860-2-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810050190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/aspeed-video.txt     | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt

diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
new file mode 100644
index 0000000..78b464a
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
+ - resets:		reset specifier for the syscon reset associated with
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

