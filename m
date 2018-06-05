Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeFERsi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:48:38 -0400
Received: from kopff.uberspace.de ([185.26.156.73]:42908 "EHLO
        kopff.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeFERsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:48:37 -0400
From: Helge Eichelberg <kernelorg@elchenberg.name>
Cc: Helge Eichelberg <kernelorg@elchenberg.name>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Disable fan support for Dell XPS13 9333
Date: Tue,  5 Jun 2018 19:38:32 +0200
Message-Id: <20180605173833.27003-1-kernelorg@elchenberg.name>
X-Mailer: git-send-email 2.14.1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling fan related SMM functions implemented by Dell BIOS firmware on Dell
XPS13 9333 freeze kernel for about 500ms. Until Dell fixes it we need to
disable fan support for Dell XPS13 9333.

Via "force" module param fan support can be enabled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=195751
Signed-off-by: Helge Eichelberg <kernelorg@elchenberg.name>
---
 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index bf3bb7e1adab..9d3ef879dc51 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1074,6 +1074,13 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Vostro 3360"),
 		},
 	},
+	{
+		.ident = "Dell XPS13 9333",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS13 9333"),
+		},
+	},
 	{ }
 };
 
-- 
2.14.1
