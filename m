Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62AAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CA92086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jzVryKFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CA92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeKZSqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40012 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeKZSqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rJfw060729;
        Mon, 26 Nov 2018 01:53:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218799;
        bh=Yh64jBOQ6CGd9QDt1o7kjVGWBqwatvzpTmxITAnhZlQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jzVryKFUgwp4qxo2ueYJA09GlM8aUGd9Inf5A4CjNpZX5ob/DBLpN2+H9F2KJQDnJ
         HT+0kZiKEy/QHkV89XiNM6XA9tLZSP0ZsgurBokBMQ1plFUcyS46lm8X1mtYeT1moM
         O8eF/e/PYghN+Y7N5nuYMz4dyt+xbVHfUrP5NDe0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rJcM038229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:19 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:18 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:18 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rIGv019818;
        Mon, 26 Nov 2018 01:53:18 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1K024490;
        Mon, 26 Nov 2018 01:53:15 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 06/16] dt-bindings: remoteproc: ti-pruss: Update bindings for supporting rpmsg
Date:   Mon, 26 Nov 2018 09:52:39 +0200
Message-ID: <1543218769-5507-7-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543218769-5507-1-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Update the PRUSS DT bindings to add the properties required to support the
optional virtio rpmsg stack using the virtio-ring based communication
transport between MPU and a PRU core.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 .../devicetree/bindings/soc/ti/ti,pruss.txt        | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
index 24fedad..3e5f32f 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
@@ -175,6 +175,32 @@ Required Properties:
 - firmware-name  : should contain the name of the default firmware image file
                    located on the firmware search path
 
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
+
 
 MDIO Child Node
 ================
@@ -243,6 +269,9 @@ Example:
 				      <0x4a322400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am335x-pru0-fw";
+				interrupt-parent = <&pruss_intc>;
+				interrupts = <16>, <17>;
+				interrupt-names = "vring", "kick";
 			};
 
 			pru1: pru@4a338000 {
@@ -252,6 +281,10 @@ Example:
 				      <0x4a324400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am335x-pru1-fw";
+				interrupt-parent = <&pruss_intc>;
+				interrupts = <18>, <19>;
+				interrupt-names = "vring", "kick";
+				/* mboxes = <&mailbox &mbox_pru1>; */
 			};
 
 			pruss_mdio: mdio@4a332400 {
@@ -329,6 +362,9 @@ Example:
 				      <0x54422400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am437x-pru1_0-fw";
+				interrupt-parent = <&pruss1_intc>;
+				interrupts = <16>, <17>;
+				interrupt-names = "vring", "kick";
 			};
 
 			pru1_1: pru@54438000 {
@@ -338,6 +374,9 @@ Example:
 				      <0x54424400 0x100>;
 				reg-names = "iram", "control", "debug";
 				firmware-name = "am437x-pru1_1-fw";
+				interrupt-parent = <&pruss1_intc>;
+				interrupts = <18>, <19>;
+				interrupt-names = "vring", "kick";
 			};
 
 			pruss1_mdio: mdio@54432400 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

