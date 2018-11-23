Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0896205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 19:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ojQASPls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0896205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633167AbeKXGjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 01:39:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45214 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbeKXGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 01:39:07 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so13331850wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 11:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HbOh/pMDb/8M3M5bu0WWSItxe+N1uRR4AZ9SpzTcn4=;
        b=ojQASPlswdjZbwZZixTwGAoD3LkDgLf+QTPYx9rpr4ZCNbyRTA80nT+uDOtY1O1uTt
         OV5CNm6WQl8hcllTmq1DIknFO6ZTNdlZYhIPQpCNE1TlV7+x2aaPIdW4Lsg1REVrzm00
         STEHWbW49c1Zl+tyOfm8tq/v2orxJhQnou23xzI5YsvZVlwHQq+Yjxh7CYAStCGQFP0j
         L4FQCm50G5ctfW9DJWUktdBOhKB2rY5inESlo+wSW/i3da3NPdCCVDD5NPtfixDdItaf
         6eicTL1YY1AZYKpsnQf6x3TZnSBskhneCzESgZ0L2Mrtwwfk638RmGgyPbTcYDshr47b
         9BoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HbOh/pMDb/8M3M5bu0WWSItxe+N1uRR4AZ9SpzTcn4=;
        b=swb5qvLbXpBL5go3nHJcj190stUSnpGq5BaayqwNJWD/9frSLJdQxgOKq0w9s+y8Da
         Am3zOaFNnS3SoTdO3B/v9COBc7TmoaANfD6Op2tLpk8Q+S3PvjMZQIwWtCp2IoDdvNwe
         /bCLA1/i+gXD4KPxvh5bPeFoO0YBzpceEadTaw0QmpXdK+zBR9UdK0q4cc8Z+gea+dei
         k2MNsgSvFbDv6HYm6PKiu0ZjODExRLnNbVNvx03+NFOGa3HJFLp76nAazFIq3HUasewR
         Tw7kTYtkpRLwfye7EnjSRpjbANFyXS2DSzr+eODanZMi+yQvlsP+uY3NShSq+gB9Cufb
         KpDA==
X-Gm-Message-State: AA+aEWY9kNldGdvc+M8a0pXejqpFeBmva2si6hT/10Kb/mthNJUFFueU
        uyNSH5M5QDGgeYo91mR0U5Y=
X-Google-Smtp-Source: AFSGD/XX14zN1TOyJS+/BykItwNfzkg7wmUizhdX78YVn8HbmS/6/lOS9CmeE5PDa4ic/W99vJlaWA==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr14633629wrq.5.1543002805240;
        Fri, 23 Nov 2018 11:53:25 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD732F500597D16A631573221.dip0.t-ipconnect.de. [2003:dc:d732:f500:597d:16a6:3157:3221])
        by smtp.googlemail.com with ESMTPSA id g198sm11495337wmd.23.2018.11.23.11.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 11:53:24 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     carlo@caione.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/6] ARM: meson: select HAVE_ARM_TWD and ARM_GLOBAL_TIMER
Date:   Fri, 23 Nov 2018 20:53:06 +0100
Message-Id: <20181123195311.4578-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
References: <20181123195311.4578-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32-bit Meson SoCs use multiple Cortex-A9 (Meson8 and Meson8m2) or
Cortex-A5 (Meson8b) CPU cores. These come with the "ARM global timer"
and "Timer-Watchdog" (aka TWD, which provides both a per-cpu local timer
and watchdog).

Selecting ARM_GLOBAL_TIMER and HAVE_ARM_TWD allows us to add the timers
to the SoC.dtsi files.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index d51cfda953d4..b16831697183 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -4,12 +4,14 @@ menuconfig ARCH_MESON
 	select GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select ARM_GIC
+	select ARM_GLOBAL_TIMER
 	select CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_MESON
 	select COMMON_CLK
 	select COMMON_CLK_AMLOGIC
 	select HAVE_ARM_SCU if SMP
+	select HAVE_ARM_TWD if SMP
 
 if ARCH_MESON
 
-- 
2.19.2

