Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620F4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFAB20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="LRcIBwzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFAB20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeKEVBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:01:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40137 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbeKEVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:01:23 -0500
Received: by mail-it1-f196.google.com with SMTP id e11so8805571itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCw1dkDLslu/HElVaRw3FdhfQGOps1Ieu66UCGRSzO0=;
        b=LRcIBwzF8OGzX4fSBdZBIEU9gtjaLxX7Sw1SJMzHumUcNrq1cVhT4VjANjKBxDNKtV
         XBaeSIeFLZTZ6D+k/DcEaBU88AqfsrcjTdXyivAbufZeYFIDmK5e9TPapYgnJMoKN34F
         hSkjfgKyaD7Cks9ZxnQjaG8eLtsteMRV+pTFLw4nvnnitzsyDdE7ui+YVNBnZFpqlL1U
         TGC6/PgReyRgt5G+sv7GBM+Hy935NReAb08LRrm6PKx26FSZLcRxQN7hP2DNRuRUuGtU
         gHqbU5a1oTqJ7pHxB8A93D/F2V67+SNO9R4gXED0rNXdBojBa09Y3EJ9TRr+TJ/ivE+w
         xd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCw1dkDLslu/HElVaRw3FdhfQGOps1Ieu66UCGRSzO0=;
        b=UoHSGkUGT+S/4yz+f7eBOkh64yeyQ9W0BjPic9hno2uxPVpPa8mdlJy1AOUFhJsP2k
         GPBPrP3s25I1/zn+aEuv/NByLpfw0w6mgaoAv+10+qyFg6i+isZ9ofefJ99VwFenxTpH
         GJxJ34ToCef4iWNMM92lQGyx2Vr79uzojwftiqpyLYzNnBXIVxTqlOve2AHowxxThVzh
         FxhsF7Pzs1YzpTNj/lOoixqeYUb9563qXjYG8hJsCNC29l9zgqyAxLqTPXU4WiAADJxD
         dHtR4+n9tOPRnYyeg62uhSMx91mqp5MCDw9DHoq9LUB1k984yr1n+6ZGs+hEtO/Lep62
         Pp6w==
X-Gm-Message-State: AGRZ1gJoUZ8uezu8btsC/ntuptW8wBgMmVf2eFiV7ohtGORySIKOcjWu
        wabGrH4Wal7ZOqNVvyMWvN3sUza7ZQO/Dg==
X-Google-Smtp-Source: AJdET5eJjtZ2Ztd6LkCJAASSZAbLTHJ+DdtbzeUzvyZUvNhyuDYTKZT03yfsoGLzvKrhX2NNzLEHAw==
X-Received: by 2002:a05:660c:606:: with SMTP id i6mr6510208itk.110.1541418123848;
        Mon, 05 Nov 2018 03:42:03 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 186-v6sm14880824itf.11.2018.11.05.03.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 03:42:03 -0800 (PST)
From:   Hans Holmberg <hans@owltronix.com>
X-Google-Original-From: Hans Holmberg <hans.ml.holmberg@cnexlabs.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 1/7] lightnvm: pblk: fix resubmission of overwritten write err lbas
Date:   Mon,  5 Nov 2018 12:41:07 +0100
Message-Id: <20181105114113.30932-2-hans.ml.holmberg@cnexlabs.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
References: <20181105114113.30932-1-hans.ml.holmberg@cnexlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.ml.holmberg@owltronix.com>

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Make sure we only look up valid lba addresses on the resubmission path.

If an lba is invalidated in the write buffer, that sector will be
submitted to disk(as it is already mapped to a ppa), and that write
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

