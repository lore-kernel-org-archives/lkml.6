Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD156C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2282175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S5Da9fZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBGN0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:26:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40621 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfBGN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:26:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id q1so1550817wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 05:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irDAtFzSD44qLeuz7xjCo1buACjRBJTzikViM/uGxI0=;
        b=S5Da9fZBJtEVAWWpk+jta2WSGqpAaCJdGgrZTstXL7WFAb2jyq8mKFO41p2tZoHp7d
         jHxRFGxUHbmWUhrOXy80xupoIv1ONEALGDpqgyPhNbZAc7wpS/B40GqfLttcMqguAo72
         a23fq+kqTsWDfAClOwNS73XURxWD1cJ7xbhCBpRjCZWw7XrxOzRtHsY+WSs3JVtvWU3k
         7+D4uMk3IRvN25RuVMScTUnwxHTpT1XJQiwUwy+LYpqkZZ2uC94WLRBiqvMGhBvVv4cB
         A8cJMnI5lBAO9ZGgN/DDYKjEN1z0YZevqJuvpqJUpm2n4yLiIChMUy66fMDZpzzPIcZn
         4sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irDAtFzSD44qLeuz7xjCo1buACjRBJTzikViM/uGxI0=;
        b=pWhBO23oOOjryKhoPIc1ScHyM/jakSoOz6ThkCLSbkaPHTnGxusu9KECC9yGIWKCUL
         bEG94Jsg4bplYqF3+FDL2FVx9Pqk8Bbu8brOePb2gBQ5Y6oQZ/dYqMPRy0TXcK4oQE2y
         xQmcusz9wNobbkfYTqDPersUwGlvsAbTZ80KehUaqhWNsflznJBQkn87F7cvrLvyymVw
         PVmC4H30vh06w0lbKJLWzRX31Xg9kvB3swD5LxXsuMu2CM9PJ2GJ4e2/OvSJyLPyQn7u
         7gWH+CkBet3OB38djWkH6rzOfPHZ2jVCOw8+Pan2RtageYvU6hZcTT5XOKB01CynBxBx
         bwPw==
X-Gm-Message-State: AHQUAuaKVVt+PumR6gG4CTbPOb06obxUXQFd8Qd1yWO94G9TLlnC9RqV
        FWaktxKnCHlEwObhO0JCoM3qnA==
X-Google-Smtp-Source: AHgI3Ib7ZCQFroZzzM/u4zeLJ/0xQRPB/GHYwz8CzjqiGhLq8Xhb8jSxRw/MQHEcZ1VgEmBPLTGRag==
X-Received: by 2002:a5d:6b05:: with SMTP id v5mr3684072wrw.76.1549545986212;
        Thu, 07 Feb 2019 05:26:26 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id v22sm11061612wml.37.2019.02.07.05.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 05:26:25 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] soc: amlogic: clk-measure: fix-up some clock definitions
Date:   Thu,  7 Feb 2019 14:26:03 +0100
Message-Id: <20190207132603.694-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207132603.694-1-jbrunet@baylibre.com>
References: <20190207132603.694-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out in review, a few clock are not properly defined.

Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Fixes: 2a4c63e080cd ("soc: amlogic: clk-measure: add axg and g12a support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 drivers/soc/amlogic/meson-clk-measure.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 5570180b94a1..19d4cbc93a17 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -202,7 +202,7 @@ static struct meson_msr_id clk_msr_axg[CLK_MSR_MAX] = {
 	CLK_MSR_ID(71, "audio_slv_sclk_a"),
 	CLK_MSR_ID(72, "pwm_d"),
 	CLK_MSR_ID(73, "pwm_c"),
-	CLK_MSR_ID(73, "wifi_beacon"),
+	CLK_MSR_ID(74, "wifi_beacon"),
 	CLK_MSR_ID(75, "tdmin_lb_lrcl"),
 	CLK_MSR_ID(76, "tdmin_lb_sclk"),
 	CLK_MSR_ID(77, "rng_ring_osc_0"),
@@ -268,6 +268,8 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(26, "sc_int"),
 	CLK_MSR_ID(27, "in_mac"),
 	CLK_MSR_ID(28, "sar_adc"),
+	CLK_MSR_ID(29, "pcie_inp"),
+	CLK_MSR_ID(30, "pcie_inn"),
 	CLK_MSR_ID(31, "mpll_test_out"),
 	CLK_MSR_ID(32, "vdec"),
 	CLK_MSR_ID(33, "sys_cpu_ring_osc_1"),
@@ -303,8 +305,8 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(65, "spicc_0"),
 	CLK_MSR_ID(66, "vid_lock"),
 	CLK_MSR_ID(67, "dsi_phy"),
-	CLK_MSR_ID(68, "hdcp22_skp"),
-	CLK_MSR_ID(69, "hdcp22_esm"),
+	CLK_MSR_ID(68, "hdcp22_esm"),
+	CLK_MSR_ID(69, "hdcp22_skp"),
 	CLK_MSR_ID(70, "pwm_f"),
 	CLK_MSR_ID(71, "pwm_e"),
 	CLK_MSR_ID(72, "pwm_d"),
-- 
2.20.1

