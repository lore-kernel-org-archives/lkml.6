Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA5CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742492084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfBCOYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:24:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55778 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730444AbfBCOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:20 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIe6-0006QI-S5; Sun, 03 Feb 2019 14:21:18 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9W-0006sm-8j; Sun, 03 Feb 2019 14:49:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "Yogesh Gaur" <yogeshnarayan.gaur@nxp.com>,
        "Han Xu" <han.xu@nxp.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.232761890@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 070/305] mtd: spi-nor: fsl-quadspi: fix api naming
 typo _init_ahb_read
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

commit dd50a1c4e56d6d2ea753f87a35b1f1e09cb877d7 upstream.

Fix api naming typo _init_ahb_read
fsl_qspi_init_abh_read --> fsl_qspi_init_ahb_read

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Acked-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -574,7 +574,7 @@ static void fsl_qspi_set_map_addr(struct
  * causes the controller to clear the buffer, and use the sequence pointed
  * by the QUADSPI_BFGENCR[SEQID] to initiate a read from the flash.
  */
-static void fsl_qspi_init_abh_read(struct fsl_qspi *q)
+static void fsl_qspi_init_ahb_read(struct fsl_qspi *q)
 {
 	void __iomem *base = q->iobase;
 	int seqid;
@@ -647,7 +647,7 @@ static int fsl_qspi_nor_setup_last(struc
 	fsl_qspi_init_lut(q);
 
 	/* Init for AHB read */
-	fsl_qspi_init_abh_read(q);
+	fsl_qspi_init_ahb_read(q);
 
 	return 0;
 }

