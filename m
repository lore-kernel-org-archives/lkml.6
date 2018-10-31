Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD37C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D865820823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D865820823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeKABox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:44:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54509 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbeKABow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:44:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gHtd5-0005q0-U3; Wed, 31 Oct 2018 16:46:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] pcmcia:  clean an indentation issues, remove extraneous spaces
Date:   Wed, 31 Oct 2018 16:46:02 +0000
Message-Id: <20181031164602.28738-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up indentation issues, remove spaces

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pcmcia/i82092.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index aae7e6df99cd..7cebea482200 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -430,27 +430,25 @@ static int i82092aa_get_status(struct pcmcia_socket *socket, u_int *value)
 		
 	/* IO cards have a different meaning of bits 0,1 */
 	/* Also notice the inverse-logic on the bits */
-	 if (indirect_read(sock, I365_INTCTL) & I365_PC_IOCARD)	{
-	 	/* IO card */
-	 	if (!(status & I365_CS_STSCHG))
-	 		*value |= SS_STSCHG;
-	 } else { /* non I/O card */
-	 	if (!(status & I365_CS_BVD1))
-	 		*value |= SS_BATDEAD;
-	 	if (!(status & I365_CS_BVD2))
-	 		*value |= SS_BATWARN;
-	 		
-	 }
+	if (indirect_read(sock, I365_INTCTL) & I365_PC_IOCARD)	{
+		/* IO card */
+		if (!(status & I365_CS_STSCHG))
+			*value |= SS_STSCHG;
+	} else { /* non I/O card */
+		if (!(status & I365_CS_BVD1))
+			*value |= SS_BATDEAD;
+		if (!(status & I365_CS_BVD2))
+			*value |= SS_BATWARN;
+	}
 	 
-	 if (status & I365_CS_WRPROT)
-	 	(*value) |= SS_WRPROT;	/* card is write protected */
+	if (status & I365_CS_WRPROT)
+		(*value) |= SS_WRPROT;	/* card is write protected */
 	 
-	 if (status & I365_CS_READY)
-	 	(*value) |= SS_READY;    /* card is not busy */
+	if (status & I365_CS_READY)
+		(*value) |= SS_READY;    /* card is not busy */
 	 	
-	 if (status & I365_CS_POWERON)
-	 	(*value) |= SS_POWERON;  /* power is applied to the card */
-
+	if (status & I365_CS_POWERON)
+		(*value) |= SS_POWERON;  /* power is applied to the card */
 
 	leave("i82092aa_get_status");
 	return 0;
-- 
2.19.1

