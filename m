Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937641AbeE2ByD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:54:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:37940 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935149AbeE2ByC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:54:02 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 02/15] fsi: gpio: Remove unused 'id' variable
Date: Tue, 29 May 2018 11:30:31 +1000
Message-Id: <20180529013044.23815-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jeffery <andrew@aj.id.au>

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 2a49b167effe..20b334f1827d 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -270,7 +270,7 @@ static int read_one_response(struct fsi_master_gpio *master,
 		uint8_t data_size, struct fsi_gpio_msg *msgp, uint8_t *tagp)
 {
 	struct fsi_gpio_msg msg;
-	uint8_t id, tag;
+	uint8_t tag;
 	uint32_t crc;
 	int i;
 
@@ -295,7 +295,6 @@ static int read_one_response(struct fsi_master_gpio *master,
 	/* Read slave ID & response tag */
 	serial_in(master, &msg, 4);
 
-	id = (msg.msg >> FSI_GPIO_MSG_RESPID_SIZE) & 0x3;
 	tag = msg.msg & 0x3;
 
 	/* If we have an ACK and we're expecting data, clock the data in too */
-- 
2.17.0
