Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C289BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA3820657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIuYyq1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbfAORWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:22:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45547 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbfAORWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:22:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so1602473pfd.12;
        Tue, 15 Jan 2019 09:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M/jhMqfrmML8QQKfJ28Ox94pBVqAdhbx+CKgP+XNCqM=;
        b=KIuYyq1oH9vfhAB8QCsr3rYqdCpSF5j8F6I1/Jtv/5F1C5AbrGYsdGknPv3/ToeGKv
         8kNRH8fcFjTmOpSExh/PObHa84Kd/QcKSjmj4DT2VwadCjrFc3WmHkSXv2HaDX0DLIjh
         4BVLtOdCuAoGQ0CnJmsxjwPa91g/cOOvMum0n2uo3m4mXKDOPN6yWdw6u+7aMr3zfC0f
         ikKXossZz1lhfTAQzXIRsiqNrYutveaBwp0cevj79atAExXi0e3o0Nj4zbJWBk+GrmqM
         kw0PABsyXs8dufweKb45Ky+gUBiJDlPORVBrGPmT30gQHmIuS8zqXghuvyz4AXkAyJ/n
         VR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M/jhMqfrmML8QQKfJ28Ox94pBVqAdhbx+CKgP+XNCqM=;
        b=UiIYpXYVfHVp63OFuC93OcbPjjsrSqGMeBSZyMeoO/l03iRbJhcepKcsLS8NOnuqL+
         RzdrsAJjTclnh3BjqQ+2cuwrfdtVhG2r61g/T0R7LBO9/Jsi16NKDa/YDLFCR4FWvABm
         yTrTZIgj99yejDaRv69c+QyJkHpmf1Whdb9mmDmT/aVQHXxn0UE4TDwFiuqZul/xtEgm
         4q4Qghdgu4+N/STzNnhxbDBHcqEiBKtTxB7wvtJGd7BBkl3UQ7pSiJWxHtvpuNyfGq5R
         TLBomCNJWR4GLULzq1aRl6Jfmme3/syiIgmvNjEZh2XTMc/KWCk16JqDSgv6DUgXlnfb
         KSXQ==
X-Gm-Message-State: AJcUukeJmWuGnagHN6Lw4nHRciv/r41qg4m5RapWl9+had4pDh+okXVz
        wqtp10oyTj3IXSorEs766+k=
X-Google-Smtp-Source: ALg8bN6FtLFfVY4UYZJ6QEBEoLwwNAlCyUjHNbpKEMHGP2o8oQO54XwJUTMip9PvbIPSH1wv6XyJJA==
X-Received: by 2002:a63:61c8:: with SMTP id v191mr4791169pgb.242.1547572938451;
        Tue, 15 Jan 2019 09:22:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q75sm7408708pfa.38.2019.01.15.09.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 09:22:17 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpuidle: use BIT() for idle state flags and remove CPUIDLE_DRIVER_FLAGS_MASK
Date:   Tue, 15 Jan 2019 12:22:10 -0500
Message-Id: <20190115172210.19793-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BIT() macro to do a small tidy-up. The CPUIDLE_DRIVER_FLAGS_MASK
 is not being used, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/cpuidle.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4dff74f48d4b..3b39472324a3 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -69,11 +69,9 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_NONE       (0x00)
-#define CPUIDLE_FLAG_POLLING	(0x01) /* polling state */
-#define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
-#define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
-
-#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
+#define CPUIDLE_FLAG_POLLING	BIT(0) /* polling state */
+#define CPUIDLE_FLAG_COUPLED	BIT(1) /* state applies to multiple cpus */
+#define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
-- 
2.17.0

