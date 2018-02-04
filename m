Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeBDUkN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 15:40:13 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34546 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeBDUj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 15:39:28 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] pcmcia: use proper printk format for resource
Date: Sun,  4 Feb 2018 21:12:05 +0100
Message-Id: <20180204201206.2300-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204201206.2300-1-linux@dominikbrodowski.net>
References: <20180204201206.2300-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though it is just in a dev_dbg statement, improve the printk format
to use %pr instead of plain %p.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/rsrc_nonstatic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 5ef7b46a2578..49377d502b74 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -367,7 +367,7 @@ static int do_validate_mem(struct pcmcia_socket *s,
 		}
 	}
 
-	dev_dbg(&s->dev, "cs: memory probe 0x%06lx-0x%06lx: %p %p %u %u %u",
+	dev_dbg(&s->dev, "cs: memory probe 0x%06lx-0x%06lx: %pr %pr %u %u %u",
 		base, base+size-1, res1, res2, ret, info1, info2);
 
 	free_region(res2);
-- 
2.16.1
