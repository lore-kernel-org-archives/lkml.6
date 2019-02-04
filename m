Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1681EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBE22087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EKro2kHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfBDOY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:28 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49884 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfBDOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14ENWPV044048;
        Mon, 4 Feb 2019 08:23:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290212;
        bh=wKcx2dLXaiJQ7mZWX/QUVBP1grt4i6qXcUpv+wF4XR0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EKro2kHFLLMt7Q5UZ/AAo9kFbgyf4Kn7V0IqKvKk6z+gm6HIh0IxjUVWwEzKm1rwh
         L9C6NFznxLL+0BAbAOe1Iv40aTBtrN2Zyix2UIZddoVmk6a8Ti7nhGx9zItgBUwvtd
         ESfykc6bljD64rZRd0fNEfoq4M9Iz+U+jaAPBRP4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14ENVTw048975
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:31 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:31 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:31 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKh012232;
        Mon, 4 Feb 2019 08:23:27 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 09/14] dt-binding: remoteproc: Add binding doc for PRU Cores in the PRU-ICSS
Date:   Mon, 4 Feb 2019 16:22:42 +0200
Message-ID: <1549290167-876-10-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The Programmable Real-Time Unit Subsystem (PRUSS) consists of
dual 32-bit RISC cores (Programmable Real-Time Units, or PRUs)
for program execution. This patch adds a remoteproc platform
driver for managing the individual PRU RISC cores life cycle.

Add DT binding documentation for that.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../bindings/remoteproc/ti,pru-rproc.txt           | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.txt
new file mode 100644
index 0000000..02dfd0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.txt
@@ -0,0 +1,56 @@
+PRU Core on TI SoCs
+===================
+
+Each PRUSS has dual PRU cores, each represented by a PRU child node. Each node
+can optionally be rendered inactive by using the standard DT string property,
+"status".
+
+Required Properties:
+--------------------
+- compatible     : should be
+                       "ti,am3356-pru" for AM335x family of SoCs
+                       "ti,am4376-pru" for AM437x family of SoCs
+                       "ti,am5728-pru" for AM57xx family of SoCs
+                       "ti,k2g-pru" for 66AK2G family of SoCs
+- reg            : base address and size for each of the 3 sub-module address
+                   spaces as mentioned in reg-names, and in the same order as
+                   the reg-names
+- reg-names      : should contain each of the following 3 names, the binding is
+                   agnostic of the order of these reg-names
+                       "iram" for Instruction RAM,
+                       "control" for the CTRL sub-module registers,
+                       "debug" for the Debug sub-module registers,
+
+- firmware-name  : should contain the name of the firmware image file
+		   located on the firmware search path. This firmware will be
+		   used as default if the Application node or User (via sysfs)
+		   doesn't provide a firmware-name.
+
+- gpcfg		 : pHandle to CFG module's syscon regmap and offset to PRU's
+		   GPCFG register.
+
+Optional Properties:
+--------------------
+The virtio based communication between the MPU and a PRU core _requires_
+either the 'mboxes' property, or the set of 'interrupt-parent', 'interrupts'
+and 'interrupt-names' properties to be defined. The latter option is the
+preferred choice. The 'mboxes' property is not applicable for 66AK2G and
+DA850/OMAP-L138 SoCs.
+
+- mboxes           : OMAP Mailbox specifier denoting the sub-mailbox, if using
+                     a mailbox for IPC signalling between host and a PRU core.
+                     The specifier format is as per the bindings,
+                         Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
+                     This property should match with the sub-mailbox node used
+                     in the corresponding firmware image.
+- interrupt-parent : phandle to the PRUSS INTC node. Should be defined if
+                     interrupts property is to be used.
+- interrupts       : array of interrupt specifiers if using PRU system events
+                     for IPC signalling between host and a PRU core. This
+                     property should match with the PRU system event used in
+                     the corresponding firmware image.
+- interrupt-names  : should use one of the following names for each interrupt,
+                     the name should match the corresponding PRU system event
+                     number,
+                         "vring" - for PRU to HOST virtqueue signalling
+                         "kick"  - for HOST to PRU virtqueue signalling
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

