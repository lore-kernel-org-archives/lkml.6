Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FFA2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ju0aYP9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732135AbeLQJqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:46:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40722 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732019AbeLQJqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so11526622wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MAoZVGyUyqIgBFjZmHlB19eSlto0aZoSbTGaZ+uSfto=;
        b=ju0aYP9TwSWXr86I68EvqHSMfznus+2y4taD626AEyJQ8pivkVBFmqA1lZo0dF3+8n
         oMhIBEWw3Ak98UO+qQLaGCcj8vlMp1u0qie8op4+DYKI/rgoSKEXaTxUS0NvD52uSCJt
         EMU5uAVjdn/0rTOdtAPD4+qBGXiDqhE8eN8Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MAoZVGyUyqIgBFjZmHlB19eSlto0aZoSbTGaZ+uSfto=;
        b=loROqyw80hP9a2bqWr9haAlkObd51o1Oo6YN8ZwqtxktQQrniAn/GB/ky/CJdPBKTZ
         rbOWsR72OWancxbr6vpXA+tRfaxouX123EK6HxGhzB2GnBoi0rPPpfKajrhLg8hM1m0x
         yAzF+xsDdmSEEHibn7kOfQz2iVS4qWDA7VQ92k/In5tuxwoTjKXvRRvwMT0vLA7iqdFi
         HCngih09g+ZoDnlUSS1ndXVzxWQHgEhlE0kNFdBP713LRRNBP0E7aoWqJpPEiWbadSIi
         olRDNU0ZweNIEX9eBsm4zGky+JZ3ICx/oDSq/JQajqFdjTsOeHygOrd1e/LKApPt9wY9
         3agA==
X-Gm-Message-State: AA+aEWZ0PvkrPbVnabrzVGfFVDrP2sPveSF/ihj2BhWvhBRfZwK5WOum
        /T5+xZCJITwwaJ1Bn95yU+ah8w==
X-Google-Smtp-Source: AFSGD/Xrh7uK6Mu8+N9b9d9Pgvt1vtXG0aJhPLLByVmwbg+okG7Sa8pkk44ta/5GWQAwOEg8cCvHBw==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr8959307wrp.8.1545039997185;
        Mon, 17 Dec 2018 01:46:37 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:36 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
Date:   Mon, 17 Dec 2018 10:46:18 +0100
Message-Id: <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
specifications.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 64da032..833436a 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
 	},
 };
 
+static const struct pll_vco gpll0_ao_out_vco[] = {
+	{ 800000000, 800000000, 0 },
+};
+
 static struct clk_alpha_pll gpll0_ao_out_main = {
 	.offset = 0x21000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.flags = SUPPORTS_FSM_MODE,
+	.vco_table = gpll0_ao_out_vco,
+	.num_vco = ARRAY_SIZE(gpll0_ao_out_vco),
 	.clkr = {
 		.enable_reg = 0x45000,
 		.enable_mask = BIT(0),
-- 
2.7.4

