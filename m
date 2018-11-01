Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DB2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E12E204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E12E204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeKAUpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:45:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57255 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeKAUps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:45:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA1BgqnI2796160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 1 Nov 2018 04:42:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA1BgpL32796157;
        Thu, 1 Nov 2018 04:42:51 -0700
Date:   Thu, 1 Nov 2018 04:42:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Carpenter <tipbot@zytor.com>
Message-ID: <tip-3424243e39e8ec138486926949e3668e7553125d@git.kernel.org>
Cc:     gregory.clement@bootlin.com, tglx@linutronix.de, andrew@lunn.ch,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com, marc.zyngier@arm.com,
        hpa@zytor.com, dan.carpenter@oracle.com
Reply-To: linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
          jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
          marc.zyngier@arm.com, hpa@zytor.com, dan.carpenter@oracle.com,
          gregory.clement@bootlin.com, tglx@linutronix.de, andrew@lunn.ch,
          mingo@kernel.org
In-Reply-To: <20181013102246.GD16086@mwanda>
References: <20181013102246.GD16086@mwanda>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug
 in probe function
Git-Commit-ID: 3424243e39e8ec138486926949e3668e7553125d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3424243e39e8ec138486926949e3668e7553125d
Gitweb:     https://git.kernel.org/tip/3424243e39e8ec138486926949e3668e7553125d
Author:     Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate: Sat, 13 Oct 2018 13:22:46 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Nov 2018 12:38:48 +0100

irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug in probe function

The devm_ioremap_resource() function never returns NULL, it returns
error pointers.

Fixes: 61ce8d8d8a81 ("irqchip/irq-mvebu-sei: Add new driver for Marvell SEI")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20181013102246.GD16086@mwanda

---
 drivers/irqchip/irq-mvebu-sei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 566d69a2edbc..add4c9c934c8 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -384,9 +384,9 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 
 	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sei->base = devm_ioremap_resource(sei->dev, sei->res);
-	if (!sei->base) {
+	if (IS_ERR(sei->base)) {
 		dev_err(sei->dev, "Failed to remap SEI resource\n");
-		return -ENODEV;
+		return PTR_ERR(sei->base);
 	}
 
 	/* Retrieve the SEI capabilities with the interrupt ranges */
