Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEE3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7539B218EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 10:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FQ4QOyVq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7539B218EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeHQNWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 09:22:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44995 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeHQNWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 09:22:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so4240887edr.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLQ/UONVMbnI6JksHfyf/kkysaceowTp3RRvI4Telas=;
        b=FQ4QOyVqm9e1KsLNvNknaA/DeDS5lJEWAFHGvrbBcV+8S0J6wJOYMsJvIfklEqRN/V
         Ynfz9f/cLpF225EB7oqgGLemMblVOiqf/lGHoF35ErpBJMtQ073RxZM2tsBqN8gqXPwP
         IveZ0DIScfX3LRDkVL7etebMlyNcvyTnNBdDkUoT+itV8NSjM6deZ38/NmtVGFzbd1CI
         TkgszhTAapMBhIGuYwLQM5bFxAfxOgkGKS7FKoYdKoTKHMXWw1wtRemIQBNgrPmOcfgy
         0Kt2mgppUo5tnG2T1mUInXC7TY+5quBhA/8YbaOSfa33/fmjKd46BxCB9E28pFmtoL9C
         9CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLQ/UONVMbnI6JksHfyf/kkysaceowTp3RRvI4Telas=;
        b=Nk0wWnNnRqfoiQq4EUGrJ4aFlAAX5k9kCweOqBZ1Zbi3nC1HQjBcM2H36LAF/M9M/2
         cBjpOQKPBc82z+oO2F7r3i4Ylk6Y81tAzmfL1fC+cldoCo11qMwvhA13DbJNa7whUaxD
         Abk4Q5RPglVMmP8GGnQNLInFtAmNsKHZTmP3KV0CuIxwY6QlxwveuGsQJ4Fy+/7kAb3O
         X61pGCgia2hyYIvAPhjsztS+5dNqs9b4mBe7gWnzHGBbp3bHwb6wpjYx0uk7FE37hZxd
         sTkJYvDb/Zanw64/2M3fVOwPcPGV2obfnfvdhiP3NpySfLcdIm5sL+NgYSHSO415X5BE
         yznA==
X-Gm-Message-State: AOUpUlHY59hmMLg3sQNo0vivYogtn1eSA+dTteZt4C42DgUrE7qOS3Br
        DOHw3snXpM2r9tEaiNmctwZ/PA==
X-Google-Smtp-Source: AA+uWPzrBLEMno1nj/5kZHS7DhHdgu8BCFYsdT6Ehjtvl5s3OpB8K/TK4278GHiXjcqoF9MQvwgw3Q==
X-Received: by 2002:a50:b764:: with SMTP id g91-v6mr42984361ede.187.1534501165530;
        Fri, 17 Aug 2018 03:19:25 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id v26-v6sm1442563eds.43.2018.08.17.03.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 03:19:25 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 2/2] lightnvm: pblk: take write semaphore on metadata
Date:   Fri, 17 Aug 2018 12:19:10 +0200
Message-Id: <1534501150-11906-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534501150-11906-1-git-send-email-javier@cnexlabs.com>
References: <1534501150-11906-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pblk guarantees write ordering at a chunk level through a per open chunk
semaphore. At this point, since we only have an open I/O stream for both
user and GC data, the semaphore is per parallel unit.

For the metadata I/O that is synchronous, the semaphore is not needed as
ordering is guaranteed. However, if the metadata scheme changes or
multiple streams are open, this guarantee might not be preserved.

This patch makes sure that all writes go through the semaphore, even for
synchronous I/O. This is consistent with pblk's write I/O model. It also
simplifies maintenance since changes in the metadata scheme could cause
ordering issues.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 52306573cc0e..eac5bd551860 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -493,6 +493,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io_sync(dev, rqd);
 }
 
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int ret;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
+	ret = pblk_submit_io_sync(pblk, rqd);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+
+	return ret;
+}
+
 static void pblk_bio_map_addr_endio(struct bio *bio)
 {
 	bio_put(bio);
@@ -731,7 +745,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 		meta_list[i].lba = lba_list[paddr] = addr_empty;
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
-- 
2.7.4

