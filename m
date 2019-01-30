Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF776C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8813320870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="SsHD0Nim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfA3SOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:14:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727402AbfA3SOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:14:50 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0UICDwQ031847
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:14:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=kfkaMT2bBs1cq2Dp5zgD3taUBGLMPsX69j6ltSYwu/A=;
 b=SsHD0NimPXxFI3hTxFeO3PcSoQhTNZxWzG3GjySEz8ZithSrGWRYa+buPGvB1V4Iw6+U
 NNQjJfOEDzABkO12yn6BwKuC3NwUwkGajAOsjID3svkuWqsdeZfHNCDiRGgVZOmQdBG1
 XGYMqjT7yzDqRi8Jp8Oekk15w+t82J09IrU= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2qbh0cg09t-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:14:48 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 30 Jan 2019 10:14:30 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 759549182779; Wed, 30 Jan 2019 10:14:29 -0800 (PST)
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
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Enable VUART
Date:   Wed, 30 Jan 2019 10:14:26 -0800
Message-ID: <20190130181427.2469674-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling vuart for Facebook tiogapass

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 42e0d7a8e8d0..a058fb2985f7 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -64,6 +64,11 @@
 	status = "okay";
 };
 
+&vuart {
+	// VUART Host Console
+	status = "okay";
+};
+
 &uart1 {
 	// Host Console
 	status = "okay";
-- 
2.17.1

