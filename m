Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB515C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7B820878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107852;
	bh=KFncQp1WddFROc7OrMk0D2Y+QITfQzCxrIjJfUvDGeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkp4tCao2sIEJXnB6OjvY6Amgdy09nyLwmikjqBt5vosyZpzW7KJ+6znXZVnFV/Eb
	 gIDuyFv/ZpajNK9cF1euHrEg5s9K5Tj/h36l3IiBSskWUddTCIAtGUNvWw0M5W4m3O
	 97I2UAXTlXx4OvZsGnyhOAwtOY8n+wnXkIf4rGUU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7B820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbeLFOuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731368AbeLFOrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C3B20661;
        Thu,  6 Dec 2018 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107626;
        bh=KFncQp1WddFROc7OrMk0D2Y+QITfQzCxrIjJfUvDGeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOKqtIJpm02/WGYBCSwPjI8xLdJCOVHcxBOJa6oUln4HOS/nJJTiHtaPwOgv0DGlf
         XQLFA3X63kFiwlxUPGcy3a7tYNQPZK/9fm9m6HyKPMnse0KQj1oC7Wkh1zs1F1vJB6
         xMm+fokehUeW9UINTgkC9ufQam3vLBvCU8+Xl2DY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.9 042/101] reset: make device_reset_optional() really optional
Date:   Thu,  6 Dec 2018 15:38:41 +0100
Message-Id: <20181206143013.942834559@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit 1554bbd4ad401b7f0f916c0891874111c10befe5 upstream.

Commit bb475230b8e5 ("reset: make optional functions really optional")
converted *_get_optional* functions, but device_reset_optional() was
left behind.  Convert it in the same way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/reset/core.c  |    9 +++++----
 include/linux/reset.h |   28 +++++++++++++---------------
 2 files changed, 18 insertions(+), 19 deletions(-)

--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -410,17 +410,18 @@ EXPORT_SYMBOL_GPL(__devm_reset_control_g
  * device_reset - find reset controller associated with the device
  *                and perform reset
  * @dev: device to be reset by the controller
+ * @optional: whether it is optional to reset the device
  *
- * Convenience wrapper for reset_control_get() and reset_control_reset().
+ * Convenience wrapper for __reset_control_get() and reset_control_reset().
  * This is useful for the common case of devices with single, dedicated reset
  * lines.
  */
-int device_reset(struct device *dev)
+int __device_reset(struct device *dev, bool optional)
 {
 	struct reset_control *rstc;
 	int ret;
 
-	rstc = reset_control_get(dev, NULL);
+	rstc = __reset_control_get(dev, NULL, 0, 0, optional);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
 
@@ -430,4 +431,4 @@ int device_reset(struct device *dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(device_reset);
+EXPORT_SYMBOL_GPL(__device_reset);
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -19,17 +19,11 @@ struct reset_control *__reset_control_ge
 					  int index, bool shared,
 					  bool optional);
 void reset_control_put(struct reset_control *rstc);
+int __device_reset(struct device *dev, bool optional);
 struct reset_control *__devm_reset_control_get(struct device *dev,
 				     const char *id, int index, bool shared,
 				     bool optional);
 
-int __must_check device_reset(struct device *dev);
-
-static inline int device_reset_optional(struct device *dev)
-{
-	return device_reset(dev);
-}
-
 #else
 
 static inline int reset_control_reset(struct reset_control *rstc)
@@ -56,15 +50,9 @@ static inline void reset_control_put(str
 {
 }
 
-static inline int __must_check device_reset(struct device *dev)
-{
-	WARN_ON(1);
-	return -ENOTSUPP;
-}
-
-static inline int device_reset_optional(struct device *dev)
+static inline int __device_reset(struct device *dev, bool optional)
 {
-	return -ENOTSUPP;
+	return optional ? 0 : -ENOTSUPP;
 }
 
 static inline struct reset_control *__of_reset_control_get(
@@ -91,6 +79,16 @@ static inline struct reset_control *__de
 
 #endif /* CONFIG_RESET_CONTROLLER */
 
+static inline int __must_check device_reset(struct device *dev)
+{
+	return __device_reset(dev, false);
+}
+
+static inline int device_reset_optional(struct device *dev)
+{
+	return __device_reset(dev, true);
+}
+
 /**
  * reset_control_get_exclusive - Lookup and obtain an exclusive reference
  *                               to a reset controller.


