Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06098C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C052133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039637;
	bh=oNqG+UnI4PcR4d88PxqYvYJCYc1RgxUQMivrVyd8o2Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=I5fdHMD4l4CPJ8OH7kMKVHq6+6ZmMseMrfxNDb9OBHp+rjzMRxW805NTmeaaN6r1V
	 ysUaRNRIWelfrY0mYLabE5MOEqBHD3doLidvSCva3MQG/azGocZjTfaI5/oyvCwTuo
	 0sFKPOnuCDNZT95heNtF7sph2sM9nl54kpVB9KdY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C052133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeLETx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:53:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37584 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbeLETu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so19801522oth.4;
        Wed, 05 Dec 2018 11:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qMf/8b8HPdVUaDDlxlxbmj1xfhA6XtWizfCJKwehYSU=;
        b=T6uCCHPpvMBGqcCT76BgHw9dl6mLANprobfA8VHQmQJnYbNDgm8SbbYckGskBpaZLa
         /ETqUtLTY115Vr6tKXMAsadLBaNsgjqzJNTn/vHSFvl5mf85J/9O0e49MXq7HtbJHVbr
         PsJBX+ztUZ2krj6ko8TJ5Bukv0AGv+dbekyzz6WUa289kGs+eEZNr1jsw24N5QG3aF5z
         P93URXiNNceQXQ86DWO3/lqiY7haTP96YuGhramfxrR6QFE2K1OyMQNL6a1qqoTNJWlp
         5oZlJXmNUYOM9ZNnybCbz5c3QeyENgFp7/nV2vc9gJ51oJ8BqT6tqkCnAo3S/z/8K8X2
         VIUg==
X-Gm-Message-State: AA+aEWZvqEwMJ+3DkOe3b7c3q+Ea/QBtQCUL8aMhHh2FSXvbzBIGREZ8
        s+XagDdnPxkd+9e7ywYnLvnl9Qo=
X-Google-Smtp-Source: AFSGD/Uto0OjqNOmEsHFK57ZDUo6dZJqoQDrNSvkN0UuQUlPmALMlrnVcywX5kxxgjKsaDeXw7i4cg==
X-Received: by 2002:a9d:5e0b:: with SMTP id d11mr15115452oti.145.1544039456498;
        Wed, 05 Dec 2018 11:50:56 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:50:55 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:21 -0600
Message-Id: <20181205195050.4759-5-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/renesas/clk-mstp.c   |  2 +-
 drivers/clk/ti/clkctrl.c         |  2 +-
 drivers/clk/ti/dpll.c            |  2 +-
 drivers/clk/ux500/u8500_of_clk.c | 10 +++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 1c1768c2cc82..765175d1148a 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -280,7 +280,7 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 			goto found;
 
 		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock */
-		if (!strcmp(clkspec.np->name, "zb_clk"))
+		if (of_node_name_eq(clkspec.np, "zb_clk"))
 			goto found;
 
 		of_node_put(clkspec.np);
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 469f560ae1cf..40630eb950fc 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -448,7 +448,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	char *c;
 
 	if (!(ti_clk_get_features()->flags & TI_CLK_CLKCTRL_COMPAT) &&
-	    !strcmp(node->name, "clk"))
+	    of_node_name_eq(node, "clk"))
 		ti_clk_features.flags |= TI_CLK_CLKCTRL_COMPAT;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 92e28af7afba..6c3329bc116f 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -410,7 +410,7 @@ static void __init of_ti_omap3_dpll_setup(struct device_node *node)
 
 	if ((of_machine_is_compatible("ti,omap3630") ||
 	     of_machine_is_compatible("ti,omap36xx")) &&
-	    !strcmp(node->name, "dpll5_ck"))
+	     of_node_name_eq(node, "dpll5_ck"))
 		of_ti_dpll_setup(node, &omap3_dpll5_ck_ops, &dd);
 	else
 		of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index d5888591e1a9..18a3c4522831 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -545,21 +545,21 @@ static void u8500_clk_init(struct device_node *np)
 	for_each_child_of_node(np, child) {
 		static struct clk_onecell_data clk_data;
 
-		if (!of_node_cmp(child->name, "prcmu-clock")) {
+		if (of_node_name_eq(child, "prcmu-clock")) {
 			clk_data.clks = prcmu_clk;
 			clk_data.clk_num = ARRAY_SIZE(prcmu_clk);
 			of_clk_add_provider(child, of_clk_src_onecell_get, &clk_data);
 		}
-		if (!of_node_cmp(child->name, "prcc-periph-clock"))
+		if (of_node_name_eq(child, "prcc-periph-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_pclk);
 
-		if (!of_node_cmp(child->name, "prcc-kernel-clock"))
+		if (of_node_name_eq(child, "prcc-kernel-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_kclk);
 
-		if (!of_node_cmp(child->name, "rtc32k-clock"))
+		if (of_node_name_eq(child, "rtc32k-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
 
-		if (!of_node_cmp(child->name, "smp-twd-clock"))
+		if (of_node_name_eq(child, "smp-twd-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, twd_clk);
 	}
 }
-- 
2.19.1

