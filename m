Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HvHuKkFKGVucVAAAmS7hNA
	; Thu, 07 Jun 2018 15:07:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 95BB9608BA; Thu,  7 Jun 2018 15:07:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1948A6089E;
	Thu,  7 Jun 2018 15:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1948A6089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936085AbeFGPHm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:07:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41538 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935879AbeFGPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:03:50 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbu-0005Zq-5Q; Thu, 07 Jun 2018 15:09:54 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002n8-DQ; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Marc Kleine-Budde" <mkl@pengutronix.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.246795205@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 077/410] slip: sl_alloc(): remove unused parameter
 "dev_t line"
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 936e5d8bdfa72577e28ea671d9e2ee4fef0d6b3e upstream.

The first and only parameter of sl_alloc() is unused, so remove it.

Fixes: 5342b77c4123 slip: ("Clean up create and destroy")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/slip/slip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -732,7 +732,7 @@ static void sl_sync(void)
 
 
 /* Find a free SLIP channel, and link in this `tty' line. */
-static struct slip *sl_alloc(dev_t line)
+static struct slip *sl_alloc(void)
 {
 	int i;
 	char name[IFNAMSIZ];
@@ -814,7 +814,7 @@ static int slip_open(struct tty_struct *
 
 	/* OK.  Find a free SLIP channel to use. */
 	err = -ENFILE;
-	sl = sl_alloc(tty_devnum(tty));
+	sl = sl_alloc();
 	if (sl == NULL)
 		goto err_exit;
 
