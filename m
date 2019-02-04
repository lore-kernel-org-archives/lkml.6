Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E822082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gvNp3Ad7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfBDPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:55:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58638 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfBDPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:55:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14Fs8kW050028;
        Mon, 4 Feb 2019 09:54:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549295648;
        bh=7XIKbA+SuSh0yU8UNFz9F69GDO1qdn7kJ4Z9VhkYcm0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gvNp3Ad7jd2B9xzO4DNmzj6mK7beaWPj+TD7EsMzBsbincJwi7oer/2L+EwWFQLfv
         /xTmukgxgy1RZP0TgGi4c8rFFb6LrYM31C3vmH5EnAFhnDcyyJZBVVPFt5LIrsiVvm
         WLBEkJTHYMVrIFoJsn9hxM+amX/P0AD00+zK+BVk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14Fs8jH040312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 09:54:08 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 09:54:08 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 09:54:08 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14Fs1mM012077;
        Mon, 4 Feb 2019 09:54:05 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <s-anna@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/4] dt-binding: bus: ti-sysc: Add support for PRUSS SYSC type
Date:   Mon, 4 Feb 2019 17:53:54 +0200
Message-ID: <1549295637-24890-2-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549295637-24890-1-git-send-email-rogerq@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PRUSS module has a SYSCFG which is unique. Add
support for it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.txt |  1 +
 include/dt-bindings/bus/ti-sysc.h                 | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
index 85a23f5..fe1dfb1 100644
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -38,6 +38,7 @@ Required standard properties:
 		"ti,sysc-dra7-mcasp"
 		"ti,sysc-usb-host-fs"
 		"ti,sysc-dra7-mcan"
+		"ti,sysc-pruss"
 
 - reg		shall have register areas implemented for the interconnect
 		target module in question such as revision, sysc and syss
diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
index 7138384..8ec78e8 100644
--- a/include/dt-bindings/bus/ti-sysc.h
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -17,6 +17,17 @@
 
 #define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
 
+/* SYSCONFIG specific to PRUSS */
+#define SYSC_PRUSS_SUB_MWAIT		(1 << 5)
+#define SYSC_PRUSS_STANDBY_INIT		(1 << 4)
+
+#define SYSC_PRUSS_STANDBY_FORCE	(0 << 2)
+#define SYSC_PRUSS_STANDBY_NO		(1 << 2)
+#define SYSC_PRUSS_STANDBY_SMART	(2 << 2)
+#define SYSC_PRUSS_STANDBY_MASK		(3 << 2)
+
+#define SYSC_PRUSS_IDLE_MASK		3
+
 /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
 #define SYSC_IDLE_FORCE			0
 #define SYSC_IDLE_NO			1
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

