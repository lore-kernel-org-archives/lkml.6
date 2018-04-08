Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbeDHU5s (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:57:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51441 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeDHU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:57:45 -0400
X-Google-Smtp-Source: AIpwx48lnNmiLONpQ7w8rBGSakvNM4f4kZGRJWLfeZq5PVPkSh7y1wKcM+0trTSFEsDLamaC1J5sIQ==
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] firmware: bcm47xx_nvram: support small (0x6000 B) NVRAM partitions
Date: Sun,  8 Apr 2018 22:57:33 +0200
Message-Id: <20180408205733.9026-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180408205733.9026-1-zajec5@gmail.com>
References: <20180408205733.9026-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Some old devices with 4 MiB flashes were using 0x1000 block size and
could use smaller (0x6000 bytes) flash partition for storing NVRAM
content. This adds support for reading NVRAM on Netgear WNR1000 V3.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 0b631e5b5b84..d25f080fcb0d 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -36,7 +36,7 @@ struct nvram_header {
 
 static char nvram_buf[NVRAM_SPACE];
 static size_t nvram_len;
-static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
+static const u32 nvram_sizes[] = {0x6000, 0x8000, 0xF000, 0x10000};
 
 static u32 find_nvram_size(void __iomem *end)
 {
-- 
2.11.0
