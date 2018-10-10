Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B0BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48512086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhQvgRNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48512086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJKAtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:49:53 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:34940 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJKAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:49:53 -0400
Received: by mail-vs1-f74.google.com with SMTP id x7so2330113vsf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Zz7PPs5AcRzkxIBygTwLmabY3Uzsb0z0jYYqTjSlpqI=;
        b=YhQvgRNhF88qWCoLwOSPsRfx705MKoIyMYQnLghb5raTMc1sulGp0RCkTYFKVeUqhq
         X1C+8RG2xt+3e8AkUN4ogQ2d9Dc4TB8w3Q3M0llA08Tp2zAA0EbFi3OfBHwiVKBOcj+z
         /gTY/k4J9rd1BnLnoUuzB+MFat3B4PwUs+JvX/O4uSIAa0uc9QXbRdngNW7T+wptWFRd
         hMav5pWYRHIJ1nEPRhUoJmO/2NmEJA0FHpSvk/Ww2JSdm3pJ9lfkWkqELrHz3qvSpVXM
         /PexU0mPOVzF2QyGDf0uswGXdIIaf8C0UyYVuaZMMKTWWNjDHhC8f/cgbqTh1ED/kk58
         Uv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Zz7PPs5AcRzkxIBygTwLmabY3Uzsb0z0jYYqTjSlpqI=;
        b=uLGQjVyGnOb33xeOxs2ZvTxBo9+J3ACp4f+ifAVZIcamJXy/iMGpbYP81d6F+1Jprj
         ZCNp9sIkfQA1BQoaTDpua8WUCpO0YKjQp0SIxL0OCqBE2lTMqPIjAen46b4rFKVGVJuy
         PbQi2MH6u47uSnFkXAdq2cr7DCNRBRqnS45DV0dp4p+zk/CkVh8nwNFYB658bGzwk81I
         M0d6Ux2QWgK+ITI9jqVTIm0+c/B47dpQR9u6OsxZdf6TRHggMvnl9jxjwBESTLYNNDkF
         Aoakqp7sef7hRSr4S8kIn+cEjbyGaKPnTSR/B2Bms+MRq6AkXTMtp+GoRHxNNlSvrzIQ
         p66w==
X-Gm-Message-State: ABuFfohdxqFujag7HXV1B2av6yVTPjrBAl2faP1GyL7OSHNby24Lwo5d
        NJG+9lfeYlZFqonXxzM5457+zJYfQB4=
X-Google-Smtp-Source: ACcGV62SYsQref9Ujw1gIAMHo/Vc76fjzXco+h3GnB59YBXL+KFmAi6oqgYMBptqJa+qEYyZ9Fqj9lvmrAQ=
X-Received: by 2002:ab0:6298:: with SMTP id z24-v6mr17560104uao.15.1539192405040;
 Wed, 10 Oct 2018 10:26:45 -0700 (PDT)
Date:   Wed, 10 Oct 2018 10:26:23 -0700
Message-Id: <20181010172623.57033-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH] fs/fat: add cond_resched to fat_count_free_clusters
From:   Khazhismel Kumykov <khazhy@google.com>
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non-preempt kernels this loop can take a long time (more than 50
ticks) processing through entries.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 fs/fat/fatent.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index defc2168de91..f58c0cacc531 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -682,6 +682,7 @@ int fat_count_free_clusters(struct super_block *sb)
 			if (ops->ent_get(&fatent) == FAT_ENT_FREE)
 				free++;
 		} while (fat_ent_next(sbi, &fatent));
+		cond_resched();
 	}
 	sbi->free_clusters = free;
 	sbi->free_clus_valid = 1;
-- 
2.19.0.605.g01d371f741-goog

