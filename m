Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B85C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 05:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0E021473
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 05:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="r5DC+eJA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfA0FKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 00:10:32 -0500
Received: from mx4.ucr.edu ([138.23.248.66]:34392 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfA0FKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 00:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1548565832; x=1580101832;
  h=from:to:cc:subject:date:message-id;
  bh=/KqbmcKVen34Q5JOyYcFb+/FPRQaSMEFS+uDTyuJnZM=;
  b=r5DC+eJAPtE3/ZpVo7H6ERNggFu1P0aYKHDM8fB5G1vKzm+x3jDor1Kh
   T23zI0/FnQj1x93nl334hlBYczUeAjEffP0KFjASnZ+l204vZEDJYPDGL
   iOSkG9XBsUqqqv/6eMEo7GtBw4yojshW4f+WuS7cVLhYmnVi++FTAdN/9
   4CSAp7cFSNIHknxSc4NfJVq8ievv+W2S6krvpeSxs1mHByyqrPH3xTDTC
   M/8xODbizc0Kea7DQKoZ9En76b5PWF0P3QbUfAILMwAk+R2MBBTxaGCvf
   Pgev1ItRnzEE00fCvSLT9jZZGSYR2l0f3/Vo1F0VilaT/qa5/npFGgEk1
   w==;
IronPort-PHdr: =?us-ascii?q?9a23=3A/naN9RHoBM/4W6rOW5pg1p1GYnF86YWxBRYc798d?=
 =?us-ascii?q?s5kLTJ78r86wAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk1Nou?=
 =?us-ascii?q?QttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZr?=
 =?us-ascii?q?KeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1xDHuGFIe+?=
 =?us-ascii?q?NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PGAu+MLrrxjD?=
 =?us-ascii?q?QhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC+85Kl3VhDnlC?=
 =?us-ascii?q?YHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6PYfNMaXnFBXsdXVyxOH4iy?=
 =?us-ascii?q?cZIBBPcPPeZZsYb9o0YBpga6CQSiGO/jzzlFjWL006InyeQsCQHI0hI9EdwAs3?=
 =?us-ascii?q?raq874OLsOXe2v0KXF1ynPY+9Q1Dzg6IbIaBchofSUUL1ycMrQyEkvFx7Cjl6N?=
 =?us-ascii?q?roHkPzKU1uQXvGia8+ZsSeyihnU6qw5tuDij3NkjhZTUho8MzF3P6CZ3wJ4tKN?=
 =?us-ascii?q?GmVEJ2ZcSoHZhQui2AKYd6X8wvT3t1tCs+yLAKoYO3cSkOxZg92RLSZfyKf5KW?=
 =?us-ascii?q?7h/iTuqcIzh1iXR4c7ylnRmy61KvyujkW8mx11ZFszRKn8HXtnAIyxzT8s+HSu?=
 =?us-ascii?q?Zh/ku52TaAyQTT6uZcLEAxj6XbKpohzqcolpoXrEjPByH2lFjygaKUbEkk9e+o?=
 =?us-ascii?q?6+PoYrXiuJCQLZN7igb7Mqg2m8y/B/o3MhQWUmSF5eix0Kfv8E75TblQkPE6j6?=
 =?us-ascii?q?bUvIrHKckfpKO1GwpV3Zwi6xa7ATemytMYnXwfIVNFeROHj5LmO1DSLPzkA/qy?=
 =?us-ascii?q?mEmsnytxx/zcILLuH4jNImDZkLj9ZbZ991JcyA0rwNBb5pJUDKwBIf3qVk/yqt?=
 =?us-ascii?q?PYFBk5PBKww+v8FtV92Z0RWXiVDq+aLqzSq1mI6fwrI+WWY48Vojn9eLAL/fnr?=
 =?us-ascii?q?2E44i18AeuH9zIkXYXHgRq9OPk6DJ3fgn4FSQi8xogMiQbmy2xW5WjlJaiP3AP?=
 =?us-ascii?q?ox?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AfAAAAPU1cgMXWVdFjHAECBAEIBAGBU?=
 =?us-ascii?q?gcBDAGEBQ+MG1+LFE8BAQEGgjGITG2FV4JyhQqBewEKAQEshECDDCI0CQ0BAwE?=
 =?us-ascii?q?BAgEBAgETAQEJDQkIJzGCOimCXzZSgRUBBQE1W4JHAYF0DQWdSjyMFzOIUAEHg?=
 =?us-ascii?q?UsJAQiHboRBgQ+BB4ERgl2IU4JDAoEsAQEBj22RKgEGAgGBY4FCjn0kgzGGc4g?=
 =?us-ascii?q?HAS2aeAIEAgQFAgUPIYElgg5NJYFsCoFEglGOLB4zgQeLVwE?=
X-IPAS-Result: =?us-ascii?q?A2AfAAAAPU1cgMXWVdFjHAECBAEIBAGBUgcBDAGEBQ+MG1+?=
 =?us-ascii?q?LFE8BAQEGgjGITG2FV4JyhQqBewEKAQEshECDDCI0CQ0BAwEBAgEBAgETAQEJD?=
 =?us-ascii?q?QkIJzGCOimCXzZSgRUBBQE1W4JHAYF0DQWdSjyMFzOIUAEHgUsJAQiHboRBgQ+?=
 =?us-ascii?q?BB4ERgl2IU4JDAoEsAQEBj22RKgEGAgGBY4FCjn0kgzGGc4gHAS2aeAIEAgQFA?=
 =?us-ascii?q?gUPIYElgg5NJYFsCoFEglGOLB4zgQeLVwE?=
X-IronPort-AV: E=Sophos;i="5.56,528,1539673200"; 
   d="scan'208";a="24248461"
Received: from mail-pl1-f197.google.com ([209.85.214.197])
  by smtpmx4.ucr.edu with ESMTP/TLS/AES128-GCM-SHA256; 26 Jan 2019 21:10:28 -0800
Received: by mail-pl1-f197.google.com with SMTP id j8so9425771plb.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 21:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wauu6KYLbGTtY8Ta9/ThAgOWsZRHbAT3Gm7KGlRzDSw=;
        b=mtgtQO73lxPTYoFnvGl4tTEm9OK9SE7IiwRbjyhFvdN8VHVKyvtgJ/navPwqijCV/N
         Q75eSRXpEpE8jogNwnulU/P86L50LibuwrlvGocNoM/o3irtBDh/woTQaKwq3/E6E55k
         K0T4LdxiEwCG6kXEFm16DPlCLqqJVFkuzMl8yCbQAn50zAj4iB5v9u2bme5Vuntf4a7W
         hzeCWXdZHl+SfB0EdqVkwLqYs6ULt7qGSd69FoHUh5c3iNETqBQuYC89rOom51tXNS+V
         9Paq64sLCpbzAUAjggCFepI/3r7y1QKqJF3FpDvCYxbcLZ1BxrhF5j6oksJ7/dU9obxo
         qStA==
X-Gm-Message-State: AJcUukdqf0dkWqSq4AmfWIjSRLqC1I2Gpxp0QLU3P30v6OL70LRvKUQI
        bW39nSUog6roCgYN89fKwqF6jg+e2cT4Ewg/P1Bi1BvP5tOIqcJR8hLdrC722AKjHrtBrM7FCa8
        x6al9biMt8nsyiwWROnRC4Smpgg==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr16882479plb.46.1548565826703;
        Sat, 26 Jan 2019 21:10:26 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4dKbvNFSx1d1HieEDycemd1AM2ehrWLXL7OBvnQT5AFZzdgEXdUSA5frObuY4mdQzStbaWcA==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr16882459plb.46.1548565826315;
        Sat, 26 Jan 2019 21:10:26 -0800 (PST)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id y5sm50574978pge.49.2019.01.26.21.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 21:10:25 -0800 (PST)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: gemini: Variable "val" in function gemini_clk_probe() could be uninitialized
Date:   Sat, 26 Jan 2019 21:10:12 -0800
Message-Id: <20190127051012.5928-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function gemini_clk_probe(), local variable "val" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used as index in the later context, which
could potentially be unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/clk/clk-gemini.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
index 5e66e6c0205e..07e1b551d1d9 100644
--- a/drivers/clk/clk-gemini.c
+++ b/drivers/clk/clk-gemini.c
@@ -314,7 +314,10 @@ static int gemini_clk_probe(struct platform_device *pdev)
 	gemini_clk_data->hws[GEMINI_CLK_RTC] = hw;
 
 	/* CPU clock derived as a fixed ratio from the AHB clock */
-	regmap_read(map, GEMINI_GLOBAL_STATUS, &val);
+	ret = regmap_read(map, GEMINI_GLOBAL_STATUS, &val);
+	if (ret)
+		return ret;
+
 	val >>= CPU_AHB_RATIO_SHIFT;
 	val &= CPU_AHB_RATIO_MASK;
 	hw = clk_hw_register_fixed_factor(NULL, "cpu", "ahb", 0,
@@ -323,7 +326,10 @@ static int gemini_clk_probe(struct platform_device *pdev)
 	gemini_clk_data->hws[GEMINI_CLK_CPU] = hw;
 
 	/* Security clock is 1:1 or 0.75 of APB */
-	regmap_read(map, GEMINI_GLOBAL_CLOCK_CONTROL, &val);
+	ret = regmap_read(map, GEMINI_GLOBAL_CLOCK_CONTROL, &val);
+	if (ret)
+		return ret;
+
 	if (val & SECURITY_CLK_SEL) {
 		mult = 1;
 		div = 1;
-- 
2.17.1

