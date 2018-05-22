Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752921AbeEVUsA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:48:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41698 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeEVUr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:47:58 -0400
X-Google-Smtp-Source: AB8JxZopwO+sc2I8xFRR7hzVTu6rumsaPjNrOiJSUavqgNk5Dsd5g6+hAWJuaRR3ZQlkKfWsfG+KFQ==
Date: Tue, 22 May 2018 13:47:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: cherryview: limit Strago DMI workarounds to
 version 1.0
Message-ID: <20180522204753.GA260493@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Google/Intel will fix the BIOS/Coreboot issues with hardcoding
virtual interrupt numbers for keyboard/touchpad/touchscreen controllers
in ACPI tables, they will also update BOARD version number from 1.0
to 1.1. Let's limit the DMI quirks that try to preserve virtual IRQ
numbers on Strago boards to those that still carry older BIOSes.

Note that ideally not BOARD but BIOS version should have been updated.
However the BIOS version used by Chrome devices has format of
Google_BUILD.BRANCH.PATCH which is not well suited for DMI matching as
we do not have "less than" match mode for DMI data.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=197953
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v1->v2:

- switch from matching on DMI_BIOS_VERSION to DMI_BOARD_VERSION


 drivers/pinctrl/intel/pinctrl-cherryview.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index b1ae1618fefea..44133e6846303 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1527,6 +1527,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1534,6 +1535,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1541,6 +1543,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Cyan"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
 		},
 	},
 	{
@@ -1548,6 +1551,7 @@ static const struct dmi_system_id chv_no_valid_mask[] = {
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Celes"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
 		},
 	},
 	{}
-- 
2.17.0.441.gb46fe60e1d-goog


-- 
Dmitry
