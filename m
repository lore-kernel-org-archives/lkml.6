Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F6BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAEE23C7F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE7XALWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAEE23C7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934380AbeFVDBL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:01:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40393 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934078AbeFVDBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:01:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id z24-v6so2477927pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=br27qigXAuSSoszsGJOL/ASyAImutwIY1+PKrGzqiXw=;
        b=XE7XALWKAU9fJ3H7r7Nnf/kBm0w75Np6OUuMmGlVvSoJoMYVhZx9WFe7cryUjdH67f
         7PNkvGt+9ayKlawKEZL6tXC/81b/5M0awMJGSEIQ4wz5tqYKxNhDxUfvb96GerjKya/K
         v/GcbfRljMIUPgYlqfoK3/5bZzdBrZ9fEZLD/zkqQG4Auxx7cCrPw2/zu2yfxT/mShHR
         ME8RLHz0y8TQ54L3lgze8qXHxZSt98nh0DM2QTeIkVr5K/NDY6HXP0MwdlQHpJsy6R+/
         Gs/eGFDvV9LLDo6E7wumyZVvEQtqhLghDnvNgwWPItqqVUDv4VTxcetl0WGhBa3ePQOV
         xMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=br27qigXAuSSoszsGJOL/ASyAImutwIY1+PKrGzqiXw=;
        b=Ggvf/LOAwou9RyDyGqE/uaq8BW/Ur+jCCwkx1jRSFp1di4GK9UFWVgjn9tC+xP7L7c
         +PrHqwq+TnVNsMcVoIq+XuDrvpjG+5M7a5f90THXIMUDut7XC8LopAkqHAk5JOMkapTl
         GY7oehNq1Lgz1qKZPtgMqDR1chCVsU0KP8HQU1cpOOIE4fBsMxCwf2pbXa2hhsFyqv9N
         oQQLpb1cZbYVIIWb7dlQvVadBx//ahKAZqEUCN249sF+AooeY9CFmNFiZuTCFHjxVeSz
         OFQe9qKnAT1uZyfV7lgwlbuyqNwbfQjoXjrn6aXhoBf6RX4TeMoJltOOkX5m6jZAxFj3
         8tEg==
X-Gm-Message-State: APt69E2ovop28/r1/nRzzsBHmVpd0AkiU7FtFUPqyMXHnixbHpbFrIcf
        HDwDuHHrOzoIjqiTMtVOvfY=
X-Google-Smtp-Source: ADUXVKIzTY+0qqSrho2HblY8f2NUDYVAjFfhKaPMznyBiGSn5efJczBTa5X7riTb/8LhaKd3NnKAuA==
X-Received: by 2002:a65:6190:: with SMTP id c16-v6mr23851182pgv.405.1529636469469;
        Thu, 21 Jun 2018 20:01:09 -0700 (PDT)
Received: from localhost.localdomain ([115.97.186.211])
        by smtp.gmail.com with ESMTPSA id c4-v6sm12890783pfe.53.2018.06.21.20.01.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 20:01:08 -0700 (PDT)
From:   Chakra Divi <2chakrass@gmail.com>
X-Google-Original-From: Chakra Divi <chakra@openedev.com>
To:     Robin van der Gracht <robin@protonic.nl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chakra Divi <chakra@openedev.com>
Subject: [PATCH] Fix for clk disable issue on imx6ul
Date:   Fri, 22 Jun 2018 08:25:19 +0530
Message-Id: <1529636119-4076-1-git-send-email-chakra@openedev.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isiot engicam board is not booting after the
commit cf091ee994ec266e33c3a305d6fc8c5ccb1f8acd
done by <robin@protonic.nl>. Modified the
commit to support imx6ul based SOMs too along
with imx6ull processors

Signed-off-by: Chakra Divi <chakra@openedev.com>
---
 drivers/clk/imx/clk-imx6ul.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index ba563ba..69ec9f0 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -80,7 +80,7 @@ static struct clk *clks[IMX6UL_CLK_END];
 static struct clk_onecell_data clk_data;
 
 static int const clks_init_on[] __initconst = {
-	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2,
+	IMX6UL_CLK_AIPSTZ1, IMX6UL_CLK_AIPSTZ2, IMX6UL_CLK_AIPSTZ3,
 	IMX6UL_CLK_AXI, IMX6UL_CLK_ARM, IMX6UL_CLK_ROM,
 	IMX6UL_CLK_MMDC_P0_FAST, IMX6UL_CLK_MMDC_P0_IPG,
 };
@@ -358,7 +358,9 @@ static void __init imx6ul_clocks_init(struct device_node *ccm_node)
 	clks[IMX6UL_CLK_GPT2_SERIAL]	= imx_clk_gate2("gpt2_serial",	"perclk",	base + 0x68,	26);
 	clks[IMX6UL_CLK_UART2_IPG]	= imx_clk_gate2("uart2_ipg",	"ipg",		base + 0x68,	28);
 	clks[IMX6UL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf",	base + 0x68,	28);
-	if (clk_on_imx6ull())
+	if (clk_on_imx6ul())
+		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		base + 0x68,	30);
+	else if (clk_on_imx6ull())
 		clks[IMX6UL_CLK_AIPSTZ3]	= imx_clk_gate2("aips_tz3",	"ahb",		 base + 0x80,	18);
 
 	/* CCGR1 */
-- 
2.7.4

