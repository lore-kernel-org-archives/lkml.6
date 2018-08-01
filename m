Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D29C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1108020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AhE0OtDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1108020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbeHALtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:49:11 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:54776 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388919AbeHALtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:49:11 -0400
Received: by mail-wm0-f53.google.com with SMTP id c14-v6so6281823wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VuMSobxqG9WNa9OZiPgkmFIgiBpcY6xQ+KGyfHoGbPg=;
        b=AhE0OtDx8p4sPmEDFS/iadD5n1O5KeLKyJUt/xUNn0z9hzLPcats6xdPMeP7k/U7BW
         9Ld1qziXLrjr/jWML91LrMM8lNZvKwez+MDZTFVodiCDVgTqqeI9nGX+HjpuY3MngHoI
         dp1ckCxteEK0ae4grNSOASj9hzs3tI9JEtzRMC6p3S9JGS9r7vfuEN3iIzPY/2vt3jBo
         RZwS29NDpyG/8QVcIWE53wek5uoF/qBEU9MJMlur9C3cEam2g5hWaBI1OjP+D1SHQMY3
         Ksg5ykHiJtrI0veNoGMqjL0o7aIFmMLdGmoe8sw9R8fGdFdeDhajZGlauPnA27S0eyIf
         ubyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VuMSobxqG9WNa9OZiPgkmFIgiBpcY6xQ+KGyfHoGbPg=;
        b=k12dUAjhsWlGQQqjhDy7GT4psQQIPG6+Wv4ZuprGgZ6gKHPReJsYnS7BhVHcEFftkw
         lrWrra4zCpo9fruZ6OgHL3iHaQ1oHwsGYDkNHuhGPSkl6/Iemu7taEm7s9/pwNYvRNOF
         igrEZ6M98jjoLHSXtHtnjubp0L7ZB+lnOEbA5oG7eTBPnJcD39yGK+ZIMtzbUiQZyoeI
         WTLERH3h4PX0RsR4bTm+gX2TPqx1w2u53aWMzNoUGnwXt+WwvgPDi2Ny9R95uYcVvf0R
         yQli0u/42QzA/XhGHaUktJrxFGxZ4eYbebFlEcvImDHRwcRLXzI7RY8GelUuoB4GS4Mr
         UKGw==
X-Gm-Message-State: AOUpUlEtJTJg+HBaB388rlu184+mil16JSnkzgf8VJ6xXPcpevDYo7qw
        pq6/RRBW+8uj1EObhCT5djtGhw==
X-Google-Smtp-Source: AAOMgpeBib7IEUDCNVwh7P4pMkZ6BpzMeTW8htUSVTXVVlyw6H+1Zoy0pKhzw56KpQkx6BCqIrD/cg==
X-Received: by 2002:a1c:3e8f:: with SMTP id l137-v6mr2248949wma.132.1533117851099;
        Wed, 01 Aug 2018 03:04:11 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e5-v6sm4579835wmh.29.2018.08.01.03.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 03:04:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, linus.walleij@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] meson_sm: add TEST_N pin direction call
Date:   Wed,  1 Aug 2018 12:04:08 +0200
Message-Id: <1533117848-28194-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic Meson GX and AXG has a Secure Monitor call to change the
TEST_N pin gpio direction, add it in the supported call list.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/meson/meson_sm.c       | 1 +
 include/linux/firmware/meson/meson_sm.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 0ec2ca8..f407001 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -48,6 +48,7 @@ struct meson_sm_chip gxbb_chip = {
 		CMD(SM_EFUSE_READ,	0x82000030),
 		CMD(SM_EFUSE_WRITE,	0x82000031),
 		CMD(SM_EFUSE_USER_MAX,	0x82000033),
+		CMD(SM_TEST_N_DIR,	0x82000046),
 		{ /* sentinel */ },
 	},
 };
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 37a5eae..133b1c3 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -17,6 +17,7 @@ enum {
 	SM_EFUSE_READ,
 	SM_EFUSE_WRITE,
 	SM_EFUSE_USER_MAX,
+	SM_TEST_N_DIR,
 };
 
 struct meson_sm_firmware;
-- 
2.7.4

