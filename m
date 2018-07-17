Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608B5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18441208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH9uKS1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18441208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeGQCj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:39:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33863 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbeGQCj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:39:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so8261995pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tTXbFz3WKwiG+9N0fxlLYmbI9e8jwvYVZrvo3SEj82E=;
        b=iH9uKS1VHX4LbynLvjZyIHdOaZ14x0pn887XiPV5grJyMDlHMmbE5fdlu7JjP4zxJg
         Sz6yMOUOoOSwWWFQHYIzTpDG1qWjeC22UCa8uVM11ffDBwd4LQFKMCcjEvWFr94QGEeC
         hrjmRxFr6X8x1z7+PBBoYZypV2Np4927W+0bCjJEX2Og6RdD+r6iasP3pRjd5Msjo6ap
         i9Ut+58FvccnJU0qJiKd59ZT3zdEGf/LCSJGe5juJaUfPw+r0abD2rX3PmEWQO0C49HM
         XWsjV0+bpkNSWowF/HNdkssLD8OSxQzNXyErzsgRstm5OszwC/ISjSq3lynRIq5oKEtu
         W7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTXbFz3WKwiG+9N0fxlLYmbI9e8jwvYVZrvo3SEj82E=;
        b=Y4Bix4NOr05ZwNBsfKvM2Dp7TQKBe6OpJ7zYGJ4CQazZgWn522POHnu1s+9LM/p341
         7QC/rI0zR26YYinSi5Li2EU9b5XEifpxyYu6pGeLSFlSFDW0ZXryIbbQajZvvDyNepdw
         uOiPUrJ8+ryE7MeypkuQ2xICR0CnLEw6iOBh6OFstnVFTLi1MqGwgrnPJBYXOdAJzGpZ
         UuJ099DN4glMxeb5u/ZVeIerbawBu6P1MHmqDEhFnu4AaQbXBlbkNfecYt8ULE9GbSfG
         m7IQGS4z/ko09jQGmk/7Cu0K2XIRJhJpwwFWmPUG/F0OAYhLts+nfjAeLDMuqgnDyoPo
         2wIw==
X-Gm-Message-State: AOUpUlFDYVrvb0LZ5Y2rNpIYmVNI3BvdTdzYw85dfoccWDpxHKRMHdGo
        8/15Zixuy1iSp2ykNdPopNWQ4COi
X-Google-Smtp-Source: AAOMgpfk+bnlsAPx1hTyi9gmZSFUrHew9Xpb8ozjCB2AZ8Xp5iWkjYKnzfZoIcB6W/hsAKd2/e1OGg==
X-Received: by 2002:a65:4d05:: with SMTP id i5-v6mr17298462pgt.58.1531793388685;
        Mon, 16 Jul 2018 19:09:48 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:09:48 -0700 (PDT)
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
Date:   Mon, 16 Jul 2018 19:08:58 -0700
Message-Id: <20180717020926.176408-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
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

