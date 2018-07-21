Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE93ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E294720856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvHRFday"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E294720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbeGUNui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35697 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729933AbeGUNui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so6332139plq.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBF2y/mExi53CF1QzH4dbyiJJYz/W7TnC0dgpxncxrU=;
        b=AvHRFday4KqpgzJ16mdKA78ao0Zrrm8c5gJpb8NeC2MhiTRQAQT0RTLvgMhHDL0//T
         M4yB7llOBlPEaG8tQMGP1ZOt7fDZUztwPIhh5ob8hXpyc3eAHeREJshMGLMpro7X+cmL
         R1sZfz2i4xMYz7LJ/lrhWy6ABLSa6wIBvQapcEIL7dnXuZgidUp0BJneGWDiRnWgnb5f
         Y3njZlk0DcCQ/EfAjPS4E814aKIBo1oIFwp9mMn92s6rUpB+FKDTZa7csPhl8coHBh11
         KOpv0P4gmJswWmfbbC9KzgB2gH2tqDguKDLOGRwDnea+1lvsQeDgW+SL4JgppgwalSl+
         /j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBF2y/mExi53CF1QzH4dbyiJJYz/W7TnC0dgpxncxrU=;
        b=WxTGf+Gl81/BsJCeRvb56kFY1kysbIDnv2hbS+r1GXVSkGnmVA7k+9Qj4qgiDCUs0S
         q+YODW/MSU3hVxlI/wJfhTm8X4CmaFaJy1GJN+C/pRuyKNaFQY/P/spqUK0PfXx5Y5XR
         YRZhBp3DSnCDBjSq4/1XUD4LIcpeLV73mUgEoGa8jI4y2WBajJ6KbjGx69UNHpnQmvvY
         77Z8gtUbRu9B2yRD7tXjqI1KxXQnWkVj146SxuveANBa6xhz5aoZrbe8YnBECMkQjjnl
         4ZN47P13uroyGvsxl0ORgaxGqVnqHtkHxhAfjPhsQ15aR2Om8XJSLL40I0Sc9/PrZ6K2
         /AOg==
X-Gm-Message-State: AOUpUlHb8s6S42YfIqhJo62IFtdQZn5Edc6Qf+DVVkMugxC4APkSrSMh
        qZoRzFCAH40XLqDfmoEj3vs=
X-Google-Smtp-Source: AAOMgpcxzmyctC3yQBRTR9g99anVEIyk0fvgJ95GZVKjaZlQqFc85uM5FoL7MkGbNOmOP9bvL9m2eg==
X-Received: by 2002:a17:902:ac1:: with SMTP id 59-v6mr5683869plp.36.1532177877985;
        Sat, 21 Jul 2018 05:57:57 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:57 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 14/14] staging: gasket: apex: convert various logs to debug level
Date:   Sat, 21 Jul 2018 05:57:06 -0700
Message-Id: <20180721125713.88501-28-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Debugging information is improperly logged at non-debug log level in a
number of places, and some logs regarding error conditions may be
generated too frequently, such that these could cause performance
problems and/or obscure other logs.  Convert these to debug log level.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 1c6f73b5a2a9e..6396b18b246a5 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -420,7 +420,7 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 		gasket_dev, APEX_BAR_INDEX,
 		APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
 
-	gasket_log_info(
+	gasket_log_debug(
 		gasket_dev,
 		"%s 0x%p hib_error 0x%llx scalar_error "
 		"0x%llx.",
@@ -589,7 +589,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
 		val1 = gasket_dev_read_32(
 			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Disallow HW clock gating 0x%x -> 0x%x",
 			val0, val1);
 	} else {
@@ -602,7 +602,7 @@ static int apex_quit_reset(struct gasket_dev *gasket_dev, uint type)
 			SCU3_RG_PWR_STATE_OVR_BIT_OFFSET);
 		val1 = gasket_dev_read_32(
 			gasket_dev, APEX_BAR_INDEX, APEX_BAR2_REG_SCU_3);
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Allow HW clock gating 0x%x -> 0x%x", val0,
 			val1);
 	}
@@ -668,7 +668,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev,
 	if (copy_from_user(&ibuf, argp, sizeof(ibuf)))
 		return -EFAULT;
 
-	gasket_log_error(gasket_dev, "%s %llu", __func__, ibuf.enable);
+	gasket_log_debug(gasket_dev, "%s %llu", __func__, ibuf.enable);
 
 	if (ibuf.enable) {
 		/* Quiesce AXI, gate GCB clock. */
@@ -738,7 +738,7 @@ static ssize_t sysfs_show(
 					gasket_dev->page_table[0]));
 		break;
 	default:
-		gasket_log_error(
+		gasket_log_debug(
 			gasket_dev, "Unknown attribute: %s", attr->attr.name);
 		ret = 0;
 		break;
-- 
2.18.0.233.g985f88cf7e-goog

