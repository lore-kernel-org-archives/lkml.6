Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405CFC71130
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021BE2088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvVF3pVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021BE2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJHEsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40544 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJHEsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so14262387wro.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTPaDu7ODyLW/YfGn90JC5mdzNHtgtW8N57krn0bSNM=;
        b=hvVF3pVr1Xn1jstPcxPR+hCPWk/y+KTu8NVfuAStr0XaicnnXTK8AFqzSjbF21vWGG
         i+ZF+EMDkMOcEHjH8l60nYcM8HWCqfT3M7S8hXBEUCkpcCZhtq9W49yUIkDWhE6ugYjs
         bvYT8D9RA9owI+efkNuc0pLjkVF48+Qa6Es8UOXesevHvVgm0Ta93Aryp/G+dAzJN0FI
         PzcBZa5mZazNtSb3Gzh7OzJCkp5JS5v2oOKziT2OaA+jcw5/J0YvVGbJfQbLaVxp5sJb
         +VDJYGw481c5Hw6v3x778SqrlALTw1Qpjoz3anuLdxUkl1PqfVPXe8PmgcO+caAJ3LSg
         9xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTPaDu7ODyLW/YfGn90JC5mdzNHtgtW8N57krn0bSNM=;
        b=TLCyi5wp+tZGdnOc6Hy11dKByvRMFFE3efvCVmYK46k3kgh1xQKxhYmFkHlWxcvjLK
         3u/cz4zRRoC2XA07XoLYB8rdBzIS+5Mxg3IeX7OAWxjJd1hukaJi8JHD9IBWIOZdlzG+
         FR9xd0yul9yspYJHD01Fh1YgZubm0X3DCRs181RcjR2j6JAxYrpbRQ91e+kn4Zcns94h
         dhsVJm9YYllC6yYToQ4m2QeYhGNCk6gnKmSTHhVujNxkeqwhBwcpoL/2mcZoOyC4n9HY
         i2Mb4e/g3N4j+66yiRYqv3avFaoNv9XJZFH6WrL3BuSkrDFweUiOkbkeO5KJIR8eXnJr
         wGGQ==
X-Gm-Message-State: ABuFfohgIkyY4Kr/Bx5rm6eiN+35XxbRJJGk6+5BF55JutDtJsh42lt/
        LaS+FPNqiZL2+DJNTSkQ4ZXfsJV/
X-Google-Smtp-Source: ACcGV60He2M4EekfUVfI0/+UP8f6NH/efH2CtomD6Uo+a2KdUs/BfmWIczC879mmlvxByfmJzBCLEg==
X-Received: by 2002:adf:e9c7:: with SMTP id l7-v6mr13624027wrn.238.1538948415369;
        Sun, 07 Oct 2018 14:40:15 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:14 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/11] staging:rtl8192u: Rewrite test for null - Style
Date:   Sun,  7 Oct 2018 22:40:20 +0100
Message-Id: <20181007214025.25469-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite a test for NULL to comply with the coding style and clear the
checkpatch issue.

This is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 0fe65dd8c407..9bbacec52e1f 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -155,7 +155,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	ieee80211_softmac_init(ieee);
 
 	ieee->pHTInfo = kzalloc(sizeof(RT_HIGH_THROUGHPUT), GFP_KERNEL);
-	if (ieee->pHTInfo == NULL) {
+	if (!ieee->pHTInfo) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for HTInfo\n");
 		goto failed;
 	}
-- 
2.19.0

