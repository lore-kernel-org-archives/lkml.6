Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E244FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JwNKcWWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF9420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbeGRLdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:33:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37006 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbeGRLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:33:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so1838982pgq.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6B35vbi/oJ9FVsDr3HKcLGKgT6nfQVkH08O5ypyqPo=;
        b=JwNKcWWvyT09u+kkzb+QQBc7sKsnQM5KYC3n17J6XcR24OE9JashcUrGX1H6XKZJNx
         6tqIl/PPCzXSlWCYNkpBPbRd6XxM4DuaBg1ll0Dv4lCUD9CWvwYcySg26zHtZh/R0+/y
         hOjkVUFpeRskI6zG29KErqkTeXYW+RGER/RWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6B35vbi/oJ9FVsDr3HKcLGKgT6nfQVkH08O5ypyqPo=;
        b=mLwwd4DzTLu9l/nURr71ZE72vhLLUUn7ZgARywH7+OvWMiIn7M8D8i1ItOqw+jwjkS
         gpWGyp8JHaPV1qCkS9zFsiU5Bydtm65Ab1yVTzXswvW91zu0CccxpEnFhcb99CJpr2Vs
         GoYi2DeqgGTB+Zb1afxIuEw7iqAf1XlUO5XNJ5MrXDmo5L7Am9kWisLP6ToL8e6GdtPc
         zLB8jM+wApqLquhHPJUdGa0MQKTVDwxDY9SYR/VNtRLos6eaQ0NnVbMvrOu9DaCw3TMQ
         cw89ICNsX/cOxsXdKMW5aCOhfFXmkFIKLDAOiCz0rlFgcCPbclzK4OMNRsg52oLaDYAZ
         PPAA==
X-Gm-Message-State: AOUpUlHKG9AArWAS8kClrddSqtQ0IH0Gve6hGetyKK4xBxBn76GD7MgU
        3XqgKCyfAgxnHHuXsfA0lmeqlw==
X-Google-Smtp-Source: AAOMgpcqRfOxNky5xDDZ5vm1BrS3CiJM6c6fsMEgj8hm9vNAJHE0Qxb62YPTjMz75QxLqkjlUroaEA==
X-Received: by 2002:a63:6e08:: with SMTP id j8-v6mr5320039pgc.428.1531911371658;
        Wed, 18 Jul 2018 03:56:11 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:56:11 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 10/18] drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
Date:   Wed, 18 Jul 2018 16:24:50 +0530
Message-Id: <20180718105458.22304-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner SoC like SUN8I and SUN50I are now using DE2 Mixer
so enable them as default.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none
Changes for v2:
- Enable for SUN8I

 drivers/gpu/drm/sun4i/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index c2c042287c19..cfa8b96273fb 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -61,7 +61,7 @@ config DRM_SUN8I_DW_HDMI
 
 config DRM_SUN8I_MIXER
 	tristate "Support for Allwinner Display Engine 2.0 Mixer"
-	default MACH_SUN8I
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 	help
 	  Choose this option if you have an Allwinner SoC with the
 	  Allwinner Display Engine 2.0, which has a mixer to do some
-- 
2.17.1

