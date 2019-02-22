Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F51C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323D220700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCgQVojB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfBVTgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:36:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37938 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVTgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:36:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so1551321pfn.5;
        Fri, 22 Feb 2019 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
        b=RCgQVojBuznwodAFTzYzXjJ6qFR8aRc77IK/patxS1lIaPbWbKwujh98X3YuJR6aOW
         oe/wctpSvSvG9rz4/fe0oOUeHIHG5C602p6Bcd7TjxN15wpuBhZv1+7uLdz7Kv/1JNUT
         qxgqEXRyXrq4kd5wha2xQlmApUO1EXcO4/urzgfJDde2ec6ELBKsoyc1HfRIjkiI09x1
         H8rPl2R0oRcHMgunD03StB/fpr4Mdizg/K1y3Iu2iyiFn5LCxS9yIdi4b7DnDM2PNsTd
         GgKVZfaxj6X1mBy1HAldVqwcFlq+6JHE8+suUvg+5nXP6T8NVhAVa7FdY/9IPzi3/ASI
         A3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
        b=tAAx42W4IVOUgAPuckoVgkGXK/Pd2K9qLbB7OsvWbopxh/AlePb1KFCqeW1vp902tY
         7b+0b54z6gGnI4NX3bo6UkRdNYuIZDP6JRrpNfGyutrjr2epXeA/zCgsL4g+f8T1fSe7
         0j9YjYsMlRdRSjMDw7M4cJCDNC4isIWotLwzsHbvTvM7Mwi3C/MNr+muJXIZA1Jkx2Bl
         eyW+rSz+EAJFqCn5MdOj8zn3tbNsBBdMaY++bzI33Sj2BZQ2n0Dr3kzkCn78D8zok2Jw
         CJE5lwmRIhH831/oZafkbvR3QdoN/NxuL5RyzoF0Y0MxqeKUujE6CwZfwyNzCt3N91zP
         SlbA==
X-Gm-Message-State: AHQUAuYOmBDeEwMiM9E06kxqgi3r5pCj6gU6RHdnR3tKjWZVAegziMdE
        g6RNOSp+w98Yk3bYzcx6qDQ=
X-Google-Smtp-Source: AHgI3IYlzxVgrVdAeFuaC0G+BDObQc44fiSh9qEU91y8vM+CC3ffieRHL/jGFkkByd4Xq4an0AS4sQ==
X-Received: by 2002:a63:61d8:: with SMTP id v207mr5477157pgb.308.1550864168027;
        Fri, 22 Feb 2019 11:36:08 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:36:07 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/7] ARM: tegra: Always boot CPU in ARM-mode
Date:   Fri, 22 Feb 2019 22:34:25 +0300
Message-Id: <20190222193426.10747-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 6bea95d165fa..3bf202819534 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1

