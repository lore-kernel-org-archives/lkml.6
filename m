Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B8BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F5A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vL6oJytm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F5A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbeGQVjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41181 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so984261ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tTXbFz3WKwiG+9N0fxlLYmbI9e8jwvYVZrvo3SEj82E=;
        b=vL6oJytmAP0Njvxeq8vDcReSa3TMArLVridpJ1gG+BVTULG7lvMYad3EwEVNCZ+0LR
         2/KZmw3PeY+ySR05m8OYfYVOyusyEqKd0Zwy578JPo0C/XdDlTzfs7yTQjYEtJo7+cz9
         2A0aeGw40KnY+N0115+FbeR94EoxwAEs/eBGGUtSefMTyFOVsJml3Cd0cNRpZk6Xi5YG
         J4WDuoSemvitoTUbTpS8IU+BW+gLng9NloVcoGvJpcRiPLK+G+GbFhJa76nQH05CpOcO
         mtEhWXKdtZ4taqeclHh0xD4iVoSAmn9I3S8w/znGngK51khsVtRzbaPlomFO5xT/TbT9
         gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTXbFz3WKwiG+9N0fxlLYmbI9e8jwvYVZrvo3SEj82E=;
        b=r7LvyXIyVGNLV87xk85WsRF1i9yZpLJklq/gpSdZBZYgzne9MppyiY50hWF9T9NjmP
         DAaP4DbI1AA8XbghXu4v0s17O204CLD3i6/qrTHO5crJoGMW/TpX1FExrCL6BnCQILjH
         R6vvsj78Lif8nAs+38uYc46Ey0vKIPwUmW3ZictBP7V4vDjBkMoeL8ExemoMIAkY1Gyy
         /vYbYbfVCnDOUOyKlqYg4dd/juYCcUiWIaH6w6WkIvrCTm+k7dBvS3Ehybc/PaXrlUgN
         dlf6pjTzE+RJZA9tgenZOiHU9LSXXSKFC3/qSmgUCxcj9/7x1bTG1s4YSueztChj5Aqa
         6MCg==
X-Gm-Message-State: AOUpUlF+Nu4rBWhgs3l1t50leqRDtLMt1lQyFFbVbLcOFMuvMhNz4eUi
        lTAKgnM6qaMRJAazgVVtYT4=
X-Google-Smtp-Source: AAOMgpeXoi8R3MXH8hpnB5qk3pFE/918XLoh7CIWJlz7ZWYaDHgZkSRRkgXNEyVEr5e/Pm0RRNqKBA==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr3181143plz.26.1531861489674;
        Tue, 17 Jul 2018 14:04:49 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:48 -0700 (PDT)
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
Subject: [PATCH 04/32] staging: gasket: whitespace fix in gasket_page_table_init
Date:   Tue, 17 Jul 2018 13:56:44 -0700
Message-Id: <20180717205712.29495-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Tab replaced with space.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index dcd52e141f95d..36a560c87af36 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -347,7 +347,7 @@ int gasket_page_table_init(
 	    pg_tbl->config.mode == GASKET_PAGE_TABLE_MODE_SIMPLE) {
 		pg_tbl->num_simple_entries = total_entries;
 		pg_tbl->num_extended_entries = 0;
-		pg_tbl->extended_flag =	1ull << page_table_config->extended_bit;
+		pg_tbl->extended_flag = 1ull << page_table_config->extended_bit;
 	} else {
 		pg_tbl->num_simple_entries = 0;
 		pg_tbl->num_extended_entries = total_entries;
-- 
2.18.0.203.gfac676dfb9-goog

