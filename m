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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0700CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02D720861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdt7McNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02D720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409112AbeKWUTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:19:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38577 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390325AbeKWUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:19:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id k198so11383356wmd.3;
        Fri, 23 Nov 2018 01:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9k4wUuJbe8YveAA7ziaHQKP2wZlEsaVdhJrWGGM/Gxo=;
        b=sdt7McNicnGe9bgIftfxEMlPl/fR+jr1IRsPx7prdK3PFz3tAUd7RKX6PTgGGtnZvQ
         68bGtvwjSXssMm/WtuzAZ5vXuJUQ7RCkzA2BWkQTM4MCDYTmaZNWa9ak+PEKSKIA5dKN
         9cVw8jx8GcXqikxaXYNPjrePEgRME6VjgnedmtaxecRaVF9S9iEGDeIqaAJnQEneQ2Lw
         r5occVJ+A6DCF5bb+KWDK+RrPtpqwhNPv5m3wiRK+MWYZX0FMyTrqMYpNqLcoMYlRNF1
         +enDdmL9YGa0j85WMu5TlYdonl9x5G54dsEV46MDIWXt4E0tSvPSm8/NxISVDPYPWQeJ
         giMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9k4wUuJbe8YveAA7ziaHQKP2wZlEsaVdhJrWGGM/Gxo=;
        b=Iltw37kcB/MJKrhatzTCf+rPl9DYcpHLL8q8izPHtBRu5km+qyYcS2GF0iaYYypZrU
         14PCYpuNP3ZnkgwzcHfrlhu5p/vf6oDsYFeB23Gk5VYEtEsL+8aU9fzM1lF1LlsCUYyl
         KsIcVnO3vs/mX1MQkxAquYp9nzn/QgHnLNXybnNJq0DrT+N6mYQCkG7k71vqnJsFXa8p
         u5ay0Fdo7+HSVj8JYhMl4QJ0bOPLmlD9/M3tJGxkCL3Hn6AQFrN6P3OZdKDsTx+4EoaD
         PiKJYlZZheJkRELvNybh2BXIt/qQg8dhUtBuPad8u2iTNugt75iGq2bdYyJddWiU7ZIQ
         Wmmg==
X-Gm-Message-State: AA+aEWa8apsBYCTO5Fm+NuvoabzwbeE6a+kzdzZ1SDPHhOOxVZW8qscf
        satLKXY9a7CocepOz1RZNQ4=
X-Google-Smtp-Source: AJdET5eUhjJq85S3tyfsKO5OPThZWicuA1aO56cATxTZrgeXHcBbgFCmYS54e88D5q4+lLw0VPmO8Q==
X-Received: by 2002:a1c:63c2:: with SMTP id x185-v6mr11956619wmb.27.1542965772593;
        Fri, 23 Nov 2018 01:36:12 -0800 (PST)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id k5-v6sm79850115wre.82.2018.11.23.01.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:36:11 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3] pwm: kconfig: enable kona pwm to be built for cygnus arch
Date:   Fri, 23 Nov 2018 10:35:59 +0100
Message-Id: <20181123093559.10397-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cygnus architecture use a Kona PWM. This is already present
in the device tree but can't be built actually. Hence, allow the
Kona PWM to be built for Cygnus arch.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 27e5dd47a01f..a8f47df0655a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -88,7 +88,9 @@ config PWM_BCM_IPROC
 
 config PWM_BCM_KONA
 	tristate "Kona PWM support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+	default ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
 	help
 	  Generic PWM framework driver for Broadcom Kona PWM block.
 
-- 
2.19.1

