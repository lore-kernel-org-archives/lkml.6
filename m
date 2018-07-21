Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F16ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E2220856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfqTEEMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E2220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeGUNuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38905 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeGUNui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id b1-v6so6327373pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bCg8UsGV6aNVlTYOKQwHQHZXXvhtfFcoKJs1IsSv0wo=;
        b=bfqTEEMhzcgAs0iMYZlsFay3B8te4GvltOp/u9U5KXZOgL6twuAJ0rkL9yc5bDjlM2
         GfH9tYGaaZMiIg4Vv4LGgUfbyQlhLovjm5qVsm9TwOEzos8T5C0wHf1eymGqbO2pcJgW
         GDIjJALlgK6A59ooJrHeXHbmYCqcv7hTmCFtbFWVVg8YDylw3B0iNZI0ERSxOcB5ixdz
         dp+wuwWM7Rf22T5xA3kNs81pnC6BUTvUuh+/WtXQ/5U2h+J8XUbeXzQA926kbrY9LCim
         B5ty9Zg8wOTm4pFDkpfyGhRZ7BWrMjp8EDoUpSDlQLJVoCoWBOqcPfaTyHgNPZcdFHIq
         ljVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bCg8UsGV6aNVlTYOKQwHQHZXXvhtfFcoKJs1IsSv0wo=;
        b=tt26+6b0sPln48cSI9P5uhw64Bl1XQ1Wf2AawwJuqX2JcEx3SKaKjLKM0nZSISDH8Q
         llDahWhck4zsOoL6XiiNttCUyPsejCq1KcyczZKbhu5Bs2i75hC+/EAskaLvnGMWmR9M
         5qduaJT/VPmlKLu7dxvGxFW6N00KZLQ53fztEUzlTi73x5BJ3ps5BigOdGzG6HMAuObd
         43D9kSjHVn/n8hC8R9qfOdGUQ5b+CTeNhE9ezJS8fp83HIYMO7ZDRr3Y6Rba1oF3gCQY
         SEbTJT5+sERS44SeCcLmolGt78ZICP1FBjLHw41GZlPQe4rNFB+Yb+G4WiA2yD5wnwFI
         ts9Q==
X-Gm-Message-State: AOUpUlECQ75S6RRytZJqajP59zF5cqs/HLM15GSBk1EeZbX1F+XninnK
        k5Aj0L0o/EtdIJfYi9LGSr8=
X-Google-Smtp-Source: AAOMgpfhKyE7S+q6isdOsAHVYgmtamtyWhSAif5y/VrXGAONFoJeWPYpf0U8fY0+Khe3xkouFujdgw==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6-v6mr5731939plb.210.1532177878956;
        Sat, 21 Jul 2018 05:57:58 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:58 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>,
        Simon Que <sque@chromium.org>
Subject: [PATCH 14/20] staging: gasket: remove extra parens in gasket_write_mappable_regions
Date:   Sat, 21 Jul 2018 05:57:07 -0700
Message-Id: <20180721125713.88501-29-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unneeded parentheses around subexpressions.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ae5febec8844c..ba48a379b0ada 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1889,7 +1889,7 @@ static ssize_t gasket_write_mappable_regions(
 	if (bar_desc.permissions == GASKET_NOMAP)
 		return 0;
 	for (i = 0;
-	     (i < bar_desc.num_mappable_regions) && (total_written < PAGE_SIZE);
+	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
 	     i++) {
 		min_addr = bar_desc.mappable_regions[i].start -
 			   driver_desc->legacy_mmap_address_offset;
-- 
2.18.0.233.g985f88cf7e-goog

