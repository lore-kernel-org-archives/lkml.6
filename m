Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF05BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9943D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANOnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:43:19 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10051 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbfANOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:42:44 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EEajKo031774;
        Mon, 14 Jan 2019 15:42:39 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pybxy0gq6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 15:42:39 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BB77E31;
        Mon, 14 Jan 2019 14:42:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E3EE52AB;
        Mon, 14 Jan 2019 14:42:38 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan
 2019 15:42:38 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan 2019 15:42:37
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 1/7] devicetree: bindings: Document domains controller bindings
Date:   Mon, 14 Jan 2019 15:41:56 +0100
Message-ID: <20190114144202.27315-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190114144202.27315-1-benjamin.gaignard@st.com>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document commons domains controller bindings for controller
and client devices.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/bus/domains/domainsctrl.txt           | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/domains/domainsctrl.txt

diff --git a/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
new file mode 100644
index 000000000000..11dadba4c1fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
@@ -0,0 +1,35 @@
+Common Domains Controller bindings properties
+
+Domains Controller framework defines common bindings properties to describe
+the configurations to be applied for each device.
+
+Domains Controller bindings:
+- #domainctrl-cells	: provide the number of parameters provided with the
+			  phandle by the client device
+
+Client device node bindings:
+- domainsctrl-names	: list of strings to name the configurations.
+			  "default" and "unbind" are reserved names used by
+			  the framework.
+- domainsctrl-X		: list of configurations to be applied where X is
+			  the index of the configuration within the node.
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

