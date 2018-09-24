Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A39C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BF6208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BF6208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeIXRia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:30 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33045 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728818AbeIXRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:28 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8OBY5uo010673;
        Mon, 24 Sep 2018 13:36:39 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mnb6x2dns-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Sep 2018 13:36:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC31543;
        Mon, 24 Sep 2018 11:36:38 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E6FC5650;
        Mon, 24 Sep 2018 11:36:38 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 24 Sep
 2018 13:36:38 +0200
Received: from localhost (10.201.23.97) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 24 Sep 2018 13:36:37
 +0200
From:   =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] drm: Add missing flags for pixel clock & data enable
Date:   Mon, 24 Sep 2018 13:36:20 +0200
Message-ID: <1537788981-21479-2-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537788981-21479-1-git-send-email-yannick.fertre@st.com>
References: <1537788981-21479-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.23.97]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing flags for pixel clock & data enable polarities.
These flags are similar to other synchronization signals (hsync, vsync...).

Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
---
 drivers/gpu/drm/drm_modes.c | 19 ++++++++++++++++++-
 include/uapi/drm/drm_mode.h |  6 ++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 02db9ac..596f8b3 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -130,7 +130,7 @@ EXPORT_SYMBOL(drm_mode_probed_add);
  * according to the hdisplay, vdisplay, vrefresh.
  * It is based from the VESA(TM) Coordinated Video Timing Generator by
  * Graham Loveridge April 9, 2003 available at
- * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls 
+ * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls
  *
  * And it is copied from xf86CVTmode in xserver/hw/xfree86/modes/xf86cvt.c.
  * What I have done is to translate it by using integer calculation.
@@ -611,6 +611,15 @@ void drm_display_mode_from_videomode(const struct videomode *vm,
 		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
 	if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
 		dmode->flags |= DRM_MODE_FLAG_DBLCLK;
+	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+		dmode->flags |= DRM_MODE_FLAG_PPIXCLK;
+	else if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+		dmode->flags |= DRM_MODE_FLAG_NPIXCLK;
+	if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
+		dmode->flags |= DRM_MODE_FLAG_PDATAEN;
+	else if (vm->flags & DISPLAY_FLAGS_DE_LOW)
+		dmode->flags |= DRM_MODE_FLAG_NDE;
+
 	drm_mode_set_name(dmode);
 }
 EXPORT_SYMBOL_GPL(drm_display_mode_from_videomode);
@@ -652,6 +661,14 @@ void drm_display_mode_to_videomode(const struct drm_display_mode *dmode,
 		vm->flags |= DISPLAY_FLAGS_DOUBLESCAN;
 	if (dmode->flags & DRM_MODE_FLAG_DBLCLK)
 		vm->flags |= DISPLAY_FLAGS_DOUBLECLK;
+	if (dmode->flags & DRM_MODE_FLAG_PPIXDATA)
+		vm->flags |= DISPLAY_FLAGS_PIXDATA_POSEDGE;
+	else if (dmode->flags & DRM_MODE_FLAG_NPIXDATA)
+		vm->flags |= DISPLAY_FLAGS_PIXDATA_NEGEDGE;
+	if (dmode->flags & DRM_MODE_FLAG_PDE)
+		vm->flags |= DISPLAY_FLAGS_DE_HIGH;
+	else if (dmode->flags & DRM_MODE_FLAG_NDE)
+		vm->flags |= DISPLAY_FLAGS_DE_LOW;
 }
 EXPORT_SYMBOL_GPL(drm_display_mode_to_videomode);
 
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d3e0fe3..b335a17 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -89,6 +89,12 @@ extern "C" {
 #define  DRM_MODE_FLAG_3D_TOP_AND_BOTTOM	(7<<14)
 #define  DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF	(8<<14)
 
+/* flags for polarity clock & data enable polarities */
+#define DRM_MODE_FLAG_PPIXDATA			(1 << 19)
+#define DRM_MODE_FLAG_NPIXDATA			(1 << 20)
+#define DRM_MODE_FLAG_PDE			(1 << 21)
+#define DRM_MODE_FLAG_NDE			(1 << 22)
+
 /* Picture aspect ratio options */
 #define DRM_MODE_PICTURE_ASPECT_NONE		0
 #define DRM_MODE_PICTURE_ASPECT_4_3		1
-- 
2.7.4

