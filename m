Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A214C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAA020865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAA020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeK0Fx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:53:56 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:59126 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeK0Fxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:53:55 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433bmV22wYz1r34y;
        Mon, 26 Nov 2018 19:58:45 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433bmN1kgwz1qtfY;
        Mon, 26 Nov 2018 19:58:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id j0rqyhyc1YuD; Mon, 26 Nov 2018 19:58:43 +0100 (CET)
X-Auth-Info: 0zD/zE7sX05b5pp37BKzp+WnemujeDJ1mNvbCPfcJXQ=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Nov 2018 19:58:43 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v2 2/4] i2c: Add Actions Semiconductor Owl family S700 I2C support
Date:   Mon, 26 Nov 2018 19:58:19 +0100
Message-Id: <20181126185821.2480449-3-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S700 to the list of devices supported by Owl I2C driver.

Add Actions Semiconductor Owl family S900 I2C driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 drivers/i2c/busses/i2c-owl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 96b4572e6d9c..b6b5a495118b 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id owl_i2c_of_match[] = {
+	{ .compatible = "actions,s700-i2c" },
 	{ .compatible = "actions,s900-i2c" },
 	{ /* sentinel */ }
 };
-- 
2.17.2

