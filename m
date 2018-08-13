Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDA0C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623FC21758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDZ7j51S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623FC21758
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbeHNCYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:24:02 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:41061 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:24:01 -0400
Received: by mail-ua1-f73.google.com with SMTP id c13-v6so8509766uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7e7HdXoi9bnRKx/iR6BbLaDysyKfZGcjHn6Pl8qK/5I=;
        b=nDZ7j51ShDEBvXgZmxOdZoWHaExEK882YPmaGztRBk65AiNO11M9gpsMqkIm7XdIaa
         8FpNndjwDvOegkfNOef5yydeXpJkwCxNYqoFXT+HNuTuA25G6S7JN+dNJSBkkmozkio0
         wALhWV8+3BKeFrboc89FQlUQXl0Ox3ZLr9d1kQsv9l6KZKYZFyHeFuyIUjB8clqT0iJO
         LCKxIOwXDxI7tXshs1GvO9OB7TNBhplIC2i/KA9SIM1oPa/ruWkCbkRHkaC4HMse6v08
         8lmuLq3+INhdCFL3ndAtWrfHNo9nYgxzdevm1gTPwUUtuqsU/BKhO9o6QinoB9taomLd
         MmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7e7HdXoi9bnRKx/iR6BbLaDysyKfZGcjHn6Pl8qK/5I=;
        b=lPPxIh7bkyXbYq6TQn0opcWoyiSkGYcZZhI6tINjlIdUexZB+wcv3UBNple1cc7/uq
         qpEcpRBE+pX+P/1U683rx8ev8iB9f5+UERl13rbZrWBf355eF8VFDhHOC1q/6nQDVjBQ
         xY3R7ce/USwdt+f7/xUPZzO+PIvjNIDTKWqdPd5nf13k2bLK1/KODUOkmL6LKL+Dagbn
         ni1PqlNv4kbFgvoz/5OWT5qtGvIO4y78zQWBsGAe6BCycWGQ5c5T0IJrYsuxIVtFUc73
         0WW/ZeL8vCcxXDCl7Zwf3XEUGZsjbxoP3Y5/JAXChbE1WDvf/4T755bxTiPXmFZJDbqf
         Ce3g==
X-Gm-Message-State: AOUpUlFtEGVNycgnnMUyUE+oS4LouUtw+sS/Pdn7a/dZbzympIgUCpmh
        OmTMJdPRCCxki7DrIV16dRNibNwH
X-Google-Smtp-Source: AA+uWPxx6GJhI9dvcTYCz60B6bFcDOcTGrx05ide6abwb3qs0PMmyNjIOwT4HwU+/cMgK9/Qk+WYG3/w
X-Received: by 2002:a1f:898f:: with SMTP id l137-v6mr10674988vkd.33.1534203572817;
 Mon, 13 Aug 2018 16:39:32 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:36 -0700
In-Reply-To: <20180813233839.190855-1-rkir@google.com>
Message-Id: <20180813233839.190855-5-rkir@google.com>
Mime-Version: 1.0
References: <20180813233839.190855-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH 5/9] platform: goldfish: pipe: Update the comment for GFP_ATOMIC
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

Provide an explanation why GFP_ATOMIC is needed to prevent changing it to
other values.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 8f9580454154..a4db4d12b09c 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -639,7 +639,10 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
 			return id;
 
 	{
-		/* Reallocate the array */
+		/* Reallocate the array.
+		 * Since get_free_pipe_id_locked runs with interrupts disabled,
+		 * we don't want to make calls that could lead to sleep.
+		 */
 		u32 new_capacity = 2 * dev->pipes_capacity;
 		struct goldfish_pipe **pipes =
 			kcalloc(new_capacity, sizeof(*pipes), GFP_ATOMIC);
-- 
2.18.0.865.gffc8e1a3cd6-goog

