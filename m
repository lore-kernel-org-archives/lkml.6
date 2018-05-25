Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936107AbeEYNwt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:52:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34517 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936015AbeEYNwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:52:45 -0400
X-Google-Smtp-Source: ADUXVKIO+Vca/SjVSDe7aY4jSY7i1dVvxCSxyaS20A3dyIoW0y2XwKdlh8nQ2wqo4fRSiRbII1xQig==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] regmap: slimbus: allow register offsets up to 16 bits
Date: Fri, 25 May 2018 14:50:37 +0100
Message-Id: <20180525135037.30638-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180525135037.30638-1-srinivas.kandagatla@linaro.org>
References: <20180525135037.30638-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per SLIMBus specs Value Elements and Information Elements
address map ranges from 0x000 - 0xFFF.

So allow register addresses up to 16 bits

Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap-slimbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index c90bee81d954..91d501eda8a9 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -41,7 +41,7 @@ static struct regmap_bus regmap_slimbus_bus = {
 static const struct regmap_bus *regmap_get_slimbus(struct slim_device *slim,
 					const struct regmap_config *config)
 {
-	if (config->val_bits == 8 && config->reg_bits == 8)
+	if (config->val_bits == 8 && config->reg_bits == 16)
 		return &regmap_slimbus_bus;
 
 	return ERR_PTR(-ENOTSUPP);
-- 
2.16.2
