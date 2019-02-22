Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE612075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kdwq3GXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfBVNQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:16:08 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59140 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVNQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:16:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1MDFrKs124719;
        Fri, 22 Feb 2019 07:15:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550841353;
        bh=Mu+XSF/NvW5DBqo5ZK5JGGo1czM1xr1qMc0mAB3mgE4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Kdwq3GXdKN+FDOLPSZ0DzRBqxlglIlZ9lRZgQZrBQu3+E1SfqzfJUb3E7/gJXDW0A
         6e72Nl3WKHrHEistbBdnlpj3F2NmRzbXtRaZ1YOwdju+b1dgPFQjB28GcaHJkzBfUe
         wvJSwZ9zH/52eDeLR0b+XHA55b4e6djn0DDL7HF0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1MDFr9b055059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Feb 2019 07:15:53 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 22
 Feb 2019 07:15:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 22 Feb 2019 07:15:52 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1MDFlwB016867;
        Fri, 22 Feb 2019 07:15:50 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>, <sam@ravnborg.org>
Subject: [PATCH v2 1/4] dt-bindings: display: Add bindings for OSD101T2045-53TS
Date:   Fri, 22 Feb 2019 15:16:15 +0200
Message-ID: <20190222131618.20520-2-peter.ujfalusi@ti.com>
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

