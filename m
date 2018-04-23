Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbeDWMmt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:42:49 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34815 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754994AbeDWMl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:41:56 -0400
X-Google-Smtp-Source: AB8JxZoesh+VkmZHvJSk4kvuK/wihHaImIWzMIPl/SIPJcB/9/mkfZElh1JJNLWY8fkGK5bobGvFog==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] nvmem: meson-efuse: simplify read callback
Date: Mon, 23 Apr 2018 14:41:48 +0200
Message-Id: <20180423124149.3077-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180423124149.3077-1-jbrunet@baylibre.com>
References: <20180423124149.3077-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the code and variables in the read callback is not necessary.
Keep only what is required.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 2df9b0094f45..4623249dfd87 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -24,15 +24,8 @@
 static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
-	u8 *buf = val;
-	int ret;
-
-	ret = meson_sm_call_read(buf, bytes, SM_EFUSE_READ, offset,
-				 bytes, 0, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return meson_sm_call_read((u8 *)val, bytes, SM_EFUSE_READ, offset,
+				  bytes, 0, 0, 0);
 }
 
 static const struct of_device_id meson_efuse_match[] = {
-- 
2.14.3
