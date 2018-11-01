Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E7F2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB7R1jX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E7F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeKAXoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:44:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38840 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbeKAXoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:44:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id q186-v6so4925436ljb.5;
        Thu, 01 Nov 2018 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7cG9+lND0TeXnC58usBu2VlJeXHav7G6dAR1Cn7V68=;
        b=aB7R1jX5SVcCqw39f3ZlbkCK/IYmEfcjJVGJm0o2JrewKTq0J5NcaFHeZOh2v84UWJ
         b+5tunaA/zWFIy5mOPLQf4+iUFJM5SCW0t0N5esQF2aL2CIXXykoTZMnpzPyk+bE2jAs
         aE8w4wEMxys1zNmlnxsqNbYS+2Szv7NeEE4rD2KAFiwR1UYalySpvhL5QzdtWlVeYeo3
         Cd7y/e/5sD/Cpr0XSGEKOFVn7GbCCNvVbmVFsn8T+DtMVBuaysQNY/oWI9OP/8Aipxu2
         uSbfbFukCT+XGodXBCC3eZL3dvYnBI1Ri0GJnMvRwCSgB4ShwZT8fFNapGNlFkLpGuLd
         n/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7cG9+lND0TeXnC58usBu2VlJeXHav7G6dAR1Cn7V68=;
        b=GlEBC9v7NG9SZ3Sxqylk7RXCgxb+Eu4c3hW+f1BdIArB3ckuQLtaVari8sX+ppG4uF
         fTL2+/hVVVxe+FFl4l1Y1F+44u5+TdbPlZAu5RrF0NI4SYevOdro2L7O576tkuhIJrkI
         O3/qaVBsI8Cx5pcLaeX2PPU9TMcWVFuNphLgvdp3KqgC4w/5YhlU/Wa9sVzRV+nDVT2E
         Za5AX1TQSyTcrxB16ezIK1RV28RBE9pubGP0N++0kV8rUMVwI0thapvqB7eFKrwrFqx0
         V3uvOOFWDIARfQWeRNydT4RjygQHiXpcqidxIKRnKs9jc4+XDKmoZeJKCxDsIpmQW3lf
         ysgQ==
X-Gm-Message-State: AGRZ1gJGOA2byxcE7WL0sVDJ5EPnA3KVE62Q18vBDpNpAckQjq7BoOve
        /5Kv0btdtpGoLMaC0oMwyWKi8WoWrLs=
X-Google-Smtp-Source: AJdET5cyh2L6fDcCFoHjfz1sUPv4CmC6iRbiOJ93nX2pppOKmAGOBQo0+FwbcztRF3aK/0yAviHHqQ==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr5094951lje.28.1541083252485;
        Thu, 01 Nov 2018 07:40:52 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a9sm404870lfa.19.2018.11.01.07.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:40:50 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 3/5] clk: fixed-factor: Use devm_of_clk_add_provider
Date:   Thu,  1 Nov 2018 15:40:42 +0100
Message-Id: <20181101144044.11495-4-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
References: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_add_provider. It will take care of clk un-registering.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/clk/clk-fixed-factor.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 7df6b5b1e7ee..876d76522475 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -148,7 +148,8 @@ static const struct of_device_id set_rate_parent_matches[] = {
 	{ /* Sentinel */ },
 };
 
-static struct clk *_of_fixed_factor_clk_setup(struct device_node *node)
+static struct clk *_of_fixed_factor_clk_setup(struct device *dev,
+					      struct device_node *node)
 {
 	struct clk *clk;
 	const char *clk_name = node->name;
@@ -187,7 +188,11 @@ static struct clk *_of_fixed_factor_clk_setup(struct device_node *node)
 		return clk;
 	}
 
-	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (dev)
+		ret = devm_of_clk_add_provider(dev, of_clk_src_simple_get, clk);
+	else
+		ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
 	if (ret) {
 		clk_unregister(clk);
 		return ERR_PTR(ret);
@@ -201,7 +206,7 @@ static struct clk *_of_fixed_factor_clk_setup(struct device_node *node)
  */
 void __init of_fixed_factor_clk_setup(struct device_node *node)
 {
-	_of_fixed_factor_clk_setup(node);
+	_of_fixed_factor_clk_setup(NULL, node);
 }
 CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
 		of_fixed_factor_clk_setup);
@@ -210,7 +215,6 @@ static int of_fixed_factor_clk_remove(struct platform_device *pdev)
 {
 	struct clk *clk = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
 	clk_unregister_fixed_factor(clk);
 
 	return 0;
@@ -224,7 +228,7 @@ static int of_fixed_factor_clk_probe(struct platform_device *pdev)
 	 * This function is not executed when of_fixed_factor_clk_setup
 	 * succeeded.
 	 */
-	clk = _of_fixed_factor_clk_setup(pdev->dev.of_node);
+	clk = _of_fixed_factor_clk_setup(&pdev->dev, pdev->dev.of_node);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.19.1

