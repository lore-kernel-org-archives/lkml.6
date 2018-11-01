Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F5204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba2j8U9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeKAWSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:18:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45270 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeKAWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:18:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so18008830ljc.12;
        Thu, 01 Nov 2018 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3pv2G7gSVJDRDILlpFOB0c/JOxx5Q6+GpDJMALNQ8Y=;
        b=Ba2j8U9I708Y3e6IyZNdqXVvqBY3BkM7fmnqK/al/3QeWkXte3vTv599Zt9R5Ve83Z
         6C3VCgOVxJMAL7hQ9MFp7T/p0i2Mc3i3EnVWDyLPmma4CXsv2S7bwudOPIcsr0J91C++
         HHqsQTpICE5g9IZs5nj3lVg8EBPhO2RSRmnhuHV/Hruvn8y5X3d1pBOgcJsOJ/3edF7I
         y6P98QhI7gu+XY7QKWcB1r0tN+1f4JRTU64LQcVDPyf+TadZ9oR4IGQPjXt8JlKNwtac
         /vetZy6V63D67S5CUAmyEjOj+1NHPTLutFahQegleFQDnFgGdz7d1m+tnBXLtUYVS0GG
         BmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3pv2G7gSVJDRDILlpFOB0c/JOxx5Q6+GpDJMALNQ8Y=;
        b=Fhd9Eoyjv/Ip5y9L1CnTpBbr9l0fsqXfW69JFNegibX/yWRaTS7LLeAEml/Uts0909
         ZZ/zrgIKALSn8lXFOLE6j1AEOCUT1b4lr44qYTJ32IBpXL5XGsGV8wo/XY4kQfotzuWh
         FE5RAZWOqJDdUfWjAoRmwB+7vGUWyMLxxEfeWbvx56nrn1ZdOzIjJ3CGLJgsaC2w2Sx7
         B/BXsZMnYsk9kW5d8JqhtOIHys2JSUHJMxyAAC/Kei7KjmKEFDoNxFwH6l4L74i7EG+3
         Pr29kMAPI1T2w4vXWa26jTeTqXCmf5VDf78n8DqrpEFJFzInidQ1WFklPWyqvUFOjW/z
         CBnQ==
X-Gm-Message-State: AGRZ1gLS0GeQG5lkLc3KP1F2n1B8VM3qvMca3GyMO0BrZ5Ej/fk6/LAs
        7hg4Ys3xHA9XJjyq/NweumcNcpvu2mc=
X-Google-Smtp-Source: AJdET5ddsk9S0hLvya2w9nWUDevRrcCOGxBneehFhUoy0+mmVmo+J8yLesRMnS9Hz4uikgDsCsdORg==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr5360401lju.8.1541078152899;
        Thu, 01 Nov 2018 06:15:52 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id 66-v6sm390741ljj.13.2018.11.01.06.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 06:15:51 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Alan Tull <atull@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] clk: fixed-factor: fix of_node_get-put imbalance
Date:   Thu,  1 Nov 2018 14:15:49 +0100
Message-Id: <20181101131549.24497-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the fixed factor clock is created by devicetree,
of_clk_add_provider is called.  Add a call to
of_clk_del_provider in the remove function to balance
it out.

Reported-by: Alan Tull <atull@kernel.org>
Fixes: 971451b3b15d ("clk: fixed-factor: Convert into a module platform driver")
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/clk/clk-fixed-factor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 20724abd38bd..7df6b5b1e7ee 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -210,6 +210,7 @@ static int of_fixed_factor_clk_remove(struct platform_device *pdev)
 {
 	struct clk *clk = platform_get_drvdata(pdev);
 
+	of_clk_del_provider(pdev->dev.of_node);
 	clk_unregister_fixed_factor(clk);
 
 	return 0;
-- 
2.19.1

