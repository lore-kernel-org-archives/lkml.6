Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C88CE601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeFFPJL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:09:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56802 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeFFPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:09:10 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v3 01/12] platform/chrome: Make license text and module license match.
Date: Wed,  6 Jun 2018 17:08:49 +0200
Message-Id: <20180606150900.8342-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
boiler plate does not match, go for boiler plate license.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3:
- Add new patches to match license text with MODULE_LICENSE (Dmitry)
- If there is a conflict between the license notice and MODULE_LICENSE
  go by license notice not MODULE_LICENSE. (Dmitry)
- Reintroduced again the patch for the rtc-cros-ec driver as license
  should be GPL v2-only.
- Removed '[PATCH 7/9] pwm: cros-ec: Switch to SPDX identifier.' as
  maintainer told me that I don't need to resend.

Changes in v2:
- Removed '[PATCH 5/9] rtc: cros-ec: Switch to SPDX identifier' from
  series as it was applied.
- s/Chrome OS/ChromeOS/
- [1/9] Fixed wrong copyright year.
- [6/9] Do not remove last paragraph.
- [8/9] Fixed wrong copyright year.

 drivers/platform/chrome/chromeos_pstore.c | 2 +-
 drivers/platform/chrome/cros_ec_lpc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index b0693fdec8c6..57138ced4ca7 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -139,4 +139,4 @@ module_init(chromeos_pstore_init);
 module_exit(chromeos_pstore_exit);
 
 MODULE_DESCRIPTION("Chrome OS pstore module");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 3682e1539251..26f4fe6e9b04 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -479,5 +479,5 @@ static void __exit cros_ec_lpc_exit(void)
 module_init(cros_ec_lpc_init);
 module_exit(cros_ec_lpc_exit);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ChromeOS EC LPC driver");
-- 
2.17.1
