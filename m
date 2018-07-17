Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F4ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED587208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ+YKI+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED587208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbeGQCkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:35 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34252 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbeGQCkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:35 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so2178034plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kC5DicUvUh72sEQdmlbAqrqr+jZijAZa088KFVl/pDo=;
        b=PQ+YKI+u+IHAhOJ8H3nCP4Z1nWsqUHJvLWRWIgRTFce8nQ56LXWYB3VOrnOvZI+Rsc
         3DHJ6bzGnOPGpgY9D1ASYpSjruT8yP+KSSTVciF2WBQ7MPpRl7wXBlN4OwIC7/a8UI5Y
         qA9EtpPXxiCkSJ1dvHqNZIFin/f1SunMAalef4k8S2PW7nR4T/A9zYiThHS9IOdQU8oi
         B7qfQoKVIBGmlQ2bv/3SWwaVoC7LLhmokxJa8dvuUaHg38WXVj30JnWXdnakZ7ffe6W9
         wccHZh4w3v4DCsIowA3UAAIMvy4NqUDhFPn1320HWpX9+3XY3Dl+ELnXmJKAjEixBwcU
         DJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kC5DicUvUh72sEQdmlbAqrqr+jZijAZa088KFVl/pDo=;
        b=ompaCozt0AzcdZJFbZ5jBWB/NDcYfyXuibMi5b0f/XvTnOfU/C05EeaX6FaC07BMAL
         MrhTaW0i6g1/qh0IJMBAdVA9E6fXJI4gHOnyPpARgjL1Wk2ZttpkdxRvprkSvbuzqWT/
         inlIjfkyt6LBfwWFpHWWz6tA0eXN9zNAJAWu0UBVLkyCwTY3CkBncHdLCBmbgwT7j0oN
         4OaPIKugk22YLWhNL1C6CwDp8VyakV40qV9+6hIOPlQ1P45p4ylL9qFPBJdh9gfH7sNO
         lzbxV8RY5dYhQnNhZY2O7JE/406r92470CwGW4Ru4pG/LeS3PG/sQlYs44HHI/2RtyRX
         BvtQ==
X-Gm-Message-State: AOUpUlGBLxXhaUTIuLLx0OUcPG5ZFabuqzjoI4yu3wVxnz42Vwuy5hAq
        +luPdyDISFnc+8kK2skAyFc=
X-Google-Smtp-Source: AAOMgpevHezMbpZSKFdQhnZRT8xeNOuurrfDr1KSZc6owIVIV2oSGZ62jXDFYsLiR8r05JGgWpjrbw==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9-v6mr18374199plo.1.1531793424927;
        Mon, 16 Jul 2018 19:10:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:24 -0700 (PDT)
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
Subject: [PATCH 27/32] staging: gasket: remove else clause after return in if clause
Date:   Mon, 16 Jul 2018 19:09:21 -0700
Message-Id: <20180717020926.176408-28-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Else after return is unnecessary and may cause static code checkers to
complain.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 2a27db658a4e4..080bf78c22c3b 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -598,9 +598,8 @@ bool gasket_page_table_is_dev_addr_bad(
 	if (gasket_addr_is_simple(pg_tbl, dev_addr))
 		return gasket_is_simple_dev_addr_bad(
 			pg_tbl, dev_addr, num_pages);
-	else
-		return gasket_is_extended_dev_addr_bad(
-			pg_tbl, dev_addr, num_pages);
+	return gasket_is_extended_dev_addr_bad(
+		pg_tbl, dev_addr, num_pages);
 }
 EXPORT_SYMBOL(gasket_page_table_is_dev_addr_bad);
 
-- 
2.18.0.203.gfac676dfb9-goog

