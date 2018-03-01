Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AG47ELvXrNWcWFUEAu6M2JvTc/+hVhfgz90P4mGqNDQcvqN8ag3FvN9ycvMERCPeMGQhZqLKZzaT
ARC-Seal: i=1; a=rsa-sha256; t=1519901810; cv=none;
        d=google.com; s=arc-20160816;
        b=QSyCbMbVfrrgYA12/jMpRGCe6wJjTNSwWNuYPYlXrkMcU8SW1R8LxbgNnKrrHooK02
         S6f3dRi8qqEo86wU9Us1wYu8eVb3P+0y0wp/IQki0sdE0bC+BbsmmWtCe9mvKPIZ+Fu3
         W7SeezagjqtGelLPPo5mPr07Mgr3p06GxQ0YfRPust0JR4z5BcKlX+Sn/UDjMHFoFz7u
         waGr/lpLSq6wJtY0Dt7rkEN+rg//s6879o7EzBnrewhoe6T83yDWdiivprHnqXS9r6Ob
         ME76+Jqx+flq83NYIg/trxiN6m/DFWrJOkcNlvWoPaf/EaTywb9nl3Hk09SLw8cl1qcD
         WyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=I9ECEjdt3SWr+cFyjFug/3XPldKws9lNh5s5bFEGMeA=;
        b=h+bKViYDf3NVQQfzKY/2ogpK+RwZ/7tAeWwVEynTw2CAhHoJ1tW0g0WWOqB/8ZaNbQ
         wkPBXIAev79d01eWxLf0SLTRY26wzZlHmcb4MJpnha1geWGevaGdTcfAjHYTu1TPU5ZR
         dbfbPiukb2DL8h5IiXpkDwsdUeRe0nAAK88cL4ZYVK0VsPjKwP1byQzXcLgMgxnCu3dJ
         EbbWYlIeTxBYLtutr2tVvOF2lI6255Bp7nQKitDS5xqkHQSBpq+Y9S2/ACtaaEvN7PSe
         7qqtgdenCmlIe/04otIpLBqrcodUOhECjrqD7JO7aciGx4uceJWnNrqVzapc9H1cyoAm
         hHCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.133 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.133 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Anshuman Khandual <khandual@linux.vnet.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Lee Jones <lee.jones@linaro.org>,
	Rui Feng <rui_feng@realsil.com.cn>,
	Steven Feng <steven_feng@realsil.com.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] misc: rtsx: rename SG_END macro
Date: Thu,  1 Mar 2018 11:31:28 +0100
Message-Id: <20180301105641.1650792-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:Z5KlDs0JfBf+xO879qZHgV5tOAXFu3eLm8/5rOHqjtMDQqMNyfd
 +T+V0YgoHeqtXtHYnKS7ZG50eTQnruzmYIQGH+A7z61QWi+ngaR3TP/oGoE8hFJCFgKL9qS
 aHiwG7dHE8rD8I1Rnpv7hsbZM6H9k0WEzfpNovUSs3M8HLIm8QAgP4eGE3PQJZCwFDhMWJn
 Ig4vdsFHHR8EAwIJaWcUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pOWymXtEOJY=:olu9gmPUYnmY3W8seI9mZo
 0WuhjZOkmx5n2nUJMLWh98Bo6HSyK2p+SfhG0iqkJc13QB2/phB2vOUpijpg4utnjTs3mfY4W
 OzMSzU8PHT6VSZGVgS8af/sS9BUD090XG+u5UJyfqNK/dQShfIe7QBoe3lrOjGXobNidvyKAM
 1JcZuFcJm59nyk9frV17GW5aQp4u0wUFzIY6M3Fd7A3qmfmtPBtCtVyGPq7s0jaNORD5oxq4e
 yWZUuK54iG1ZrrqpTdjooHuv5U133qGbCdwThki3+w7Tk0TRIFoA8qnM6bL+2xabeLlbZV3ux
 0fGl0W3a0HhW0gMnRLrsU8zccaToYuB/qH6LT506hN4GhI6W6rpOou4qs2XaNG/Yw9PO6Hlxq
 gothjvo0ok7r3D1j5tzZ+ZAVL3wRxrp9JODPMhj/y0lgwCsWEpDcHGRc2caR+0yZwMUjdm7KN
 8Nh9YRGR44IxZW/V2oi5+3jtyXmQQ9wdtefkOcBT20p01elQZYWv7w12G6GJk/RVW6jWMKkWN
 8zc1eEwThN1ECfXORVr3U3/UbdUn7dCGYjez2jDtEVvNo0FyUCGuZcYUf60DLhbEPeQPFp/Xj
 CEfOb+8y1zS/PA9twdrvp8xe9qFdsKVKpEWWLUJT7HuOGnQHaOkdw36NEnqMP1REf9c3hI6ZY
 4cVwKtDTwOvIsrPmECLHcjBAbRwzcKac/I7J4kwRbIOZA+babDsyM2fWrTvyLbBkjuYkqzXyp
 G0VgFPk603N+h8zZNkqXZrY2zqZfs54AUe6RNg==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593732560989886053?=
X-GMAIL-MSGID: =?utf-8?q?1593732560989886053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A change to the generic scatterlist code caused a conflict with
the rtsx card reader driver:

In file included from drivers/misc/cardreader/rtsx_pcr.c:32:
include/linux/rtsx_pci.h:40: error: "SG_END" redefined [-Werror]

This changes one instance of the driver to prefix SG_END and
related constants.

Fixes: 723fbf563a6a ("lib/scatterlist: Add SG_CHAIN and SG_END macros for LSB encodings")
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/cardreader/rtsx_pcr.c |  4 ++--
 include/linux/rtsx_pci.h           | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index fd09b0960097..e8f1d4bb806a 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -444,12 +444,12 @@ static void rtsx_pci_add_sg_tbl(struct rtsx_pcr *pcr,
 {
 	u64 *ptr = (u64 *)(pcr->host_sg_tbl_ptr) + pcr->sgi;
 	u64 val;
-	u8 option = SG_VALID | SG_TRANS_DATA;
+	u8 option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 
 	pcr_dbg(pcr, "DMA addr: 0x%x, Len: 0x%x\n", (unsigned int)addr, len);
 
 	if (end)
-		option |= SG_END;
+		option |= RTSX_SG_END;
 	val = ((u64)addr << 32) | ((u64)len << 12) | option;
 
 	put_unaligned_le64(val, ptr);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 478acf6efac6..e964bbd03fc2 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -36,12 +36,12 @@
 #define   CHECK_REG_CMD			2
 
 #define RTSX_HDBAR			0x08
-#define   SG_INT			0x04
-#define   SG_END			0x02
-#define   SG_VALID			0x01
-#define   SG_NO_OP			0x00
-#define   SG_TRANS_DATA			(0x02 << 4)
-#define   SG_LINK_DESC			(0x03 << 4)
+#define   RTSX_SG_INT			0x04
+#define   RTSX_SG_END			0x02
+#define   RTSX_SG_VALID			0x01
+#define   RTSX_SG_NO_OP			0x00
+#define   RTSX_SG_TRANS_DATA		(0x02 << 4)
+#define   RTSX_SG_LINK_DESC		(0x03 << 4)
 #define RTSX_HDBCTLR			0x0C
 #define   SDMA_MODE			0x00
 #define   ADMA_MODE			(0x02 << 26)
-- 
2.9.0
