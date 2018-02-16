Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034212AbeBPOWb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:22:31 -0500
Received: from mout.web.de ([217.72.192.78]:47461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034176AbeBPOW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:22:29 -0500
Subject: [PATCH 1/2] pata_it821x: Delete an error message for a failed memory
 allocation in it821x_firmware_command()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-ide@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
Message-ID: <939014fc-8c9e-99a4-99fb-2fde4694cd29@users.sourceforge.net>
Date: Fri, 16 Feb 2018 15:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6cdadc5e-bfbd-9866-a69f-d225e68c3b22@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:x1I30UIFZBLew4Kk+HI3Pu4r1bEhZ+SDl11Tx/5yO1qU35O/FJy
 8t7VgbFrGBLVqjzlNkmmUq52N1aJd1GdEKbvErFDioUBuLlkcNK0FfKuglYqXyLk08j2NVF
 Ek3NGFMw/cvIdbGqsivDCeZL0lQ7d+TkrK7x9aXWvEcBca65Y66PO57SfmU3Qpd48b7dgW1
 TfAdrjoz5csGfBJTyYuow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qgfMIbJ6gJI=:pGw9resP1lAhBkgLzjcNcw
 yvo03ishrTvmWVv6RQRV43JfjqDeRvQr7F8furSFssJRs+ZF3nAJEoDuhqSz/ANUv7xPwzQRX
 HZoEjPrTQ2AG4Onk/SmFTWh0kTXGPOV9iwHDjvRg5ddsDQdDGhAC6C5/dD7BtaRLxVeKRU6Sw
 W/kyShWdCfiLs0IwDp9x1hInXPS0JIghdz22t4BC6TjJgeg3waI9fKZlshgU1XqKY8KAGEysu
 gZ3Z9+LeI9RKTb3gDYI3TZHqwSDpTQSyCEME14zKwTLTsvgC7QLlNe7nRd98xTfQoma80rrIX
 HctI8GBM2TMgu2rok6LE66IZ+efdg0QKLIfUmT8ALCACtZkCp9fsGRPdRuZDxV/LsyWQC8RcO
 q1gGgvED589ISkl6jA+BYyblhmZE+7nlb4yGpqeSI4FjuLjR/tXUEHydSwzni5LNw77qUjLB6
 l1dHT25DGFmhSn0X0pcUGWEW/Ce8k5LbbfKtLTib4JOCsGcnqitAdDrEOq2+eIOt0+yEbzWo4
 4lVmpP4TOL6WrSflHhOV3aVce0d6tUy6/sokZNHUVxhKgHUbNsuwwUJFZP8CAU6T1UwriZRXk
 GPBUKyRkiC66L972QcxzuU20+mq/Cl5xiSirDrdW9E5GRjA6XnkcX3lyuqfIS5zly76Ky9jGW
 dOBNdXShv4ootoLEkm8ylCrbahbv4OGyTTTfuovLdS257nOFb92QUGbNc6F4V95N9QiYIrUAe
 i99yYwjOkZoGoZ3h0s5gvttay7t3kariuWiqKTggOA7Wz4+ddiXMOBdrmemDL3R0kl40E6vMK
 ene0baAnZSP9bLiQp7iEjI01V8aFDhCWPE4pZX0UpR/hPzLUik=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 16 Feb 2018 14:04:49 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/pata_it821x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 7a21edf89e72..46eacb6b93dd 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -658,10 +658,10 @@ static u8 *it821x_firmware_command(struct ata_port *ap, u8 cmd, int len)
 	u8 status;
 	int n = 0;
 	u16 *buf = kmalloc(len, GFP_KERNEL);
-	if (buf == NULL) {
-		printk(KERN_ERR "it821x_firmware_command: Out of memory\n");
+
+	if (!buf)
 		return NULL;
-	}
+
 	/* This isn't quite a normal ATA command as we are talking to the
 	   firmware not the drives */
 	ap->ctl |= ATA_NIEN;
-- 
2.16.1
