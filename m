Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE13C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB2520663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tHXQ6/ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB2520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeKZSrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:47:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41014 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeKZSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:47:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rh9k043570;
        Mon, 26 Nov 2018 01:53:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218823;
        bh=Wq3rx3PYsI4iFiwTWmGf7b0qeZ/uiC62qdIe0NzgMmM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tHXQ6/ih2Qi5WQozISuk6viTXN2cIbNfweHBXVdBdDonfKUK2ARQUw6Hz+mF1NHkU
         27VZ/uB20NNl10pckTSAAhynn8kkKWaLa2g3xCindPIWs8NGL7ZSu7cc/C8q6mfhc3
         F9yp08qCTq88lou35+jNWkKunDo/wbJ99CMqlYFU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rhOU059915
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:43 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:43 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:43 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rh2U007296;
        Mon, 26 Nov 2018 01:53:43 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1Q024490;
        Mon, 26 Nov 2018 01:53:39 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 12/16] dt-bindings: remoteproc: ti-pruss: Document application node bindings
Date:   Mon, 26 Nov 2018 09:52:45 +0200
Message-ID: <1543218769-5507-13-git-send-email-rogerq@ti.com>
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

From: Tero Kristo <t-kristo@ti.com>

Add documentation for the Texas Instruments PRU application nodes.
These are used to configure specific user applications for PRU instances.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[s-anna@ti.com: some binding updates]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/soc/ti/ti,pruss.txt        | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
index 3e5f32f..94c91ee 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
@@ -210,6 +210,38 @@ used in TI Davinci SoCs. Please refer to the corresponding binding document,
 Documentation/devicetree/bindings/net/davinci-mdio.txt for details.
 
 
+Application/User Nodes
+=======================
+A PRU application/user node typically uses one or more PRU device nodes to
+implement a PRU application/functionality. Each application/client node would
+need a reference to at least a PRU node, and optionally pass some configuration
+parameters.
+
+Required Properties:
+--------------------
+- prus                 : phandles to the PRU nodes used
+
+Optional Properties:
+--------------------
+- firmware-name        : firmwares for the PRU cores, the default firmware
+                         for the core from the PRU node will be used if not
+                         provided. The firmware names should correspond to
+                         the PRU cores listed in the 'prus' property
+- ti,pruss-gp-mux-sel  : array of values for the GP_MUX_SEL under PRUSS_GPCFG
+                         register for a PRU. This selects the internal muxing
+                         scheme for the PRU instance. If not provided, the
+                         default out-of-reset value (0) for the PRU core is
+                         used. Values should correspond to the PRU cores listed
+                         in the 'prus' property
+- ti,pru-interrupt-map : PRU interrupt mappings, containing an array of entries
+                         with each entry consisting of 4 cell-values. First one
+                         is an index towards the "prus" property to identify the
+                         PRU core for the interrupt map, second is the PRU
+                         System Event id, third is the PRU interrupt channel id
+                         and fourth is the PRU host interrupt id. If provided,
+                         this map will supercede any other configuration
+                         provided through firmware
+
 Example:
 ========
 1.	/* AM33xx PRU-ICSS */
@@ -397,3 +429,14 @@ Example:
 			...
 		};
 	};
+
+3:	/* PRU application node example */
+	app_node: app_node {
+		prus = <&pru1_0>, <&pru1_1>;
+		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
+		ti,pruss-gp-mux-sel = <2>, <1>;
+		/* setup interrupts for prus:
+		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
+		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
+		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
+	}
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

