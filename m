Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75470C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157E52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgEW+H5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157E52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIKRSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:18:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39136 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeIKRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:18:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so20621888lji.6;
        Tue, 11 Sep 2018 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=agjyomkAqshVEbDPthw3qbDe1WUb/0nPMK0VQqTwFJE=;
        b=IgEW+H5n6Yr1atqP3PmFBOCIUAOWGl0aZUJqIjjkwDTbwmJf2Oe9sjKUSZRjmY3V98
         4Ya1IXjzdtfrryrBGYuD6r3XUL1w/L2ClPUSpW6JtLN/np6CIIbjO6QsnEzQMZ2IUIGh
         OHuVEzxWGDT8e6OfMhY9z01bVe424XPjRs6dwimwGBOo5Y58Wbw2Jon4Xh19Z+uIHaCS
         s+gjyYdNyDZW3TenXp1bDYLyjH0e0C/U1nA6xJ6lOYhCpeQzGnkaBwnwl2q5V8HBaQ7M
         hjq0r2YM4YS+Ept+qTJ21yYmfQu2f/LExhM+LwTe4rs3PZnNFND+jC4UA+BeB+gQkze0
         peMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=agjyomkAqshVEbDPthw3qbDe1WUb/0nPMK0VQqTwFJE=;
        b=TXFIiL5rK9sQ0UhA4WYE88zfADdj3zy6iVdqkOl6YbYy42/XjvWg+khnoUipWnx6iQ
         6pppkltt6VCDGQ/j+s9C/rKf6xpLf1uReB0lekdSw0PmZPl2REQqRIWol0WeSYAuhtxC
         XOE92xvMFgluny7vgJh3bKMgYVklxgTbG9FlcQiYrlx9VriVrRIRuJeuyvuD4y1qa3Mj
         JDYsr/AqQUCzAG00BxyNysgKq+0KRj2Ahr+cdkcDbXEoitLhTZYV1VRydokWtCYx2z8/
         Zt7fHvRF+STYqqOLAGZAru2Qh3uqeBZ6h5q308VgctY0RLBxoKFOQ0uH7PeP1RkEMTk2
         7TPQ==
X-Gm-Message-State: APzg51CbUW2c9iGU7gtbCo89gyw1XsLKNQm+zh1R4NECo5xX4CxTNkbC
        EAHO3EKsUDuWdmMua50MG84=
X-Google-Smtp-Source: ANB0VdZhgtbeyolY6+u2aW0ZG9kqCFkf7hcU9X3b/uhWoTyZmyA16ZP/gLhOdkrHylqXpQ2PDOnH5A==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr14821696ljc.148.1536668365861;
        Tue, 11 Sep 2018 05:19:25 -0700 (PDT)
Received: from Mort.jumbo.freeair (drqv51zl1s10p1948tk-4.rev.dnainternet.fi. [2001:14bb:73:639a:d135:7d7c:caf7:1c82])
        by smtp.gmail.com with ESMTPSA id f9-v6sm3296925ljf.9.2018.09.11.05.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 05:19:24 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] asm-generic: bug: unify hints for BUG_ON()
Date:   Tue, 11 Sep 2018 15:19:15 +0300
Message-Id: <20180911121915.30236-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If BUG_ON() is used instead of BUG(), it means that probably the
preferred outcome is to not BUG(), therefore the condition tested should
be unlikely().

However, when CONFIG_PROFILE_ANNOTATED_BRANCHES is enabled, the hint is
disabled, to avoid generating false-positive warnings caused by
-Wmaybe-uninitialized.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/asm-generic/bug.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..b91273c36baf 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -58,8 +58,12 @@ struct bug_entry {
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
+#ifdef CONFIG_PROFILE_ANNOTATED_BRANCHES
+#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#else
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
+#endif
 
 #ifdef __WARN_FLAGS
 #define __WARN_TAINT(taint)		__WARN_FLAGS(BUGFLAG_TAINT(taint))
@@ -183,7 +187,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
+#ifdef CONFIG_PROFILE_ANNOTATED_BRANCHES
 #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#else
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
+#endif
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
2.17.1

