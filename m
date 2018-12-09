Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF9BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2FF20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2FF20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeLIWL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:11:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37738 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727603AbeLIWLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:11:55 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW735-0002ie-5p; Sun, 09 Dec 2018 21:55:39 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72g-0003V6-3l; Sun, 09 Dec 2018 21:55:14 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Mark Brown" <broonie@linaro.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.160071340@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 200/328] spi: sh-msiof: Add more register documentation
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2e2b36872d7b45b1f88a590283b14c67931b777f upstream.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/spi/spi-sh-msiof.c | 54 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -113,9 +113,61 @@ struct sh_msiof_spi_priv {
 #define CTR_TXE		0x00000200 /* Transmit Enable */
 #define CTR_RXE		0x00000100 /* Receive Enable */
 
-/* STR and IER */
+/* FCTR */
+#define FCTR_TFWM_MASK	0xe0000000 /* Transmit FIFO Watermark */
+#define FCTR_TFWM_64	0x00000000 /*  Transfer Request when 64 empty stages */
+#define FCTR_TFWM_32	0x20000000 /*  Transfer Request when 32 empty stages */
+#define FCTR_TFWM_24	0x40000000 /*  Transfer Request when 24 empty stages */
+#define FCTR_TFWM_16	0x60000000 /*  Transfer Request when 16 empty stages */
+#define FCTR_TFWM_12	0x80000000 /*  Transfer Request when 12 empty stages */
+#define FCTR_TFWM_8	0xa0000000 /*  Transfer Request when 8 empty stages */
+#define FCTR_TFWM_4	0xc0000000 /*  Transfer Request when 4 empty stages */
+#define FCTR_TFWM_1	0xe0000000 /*  Transfer Request when 1 empty stage */
+#define FCTR_TFUA_MASK	0x07f00000 /* Transmit FIFO Usable Area */
+#define FCTR_TFUA_SHIFT		20
+#define FCTR_TFUA(i)	((i) << FCTR_TFUA_SHIFT)
+#define FCTR_RFWM_MASK	0x0000e000 /* Receive FIFO Watermark */
+#define FCTR_RFWM_1	0x00000000 /*  Transfer Request when 1 valid stages */
+#define FCTR_RFWM_4	0x00002000 /*  Transfer Request when 4 valid stages */
+#define FCTR_RFWM_8	0x00004000 /*  Transfer Request when 8 valid stages */
+#define FCTR_RFWM_16	0x00006000 /*  Transfer Request when 16 valid stages */
+#define FCTR_RFWM_32	0x00008000 /*  Transfer Request when 32 valid stages */
+#define FCTR_RFWM_64	0x0000a000 /*  Transfer Request when 64 valid stages */
+#define FCTR_RFWM_128	0x0000c000 /*  Transfer Request when 128 valid stages */
+#define FCTR_RFWM_256	0x0000e000 /*  Transfer Request when 256 valid stages */
+#define FCTR_RFUA_MASK	0x00001ff0 /* Receive FIFO Usable Area (0x40 = full) */
+#define FCTR_RFUA_SHIFT		 4
+#define FCTR_RFUA(i)	((i) << FCTR_RFUA_SHIFT)
+
+/* STR */
+#define STR_TFEMP	0x20000000 /* Transmit FIFO Empty */
+#define STR_TDREQ	0x10000000 /* Transmit Data Transfer Request */
 #define STR_TEOF	0x00800000 /* Frame Transmission End */
+#define STR_TFSERR	0x00200000 /* Transmit Frame Synchronization Error */
+#define STR_TFOVF	0x00100000 /* Transmit FIFO Overflow */
+#define STR_TFUDF	0x00080000 /* Transmit FIFO Underflow */
+#define STR_RFFUL	0x00002000 /* Receive FIFO Full */
+#define STR_RDREQ	0x00001000 /* Receive Data Transfer Request */
 #define STR_REOF	0x00000080 /* Frame Reception End */
+#define STR_RFSERR	0x00000020 /* Receive Frame Synchronization Error */
+#define STR_RFUDF	0x00000010 /* Receive FIFO Underflow */
+#define STR_RFOVF	0x00000008 /* Receive FIFO Overflow */
+
+/* IER */
+#define IER_TDMAE	0x80000000 /* Transmit Data DMA Transfer Req. Enable */
+#define IER_TFEMPE	0x20000000 /* Transmit FIFO Empty Enable */
+#define IER_TDREQE	0x10000000 /* Transmit Data Transfer Request Enable */
+#define IER_TEOFE	0x00800000 /* Frame Transmission End Enable */
+#define IER_TFSERRE	0x00200000 /* Transmit Frame Sync Error Enable */
+#define IER_TFOVFE	0x00100000 /* Transmit FIFO Overflow Enable */
+#define IER_TFUDFE	0x00080000 /* Transmit FIFO Underflow Enable */
+#define IER_RDMAE	0x00008000 /* Receive Data DMA Transfer Req. Enable */
+#define IER_RFFULE	0x00002000 /* Receive FIFO Full Enable */
+#define IER_RDREQE	0x00001000 /* Receive Data Transfer Request Enable */
+#define IER_REOFE	0x00000080 /* Frame Reception End Enable */
+#define IER_RFSERRE	0x00000020 /* Receive Frame Sync Error Enable */
+#define IER_RFUDFE	0x00000010 /* Receive FIFO Underflow Enable */
+#define IER_RFOVFE	0x00000008 /* Receive FIFO Overflow Enable */
 
 
 static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)

