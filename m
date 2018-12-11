Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752D7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403D12087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="lzOEtcYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403D12087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLKTRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:17:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44468 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLKTRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:17:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so13994476lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAAvZB5EbkafXfB/nQ8jKNvQ2dQs06mVyegUe1IKNXs=;
        b=lzOEtcYAkliKJkbxwBrdhYEMD+GTwp2RMPuopkhSqBjw4wEJpQCYlBgBF/lDitqViW
         /08yLQWhRdNLo4g3XqeQrciKXNP95mZcALPOG2CvMCDIthp6Knf9dIqKC39Rybu4MV4g
         pKoC0nuZ+VduwOqk5eO/jgFKue7E+Fse60QBN1rroTsirPC2y2q7LYQlUhwiid/1KE/f
         Qb3ztOYU7I5WK/pL4EYCwS2n18FuXYvpEWYWWrF1phL6UPX3l0Sr88/g9Cl9QBr3uZEI
         GyNWjfqnPEoAAFYXoPrBjLxuJZl6pLDtbpoeChbP6b1lQB4yLaHpADk2tEAKZPT45n+n
         +dWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAAvZB5EbkafXfB/nQ8jKNvQ2dQs06mVyegUe1IKNXs=;
        b=SHeTjnUzAsfQVmn/+yAvqAKShLjJs3dQ+6cmABOM7qZG5ee7ULqTtiDKOczTWHDnOq
         KEys1mLIGMVaKwfuHZaycEV5nBHIzxFzrU4AbPSEp5479JnERCyHjhgIaQKKgbAlpWy9
         e7rdYS6/A39mVvZfwRSSB5+v6qLLKZPB6UgWFpMe2qtKUrDdhdH8gMJW4L9c5qJEp5G9
         e/GN3+1T/AC5XwvQ7OJ/VQZxl76LwKOEGdbFWtzb8ZdY5Pa8bnMsOLOezNzbrnIMeIGz
         F/jnSemhkqA05pKz2QTlE03ymyTMBa6cawxrj/SeojjcyEBKCF/lxY60pIqDfNRBD8aA
         Kfvw==
X-Gm-Message-State: AA+aEWYwWLIlu77iPIK/jYp8L+0sgpczgzb6uAT9hm78zxGYfH9LcvNZ
        O51Jt0KxrO37Ac3T3lmyDfEnjMwga08=
X-Google-Smtp-Source: AFSGD/XDHUA/r76FNrnzaaEtoXbTWySAe7CO33Ssv7XIEK3Xe/KMdAcZSzA2DvPP+UK172BOCF1QdQ==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr10215088ljd.137.1544555820306;
        Tue, 11 Dec 2018 11:17:00 -0800 (PST)
Received: from skyninja.webspeed.dk (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id v64sm2764583lfa.48.2018.12.11.11.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:16:59 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhoujie Wu <zjwu@marvell.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 01/21] lightnvm: pblk: ignore the smeta oob area scan
Date:   Tue, 11 Dec 2018 20:16:07 +0100
Message-Id: <20181211191627.15542-2-mb@lightnvm.io>
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

From: Zhoujie Wu <zjwu@marvell.com>

The smeta area l2p mapping is empty, and actually the
recovery procedure only need to restore data sector's l2p
mapping. So ignore the smeta oob scan.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
Reviewed-by: Javier González <javier@javigon.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 5740b7509bd8..0fbd30e0a587 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -334,6 +334,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 			       struct pblk_recov_alloc p)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	struct pblk_line_meta *lm = &pblk->lm;
 	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr *ppa_list;
 	struct pblk_sec_meta *meta_list;
@@ -342,12 +343,12 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	void *data;
 	dma_addr_t dma_ppa_list, dma_meta_list;
 	__le64 *lba_list;
-	u64 paddr = 0;
+	u64 paddr = pblk_line_smeta_start(pblk, line) + lm->smeta_sec;
 	bool padded = false;
 	int rq_ppas, rq_len;
 	int i, j;
 	int ret;
-	u64 left_ppas = pblk_sec_in_open_line(pblk, line);
+	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
 
 	if (pblk_line_wp_is_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
-- 
2.17.1

