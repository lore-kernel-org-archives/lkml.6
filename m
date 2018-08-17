Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC01C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB32A21565
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="JXdXzh8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB32A21565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeHQNZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:25:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45669 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeHQNZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:25:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so4248153edq.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVfKH5fxvtMI2nn+wFotQVSEFmCc6QzAd/OwPbB5mRw=;
        b=JXdXzh8BY0BBYk/N95Ue2lFimLeZbiZtnJhSYmgiqG1RK+gd4TDjOAfJ3v88QfKZR9
         dKJKVxx4xbqvt4gpGwlnTvVG0shMGNrP7yRIM4kl8BoBUdHCSdhifETV/q/jaF/3cavQ
         JtEhBGuC2QC3Csv/GRRVkLYGB8ZARIpAo1dOWG0fYO5iYDHJM7OKmZKuqEOxGr0S6enl
         QPZ+aD5t0pu1GH4d1GKmf+tJUc7wSwCChDrqqxjjprkmeH+b0xu/Wha48q4fbEuaX5FO
         nHidHosrb+ewj8TpsiYyVkinaO/ffPcogmRCfCPqXGjaEhS5n6+cl2BOzbhX4QedHnZ1
         Z0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVfKH5fxvtMI2nn+wFotQVSEFmCc6QzAd/OwPbB5mRw=;
        b=KbcXNXQ3gsjRFiwOHDbUiXNk4lGm/MuCoAsySyiUqTZ1ZQbVdSkpMobuxChtIczmw/
         PnIvlT0/FVmVkDIRjcsIYHRmyFMyDUNZXdng9IRSnXqprEzSYBTHqDl09YwJciSnKV5x
         L98nSONKVtP6LxwtXijwOlMJjOU5ChPw30o4k3XnL6a1xYj98tGkzl6u4nHO18yC1XKi
         /reBD+BVY75EsN0JT1Xr/FEd4WaeurWr19wxF4Q2MRA0zj3QqSjFBYEmnuSuxXQxUacS
         89Phqm0PzWyIvMBkO8KKcn0hF7LLCnHrdY59QohS+euXefJcJPWhA4pTbDYAmq7cyoAq
         oK3Q==
X-Gm-Message-State: AOUpUlG/r1zOgkDFxtQBlKtF03QfwC10lzLW0PkQ4J+C/ltcz+42OYAt
        4W1ZPyIlTA8eOtT8d1XpXlBwKg==
X-Google-Smtp-Source: AA+uWPyC8zB7npyLzfk7pvWueOlYH2QW4gUan7PivalZYCETiqS6A8z7HLtq8hJ2moDitj2j7oIFUg==
X-Received: by 2002:a50:c082:: with SMTP id k2-v6mr40353218edf.294.1534501335088;
        Fri, 17 Aug 2018 03:22:15 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id q26-v6sm2217865eda.35.2018.08.17.03.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 03:22:14 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: fix race condition on metadata I/O
Date:   Fri, 17 Aug 2018 12:22:04 +0200
Message-Id: <1534501324-13693-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pblk, when a new line is allocated, metadata for the previously
written line is scheduled. This is done through a fixed memory region
that is shared through time and contexts across different lines and
therefore protected by a lock. Unfortunately, this lock is not properly
covering all the metadata used for sharing this memory regions,
resulting on a race condition.

This patch fixes this race condition by protecting this metadata
properly.

Fixes: dd2a43437337 ("lightnvm: pblk: sched. metadata on write thread")

Signed-off-by: Javier González <javier@cnexlabs.com>
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
2.7.4

