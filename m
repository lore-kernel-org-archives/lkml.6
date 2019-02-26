Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A83C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87CE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRoL17ql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfBZHBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:01:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39754 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfBZHBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:01:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so5244718pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 23:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QttOz8KAk5HTV2qQPu3H+rSCJ+Pe4jsGqkjtfi076ts=;
        b=kRoL17qlnGXp14y62Kj2jmQN18xp96F19TLL45rzeKqGqKGkiAyKrV6IdZhECFaYbs
         NbMpg/07HN6F4OZYTdx5PxkmFkFPsvFZOfGqq+Q9lrJPa6JJEx7Oe+Csolz9MYLqDBFd
         QRRcv80m17j9ZyYVmOQUPlCfzo8uKzoJRicpuuvLeYvmkb6MJBRVR+cGN2hkJamY8Qv+
         jRHoNEozhpwUueU9w1CYpiy9odi8Ro1n90u5QygBtIGRsncLAX13dErn0ccfi2PoFrD7
         PoGx/FvIZlAlXvSvgpjDTZCI5cb0Oo31TAy04LmhYazMnfvx7enUbKe/I9oZ2onSKGaQ
         AAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QttOz8KAk5HTV2qQPu3H+rSCJ+Pe4jsGqkjtfi076ts=;
        b=NJ6qSttJTyeSAlSE5F0hemJ02Va8j22Rda1YMPHk9cLCpbkKpRdv6dsFfMjyoGI7Tf
         P3/j73bWuW8vK6rVwkWWw4mbB/Iyqk+YpTq16/hGbg0/45PNeBKcTjG/jkeIZxtrvqty
         npCU6t8iF+Hdd7y+P3NcJxJJV/q875e4CMhigq9YSgNLa1Olx7l3QHmfDbh9GZEV1W3F
         RiVamRf/1w5bCA2zEeVeYUXk9TU3jIPiar2/yNm/joxXX0K6YhnddgY4GL8WSQv8KsTG
         XQaJAey7dukNBYQhlS4C2oGn1jOyWNvmOoH5aBHkO8/Hra/8xPck50ej2ubO1KuqRPhI
         7NDg==
X-Gm-Message-State: AHQUAuZgRNWuWUiyeeoEJPjY32XctNut/L1f75lepUghvzO+L5/NksCY
        6RpgrND+/+vofZWoEyMo79+glQ==
X-Google-Smtp-Source: AHgI3IbbIEYQomxqLl908709DI9aXcQAOzkuApX8mysPdcH38QHhMsvvqDQzM+SLUEsjxvfzwI8EWg==
X-Received: by 2002:a62:61c4:: with SMTP id v187mr23953793pfb.133.1551164509636;
        Mon, 25 Feb 2019 23:01:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j24sm18324829pgl.58.2019.02.25.23.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 23:01:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sdm845: Define parent of PCIe PIPE clocks
Date:   Mon, 25 Feb 2019 23:02:21 -0800
Message-Id: <20190226070221.22382-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe PIPE clock in the GCC is fed by the PIPE clock coming from the
PHY, describe this relationship.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 58fa5c247af1..7131dcf9b060 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -1703,6 +1703,9 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk",
+			.parent_names = (const char *[]){ "pcie_0_pipe_clk" },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1802,6 +1805,8 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 		.enable_mask = BIT(30),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk",
+			.parent_names = (const char *[]){ "pcie_1_pipe_clk" },
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
2.18.0

