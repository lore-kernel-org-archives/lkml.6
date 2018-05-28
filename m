Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165791AbeE1Ogr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:36:47 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:56455 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968913AbeE1Og0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:36:26 -0400
From: Roger Quadros <rogerq@ti.com>
To: <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] usb: dwc3: of-simple: Don't fail if no clock entries
Date: Mon, 28 May 2018 17:36:13 +0300
Message-ID: <1527518174-27860-1-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_count_phandle_with_args() returns -ENOENT (-2) if
there are no clock entries. Don't fail in such a case.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index cb2ee96..e98d221 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -36,11 +36,11 @@ static int dwc3_of_simple_clk_init(struct dwc3_of_simple *simple, int count)
 	struct device_node	*np = dev->of_node;
 	int			i;
 
-	simple->num_clocks = count;
-
-	if (!count)
+	if (count <= 0)
 		return 0;
 
+	simple->num_clocks = count;
+
 	simple->clks = devm_kcalloc(dev, simple->num_clocks,
 			sizeof(struct clk *), GFP_KERNEL);
 	if (!simple->clks)
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
