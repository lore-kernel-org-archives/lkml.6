Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752392AbeDRQSs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:18:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35810 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeDRQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:18:47 -0400
From: Colin King <colin.king@canonical.com>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: pxa2xx: make function pxa2xx_spi_transfer_one static
Date: Wed, 18 Apr 2018 17:18:42 +0100
Message-Id: <20180418161842.19846-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function pxa2xx_spi_transfer_one is local to the source and
do not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/spi/spi-pxa2xx.c:914:5: warning: symbol 'pxa2xx_spi_transfer_one'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-pxa2xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c852ea5c28c6..40f1346b8188 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -911,9 +911,9 @@ static bool pxa2xx_spi_can_dma(struct spi_controller *master,
 	       xfer->len >= chip->dma_burst_size;
 }
 
-int pxa2xx_spi_transfer_one(struct spi_controller *master,
-			    struct spi_device *spi,
-			    struct spi_transfer *transfer)
+static int pxa2xx_spi_transfer_one(struct spi_controller *master,
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer)
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(master);
 	struct spi_message *message = master->cur_msg;
-- 
2.17.0
