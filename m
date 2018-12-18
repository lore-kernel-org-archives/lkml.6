Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8147C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69848218C3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ajm80HsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeLRV3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40307 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeLRV3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so17413752wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EQh4Wy4xg4tu3G5mjMUe7R/MpSc7Nf6V6BJXMW/ceAY=;
        b=ajm80HsTJBcYde6kD2E/K93Z5DSEXUyveMyk6h4WVckfa1oMMpgpNUb7krISJ55Ymd
         6q9LKIcsSxFrsHJHOiJvfnlDsvvm+JUdbbhsOXYRARddHpD1S+r2ri26df8ASWn2eykQ
         sAJJl8zuVYaiAfjhwmULDtBsp1lD5uE57AeeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EQh4Wy4xg4tu3G5mjMUe7R/MpSc7Nf6V6BJXMW/ceAY=;
        b=buVfF/63CFUaVWh6kVafqGntMVqxxpuVSYr+kdzqkw2fCfYoddjtT0dBP6o4O2IA2p
         OZYzCUOWoAQBs1VFItOWBhSQhHq2+iPrKAd+D+z1zt1ds/JcJumbi/OMv7qhlAfYpNYD
         q/Iqo2x6qYI0Yb9bxbqsyPAQAMaMJwh+Wcs8eY9iT1KaLBm95wU3OoC1oT5IeYgiKrFi
         EhELcXzhKVNbVqgFSMnIVg+kPLJORmk2M1ZxrxA9ifaW5nuaqAkjfaEqnilRgCLEpexc
         6ciVBrqwnjPmFlYEMXjdPICMLdcl/Wd/WnH6fCtlh+x6OardFMjxPY7D5EXyDJUmZOb2
         FyKw==
X-Gm-Message-State: AA+aEWb3joxtw6VqLWpy14CW0uCGI6dBvy7olyauCg/RboprJkc5LmFb
        PbfkZX+YysMG/ITQSoUofbv/7Q==
X-Google-Smtp-Source: AFSGD/VyqwbC2xqjFW3tthDUqtEugf6f53B083zDSHZ4ZyjS/4jBP6oWxJ3k7g91vU96RxB1UARsGg==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr15990488wrc.62.1545168580238;
        Tue, 18 Dec 2018 13:29:40 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:39 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH 20/25] clocksource/drivers/riscv: Change name riscv_timer to timer-riscv
Date:   Tue, 18 Dec 2018 22:28:38 +0100
Message-Id: <20181218212844.30445-20-daniel.lezcano@linaro.org>
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

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                         | 2 +-
 drivers/clocksource/{riscv_timer.c => timer-riscv.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{riscv_timer.c => timer-riscv.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index dd9138104568..ddf697b29df9 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -78,6 +78,6 @@ obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
-obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
+obj-$(CONFIG_RISCV_TIMER)		+= timer-riscv.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/timer-riscv.c
similarity index 100%
rename from drivers/clocksource/riscv_timer.c
rename to drivers/clocksource/timer-riscv.c
-- 
2.17.1

