Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF9EC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B239222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025222;
	bh=/rNfeIsRBuBWQj7uU8JneWWbgwD+/5OaoXO32Non874=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WX7RUVGoJ0j9TJM4JNH8aqe8pSP3CTQ4XiTymmi29ZeJenwOWKaX4mJKTocmtdZXO
	 4IAPEW1K7eBHrw9vCaGuhPZEwt+eFIsn/OqKIECkTQZcqTsI3cWfM0nAdmasEYrcrP
	 qRjINEO80DT/g5sgOIszcJd4HNbZB+4NyFlyBt1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfBMCdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbfBMCdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D52222C7;
        Wed, 13 Feb 2019 02:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025219;
        bh=/rNfeIsRBuBWQj7uU8JneWWbgwD+/5OaoXO32Non874=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcZ7KFVCu/N6vHZ+j4iQfl+iU4sfLkKAfyuyyEKVFAOjFVdQ0Pd73rkQoeWuGXGwQ
         5Vr+/A/in6xExHZM29R+vh5YgSqcK6LrFTlhDgwTW2nYciB8nDt9Awzf8xEv7yxFVK
         2Dzkn72+ZWIEb67qsz7v6YTEAsZOPvIE0B4HwNg4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh R <vigneshr@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 002/105] mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
Date:   Tue, 12 Feb 2019 21:31:53 -0500
Message-Id: <20190213023336.19019-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit b40ee006fe6a8a25093434e5d394128c356a48f3 ]

Use PLATFORM_DEVID_AUTO to number mfd cells while registering, so that
different instances are uniquely identified. This is required in order
to support registering of multiple instances of same ti_am335x_tscadc IP.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/ti_am335x_tscadc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index c2d47d78705b..fd111296b959 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -264,8 +264,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		cell->pdata_size = sizeof(tscadc);
 	}
 
-	err = mfd_add_devices(&pdev->dev, pdev->id, tscadc->cells,
-			tscadc->used_cells, NULL, 0, NULL);
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+			      tscadc->cells, tscadc->used_cells, NULL,
+			      0, NULL);
 	if (err < 0)
 		goto err_disable_clk;
 
-- 
2.19.1

