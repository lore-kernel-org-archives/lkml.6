Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966334AbeE2THH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 15:07:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43279 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965311AbeE2THD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 15:07:03 -0400
X-Google-Smtp-Source: AB8JxZrBNh0lMuHKPIO+Azan73DMHb73fX6abINfv1i6y8xczkkYFw3HPikyfptESK5T5LZoG/w6rA==
Date: Tue, 29 May 2018 12:06:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benson Leung <bleung@chromium.org>
Cc: Sultan Alsawaf <sultanxda@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: chromeos_laptop: fix touchpad button
 mapping on Celes
Message-ID: <20180529190659.GA261828@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Celes has newer touch controller (compared to the controllers used in
older BayTrail-based devices) and so uses the same button mapping as
Samus.

This fixes the issue with mouse button being stuck in pressed state
after the first click.

Reported-by: Sultan Alsawaf <sultanxda@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/chrome/chromeos_laptop.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/chromeos_laptop.c b/drivers/platform/chrome/chromeos_laptop.c
index 3cecf7933f751..24326eecd7876 100644
--- a/drivers/platform/chrome/chromeos_laptop.c
+++ b/drivers/platform/chrome/chromeos_laptop.c
@@ -620,10 +620,18 @@ static const struct dmi_system_id chromeos_laptop_dmi_table[] __initconst = {
 		},
 		.driver_data = (void *)&samus,
 	},
+	{
+		.ident = "Samsung Chromebook 3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
+		},
+		.driver_data = (void *)&samus,
+	},
 	{
 		/*
 		 * Other Chromebooks with Atmel touch controllers:
-		 * - Celes, Winky (touchpad)
+		 * - Winky (touchpad)
 		 * - Clapper, Expresso, Rambi, Glimmer (touchscreen)
 		 */
 		.ident = "Other Chromebook",
-- 
2.17.0.921.gf22659ad46-goog


-- 
Dmitry
