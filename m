Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4607A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W8ThCd+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395048AbfBOOC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:02:56 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53402 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387546AbfBOOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:02:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FE2pML005848;
        Fri, 15 Feb 2019 08:02:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550239371;
        bh=8wzoiMOZjP0AgO9VOVI5hPO42xZBuhc+dwXZS1G6dO8=;
        h=From:To:CC:Subject:Date;
        b=W8ThCd+rmQxDKAnEJeEZ8r8/sHRe0tOOnoHqibeARw86v3DO3kjrzMb8nO+AE/NDd
         ZTPoElXbFlyDx567SrsYa9dPbpz0a1/HUbjNZkHFqEoKL1iczbCW+LLDGG1tEM5ogD
         fNls9utt/8/OJYYhXPk5TeSC/HwDDVk0y5YprKZc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FE2pRT049690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 08:02:51 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 08:02:51 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 08:02:50 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FE2mNj001839;
        Fri, 15 Feb 2019 08:02:49 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>
Subject: [PATCH 0/4] drm/panel: Support for OSD101T2045-53TS and OSD101T2587-53TS
Date:   Fri, 15 Feb 2019 16:03:11 +0200
Message-ID: <20190215140315.18046-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Add support for OSD101T2045-53TS and OSD101T2587-53TS from One Stop Displays.

The two panel is similar with one big difference: OSD101T2587-53TS requires the
MIPI_DSI_TURN_ON_PERIPHERAL message, thus can not be handled by panel-simple.

Regards,
Peter
---
Peter Ujfalusi (4):
  dt-bindings: display: Add bindings for OSD101T2045-53TS
  drm/panel: simple: Add support for OSD101T2045-53TS
  dt-bindings: display: Add bindings for OSD101T2587-53TS panel
  drm/panel: Add OSD101T2587-53TS driver

 .../display/panel/osd,osd101t2045-53ts.txt    |  11 +
 .../display/panel/osd,osd101t2587-53ts.txt    |  14 +
 drivers/gpu/drm/panel/Kconfig                 |   6 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 284 ++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  34 +++
 6 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt
 create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

