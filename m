Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B26C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B52C20895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGX7sL2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B52C20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJHEsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36211 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeJHEsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so18713669wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CcVqTL8cxSHY3yn91BgDQSeDEKcsVk6MLU6FnnFIMtg=;
        b=SGX7sL2PJulVfH1NwTLnUQOMjKo3XWKYv+1+WVPGYEPo/Lx1UG6Q2JX53I3YebmehT
         9wdNPWQ4dXVJwDd0ZheLIQFymsqa52SX9MTpOQFxBQL7P9O861SbStCgSjYvKNIp6IhO
         YnXmENndYl1bk06NP1ybAnUlBekqJPUMmzJkktA4rXqVfkR4oHtSuNAGqE7JsxHrwwpb
         HR1s6dpHr3gGL6icnUc3Prm1BQN08bhF5Ky7QaycTdxIv/IGKjOVMv/2g2gnJuJ1FNZL
         TZF3px27ER0lVdmBxqeCi8jokgSEfa1bN2t0Dwo03/sqJqu6+mfCDdKmOYPQ3cyhHSr4
         7Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CcVqTL8cxSHY3yn91BgDQSeDEKcsVk6MLU6FnnFIMtg=;
        b=sy7+ZRMQzOwL2rj753i0tGDgegZlYPmGjfaqetMYAOKLaf7PzGM35u9U2m1+dXil5O
         60VJCEZD3AZT+/7QRAS+KwnldA0HLm0jkbPRRPSgVidfrUjyRXMoRVonNKQnDoJ4blIE
         yWkgC1z7TmMMaVyBaqWI7tbddIpUSyYpeLG8Ph3HjV6AW1sj741153aajzbokqs2cCoQ
         /pFh8Dvupilaw9nkwSWYFRNSNB4SHmAG21NQBVuAm+peBz6pLxl3ehWmHI1EacQ+XK3k
         5f5up/X7Lo2FuIDNOqaaAs+ou0k/UmxlOkl4XN4HpdBjYi1Tag+vE1FtNHF3GMEL/Em5
         5lGA==
X-Gm-Message-State: ABuFfoiD8yoAOIcU4nUpNpoNx44Q8u5AHGg7RXldUy66vQ438Aqp9TJw
        t7yehtQfATC04lDbcaavmmAypIVT
X-Google-Smtp-Source: ACcGV62jwj3yDJzJZzDV0gtkSo7inNL6hCZhI2u0by6KiTwCHC7qO4qxavFT7dWltyb3oQoEl5fgDA==
X-Received: by 2002:adf:a352:: with SMTP id d18-v6mr14360134wrb.31.1538948416831;
        Sun, 07 Oct 2018 14:40:16 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/11] staging:rtl8192u: Correct code indentation - Style
Date:   Sun,  7 Oct 2018 22:40:21 +0100
Message-Id: <20181007214025.25469-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite code block to correct the indentation of code. This clears the
resulting checkpatch issue.

This is a coding style change which should not impact runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 9bbacec52e1f..c31db21f7e63 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -167,9 +167,9 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 		INIT_LIST_HEAD(&ieee->ibss_mac_hash[i]);
 
 	for (i = 0; i < 17; i++) {
-	  ieee->last_rxseq_num[i] = -1;
-	  ieee->last_rxfrag_num[i] = -1;
-	  ieee->last_packet_time[i] = 0;
+		ieee->last_rxseq_num[i] = -1;
+		ieee->last_rxfrag_num[i] = -1;
+		ieee->last_packet_time[i] = 0;
 	}
 
 /* These function were added to load crypte module autoly */
-- 
2.19.0

