Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E82BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0BC2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfB0MNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:13:07 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:2757 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729822AbfB0MNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:13:02 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RC8kN8019402;
        Wed, 27 Feb 2019 13:12:45 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2qtvh3pd6u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Feb 2019 13:12:45 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 944D131;
        Wed, 27 Feb 2019 12:12:44 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D7335266;
        Wed, 27 Feb 2019 12:12:44 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 13:12:44 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb 2019 13:12:43
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <fabio.estevam@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <benjamin.gaignard@linaro.org>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/7] devicetree: bindings: Document domains controller bindings
Date:   Wed, 27 Feb 2019 13:12:26 +0100
Message-ID: <20190227121232.24873-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190227121232.24873-1-benjamin.gaignard@st.com>
References: <20190227121232.24873-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document commons domains controller bindings for controller
and client devices.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/bus/domains/domainsctrl.txt           | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/domains/domainsctrl.txt

diff --git a/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
new file mode 100644
index 000000000000..f82e5e11ea64
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
@@ -0,0 +1,55 @@
+Common Domains Controller bindings properties
+
+Bus domains controllers allow to divided system on chip into multiple domains
+that can be used to select by who hardware blocks could be accessed.
+A domain could be a cluster of CPUs (or coprocessors), a range of addresses or
+a group of hardware blocks.
+
+This device tree bindings can be used to bind bus domain consumer devices with
+their bus domains provided by bus domains controllers. A bus domain provider
+can be represented by any node in the device tree and can provide one or more
+bus domains. A consumer node can refer to the provider by a phandle and a set
+of phandle arguments of length specified by the #domainctrl-cells property in
+the bus domain provider node.
+
+==Bus domain provider==
+
+Required properties:
+- #domainctrl-cells	: Number of cells in a bus domain specifier;
+			  Can be any value as specified by device tree binding
+			  documentation of a particular provider.
+
+==Bus domain consumer==
+
+Required properties:
+- domainsctrl-X		: A list of bus domain specifiers, as defined by
+			  bindings of the bus domain controller that is the
+			  bus domain provider.
+
+Optional properties:
+- domainsctrl-names	: A list of bus domain name string sorted in the same
+			  order as the domainsctrl-X proprerties. Consumer
+			  drivers will use domainsctrl-names to match bus
+			  domains with bus domains specifiers.
+			  Note that "default" and "unbind" are reserved names
+			  used by the framework.
+
+Example of usage with:
+- a domains controller with a 2 parameters cell
+- a domains controller with a 3 parameters cell
+- a client device node using the both controllers and 2 configurations
+  named "default" and "unbind"
+
+ctrl0: ctrl@0 {
+	#domainctrl-cells = <2>;
+};
+
+ctrl1: ctrl@1 {
+	#domainctrl-cells = <3>;
+};
+
+foo@0 {
+	domains-names = "default", "unbind";
+	domainctrl-0 = <&ctrl0 1 2>, <&ctrl1 3 4 5>;
+	domainctrl-1 = <&ctrl0 6 7>, <&ctrl1 8 9 0>;
+};
-- 
2.15.0

