Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F130C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F92B20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hLTgQoY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F92B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeK3BsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:48:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54047 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387859AbeK3BsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:48:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so2515339wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9n/ARJW/vSmYLj9SN9ylrpC2sSqXn0Twlo1KGmkMWjs=;
        b=hLTgQoY83RBkMaaP/tR14xrQ/lPHNfDhWvsXJ30I2GLHvV7saAx3mwi42WCQ/A84u/
         Eb74CKqZ2TYZQ/GMBt6rXV7CRi5vhNTWf8TOxyb7zNRGZU7Mlr84ms2HAnYEkMTyJTWC
         8/s67zA33tDhVkIqtQnVxrCDaiUZx+RQprgBE8aPUciTbe9GqZcko3cwp7J2BA+fLRv5
         bmQhk8r8+aAFNnxvuSUAJRVrUC2MJthgfzqUobnyG6perggGaV/9DblHCFblnTiQotcX
         QzzKWjlCP41ABCkR5zU3Uz71I72HzZJ+ct05xY7W55W/rlXOdEivyY8NWI/zjiWJGtJb
         3odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9n/ARJW/vSmYLj9SN9ylrpC2sSqXn0Twlo1KGmkMWjs=;
        b=dED2b59lJbm0tft83bLbfelhp4Grq9jBVuKYeWXliAKX8aP2C9cm1qRC7xJx5AKDmV
         KpHT8FQJXMcE5GaOAh3Q1+oqQk4B/PjUoI6mqiVE+iKNFeRj6f4bKxyctw6bmGPlEYfw
         Lcitj5eP4agouvGIp5TNGO7ucTmBvuKUlHLYHJ9mfyAIe+Arc0jiDn9XGF/wvAlEz4BE
         kaJJcsGMVGzjJyV6bmp6IJApQdz05dnfPuWizQzDGPXyPla3YYaHsK/nWYv15gS+Vi9s
         LOlaCtAYa/5NQpzMQD0juUDEGaDYkxMLnFzaLGhI8Z6PMYKwigDRqQNwoVG+2wf36MAc
         DN8Q==
X-Gm-Message-State: AA+aEWbh935Ejt0yNamZvHlIRxobfGeqhd4F6moW2d8dScV6BzBTldOc
        fkzlc3metZUOFLg29QOAI7yR3A==
X-Google-Smtp-Source: AFSGD/U3okb+iei+DGsPUSGRGazLgPdyEJ3srOlg+o/iokaBATlaJ51mX3Byg18L22aHgjt6mVngnw==
X-Received: by 2002:a1c:8bd0:: with SMTP id n199mr2095358wmd.104.1543502556074;
        Thu, 29 Nov 2018 06:42:36 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t131sm875406wmt.1.2018.11.29.06.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 06:42:35 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 02/11] crypto: CRYPTO_STATS should depend on CRYPTO_USER
Date:   Thu, 29 Nov 2018 14:42:17 +0000
Message-Id: <1543502546-23870-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
References: <1543502546-23870-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRYPTO_STATS is using CRYPTO_USER stuff, so it should depends on it.
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index b6376d5d973e..5994d0fa7a78 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1865,6 +1865,7 @@ config CRYPTO_USER_API_AEAD
 
 config CRYPTO_STATS
 	bool "Crypto usage statistics for User-space"
+	depends on CRYPTO_USER
 	help
 	  This option enables the gathering of crypto stats.
 	  This will collect:
-- 
2.18.1

