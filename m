Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DDDECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE63208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 06:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b74mbzVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE63208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeIOMQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 08:16:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43250 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeIOMQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 08:16:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so5365230pgb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xZ3k+JiLm3H50ZYovuhDbIo7tgKEc8Eks2mm3KskRo=;
        b=b74mbzVJeUj27GH6zbrMI4BzkbJ0yUxu5ohf+SOubmrW1qD4ERYzGg28IeCmzowEBY
         GGhc71L/MBJ8IR9m6oSmtcXTqTzdJEymUUdGtLX88lqFNw41IKL0CUPu6CAXhAa2LsNN
         /wK05uGpiuXRj7hB8RFtwqtggYXfLCyTzFrf3tLBpEpIJ1B/bJULe341D1qok+eiZvH3
         +JLOyf1kxz+tOW/wENjVr+PPDzF2S6lPZmQjcKYrzR17yf/ZkoJFyf/hTsBK7/ElrQk1
         mqSc1Oj1dLeqURJyPjRH1tRUV5b3cztW5lk8TEhxpIDDUrpZ92QlTNr0D1nWBRLwjd+P
         +jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4xZ3k+JiLm3H50ZYovuhDbIo7tgKEc8Eks2mm3KskRo=;
        b=Cx81tR/Yd3IXnLHjylLUuTRsEAQVY43g0lZGiXdZpd5ZvsUyTy1Pn2Zn0wf9D63Obk
         +0KeIREje9y9zZh2arwDrDSkeHOCr1w54xq1CLk9A+XXAYs9NYgNzl/2WlSR1kKf0+7N
         ej1pKez3AJBuQVwZZpNZUD/TUjct2dXde25NH1hYK0vdRWcv6KxoJAGGvzLUNQoysg0F
         BJIeznT8YcLs6HiA+ALPg4ZzjJYZSH66Yb4xCql0NMvVmOXIFDT2bWZNqFU9ch3PEIfV
         g6M7IMRj9M355auTxH/WUImNuFHDxqfwRCZRDoRaXfT4k9pZfTaKPlEJdQFp74xEbTw6
         YMJA==
X-Gm-Message-State: APzg51DCjb6E8dTfMzHZr3kPXDEnAUGfW/cl4jADWFj2D4QvzgmHt5Br
        aIFb2S7TNS7XMe6JzwWetAo=
X-Google-Smtp-Source: ANB0VdYhGOzWWUC0Vrh2sCQAZV/Mcs9RYY6eJJSZgqDjnj2/ZyTBIdW4E7ULrpzT4KYlpWz1M99KhQ==
X-Received: by 2002:a63:a745:: with SMTP id w5-v6mr14686469pgo.374.1536994735043;
        Fri, 14 Sep 2018 23:58:55 -0700 (PDT)
Received: from localhost.localdomain ([136.24.158.133])
        by smtp.gmail.com with ESMTPSA id o20-v6sm25786068pfj.35.2018.09.14.23.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 23:58:53 -0700 (PDT)
From:   ysoheil@gmail.com
To:     gustavo@padovan.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Soheil Yasrebi <ysoheil@gmail.com>
Subject: [PATCH] GPU: drm: drm_modes: fixed a line length coding style issue
Date:   Fri, 14 Sep 2018 23:58:35 -0700
Message-Id: <20180915065835.12808-1-ysoheil@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Soheil Yasrebi <ysoheil@gmail.com>

Fixed a coding style issue.

Signed-off-by: Soheil Yasrebi <ysoheil@gmail.com>
---
 drivers/gpu/drm/drm_modes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 02db9ac82d7a..1eed35c549e8 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1318,7 +1318,8 @@ EXPORT_SYMBOL(drm_mode_prune_invalid);
  * Negative if @lh_a is better than @lh_b, zero if they're equivalent, or
  * positive if @lh_b is better than @lh_a.
  */
-static int drm_mode_compare(void *priv, struct list_head *lh_a, struct list_head *lh_b)
+static int drm_mode_compare(void *priv, struct list_head *lh_a,
+				      struct list_head *lh_b)
 {
 	struct drm_display_mode *a = list_entry(lh_a, struct drm_display_mode, head);
 	struct drm_display_mode *b = list_entry(lh_b, struct drm_display_mode, head);
-- 
2.19.0

