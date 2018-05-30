Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeE3LQH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:16:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60689 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751586AbeE3LHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:24 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Marc Kleine-Budde" <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.953655645@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 028/153] slip: sl_alloc(): remove unused parameter
 "dev_t line"
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -719,7 +719,7 @@ static void sl_sync(void)
 
 
 /* Find a free SLIP channel, and link in this `tty' line. */
-static struct slip *sl_alloc(dev_t line)
+static struct slip *sl_alloc(void)
 {
 	int i;
 	char name[IFNAMSIZ];
@@ -800,7 +800,7 @@ static int slip_open(struct tty_struct *
 
 	/* OK.  Find a free SLIP channel to use. */
 	err = -ENFILE;
-	sl = sl_alloc(tty_devnum(tty));
+	sl = sl_alloc();
 	if (sl == NULL)
 		goto err_exit;
 
