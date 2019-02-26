Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06D6217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tzgS+uF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfBZMIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:08:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55737 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfBZMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id q187so2140964wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FgZZ1EvXiQW14YwhWJkkZvTKvqMw94PKF0P4G+L3sE=;
        b=tzgS+uF9F9GSsACIgXXYU2lRUlanElCpH5tzyt9UCVDqcpYHelyOhBsWKfgV3W51TR
         lGkJj8jXQvLV4thwQVkP2pjdiXM37aOOIbY3cq+KL99Bbl1sAozH/3RUzeAhpv0kmShk
         ArGVNM97OcKuqoI/YOC/Sf4v78fPBkN+YeTyUg74salDIN2vXte8Toqx8ff1s+xUH/lD
         SzI3H30QfS0s90mMoON8tfbPFrWKE1SVLUEF+zPqSZfBe2fm4EwzW/eZ/XHZcmoEOkyH
         lSMp6HBlmhatZ/Lcbk3L5sxzP1UJpJKBi+SoISwfT+asVFTnPA2EnszGW1g8AnXSza74
         Qmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FgZZ1EvXiQW14YwhWJkkZvTKvqMw94PKF0P4G+L3sE=;
        b=IgLLI3VrD1nsH42MVGhxEEf8uN4jC5vUgdwHHH7sJ14QF56t/Rx6oCwMRQ4CpMYbDm
         KmumUu18TJYUCEjVxc8bdPcB78EovOJyFo4xqRyyLNQJmBcFzTfTCNZCHWkfv2QTl2c3
         ToF+SKnD0IL2CoNQay8TSuZg/7B25bj4AsKMrADFXToCfgQNh+whfs6Eb18U2X91xsnK
         T8bcjZOtoiTcrKOcrSr3vX/HLY80Wom1WxxAOxBKCeTZKoGJTxAvqMKnKe2UOBn9ftAd
         Ey8h5uDiPUZch+oJoJBRqLBEVT3WLx9TtzFae8wog6nfFIVBm/a4mOjTF9loWenuzE6g
         SZxw==
X-Gm-Message-State: AHQUAuaVajBEFq6pF/KCpI+r49XF9eZRvbOz4oaVYCjlWFI6iJl2RhfT
        QaTDkNvPrBGgwR8lFp9Jcekd3A==
X-Google-Smtp-Source: AHgI3IZmEmWsQKkR1jNbodwtQrYqFRnzcqSd/SNj1IlIflOSuOgG64Ml7NHqeFRmExoUFJkPA5GU4w==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr2589872wmc.102.1551182857584;
        Tue, 26 Feb 2019 04:07:37 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:36 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 06/11] ARM: davinci: move timer definitions to davinci.h
Date:   Tue, 26 Feb 2019 13:06:28 +0100
Message-Id: <20190226120633.18200-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Boards from the dm* family rely on register offset definitions from
arch/arm/mach-davinci/include/mach/time.h. We'll be removing this file
soon, so move the required defines to davinci.h where the rest of such
constants live.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/davinci.h           | 3 +++
 arch/arm/mach-davinci/include/mach/time.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 56c1835c42e5..208d7a4d3597 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -60,6 +60,9 @@ void davinci_map_sysmod(void);
 #define DAVINCI_GPIO_BASE 0x01C67000
 int davinci_gpio_register(struct resource *res, int size, void *pdata);
 
+#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
+#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/include/mach/time.h b/arch/arm/mach-davinci/include/mach/time.h
index 1c971d8d8ba8..ba913736990f 100644
--- a/arch/arm/mach-davinci/include/mach/time.h
+++ b/arch/arm/mach-davinci/include/mach/time.h
@@ -11,9 +11,7 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_TIME_H
 #define __ARCH_ARM_MACH_DAVINCI_TIME_H
 
-#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
 #define DAVINCI_TIMER1_BASE		(IO_PHYS + 0x21800)
-#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
 
 enum {
 	T0_BOT,
-- 
2.20.1

