Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35066C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D1F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yo3Az20v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfBZHzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:55:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54796 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBZHzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:55:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1Q7sutc014325;
        Tue, 26 Feb 2019 01:54:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551167696;
        bh=FiCqY5eklq+mViEZBXW8F0ra0QTlW0NFDVOpsDOUipE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Yo3Az20vBjhtgngMF5kLYb2Uk/ZfbThKrU9jng1uo9+sTkIMdQodMhOQQRholTpGc
         BHT600k08/nJehEMdNUVRpFnDr1mECoNYiwm52LQZL7oy1Tvo8WGzqOtwfjax9ok/h
         OH0B78eQJqbXrrTSvodzy65EMa4GAZn5OcJ+7Rpw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1Q7suss103817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 01:54:56 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 01:54:55 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 01:54:55 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1Q7soqm016249;
        Tue, 26 Feb 2019 01:54:53 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>, <sam@ravnborg.org>
Subject: [PATCH v3 1/4] dt-bindings: display: Add bindings for OSD101T2045-53TS
Date:   Tue, 26 Feb 2019 09:55:20 +0200
Message-ID: <20190226075523.28997-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226075523.28997-1-peter.ujfalusi@ti.com>
References: <20190226075523.28997-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the device-tree bindings for the OSD101T2045-53TS 10.1"
1920x1200 panel from One Stop Displays.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/osd,osd101t2045-53ts.txt   | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt

diff --git a/Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt b/Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt
new file mode 100644
index 000000000000..b3f6df59f7c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt
@@ -0,0 +1,11 @@
+One Stop Displays OSD101T2045-53TS 10.1" 1920x1200 panel
+
+Required properties:
+- compatible: should be "osd,osd101t2045-53ts"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

