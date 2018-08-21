Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001ACC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6077214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 11:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="VC/3dEWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6077214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeHUPEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:04:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35573 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeHUPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:04:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so14063281ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQz+pJENNVIdSe/xDXZSzhu/OA0ZONBSglbwT5nB4TU=;
        b=VC/3dEWhj7xGo4axQa1elHxIX6gJiy3a9bK4M3dtNtKl5M+T9m8KGZKPCy1cy4PDXo
         7yAcNgYaxHzIlhM4OJk3jmhqmMC2SG23xByFLeEMNzx46Rb9gcn7MEjLm+cLZH4DML2v
         qRcKILllzAcsYc/gxPtzgZgy1zjke90twkdb5v51BwgXo9rR4bDnDkvEYQO4mfxI5e9L
         CwwnwaQ/PMtD5nWq3DV8fMtYz7GYyaMaHWRVc3JVpG+h6ACIc7RPxl0ND5g3Kb0Q+tWs
         V7C7nUhAgVXSuPXN5nseigkxWQ7UUAJbZ3b1wOPGqe2+K180YiJKUvM/x3RjBIEOx0ab
         1GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LQz+pJENNVIdSe/xDXZSzhu/OA0ZONBSglbwT5nB4TU=;
        b=Wn+VWt2Q/bMzFp2piPXR4QtTvyLcGnj26T4k7jDI4D8H4wLDJ0r+Fv1iKkWV8I/TR9
         +hSL4q6JDR1lx3gICHcVEBHDkqPLA0quRvZnAeb2MPg/PnDkGlxmenHgwBrbhXM93zeu
         14mp5d/ATN2HUEg/CzsIuDdb0HcHOJySqIA/YNbSJLQ/huojfQvXnL6gjDtSq91zkMrB
         WfykXD0KPkHwAQe2/N94z8vZUbydIDfnnTWokIoXPP5F1fG4D5P6TT1wpyYi+Ys1Vlck
         iFSA6pbEf+7L/avrepZ8GvdySlp0SmDH9947f/Jz+KPheLqdUsgr9AW+zqqM9qUZ8CPU
         GJVg==
X-Gm-Message-State: AOUpUlHV4WQHnInH8dRJqadUVVUEuPRP/7JHOjqfBtR0WdDZDa8rM0gb
        1oERFiZ+ziTwTcAVtbI7MgrXjw==
X-Google-Smtp-Source: AA+uWPw8G41KMSGzv9gLbGKC4K/ES/m/YJfgQXYPlrSmBXm6He5BciZ79vNM72hSasV7AIJJPK5bQQ==
X-Received: by 2002:a2e:380d:: with SMTP id f13-v6mr35877095lja.74.1534851889489;
        Tue, 21 Aug 2018 04:44:49 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id b15-v6sm1596283lfg.18.2018.08.21.04.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 04:44:48 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH v2] lightnvm: pblk: refactor put line fn on read completion
Date:   Tue, 21 Aug 2018 13:44:41 +0200
Message-Id: <20180821114441.23147-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The read completion path uses the put_line variable to decide whether
the reference on a line should be released. The function name used for
that is pblk_read_put_rqd_kref, which could lead one to believe that it
is the rqd that is releasing the reference, while it is the line
reference that is put.

Rename and also split the function in two to account for either rqd or
single ppa callers and move it to core, such that it later can be used
in the write path as well.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Reviewed-by: Javier González <javier@cnexlabs.com>
Reviewed-by: Heiner Litz <hlitz@ucsc.edu>

Changes since v1:

  Moved into core for Heiner to later integrate with his RAIL
  patches.
---
 drivers/lightnvm/pblk-core.c | 19 +++++++++++++++++++
 drivers/lightnvm/pblk-read.c | 18 +-----------------
 drivers/lightnvm/pblk.h      |  2 ++
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index e0b513d07e14..5f99cf396072 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1426,6 +1426,25 @@ struct pblk_line *pblk_line_get_first_data(struct pblk *pblk)
 	return line;
 }
 
+void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
+{
+	struct pblk_line *line;
+
+	line = &pblk->lines[pblk_ppa_to_line(ppa)];
+	kref_put(&line->ref, pblk_line_put_wq);
+}
+
+void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int i;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	for (i = 0; i < rqd->nr_ppas; i++)
+		pblk_ppa_to_line_put(pblk, ppa_list[i]);
+}
+
 static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
 {
 	lockdep_assert_held(&pblk->l_mg.free_lock);
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index 1ad501721d0f..dc8233f3fd6c 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -165,22 +165,6 @@ static void pblk_read_check_rand(struct pblk *pblk, struct nvm_rq *rqd,
 	WARN_ONCE(j != rqd->nr_ppas, "pblk: corrupted random request\n");
 }
 
-static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd)
-{
-	struct ppa_addr *ppa_list;
-	int i;
-
-	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
-
-	for (i = 0; i < rqd->nr_ppas; i++) {
-		struct ppa_addr ppa = ppa_list[i];
-		struct pblk_line *line;
-
-		line = &pblk->lines[pblk_ppa_to_line(ppa)];
-		kref_put(&line->ref, pblk_line_put_wq);
-	}
-}
-
 static void pblk_end_user_read(struct bio *bio)
 {
 #ifdef CONFIG_NVM_PBLK_DEBUG
@@ -208,7 +192,7 @@ static void __pblk_end_io_read(struct pblk *pblk, struct nvm_rq *rqd,
 		bio_put(int_bio);
 
 	if (put_line)
-		pblk_read_put_rqd_kref(pblk, rqd);
+		pblk_rq_to_line_put(pblk, rqd);
 
 #ifdef CONFIG_NVM_PBLK_DEBUG
 	atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 64ae0c7ed3bb..be67bbfa3d0a 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -787,6 +787,8 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 struct pblk_line *pblk_line_get(struct pblk *pblk);
 struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
 struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
+void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa);
+void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
 struct pblk_line *pblk_line_get_data(struct pblk *pblk);
-- 
2.11.0

