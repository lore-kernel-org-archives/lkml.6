Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E51C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C421F20685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG76ReaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C421F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeIZOxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:53:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38772 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:53:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id z16-v6so1332925wmi.3;
        Wed, 26 Sep 2018 01:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EPPcyga3dCUWQSIsHTMyoeg/2P0ChGLKCEC2aOamvsE=;
        b=dG76ReaJRua91qSoZ4xa1NiXFBv1do1qt8axHgUsep8yznu3f/ckak8fBVK3Gtk9BO
         LExIFvQuLNo01/4GdP2Ue+HO7kz9+vpPaWphotkTApNXF7DtvEt9mi6TOfBnoUlzGmXB
         z4z6oSd1AiGBUIzPO5jp5kAhYcp3/ERw4EbpsShrnMhcnT+oLGuTFcjrdeygOCFMJi55
         Ie7QsNh/s6foOgk66gueKAkk5JooDFWwgxOvpS6hhOUBmq07WaBIgqcsCzxfntzjcw8F
         NEBCiWBDJ4ZdzxAcct1FQ+cRQKdF9mdJq1WL9WSyVlUBNGtNiKgRGD0nMvzllSAfJNJX
         vixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EPPcyga3dCUWQSIsHTMyoeg/2P0ChGLKCEC2aOamvsE=;
        b=c4IMVzh8uSn8v9XLtLqYulE2Iy3OAG/pT2mqCv8wcn80JvwsoY8Uch1wFUgHF20Ayy
         Hj/9xvaFJ2iULqnfuRKpEThngi2zZUrG57cFhhqipx8wKTq8cVw6/wux/zXw+D0F/1UB
         zT6zqBj+a1Ycr4aYReCUKD7aGlEatahYs95OW0sdWx5iaY8blcjPhb3RhHIAeDkLZWDB
         BX/wbT6DcZlMKj2fMJO+GpYTAUIdpQWzW5A4Q/bzX6rxc97cWxEPxE4Iyx3grD7mQHu1
         RcK9jssQoFsha/HrxulXlBwy0GgmAQuP4rwBVkQX59J6bqTk3l+BRPH316JvKxlAMZJA
         HeMg==
X-Gm-Message-State: ABuFfojTTiZmpECZabzMT17TrX2b+9XpvzGKmdBLQOojgtR5mZ0KrQD9
        wTqDfPAQIST60a6eOO2+AC/eteWV
X-Google-Smtp-Source: ACcGV60qe9rOC4VRkto1rkdKasevC3jsyUSQxq8Bx2BH5sJdg+ESx0mtlJUzUCBPZ4tT7d/d3AMo1A==
X-Received: by 2002:a1c:c243:: with SMTP id s64-v6mr1501905wmf.36.1537951273298;
        Wed, 26 Sep 2018 01:41:13 -0700 (PDT)
Received: from pc-ceresoli.dev.aim (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id y11-v6sm3767843wrp.30.2018.09.26.01.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:41:12 -0700 (PDT)
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: mux: remove duplicated i2c_algorithm
Date:   Wed, 26 Sep 2018 10:40:52 +0200
Message-Id: <20180926084052.22379-1-lucaceresoli77@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca@lucaceresoli.net>

i2c-mux instantiates one i2c_algorithm for each downstream adapter.
However these algorithms are all identical, depending only on the
parent adapter.

Avoid duplication by hoisting the i2c_algorithm from the adapters to
the i2c_mux_core object, and reuse it in all the adapters.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i2c/i2c-mux.c   | 37 ++++++++++++++++++-------------------
 include/linux/i2c-mux.h |  1 +
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f330690b4125..2b0cc2ad0a17 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -30,7 +30,6 @@
 /* multiplexer per channel data */
 struct i2c_mux_priv {
 	struct i2c_adapter adap;
-	struct i2c_algorithm algo;
 	struct i2c_mux_core *muxc;
 	u32 chan_id;
 };
@@ -263,6 +262,23 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
 	muxc->deselect = deselect;
 	muxc->max_adapters = max_adapters;
 
+	/* Need to do algo dynamically because we don't know ahead
+	 * of time what sort of physical adapter we'll be dealing with.
+	 */
+	if (parent->algo->master_xfer) {
+		if (muxc->mux_locked)
+			muxc->algo.master_xfer = i2c_mux_master_xfer;
+		else
+			muxc->algo.master_xfer = __i2c_mux_master_xfer;
+	}
+	if (parent->algo->smbus_xfer) {
+		if (muxc->mux_locked)
+			muxc->algo.smbus_xfer = i2c_mux_smbus_xfer;
+		else
+			muxc->algo.smbus_xfer = __i2c_mux_smbus_xfer;
+	}
+	muxc->algo.functionality = i2c_mux_functionality;
+
 	return muxc;
 }
 EXPORT_SYMBOL_GPL(i2c_mux_alloc);
@@ -301,28 +317,11 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->muxc = muxc;
 	priv->chan_id = chan_id;
 
-	/* Need to do algo dynamically because we don't know ahead
-	 * of time what sort of physical adapter we'll be dealing with.
-	 */
-	if (parent->algo->master_xfer) {
-		if (muxc->mux_locked)
-			priv->algo.master_xfer = i2c_mux_master_xfer;
-		else
-			priv->algo.master_xfer = __i2c_mux_master_xfer;
-	}
-	if (parent->algo->smbus_xfer) {
-		if (muxc->mux_locked)
-			priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
-		else
-			priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
-	}
-	priv->algo.functionality = i2c_mux_functionality;
-
 	/* Now fill out new adapter structure */
 	snprintf(priv->adap.name, sizeof(priv->adap.name),
 		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
 	priv->adap.owner = THIS_MODULE;
-	priv->adap.algo = &priv->algo;
+	priv->adap.algo = &muxc->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
 	priv->adap.retries = parent->retries;
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index bd74d5706f3b..d60b6846ca88 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -36,6 +36,7 @@ struct i2c_mux_core {
 	unsigned int arbitrator:1;
 	unsigned int gate:1;
 
+	struct i2c_algorithm algo;
 	void *priv;
 
 	int (*select)(struct i2c_mux_core *, u32 chan_id);
-- 
2.17.1

