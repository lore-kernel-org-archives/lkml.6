Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA4C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376D220818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376D220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeKJCSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:18:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50221 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbeKJCSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:18:52 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5595A207CF; Fri,  9 Nov 2018 17:37:31 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 271BC20510;
        Fri,  9 Nov 2018 17:37:21 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] net: mvneta: correct typo
Date:   Fri,  9 Nov 2018 17:37:20 +0100
Message-Id: <20181109163720.17266-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved variable should be named reserved1.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 5bfd349bf41a..3ba672e9e353 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -494,7 +494,7 @@ struct mvneta_port {
 #if defined(__LITTLE_ENDIAN)
 struct mvneta_tx_desc {
 	u32  command;		/* Options used by HW for packet transmitting.*/
-	u16  reserverd1;	/* csum_l4 (for future use)		*/
+	u16  reserved1;		/* csum_l4 (for future use)		*/
 	u16  data_size;		/* Data size of transmitted packet in bytes */
 	u32  buf_phys_addr;	/* Physical addr of transmitted buffer	*/
 	u32  reserved2;		/* hw_cmd - (for future use, PMT)	*/
@@ -519,7 +519,7 @@ struct mvneta_rx_desc {
 #else
 struct mvneta_tx_desc {
 	u16  data_size;		/* Data size of transmitted packet in bytes */
-	u16  reserverd1;	/* csum_l4 (for future use)		*/
+	u16  reserved1;		/* csum_l4 (for future use)		*/
 	u32  command;		/* Options used by HW for packet transmitting.*/
 	u32  reserved2;		/* hw_cmd - (for future use, PMT)	*/
 	u32  buf_phys_addr;	/* Physical addr of transmitted buffer	*/
-- 
2.19.1

