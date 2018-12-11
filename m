Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADF7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A77C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A77C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLKIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:05:35 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:48498 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeLKIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:05:26 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43DXYc1FDXz1r2cC;
        Tue, 11 Dec 2018 09:05:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43DXYc0Ghqz1qrnJ;
        Tue, 11 Dec 2018 09:05:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 7tYr4Ma-_Qow; Tue, 11 Dec 2018 09:05:22 +0100 (CET)
X-Auth-Info: vEhu7Uh0aFLABhva+u7giMJXYyMx2ajaAFfp049DCYg=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 11 Dec 2018 09:05:22 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 3/4] i2c: Add Actions Semiconductor Owl family S700 I2C support
Date:   Tue, 11 Dec 2018 09:04:47 +0100
Message-Id: <20181211080448.24007-4-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181211080448.24007-1-pn@denx.de>
References: <20181211080448.24007-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S700 to the list of devices supported by Owl I2C driver.

Add Actions Semiconductor Owl family S700 I2C driver.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

