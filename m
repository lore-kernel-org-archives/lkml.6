Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeDHHia (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:38:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:41921 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbeDHHi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 03:38:29 -0400
Date: Sun, 8 Apr 2018 09:38:26 +0200
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: dmi_scan: Use lowercase letters for UUID
Message-ID: <20180408093826.3107ada1@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC 4122 asks for letters a-f in UUID to be lowercase. Follow this
recommendation.

Suggested by Paul Dagnelie at:
https://savannah.nongnu.org/bugs/index.php?53569

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/firmware/dmi_scan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-4.16.orig/drivers/firmware/dmi_scan.c	2018-04-01 23:20:27.000000000 +0200
+++ linux-4.16/drivers/firmware/dmi_scan.c	2018-04-08 09:32:20.508719012 +0200
@@ -210,9 +210,9 @@ static void __init dmi_save_uuid(const s
 	 * says that this is the defacto standard.
 	 */
 	if (dmi_ver >= 0x020600)
-		sprintf(s, "%pUL", d);
+		sprintf(s, "%pUl", d);
 	else
-		sprintf(s, "%pUB", d);
+		sprintf(s, "%pUb", d);
 
 	dmi_ident[slot] = s;
 }


-- 
Jean Delvare
SUSE L3 Support
