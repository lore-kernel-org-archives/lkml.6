Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C860BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F07120833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0A/ZhIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F07120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbeGYUGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:06:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54158 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbeGYUGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:06:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so7078131wmh.3;
        Wed, 25 Jul 2018 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T2XmLz4t7bJY8qwNpH6u+IO0Q4CPhV2M+ECjf20HV8w=;
        b=t0A/ZhIos3bHLy4735EXMJX6WSm1+4LTbjEOb9Cyqcuk2hgwp2BRdh+kpXitErOGsg
         vutgXM/LWxCQql1rloNjMFIN/i6xi0iv6UrWWj7d+s45W+guuSpv5UjhQYnsAF26Xxlk
         KMzf8VD3Kvx5JdGBgu89KpZRUucibFg9XB0kvODeXOVhg7qgYIrhWT0Kremd7Q3zDHl+
         eb5igBU0lMkSpVyuElkAnreeM3MxfLnaCn2L9P9FDrNYY5F+gyUu5kU/s2XIlEvepLlW
         NbC2zgHXAo1BPumw+MUZzYSqMaWSzSdpfuvq6bVVZenrlEbLp4A1IaGQX275IMd2kfZQ
         tRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2XmLz4t7bJY8qwNpH6u+IO0Q4CPhV2M+ECjf20HV8w=;
        b=WEfITpUBsuvFRCsz6UnurfPPDzp2RSAmbHdviq8ClDOtYLytEs6ektO0H6IKpT5MUH
         hqpLrqtvfDx8dhPrU+YjvSsGAii2Z70A5Vy+Ms8X6Nz5hUzg7uRuqX6oFqadYtRwp3Qd
         SXvWP2l8PnTH4+vDYm6Sky3QOJCGcQBb9wOEoFuqswxSy/LOKqqDZvEXEfONmF5QL+bo
         A9slQZFupvWY2OeC9DhAM22f/Hapa/fbrnU9WC6RkUqwlkIjQfdg04R1o1e447MOsgIm
         rPwVAumMMS+KCRGk/TSzMXRuBEgyzZ3HNl4zgOazbqk1B/drC73s0/r21YVSANN26M4F
         ChRw==
X-Gm-Message-State: AOUpUlF55ZoIvQKW6MsJbD5UiZu40luH3LPn0zX4FtT/H4AYthvKoqU/
        XZHpkEJtizUraG5tjUKh+Ug=
X-Google-Smtp-Source: AAOMgpc6blNR7imDk8LBGL1bxdzQ2psQBJb1M+VrvcRJbLUM7yQcfUSP5ORnVXNR2RwX+A2rLp6duQ==
X-Received: by 2002:a1c:82c8:: with SMTP id e191-v6mr5008152wmd.35.1532544798374;
        Wed, 25 Jul 2018 11:53:18 -0700 (PDT)
Received: from euri.wifirst.net (eth-west-pareq2-46-193-2-21.wb.wifirst.net. [46.193.2.21])
        by smtp.googlemail.com with ESMTPSA id e204-v6sm4928475wma.8.2018.07.25.11.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 11:53:17 -0700 (PDT)
From:   Varsha Rao <rvarsha016@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] net: wireless: ath9k: Remove unnecessary parentheses
Date:   Wed, 25 Jul 2018 20:53:03 +0200
Message-Id: <20180725185305.4118-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra parentheses to fix the clang warning of extraneous
parentheses.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/net/wireless/ath/ath9k/debug_sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug_sta.c b/drivers/net/wireless/ath/ath9k/debug_sta.c
index a6f45f1bb5bb..ed8b77a74630 100644
--- a/drivers/net/wireless/ath/ath9k/debug_sta.c
+++ b/drivers/net/wireless/ath/ath9k/debug_sta.c
@@ -116,7 +116,7 @@ void ath_debug_rate_stats(struct ath_softc *sc,
 		if (rxs->rate_idx >= ARRAY_SIZE(rstats->ht_stats))
 			goto exit;
 
-		if ((rxs->bw == RATE_INFO_BW_40))
+		if (rxs->bw == RATE_INFO_BW_40)
 			rstats->ht_stats[rxs->rate_idx].ht40_cnt++;
 		else
 			rstats->ht_stats[rxs->rate_idx].ht20_cnt++;
-- 
2.17.0

