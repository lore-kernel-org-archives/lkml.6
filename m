Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F3C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CED2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkvtKgLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CED2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeKAXoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:44:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36188 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbeKAXoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:44:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id s15-v6so18290533lji.3;
        Thu, 01 Nov 2018 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VimP1qjpqygKIez+BYIo7GsWa4+fe+wj595JxxLPTUg=;
        b=nkvtKgLqul6YhnnlJcG8kHjNcRTTXWAuNWrvW6UJVlQSMG+GprQ+JBxkO2tlO7N7f+
         G7POu80hzGPSiYvWqZzpU4FFWYj1OOkFR03Xhqo8EpsLKa1k2v4heGRR82KMeHnf2u1m
         4GIAcK8hIYOM+ANZBZZk5xLuYCZKc96QX2aGDYN35mhlgrhr14npKaJyntx90mCq7L3L
         wCX1XZse9NchuOxEmzJaKZAjuTRhDBLv57SjJMvmSDMoNxJKXafDcob+uTDYhgLxnddJ
         0bZ64VImrJQqAKds1WmlK4v+acyJoaq0Sh3m4dopJbK8338Xb/pOfYiKsZ+AZtuU63gK
         mW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VimP1qjpqygKIez+BYIo7GsWa4+fe+wj595JxxLPTUg=;
        b=BiF+RkxhxgQ+XXgj/MsTlxyh8o+yxfJMtluruut4o9CkYzyY0VuKQPJ0sCZ1/f4T4A
         tG8ReDd3tMJX9KRdlhWtqlQNjLgsP+m42PJ5Noq0tNFV4sXHMSP1FAkATJUNjfqr6DDv
         xQUKbn1UPvkJbTQsZ15PzTctUZ58J3xTndC/Bgf+YrMaMKX/1iSplWsoZgWZxFgAUqYq
         L3LNCw+Ykhw/iA0TyOwyFpZWNZEU9HQjI4CLhhGJnOMi6zCvTILUDQlYcOonSJPnoNFt
         a+nEFjk1Fr0IR7P/0aeneTptZo2urmpljxymX/LDpCPyb5jX7CkAf8wIJ+eLSQ/YCQiF
         DPkw==
X-Gm-Message-State: AGRZ1gKV9Dd8zy1QthJJlvTYzKCk4M76KtmfRS/RPvncOnPwXxIm4REP
        ajaLlLhFWk0ZTBDM/pXY9twCDd3nJhg=
X-Google-Smtp-Source: AJdET5c3ENFWhCHxUAbLv2oiLIe4xZHza0SC/6q5VrmlrEq4UWuF4T2VUGqEOH8Sr4zK6h61HZwiBA==
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr4945282ljw.75.1541083250445;
        Thu, 01 Nov 2018 07:40:50 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a9sm404870lfa.19.2018.11.01.07.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:40:48 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 2/5] clk: Create devm_of_clk_add_provider
Date:   Thu,  1 Nov 2018 15:40:41 +0100
Message-Id: <20181101144044.11495-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
References: <20181101144044.11495-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement devm_ flavour of of_clk_add_provider. This will help fixing
of_node_get-put imbalances.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/clk/clk.c                     | 29 ++++++++++++++++++++++-----
 include/linux/clk-provider.h          | 11 ++++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 43681ca0837f..a8e066d42355 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -237,6 +237,7 @@ CLOCK
   devm_clk_get()
   devm_clk_put()
   devm_clk_hw_register()
+  devm_of_clk_add_provider()
   devm_of_clk_add_hw_provider()
 
 DMA
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cd3117e66ab8..d315ffa6a32f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3789,10 +3789,12 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
-int devm_of_clk_add_hw_provider(struct device *dev,
-			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
-					      void *data),
-			void *data)
+static int __devm_of_clk_add_provider(struct device *dev,
+		struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
+					   void *data),
+		struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+				      void *data),
+		void *data)
 {
 	struct device_node **ptr, *np;
 	int ret;
@@ -3803,7 +3805,7 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 		return -ENOMEM;
 
 	np = dev->of_node;
-	ret = of_clk_add_hw_provider(np, get, data);
+	ret = __of_clk_add_provider(np, clk_src_get, get, data);
 	if (!ret) {
 		*ptr = np;
 		devres_add(dev, ptr);
@@ -3813,6 +3815,23 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 
 	return ret;
 }
+
+int devm_of_clk_add_provider(struct device *dev,
+		struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
+					   void *data),
+		void *data)
+{
+	return __devm_of_clk_add_provider(dev, clk_src_get, NULL, data);
+}
+EXPORT_SYMBOL_GPL(devm_of_clk_add_provider);
+
+int devm_of_clk_add_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_provider(dev, NULL, get, data);
+}
 EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
 
 /**
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa70a38d..bbd86fe656ef 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -905,6 +905,10 @@ int of_clk_add_hw_provider(struct device_node *np,
 			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data);
+int devm_of_clk_add_provider(struct device *dev,
+		struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
+					   void *data),
+		void *data);
 int devm_of_clk_add_hw_provider(struct device *dev,
 			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 						 void *data),
@@ -939,6 +943,13 @@ static inline int of_clk_add_hw_provider(struct device_node *np,
 {
 	return 0;
 }
+static inline int devm_of_clk_add_provider(struct device *dev,
+		struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
+					   void *data),
+		void *data)
+{
+	return 0;
+}
 static inline int devm_of_clk_add_hw_provider(struct device *dev,
 			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 						 void *data),
-- 
2.19.1

