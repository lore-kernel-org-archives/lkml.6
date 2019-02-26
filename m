Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83664C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542262173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xGnLV8BH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBZHzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:55:06 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53650 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBZHzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:55:05 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1Q7ssT2124933;
        Tue, 26 Feb 2019 01:54:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551167694;
        bh=iIzeLFAM8RHgvq6G8ROmpFBCEjEpFRw6AAvsvktaLXY=;
        h=From:To:CC:Subject:Date;
        b=xGnLV8BHAtsJI0qIe0n5cLzp1DhizNYQfHG08nwEUxFuTPKZJe5jUOTqL2qveDerQ
         AeRp6MtjLWnHFiV9s5J7BHczfJgFsAl4OpIzDXAH2q3GTuIeRNnPyOI3rv2NhTdiO9
         /UcDHAf8woVymmF2PWQO4KEr6i9tjkpQ04cv3jlA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1Q7ssgb055570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 01:54:54 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 01:54:52 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 01:54:52 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1Q7soql016249;
        Tue, 26 Feb 2019 01:54:50 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <tomi.valkeinen@ti.com>, <sam@ravnborg.org>
Subject: [PATCH v3 0/4] drm/panel: Support for OSD101T2045-53TS and OSD101T2587-53TS
Date:   Tue, 26 Feb 2019 09:55:19 +0200
Message-ID: <20190226075523.28997-1-peter.ujfalusi@ti.com>
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

Changes since v2:
- Added Reviewed-by from Rob to the binding patches
- Added help text to Kconfig (osd101t2587-53ts)
- Print the error values in dev_err/warn
- Added Reviewed-by from Sam to the osd101t2587-53ts patch

Changes since v1 (only panel-osd-osd101t2587-53ts changed):
- Removed unused members from struct osd101t2587_panel
- Use backlight_enable/backlight_disable
- Use devm_of_find_backlight()
- osd101t2587_of_match table standardized 
- osd101t2587_panel_unprepare() added to shutdown and remove callbacks to turn
  power off
- Fix probe in case mipi_dsi_attach() would fail

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
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 254 ++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  34 +++
 6 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt
 create mode 100644 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

