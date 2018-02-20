Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeBTPDu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:03:50 -0500
Received: from mail-it0-f74.google.com ([209.85.214.74]:43981 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeBTPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:03:49 -0500
X-Google-Smtp-Source: AH8x226ZlAPlWVnlJexOyrNq3tT6zOZ71GIVwSHeZCh0NCEyI80olo6ZcxQ2NRL1T5RUEjXvQsCtWaLDLvh5
MIME-Version: 1.0
Date: Tue, 20 Feb 2018 16:03:18 +0100
Message-Id: <20180220150318.138827-1-delroth@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
Subject: [PATCH] max17042: propagate of_node to power supply device
From: Pierre Bourdon <delroth@google.com>
Cc: Pierre Bourdon <delroth@google.com>, Andre Heider <a.heider@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max17042_get_status uses the core power_supply_am_i_supplied. That
function relies on DT properties to figure out the power supply
topology, and will error out without DT.

Fixes max17042 battery status being reported as "unknown".

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 35dde81b1c9b..1a568df383db 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1053,6 +1053,7 @@ static int max17042_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
+	psy_cfg.of_node = dev->of_node;
 
 	/* When current is not measured,
 	 * CURRENT_NOW and CURRENT_AVG properties should be invisible. */
-- 
2.16.1.291.g4437f3f132-goog
