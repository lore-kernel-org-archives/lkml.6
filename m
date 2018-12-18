Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBF8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06BD21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JV1PTNuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeLRVaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:30:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40309 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeLRV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so17413790wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ortts1jeLglmGDZSNPMXJ+Gydp1wITIqzfWnCQEmT+Q=;
        b=JV1PTNuhQn8bknei1s2ltKXasMxKi6ufAL4JVJYPX+64flu07h8vawcF27TEslv/UU
         gdMfuND6oewuaazThElIf6j0Xz63/0RAnj+n4mIwa0GIj/c+Sz71pipzLN5ulMfrURIs
         dZ0ur98ZGYs6qm/hvbo9anSN9ggL1hpluGBYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ortts1jeLglmGDZSNPMXJ+Gydp1wITIqzfWnCQEmT+Q=;
        b=V90h9VmJVwY9jHzVho7vkIMDLYq+DjwSZHRiOjmpm3dkPLdbPIobnFTZU0+oaC6oIw
         9lprdKe92HCIIPYSstvYT/H80LhogAQvweVAgeZzIDtA3WjtfFq6Up16d5vq0I6E8rBK
         EEn1ZuxQyAPCqkJiGm0FJ0+u4F+iwwN550/lr7AutlOc1iNyPiXd+adiimL4zsqrzkpt
         pbzI5o4QQZaYEDHFEnbJl9S9/CLRUBYz0W1lphoyKpJHT9ZpE/wWKKp8p+G4em9NCVWx
         4vCSwobdozJ8qfm8m1i+RVVqsiGQrCGG4sOw72N8a4HogVL3B1DDpIf+/M108FSUD8OS
         fpjg==
X-Gm-Message-State: AA+aEWYTx16+bf4uoPKwc827LBZgTIIVyZmnJzs5TY9bqd6KNtrn4qcw
        2uoUnTZxYWzBxUv2/FColw5GAA==
X-Google-Smtp-Source: AFSGD/UKPNUB2FNdKpOMiFOA6rgMMnAPqzHgQWnoUzpJOtIdcrZngLS2NHSi0kz0riTKN7bDjAqc7w==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr15495056wrw.323.1545168581544;
        Tue, 18 Dec 2018 13:29:41 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] clocksource/drivers/rockchip: Change name rockchip_timer to timer-rockchip
Date:   Tue, 18 Dec 2018 22:28:39 +0100
Message-Id: <20181218212844.30445-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to unify the names in this directory, let's rename the driver to be
prefixed with timer-*

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                               | 2 +-
 drivers/clocksource/{rockchip_timer.c => timer-rockchip.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{rockchip_timer.c => timer-rockchip.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index ddf697b29df9..9d0c0fa0d69b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
-obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
+obj-$(CONFIG_ROCKCHIP_TIMER)      += timer-rockchip.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= timer-armada-370-xp.o
diff --git a/drivers/clocksource/rockchip_timer.c b/drivers/clocksource/timer-rockchip.c
similarity index 100%
rename from drivers/clocksource/rockchip_timer.c
rename to drivers/clocksource/timer-rockchip.c
-- 
2.17.1

