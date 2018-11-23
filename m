Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61022C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DB520863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tpz4n55B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DB520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503951AbeKWWqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:46:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53057 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503925AbeKWWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:46:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so11644474wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 04:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9n/ARJW/vSmYLj9SN9ylrpC2sSqXn0Twlo1KGmkMWjs=;
        b=tpz4n55BAcUiARXYmN4O3AdNJHWCPJY1j6cN7VmmmJWdFsyq7/qEQEtzeOFuLy5wOM
         zL22PCH2IHoi4ezLLJ2GmfzhHWkTLIJ7kZ0pH3TK+Kd1QL3kofXI0/1B8NNetBKK2JT2
         /3eFxJCOiv6QAs9tlljy2wcte0MvpATrSnvDhf+Lvnhj/hQq9HygUFvSAa1ydAFSTbsf
         UvCXENo4bpjdw1CwWZpdQgcjj/mLmE/te4eHaGgscyAYA2p645/A42apuHuKkk9ZKL2a
         RQOYZt0aZ0IFT4gbRtUgTTMvukrRX22HZf0UMDW6Bm5Xu0t/4TsG23FC8ZHoXwMY/gNW
         Cjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9n/ARJW/vSmYLj9SN9ylrpC2sSqXn0Twlo1KGmkMWjs=;
        b=ANI6zoGIhXoiMwewZGb4kaXSnKWWC7BnkuiIv7PzeiJyYpT2FI9sPfPcRsS6h+FBKU
         1yBSLr/UNDacHs3fyQ2MA4SzU93J4gcXOqZvR+XyN3WXCAG/bye0dWdXIvced7gYRs+W
         CHwEYzP/L/K1j9Ny7nRadLDd6Z389EPpP/T4T9KEPtQZF7ra+8XJNvFUleKAMdRORyNY
         6s/hFETS46lef2jv30b/gjy2ExxMeXM8a9sXBoqtnCqQG+nz5L5CbLxwBMc4H5ym0mh1
         1KVCMFmEoJljJBAj3LUYohappPjtYcrZrCBzQxJzGfYBXQYCRQUYH/Ty80U9YJZW2u5Q
         FvjA==
X-Gm-Message-State: AGRZ1gIZFVi5s8o01cHnl5GWTH/LNJ15YM+apvUIPwacrrGoIs73V5+R
        mj9ZUnE2ErnczTWKVr45hQUyJA==
X-Google-Smtp-Source: AFSGD/XeGXcmA0+2A9K6X3BDq2VhoG/eCdQx3Ch8tbHM4WyajGRhk0/0391kB+83s3Rrha/dWK1uRw==
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr12944887wmg.100.1542974553709;
        Fri, 23 Nov 2018 04:02:33 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a18sm25164379wrp.13.2018.11.23.04.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 04:02:31 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, ebiggers@kernel.org,
        herbert@gondor.apana.org.au, nhorman@tuxdriver.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 02/11] crypto: CRYPTO_STATS should depend on CRYPTO_USER
Date:   Fri, 23 Nov 2018 12:02:12 +0000
Message-Id: <1542974541-23024-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
References: <1542974541-23024-1-git-send-email-clabbe@baylibre.com>
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

