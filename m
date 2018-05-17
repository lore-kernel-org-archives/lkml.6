Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeEQNHe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:07:34 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35595 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQNHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:07:32 -0400
X-Google-Smtp-Source: AB8JxZog8DdHG3tomcSnpgJGQBEKfajaj+SCtvxOMCszaYFIoxaw1GAAIX3T3acnp9NGDmIYTaNrlg==
From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To: tobin@apporbit.com
Cc: andrea.greco.gapmilano@gmail.com, Andrea Greco <a.greco@4sigma.it>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arcnet: com20020: Fixup missing SLOWARB bit
Date: Thu, 17 May 2018 15:07:13 +0200
Message-Id: <20180517130713.2839-1-andrea.greco.gapmilano@gmail.com>
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
index 2fd00d2dd6bf..f1de02f05305 100644
--- a/drivers/net/arcnet/com20020.c
+++ b/drivers/net/arcnet/com20020.c
@@ -102,6 +102,10 @@ int com20020_check(struct net_device *dev)
 	lp->setup = lp->clockm ? 0 : (lp->clockp << 1);
 	lp->setup2 = (lp->clockm << 4) | 8;
 
+	/* If clock is major of 40Mhz, SLOWARB bit must be set */
+	if (lp->clockm > 1)
+		lp->setup2 |= SLOWARB;
+
 	/* CHECK: should we do this for SOHARD cards ? */
 	/* Enable P1Mode for backplane mode */
 	lp->setup = lp->setup | P1MODE;
-- 
2.14.3
