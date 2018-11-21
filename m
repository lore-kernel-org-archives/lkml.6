Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67905C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C15F214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAmYMJUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C15F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbeKVFHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35076 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733287AbeKVFHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so6747253wmh.0;
        Wed, 21 Nov 2018 10:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uVh0xNo2V1MxOpBSFsyikXljPWdCVTSBhzPNWO4ZvGY=;
        b=sAmYMJUnUDaNoFq8FCH3Jcvy9ZFamXo0JscNxyHCPMExbaTUzvXXGzscIUnKmuTQmA
         d/F//6PcKMBIdt0rrUW3uWIxXNzYTlIJj1LK3r9+zxLyrh2lFj4DcGeVYkZgY3VIFxsm
         yGWGeYaRY1w+GyYV4PkS5pqsWzDJBbE2pgRBO+jBS9/2q4QjUscmGPEF7LPdTtf8oH3i
         VBgdZx4CD3ekV+ye28CQR4utCtMpLFjR+1aEtDQdmFoT9xAI5vV1mA8oSvxQj0H9zZ0+
         rgPZ2TL4TuWp5SI3EGMvyQ8jddvpKDU21t1dw/I0RRc/pF5uMup+GyMkNmNRU95YTN/C
         Grxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVh0xNo2V1MxOpBSFsyikXljPWdCVTSBhzPNWO4ZvGY=;
        b=QH4MDmyMSf8/noP0USXTrEM8zg5bpTsMnygvxNVXlijyp8Gkevht6y+r5EBlP7E/CX
         ALD+zB30Dy2fTsccJ9ZSn7v2CwhX824CFlw1n8S+6UkUriLc7wm9JRsHCkn4zCBwETYT
         SGZQg/Qr1i9puRhdWwPhHZzLWpEBLYGouMP1TaeE2LYTShbSptTn/oEqBxgxl/fITkpJ
         Co9taSBnml9p7xUadsynjvtZCl0peDT+MglcgDlVg1cv2Q0+YwJ+iV4v6VFm11ZyYWoM
         TBkGsU3oUej4SOwG+3iAKVg2CzURFchZiIgVibkOJxBrGroDnXjVspPop2UJmmMluZd1
         NibQ==
X-Gm-Message-State: AGRZ1gL+UhRf2dC3f3aoVUkw/DljtaS5k47aKiRsxsVbRcFmhUz/Kg1G
        W9ocZT7t9P1Mnp/sps/VC0KOCqykovg=
X-Google-Smtp-Source: AJdET5dRC+tZ6xNqh0tg9gjz5YUjPkHUwxpPrhSij+JDvdS4hD9I98VY4BCIUCMsrsep/LhEQFjFvg==
X-Received: by 2002:a1c:bc82:: with SMTP id m124-v6mr6638648wmf.47.1542825131138;
        Wed, 21 Nov 2018 10:32:11 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:32:10 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [RFC PATCH v3 15/17] watchdog: Add support for Allwinner ARMv5 F1C100s wdt
Date:   Wed, 21 Nov 2018 21:30:48 +0300
Message-Id: <09c57147e53dda00eaae83178d0a25fe3f50dd1e.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
Add compatible string for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/watchdog/sunxi_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index c6c7365..bc70742 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -227,6 +227,7 @@ static const struct sunxi_wdt_reg sun6i_wdt_reg = {
 static const struct of_device_id sunxi_wdt_dt_ids[] = {
 	{ .compatible = "allwinner,sun4i-a10-wdt", .data = &sun4i_wdt_reg },
 	{ .compatible = "allwinner,sun6i-a31-wdt", .data = &sun6i_wdt_reg },
+	{ .compatible = "allwinner,suniv-f1c100s-wdt", .data = &sun6i_wdt_reg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
-- 
2.7.4

