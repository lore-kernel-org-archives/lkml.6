Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E34C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E75D214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="J8lZLHOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E75D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJISbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34174 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbeJISbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so685663pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jYV4XtZvQJcH5lonM8XkSCurPDD+mGIDAojfNLj+Ipk=;
        b=J8lZLHOYK1LrbY6Pq/9Td9waby+CNpeceM5hEqGwFAqmiObwbixI9PITvVw+LvWVuj
         uRfzErRYQ4itOZQ/++9nktVEnKHTW+vpC72Lax2iRMNNuUB0GxFcfwOoSkpNGmSgBPnJ
         6ts8HuZ9YBAvMcQO+cW8LSsC3y9Sd8u50AVaxs0OIHkIZpWzkl3Ou5NLdMykqEDBK/zS
         w8KMwzdeQzXuIJhb23ZflMtGoUEDvRw+tZTwzhsD77IDYJPTMPCGaj3rC2/z+3U477NO
         GjcAuuPp1TRhpzYsRnBhJkDoSC4FlIJpWj6jqPYaa8bTDVub8z3U8dPAQiy2TglkBtoo
         TK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jYV4XtZvQJcH5lonM8XkSCurPDD+mGIDAojfNLj+Ipk=;
        b=OS0F2RBY450stX4BYcSsygnib6qDzbRFgMcxs+vWK1agcv4ctOXlPQhNtvNTj1JBJZ
         yFgqo80Kc2Qoa2Bh1Kb4vnD1fdf0zVqjDJmDIriE1t+tThbZ1vl2lwTbWOg4v/9pZcYy
         LSLVWihsaVzafVKVo5RzHNHb9+kO4e2WFMrdnLranCN/uVsKQ4eUI0TBFXdz98xGKSN5
         TffGKsx/u8ABz7SBe7uS8EEZPUsOamBVzpBk33eDaM4jTjUlvP2Dkv+dpQ1g/dGmH7ul
         uYYwCE/UtIh0gDndouLZh0BtuiCK16gIS7D/YlN6tju+ZM1MBigZ4TjTQUKcB2xq1qeV
         L5UQ==
X-Gm-Message-State: ABuFfoglaasdX5hsgQO8hSYVaidvbce3BGVnYiqKsg3TZ0yjIBZbsM8S
        8kVfenrvP6wEytCF3SuORTVi0w==
X-Google-Smtp-Source: ACcGV62Osy0EJ7KNHfxsdRbYHE4EeCaoGvN/YD7HHLYD7aXxQHLmkipoSCwVGlZC1vgCnUA2LSwzUQ==
X-Received: by 2002:a63:3308:: with SMTP id z8-v6mr21143648pgz.220.1539083694326;
        Tue, 09 Oct 2018 04:14:54 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:53 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 30/45] lightnvm: pblk: fix two sleep-in-atomic-context bugs
Date:   Tue,  9 Oct 2018 13:12:00 +0200
Message-Id: <20181009111215.7653-31-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 754:
	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048:
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434:
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980:
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976:
	spin_lock in pblk_recov_l2p

[FUNC] bio_map_kern(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 762:
	bio_map_kern in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048:
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434:
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980:
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976:
	spin_lock in pblk_recov_l2p

To fix these bugs, the call to pblk_line_replace_data()
is moved out of the spinlock protection.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 8036c3eb6372..2526722304bb 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -966,12 +966,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		}
 	}
 
-	spin_lock(&l_mg->free_lock);
 	if (!open_lines) {
+		spin_lock(&l_mg->free_lock);
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
 							&l_mg->meta_bitmap));
+		spin_unlock(&l_mg->free_lock);
 		pblk_line_replace_data(pblk);
 	} else {
+		spin_lock(&l_mg->free_lock);
 		/* Allocate next line for preparation */
 		l_mg->data_next = pblk_line_get(pblk);
 		if (l_mg->data_next) {
@@ -979,8 +981,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			l_mg->data_next->type = PBLK_LINETYPE_DATA;
 			is_next = 1;
 		}
+		spin_unlock(&l_mg->free_lock);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	if (is_next)
 		pblk_line_erase(pblk, l_mg->data_next);
-- 
2.17.1

