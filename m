Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E3CC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26BE223E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To1t41ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26BE223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeHJFtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:23 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36873 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbeHJFtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id d5-v6so3435037pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gG9X64yFfh3t0HzNukSh7fXF8kJQf5vX++7kKagUn8=;
        b=To1t41epPSkISRSgp6MXw1A/McpoH8DF1nsOSPOfk0cLegnsG0VLVOmSR92BSQ3laB
         MwFdqkor02UJ0ndY5uwTUXE0LktIaaXjuEVpLONzcsq0ap4QsVoFgx3OiImqVps8XZdO
         Fr26Rmhsv0jteHK6m7z+FKVHF4eExrqxibLQdUaLGla8VKZMd67av7qnKBKm3Md5+ntN
         sASkncq2Jl75OQUV5rX1r/FIYWtvD/afbDA8FIB8ZezgxtA9Cz45R9K9DqPX8HOEQBRg
         m3+VRM4P88zNT8E86bvHoSLq/GklmCQkPLyt/B1PrfghtPlxjWpotQUEJhJLF7jAMNlE
         1ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gG9X64yFfh3t0HzNukSh7fXF8kJQf5vX++7kKagUn8=;
        b=dfuvBPpPAwIirfqOK6J2dyHCRmARgHMrxitHIYmJaaDTyJWHjldDNTLp4tZukwjLUI
         Dq1LAogLj0w8nun+vu6Fy6/pq2R4kG0U3RhnA/m51g/LyFjJAI146+kLuzbj8G0Tkb0l
         i7mRElDhK5t3tbFHnNyL40hbZ0cU5/uEfVirTcwGENrdBtkbul1OXsmtLGXGvF2WvqDD
         wns5pckwYCeVhd1uz1kuWZ3GJJ+ZQB77i34g8pEy8OaQzfDSL2yN2C33aOdoxe4KdBX2
         wuo/WBZWYZbZZ1lFeHaZkvcG0JfloyhP7AahKJ8dPRFLSZY6C30GIWjhHNzwWQbCxuEy
         qeOQ==
X-Gm-Message-State: AOUpUlEXv2RoadMw7zaTD+QlKisCM33Qqyl0mMmq7euTIZB4Z5dQvTYa
        mweV8VE63/iQgfaR6029Soc=
X-Google-Smtp-Source: AA+uWPzxyWby8oUzLXgi1Oo6yh3PSm5JysIpejxwhYjKBODUxnBqsuqo6X0Q7+M3Ig9M62wyNew7oA==
X-Received: by 2002:a17:902:b609:: with SMTP id b9-v6mr4373924pls.321.1533871287795;
        Thu, 09 Aug 2018 20:21:27 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:27 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/16] staging: gasket: core: remove ftrace-style debug logs
Date:   Thu,  9 Aug 2018 20:21:00 -0700
Message-Id: <20180810032111.197743-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove debug logs that only indicate the name of the entered function,
in favor of using ftrace for function tracing style logs.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 5f54b3615f67c..0fe5b86b294c8 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1789,7 +1789,6 @@ static int __init gasket_init(void)
 {
 	int i;
 
-	pr_debug("%s\n", __func__);
 	mutex_lock(&g_mutex);
 	for (i = 0; i < GASKET_FRAMEWORK_DESC_MAX; i++) {
 		g_descs[i].driver_desc = NULL;
@@ -1804,7 +1803,6 @@ static int __init gasket_init(void)
 
 static void __exit gasket_exit(void)
 {
-	pr_debug("%s\n", __func__);
 }
 MODULE_DESCRIPTION("Google Gasket driver framework");
 MODULE_VERSION(GASKET_FRAMEWORK_VERSION);
-- 
2.18.0.597.ga71716f1ad-goog

