Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD70C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F6213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiosQCl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBZGAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:00:54 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40481 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBZGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:00:54 -0500
Received: by mail-yw1-f67.google.com with SMTP id c67so4652285ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 22:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=owLeHvkuFB5BiqLUhh1Q+XsB2HNhaDtZSXPOTXVUCB8=;
        b=EiosQCl1xEsMlulpsSRDiQN5hRA/GRiKpE/jZ6r/LjcK4XB3h0qf9//OO5BVxX8Dfr
         pPbqOpid/nsrGFVc2LsGGSotwZrR2MCzgH8AndERuRfBSaiCqZqW/40E00kmFOGPorOP
         3DmYXnRQy5RkVtXtOs1yft793NDdE8tVnpLhFEKp7k5Y+Xf7VI+POvWqtbJ2S2pIWAM7
         BDzqZqiohsUDtySzwLNg+iAGk5blS5NGqhFPK+HtUYRDOcBxrcNVfRvslTJFsjx99hVi
         fanPKW/rYu1FiJIoldFv6/dC6sDD65cVj2s2n+GhoetUjmc0zRMM9drEuql+tdofGsRN
         r7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=owLeHvkuFB5BiqLUhh1Q+XsB2HNhaDtZSXPOTXVUCB8=;
        b=PfpbopG1O2yoc3wHoJNJaN+WXloB5NJocdW6qPA5euJnBKso2m1dBNgeFdi1H/yaq7
         Zet5HKHsvh9da5zP6UsoEyN0TLXpu2Fm/pQwT7KvRThPWAR0IYJCPSKy1xHqcQHtXmuv
         YBHpVfbdfm4OXabcCf6nIq9+yfvHPxlHW0S8/GcCN0lwX//nwO38Eep0kI22j63cLQR0
         0AmBwaOFFmwpc7inpLxN+DpVklXHFVC2zXpLRsk6xf5TyxbGosjT8a1gGqPhRRTrVbMR
         euElnRspTnCHPb/3ytA4gH9TVMkooM6yQQh9P4MhjySQaIyf6gAK/GbFK499SABtf0/s
         pFeg==
X-Gm-Message-State: AHQUAuaD2YTtP4bXqGY9a+iVf+bSfLVwH+HzGVx7jPo/Eh2G+3tX8owN
        nJuC5rOwWFUvwlgA1LN6MmA=
X-Google-Smtp-Source: AHgI3Ibv0SOq8gH5heerrdCQxnxtGGV7N7Cb+wvp/jvDl3CNdXWUS4YU3agBGEAng4i6c9nvalGMZw==
X-Received: by 2002:a0d:e105:: with SMTP id k5mr16516948ywe.196.1551160853238;
        Mon, 25 Feb 2019 22:00:53 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id l140sm4199433ywc.2.2019.02.25.22.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 22:00:52 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     adham.abozaeid@microchip.com, ajay.kathat@microchip.com,
        gregkh@linuxfoundation.org, yuzibode@126.com
Cc:     Bo YU <tsu.yubo@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wilc1000: fix incorrect type in initializer
Date:   Tue, 26 Feb 2019 01:00:32 -0500
Message-Id: <20190226060032.26495-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning following:

drivers/staging/wilc1000/host_interface.c:444:49: warning: incorrect type in initializer (different address spaces)
drivers/staging/wilc1000/host_interface.c:444:49:    expected struct cfg80211_bss_ies const *ies
drivers/staging/wilc1000/host_interface.c:444:49:    got struct cfg80211_bss_ies const [noderef] <asn:4> *ies

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/staging/wilc1000/host_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
index cdcb52aec779..89ae22d40f71 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -441,7 +441,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
 	const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
 	int ret;
-	const struct cfg80211_bss_ies *ies = bss->ies;
+	const struct cfg80211_bss_ies *ies = rcu_dereference(bss->ies);
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
 	if (!param)
-- 
2.11.0

