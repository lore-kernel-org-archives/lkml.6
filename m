Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6BEC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203A120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsGxe7qO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203A120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbeKAXoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:44:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:47007 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbeKAXoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:44:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id o2-v6so14343966lfl.13;
        Thu, 01 Nov 2018 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hb5bfSM9LfGVJtNRyin3nTAOn6v8C2JaBjYTLsc+xu4=;
        b=TsGxe7qORmYTWS5nlJp4OR9COczVldjviSrzwZ28F4WZaDcH6i19LP2xwp8PUSwX4Z
         q6mQ7OhurcTtfkhlYQ8LzuTVTP9nhYBTrVEW5rXBi/rYADZ3DP6v364rWohuBRkM2JPX
         47SPoof5gEF2COpDLP7J2dp4KPZrsLvWg6JSHUmlgOsd/CCkYFCiZWrrbKudDmyuqi8l
         eYmaXn9XaG2KOTBfv7F7EXrpajRq/tS9V91IsqMpKg8VMPw/VhmT095kN5PpJ6Ix3UHu
         uD08iyDjj+MPSGieBRx04kuve6B+zuy4bt7rFGz/OO0sBuVoPxe/i0T3rOAnFMki/Dkv
         YZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hb5bfSM9LfGVJtNRyin3nTAOn6v8C2JaBjYTLsc+xu4=;
        b=aY1VooRgdvuCqKTbrzXjKKZfmbl0PoieDI3IMSsfFxb7mHWAlNoO11p0tu7bGQXWQT
         C9d8XMxvA+GNNwBMTvCRAgsknErZ8rqs0+wkNWyh0raWjTzabE4TtUV5crbHTONa9hby
         2LZZQzdPNANf5rZYBXnzHC1JNjWew8zjRl9NNy4nC9pXlAcnufEBlQ2GAO+hnTLCnH7o
         2vMQeT4irJvUFy1W0Je1+UO3RkAgrQV1VG09oiF1gzHP2yq2ck9+bdvUUHBpISn0wjEP
         VR991xbiex/UNcWEXo6qIY3ZXKOwPjQPF80CrvcFRGNerxH5Y/O83OOcKlN6j8FTlsN4
         sGUQ==
X-Gm-Message-State: AGRZ1gLS3pmS1duMYlQXdlu2aa11o6FS/bP7ldhRDAdbRkbOo9SB5jpb
        f19eeVFOCecqtZw3xOIyJWI=
X-Google-Smtp-Source: AJdET5dwxjTqqMArgY8UArKczeJZuSVc4I5P3LyebkpbwvD0RdHsqXrQCuLE8epI3XtL9Ic0iWOmlQ==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr4860813lfb.140.1541083254176;
        Thu, 01 Nov 2018 07:40:54 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a9sm404870lfa.19.2018.11.01.07.40.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:40:52 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 4/5] clk: fixed-rate: Use devm_of_clk_add_provider
Date:   Thu,  1 Nov 2018 15:40:43 +0100
Message-Id: <20181101144044.11495-5-ricardo.ribalda@gmail.com>
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
 drivers/clk/clk-fixed-rate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 6d6475c32ee5..2678b7bd68ac 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -158,7 +158,8 @@ void clk_hw_unregister_fixed_rate(struct clk_hw *hw)
 EXPORT_SYMBOL_GPL(clk_hw_unregister_fixed_rate);
 
 #ifdef CONFIG_OF
-static struct clk *_of_fixed_clk_setup(struct device_node *node)
+static struct clk *_of_fixed_clk_setup(struct device *dev,
+				       struct device_node *node)
 {
 	struct clk *clk;
 	const char *clk_name = node->name;
@@ -173,12 +174,16 @@ static struct clk *_of_fixed_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	clk = clk_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
+	clk = clk_register_fixed_rate_with_accuracy(dev, clk_name, NULL,
 						    0, rate, accuracy);
 	if (IS_ERR(clk))
 		return clk;
 
-	ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (dev)
+		ret = devm_of_clk_add_provider(dev, of_clk_src_simple_get, clk);
+	else
+		ret = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
 	if (ret) {
 		clk_unregister(clk);
 		return ERR_PTR(ret);
@@ -192,7 +197,7 @@ static struct clk *_of_fixed_clk_setup(struct device_node *node)
  */
 void __init of_fixed_clk_setup(struct device_node *node)
 {
-	_of_fixed_clk_setup(node);
+	_of_fixed_clk_setup(NULL, node);
 }
 CLK_OF_DECLARE(fixed_clk, "fixed-clock", of_fixed_clk_setup);
 
@@ -200,7 +205,6 @@ static int of_fixed_clk_remove(struct platform_device *pdev)
 {
 	struct clk *clk = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
 	clk_unregister_fixed_rate(clk);
 
 	return 0;
@@ -214,7 +218,7 @@ static int of_fixed_clk_probe(struct platform_device *pdev)
 	 * This function is not executed when of_fixed_clk_setup
 	 * succeeded.
 	 */
-	clk = _of_fixed_clk_setup(pdev->dev.of_node);
+	clk = _of_fixed_clk_setup(&pdev->dev, pdev->dev.of_node);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.19.1

