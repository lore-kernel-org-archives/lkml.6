Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D155C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C61920645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMhXLJEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfAOQsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:48:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39642 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387743AbfAOQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:45:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1541812pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v+1zm1MHqauBe7cDg0DzjpVqwSHDVQn/jH/aHhX9j9Q=;
        b=lMhXLJEahQX+HAr2JO1udRx3lCQet4a1Y4sBAq8vUJkX/w7ZOXuk7f3n4BAyK8pMA7
         4s/NYWmr206trEiGnEY3xRuaKYr6appQXgmN9gGSKDiTxK1pUK9eN4o7tgzDtuLQ6HLZ
         JjZu6BZxtbIzWrbgzbD1+wQZpxdNFdDz2dxbFZ3qQShSRyGywnAgPcToYrcRzvKWoRs/
         80KrLOrLffxXjsmMIm7IxenDxkYUGKd2OXo6htwrt9KRU/+5V34b2woNEu/3/tUdGag4
         +xnbv6X9IuY5D1Ka8UwMHC22O/x9qKae4tr+q04JXEipHbfN8KIB82KrzbiNgh2t2xJ9
         GmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v+1zm1MHqauBe7cDg0DzjpVqwSHDVQn/jH/aHhX9j9Q=;
        b=oMs3svlfwUtsTOBR6Dl0DilE4OcC3v6Hl0d3XL0zrKHbv4nDvKeV1nG2uEchWMnxDN
         eBGaqOFJq3IbZu9bhs3VN61buAURxYSb0g9lBNDBJnDWDZqXhJKeSxQLVgnDqwm7y4f4
         SvlwY3agnX+j4LxwLqMuTf1sFE7DqPgw1KATIVk8iml2fgS1d4CYpYkWl/csL1rHl72s
         h66qfyQP29sRmbfYuNfpH1RqTTiI3csjZV60H8OukJfEiab97EuKT373sGORX6HPe/IK
         ZgNzxPtN9k+8h9FmSDQKt3zDOTzJ3EPeCn6CRFndOYzrOEEEw7fMQKYV7WwbSP3Hs2Tu
         PwxQ==
X-Gm-Message-State: AJcUukdPGi5kexdjEDsTiTKgbiyWFNii5NxaYQWHkSTNvJe21OFlqoLv
        BGoDCVE0ITx7cp63dpIkjr4=
X-Google-Smtp-Source: ALg8bN5+GwIQGWanyyvr0dqhj9U7q5H1jd2/3phuamLLUBEJHx/dwGqcIetI2Xr2PCnyUbhyBeXvKw==
X-Received: by 2002:a17:902:7d82:: with SMTP id a2mr5022378plm.163.1547570714005;
        Tue, 15 Jan 2019 08:45:14 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y1sm4656950pfe.9.2019.01.15.08.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 08:45:13 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] clocksource: use BIT() for clock source flags
Date:   Tue, 15 Jan 2019 11:45:10 -0500
Message-Id: <20190115164510.19643-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a small tidy-up.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
v2:
-add missing changelog
---
 include/linux/clocksource.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index b21db536fd52..130f4c3c0781 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -112,14 +112,14 @@ struct clocksource {
 /*
  * Clock source flags bits::
  */
-#define CLOCK_SOURCE_IS_CONTINUOUS		0x01
-#define CLOCK_SOURCE_MUST_VERIFY		0x02
-
-#define CLOCK_SOURCE_WATCHDOG			0x10
-#define CLOCK_SOURCE_VALID_FOR_HRES		0x20
-#define CLOCK_SOURCE_UNSTABLE			0x40
-#define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
-#define CLOCK_SOURCE_RESELECT			0x100
+#define CLOCK_SOURCE_IS_CONTINUOUS		BIT(0)
+#define CLOCK_SOURCE_MUST_VERIFY		BIT(1)
+
+#define CLOCK_SOURCE_WATCHDOG			BIT(4)
+#define CLOCK_SOURCE_VALID_FOR_HRES		BIT(5)
+#define CLOCK_SOURCE_UNSTABLE			BIT(6)
+#define CLOCK_SOURCE_SUSPEND_NONSTOP		BIT(7)
+#define CLOCK_SOURCE_RESELECT			BIT(8)
 
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
-- 
2.17.0

