Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE5C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39CA22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39CA22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeKMVyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:54:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39089 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeKMVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:54:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so10557260ljh.6;
        Tue, 13 Nov 2018 03:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i+KZ9+62AmBi6LwLI4MDe8trUcZvmkQ3tsEjwOIjYlM=;
        b=J4MG3VrkpS+ZFoqckKLFbA/WBmtz02ksdV0VUdtiq5c+PjnrCZeLASzfTpu004N5Uf
         WhzPlXMRpLoElj2TtVy9o9Tx1jKWKO1Q9mQpQ6Ork8ck2gBfio78PYvPG6xXD18nSeAR
         p2oKfREjOliBDid54ioi11BlnimDTsWyaLJNgv6qZ9/iiFWzrEkJQ5+AhEiC6RzbNWsr
         UAavjy4MLSrDSpsmgBvZBUZNiSGyuhwaodohOdBFl8sZ2IWaET0sYIkwi9qFiWya6ta6
         2t6p287fyRa0/GUMfmPHpIOqVmUGwWus6YsOTGFuZcLOoaNOZPDpY+7zkC41z5prHbVO
         6hkQ==
X-Gm-Message-State: AGRZ1gKSi2/5d1OR08w7KJzNS00iIwADFcivg37zAWCFsJtK2g0tdhvk
        twkGxVdi5lldPh7DMnLl5EU=
X-Google-Smtp-Source: AJdET5dfVzgYUBkrPtM5r2r6qpEmSu6H9Is6ip9ppRrEfzXHkTxavCxRb0mE6ov5syKqPOzB79t/uQ==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr2955037ljg.50.1542110172456;
        Tue, 13 Nov 2018 03:56:12 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c14sm3423949lfb.40.2018.11.13.03.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 03:56:11 -0800 (PST)
Date:   Tue, 13 Nov 2018 13:55:58 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v4 1/8] clk: clkdev/of_clk - add managed lookup and provider
 registrations
Message-ID: <ec0d6ee7ea79f0e05041ed3e564b0aadb297ef5f.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542107769.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MFD devices the clk properties may be contained in MFD (parent) DT
node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
subdevice not to MFD device (parent). Add
devm_of_clk_add_hw_provider_parent to tackle this issue.

Also clkdev registration lacks of managed registration functions and it
seems few drivers do not drop clkdev lookups at exit. Add
devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
releasing at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++++--------
 include/linux/clk-provider.h          |  11 +++
 include/linux/clkdev.h                |   4 ++
 5 files changed, 136 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 43681ca0837f..fac63760b01c 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -238,6 +238,9 @@ CLOCK
   devm_clk_put()
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
+  devm_of_clk_add_parent_hw_provider()
+  devm_clk_hw_register_clkdev()
+  devm_clk_release_clkdev()
 
 DMA
   dmaenginem_async_device_register()
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..9bb921eb90f6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,12 +3893,12 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
-int devm_of_clk_add_hw_provider(struct device *dev,
+static int __devm_of_clk_add_hw_provider(struct device *dev,
 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 					      void *data),
-			void *data)
+			struct device_node *of_node, void *data)
 {
-	struct device_node **ptr, *np;
+	struct device_node **ptr;
 	int ret;
 
 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
@@ -3906,10 +3906,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	if (!ptr)
 		return -ENOMEM;
 
-	np = dev->of_node;
-	ret = of_clk_add_hw_provider(np, get, data);
+	*ptr = of_node;
+	ret = of_clk_add_hw_provider(of_node, get, data);
 	if (!ret) {
-		*ptr = np;
 		devres_add(dev, ptr);
 	} else {
 		devres_free(ptr);
@@ -3917,8 +3916,25 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 
 	return ret;
 }
+int devm_of_clk_add_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
+}
 EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
 
+int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_node,
+					     data);
+}
+EXPORT_SYMBOL_GPL(devm_of_clk_add_parent_hw_provider);
+
 /**
  * of_clk_del_provider() - Remove a previously registered clock provider
  * @np: Device node pointer associated with clock provider
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..f6100b6e06fd 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -401,6 +401,25 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 	return cl;
 }
 
+static int do_clk_register_clkdev(struct clk_hw *hw,
+	struct clk_lookup **cl, const char *con_id, const char *dev_id)
+{
+
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	/*
+	 * Since dev_id can be NULL, and NULL is handled specially, we must
+	 * pass it as either a NULL format string, or with "%s".
+	 */
+	if (dev_id)
+		*cl = __clk_register_clkdev(hw, con_id, "%s",
+					   dev_id);
+	else
+		*cl = __clk_register_clkdev(hw, con_id, NULL);
+
+	return *cl ? 0 : -ENOMEM;
+}
+
 /**
  * clk_register_clkdev - register one clock lookup for a struct clk
  * @clk: struct clk to associate with all clk_lookups
@@ -420,20 +439,10 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 {
 	struct clk_lookup *cl;
 
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, "%s",
-					   dev_id);
-	else
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, NULL);
-
-	return cl ? 0 : -ENOMEM;
+	if (!IS_ERR(clk))
+		return do_clk_register_clkdev(__clk_get_hw(clk), &cl, con_id,
+					      dev_id);
+	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL(clk_register_clkdev);
 
@@ -456,18 +465,79 @@ int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
 {
 	struct clk_lookup *cl;
 
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	return do_clk_register_clkdev(hw, &cl, con_id, dev_id);
+}
+EXPORT_SYMBOL(clk_hw_register_clkdev);
 
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(hw, con_id, "%s", dev_id);
-	else
-		cl = __clk_register_clkdev(hw, con_id, NULL);
+static void devm_clkdev_release(struct device *dev, void *res)
+{
+	clkdev_drop(*(struct clk_lookup **)res);
+}
 
-	return cl ? 0 : -ENOMEM;
+static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
+{
+	struct clk_lookup **l = res;
+
+	if (!l || !*l) {
+		WARN_ON(!l || !*l);
+		return 0;
+	}
+	return *l == data;
 }
-EXPORT_SYMBOL(clk_hw_register_clkdev);
+
+/**
+ * devm_clk_release_clkdev - Resource managed clkdev lookup release
+ * @dev: device this lookup is bound
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * Drop the clkdev lookup created with devm_clk_hw_register_clkdev.
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id)
+{
+	struct clk_lookup *cl;
+	int rval;
+
+	cl = clk_find(dev_id, con_id);
+	WARN_ON(!cl);
+	rval = devres_release(dev, devm_clkdev_release,
+			      &devm_clk_match_clkdev, cl);
+	WARN_ON(rval);
+}
+EXPORT_SYMBOL(devm_clk_release_clkdev);
+
+/**
+ * devm_clk_hw_register_clkdev - managed clk lookup registration for clk_hw
+ * @dev: device this lookup is bound
+ * @hw: struct clk_hw to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * clkdev.
+ *
+ * To make things easier for mass registration, we detect error clk_hws
+ * from a previous clk_hw_register_*() call, and return the error code for
+ * those.  This is to permit this function to be called immediately
+ * after clk_hw_register_*().
+ */
+int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
+				const char *con_id, const char *dev_id)
+{
+	int rval = -ENOMEM;
+	struct clk_lookup **cl;
+
+	cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
+	if (cl) {
+		rval = do_clk_register_clkdev(hw, cl, con_id, dev_id);
+		if (!rval)
+			devres_add(dev, cl);
+		else
+			devres_free(cl);
+	}
+	return rval;
+}
+EXPORT_SYMBOL(devm_clk_hw_register_clkdev);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..a6663f084cf1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -916,6 +916,10 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data);
+int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data);
 void of_clk_del_provider(struct device_node *np);
 void devm_of_clk_del_provider(struct device *dev);
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
@@ -953,6 +957,13 @@ static inline int devm_of_clk_add_hw_provider(struct device *dev,
 {
 	return 0;
 }
+static inline int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data)
+{
+	return 0;
+}
 static inline void of_clk_del_provider(struct device_node *np) {}
 static inline void devm_of_clk_del_provider(struct device *dev) {}
 static inline struct clk *of_clk_src_simple_get(
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 4890ff033220..ccb32af5848b 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -52,4 +52,8 @@ int clk_add_alias(const char *, const char *, const char *, struct device *);
 int clk_register_clkdev(struct clk *, const char *, const char *);
 int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 
+int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
+				const char *con_id, const char *dev_id);
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id);
 #endif
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
