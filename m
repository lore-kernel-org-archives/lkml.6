Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32858C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97B02084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbzA/zCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfBUP0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41331 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so18828627wrw.8;
        Thu, 21 Feb 2019 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a/kMhZeaVVw1leKshC6LSw8+0RsVdtfnkg3LU9kcxgM=;
        b=ZbzA/zClhl8m0H+joiR9M1gAFGiE9EzaPIb8Re70ZUssdFul6ZuyD1kDpDFqWZTrLw
         EqxVvS7y3Oc5PU5jr33iyrOL8GUIw6ww3tvcCQgX1O2ShdLQwJmzj1STSYZyxGTc0E71
         hdZp8GqzPr8CIVofE9ZlM5dCnjTaUVvincZpGe3R2ylGnzbbfXGpM9VGg/OjGL2Ohv7J
         L4tIbZFFSAEXMhSNE5TXcP+GRvM7lpIY84H+XRvr1L9C55PqSzvIDzZxZblXggoQnG2U
         cf+kyQ61vknm7+VcFc3iYOnrlGQDMJ67aOoNqA4nQGs/KTlmlchc5AOnx6iAM+ABJ/wu
         88xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a/kMhZeaVVw1leKshC6LSw8+0RsVdtfnkg3LU9kcxgM=;
        b=WVQ/F2UqyMdanJCRwS6AjF8ENSvPbdE6RziVdspv40YYjuDixKkDwT+Q0OwPLmdlBn
         qlAsCfkv5sxB0ugfvITRhKOJnuiXxkqSiBIUsOCSYjZWL6VeMl3b4CfmoXfCxqazEsOy
         Iz+uu8SUcCJQu2vy6FlkKFssitGfWXW3N+8iN+hVD8TGf/v90Zx2J5ubWl53CIXR+kvP
         7zDzMKGWhZt6JWcpRdGoTKnWdjwS/kaKO7LpKKMKsARLFHuSVz/jzblnnAgwRqQRziOy
         ALjrbsS0uTGdQmAGqKKS9Q9HflFIOSZdjzhnV5F5mPivO0GP6VE9PKw49St4L78JnwcG
         Chmw==
X-Gm-Message-State: AHQUAubJunI24g3FzxJLSeo1/3FN0Q2Ahk5gLfQNxh55k1bCr/NtFQln
        hmU36Xqm4mgesaLEv/yqnqU=
X-Google-Smtp-Source: AHgI3IZvpR+6HqzFnM7Ca+7bPWv5SAy0Dx5lUe+3n1xSMl0ZDhxvoUjtlcDWpj2/Ug7apms79CH8eA==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr19665749wrv.323.1550762760655;
        Thu, 21 Feb 2019 07:26:00 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id d24sm70587132wrb.47.2019.02.21.07.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:26:00 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/5] reset: Add acquired flag to of_reset_control_array_get()
Date:   Thu, 21 Feb 2019 16:25:54 +0100
Message-Id: <20190221152557.8534-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221152557.8534-1-thierry.reding@gmail.com>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

In order to be able to request an array of reset controls in acquired or
released mode, add the acquired flag to of_reset_control_array_get() and
pass the flag to subsequent calls of __of_reset_control_get().

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/reset/core.c              |  9 ++++++---
 drivers/usb/dwc3/dwc3-of-simple.c |  3 ++-
 include/linux/reset.h             | 14 ++++++++------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 1e8a42b16f23..f94da91c22af 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -830,12 +830,15 @@ static int of_reset_control_get_count(struct device_node *node)
  * @np: device node for the device that requests the reset controls array
  * @shared: whether reset controls are shared or not
  * @optional: whether it is optional to get the reset controls
+ * @acquired: only one reset control may be acquired for a given controller
+ *            and ID
  *
  * Returns pointer to allocated reset_control_array on success or
  * error on failure
  */
 struct reset_control *
-of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
+of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
+			   bool acquired)
 {
 	struct reset_control_array *resets;
 	struct reset_control *rstc;
@@ -851,7 +854,7 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
 
 	for (i = 0; i < num; i++) {
 		rstc = __of_reset_control_get(np, NULL, i, shared, optional,
-					      true);
+					      acquired);
 		if (IS_ERR(rstc))
 			goto err_rst;
 		resets->rstc[i] = rstc;
@@ -898,7 +901,7 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 	if (!devres)
 		return ERR_PTR(-ENOMEM);
 
-	rstc = of_reset_control_array_get(dev->of_node, shared, optional);
+	rstc = of_reset_control_array_get(dev->of_node, shared, optional, true);
 	if (IS_ERR(rstc)) {
 		devres_free(devres);
 		return rstc;
diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 4c2771c5e727..67ce2037472d 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -107,7 +107,8 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 		simple->pulse_resets = true;
 	}
 
-	simple->resets = of_reset_control_array_get(np, shared_resets, true);
+	simple->resets = of_reset_control_array_get(np, shared_resets, true,
+						    true);
 	if (IS_ERR(simple->resets)) {
 		ret = PTR_ERR(simple->resets);
 		dev_err(dev, "failed to get device resets, err=%d\n", ret);
diff --git a/include/linux/reset.h b/include/linux/reset.h
index ea9a8a1ce4b1..a01b32bf51d4 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -32,7 +32,8 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 struct reset_control *devm_reset_control_array_get(struct device *dev,
 						   bool shared, bool optional);
 struct reset_control *of_reset_control_array_get(struct device_node *np,
-						 bool shared, bool optional);
+						 bool shared, bool optional,
+						 bool acquired);
 
 int reset_control_get_count(struct device *dev);
 
@@ -107,7 +108,8 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 }
 
 static inline struct reset_control *
-of_reset_control_array_get(struct device_node *np, bool shared, bool optional)
+of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
+			   bool acquired)
 {
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
@@ -465,24 +467,24 @@ devm_reset_control_array_get_optional_shared(struct device *dev)
 static inline struct reset_control *
 of_reset_control_array_get_exclusive(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, false);
+	return of_reset_control_array_get(node, false, false, true);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_shared(struct device_node *node)
 {
-	return of_reset_control_array_get(node, true, false);
+	return of_reset_control_array_get(node, true, false, true);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_optional_exclusive(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, true);
+	return of_reset_control_array_get(node, false, true, true);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_optional_shared(struct device_node *node)
 {
-	return of_reset_control_array_get(node, true, true);
+	return of_reset_control_array_get(node, true, true, true);
 }
 #endif
-- 
2.20.1

