Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE71C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F472081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKdar9Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F472081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeKAXoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:44:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40182 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbeKAXoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:44:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id t22-v6so18265843lji.7;
        Thu, 01 Nov 2018 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35XjVyJKaPXi3eDOVrzg+ahSd5WiXKjGMHZpZ9TPAEU=;
        b=eKdar9Lc36XpSl0KXlHuQCVdgojy7S2VIwtPWnpjVjRJTsAJ0RCaUzOXiRKbwky4qS
         5f3k3EeFY3G8ueO+Kko6FGz3Ymc2nBOx+xQaQ3Ulr0BOTfUq9zBE5sjMZADX8ZsWtbt1
         N9J7mprDYuT1xJthMAujIIh5l6ImF0s2sL4+dHQ5PsFmrcP7r/W0XDPsSJvVzWnAZnI4
         t3LlZMLX5GpLk1oCpLgFOYaDtXYzu2mhqNz6AgUs5wBdj7OeoF1cgeXvmqmvcmf+IF4g
         cTAl7gB5fpvlwRvbyffaJ71gbza48RV4iZFKGa2R8y6Q3JLYQe4B66lQRbeKdfhyxoOH
         D+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35XjVyJKaPXi3eDOVrzg+ahSd5WiXKjGMHZpZ9TPAEU=;
        b=sdTzwV9qWAyWhiJt6JUu01lnyC5Nn/rGtzhot62kDyOVTAZpAR4vBPlWFsOfuYLUQD
         4/Xlzh8mU3ssYuwHkjsqiz5SPVjmbtgsIH7KZjBM71l+CcvZ+iDjWG1M8X+pizyX4L98
         k4MGbLBMnxtQoW3zBoD4ylCoGYTltgIgjqxbDeHlUZLHvny+T/L5P8FSLTGw84LH2nHu
         MKulIx1IrujMMwwj0+OfQdp1sEeYtFN6RA+RIwqpHfuI1lLugn7iyEgQrpynw725Ext6
         EJH6z+Nr8HXQ6RPYtha09EFdoZdHpg9n6v6tGVySy/9aHK0fcCbB8KN/MGHoTcm92gGA
         hl0g==
X-Gm-Message-State: AGRZ1gJeohqb/Hc+kAXac36tXvz9DHkCkQT8TKyw90J9sBuQE+vXMyyg
        x9kiRmu3Ifc1eJOC5IiRX0Y=
X-Google-Smtp-Source: AJdET5cTr4+3nMax9jGqZ3BpPFsSY5QA7Q/YwRu85pJUyBqyII3sQ0EUXsy8e8+gZ2+HhKtj7wFvrQ==
X-Received: by 2002:a2e:9547:: with SMTP id t7-v6mr5010980ljh.63.1541083248464;
        Thu, 01 Nov 2018 07:40:48 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a9sm404870lfa.19.2018.11.01.07.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:40:47 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 1/5] clk: Refactor of_clk_add_provider and of_clk_add_hw_provider
Date:   Thu,  1 Nov 2018 15:40:40 +0100
Message-Id: <20181101144044.11495-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
References: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions have almost the same functionality. Create a helper
function that is called by both functions.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/clk/clk.c | 49 +++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055ae6ec6..cd3117e66ab8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3723,15 +3723,11 @@ of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
 }
 EXPORT_SYMBOL_GPL(of_clk_hw_onecell_get);
 
-/**
- * of_clk_add_provider() - Register a clock provider for a node
- * @np: Device node pointer associated with clock provider
- * @clk_src_get: callback for decoding clock
- * @data: context pointer for @clk_src_get callback.
- */
-int of_clk_add_provider(struct device_node *np,
+static int __of_clk_add_provider(struct device_node *np,
 			struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
 						   void *data),
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
 			void *data)
 {
 	struct of_clk_provider *cp;
@@ -3744,11 +3740,12 @@ int of_clk_add_provider(struct device_node *np,
 	cp->node = of_node_get(np);
 	cp->data = data;
 	cp->get = clk_src_get;
+	cp->get_hw = get;
 
 	mutex_lock(&of_clk_mutex);
 	list_add(&cp->link, &of_clk_providers);
 	mutex_unlock(&of_clk_mutex);
-	pr_debug("Added clock from %pOF\n", np);
+	pr_debug("Added clock%s from %pOF\n", get?"_hw provider":"", np);
 
 	ret = of_clk_set_defaults(np, true);
 	if (ret < 0)
@@ -3756,6 +3753,20 @@ int of_clk_add_provider(struct device_node *np,
 
 	return ret;
 }
+
+/**
+ * of_clk_add_provider() - Register a clock provider for a node
+ * @np: Device node pointer associated with clock provider
+ * @clk_src_get: callback for decoding clock
+ * @data: context pointer for @clk_src_get callback.
+ */
+int of_clk_add_provider(struct device_node *np,
+		struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
+					   void *data),
+		void *data)
+{
+	return  __of_clk_add_provider(np, clk_src_get, NULL, data);
+}
 EXPORT_SYMBOL_GPL(of_clk_add_provider);
 
 /**
@@ -3769,27 +3780,7 @@ int of_clk_add_hw_provider(struct device_node *np,
 						 void *data),
 			   void *data)
 {
-	struct of_clk_provider *cp;
-	int ret;
-
-	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
-	if (!cp)
-		return -ENOMEM;
-
-	cp->node = of_node_get(np);
-	cp->data = data;
-	cp->get_hw = get;
-
-	mutex_lock(&of_clk_mutex);
-	list_add(&cp->link, &of_clk_providers);
-	mutex_unlock(&of_clk_mutex);
-	pr_debug("Added clk_hw provider from %pOF\n", np);
-
-	ret = of_clk_set_defaults(np, true);
-	if (ret < 0)
-		of_clk_del_provider(np);
-
-	return ret;
+	return  __of_clk_add_provider(np, NULL, get, data);
 }
 EXPORT_SYMBOL_GPL(of_clk_add_hw_provider);
 
-- 
2.19.1

