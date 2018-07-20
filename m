Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A31ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E91E20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWO0UWAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E91E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeGTEgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35524 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbeGTEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so5625419pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rAtoadXSt5hxka2LKV3Eq+/r8t+CIFxOEm2gppHYq8M=;
        b=DWO0UWArx2PJtMF7+6iMDPH/huZRb7JfkYy4mOcxy83YcTaik7OBf2ny+ltPF7eiBb
         P1oGvD3PPyVtWvzmdLvYX51vgvvj+IPIgdD6PFZ9b4j6ga4Jfh8PnoWZdN1TMei6g4s0
         Dcwfc7SPNEM4Fm2lLz9Ax+xsBKWswCgjjw4kDYwBhm3W0qiNKdndBw6zyqSPxqZhvGto
         w3IX88kw7U7P3n8hE1nlGnWIFmCr0Q2SkvkEcfxVNMGP8TNBAxPKwODdcbjly5qmcLw5
         LD+muKy1kyAsQK/hKDViJhMXOScX34Y+selc1XTNQt20UMk3PMUsHd6d0xNwMw6WkDuF
         0jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rAtoadXSt5hxka2LKV3Eq+/r8t+CIFxOEm2gppHYq8M=;
        b=LAUF8Kaoo9B2xnVit2ib4x5AHdAzz813oxqkfpqdGklVzeUGgN5GCzKsqK3lHn5M+8
         YgLOPs9XNuRc1YO7Ed8RU22JpNCZrPqxo8zj7tf7jd0dFyWvwHTrpAberO0UpqxWeQ1O
         tJ96LjSelmLw7Td8wTfQ0maqGewH5HfqCbXwR/mdHzmwIigbOf3NNrHfDizmLKBWJ85c
         5Uo2tjBfGEs6wjhMPqgktkalqRCihqRqmU+NLrr4WjZxnIM+IrvYcB/S0VWkyxfxtJ6I
         qmAyY9hLcMj0B4O5zwZtQa7be5vpfw30942Xez0CmK0FoKmddTadiUCvBrvlvpVaEr/K
         x3AA==
X-Gm-Message-State: AOUpUlGL57edDFEXogxBHDObElNN6qCCDKtKdlSgBl9C5sm5l9jjpky9
        K98MniI0Jor/p477c9bUG8kxAcvgBkw=
X-Google-Smtp-Source: AAOMgpdqmUWLnGf1DcpsE/YiWmGouh/bKPzYWnK6Tx7JMywp1ZcBu/isZRtGBWJvsnX0oNJLD4z/Ow==
X-Received: by 2002:a62:6746:: with SMTP id b67-v6mr429839pfc.243.1532058595236;
        Thu, 19 Jul 2018 20:49:55 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:54 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 06/20] staging: gasket: don't treat no device reset callback as an error
Date:   Thu, 19 Jul 2018 20:49:06 -0700
Message-Id: <20180720034920.77320-7-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

It is not an error for a device to not have a reset callback registered.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 53236e1ba4e48..eb5ad161ccda2 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1836,11 +1836,8 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 	const struct gasket_driver_desc *driver_desc;
 
 	driver_desc = gasket_dev->internal_desc->driver_desc;
-	if (!driver_desc->device_reset_cb) {
-		gasket_log_error(
-			gasket_dev, "No device reset callback was registered.");
-		return -EINVAL;
-	}
+	if (!driver_desc->device_reset_cb)
+		return 0;
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
-- 
2.18.0.233.g985f88cf7e-goog

