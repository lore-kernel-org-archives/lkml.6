Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7D72075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bzrxQ7Vv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfBVNQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:16:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59180 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBVNQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:16:14 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1MDFwRq124755;
        Fri, 22 Feb 2019 07:15:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550841358;
        bh=Nn4hVgxKm7a3r3KGo2Xx3wsvE14ks82lETKi7iwfweA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bzrxQ7VvfVHwv98vL0xK4U+oKu8ckiFyRK3r6f1nYQQRM8qSomKe30lmcmoMbR/dc
         ApkHp/ZEm9G8mkK47G32bpBYGfgT6ryajMD9BUA4nLm4qbtKriRP3jG8vNXNptClBb
         cjAegbfGfzAPrOW3rl2uAgBscGsQJ+ebBvpfRW2U=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1MDFwsD014045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Feb 2019 07:15:58 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 22
 Feb 2019 07:15:58 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 22 Feb 2019 07:15:58 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1MDFlwD016867;
        Fri, 22 Feb 2019 07:15:55 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>, <sam@ravnborg.org>
Subject: [PATCH v2 3/4] dt-bindings: display: Add bindings for OSD101T2587-53TS panel
Date:   Fri, 22 Feb 2019 15:16:17 +0200
Message-ID: <20190222131618.20520-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222131618.20520-1-peter.ujfalusi@ti.com>
References: <20190222131618.20520-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the device-tree bindings for the OSD101T2587-53TS 10.1"
1920x1200 panel from One Stop Displays.

Note: the panel is similar to OSD101T2045-53TS, but it needs additional
MIPI_DSI_TURN_ON_PERIPHERAL message from the host.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../display/panel/osd,osd101t2587-53ts.txt         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt

diff --git a/Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt b/Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt
new file mode 100644
index 000000000000..2082cae1a0e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt
@@ -0,0 +1,14 @@
+One Stop Displays OSD101T2587-53TS 10.1" 1920x1200 panel
+
+The panel is similar to OSD101T2045-53TS, but it needs additional
+MIPI_DSI_TURN_ON_PERIPHERAL message from the host.
+
+Required properties:
+- compatible: should be "osd,osd101t2587-53ts"
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

