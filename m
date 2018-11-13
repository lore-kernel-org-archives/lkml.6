Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ACDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D7D22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me7d7TN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D7D22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeKMOON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:14:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42165 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbeKMOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:14:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so1615681pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 20:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HMmJibSrAynUwKhby60Ri0xmOKkhaXCBIIErp75jOPI=;
        b=Me7d7TN7wq642HSYt7kw+FVCED9mN5O2CxVL+v3TYAcYX5mSJtRkLLdskLS+6kQdTM
         0c45cvKs9IMwJTli/cRwJemlKlC747Q6SujFB41FTV1Ny3N5pbZb2OIHQWhdupbcp6J8
         iLIFm6PervcoXJuIXSONlXL9wiCooYo/+Nfuet9Pnm1v+Kgo5A/Zy2e7Xch054NeKN3j
         OdktjtaMwDJD8gvoByR+Ju9KZR6dEnh+3qDTt9qb4ftCrUvCDxMo5v1cOQmeSvGAeeiN
         z/ME18GRnIqmBCErU3Y+oY6/UIADHY0OxGDRIG4oYC4uN6H6wLAHgP8OiWIvZS3pRDz+
         Z/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HMmJibSrAynUwKhby60Ri0xmOKkhaXCBIIErp75jOPI=;
        b=VPWGO8cswRESKMXHJd/uHqaqNfjbhHppsrfzrTJjYSyF7cNkTgzn03uUJZcxngvlhO
         r38KhAb7EcBDA/Nosxu8w7KHvgdZpkciFuaJ9ixbTo9iF8V/HXbB+CRgnt9pBvLmNXo9
         xoqWths3MWc9twtw4ycKRzbzlpwGEfyhewO59E+wnLBHghdQ0W7ZPUdmDoiANUFcNp+y
         N5kKjqz7+7ReC6J7vt1RsyYUZjlowx+r/RkzZmDS1gJPx96XClEyydzSFbwYWqighRqh
         ZnlVkyyd77TFf4/owX9bSvBV6T/C5zY+EKewLE1SNqAXtAHy3G+UKl2eYqqH4zqJlOcG
         lE4A==
X-Gm-Message-State: AGRZ1gISirnJBfGey+wfNfp4wR7ybQ3MNEkbbpRce2dIYylWa7neIqto
        UxTdb+D2W5L9V0kwlROjdnCy2bbg21E=
X-Google-Smtp-Source: AJdET5dl1V8Tyo+49fWpnwcvKUCswULvBwK6JkBZrW6qUwNXeKqEbjEz8giU0HZptCqrxtB4rCToJg==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr3587937pfm.18.1542082678372;
        Mon, 12 Nov 2018 20:17:58 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w10sm9793279pgi.81.2018.11.12.20.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 20:17:57 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim() when CONFIG_NUMA is n
Date:   Tue, 13 Nov 2018 12:17:50 +0800
Message-Id: <20181113041750.20784-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa5e084e43eb ("vmscan: do not unconditionally treat zones that
fail zone_reclaim() as full") changed the return value of node_reclaim().
The original return value 0 means NODE_RECLAIM_SOME after this commit.

While the return value of node_reclaim() when CONFIG_NUMA is n is not
changed. This will leads to call zone_watermark_ok() again.

This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
it is not proper to include "mm/internal.h", just hard coded it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---

This doesn't effect the system functionally. I am not sure we need to cc to
stable tree?

---
 include/linux/swap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d8a07a4f171d..2bd993280470 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -364,7 +364,7 @@ extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
 static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
 				unsigned int order)
 {
-	return 0;
+	return -2;	/* NODE_RECLAIM_NOSCAN */
 }
 #endif
 
-- 
2.15.1

