Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeCMKyJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:54:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932627AbeCMKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:54:08 -0400
From: Colin King <colin.king@canonical.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: reset: make function sc27xx_poweroff_shutdown static
Date: Tue, 13 Mar 2018 10:54:06 +0000
Message-Id: <20180313105406.28841-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function sc27xx_poweroff_shutdown is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/power/reset/sc27xx-poweroff.c:28:6: warning: symbol
'sc27xx_poweroff_shutdown' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/reset/sc27xx-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
index 65c477eee559..29fb08b8faa0 100644
--- a/drivers/power/reset/sc27xx-poweroff.c
+++ b/drivers/power/reset/sc27xx-poweroff.c
@@ -25,7 +25,7 @@ static struct regmap *regmap;
  * taking cpus down to avoid racing regmap or spi mutex lock when poweroff
  * system through PMIC.
  */
-void sc27xx_poweroff_shutdown(void)
+static void sc27xx_poweroff_shutdown(void)
 {
 #ifdef CONFIG_PM_SLEEP_SMP
 	int cpu = smp_processor_id();
-- 
2.15.1
