Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16092173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lH1E2/oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16092173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeI1LsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:48:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38634 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeI1LsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:48:07 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8S5PTsg054842;
        Fri, 28 Sep 2018 00:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538112329;
        bh=AEfsXMvy3cqdwmEUPDDQcp7lcq78C3iQ3zg71bqyr+U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lH1E2/oGmafLCXhTPj6/mo8jnx1xAmiGsP7EEkbjlF/7oBRR5yaU7eRwfTp4aCDKp
         O2tJhQCcurbGzNj+nyxij9Mcabb1+CJ3dMTYhQeS9G4RL6lYQuMlJbYBHu37VTSVEW
         TC+VVP4USCz4VkdGv/6H7tuI5+l5fQvyvvmHRgh4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5PTxv013579;
        Fri, 28 Sep 2018 00:25:29 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 00:25:28 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 00:25:28 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5PMGp012173;
        Fri, 28 Sep 2018 00:25:26 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>, Peter Rosin <peda@axentia.se>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/2] dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
Date:   Fri, 28 Sep 2018 10:55:56 +0530
Message-ID: <20180928052557.21663-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928052557.21663-1-vigneshr@ti.com>
References: <20180928052557.21663-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 SoCs have same I2C IP as OMAP SoCs. Add new compatible to
handle AM654 SoCs. While at that reformat the existing compatible list
for older SoCs to list one valid compatible per line.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2: Reformat compatible existing compatible list.

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
index 7e49839d4124..4b90ba9f31b7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -1,8 +1,12 @@
 I2C for OMAP platforms
 
 Required properties :
-- compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
-  or "ti,omap4-i2c"
+- compatible : Must be
+	"ti,omap2420-i2c" for OMAP2420 SoCs
+	"ti,omap2430-i2c" for OMAP2430 SoCs
+	"ti,omap3-i2c" for OMAP3 SoCs
+	"ti,omap4-i2c" for OMAP4+ SoCs
+	"ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
2.19.0

