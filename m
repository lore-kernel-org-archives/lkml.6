Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029FDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869342089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869342089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeIZCD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:03:29 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:29190 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbeIZCD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:03:29 -0400
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id EFE7B41E33;
        Tue, 25 Sep 2018 21:54:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id ICbHBCTXakjX; Tue, 25 Sep 2018 21:54:17 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] phy: lantiq: Fix compile warning
Date:   Tue, 25 Sep 2018 21:54:07 +0200
Message-Id: <20180925195407.10661-1-hauke@hauke-m.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This local variable is unused, remove it.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
index 986224fca9e9..5a180f71d8d4 100644
--- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
+++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
@@ -156,7 +156,6 @@ static int ltq_rcu_usb2_of_parse(struct ltq_rcu_usb2_priv *priv,
 {
 	struct device *dev = priv->dev;
 	const __be32 *offset;
-	int ret;
 
 	priv->reg_bits = of_device_get_match_data(dev);
 
-- 
2.11.0

