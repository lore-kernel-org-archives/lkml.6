Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936842AbeE2BcF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:32:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:38853 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936805AbeE2BcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:32:00 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 06/15] fsi/fsi-master-gpio: Reduce turnaround clocks
Date: Tue, 29 May 2018 11:30:35 +1000
Message-Id: <20180529013044.23815-7-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSI_GPIO_PRIME_SLAVE_CLOCKS is the number of clocks if the
"idle" phase between the end of a response and the beginning
of the next one. It corresponds to tSendDelay in the FSI
specification.

The default value in the slave is 16 clocks. 100 is way overkill
and significantly reduces the driver performance.

This changes it to 20 (which gives the HW a bit of margin still
just in case).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-master-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index c82bbd35276e..029b0a5b6d89 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -49,7 +49,7 @@
 #define	FSI_GPIO_CRC_SIZE	4
 #define	FSI_GPIO_MSG_ID_SIZE		2
 #define	FSI_GPIO_MSG_RESPID_SIZE	2
-#define	FSI_GPIO_PRIME_SLAVE_CLOCKS	100
+#define	FSI_GPIO_PRIME_SLAVE_CLOCKS	20
 
 struct fsi_master_gpio {
 	struct fsi_master	master;
-- 
2.17.0
