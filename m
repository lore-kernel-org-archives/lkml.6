Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A7C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637582087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="vM938xQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637582087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeLKTRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38897 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeLKTR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so14051066lja.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvwDy0B0eo5bm6LRb1HjRis5IhBlsMJInML918QqRcI=;
        b=vM938xQL7ND4aTGOdQfsGOLI74Bmt+xRgpD/LmfzRFOIWxMKFi8Nwx1GgOu4yS7UHM
         yu3QdfzqkeSBIa08QhLDnXPK+889Q8j0qu73A3K5zXjwhXkoJlcT5x0lHj12fWB0smdE
         nRQp2djUoylvLvOUZ9Bq5ZZgC4bRyvcd3rfS+cvZneAWyWPJmMzseOf1h1QzS+eRPd2M
         lHUdKfODEReYQYktbriLJEQY5yzo/nQuJ/9RT5krzH5ONs9kbMzomcZxV1EC9Ijc1QD6
         U+p0LZgaBjH4YBuOnjx2vnYqS5fkptC/8snckZ/pFxCwgI5T3K+35Ywrz5dYxvHmmBad
         q3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvwDy0B0eo5bm6LRb1HjRis5IhBlsMJInML918QqRcI=;
        b=UIaFjrcD/G69bRizSw160hQ97O73AhqS1/S9gjfhCpTGFupwkXHq7eMGPC59VWY5ml
         8PoUuyvut/nFP8YEsWp0KaYOdJO5+yyGflJT/EKmGdw9ZHP+nItZsRaEGUsvgAASWPgH
         UD4Ztlfx45Tm1xl/8IQQ2f+OW4duV46h9QS3sRMfCwecZI6AZTc+K6WzlPgJSy3jpquk
         V/AsKFq01uQYow9b2crUOVND597uM1POLo4lYbbLKDThutjxT2vyeuakKoSXxn99NEI6
         Gg3G8k5mBoTXaSFxG/b0x8zOUVKwI0ABLd0kJsFSDTAX3ijDfKT5N7n4yDAQZzWz/1WZ
         iAYw==
X-Gm-Message-State: AA+aEWYY1sBYtnNg5fltDwSfO0avLoUJPpti35e6gv4sLu7uvDDo2+3S
        61zPkO0tVVF/gcgUlnF81iCPHw==
X-Google-Smtp-Source: AFSGD/X2FZZSird9B30Rmu6F4xIUeCKcjjHIR1xy85BHr0k2QDIAxSgUKJa+uwol1MgbawPjoFSVeQ==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr10526948lja.58.1544555846450;
        Tue, 11 Dec 2018 11:17:26 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:17:25 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 21/21] lightnvm: pblk: do not overwrite ppa list with meta list
Date:   Tue, 11 Dec 2018 20:16:27 +0100
Message-Id: <20181211191627.15542-22-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
References: <20181211191627.15542-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Ehen using pblk with 0 sized metadata both ppa list and meta list
points to the same memory since pblk_dma_meta_size() returns 0 in
that case.

This patch fix that issue by ensuring that pblk_dma_meta_size()
always returns space equal to sizeof(struct pblk_sec_meta) and thus
ppa list and meta list points to different memory address.

Even that in that case drive does not really care about meta_list
pointer, this is the easiest way to fix that issue without introducing
changes in many places in the code just for 0 sized metadata case.

The same approach needs to be also done for pblk_get_sec_meta()
since we also cannot point to the same memory address in meta buffer
when we are using it for pblk recovery process

Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Tested-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index bc40b1381ff6..85e38ed62f85 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1388,12 +1388,15 @@ static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
 static inline struct pblk_sec_meta *pblk_get_meta(struct pblk *pblk,
 							 void *meta, int index)
 {
-	return meta + pblk->oob_meta_size * index;
+	return meta +
+	       max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
+	       * index;
 }
 
 static inline int pblk_dma_meta_size(struct pblk *pblk)
 {
-	return pblk->oob_meta_size * NVM_MAX_VLBA;
+	return max_t(int, sizeof(struct pblk_sec_meta), pblk->oob_meta_size)
+	       * NVM_MAX_VLBA;
 }
 
 static inline int pblk_is_oob_meta_supported(struct pblk *pblk)
-- 
2.17.1

