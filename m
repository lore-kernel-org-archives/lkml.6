Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1A1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10BB2156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsJ/2Ggl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10BB2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391609AbeIVDwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:52:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32845 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391323AbeIVDwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:52:47 -0400
Received: by mail-io1-f67.google.com with SMTP id l25-v6so455156ioj.0;
        Fri, 21 Sep 2018 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e4d6SUz6jd2Yml7+iF79CF3Q+GxZN3hRxdA7HUKhIP4=;
        b=OsJ/2Ggl+ckSFSzEKWF9T7LdkGEJLU6CpsGloK8cr1stHpIw0kryPPr5PJVuaVlmDm
         yfw+w1RJNTtBul51TnSnRRGLg3jF5naGrGg1oqDH6sMKeAJv1VWOce7a6BUlZ92kNGHB
         OeQIX7N8gyGj+OjRua3F8rD7SFqgfvdB96z9RCJP1lhUZgJEZASlrefDzfjxPWg4G+zb
         Xe/Ef2Dte4FeWQ5O8CY5JVIAo8mnh2yvO3UmLAZXggFW3v8jKO5GNG9r0NSq7uFsrv0C
         Kmjmi/PKOM+L9j8UEVPlHhdsj2IzM+NjxGnlPloetfizpoQ34FrbmpP3jouIdCbAq+NT
         SYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e4d6SUz6jd2Yml7+iF79CF3Q+GxZN3hRxdA7HUKhIP4=;
        b=nVOrDOArGjfDYGy3W1VKzUuIAVN6+/4pynf0VEYzv5tZZmZ6Km3ur9wm9EslvdaEaK
         5J5iFmxRP+a5H1ieRBihVkP2JBCB8L/XsezWrioexJPeQb4W6UQMyiZRBqh9X0MYx5Hd
         jdIElaDS3eTLq6qnKTl1sbxmnbG3vfYakCfehR5ijHXTo6P5Ql9T/5/hW6ABnE+yAAYv
         rzhkKXeqJlkWFaj3/E1JrnMDN0ZOTW7fNt1vsRSYC7a+Sku4ThN8tfcynV5wxETQJh6z
         XvGsUqO7M+J+5wZ7Wq8kZgYNUoKj1gL9XJSqj9pyyvISkG3GvAFVRxsI9hLMdtRq96Fd
         wfSQ==
X-Gm-Message-State: APzg51B+Syoq1tbBU7iu7egOGdrUQ4f/Wp9AwaKUqwwp+DcGsLJKcHDw
        /2fKEintF3dsay2VM+P8UzGXQ20+Jg==
X-Google-Smtp-Source: ANB0VdYwQ6V1x5IxCC5jgVgYRDnOM/gKEclPaK9SFOqyIUOfcdxBlZ2uto3YXG0sMWo5067POVwdcQ==
X-Received: by 2002:a6b:e15:: with SMTP id 21-v6mr38771075ioo.149.1537567318608;
        Fri, 21 Sep 2018 15:01:58 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id w140-v6sm223101iof.22.2018.09.21.15.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:01:57 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryang <decatf@gmail.com>
Subject: [PATCH] clk: tegra: Return the exact clock rate from clk_round_rate
Date:   Fri, 21 Sep 2018 18:01:49 -0400
Message-Id: <20180921220149.17136-1-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current behavior is that clk_round_rate would return the same clock
rate passed to it for valid PLL configurations. This change will return
the exact rate the PLL will provide in accordance with clk API.

Signed-off-by: ryang <decatf@gmail.com>
---
 drivers/clk/tegra/clk-pll.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 17a058c3bbc1..36014a6ec42e 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -595,7 +595,12 @@ static int _calc_rate(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
 		return -EINVAL;
 	}
 
-	cfg->output_rate >>= p_div;
+	if (cfg->m == 0) {
+		cfg->output_rate = 0;
+	} else {
+		cfg->output_rate = cfg->n * DIV_ROUND_UP(parent_rate, cfg->m);
+		cfg->output_rate >>= p_div;
+	}
 
 	if (pll->params->pdiv_tohw) {
 		ret = _p_div_to_hw(hw, 1 << p_div);
-- 
2.17.1

