Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1874320842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRAuvmU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfBUP0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36760 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfBUP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so31015217wrw.3;
        Thu, 21 Feb 2019 07:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEjER1QD2Tnm8PA8oEKeSor0Ppgc9jB1pMOYk91Kf9w=;
        b=eRAuvmU6wHfCWERjzw5d4lpj0sp0an9YXnPTTSHLnXzMQMC6r58jC/3bB6GjKhIK7R
         h2i9UO1RBDe2mvk+rtG7wFB928xzDZB/06kFDAJw/f44EjySs0oRbdvZjC8rVzV7HmU6
         sWxwKED99Ywy60KA/KqWU186BL6bAeX9Y5tpvQXQNCqbWS0lsICagA0FuFxEgt0VIngk
         8JYBqFPcWVbdxdVQ70/r78hcpaKAWW7OXm8RjzzFZzlphnbCX7tf/BfWMIygDHzHdKMy
         3K2HhMMz0wgPJY5pjQBws7leR+YHt8Lbwj9mRzGvTWf8uVCmO5dNmOEaP3alLHlsk3Fc
         BmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEjER1QD2Tnm8PA8oEKeSor0Ppgc9jB1pMOYk91Kf9w=;
        b=ftGUhZFcx/3mCni9kSfdpHxG9BMNbUQPqtzcQHG1hh9o/Jjpc4KVMSyW1ahoxqiEQq
         JmN4MkRIyGdfJ9RPfLWGqYZhTSvMEGLj5YXtfWbsN9EfvlplP/swsTrwj0ZzrU12r9QZ
         k57GZ4yNrn1wy/4ledy8B2bJVONNt0FPratMseLeCT3g3MZeemwTGa87RRivoc3bJbaW
         /mrdeyF/uOz3Ly1/ay7MIr2CmyGF3HpSwBrwUkYFQigB4HXgtmC8QZH1MKIevFBRekOV
         f1IT2x6Lhff3ZotEzpjpsK4jOHT+kyWnGiHbGuhN4uiPVx/YFrEpwDCYWW2N61VmvGe0
         S4sg==
X-Gm-Message-State: AHQUAub+MnwwFw7GRiD0ysD35y1gmEJiKmYHA0O/eikZr/e6ZgoiYQSN
        oayutNT9nQkpVjDKhg+L5pE=
X-Google-Smtp-Source: AHgI3Ib/veyvOT3rzYEj5iqeAJ2bTEImkZyesLVX3RmAlVyvjMFef5IOddjFb7Db5IpNOadzltxC/Q==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr11081548wmd.103.1550762762096;
        Thu, 21 Feb 2019 07:26:02 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id z14sm16074786wrv.91.2019.02.21.07.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:26:01 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] reset: Add acquire/release support for arrays
Date:   Thu, 21 Feb 2019 16:25:55 +0100
Message-Id: <20190221152557.8534-3-thierry.reding@gmail.com>
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

Add implementations that apply acquire and release operations to all
reset controls part of a reset control array.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/reset/core.c  | 36 +++++++++++++++++++++++++++++++++++-
 include/linux/reset.h |  6 ++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index f94da91c22af..81ea77cba123 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -245,6 +245,34 @@ static int reset_control_array_deassert(struct reset_control_array *resets)
 	return ret;
 }
 
+static int reset_control_array_acquire(struct reset_control_array *resets)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < resets->num_rstcs; i++) {
+		err = reset_control_acquire(resets->rstc[i]);
+		if (err < 0)
+			goto release;
+	}
+
+	return 0;
+
+release:
+	while (i--)
+		reset_control_release(resets->rstc[i]);
+
+	return err;
+}
+
+static void reset_control_array_release(struct reset_control_array *resets)
+{
+	unsigned int i;
+
+	for (i = 0; i < resets->num_rstcs; i++)
+		reset_control_release(resets->rstc[i]);
+}
+
 static inline bool reset_control_is_array(struct reset_control *rstc)
 {
 	return rstc->array;
@@ -464,6 +492,9 @@ int reset_control_acquire(struct reset_control *rstc)
 	if (WARN_ON(IS_ERR(rstc)))
 		return -EINVAL;
 
+	if (reset_control_is_array(rstc))
+		return reset_control_array_acquire(rstc_to_array(rstc));
+
 	mutex_lock(&reset_list_mutex);
 
 	if (rstc->acquired) {
@@ -502,7 +533,10 @@ void reset_control_release(struct reset_control *rstc)
 	if (!rstc || WARN_ON(IS_ERR(rstc)))
 		return;
 
-	rstc->acquired = false;
+	if (reset_control_is_array(rstc))
+		reset_control_array_release(rstc_to_array(rstc));
+	else
+		rstc->acquired = false;
 }
 EXPORT_SYMBOL_GPL(reset_control_release);
 
diff --git a/include/linux/reset.h b/include/linux/reset.h
index a01b32bf51d4..95d555c2130a 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -470,6 +470,12 @@ of_reset_control_array_get_exclusive(struct device_node *node)
 	return of_reset_control_array_get(node, false, false, true);
 }
 
+static inline struct reset_control *
+of_reset_control_array_get_exclusive_released(struct device_node *node)
+{
+	return of_reset_control_array_get(node, false, false, false);
+}
+
 static inline struct reset_control *
 of_reset_control_array_get_shared(struct device_node *node)
 {
-- 
2.20.1

