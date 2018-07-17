Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97585ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B2F20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjWQpSQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B2F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeGQVlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:41:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41599 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbeGQVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id c21-v6so1086342pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/l2vY/oMZSS2TQzki4Lw5uwf9RTRP8Zc6uZKaS4/pY=;
        b=EjWQpSQhEk2z4IDcmZJ1PCTYk/t+N3N1Vph220rOVrXPk0yNbNYAc2ShRRJYkC2Qkx
         YXZkYAdsZ+TAVvX+g33yaqs4ycdFLyoPt56yJr0k0MKWogRVuz9NCIqpmQXD/GwzuAYn
         DnKKbcyi9OvlEZZjJucC6zXXr+eNrzyNgy/3+mLRrDU1eJ3QslEGySOfVHxWhbX5zZtn
         YLDiipbv5p7xGPyoXOCdHAK1SgqnQud+WEedSr45BpnpuBAZHnfpJHYV8XD6VkcLqYan
         PV3hPeLLPVWCqbRQ2ZHR1K3HGBQpCbMERbcan2ZrdeVAzewloODtFyFob2zfFFdVA3XB
         vBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/l2vY/oMZSS2TQzki4Lw5uwf9RTRP8Zc6uZKaS4/pY=;
        b=RNawB6jstNJEPoJqxPb68lLs7unXkvhswUR1W47ZEuoYCZd6uS1jGg1epA/Yw+C/81
         QMJo4zJoByfMSrKEwT8zPZkVQUKealZQXp0kab6OcrYSyKIKZSHfl+7RVGSLBIQ0cqKh
         YHWmdxJrKFRY2d02a31ONNLuQKqbHZFdbTFcKUBqIUd4aQGg5kK793W7m4ZELplVXb8P
         Vn9InKu7F4u+fXZ+4/KlinlQ/nqXQhZYyFRmhNlXA0Ca0f1k4jFzvp0e0JpmppGCqfcP
         TfP5wksy682GnPBaRNCfShUZCG9CpOsVoOcecKPr3WfWN08NdNp4CQwk+I596JLQSNfP
         vCmg==
X-Gm-Message-State: AOUpUlHx0S9AhnH/BWUBLx5TZXjYaDybampDG8Yn8jXgo6pEYyqrkruo
        hjwasmvUJw6Pw7kIbFEN/fHVjGx5
X-Google-Smtp-Source: AAOMgpdHyKyVVK7Ry/xNVssfO5hi9HDODG6EDgUAXtsy3hjneiGtbx/Ad5N/I3Rabno22MLPzXCj/g==
X-Received: by 2002:a65:5144:: with SMTP id g4-v6mr3086683pgq.21.1531861499258;
        Tue, 17 Jul 2018 14:04:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:58 -0700 (PDT)
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
Subject: [PATCH 12/32] staging: gasket: gasket_wait_with_reschedule simplify logic
Date:   Tue, 17 Jul 2018 13:56:52 -0700
Message-Id: <20180717205712.29495-13-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_wait_with_reschedule() is a little more clear if we just return
directly when the waited-for condition is hit.  This also allows the
following condition check to be removed and identation of the
conditionally-executed code to be reduced.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 442543573f6e9..5ae3d44f6166e 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2097,18 +2097,12 @@ int gasket_wait_with_reschedule(
 	while (retries < max_retries) {
 		tmp = gasket_dev_read_64(gasket_dev, bar, offset);
 		if ((tmp & mask) == val)
-			break;
+			return 0;
 		msleep(delay_ms);
 		retries++;
 	}
-	if (retries == max_retries) {
-		gasket_log_error(
-			gasket_dev,
-			"%s timeout: reg %llx timeout (%llu ms)",
-			__func__,
-			offset, max_retries * delay_ms);
-		return -ETIMEDOUT;
-	}
-	return 0;
+	gasket_log_error(gasket_dev, "%s timeout: reg %llx timeout (%llu ms)",
+			 __func__, offset, max_retries * delay_ms);
+	return -ETIMEDOUT;
 }
 EXPORT_SYMBOL(gasket_wait_with_reschedule);
-- 
2.18.0.203.gfac676dfb9-goog

