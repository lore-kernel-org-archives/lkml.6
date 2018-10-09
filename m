Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96019C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548212075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mERJpbIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548212075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeJISbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45006 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeJISbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so641308pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9I+TPvf6SCw26SBDSlzBDvl3jcORMV7eF6pAF/YpLQ=;
        b=mERJpbIYAbI7Vm5L8i/qB8Ot8t6Uv6+CTGbTWuX8Xj3ERhhAG9mPpR0dayeZ8tid+E
         2o9+gwJaOfCeAemWpQODRrBQxdjjvwjlLR6o+o+GgdcBMf2KABIjf9y4o0ECeZm2Atl/
         qOaK28Wg0VFxi+m8fvNTNdokJlgrjQLzNeqdi8540ES78W2y05eTqufCKT6ztl+KpMhH
         faDVeX40JshVWeX2/hvKlozd81gfEidHfDtmf+XiE/QBWWKHN2rGkRt4tPHsf01zyvgE
         bsl5a34+5K+KzRJ1rOWSGAvt56t74QL+C8LBdkiwdMzabiVqGyNr/iZK+WuOY7iFlrAl
         fBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9I+TPvf6SCw26SBDSlzBDvl3jcORMV7eF6pAF/YpLQ=;
        b=QG+Spp+800DXUg1iT82MQ1T8gUzI2wVhpt1VKbY8oN8pMGARcPSwjBtaX437Lg7Njl
         xeVD8qwGUQI1qDH0F4nGzwaoB0GKkVVfTKflrV57i1bQRyHkSQf9XQyfjO2wZDPr7EN5
         kZjJdmCez2TXs1TkOd8LdKj5qV9eFrc7cE74WZ8kie+XkXV3sofPl18BcUeBJQ3lar33
         +80V1/3u4fHwdwUUqX6BjLPP0vvi1IMhrzz6EUTmVyFQ1ohhdpmIsMJmLIVc0wJsMSsU
         B/IkUr1E2GwSw2FK6OxAlqk66Ev1mHlcfbTkWBkSgwiePkaszbAo4fhNNmBFGYdfrs2i
         cE+g==
X-Gm-Message-State: ABuFfohX2I2lFJAQKW8/9lBZ5XNKQd0Pj5GqXvBnPY/kHFzZK6QK6ai6
        rV2CemXiCtR3w27oOECJE2B+dbIZGV2Oyw==
X-Google-Smtp-Source: ACcGV61etT9glLrTQfEDerHFNJewp73x4LXN4wAoK0zwPP9dwr7iCA2L9z5HG0bmDQG2A0xto8xsFQ==
X-Received: by 2002:aa7:8715:: with SMTP id b21-v6mr29328349pfo.250.1539083722805;
        Tue, 09 Oct 2018 04:15:22 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:15:21 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 38/45] lightnvm: pblk: remove unused function
Date:   Tue,  9 Oct 2018 13:12:08 +0200
Message-Id: <20181009111215.7653-39-mb@lightnvm.io>
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

From: Javier González <javier@javigon.com>

Removed unused function in pblk-rb.c

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-rb.c | 26 --------------------------
 drivers/lightnvm/pblk.h    |  2 --
 2 files changed, 28 deletions(-)

diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index c26eab2ba8bd..82829e8151db 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -729,32 +729,6 @@ unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb)
 	return (submitted < to_flush) ? (to_flush - submitted) : 0;
 }
 
-/*
- * Scan from the current position of the sync pointer to find the entry that
- * corresponds to the given ppa. This is necessary since write requests can be
- * completed out of order. The assumption is that the ppa is close to the sync
- * pointer thus the search will not take long.
- *
- * The caller of this function must guarantee that the sync pointer will no
- * reach the entry while it is using the metadata associated with it. With this
- * assumption in mind, there is no need to take the sync lock.
- */
-struct pblk_rb_entry *pblk_rb_sync_scan_entry(struct pblk_rb *rb,
-					      struct ppa_addr *ppa)
-{
-	unsigned int sync, subm, count;
-	unsigned int i;
-
-	sync = READ_ONCE(rb->sync);
-	subm = READ_ONCE(rb->subm);
-	count = pblk_rb_ring_count(subm, sync, rb->nr_entries);
-
-	for (i = 0; i < count; i++)
-		sync = (sync + 1) & (rb->nr_entries - 1);
-
-	return NULL;
-}
-
 int pblk_rb_tear_down_check(struct pblk_rb *rb)
 {
 	struct pblk_rb_entry *entry;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index e710f6db2a35..22586b78198a 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -760,8 +760,6 @@ unsigned int pblk_rb_read_commit(struct pblk_rb *rb, unsigned int entries);
 
 unsigned int pblk_rb_sync_init(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_sync_advance(struct pblk_rb *rb, unsigned int nr_entries);
-struct pblk_rb_entry *pblk_rb_sync_scan_entry(struct pblk_rb *rb,
-					      struct ppa_addr *ppa);
 void pblk_rb_sync_end(struct pblk_rb *rb, unsigned long *flags);
 unsigned int pblk_rb_flush_point_count(struct pblk_rb *rb);
 
-- 
2.17.1

