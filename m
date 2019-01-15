Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDDC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9EF2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZA6fV4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbfAOQl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:41:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44867 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732753AbfAOQlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so1527566plt.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lTX4wBB2KWN4DoEePGtr6dBXfwKyttUXtfe8waG4gdE=;
        b=pZA6fV4jQSwAeP1euhKTA6IBcx/S6A9zy7c5UGsxbKZTz+Le1cL5/GpKcL43lRP5it
         Eh72lmqRnEEKBrHsWyw13+2LrbLyLW53JdCQcS1d+dtZEjJq66l6i+wsXu9A13dBcmHK
         EUJziM3Ac/lb1J9wgFh7nCXGfGHKu27T0tfZrS8ZR+a2+iSnD89MPE5H3HyOa2BGMluk
         w6458zzB1RffOA2DJ1BAMMNAob369zCr0ulwZHeFmb/vFZVWhEuWFs2p7amWXJNBHmC5
         hvhl/f18AGhGfr2VG8h57b/Jitl45gfqJMFQanAP1PzW87YdwCJWaQlBzkLtY0JPSPuY
         FLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lTX4wBB2KWN4DoEePGtr6dBXfwKyttUXtfe8waG4gdE=;
        b=SMlHCPlvl9o330S0Mvfi/Dwd8izaeNOraQqmi0NssYU4j+P1bsVpwHohU/KofSxHgq
         aWW9f6b8VY7mLzeNSRALbWlD7KVvYOsvE/lBItFwKf5JpRBjfOuu8IN38BbbHRE4byt1
         JngyuMHDBp0UIwNZOFGDXb/LEycTlMck9fODnmTuzjQixvHPMaYoLhd94vM3I2jKg9Ph
         jbW5TsLPZPxwyMQ99fkxmn2vkZA5IbbuQtZxuxp67avwpJqTEOLI893eZ2+KMdLwJErt
         4loBkdlyQigfA7VD1mg8XW53RqZNYuZFqTkuxF/Hv//m0+RVzPPGhNwDlzwxDiFmCuiS
         OrBg==
X-Gm-Message-State: AJcUukeOkTYVOM72pDh54L613gbqMW6i8Zw78OfyOXb4HMTsOWQG6lga
        HC3lNNk3YUTvFhbj0xmh1MTZ5p565Lg=
X-Google-Smtp-Source: ALg8bN7B7JIkCSLzoaLruM56807rpCywiskzVGQh3St7j3zwOwOJ1XDDk+FVMmSjid+gtPNJjUTZSQ==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr5000863plf.233.1547570477112;
        Tue, 15 Jan 2019 08:41:17 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g3sm7330744pfe.37.2019.01.15.08.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 08:41:16 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clocksource: use BIT() for clock source flags
Date:   Tue, 15 Jan 2019 11:41:13 -0500
Message-Id: <20190115164113.19560-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
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

