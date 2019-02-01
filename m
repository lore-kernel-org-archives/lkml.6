Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A09C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E536720863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ambKAiD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBAVKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:10:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36323 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:10:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so3821384pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 13:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B/EOcG6wkzwM+DGjGCwz/BS3LDMMg3hdZ6/00CJ+sjc=;
        b=ambKAiD9wPSUU34x6W7rNrmIEs4+xPM9fnTf+VPILoj55sx4oCh74VpBzlL5Hm9p//
         hkO1upSeGra+lagJBVfZT9l48qEVTQl8ofI00t9diB6ksrMEV1fa8gk1jNywPgAUI2Fm
         +8JI1onQYjX5guI7xD3JoMcHN48NSLPwuA5VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B/EOcG6wkzwM+DGjGCwz/BS3LDMMg3hdZ6/00CJ+sjc=;
        b=QE9cy+5wTeSW5/kKWqIZmwDBPrgPTnd//94VMduBIZdxDBD7bkhHtqjd+hFvNwMk2B
         fE9sJit1HCDA0bFL0PCTRlKS1r/Yz4d5oL/Z5xbYrb0qvhWlnwpjShAY1iNnnXDBJCjP
         Q2Xiw9IxFcN2AK2a4PV7K1oFUEC9rP9cEYmkCsmuhO3m7gQDdJzPjcOA7IHT6+IhPKsS
         PR000y0XNj/D8IXwvlxe6KDMT0O129WMOHQvomCqkG+G/Ly28GMATPoIrDhN8jul4rVt
         k7q14wdXnqHNsw8n1R2mLFPsJINV6aZE7slIJNtC4SM3nPpmFcpTm/MBPaNbX79GHsma
         PuHg==
X-Gm-Message-State: AJcUukfSqrHdoeyw/u5S9zK9UsDC7J8saSpiSgBj0AWtKIzChSSqphre
        lQBS7ib9ivGDln3w1D4iQ4BrbA==
X-Google-Smtp-Source: ALg8bN5lOzU98RnaxsElvDdBste++qcqh7B0C8NC7Sb5VqMgEpTaxZD7Hzjz48sLtgefoo5n/tQmvg==
X-Received: by 2002:a62:5793:: with SMTP id i19mr41258672pfj.49.1549055419859;
        Fri, 01 Feb 2019 13:10:19 -0800 (PST)
Received: from flatbox9001.mtv.corp.google.com ([2620:15c:202:201:8a81:a957:49d:5968])
        by smtp.gmail.com with ESMTPSA id i62sm9475957pge.44.2019.02.01.13.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:10:18 -0800 (PST)
From:   jflat@chromium.org
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, Jon Flatley <jflat@chromium.org>
Subject: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
Date:   Fri,  1 Feb 2019 13:08:53 -0800
Message-Id: <20190201210853.244043-1-jflat@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Flatley <jflat@chromium.org>

gcc produces format warnings that clang suppresses. To keep behavior
consistent between gcc and clang, don't suppress format warnings in
clang.

Signed-off-by: Jon Flatley <jflat@chromium.org>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 768306add591..94daf4e1fc73 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -68,7 +68,6 @@ else
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
-KBUILD_CFLAGS += $(call cc-disable-warning, format)
 KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
 KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
-- 
2.20.1.611.gfbb209baf1-goog

