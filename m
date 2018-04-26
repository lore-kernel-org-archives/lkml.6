Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756439AbeDZSsl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:48:41 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40278 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755422AbeDZSs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:48:28 -0400
X-Google-Smtp-Source: AB8JxZro2I0LsGYkjYizGcUPC7GGuENGOJvCpmHA3p309zH13VSXq7mBTDjgO6SXUHRyqaWXHppdpQ==
From: Kamal Dasu <kdasu.kdev@gmail.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jon.mason@broadcom.com, yendapally.reddy@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 2/2] spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL
Date: Thu, 26 Apr 2018 14:48:01 -0400
Message-Id: <1524768481-16347-3-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524768481-16347-1-git-send-email-kdasu.kdev@gmail.com>
References: <1524768481-16347-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always confirm the BSPI_MAST_N_BOOT_CTRL bit when enabling
or disabling BSPI transfers.

Fixes: 4e3b2d236fe00 ("spi: bcm-qspi: Add BSPI spi-nor flash controller driver")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 2946989..6573152 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -490,7 +490,7 @@ static int bcm_qspi_bspi_set_mode(struct bcm_qspi *qspi,
 
 static void bcm_qspi_enable_bspi(struct bcm_qspi *qspi)
 {
-	if (!has_bspi(qspi) || (qspi->bspi_enabled))
+	if (!has_bspi(qspi))
 		return;
 
 	qspi->bspi_enabled = 1;
@@ -505,7 +505,7 @@ static void bcm_qspi_enable_bspi(struct bcm_qspi *qspi)
 
 static void bcm_qspi_disable_bspi(struct bcm_qspi *qspi)
 {
-	if (!has_bspi(qspi) || (!qspi->bspi_enabled))
+	if (!has_bspi(qspi))
 		return;
 
 	qspi->bspi_enabled = 0;
-- 
2.7.4
