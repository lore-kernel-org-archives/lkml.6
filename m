Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC3DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A099921906
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OIF/Hknd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbfBAM65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:58:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35995 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbfBAM6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:58:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so6115859wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cl+T+BPNCxXXA5ox3kofUWAwnqL2Ija54XfDMQkeCfA=;
        b=OIF/HkndosfayBf1nS22cv3hPfxo4/iHwLmHRfTfEdad4fKGYaNoLAP05RuKV8sawy
         l8BmIocCsSWIh4YvijyUDEOxdTX8JxDdiQ6WXCWPeyW60l6LHtaWIqIuCSYTluhp5Vdi
         w+iNU7zstBcs0Ydo88DEzRdolGMbqLzky20tQImE0NRIwcvQh02+U7+Dr3FKrbYk8OCn
         ltX/XPEvsChhnATbPITSJy8HrynDjlqzVIzpDCJNAFztyTaOdlNIFThd+t8IZ/9izX3K
         a3M/VQd7O+6DMp7v5E+GorNrKFvFkGKSfg7flACC5VCrHkQVSfIeErwxUHlWCL8xy7sG
         q1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cl+T+BPNCxXXA5ox3kofUWAwnqL2Ija54XfDMQkeCfA=;
        b=f9oBocXxOwrq0XrmScm4mFVm9uaXwUxAFqRvmtIGaC3rdKqhagXusOoRy8g9E6Yctd
         DVQ7tgaPfZZ8q+L5XX/TZzm0W2sZjCwUlhWQJvub/f/u9gXH79H1PcFbTkkh3qCb+QeR
         upM49DpEmaYu0XmHny2Vwj8yMf5FzMU0ZDf9bQk/2QF8sNJMSLU76Qhg7Qi2upp0HSpW
         VyQFzX84rQpyrJ1hbqqKA1F9fIz8mqAzueWftp3y42o6YrX9tdPaheHNCpZFj94yY6/j
         hqk1WjoTWTpk+OUzfgHRr8HeiJAOhtT6fGG/G1FadNITMDETiPp/SithdkxH4Ga1YM1j
         rMuA==
X-Gm-Message-State: AHQUAuYfJkE0bssgPKrNZYDDoTpWrQg0ZIKUXs0SM9G2/IM9RgJO5JiV
        6k4YJeIlHKOSBDJaNBVu7x+z9A==
X-Google-Smtp-Source: AHgI3IYl82796Wmyzg4/NZIdiQZCBvp12XuiMBRUrSPIp0Qb7hiUqCkI/ySIWWP6JZLsY5uLR3GL8A==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr2460560wmz.8.1549025929982;
        Fri, 01 Feb 2019 04:58:49 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w16sm8709750wrp.1.2019.02.01.04.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 04:58:49 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
Date:   Fri,  1 Feb 2019 13:58:39 +0100
Message-Id: <20190201125841.26785-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201125841.26785-1-jbrunet@baylibre.com>
References: <20190201125841.26785-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CONFIG_ARCH_MESON to let make enter the meson clock directory.
As part of a rework, CONFIG_COMMON_CLK_AMLOGIC is about to be removed.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 8a9440a97500..8d780c4390f1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
 obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
-obj-$(CONFIG_COMMON_CLK_AMLOGIC)	+= meson/
+obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-$(CONFIG_MACH_PIC32)		+= microchip/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
-- 
2.20.1

