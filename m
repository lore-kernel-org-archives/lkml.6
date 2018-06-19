Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C12C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B052083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B052083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emtrion.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757054AbeFSKBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:01:43 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:15925 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756590AbeFSKBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:01:40 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 06:01:37 EDT
Received: from tuelinux-v3.emtrion.local (2003:5a:a012:1:7eac:eac5:fc1b:7f56)
 by bmk019s01.emtrion.local (2003:5a:a012:1:d9c:d045:28a7:5f84) with Microsoft
 SMTP Server (TLS) id 8.3.485.1; Tue, 19 Jun 2018 11:56:10 +0200
From:   <jan.tuerk@emtrion.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] drm/panel: Add support for the EDT ETM0700G0BDH6
Date:   Tue, 19 Jun 2018 11:55:44 +0200
Message-ID: <20180619095546.24445-2-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619095546.24445-1-jan.tuerk@emtrion.com>
References: <20180427132445.3458-2-jan.tuerk@emtrion.com>
 <20180619095546.24445-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23916.005
X-TM-AS-Result: No--6.713400-8.000000-31
X-TM-AS-MatchedID: 700378-702796-704171-702358-702609-700156-862004-702311-1
        88019-706290-703529-700008-700264-700802-702791-708712-148004-148036-42000-
        42003-55
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

The Emerging Display Technology ETM0700G0BDH6 is exactly
the same display as the ETM0700G0DH6, exept the pixelclock
polarity. Therefore re-use the ETM0700G0DH6 modes. It is
used by default on emtrion Avari based development kits.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index cbf1ab404ee7..8b7feb2888f2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -909,6 +909,18 @@ static const struct panel_desc edt_etm0700g0dh6 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 };
 
+static const struct panel_desc edt_etm0700g0bdh6 = {
+	.modes = &edt_etm0700g0dh6_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
+};
+
 static const struct drm_display_mode foxlink_fl500wvr00_a0t_mode = {
 	.clock = 32260,
 	.hdisplay = 800,
@@ -2133,6 +2145,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "edt,etm0700g0dh6",
 		.data = &edt_etm0700g0dh6,
+	}, {
+		.compatible = "edt,etm0700g0bdh6",
+		.data = &edt_etm0700g0bdh6,
 	}, {
 		.compatible = "foxlink,fl500wvr00-a0t",
 		.data = &foxlink_fl500wvr00_a0t,
-- 
2.17.1

