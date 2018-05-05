Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeEEViI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 17:38:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33385 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEEViE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 17:38:04 -0400
X-Google-Smtp-Source: AB8JxZqLCIg8RU93JzTgl392ahUQY5r9NEOlSdl2ksDVyO9wKV7bfFo849D0zcq/G4YqIbkr8avQ5g==
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: m.grzeschik@pengutronix.de
Cc: Andrea Greco <a.greco@4sigma.it>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] arcnet: com20020: Fixup missing SLOWARB bit
Date: Sat,  5 May 2018 23:37:54 +0200
Message-Id: <20180505213754.8400-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

If com20020 clock is major of 40Mhz SLOWARB bit is requested.

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/arcnet/com20020.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/arcnet/com20020.c b/drivers/net/arcnet/com20020.c
index f09ea77dd6a8..abd32ed8ec9b 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -102,6 +102,10 @@ int com20020_check(struct net_device *dev)
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
 	lp->setup2 = (lp->clockm << 4) | 8;
 
+	// If clock is major of 40Mhz, SLOWARB bit must be set
+	if (lp->clockm > 1)
+		lp->setup2 |= SLOWARB;
+
 	/* CHECK: should we do this for SOHARD cards ? */
 	/* Enable P1Mode for backplane mode */
 	lp->setup = lp->setup | P1MODE;
-- 
2.14.3
