Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8765C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC042086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgSywFNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC042086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeK0AMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:12:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37270 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeK0AMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:12:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so13881241plr.4;
        Mon, 26 Nov 2018 05:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8KpHVJbQyOSevwfk6LspbRHUtRfMWJFJpr8Gd/Ge/rU=;
        b=cgSywFNQlPLYiUi/4TLpX6hK5XL+Zzvw9u3/VMgL3YH710LWm0/njwWfn1Gch9QAGT
         hUtDKQSJ69m7bpzWQQv7iuaVQfQOkrnieswmOVmvMhZXHdWXuGslhsPu/yN3mW5ZnRVU
         Jmd+Q97jISq46DJwJwtaL9yDiP9T+36fD6Oyy4UjV3+vRe9J4h3k5h05JaOAV8WHzPdh
         5yVp3Ou0gzAIqNygBGncWIMbYGfYWj4jML0A+B2my9SRHKgITsO2LQBEDcxBPSSBAUQM
         KOKfhyr1mCxbIPSVAtzvHvRJkBv2ml+miVZb5xt/DNj9WxvMZNnmHpqvDf1m87GbUC0n
         F44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8KpHVJbQyOSevwfk6LspbRHUtRfMWJFJpr8Gd/Ge/rU=;
        b=UpIeqM9IeckPJnGOXhE5DwnHRGi2K64UMo5DKzt0gglX0nWFteqF5/GgOYaFX8RP2r
         ZZyoxyWbBWxyv7IEQ+plswJhFjHeWalYYytrrsIyGGo901W1VMAZrRCC/gVVrRK+/XwI
         987ZldAYg+RDkoDIDwY8XNBBLL+m8WCVWblvNLmRSwLbL+bGPlrQP7O9jnU0egCBvUtn
         xj/Gv+A5AEz8F6XZYC5d967zlahaobHmnO0BF1JaDSmrVsfLYwSvDPrA2rkrFeR78uvd
         wQ8L1CYEhACdfCPd7W6voUPbVDAPK5IBpr+Ui9m/QYvsd/UWrY0s71eaoOMvFgg5OkVc
         P5vQ==
X-Gm-Message-State: AA+aEWYtnK0gEi5onKw9LO9+IsLzPYr+mmNiMG3Qbmug6mlhc3uCbUeM
        VWnLiWydMrIkvhqirIUBHBw=
X-Google-Smtp-Source: AFSGD/XFomKx8SMATwJCHqzZJLAggtVB8nhNpoM3RoK6RiJ0VLededR6E74GCpFYBm93Sq8IfDXD1Q==
X-Received: by 2002:a17:902:968d:: with SMTP id n13mr28033325plp.109.1543238323129;
        Mon, 26 Nov 2018 05:18:43 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i1sm420602pgb.46.2018.11.26.05.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 05:18:42 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] OPP: remove some duplicated includes
Date:   Mon, 26 Nov 2018 08:18:38 -0500
Message-Id: <20181126131838.30891-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some header files are included twice.It's unnecessary,
so just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/opp/core.c          | 2 --
 drivers/opp/cpu.c           | 1 -
 drivers/opp/debugfs.c       | 2 --
 drivers/opp/of.c            | 1 -
 drivers/opp/opp.h           | 1 -
 drivers/opp/ti-opp-supply.c | 1 -
 6 files changed, 8 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e4fc14..31fc2cbb9d1f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -15,9 +15,7 @@
 
 #include <linux/clk.h>
 #include <linux/errno.h>
-#include <linux/err.h>
 #include <linux/slab.h>
-#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index ab6d07e78945..778ac771ce93 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -15,7 +15,6 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/slab.h>
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index e6828e5f81b0..05670aeebecd 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -11,8 +11,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/limits.h>
 #include <linux/slab.h>
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 5a4b47958073..ea510e350682 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -15,7 +15,6 @@
 
 #include <linux/cpu.h>
 #include <linux/errno.h>
-#include <linux/device.h>
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 9c6544b4f4f9..558c5e638d97 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -20,7 +20,6 @@
 #include <linux/list.h>
 #include <linux/limits.h>
 #include <linux/pm_opp.h>
-#include <linux/notifier.h>
 
 struct clk;
 struct regulator;
diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
index 3f4fb4dbbe33..b1d7442960e3 100644
--- a/drivers/opp/ti-opp-supply.c
+++ b/drivers/opp/ti-opp-supply.c
@@ -13,7 +13,6 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-- 
2.17.0

