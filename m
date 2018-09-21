Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F243C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA3821531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM+qVdob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA3821531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389708AbeIUPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:37:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50970 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:37:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id s12-v6so2405031wmc.0;
        Fri, 21 Sep 2018 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q72Ia64O0Hj+jtCZ2mc6urtTqPRevPjtrB0L5cIiYPg=;
        b=NM+qVdobtIfq/q5x6B3Dtmn19wbQFKjhbqjS15dB1J3fDirStMeFB3xj4UmekCDHqk
         UNIHBVi/vE4OrSEbbbQ3R5no/6YG1b5t2sdpj10dZmWEfc7Zka92Eh8JLtbj7L0GdJTH
         hDgdTjcOSwOgnO8qBbEPaSHMTSzgi1RQ5tRYlXHIunF6XrRwR2ZVb/DWWBHYl3D+Essx
         4zhLkwLKdME3lDCrTsR5HhRHSQy7nVfIYL1B0RnCNvTpyA7K+B9FyFgE+eQpB263vVxi
         xiyOFMu+UHpmkZZdhTQSTBSIVhomDV+i0wdm85KnbRzY+ntbWBXG7FQAoiO2ZCGvmwCN
         gm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q72Ia64O0Hj+jtCZ2mc6urtTqPRevPjtrB0L5cIiYPg=;
        b=aXIZFc6n1If78G6TK7Qb1Hg5dqD6u1yODRg94VVxlcnF+ZQrkZlYg8SEz/FY5O8j76
         IztdvInDReWRPjh3sZExia8WMqXsHj+Wfl77CqAtzPjJzaIS0PqMwjUFJtZQ7/hVTJ29
         bDopiT8jPB1MysJvT5fYGj0k5OQMrDCz8n7m5einn+5GSukyAHWlHae73jIh6Vc/qlVm
         dN7YKdloZ32xJCpwCVjHJtrBaaNUoOHUndsZRgrh2QIfsKaVyAshy7PxPbqzEYN1DWvu
         2kDDHh/FHm6v4m5wy41Xh89IkSRiSrbSLoJiizy+1VTgKmMeNBW94a2yd5ryanmmq1ZI
         gjMA==
X-Gm-Message-State: APzg51CIOrwnU6M1n2DoThCEHIP4WPU+YDjouMxupYIq/UKpUPnby3HR
        LEvZui9+Jo+wD3jh+iVd8kGlkDWko3sfdg==
X-Google-Smtp-Source: ACcGV62uRE3V/IrKK4lj+wG0duZyTmAB6h1PXhBzHBDcCAKlwPF/PV6dok7C+gMr7ORFlJPnQc74fA==
X-Received: by 2002:a7b:c04c:: with SMTP id u12-v6mr6568435wmc.24.1537523344836;
        Fri, 21 Sep 2018 02:49:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 88-v6sm25030740wrf.95.2018.09.21.02.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 02:49:04 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] rsi: Remove unnecessary boolean condition
Date:   Fri, 21 Sep 2018 02:48:29 -0700
Message-Id: <20180921094828.16976-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context.

drivers/net/wireless/rsi/rsi_91x_mac80211.c:927:50: warning: address of
array 'key->key' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (vif->type == NL80211_IFTYPE_STATION && key->key &&
                                                ~~ ~~~~~^~~
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/136
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 4e510cbe0a89..e56fc83faf0e 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -924,7 +924,7 @@ static int rsi_hal_key_config(struct ieee80211_hw *hw,
 	if (status)
 		return status;
 
-	if (vif->type == NL80211_IFTYPE_STATION && key->key &&
+	if (vif->type == NL80211_IFTYPE_STATION &&
 	    (key->cipher == WLAN_CIPHER_SUITE_WEP104 ||
 	     key->cipher == WLAN_CIPHER_SUITE_WEP40)) {
 		if (!rsi_send_block_unblock_frame(adapter->priv, false))
-- 
2.19.0

