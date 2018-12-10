Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD0CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDDB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="OJZGT9mR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDDB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeLJUIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:08:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42160 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbeLJUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:08:29 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAK482B032718
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:08:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=vDMHH7kVNxyVk8Fng38m06gHInfn+XQCbFE45M2pZ6c=;
 b=OJZGT9mRI4/dSS7aCZXqMfimSWOa4kgjSWGbBXCKfLGpRIc7kEBjbBoh2HUQC0RpEeSw
 W7CB5kNww351G6jYu8VJx5e3fCSAZkzdsnKCKKvAdivqfHl+Mp/wJXbdX9gdxKRmX58R
 pI+a2HQhHHWiJhZybMLkxj3Dkg1Dgm1bc2c= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9vdprmc6-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:08:28 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 10 Dec 2018 12:08:18 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id ED1B04BDB0A3; Mon, 10 Dec 2018 12:08:15 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 2/2] ARM: dts: aspeed: Add KCS support for LPC BMC
Date:   Mon, 10 Dec 2018 12:07:53 -0800
Message-ID: <20181210200753.3018124-3-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210200753.3018124-1-vijaykhemka@fb.com>
References: <20181210200753.3018124-1-vijaykhemka@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added kcs device support for lpc BMC.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d107459fc0f8..1bd48655bacb 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -330,8 +330,35 @@
 				ranges = <0x0 0x1e789000 0x1000>;
 
 				lpc_bmc: lpc-bmc@0 {
-					compatible = "aspeed,ast2500-lpc-bmc";
+					compatible = "aspeed,ast2500-lpc-bmc, "simple-mfd", "syscon"";
 					reg = <0x0 0x80>;
+					reg-io-width = <4>;
+
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0x0 0x0 0x80>;
+
+					kcs1: kcs1@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <1>;
+						status = "disabled";
+					};
+					kcs2: kcs2@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <2>;
+						status = "disabled";
+					};
+					kcs3: kcs3@0 {
+						compatible = "aspeed,ast2500-kcs-bmc";
+						reg = <0x0 0x80>;
+						interrupts = <8>;
+						kcs_chan = <3>;
+						status = "disabled";
+					};
 				};
 
 				lpc_host: lpc-host@80 {
-- 
2.17.1

