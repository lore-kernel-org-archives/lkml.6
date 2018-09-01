Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16583C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89E620841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJSXfdTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89E620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeIAQFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:05:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36736 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIAQFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:05:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id e11-v6so6632201plb.3;
        Sat, 01 Sep 2018 04:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IWiPvKQSdfz/cocXP+iDE5523lfsqoaXSAQHXVKKEnw=;
        b=XJSXfdTgPeowQOME785lO5OL7PIcaVLnpSufnnYxl126DVJXBxXtUf6NMzhZ1nbHb4
         8Amr11c+kH3SqndpaWjgtt0rfRJsXMwrYnCH2xQM8oKlUBH+IFkutku0xidwc/V+Dg3F
         WMvViArSFllNrs1ui89FjhreCnl+c9I7MEbM7Y2+JYUZA2b4zG3xktk5I5xKKcvdJnJZ
         OzA02xdM3cM2/szBTpv2RsOnC+UNAYEbeecZxCCIkgrJtSfSvj9t85kUPpoo6A1RZbO/
         r+72351FGUAYFVjdn3zBmPlJlVMg11OpEQBnWznIP1wsl62NJCYgNufooY9lTt8G0Lfw
         pOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IWiPvKQSdfz/cocXP+iDE5523lfsqoaXSAQHXVKKEnw=;
        b=pnH1Zh8Zb+bMoFdIu3irfo7LDkV+yTF4JmcHE3hl8wx4cQScSAI6WMAa+tmYychL/F
         j/RgNeS6kFe9+mImHDobo/UYIBmyETcg1Wr+Xe6o1DNJMdpxz+EPivPPG9IRiQ/H5sOh
         Ot+TvLcrB5zVNetLi3jXLePv0c6wzF8XCiQ2i4IZiRll/sFpdPuRDSbFGbHFMWTChAOI
         N2folB4mjpbP9CHZ2/yw9h0Nm13aS4/vntGS+AE2F2aDIVSDw+c8E4XQA3JoSM/S/2mg
         mWR1kFuGzx1nMhtlVTzpLqPGNCsUIUKXIrVkcI3BtJ/s8BzX2Qtm9OxT1mDSJpUNXEDZ
         k08A==
X-Gm-Message-State: APzg51DyMFbPJ2+e26pO0xWScqY260l8we2az5AKFuDXWCkwKZsnHpK1
        4i5VAGHda4z9XgfiSgktVRU=
X-Google-Smtp-Source: ANB0VdZvLkZGPLywsRS30qo8EfP1BkQolsv1mM5SYpblP7ZJzAzw0KspneS4jry9WpdGj4jhgV0ZsA==
X-Received: by 2002:a17:902:6684:: with SMTP id e4-v6mr16036198plk.50.1535802805331;
        Sat, 01 Sep 2018 04:53:25 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id w69-v6sm25114914pgd.37.2018.09.01.04.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 04:53:24 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in pblk_line_submit_smeta_io()
Date:   Sat,  1 Sep 2018 19:53:18 +0800
Message-Id: <20180901115318.30416-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/lightnvm/pblk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index ed9cc977c8b3..5d915c93b6cf 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 
 	memset(&rqd, 0, sizeof(struct nvm_rq));
 
-	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
+	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_ATOMIC,
 							&rqd.dma_meta_list);
 	if (!rqd.meta_list)
 		return -ENOMEM;
@@ -810,7 +810,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
 	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
 
-	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
+	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_ATOMIC);
 	if (IS_ERR(bio)) {
 		ret = PTR_ERR(bio);
 		goto free_ppa_list;
-- 
2.17.0

