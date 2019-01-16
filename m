Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A133C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAC8205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBuU7Snl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfAPQJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:09:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42811 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfAPQJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:09:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so3012913pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9CIbBSmbne4E3sSPgt3DDYr+TcTJoKVZqcg6VHLE14U=;
        b=EBuU7Snlky8qWqG/LkDQn3REVBy3m+URGRKxo3NUPU/VscoZ+fE/T9ZS2bkGpcJ+j0
         y+qc8DihXSr0GVd1aDLBEgir3hde84tq2i0mLpbCQurVS2H++VaxXhkrxVgJvjPqkkA3
         T/G2DMeQym1IVtGMGQkq3BuLow+zSAyUzYF2fSqWd0vqtYj/vDJZRYxXIZ/tMgDp7Czu
         ZSqszKBvTqyAJmRgJSepV6+dxiKHN/FI3G0HAJvQvMjjp9oyKFGzM6qZ/Hh8CAoskH64
         XgoNReItM93yAp0cBAiiM5oqDJBcLMVBPP+X6IQqeA33wOt2MOEFOKtx+FABkUOQ5Q0r
         WzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9CIbBSmbne4E3sSPgt3DDYr+TcTJoKVZqcg6VHLE14U=;
        b=BIDjiP58Wrtbew+PgRkxaPbH1OSw1UMpJBwLSuedwWlsjIvwF7uvKza0YJNZLGbAc6
         H02rPGJfQ+UD5Ry+oCxfFC8ClZXEEaWFd9EzgSv/o2MAfwPZYHkafNonuOiMvFDWZAOx
         lQyKnQjb05o2IoHdxtlNrYt9AjkrTzWW0L5CTumSawNYEfa8kTHB2p8GCj85OB86IO4S
         w5ZBrNArmDcHXSQnbNhDKK+shRerGEToYBjbfKTplCzpD8OTMBduNzRA9Ea7Ys+PdzkR
         0vGQZQDAMVfDwXp+mZrK2Dsxg9bZ8AWBz6g0fE65aaEHf2uQZpu7wXwslZWIv7b/rDIc
         lv4w==
X-Gm-Message-State: AJcUukcTgZx7J+rU6NNxGBR4q3s2K6ED8i2oH2kEyK895nmusFxpveP8
        ZkaDmf1UZ24S0t+yqA1AF1Q=
X-Google-Smtp-Source: ALg8bN5LGCTi2ESbjX3TpzmWa+XuMaQ4VHsQX4KuoWVRWJEA47bxaCaE9lnU7jPfPmIqVwyY3kPZqw==
X-Received: by 2002:a63:7044:: with SMTP id a4mr9305523pgn.359.1547654944861;
        Wed, 16 Jan 2019 08:09:04 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f62sm7104166pgc.67.2019.01.16.08.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 08:09:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clockchips: convert the code format to BIT()
Date:   Wed, 16 Jan 2019 11:09:00 -0500
Message-Id: <20190116160900.20771-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BIT() to do some clean-up.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/clockchips.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 8ae9a95ebf5b..39a2294e995b 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -43,9 +43,9 @@ enum clock_event_state {
 /*
  * Clock event features
  */
-# define CLOCK_EVT_FEAT_PERIODIC	0x000001
-# define CLOCK_EVT_FEAT_ONESHOT		0x000002
-# define CLOCK_EVT_FEAT_KTIME		0x000004
+# define CLOCK_EVT_FEAT_PERIODIC	BIT(0)
+# define CLOCK_EVT_FEAT_ONESHOT		BIT(1)
+# define CLOCK_EVT_FEAT_KTIME		BIT(2)
 
 /*
  * x86(64) specific (mis)features:
@@ -53,19 +53,19 @@ enum clock_event_state {
  * - Clockevent source stops in C3 State and needs broadcast support.
  * - Local APIC timer is used as a dummy device.
  */
-# define CLOCK_EVT_FEAT_C3STOP		0x000008
-# define CLOCK_EVT_FEAT_DUMMY		0x000010
+# define CLOCK_EVT_FEAT_C3STOP		BIT(3)
+# define CLOCK_EVT_FEAT_DUMMY		BIT(4)
 
 /*
  * Core shall set the interrupt affinity dynamically in broadcast mode
  */
-# define CLOCK_EVT_FEAT_DYNIRQ		0x000020
-# define CLOCK_EVT_FEAT_PERCPU		0x000040
+# define CLOCK_EVT_FEAT_DYNIRQ		BIT(5)
+# define CLOCK_EVT_FEAT_PERCPU		BIT(6)
 
 /*
  * Clockevent device is based on a hrtimer for broadcast
  */
-# define CLOCK_EVT_FEAT_HRTIMER		0x000080
+# define CLOCK_EVT_FEAT_HRTIMER		BIT(7)
 
 /**
  * struct clock_event_device - clock event device descriptor
-- 
2.17.0

