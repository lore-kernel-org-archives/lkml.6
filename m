Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F125C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0402A208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aN1EAhXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0402A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeKTXDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:03:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36061 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbeKTXCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:02:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id s11so2066290wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MGyvvUrLG82fyYZI4kKXDmZmitZhSzKwNdI1JTjnMNI=;
        b=aN1EAhXlIL4gXyYA8WWbRjdMG+yBNIy0ZhnLQ5MeXj/hTqGHN7XclsF9+wgCmqPuyH
         /LzpcdDShlWozpC/jyU61g5Y6YYYSqO6IBHlTOOh17KF16WyB0gVxn/cePzzsjB9jbxT
         zOx+5BKmFQ7qjPHkXw1tyOQYRcSRbaw0FDp7s27Ln3sJMvJQJQJOBjhRYpimgCJgMTi8
         olPhgs1cxvOqG91C7wNUWTCGhfWot3L7IItkRRLekNbHAsKqYt7oBIN9DunOea7VHLAk
         FD+0okQhBt5CAA3EA3OXC6Gh/lUybtGY+BgsT0TJJwrY4yu5WxLaDVtKkKdU5ST1Dpen
         MZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MGyvvUrLG82fyYZI4kKXDmZmitZhSzKwNdI1JTjnMNI=;
        b=ZRMPWCfpyNnIvdciRwxEs9vzOBojalJkoBnoNwLQXrDXmWfqnf8mjAC0qA5kvHyqaC
         nujzwAQrKBxr/65xG7/RrCJgNWziQrZ4ZYhuHmD2RN0dPjxBydZ5JsvcfYOszmgOJF5x
         Lo4aUYcdZtn9guII+bJwM2nyI0iyfxqOy74jMMZZZfMiTo9WlJwwahLDECNcK8Yo6A3m
         ouUS84j/hnhjtgllrpmDn9OKN6bybpNR9Gv/RZZ8nNMbAVtuNsxXjwO6jBGUYSW5SkQM
         P4SxhnZnImBtbXoUbuGJ2pORrLh2uCmOeh7G/lZbE+QKnbzJKQfOowu+kT5MJz3etThj
         knrg==
X-Gm-Message-State: AA+aEWYmXUO33El5/67KQomaxKAxOs2/WSNaYZouJRfk1oMyqWl+0YQt
        p0N6TPsH4KIGhA4vKF8ktHFxxg==
X-Google-Smtp-Source: AJdET5cdUlOwclJkN9GUjxWOopb2Iid1lHLDHEj+GEZ+X1oH2G/FcMwaUixK5DCqFvUstzeXGInANA==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr2050816wmh.118.1542717201545;
        Tue, 20 Nov 2018 04:33:21 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x81sm2766951wmg.17.2018.11.20.04.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 04:33:20 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 02/10] crypto: CRYPTO_STATS should depend on CRYPTO_USER
Date:   Tue, 20 Nov 2018 12:32:18 +0000
Message-Id: <1542717146-34917-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
References: <1542717146-34917-1-git-send-email-clabbe@baylibre.com>
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

