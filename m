Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0F3218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nr6ai6wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395097AbfBOODD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:03:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37310 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfBOODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:03:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FE2wZc004439;
        Fri, 15 Feb 2019 08:02:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550239378;
        bh=Nn4hVgxKm7a3r3KGo2Xx3wsvE14ks82lETKi7iwfweA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nr6ai6wIZfvioWDFIVUHfM0pg9Omw0ecFx8qVCLmuORZaJ0winw7Nl9PH2LIfGBuo
         of7DpqYlKiewgMboKPJ2keoZ+ZuKZrOoFY2BMf9S3i21J5n7jNCRC+8yaMJ6Wjycxa
         jhznWMlK663WUXmH6rQ9FMY2VIltpJWxz2EfkPKw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FE2wI7096265
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 08:02:58 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 08:02:57 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 08:02:57 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FE2mNm001839;
        Fri, 15 Feb 2019 08:02:55 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] dt-bindings: display: Add bindings for OSD101T2587-53TS panel
Date:   Fri, 15 Feb 2019 16:03:14 +0200
Message-ID: <20190215140315.18046-4-peter.ujfalusi@ti.com>
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

