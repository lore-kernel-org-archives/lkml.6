Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12274C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA12E21755
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NL9HKslt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA12E21755
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeHNCXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:23:50 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:39527 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:23:50 -0400
Received: by mail-oi0-f73.google.com with SMTP id s200-v6so18556154oie.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fmkeoi5xFduxhgyUEewnj9VOdSOLZ4E+BgTYPrCRT8s=;
        b=NL9HKsltT9hHEXsPRb963p8LLVvzyUZY3SRdwVhei6hswIJex7KGuEqprVgM7QoyVW
         1yfMsQ0rJ7UxTkwU53IuzmXRL2kmAQfmqm74UYJx+DOxAa8nsDZhIQcKh/3HYXEwU6qU
         P6uSUtcTT3bP5BKxtXhcb+AYNzY9lenFBGE2ZFdXi3JoQ2S0/XMiUUJpf+2j3dl0S1XG
         Nw1yaDHqp+YrNWetp1L9dRLMa++0jSc9Zur8sVsiyuiVbXjouhx0goITSWRLHHxZlad2
         xJheTJ+iHZy46L/J0hAErkl7GIOoOw80mhvSBAjJFrkX52C6Hsj9qlWjqV8ps+aZeF9R
         9S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fmkeoi5xFduxhgyUEewnj9VOdSOLZ4E+BgTYPrCRT8s=;
        b=gGjV4VVd5Muzk7w7iHeF95dqy8rejya0IwaEkgAzmU/zPWuOnsfMLqxb0ktFhp9+eu
         4re7q0IsxLD8+iimhuuACCbNL8lss0FTtNFJlS9Rb/yiW49UJxspsoRrc/BjKDxUhQwO
         uEdAvOt7JIln1x1UTG+OEhXgg6dyv7EGuXnphMIk8wVD11usoO9UV9WxZyjuKh/z44f0
         /Yw/oGCcXjKvgA0r6vR9hpeZlT5nIw6OVaPwloDdQgORzfrdFKV+Y1FNuCi15rYr+KHu
         +aKtf1dfR7YnU46XtuWZUEozxo3fZTAqeZHAt93+P/NFyMkzFoojdoczjPnFaEKTAvFE
         aAdg==
X-Gm-Message-State: AOUpUlGiFBqJHKm4A+KqBNPstjeY+3pukJ0oq3EmJpnyfAbHMQdxAG8r
        hAo4v3BEgKe2Pyv550A7qpHKX280
X-Google-Smtp-Source: AA+uWPy+dWAt3G6mm+ESPtDJSN1WBBPfRL3t3GgPZkUeUXRjvi2g8u366ejMnExsQFWkl5qy+pc8nl26
X-Received: by 2002:aca:53c3:: with SMTP id h186-v6mr13117779oib.31.1534203561863;
 Mon, 13 Aug 2018 16:39:21 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:33 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
Message-Id: <20180813233839.190855-2-rkir@google.com>
Mime-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 2/9] platform: goldfish: pipe: Update license
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

goldfish_pipe is distributed under GPL v2.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 567005fe11f8..065b2eaab9cc 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2012 Intel, Inc.
  * Copyright (C) 2013 Intel, Inc.
@@ -983,4 +984,4 @@ static struct platform_driver goldfish_pipe_driver = {
 
 module_platform_driver(goldfish_pipe_driver);
 MODULE_AUTHOR("David Turner <digit@google.com>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0.865.gffc8e1a3cd6-goog

