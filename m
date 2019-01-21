Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A254EC282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704242084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umlu8iMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfAUHmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:42:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37780 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfAUHmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:42:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so16653820ljd.4;
        Sun, 20 Jan 2019 23:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6ha8Pwp+alhE6MhgYjYVmg1Lm66WPTSXK6BD8BPQX9I=;
        b=Umlu8iMWtwCga4kkE21GVA3Sf6CPtdr1HP+36L0paWcV3/7c2n2h/baB/7v8ea6haS
         4FAsmhLCJcQRdeo7pNzKsJ6AIpMpiLimu/vs1c6mjToU+0rOeL3FXIAialB/HH9KTOOu
         ZmC5tPR85Qxa4Anve2wEgvga94U8ZcIBMQp7acb4wAxO1Lk+wsiVOdZV4nq9GxvvRMWg
         3uZWChDyuPvMXx0+doUiPFYO0mAx0uPlEDERJeXRXXAe+8xrsHOxaMH9QpAINzG4oj/X
         7lKX7nV++vgrfP0GCt0i7xWGPdNV4JCExgx6973ODBlMkk0kCgYOEOiwOFkku6PSMr4T
         CDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6ha8Pwp+alhE6MhgYjYVmg1Lm66WPTSXK6BD8BPQX9I=;
        b=IO/C+0w4uCe2gt8UNfEbwUWXNy9qZTNfVpjP9JWPTzc4vbkMazdv1j/7xZ0FsOkRYl
         Ya9Z+T4ZtlhvR8Agxgl/l8oPAg3Hfw2TtrjIFcvmJsXYKxi4jl7lXvdbPBf1K8iz5rL6
         Pb0rSovtR2AjZ4Ew08PksVfF3f0813fvsJ6b8RfBXjTlul1uiQY1Zt8xtfX7RAC5HvXs
         g6FmLNqxI11EQkbqQZcz40SCqWONWiA28RiHN/vvNgvIzjYOvhgARswEWE/Fc2aiFY0I
         G79WmyHMjaVoXKmH+cbPwW3soXhCjk7VF4V3HqdI6QNpJVPUHS2lZxBjgLLRYt8gJHsN
         UDNQ==
X-Gm-Message-State: AJcUukcXklLysxhiGJ2LL9mIDL8Qub9VO4chq66hvkkzyEoP5Bgu8l94
        rXub5mROM7+QQu4/IHxABDXHxBas2fM=
X-Google-Smtp-Source: ALg8bN5LNPaX9jHS2U60Mp+z04pl5UzyBmTN6fw8Cy+TBmNoPckLWfOTbnbiD5yBkmj3gep5nF55yQ==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr18101405ljf.127.1548040927627;
        Sun, 20 Jan 2019 19:22:07 -0800 (PST)
Received: from supervisor.net28 ([37.214.63.169])
        by smtp.gmail.com with ESMTPSA id g15sm2003694lfb.1.2019.01.20.19.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 19:22:06 -0800 (PST)
From:   Arthur Demchenkov <spinal.by@gmail.com>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arthur Demchenkov <spinal.by@gmail.com>
Subject: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
Date:   Mon, 21 Jan 2019 06:21:09 +0300
Message-Id: <20190121032109.10220-1-spinal.by@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong polarity of card detect GPIO pin leads to the system not
booting from external mmc, if the back cover of N900 is closed.
When the cover is open the system boots fine.

This wasn't noticed before, because of a bug, which was fixed
by commit e63201f19 (mmc: omap_hsmmc: Delete platform data GPIO
CD and WP).

Kernels up to 4.19 ignored the card detect GPIO from DT.
---
 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 182a53991c90..826920e6b878 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -814,7 +814,7 @@
 	/* For debugging, it is often good idea to remove this GPIO.
 	   It means you can remove back cover (to reboot by removing
 	   battery) and still use the MMC card. */
-	cd-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>; /* 160 */
+	cd-gpios = <&gpio6 0 GPIO_ACTIVE_LOW>; /* 160 */
 };
 
 /* most boards use vaux3, only some old versions use vmmc2 instead */
-- 
2.11.0

