Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeBHO0u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:26:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40071 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeBHO0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:26:48 -0500
From: Colin King <colin.king@canonical.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: ocelot: make function ocelot_pinctrl_probe static
Date: Thu,  8 Feb 2018 14:24:37 +0000
Message-Id: <20180208142437.11217-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function ocelot_pinctrl_probe is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/pinctrl/pinctrl-ocelot.c:465:5: warning: symbol
'ocelot_pinctrl_probe' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 01a50d969111..a9423238471e 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -462,7 +462,7 @@ static const struct of_device_id ocelot_pinctrl_of_match[] = {
 	{},
 };
 
-int ocelot_pinctrl_probe(struct platform_device *pdev)
+static int ocelot_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ocelot_pinctrl *info;
-- 
2.15.1
