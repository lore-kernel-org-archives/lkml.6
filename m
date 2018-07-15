Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74584ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1EF208C1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmp44s34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1EF208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeGOMyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:54:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54022 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeGOMyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:54:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so5244642wmh.3;
        Sun, 15 Jul 2018 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ru5V4HR6rXm02miuVH6mLvHF6YLMkvdPB0GnEFMH57k=;
        b=Gmp44s343gjxnPMlQoQUrex51Ik2jvnTTEdYQ88Qs3eJcIL5yJftY8h5VBxrj9ClUG
         m9n+f1A7c0XKCdbuYAQqYOZil+FaOkphF0LgH9gVZGhKUid+b6Qf0S1Aim7wRGF7nCTQ
         WuOGp1m+cfeRRQhg6Or07SJBAU+kOyVHS0iBTxl9zz/701Lk1yvaJjJKXBpRwc1uxQYj
         ZAIkiI7P9J5yR5c/c8FHPXoLJVrUDnd4On05Ls1op2zyOeW4giGFRLg3UeAVxYUTpugJ
         nXnZ5suEl4Mt4K9gh0+uksvUrQ7oLZ5gCMqDgP1QtJm62bsyjQ73/kS5psB5DmMzxR5T
         Y+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ru5V4HR6rXm02miuVH6mLvHF6YLMkvdPB0GnEFMH57k=;
        b=UMJ8BKIoMAccVaI850tK29kXU/bRj/bZUn3FSsHSczby+9XdUAtGxJZCa02hSwcYX8
         XIRHP5uyjKxJ8XTLrQgRAcYAYmCAek2IiHr4z9h81tjyQ3lH+piii3nUR6VFnWht6pj8
         ZTj1NmYXAv6ph4LHclR1Pdm7LWC5ybT30761DfvJAQAc3enJ3WpINyqaekJQHSYODwj2
         00zwzMW2lDJeLxfKy6TjINcAFOkBDyJSzY+Lz688nw5lA5O2QcZhtObWF4SPV65k0/F+
         Ui+3HHXL1XMxQZDz3RXWkcq/J+6MH44EVlyrUDR6kwc06i7hW33eesv6RDpmDLhXOPgF
         Njwg==
X-Gm-Message-State: AOUpUlGkkjn8tMmRab0qJI9rXMccJEDf6jn65B0NKGcyFiThLBPu21RW
        uP7RGymvz7fsAMTlFaqwPqbNaHQzTy8=
X-Google-Smtp-Source: AAOMgpeH0RSfTftExJZB+4lD0RgkyxA0/C3qOgZpj20Aa5b4xFBjPkqgchaOoqx8lpUWQFCk3KOX3g==
X-Received: by 2002:a1c:5582:: with SMTP id j124-v6mr7953209wmb.153.1531657910699;
        Sun, 15 Jul 2018 05:31:50 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id s10-v6sm16358688wmb.12.2018.07.15.05.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 05:31:49 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v4 1/5] clk: actions: Add REGMAP as dependency
Date:   Sun, 15 Jul 2018 14:31:41 +0200
Message-Id: <20180715123145.16975-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715123145.16975-1-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add REGMAP as dependency to avoid undefined reference to regmap symbol

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/clk/actions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index 8854adb37847..39491154abbf 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -1,6 +1,7 @@
 config CLK_ACTIONS
 	bool "Clock driver for Actions Semi SoCs"
 	depends on ARCH_ACTIONS || COMPILE_TEST
+	select REGMAP_MMIO
 	default ARCH_ACTIONS
 
 if CLK_ACTIONS
-- 
2.18.0

