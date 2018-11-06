Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54725C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191ED20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="AnWiL5xR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191ED20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbeKFW64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:58:56 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35425 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbeKFW6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:58:55 -0500
Received: by mail-it1-f193.google.com with SMTP id v11so11438707itj.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hHPwN4g6a4SDExe3kUgDdBPm98FRozlO3nCP6bTp2w=;
        b=AnWiL5xR37/te7QeJB1ltNOvAsU0SgZe+F7ArNF7uPqRfG9OsJ2MGBPP1lJfUZLX4m
         tTx+L1PennzTEDPoNpkEHbXIPLHExR4wyobaBLZBoI5kgEDNz7br8850flNeZ7icnqFp
         nAcASjEscgoxS5N3mWaevjaKg4L8sdEjJ5WMX/hkNmXGJfv5ymOBW5w/60z9dkynXpu7
         CMihqHwJz8BjfNdGugwCKS6Th1YvsPNIdYFaIZRXfRmJesYH1w9aEYzlw8PcZyst4lUO
         xBjHfcjohRr6kRL3U12y6dOP8aux79EHeX/POQPthI02ypE9/oBx+ssQNInOuqYPSXHc
         x2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8hHPwN4g6a4SDExe3kUgDdBPm98FRozlO3nCP6bTp2w=;
        b=nu1wxL36IeT78ZjAP+/Yra1oanHeb9Kp6h8TNpql7+mi6SkSpTC71c0FDHD+QiY/e1
         aCQ9o2NIUnzfL9/vT0aV3FXWM1enRVwY2/kamCrdItCqUN9KHTDklZMfaGBJVEFjQPnN
         fkgf9iFLXWLlAVwrJXNBAUFmFIppUxdQUhmwsamse9EfbrJqez9JjoZFybwcA0Wij39c
         2glkgKnbFy5pdgcEgEVxGPjBNTSKPACvJfl9jUKWKRXqkH5JZTjwZJqtuomw8uUj5uVd
         LdIBTT41DqnxfWCu/8cH5dVafPcRc/l5laZcvy/6BWrTCnTPlujSmeAyA9nh9h0FfNeb
         EeMg==
X-Gm-Message-State: AGRZ1gJ4qf43t7qnC5RPOAqfJgF5ObMmnttS+sjtWduUZZKO0CJZADjG
        5yVU0HwK/ckf022/mn+jB7TvhQ==
X-Google-Smtp-Source: AJdET5eYWq7eKNDmFdB7WJOVyQ7blK4eW+6cBgW3zICvRi1HTKsdszuxLbf6A+9hAHyJrDVqKS2qqA==
X-Received: by 2002:a02:22ca:: with SMTP id o193-v6mr22163997jao.83.1541511220442;
        Tue, 06 Nov 2018 05:33:40 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u132-v6sm897282itb.21.2018.11.06.05.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:33:39 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 1/7] lightnvm: pblk: fix resubmission of overwritten write err lbas
Date:   Tue,  6 Nov 2018 14:33:24 +0100
Message-Id: <20181106133330.26570-2-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Make sure we only look up valid lba addresses on the resubmission path.

If an lba is invalidated in the write buffer, that sector will be
submitted to disk (as it is already mapped to a ppa), and that write
might fail, resulting in a crash when trying to look up the lba in the
mapping table (as the lba is marked as invalid).

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index fa8726493b39..3ddd16f47106 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -148,9 +148,11 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		w_ctx = &entry->w_ctx;
 
 		/* Check if the lba has been overwritten */
-		ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
-		if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
-			w_ctx->lba = ADDR_EMPTY;
+		if (w_ctx->lba != ADDR_EMPTY) {
+			ppa_l2p = pblk_trans_map_get(pblk, w_ctx->lba);
+			if (!pblk_ppa_comp(ppa_l2p, entry->cacheline))
+				w_ctx->lba = ADDR_EMPTY;
+		}
 
 		/* Mark up the entry as submittable again */
 		flags = READ_ONCE(w_ctx->flags);
-- 
2.17.1

