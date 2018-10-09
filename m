Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADCBC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F220214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="bUIxXt4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F220214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJIS36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:29:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40718 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeJIS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:29:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so667644plv.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYVRZNNBiLGoGN7ee6jJBIiPOJAQ8oCo8VOfejch4uU=;
        b=bUIxXt4Nz+3DxXDiFwyHugI/mcQCkIzFhOAj3gLrGA6nGNDITCnTgQJjJ7DMFCD71M
         U5e8s4xN08HS/glgGE9tc0MgYF6QYoksFNM/U1yScZJbS+ikUuZUfakfbXDhe8uxKZ8P
         QcWFlaiVs4+bdeaTWNCS3xrfdK6v7qoxAPya/6TJKEp59u17LPjgioyffxwxitAsOVd5
         xhv4+oYv04L+7kJHM+1aeX+6sYtlTcv0XDDF7aBFCLztaX/azlEn47KVIpkivBP0unAd
         alZTV/AVe9oVyrf9h/qP0oxVxUrudXN39Mf2qXBXmgtdYS2j5n398Bh79Qp8g16rtCHJ
         CyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYVRZNNBiLGoGN7ee6jJBIiPOJAQ8oCo8VOfejch4uU=;
        b=c621XBy61YrKUqhD6JlLfq4P5cXaqWqUNESdzB1VKMVfQJiMnPaQou7h2Nc0Rywuu1
         gog7KD/JuYNAQ8xmefAQqEKvIr2XHezOoJXk9n3x+6WChHZ5sTL+VsUc9iS7XYyIiI7h
         MQwZTreucHCJIAOjjJvvFWDPXzVPTsSE35WdHVxrrJKRK/dCECCksqT8V3T3n+UQa1qE
         YiKL8CmVlgV0ChNc4V5XIEe+9VK6/haqOOcxQzQYer8lA1+Lj1JjfLElYPIWtjJw9MuL
         ZTRtHY4Bmkp/hRqX8c52vDHyQu8kr1J+Ia9zG2TFLSBep1STRgZmu/231BhINfEwlHo0
         YfKQ==
X-Gm-Message-State: ABuFfoienc71QoWZEPXKYv3kBeV5IKaHGsgGV9+iZIQ9CK8xNX1z0A5m
        W8AeIdqhHERi06rtSxv4oQiSVw==
X-Google-Smtp-Source: ACcGV61+LiSd0BrqhYVRAPHeLj4IrKx0XJOCpzRAcIR3gkII0nlUFJLFDSrFlZhaABudgrY0+sdbvw==
X-Received: by 2002:a17:902:5590:: with SMTP id g16-v6mr27914511pli.46.1539083610996;
        Tue, 09 Oct 2018 04:13:30 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:29 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 05/45] lightnvm: pblk: fix race condition on metadata I/O
Date:   Tue,  9 Oct 2018 13:11:35 +0200
Message-Id: <20181009111215.7653-6-mb@lightnvm.io>
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

In pblk, when a new line is allocated, metadata for the previously
written line is scheduled. This is done through a fixed memory region
that is shared through time and contexts across different lines and
therefore protected by a lock. Unfortunately, this lock is not properly
covering all the metadata used for sharing this memory regions,
resulting in a race condition.

This patch fixes this race condition by protecting this metadata
properly.

Fixes: dd2a43437337 ("lightnvm: pblk: sched. metadata on write thread")
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 508c63701eda..df99c45778d4 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -417,12 +417,11 @@ int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line)
 			rqd->ppa_list[i] = addr_to_gen_ppa(pblk, paddr, id);
 	}
 
+	spin_lock(&l_mg->close_lock);
 	emeta->mem += rq_len;
-	if (emeta->mem >= lm->emeta_len[0]) {
-		spin_lock(&l_mg->close_lock);
+	if (emeta->mem >= lm->emeta_len[0])
 		list_del(&meta_line->list);
-		spin_unlock(&l_mg->close_lock);
-	}
+	spin_unlock(&l_mg->close_lock);
 
 	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
 
@@ -491,14 +490,15 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
 	struct pblk_line *meta_line;
 
 	spin_lock(&l_mg->close_lock);
-retry:
 	if (list_empty(&l_mg->emeta_list)) {
 		spin_unlock(&l_mg->close_lock);
 		return NULL;
 	}
 	meta_line = list_first_entry(&l_mg->emeta_list, struct pblk_line, list);
-	if (meta_line->emeta->mem >= lm->emeta_len[0])
-		goto retry;
+	if (meta_line->emeta->mem >= lm->emeta_len[0]) {
+		spin_unlock(&l_mg->close_lock);
+		return NULL;
+	}
 	spin_unlock(&l_mg->close_lock);
 
 	if (!pblk_valid_meta_ppa(pblk, meta_line, data_rqd))
-- 
2.17.1

