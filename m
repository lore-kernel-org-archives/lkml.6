Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBFBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB8620831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wgpzjYhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB8620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbeKTGSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:18:52 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33891 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbeKTGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:18:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so5005245wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MGyvvUrLG82fyYZI4kKXDmZmitZhSzKwNdI1JTjnMNI=;
        b=wgpzjYhB9KCvpMdiIQl1LAIGVOa0d88LslNrEvSx6oQ8YRD5gBVfl2PXUOSWQHidbB
         U9B/VaofemuoReM7cY21NFLWGME9Ga5Vp/cW43LBfl76onO7VEGRyVv4INA20YU643vI
         +goVhoQOM9yirVWP9fdC2zb6ApjrRmpV4NoiscfHpqvAXr5+01DIiy62zaGNO+Zw1cZw
         6Hk2T3+fliNHRXbT8GpXIDur++mNlKSZVZHQLewQNhV6eOhdDWdMraqGE4UAfZuWe0IU
         tIk1FqCrYXYtd0JIgoeOn81nkPWYBFWGlhYnKU82gHN+Q8tnL1JCMHZ8p84iFCsUQK5y
         WLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MGyvvUrLG82fyYZI4kKXDmZmitZhSzKwNdI1JTjnMNI=;
        b=IAZDG5D/ubW3aSvSVLUMYGWEPfaw3pbGLhHq8K7aHssXteYX/BAfKt48Ja0xdlsHbs
         dVxoSZr/+0mnVk/MtVrz2bCcdZoWkK5DcXr9Id1b4F7dTpjrHZFX0ptzuI8pj9jx2tOF
         2RzZ/xNxOsdFAmrneQHTMeVWHayfGzV3XQUzBsVeIgMjN99jTGoRWLYs3cMjjt1/fo3t
         Q1JlYyy29pDnEc+Q1KrX94ipGZfNP7lmrDRij/zbsGxuFWqyxF7s2XawG4B9mve7mGps
         v+ibM5QiePBgvLx9ivg8q1C/gNLrd7K9efJjCDFO1OD5UwX//pE0yMrFfEzOZeOYbVph
         oltg==
X-Gm-Message-State: AGRZ1gJG+n5fv9+pphwInpJPo8q8yHqfdVz11hIfSI5ju7292JzDCW8P
        RmoRTPwZ4wARODSJ5sp5f/WM3Q==
X-Google-Smtp-Source: AJdET5dB/xCF63N+/t+cPwyHSuqbEa00oxxh+gEdgCLMczOO6t4X+QZY9TOu/iY1JF5p04XAVF6vCA==
X-Received: by 2002:a5d:5745:: with SMTP id q5-v6mr18857097wrw.161.1542657219652;
        Mon, 19 Nov 2018 11:53:39 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i16sm22954132wmd.28.2018.11.19.11.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Nov 2018 11:53:38 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 03/11] crypto: CRYPTO_STATS should depend on CRYPTO_USER
Date:   Mon, 19 Nov 2018 19:53:22 +0000
Message-Id: <1542657210-37739-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
References: <1542657210-37739-1-git-send-email-clabbe@baylibre.com>
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
index 62dbd1a99fa3..a2f1b4a86b92 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1829,6 +1829,7 @@ config CRYPTO_USER_API_AEAD
 
 config CRYPTO_STATS
 	bool "Crypto usage statistics for User-space"
+	depends on CRYPTO_USER
 	help
 	  This option enables the gathering of crypto stats.
 	  This will collect:
-- 
2.18.1

