Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76571C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2647C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rc06VPCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2647C20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937782AbeFSNlZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:41:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53530 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937650AbeFSNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:41:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so457994wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=quzDqe0zMbz+Nefi3/9iRHz8PJBtYJfd8nD3RFDa+BQ=;
        b=rc06VPCdOBMp+2spCQJlK2YdcmFFqjAPo3EG0xpO9nfMEpFj/RZygJKvSO5wLeCa1E
         cSKbI9CRR8UJrwayiXJX/cE5vi6DhHJK9LUJw8JANV1FvX4nBUO+kSIgR+ixL5YzHq+a
         OLrhny0njsrkEYdcUXj8jTPL6BPRjt7ymYsA0yXa0v1MlErMU4KQcG7OtjurIzYsGbn7
         40LbEJqQvnUDkvUJ8to/Y+Dr+sqQmK7OCQGqDihRhtDktrPAzyeNRac4VZ9Z1RsFcAGc
         ba0eMkPwwtjTzhw4G9zEDaquU/pa0sGp8XlPEQHxvsfwx9QSPQggRyJyROimaZcOMRwy
         ROwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=quzDqe0zMbz+Nefi3/9iRHz8PJBtYJfd8nD3RFDa+BQ=;
        b=ijMaPDTYUdAZC0zixjMZXNaVia71lZcxIdqawRV/fPYf149m9jNSqz82HTLT++d2o0
         wymI8MMUsWLH9FhekNspG6S635GYGuxJaG6otoKLrthuXlTujZ+jlGz7KkzI2wLFJIrx
         wVHhKMTrNHcgymr8+zJcNJpgCxJVNKidHMUY6ceKNMtOMCYAO+QcgBoI6di4Q7uw4gEg
         EwxgDdtgeGrCUMy2PxTxSpheyBS6njLfF7CEv58xp3rmQP6bTNA3lRvaxPaxm7XVZBkp
         SoF8qEg/XsfDURSvnpeO+ONlUTxTy22yTCPFdFudljBLdRFH69VZ3Fq3mOdS7M2jzI8J
         Xj6g==
X-Gm-Message-State: APt69E0v1merrRadAVx8kChPXti0C5QCG51Ey04E9YSGe6Pup5cZH+iZ
        M4VV0jOEJ65h+4VN/ypZaD9IKA==
X-Google-Smtp-Source: ADUXVKIfjXh1+Dx4kM3lm8/lRZuMBItPcWKUnaPP00vnXS7d4xEAPu9cqxmVx2Br69GMQG6mwsB5ug==
X-Received: by 2002:a1c:d388:: with SMTP id k130-v6mr11315026wmg.66.1529415662414;
        Tue, 19 Jun 2018 06:41:02 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm17196154wrq.74.2018.06.19.06.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 06:41:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/2] clk: qcom: drop CLK_SET_RATE_GATE from sdc clocks
Date:   Tue, 19 Jun 2018 15:40:50 +0200
Message-Id: <20180619134051.16726-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180619134051.16726-1-jbrunet@baylibre.com>
References: <20180619134051.16726-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the mmci driver (drivers/mmc/host/mmci.c) does the following sequence:
* clk_prepare_enable()
* clk_set_rate()

on SDCx_clk which is a children of SDCx_src. SDCx_src has
CLK_SET_RATE_GATE so this sequence should not be allowed but this was not
enforced. IOW, the flag is ignored. Dropping the flag won't change
anything to the current behaviour of the platform.

CLK_SET_RATE_GATE is being fixed and enforced now. If the flag was kept,
the mmci driver would receive -EBUSY when calling clk_set_rate()

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 3 ---
 drivers/clk/qcom/gcc-mdm9615.c | 2 --
 drivers/clk/qcom/gcc-msm8660.c | 5 -----
 drivers/clk/qcom/gcc-msm8960.c | 5 -----
 4 files changed, 15 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 28eb200d0f1e..5f61225657ab 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1220,7 +1220,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1269,7 +1268,6 @@ static struct clk_rcg sdc3_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1353,7 +1351,6 @@ static struct clk_rcg tsif_ref_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
index b99dd406e907..849046fbed6d 100644
--- a/drivers/clk/qcom/gcc-mdm9615.c
+++ b/drivers/clk/qcom/gcc-mdm9615.c
@@ -947,7 +947,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -996,7 +995,6 @@ static struct clk_rcg sdc2_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm8660.c
index c347a0d44bc8..7e930e25c79f 100644
--- a/drivers/clk/qcom/gcc-msm8660.c
+++ b/drivers/clk/qcom/gcc-msm8660.c
@@ -1558,7 +1558,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1607,7 +1606,6 @@ static struct clk_rcg sdc2_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1656,7 +1654,6 @@ static struct clk_rcg sdc3_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1705,7 +1702,6 @@ static struct clk_rcg sdc4_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1754,7 +1750,6 @@ static struct clk_rcg sdc5_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index eb551c75fba6..fd495e0471bb 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -1628,7 +1628,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1677,7 +1676,6 @@ static struct clk_rcg sdc2_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1726,7 +1724,6 @@ static struct clk_rcg sdc3_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1775,7 +1772,6 @@ static struct clk_rcg sdc4_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1824,7 +1820,6 @@ static struct clk_rcg sdc5_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
-- 
2.14.3

