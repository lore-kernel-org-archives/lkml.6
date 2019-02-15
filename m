Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712FD218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q7DLASQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395071AbfBOODA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:03:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41572 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfBOOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:02:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FE2sbW102072;
        Fri, 15 Feb 2019 08:02:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550239374;
        bh=Mu+XSF/NvW5DBqo5ZK5JGGo1czM1xr1qMc0mAB3mgE4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q7DLASQc1eVgKirK/UFn6BJd2cYaKdhVNicylBiDpeC6u4aujk0OpdF84+Gu2zZI4
         obqaBXxTjuOFStATDo7FHYYSt8mbGzyneCrtoB+WcjOycH3G5IGif7ugXkae+S2jhj
         4jFLhzvXDJMmDScJ+tzhxmaxJPxZtby358WvSiqA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FE2s26017385
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 08:02:54 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 08:02:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 08:02:53 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FE2mNk001839;
        Fri, 15 Feb 2019 08:02:51 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>
Subject: [PATCH 1/4] dt-bindings: display: Add bindings for OSD101T2045-53TS
Date:   Fri, 15 Feb 2019 16:03:12 +0200
Message-ID: <20190215140315.18046-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215140315.18046-1-peter.ujfalusi@ti.com>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
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

