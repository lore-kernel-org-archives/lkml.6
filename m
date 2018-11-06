Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E57C46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B26B20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="wXFUZCho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B26B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbeKFW7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:59:03 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52303 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388399AbeKFW7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:59:03 -0500
Received: by mail-it1-f194.google.com with SMTP id t190-v6so12062903itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2I81Vy/QYABDh4xcEesSgnRV1G45mEQK0f/pFSOiyt0=;
        b=wXFUZChoukWVTsdsKwU4Ux6xId+xMR/Ny7DTkaDuIENqe+O0iYINOXjB1myzZV3diT
         ikSr0iBmBedcTV6UI/ZqN1rXkBznW+2nv6R1BP6PYsRtFG+1wLd8jHy9s2Ns5/bdLPOn
         +g4XWTRRQ1O3sKSU7K0/NMXOYWvnaymdtKS0CmUYrCQtxwrHMZNtKxsmbfQHtB9Pgwwv
         8l0pscStEUPJud8o66KHzQxJTSPYgiSmNAjRPYGvixAoIQWNTqbEvP2k7WF3jasAsJDT
         O5/DSMPSGMLNVjk8cv8+TWUGRszcJIi6V5XsTxzkAsYH5RHb1qPmlhuaEBbdqV9SNV1Q
         UMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2I81Vy/QYABDh4xcEesSgnRV1G45mEQK0f/pFSOiyt0=;
        b=OhBVOcvRyPq/n55IVoHtcOjWVeeg3JLMBqkueYYUFXn0OWhot0wos+Okjw7IQUzmQN
         824rUYJzyZKPSPr5rE5XMbpItLwVKuzdAcgz2wucqGYbGQ71jXuInUjMrZ4VosTXkFMZ
         8PdQc6JhNtTxiNBZjSJ3hXrOVEN0bhOO9Tyu4XHMJLB2rDEQIJY2ieh9YyWFI7D+eGZ7
         A5zvpAhAAs5DEaw1iLu36T+wu9YSYp2MtFkWBq85oma7HqtPSWCZcoZXsUvm8IfTBLHu
         0OJmNhh6CB0Des4riJAQrsJ/Rmo4PAn9f6I6XHy+QrecqnxxeAIusyPAa9b+UwiXrupW
         b4PQ==
X-Gm-Message-State: AGRZ1gKxHs0XtnLAQeqS2K1B7O0V3ESRRpDOxAc8Qd1ImNghlAIe2STq
        1GpMi6bb/tmNE0ECru5CxOFOCQ==
X-Google-Smtp-Source: AJdET5epKgrxR673IGTnDxeQF0wui91v6e8Hslifz5IHcjXNN14pWVEofEZIJHlmQAqGci1s4+E3fQ==
X-Received: by 2002:a24:8784:: with SMTP id f126-v6mr1908911ite.28.1541511227530;
        Tue, 06 Nov 2018 05:33:47 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u132-v6sm897282itb.21.2018.11.06.05.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:33:47 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 5/7] lightnvm: pblk: remove unused macro
Date:   Tue,  6 Nov 2018 14:33:28 +0100
Message-Id: <20181106133330.26570-6-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

ADDR_POOL_SIZE is not used anymore, so remove the define.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index f083130d9920..3219f335fce9 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -207,9 +207,6 @@ static int pblk_rwb_init(struct pblk *pblk)
 	return pblk_rb_init(&pblk->rwb, buffer_size, threshold, geo->csecs);
 }
 
-/* Minimum pages needed within a lun */
-#define ADDR_POOL_SIZE 64
-
 static int pblk_set_addrf_12(struct pblk *pblk, struct nvm_geo *geo,
 			     struct nvm_addrf_12 *dst)
 {
-- 
2.17.1

