Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8DBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF492081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqIbrLIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF492081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbeKGTGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:06:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38005 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKGTGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:06:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id d10-v6so16624720wrs.5;
        Wed, 07 Nov 2018 01:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wNkiWquytzIqLeOP3eKOFmMm6R01FT86AfhqFpG4g48=;
        b=XqIbrLIC31xYGqWwggdzDzuvsgf/cxH2xpBgRY/hGcevJul4KXTmIgK2dffKIk9S+a
         LlwgHq/HUUIYs17qkU9KDswdwHhrlL/CY9JRcyCm335mHHp61QQXrJ2Ruam9sKN7/bsT
         eBrQoW4Bc+E9hAABSVDYfG2oW9qT+kNA2J86g+8MQqZart/HCVKNM1lwKZ5xhozYMYQd
         kqGBE0PMBShhYziaPH6DUvR7O122fyP3P52MKZl4j4mfb6ON8tIqcbDAyK/geIwtBFnp
         iIULA8TkR6Zz8rQis5sFaamqUzE3DIx+Ofi5b4XJRB8yQ96qMhfZ+6yoXYHPF3tzRH2u
         0cKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wNkiWquytzIqLeOP3eKOFmMm6R01FT86AfhqFpG4g48=;
        b=cLAWPCOaB9sTQiM/bR9qV1Qv9jCs2pGaEzvRGAks/HyUSnKmK0FdW9S4GaC3J/4hgO
         Bb1CGThrHnuFOxy/UM23fAYctoqBs9lByB7G7eEsc+yRkak9Pf/sNzXrCFDFrHk+OgTb
         IVf404EXFcjpUKNXPrU3G9fbAvaxcSIMGofxjJ839Wp08st/2f3bDOOsPjJSrdfqsqtH
         3r49dSyuP/yunmKpQzhXIg0pGI5+p1/TXEuuSTmO+8zsbWt0fZdwjkPOreUP7Ri513+e
         2lMNFVgGgsCVaEuE49ojb3o27pIf9ofUKd7y0Obb78was4AZOaRONMPrVHR6NzqdZDM8
         k1jg==
X-Gm-Message-State: AGRZ1gLfPgi3NuLFoSUAy2iHmEj14rGV74ASoEFsMTDqT67ferJWClDs
        MK4/rOsM1enQN7sq5y2yCxc=
X-Google-Smtp-Source: AJdET5fCrg0gy3zqIVvY86zkdl6v4mXt7BFxtBqS37A46Rb6MoJWYZPl08VUesAlZW+iuL1+m1nVCQ==
X-Received: by 2002:adf:91c3:: with SMTP id 61-v6mr1152454wri.97.1541583390871;
        Wed, 07 Nov 2018 01:36:30 -0800 (PST)
Received: from cperon-Latitude-7490.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id c14-v6sm350206wmh.44.2018.11.07.01.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 01:36:30 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 1/2] pwm: kconfig: enable kona pwm to be built for cygnus arch
Date:   Wed,  7 Nov 2018 10:36:12 +0100
Message-Id: <20181107093613.26734-1-peron.clem@gmail.com>
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
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 763ee50ea57d..76d56fc8b1b7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -88,7 +88,8 @@ config PWM_BCM_IPROC
 
 config PWM_BCM_KONA
 	tristate "Kona PWM support"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || ARCH_BCM_CYGNUS
+	default ARCH_BCM_CYGNUS
 	help
 	  Generic PWM framework driver for Broadcom Kona PWM block.
 
-- 
2.19.1

