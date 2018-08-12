Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5E6C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 05:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C757021A5D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 05:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1rO00kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C757021A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeHLIG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 04:06:26 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46843 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeHLIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 04:06:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id t17-v6so5605070ply.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Fah44/1TZ+edp/MQOLQd0PWYC5x4zaOhxd+IRpp0aYE=;
        b=q1rO00kjh6jb6YhDzsfJZ3b3tpZXaQpHPOq/OHqsQWWAk/2uIpmsn5ICtiRInbRv3l
         fkrDd1rhHcyQQYUiZZf0x3rAU3ZuXY10Lhk4jxD4Yv2OHq1K4r3yRkj3f8mRieckzmrF
         TvWdNeod6OO2nhEwQazrBSH+eDbE3lqyh27pcaoZ21tEE2Qbf0mBh4zPOwkcLHKStLdm
         UprQz5PcDQPDSnU1CJu6E1ptTh+YdyPHAWcplR5bibhbOwED6ZsoTG6eH51xIWY6OGcR
         xEvQBbmq9EVQDfmnTMWauNNBUdUKsYrcpBajYnV5Xww2mfSuDsp1bV0A9TSRFL3U5OcM
         Ia7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fah44/1TZ+edp/MQOLQd0PWYC5x4zaOhxd+IRpp0aYE=;
        b=Ab4LfWRMrfUDLgfWEnPzJq7qSzncyYsFqhx8vSf+w4n09gEYVMQyIQn4K4zYkMvkaj
         4YJop8dETGRSySvxoH6fwiVNHqT1QQEgRI2u2Sm0OPYDHWHplHRPozGFX4K3G5Ce3rNQ
         KvxEXLLFf6IfxClEHis2f19uP116amzRC30A7pAH4YkcCQ3OgeEsciG651d2KPaWavJ/
         D37nWsyCQmDxgBgdytpdmtNY0MwDbrY/DBKwR/nq3im2VAWI50p6vw25dUr2EmBDnSuo
         CSgF8lTxmfKLS+zo5rqpAhhqNYlsc/C1VpyvIRIIrLxq9Z2TSxkPgiXxB2YeDWFJ8arf
         Kr2A==
X-Gm-Message-State: AOUpUlHFMBHlWRvXGvEFXu/dk/i2z16R9hlB+FPAQj9sYQtHPuWHPGnZ
        M5nv1sgIbyuugptmXqLFBmdbTmcc
X-Google-Smtp-Source: AA+uWPy1cu8Mc/lzHqd9RstERJBaP3G3ysChpIhDY/bpvYHg9LZB4qnaxctlLaV4Aggsc1Hvl88F/w==
X-Received: by 2002:a17:902:184:: with SMTP id b4-v6mr12154805plb.340.1534051782067;
        Sat, 11 Aug 2018 22:29:42 -0700 (PDT)
Received: from localhost.localdomain ([147.46.241.218])
        by smtp.gmail.com with ESMTPSA id d81-v6sm25963757pfj.122.2018.08.11.22.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Aug 2018 22:29:41 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     paulmck@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH] tools/memory-model: Fix a couple of typos
Date:   Sun, 12 Aug 2018 14:29:28 +0900
Message-Id: <20180812052928.32354-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a couple of typos in README and recipies.txt.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 tools/memory-model/Documentation/recipes.txt | 2 +-
 tools/memory-model/README                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index a40802fa1099..29df496c1c77 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -311,7 +311,7 @@ The smp_wmb() macro orders prior stores against later stores, and the
 smp_rmb() macro orders prior loads against later loads.  Therefore, if
 the final value of r0 is 1, the final value of r1 must also be 1.
 
-The the xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
+The xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
 the following write-side code fragment:
 
 	log->l_curr_block -= log->l_logBBsize;
diff --git a/tools/memory-model/README b/tools/memory-model/README
index ee987ce20aae..73313faf4036 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -89,7 +89,7 @@ The corresponding output includes:
   Observation SB+fencembonceonces Never 0 2000000
   Time SB+fencembonceonces 0.16
 
-The "Positive: 0 Negative: 2000000" and the "Never 0 2000000" indicate
+The "Positive: 0, Negative: 2000000" and the "Never 0 2000000" indicate
 that during two million trials, the state specified in this litmus
 test's "exists" clause was not reached.
 
-- 
2.13.0

