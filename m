Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98923C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5051126416
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsBM7/N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5051126416
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965127AbeFZBzl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:55:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42759 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934740AbeFZBzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:55:38 -0400
Received: by mail-pf0-f195.google.com with SMTP id w7-v6so7317684pfn.9;
        Mon, 25 Jun 2018 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=vNj3brPn3hWFVdKsJlxA7XhGR3WcUQakLS9U6rElSw4=;
        b=qsBM7/N11svS7ge59K3rS/AUQdC74ji2dPyJ+92CN4oqFh/ylGEkgtrduUtklLl6iQ
         km6KC2rJ4SqPA4bjtOaZx+Kwqrn2kM2SvVcdv0pbogiZL6yq5FQgRIG4DVJyPaWuPWK4
         jZ2Ua4AcHnEK05v573OpBq1f0mMn/XuFgezL1GZ6E15YGJIiov37XX+tP13/DCB+GgVl
         3nCmM63WgGoC8Xqdsm3NJLwlC76JYv8Cx2Rz1/xnxf4JFTgMrSxjXtXjvfGDqrYRFZKl
         OhHQW2YsK+HJ1BQOEdJW2SaVccU7O9fKcYGq8V++ER77IU2q6uLWOE6zPlmBVaTzEEKX
         HbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=vNj3brPn3hWFVdKsJlxA7XhGR3WcUQakLS9U6rElSw4=;
        b=CF9AaXpTCjfhFH62hDcYGpE6j4pEbJ69tMeh1gmtw1LYxl9SZtaVRYgA5z8jyNA3WV
         FIfgcWJ+QsKglu94V89kc9yY01DkbhdgH2hQRzczpVREn78jSofw8zNB7rfxiF0kaJRC
         vSqxoR6n0rYxJ1gKFSfzkLXbwlLp2uwOiA9j0iSC1IWwSUnoVB0wFmPVcy/kdqb4X246
         RjsJrODWqkoWg7YJMhK5Emv3KKPwCIAG+lq3ZIgLNfhrLlAI1RkohqEZZraH8CEkdOzD
         to+LAbgMQiWr6UirK+I8Kg/wOLrvuqf4TRK2ERRFnqqNFJs5HWctiuOFBSihbpmbonCG
         w28g==
X-Gm-Message-State: APt69E0ScCEgyoVjG0PXQxi0Tf+cmzhw3Z1zwYIecB7HJ4hD65R5CwTd
        f+tcwGjMjb8jNa1VzJowo9c=
X-Google-Smtp-Source: ADUXVKKmKnyeC0huPH0xIvlzhTncsxiiGDqwH2wLPDaJxn3N66hlAQ5xCQTOSvJK+wtxGlowho/ulg==
X-Received: by 2002:a62:5d83:: with SMTP id n3-v6mr15346736pfj.68.1529978137882;
        Mon, 25 Jun 2018 18:55:37 -0700 (PDT)
Received: from localhost (45.62.100.246.16clouds.com. [45.62.100.246])
        by smtp.gmail.com with ESMTPSA id s28-v6sm398732pfg.89.2018.06.25.18.55.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Jun 2018 18:55:36 -0700 (PDT)
From:   Lei YU <mine260309@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lei YU <mine260309@gmail.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] clk: aspeed: Fix SDCLK name
Date:   Tue, 26 Jun 2018 09:55:25 +0800
Message-Id: <1529978125-28712-1-git-send-email-mine260309@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDCLK was named SDCLKCLK, and no one has used this yet.
Fix it.

Signed-off-by: Lei YU <mine260309@gmail.com>
---
 drivers/clk/clk-aspeed.c                 | 2 +-
 include/dt-bindings/clock/aspeed-clock.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 38b366b..f49c684 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -109,7 +109,7 @@ struct aspeed_clk_gate {
 	[ASPEED_CLK_GATE_RSACLK] =	{ 24, -1, "rsaclk-gate",	NULL,	0 }, /* RSA */
 	[ASPEED_CLK_GATE_UART3CLK] =	{ 25, -1, "uart3clk-gate",	"uart",	0 }, /* UART3 */
 	[ASPEED_CLK_GATE_UART4CLK] =	{ 26, -1, "uart4clk-gate",	"uart",	0 }, /* UART4 */
-	[ASPEED_CLK_GATE_SDCLKCLK] =	{ 27, 16, "sdclk-gate",		NULL,	0 }, /* SDIO/SD */
+	[ASPEED_CLK_GATE_SDCLK] =	{ 27, 16, "sdclk-gate",		NULL,	0 }, /* SDIO/SD */
 	[ASPEED_CLK_GATE_LHCCLK] =	{ 28, -1, "lhclk-gate",		"lhclk", 0 }, /* LPC master/LPC+ */
 };
 
diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index 4476184..f437386 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -25,7 +25,7 @@
 #define ASPEED_CLK_GATE_RSACLK		19
 #define ASPEED_CLK_GATE_UART3CLK	20
 #define ASPEED_CLK_GATE_UART4CLK	21
-#define ASPEED_CLK_GATE_SDCLKCLK	22
+#define ASPEED_CLK_GATE_SDCLK		22
 #define ASPEED_CLK_GATE_LHCCLK		23
 #define ASPEED_CLK_HPLL			24
 #define ASPEED_CLK_AHB			25
-- 
1.9.1

