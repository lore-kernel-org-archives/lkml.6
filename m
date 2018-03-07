Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965887AbeCGTyU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:54:20 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.184]:26405 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965340AbeCGTyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:54:17 -0500
Date: Wed, 7 Mar 2018 13:54:15 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] video: fbdev: via_aux_vt1632: remove VLA usage
Message-ID: <20180307195415.GA666@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1etf8h-002QFN-Ti
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:47330
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead. Also, remove variable 'len'.

Notice that no new IDs have been added in seven years.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/via/via_aux_vt1632.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/via_aux_vt1632.c b/drivers/video/fbdev/via/via_aux_vt1632.c
index d24f4cd..0cd0d2a 100644
--- a/drivers/video/fbdev/via/via_aux_vt1632.c
+++ b/drivers/video/fbdev/via/via_aux_vt1632.c
@@ -35,10 +35,10 @@ static void probe(struct via_aux_bus *bus, u8 addr)
 		.addr	=	addr,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x06, 0x11, 0x92, 0x31}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	const u8 id[4] = {0x06, 0x11, 0x92, 0x31};
+	u8 tmp[4];
 
-	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
+	if (!via_aux_read(&drv, 0x00, tmp, 4) || memcmp(id, tmp, 4))
 		return;
 
 	printk(KERN_INFO "viafb: Found %s at address 0x%x\n", name, addr);
-- 
2.7.4
