Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755392AbeDZK3u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:29:50 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:55473 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755197AbeDZK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:29:48 -0400
From: Roger Quadros <rogerq@ti.com>
To: <tony@atomide.com>
CC: <ladis@linux-mips.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH] memory: omap-gpmc: Avoid redundant NULL check
Date: Thu, 26 Apr 2018 13:29:32 +0300
Message-ID: <1524738572-23506-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

child->name cannot be NULL as we're already checking for it
in gpmc_probe_dt_children()

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 90a66b3..c215287 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2060,8 +2060,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	 * timings.
 	 */
 	name = gpmc_cs_get_name(cs);
-	if (name && child->name && of_node_cmp(child->name, name) == 0)
-			goto no_timings;
+	if (name && of_node_cmp(child->name, name) == 0)
+		goto no_timings;
 
 	ret = gpmc_cs_request(cs, resource_size(&res), &base);
 	if (ret < 0) {
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
