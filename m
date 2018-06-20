Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E5DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6D320875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6D320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbeFTMXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:23:18 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8595 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbeFTMVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2a46b90000>; Wed, 20 Jun 2018 05:21:13 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Jun 2018 05:21:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Jun 2018 05:21:11 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 12:21:10 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 20 Jun 2018 12:21:10 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b2a46b30001>; Wed, 20 Jun 2018 05:21:09 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 2/8] dt-bindings: serial: Add bindings for nvidia,tegra194-tcu
Date:   Wed, 20 Jun 2018 15:20:36 +0300
Message-ID: <20180620122042.10950-3-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180620122042.10950-1-mperttunen@nvidia.com>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Tegra Combined UART device used to talk to the
UART console on Tegra194 systems.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2:
    - Added Rob's Reviewed-by.

 .../bindings/serial/nvidia,tegra194-tcu.txt        | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
new file mode 100644
index 000000000000..a8becf6efd2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra194-tcu.txt
@@ -0,0 +1,35 @@
+NVIDIA Tegra Combined UART (TCU)
+
+The TCU is a system for sharing a hardware UART instance among multiple
+systems within the Tegra SoC. It is implemented through a mailbox-
+based protocol where each "virtual UART" has a pair of mailboxes, one
+for transmitting and one for receiving, that is used to communicate
+with the hardware implementing the TCU.
+
+Required properties:
+- name : Should be tcu
+- compatible
+    Array of strings
+    One of:
+    - "nvidia,tegra194-tcu"
+- mbox-names:
+    "rx" - Mailbox for receiving data from hardware UART
+    "tx" - Mailbox for transmitting data to hardware UART
+- mboxes: Mailboxes corresponding to the mbox-names. 
+
+This node is a mailbox consumer. See the following files for details of
+the mailbox subsystem, and the specifiers implemented by the relevant
+provider(s):
+
+- .../mailbox/mailbox.txt
+- .../mailbox/nvidia,tegra186-hsp.txt
+
+Example bindings:
+-----------------
+
+tcu: tcu {
+	compatible = "nvidia,tegra194-tcu";
+	mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
+	         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
+	mbox-names = "rx", "tx";
+};
-- 
2.16.1

