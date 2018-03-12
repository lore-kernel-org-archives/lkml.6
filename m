Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbeCLLRp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:17:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43393 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeCLLRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:17:44 -0400
X-Google-Smtp-Source: AG47ELufFYpb6xT/0UeG/c+/6gUUYdtrP4WrYblaPHsxVufetkhmbYJLBjr4+aJT0+gKUR9HuZPmZA==
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] amlogic: meson-gx-socinfo: Update soc ids
Date: Mon, 12 Mar 2018 12:17:40 +0100
Message-Id: <1520853460-6960-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the Amlogic Meson SoCs IDs for the Armv8 based SoCs.
It includes the new families and packages.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1 :
 - Merge with S905H patch
 - Add missing S905W package id
 - Fix A113D package ID with jbrunet's comment

 drivers/soc/amlogic/meson-gx-socinfo.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index f2d8c3c..9f83c0c 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -33,6 +33,10 @@ static const struct meson_gx_soc_id {
 	{ "GXL", 0x21 },
 	{ "GXM", 0x22 },
 	{ "TXL", 0x23 },
+	{ "TXLX", 0x24 },
+	{ "AXG", 0x25 },
+	{ "GXLX", 0x26 },
+	{ "TXHD", 0x27 },
 };
 
 static const struct meson_gx_package_id {
@@ -41,12 +45,18 @@ static const struct meson_gx_package_id {
 	unsigned int pack_id;
 } soc_packages[] = {
 	{ "S905", 0x1f, 0 },
+	{ "S905H", 0x1f, 0x13 },
 	{ "S905M", 0x1f, 0x20 },
 	{ "S905D", 0x21, 0 },
 	{ "S905X", 0x21, 0x80 },
+	{ "S905W", 0x21, 0xa0 },
 	{ "S905L", 0x21, 0xc0 },
 	{ "S905M2", 0x21, 0xe0 },
 	{ "S912", 0x22, 0 },
+	{ "962X", 0x24, 0x10 },
+	{ "962E", 0x24, 0x20 },
+	{ "A113X", 0x25, 0x37 },
+	{ "A113D", 0x25, 0x22 },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.7.4
