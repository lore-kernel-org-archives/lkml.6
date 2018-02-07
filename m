Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeBGWpW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:45:22 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40272 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeBGWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:43:16 -0500
X-Google-Smtp-Source: AH8x224AQSR8uAiJhmV/hDXjxjRyYq9zrn8zqAqIeeH5Vsp94rdQMHiIe1N93H1Y/6PnPNtblotS/g==
From: Tim Harvey <tharvey@gateworks.com>
To: linux-media@vger.kernel.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v9 3/8] media: add digital video decoder entity function
Date: Wed,  7 Feb 2018 14:42:42 -0800
Message-Id: <1518043367-11531-4-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518043367-11531-1-git-send-email-tharvey@gateworks.com>
References: <1518043367-11531-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new media entity function definition for digital TV decoders:
MEDIA_ENT_F_DTV_DECODER

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/media/uapi/mediactl/media-types.rst | 11 +++++++++++
 include/uapi/linux/media.h                        |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/media/uapi/mediactl/media-types.rst b/Documentation/media/uapi/mediactl/media-types.rst
index 8d64b0c..195400e 100644
--- a/Documentation/media/uapi/mediactl/media-types.rst
+++ b/Documentation/media/uapi/mediactl/media-types.rst
@@ -321,6 +321,17 @@ Types and flags used to represent the media graph elements
          MIPI CSI-2, ...), and outputs them on its source pad to an output
          video bus of another type (eDP, MIPI CSI-2, parallel, ...).
 
+    -  ..  row 31
+
+       ..  _MEDIA-ENT-F-DTV-DECODER:
+
+       -  ``MEDIA_ENT_F_DTV_DECODER``
+
+       -  Digital video decoder. The basic function of the video decoder is
+	  to accept digital video from a wide variety of sources
+	  and output it in some digital video standard, with appropriate
+	  timing signals.
+
 ..  tabularcolumns:: |p{5.5cm}|p{12.0cm}|
 
 .. _media-entity-flag:
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index b9b9446..2f12328 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -110,6 +110,11 @@ struct media_device_info {
 #define MEDIA_ENT_F_VID_IF_BRIDGE		(MEDIA_ENT_F_BASE + 0x5002)
 
 /*
+ * Digital video decoder entities
+ */
+#define MEDIA_ENT_F_DTV_DECODER			(MEDIA_ENT_F_BASE + 0x6001)
+
+/*
  * Connectors
  */
 /* It is a responsibility of the entity drivers to add connectors and links */
-- 
2.7.4
