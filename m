Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC916C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF2220868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cC0flz6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfAPTlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:41:00 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39488 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731174AbfAPTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:41:00 -0500
Received: by mail-yw1-f66.google.com with SMTP id k188so2880724ywa.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wGPVLMKNQ0r/KWhK3vlcayEkiauUERQ12dg7Nc+G2lg=;
        b=cC0flz6FTlp/pBvzI3oE4+NeNwx2GNNZUi+PkSTzHOItH8d3V9o6xyyc+CBr2hDdCF
         g2tYc3S+FFUZPiPCTRrb9kRzMvgX8DmW2XsmZpUpeutQl4MB0DJ1ZCCGLVeJk7gF1mxs
         WQlMQiZUJOa92Xd4XsykIncvEcsFNijy679iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wGPVLMKNQ0r/KWhK3vlcayEkiauUERQ12dg7Nc+G2lg=;
        b=RcHDi22kb8CbZhGoi7v6P6NhL9nczItiQ6zG16hGr9iycJgzUZveOA9ec+qw5s7XCm
         9HPbiJ56Hz836VFhucTNkNEJXYhn4LNKGOsGBo66K1Ls3q5Crz1WYmrhR2hlz6K1PjA5
         5j6GpoGzZkW3HVEJ/qdQlGNxl/Qr9JXNGZzPUsI4wkMC4nS73JeP3qmucRd9KEAf6Igz
         C1iUEhgB+6WggowZWQa1TIa5vHrwBBBGY4ruHR9fiOAg7DqFLikzQf0AY9HH01k8A2K8
         /kGzmqo4rWRJPIoX7hrbhvz9yFoymueQCMHNsnnVdZTIsi7h+xtJMWYkEaqVkbciZud4
         qmZQ==
X-Gm-Message-State: AJcUukfvfCw5ewHDsPLqIHUxf7arAQjoREgnQHER0hYe+UHyycYfeBmO
        pE/UX0VV2ur70CVAzgQB0deHnA==
X-Google-Smtp-Source: ALg8bN7Uj33aouqzodIXryOVkcB/bO6rzTyeQsczGhNyrRHxT4a/FL/yN7uQC9CPojLEk9cjbzJiew==
X-Received: by 2002:a0d:ce82:: with SMTP id q124mr9041982ywd.482.1547667659058;
        Wed, 16 Jan 2019 11:40:59 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j12sm3030068ywk.43.2019.01.16.11.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 11:40:58 -0800 (PST)
From:   Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Subject: [PATCH] drivers: pwm: pwm-bcm-kona: update macros to remove braces around numbers
Date:   Thu, 17 Jan 2019 01:11:22 +0530
Message-Id: <1547667682-5095-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update macros to remove braces around numbers

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 drivers/pwm/pwm-bcm-kona.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95ae..81da91d 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -45,25 +45,25 @@
  *    high or low depending on its state at that exact instant.
  */
 
-#define PWM_CONTROL_OFFSET			(0x00000000)
+#define PWM_CONTROL_OFFSET			0x00000000
 #define PWM_CONTROL_SMOOTH_SHIFT(chan)		(24 + (chan))
 #define PWM_CONTROL_TYPE_SHIFT(chan)		(16 + (chan))
 #define PWM_CONTROL_POLARITY_SHIFT(chan)	(8 + (chan))
 #define PWM_CONTROL_TRIGGER_SHIFT(chan)		(chan)
 
-#define PRESCALE_OFFSET				(0x00000004)
+#define PRESCALE_OFFSET				0x00000004
 #define PRESCALE_SHIFT(chan)			((chan) << 2)
 #define PRESCALE_MASK(chan)			(0x7 << PRESCALE_SHIFT(chan))
-#define PRESCALE_MIN				(0x00000000)
-#define PRESCALE_MAX				(0x00000007)
+#define PRESCALE_MIN				0x00000000
+#define PRESCALE_MAX				0x00000007
 
 #define PERIOD_COUNT_OFFSET(chan)		(0x00000008 + ((chan) << 3))
-#define PERIOD_COUNT_MIN			(0x00000002)
-#define PERIOD_COUNT_MAX			(0x00ffffff)
+#define PERIOD_COUNT_MIN			0x00000002
+#define PERIOD_COUNT_MAX			0x00ffffff
 
 #define DUTY_CYCLE_HIGH_OFFSET(chan)		(0x0000000c + ((chan) << 3))
-#define DUTY_CYCLE_HIGH_MIN			(0x00000000)
-#define DUTY_CYCLE_HIGH_MAX			(0x00ffffff)
+#define DUTY_CYCLE_HIGH_MIN			0x00000000
+#define DUTY_CYCLE_HIGH_MAX			0x00ffffff
 
 struct kona_pwmc {
 	struct pwm_chip chip;
-- 
1.9.1

