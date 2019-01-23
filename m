Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B72BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF55621019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Puf/wGkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfAWXHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:07:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbfAWXHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:07:38 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NN1N9A029227
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:07:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=mw2Se00uQPELWHjBZyhQPnW3g6bdq8Gqz6xg7vQx+UQ=;
 b=Puf/wGkUlgCL02rBFrfdRU2MGYaU5EjRSygEwYmhdCmyYpMOm+pAqSDhzGR/pwfAWzWv
 tnBSxHAtMy0tx66AG18hV/UR122jqXllWSXJR2WYjbN9DGF5tIseW4vZ1TQUnz1VzD1z
 9iTI6d8f4Q1xT7Q2WSAqCjX/Q0qS01bIiho= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q6ysrgc10-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:07:37 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 23 Jan 2019 15:07:36 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 44BA7861B078; Wed, 23 Jan 2019 15:07:36 -0800 (PST)
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
Subject: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
Date:   Wed, 23 Jan 2019 15:07:32 -0800
Message-ID: <20190123230733.1821501-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added lpc control for enabling lpc clock, peci for cpu sensors and lpc
snoop devices to Facebook Tiogapass device tree.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 73e58a821613..d60dbb019f82 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -54,6 +54,16 @@
 	};
 };
 
+&lpc_snoop {
+	status = "okay";
+	snoop-ports = <0x80>;
+};
+
+&lpc_ctrl {
+	// Enable lpc clock
+	status = "okay";
+};
+
 &uart1 {
 	// Host Console
 	status = "okay";
@@ -67,6 +77,10 @@
 	status = "okay";
 };
 
+&peci0 {
+	status = "okay";
+};
+
 &kcs2 {
 	// BMC KCS channel 2
 	status = "okay";
-- 
2.17.1

