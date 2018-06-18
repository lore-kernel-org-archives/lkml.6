Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A53AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C332020652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C332020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936361AbeFRJzj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:55:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964877AbeFRIUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E8E0C3C;
        Mon, 18 Jun 2018 08:20:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 114/279] reset: uniphier: fix USB clock line for LD20
Date:   Mon, 18 Jun 2018 10:11:39 +0200
Message-Id: <20180618080613.527806390@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit e6914365fd280fce303a89b8a8d4529af5a2e0f9 ]

For LD20, the bit 5 of the offset 0x200c turned out to be a USB3
reset.  The hardware document says it is the GIO reset despite LD20
has no GIO bus, confusingly.

Also, fix confusing comments for PXs3.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/reset/reset-uniphier.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/reset/reset-uniphier.c
+++ b/drivers/reset/reset-uniphier.c
@@ -107,7 +107,7 @@ static const struct uniphier_reset_data
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
 	UNIPHIER_RESETX(6, 0x200c, 6),		/* Ether */
 	UNIPHIER_RESETX(8, 0x200c, 8),		/* STDMAC (HSC) */
-	UNIPHIER_RESETX(12, 0x200c, 5),		/* GIO (PCIe, USB3) */
+	UNIPHIER_RESETX(14, 0x200c, 5),		/* USB30 */
 	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
 	UNIPHIER_RESETX(17, 0x200c, 13),	/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x200c, 14),	/* USB30-PHY2 */
@@ -122,8 +122,8 @@ static const struct uniphier_reset_data
 	UNIPHIER_RESETX(2, 0x200c, 0),		/* NAND */
 	UNIPHIER_RESETX(4, 0x200c, 2),		/* eMMC */
 	UNIPHIER_RESETX(8, 0x200c, 12),		/* STDMAC */
-	UNIPHIER_RESETX(12, 0x200c, 4),		/* USB30 link (GIO0) */
-	UNIPHIER_RESETX(13, 0x200c, 5),		/* USB31 link (GIO1) */
+	UNIPHIER_RESETX(12, 0x200c, 4),		/* USB30 link */
+	UNIPHIER_RESETX(13, 0x200c, 5),		/* USB31 link */
 	UNIPHIER_RESETX(16, 0x200c, 16),	/* USB30-PHY0 */
 	UNIPHIER_RESETX(17, 0x200c, 18),	/* USB30-PHY1 */
 	UNIPHIER_RESETX(18, 0x200c, 20),	/* USB30-PHY2 */


