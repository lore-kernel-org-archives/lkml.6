Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C935AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974CD2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNerrDyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfBZKDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:03:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43457 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfBZKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:03:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id m10so5987216plt.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iKgSR3pgBbxBFbm4Ql4W6QsvFtlkjW+qw2rlTVlUse8=;
        b=XNerrDyomy7JLG77HEmJHx9s0r0RH/KfGNiMdgDGtkHfd5/6/F46oEVdSK1Stlpk0F
         IhkXp6d/2g47nyAxMDyw2kqLUCZFjbPUYaXgU0aglwHnDAGoGsY/zLVToZxkK0z+25zg
         g9MbZLN6z66bbPWty+afg1eiEM8l14mnX+haIomj2SYD9OyoScDZK/6frlpMOPeh/bLQ
         GTspI4byHD7ZyVULgyckoxs/qBE8ItyV4Mjl7VT9tYE3F1dkhS+YRjcy0+8foV0UntqT
         kiVnlKshIdd1LCPHGI9tcN6Bu4CJcclyyTqKwBcedLEVuRAXf8D11hzjT98kaAVYaq0/
         c20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iKgSR3pgBbxBFbm4Ql4W6QsvFtlkjW+qw2rlTVlUse8=;
        b=RKJj2NQG3SPd6iq6twrqww4NCo0GPrNN9jgvLb1DftQ6IfHQ6k5yiHBjRsiLfbEEUE
         /xDMo7xC9UzlzIK7WrprYP82R3xYADSDGc1TC/9Kap5cTqIbNXDeCvI1OFK8w3pAK3MS
         MOiU7OMsTBCyNzoNPr+aYaJLdZAt8T2kVefRxKtzIdy/RTdW2bUKfFIdatxtERUE1QMz
         HYDiK/NZlTadTjWwJYg+k5PcbaLNiOpp++xZaT83cU5k326HcjTclt4WZK/LnoybUwP8
         ETZs7dU8IPRiIRIzQ0zrDAF7XNlO5i68U7PY8z8k35q2ZWcnM1lR6g1dK6UpsNcl4OEA
         SvYA==
X-Gm-Message-State: AHQUAuYcvGKwoO65jqDE5WkoiyNdiK7CwPrKF33lmGN2juEtCzrP7rVl
        dg9B965UTOzIgIxN+TCXsZc7qefu1Ts=
X-Google-Smtp-Source: AHgI3IbaNU4IafCO2jzkU9NCkW04HANbifT9Uv0oomw26ES93Sl0TKJQaE/T+fgh1n5Xn5PD8oimZQ==
X-Received: by 2002:a17:902:7782:: with SMTP id o2mr25616885pll.315.1551175423846;
        Tue, 26 Feb 2019 02:03:43 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id y6sm12045520pfy.87.2019.02.26.02.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 02:03:43 -0800 (PST)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 3/8] locking/lockdep: Adjust lock usage bit character checks
Date:   Tue, 26 Feb 2019 18:03:22 +0800
Message-Id: <20190226100327.19340-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190226100327.19340-1-duyuyang@gmail.com>
References: <20190226100327.19340-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock usage bit characters are defined and determined with tricks. Use a
macro and add some explanation to make it a bit more clear. Then adjust the
logic to check the usage, which optimizes the code a bit.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 21 ++++++++++++++++-----
 kernel/locking/lockdep_internals.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 41eab3d..8b8495e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -471,15 +471,26 @@ static inline unsigned long lock_flag(enum lock_usage_bit bit)
 
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
+	/*
+	 * The usage character defaults to '.' (i.e., irqs disabled and not in
+	 * irq context), which is the safest usage category.
+	 */
 	char c = '.';
 
-	if (class->usage_mask & lock_flag(bit + 2))
+	/*
+	 * The order of the following usage checks matters, which will
+	 * result in the outcome character as follows:
+	 *
+	 * - '+': irq is enabled and not in irq context
+	 * - '-': in irq context and irq is disabled
+	 * - '?': in irq context and irq is enabled
+	 */
+	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_TO_ENABLED_STEP)) {
 		c = '+';
-	if (class->usage_mask & lock_flag(bit)) {
-		c = '-';
-		if (class->usage_mask & lock_flag(bit + 2))
+		if (class->usage_mask & lock_flag(bit))
 			c = '?';
-	}
+	} else if (class->usage_mask & lock_flag(bit))
+		c = '-';
 
 	return c;
 }
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 2ebb9d0..2815e85 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -25,6 +25,7 @@ enum lock_usage_bit {
 #define LOCK_USAGE_READ_MASK 1
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
+#define LOCK_USAGE_TO_ENABLED_STEP 2
 
 /*
  * Usage-state bitmasks:
-- 
1.8.3.1

