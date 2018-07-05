Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D33CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADB92403B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADB92403B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeGENdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:33:22 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41218 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753273AbeGENdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:18 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id DDDC7CD49;
        Thu,  5 Jul 2018 16:33:16 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 02/34] media: v4l: Add new 2X8 10-bit grayscale media bus code
Date:   Thu,  5 Jul 2018 16:32:33 +0300
Message-Id: <1530797585-8555-3-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code will be called MEDIA_BUS_FMT_Y10_2X8_PADHI_LE.
It is similar to MEDIA_BUS_FMT_SBGGR10_2X8_PADHI_LE
but MEDIA_BUS_FMT_Y10_2X8_PADHI_LE describes grayscale
data.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 Documentation/media/uapi/v4l/subdev-formats.rst | 72 +++++++++++++++++++++++++
 include/uapi/linux/media-bus-format.h           |  3 +-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/Documentation/media/uapi/v4l/subdev-formats.rst b/Documentation/media/uapi/v4l/subdev-formats.rst
index a4739f7..8e73fcf 100644
--- a/Documentation/media/uapi/v4l/subdev-formats.rst
+++ b/Documentation/media/uapi/v4l/subdev-formats.rst
@@ -4318,6 +4318,78 @@ the following codes.
       - y\ :sub:`2`
       - y\ :sub:`1`
       - y\ :sub:`0`
+    * .. _MEDIA-BUS-FMT-Y10-2X8-PADHI_LE:
+
+      - MEDIA_BUS_FMT_Y10_2X8_PADHI_LE
+      - 0x202c
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      - y\ :sub:`7`
+      - y\ :sub:`6`
+      - y\ :sub:`5`
+      - y\ :sub:`4`
+      - y\ :sub:`3`
+      - y\ :sub:`2`
+      - y\ :sub:`1`
+      - y\ :sub:`0`
+    * -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      - 0
+      - 0
+      - 0
+      - 0
+      - 0
+      - 0
+      - y\ :sub:`9`
+      - y\ :sub:`8`
     * .. _MEDIA-BUS-FMT-UYVY10-2X10:
 
       - MEDIA_BUS_FMT_UYVY10_2X10
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index 9e35117..d6a5a3b 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -62,7 +62,7 @@
 #define MEDIA_BUS_FMT_RGB121212_1X36		0x1019
 #define MEDIA_BUS_FMT_RGB161616_1X48		0x101a
 
-/* YUV (including grey) - next is	0x202c */
+/* YUV (including grey) - next is	0x202d */
 #define MEDIA_BUS_FMT_Y8_1X8			0x2001
 #define MEDIA_BUS_FMT_UV8_1X8			0x2015
 #define MEDIA_BUS_FMT_UYVY8_1_5X8		0x2002
@@ -74,6 +74,7 @@
 #define MEDIA_BUS_FMT_YUYV8_2X8			0x2008
 #define MEDIA_BUS_FMT_YVYU8_2X8			0x2009
 #define MEDIA_BUS_FMT_Y10_1X10			0x200a
+#define MEDIA_BUS_FMT_Y10_2X8_PADHI_LE		0x202c
 #define MEDIA_BUS_FMT_UYVY10_2X10		0x2018
 #define MEDIA_BUS_FMT_VYUY10_2X10		0x2019
 #define MEDIA_BUS_FMT_YUYV10_2X10		0x200b
-- 
2.7.4

