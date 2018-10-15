Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D65C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E5F20895
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trRDsJRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E5F20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJOMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35036 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeJOMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id l17-v6so9038451pff.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIT73f6eOrzGq4/Kgb9qmkqos5ywoYT6UDYKgjvtARI=;
        b=trRDsJRqYRbCQxXzK3kVCSUousgdX9FjXeuihzSimjYrL4Uc0FzIGKAAsnB+prH9UD
         2utZVUdIzn0piZwvjCLjIotnzLaE5J2GVZAW5EYu5fNzaADU6dsiQ9SfEkHG9vNiBpQQ
         97x57Q74ZdLYoUs9KliDpzxiCrLsR9uH/VSsUFH6sURNq6ILPA5lBOFMTP8hn8aqopn5
         4vtrVA1CUQByH6LCQG+ucaljVjlzk/3RmlzloFcXBhnP5+sK8UCkYEVOWx6Wdcfsab0R
         kYA7EeheTTWEtY78DtTCqDmelX2Q9/wBua3JBjmg+R6fNvrAv4plThAUujGZILImxahL
         eUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIT73f6eOrzGq4/Kgb9qmkqos5ywoYT6UDYKgjvtARI=;
        b=GUPQG82NHunsRzhx0ZzlgbYwGNQ/vZKcx8ZY9j0mJk9uHu2W7nB7p3pKPuK3h6R2K4
         MeSPVFdLWBomnnv9WhfuxXNDr6MbJNp80yW6nagTs2snkq9H8sTqnXkZaMmxNPMuVPoQ
         jPqL1SZAcUwFjqs/W0x/ww4s9FJ41vrR+PK2zYXvGxkhZpbHs4KZvQjCp2dk0Gqs7/zo
         0xKzbeyyQ5zcGE9lxVv5GRJKWuM1gzpESAE/rGwIItwxqttovbeXdQ03yFVmu3q0rLlD
         FUPRXoKDAJa8ZSMn5KH5OaIqU27gic808MgQo02ATFVjyNl3B2isaIVkBXMJ/OfL2uwq
         MevQ==
X-Gm-Message-State: ABuFfojbNdabJwYmRJEL8pRLC34yyBHa5Q40WcY4FMKSe6EYgK5UxOTG
        uFUXuvXNqO88YtORJRMtZjw=
X-Google-Smtp-Source: ACcGV63WqaQb5NVeGpz9XjpVOCiesnLgE/jLK+w3QBMy3UWnwUffws08K6R/4LCa9YuBj4KrQAlLqQ==
X-Received: by 2002:a62:cfc4:: with SMTP id b187-v6mr7442330pfg.249.1539579602454;
        Sun, 14 Oct 2018 22:00:02 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.22.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 22:00:01 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/11] staging: gasket: page_table: simplify gasket_components_to_dev_address
Date:   Sun, 14 Oct 2018 21:59:24 -0700
Message-Id: <20181015045927.156790-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Refactor gasket_components_to_dev_address to be faster and easier to
understand. The old implementation was unnecessarily complex and masked
the page_index for simple addresses but not extended ones. It makes the
most sense for this function to perform no such masking.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index ec9359576ea7c..c2fbab74194f8 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -699,26 +699,9 @@ static ulong gasket_components_to_dev_address(struct gasket_page_table *pg_tbl,
 					      int is_simple, uint page_index,
 					      uint offset)
 {
-	ulong lvl0_index, lvl1_index;
+	ulong dev_addr = (page_index << GASKET_SIMPLE_PAGE_SHIFT) | offset;
 
-	if (is_simple) {
-		/* Return simple addresses directly. */
-		lvl0_index = page_index & (pg_tbl->config.total_entries - 1);
-		return (lvl0_index << GASKET_SIMPLE_PAGE_SHIFT) | offset;
-	}
-
-	/*
-	 * This could be compressed into fewer statements, but
-	 * A) the compiler should optimize it
-	 * B) this is not slow
-	 * C) this is an uncommon operation
-	 * D) this is actually readable this way.
-	 */
-	lvl0_index = page_index / GASKET_PAGES_PER_SUBTABLE;
-	lvl1_index = page_index & (GASKET_PAGES_PER_SUBTABLE - 1);
-	return (pg_tbl)->extended_flag |
-	       (lvl0_index << GASKET_EXTENDED_LVL0_SHIFT) |
-	       (lvl1_index << GASKET_EXTENDED_LVL1_SHIFT) | offset;
+	return is_simple ? dev_addr : (pg_tbl->extended_flag | dev_addr);
 }
 
 /*
-- 
2.19.0.605.g01d371f741-goog

