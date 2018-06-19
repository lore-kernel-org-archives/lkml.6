Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D177C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BE220836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFB17Lla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BE220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966060AbeFSLDE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:03:04 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42824 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937685AbeFSLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:02:59 -0400
Received: by mail-lf0-f67.google.com with SMTP id z207-v6so8072944lff.9;
        Tue, 19 Jun 2018 04:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+7g9Lwn3g6LuKjXiq01IIe6bion0z2zfgyBdmexeaq0=;
        b=lFB17LlagojzCXLLVQVEshwArZ0Eoupfy0hplkOBzXxjvpJELlSvllcArfYaE2StoU
         y6/dYRZIID0/di2DKv7sifqCitFMKoCZ07GVxJ9gkIIxhM0F8rxyY9H9Os+ty1AZz5EU
         q/XrJBk62EkZqPKU4Jb2iTOdxB7TJAQwWH2MpMWER0/2BII79jYH85cq7dXj7IOj02ep
         GprahMmSJhGdmNsAr0jIXTC0i7ruglYZj2aFdrsm9EU9SlIt3wfPfLri0hy1i6dul6bv
         kWNPv4xcGpquYEnU5P8qasc1lTZ35wdBOfzM6/Z3YVrSeXaQtDKFD6ykLIZ2oQslAsOx
         KJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+7g9Lwn3g6LuKjXiq01IIe6bion0z2zfgyBdmexeaq0=;
        b=XsibLDamQp5gUhB2AdIR/rCDNim3yOCwhyXW2bW9YDk+Lub12cj7iCCZWJ9KMiCxwt
         cOUCAPQ2AiLlidN5+sM1N90dPPaCC6Wf4Ry8WvC9Jzk2y27TycI5tovKFhIWJFZ9M5sU
         EKdlFTWXVEl0wWQbwiPLh4k78jNcSFFM9cfXC1f8ElYXwo+fCuJW/OP1gYyPb2xjY6Cb
         va7JFBhpLC5/qqdnZmvwbYtd7/PuEGLOQlXM/ZnZk6k45lH4BSuMqKrB70QCXaorjo1y
         Rys1Yd3JB6F8LWrpSPNwxaCkp5377I8WdewlKmCKh6IHqlYfDbL+vjEwlHRf5dEMKpgD
         Mltw==
X-Gm-Message-State: APt69E11ZW9KpHY1YpF2arEos6/h6GAbPAvEh0gpg/xU1Ti/MJ6jLs5A
        e8G0HwFa1rgZT7jXXc2F6oY=
X-Google-Smtp-Source: ADUXVKKbgOLhXETgD96OHfSKqB/Efz4Xlo+/FOQ8knw/jAPXmqlBdyrlbH8+fM+KzHNzFBqVyjOvZA==
X-Received: by 2002:a19:a78a:: with SMTP id q132-v6mr1496069lfe.126.1529406177721;
        Tue, 19 Jun 2018 04:02:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id m84-v6sm3118543lje.91.2018.06.19.04.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:02:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/5] ARM: tegra: Always boot CPU in ARM-mode
Date:   Tue, 19 Jun 2018 14:00:27 +0300
Message-Id: <20180619110027.16935-6-digetx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619110027.16935-1-digetx@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into the reset handler in ARM-mode from the Trusted
Foundations firmware, hence make CPU to always jump into kernel in
ARM-mode regardless of the firmware presence to support Thumb2 kernel + TF
case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 arch/arm/mach-tegra/reset.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index e9f2a7775998..8eda5c786f50 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index b02ae7699842..3f1ef4561298 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -97,7 +97,7 @@ void __init tegra_cpu_reset_handler_init(void)
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
 		*((u32 *)cpu_possible_mask);
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_SECONDARY] =
-		__pa_symbol((void *)secondary_startup);
+		__pa_symbol((void *)secondary_startup_arm);
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.1

