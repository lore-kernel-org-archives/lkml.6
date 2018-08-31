Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABFD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="dsFLGXCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABFD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeHaOGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:06:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39277 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbeHaOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:06:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id j201-v6so9520174lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Q+D9DpoUgHvS8lAMSAmBdr3zYbRMcOr6gx52NImDcVY=;
        b=dsFLGXCtW9tMcZowWquUtli6OkNWNyJC0s+RMPzTo0xf/UeCyt1aIr0PF0Ufa653Zs
         TEOJhyc3BTWyzXvjbF93gYsgYDD8XbdIp0kR8+0x2aSoxivOEi6ZQFZ4/mDYho4bDl2I
         K/CeoAxpqWSnIfLNSN8k/iu8la3sa4RvrxgMOAQssdTqIA8LZ44chgz0ZHiKLXzIxGAz
         ZW5MvbPyEt2lWd3N1hhk0Ksh4mAxrAFuHa0sk9PaMcXtfNEzJpOqfW8EwEqt1z3PMttn
         y75tdU3dvB+/jDhAPMf7t1HzFiClB2rV6CBBQVU2v9AvgwchqJHdLt/2Y3gyGzJAkyk2
         UhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q+D9DpoUgHvS8lAMSAmBdr3zYbRMcOr6gx52NImDcVY=;
        b=tAaeo8BSf+m2GOjY5UIZgHLegR1E0JVsWHdIyYkHiz1rVo5FohKGAwdKibZoE+pogT
         8Qfl2ua39udyTXDx/h296Lv+jzDQOOrhZW4YlfplY4bjavKPkSPNy/zbbln67nI1/WqB
         VmBz5QDxWt+HzoeFrMUbxS/Nz0T7YUYFPsmq0ODZnwjUkTTki+PzB1BRdZaF3I6SS2D9
         8iaCylJRW8O0hOd1orv5h4BeceLCypOM1Fa1oUcbWtYaFriQoXnfRSnJ7g6tsPhirMHY
         gordXTna8/phCiiptbbD8gKs30CzmKjWpye21MTAJ59g9zep0uFrvhqBEJTAwiLoF4jd
         Lu0Q==
X-Gm-Message-State: APzg51Bte4jnuEfDwZO5hmDL0B+8/KziNBvv4aUiR3gyS5C/Ot2K6JpP
        2ZERD1kDU8BzGADw4NqhEP/Xyw==
X-Google-Smtp-Source: ANB0VdbDiC6Evk/4ibVTROpeGQ4yLZ0K2EPYssFcd8xnIUwuzrLaeWmarHEo9iB3UbdS1AS35wVXlg==
X-Received: by 2002:a19:f83:: with SMTP id 3-v6mr9782204lfp.131.1535709595909;
        Fri, 31 Aug 2018 02:59:55 -0700 (PDT)
Received: from titan.bredbandsbolaget.se (c-adb2e655.03-91-6d6c6d4.bbcust.telenor.se. [85.230.178.173])
        by smtp.gmail.com with ESMTPSA id l141-v6sm1764715lfg.55.2018.08.31.02.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 02:59:55 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: fix mapping issue on failed writes
Date:   Fri, 31 Aug 2018 11:59:29 +0200
Message-Id: <1535709570-8923-1-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

On 1.2-devices, the mapping-out of remaning sectors in the
failed-write's block can result in an infinite loop,
stalling the write pipeline, fix this.

Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

Changes in V2:
	Moved the helper function pblk_next_ppa_in_blk to lightnvm core
	Renamed variable done->last in the helper function
	

 drivers/lightnvm/pblk-write.c | 10 +---------
 include/linux/lightnvm.h      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 5e6df65d392c..922506d2d0a6 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -125,15 +125,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 		if (!test_and_set_bit(paddr, line->invalid_bitmap))
 			le32_add_cpu(line->vsc, -1);
 
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			map_ppa.ppa++;
-			if (map_ppa.g.pg == geo->num_pg)
-				done = 1;
-		} else {
-			map_ppa.m.sec++;
-			if (map_ppa.m.sec == geo->clba)
-				done = 1;
-		}
+		done = nvm_next_ppa_in_blk(geo, &map_ppa);
 	}
 
 	line->w_err_gc->has_write_err = 1;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 09f65c6c6676..2a6cbfe1d1b4 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -593,6 +593,40 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
 	return ppa32;
 }
 
+static inline int nvm_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *ppa)
+{
+	int last = 0;
+
+	if (geo->version == NVM_OCSSD_SPEC_12) {
+		int sec = ppa->g.sec;
+
+		sec++;
+		if (sec == geo->ws_min) {
+			int pg = ppa->g.pg;
+
+			sec = 0;
+			pg++;
+			if (pg == geo->num_pg) {
+				int pl = ppa->g.pl;
+
+				pg = 0;
+				pl++;
+				if (pl == geo->num_pln)
+					last = 1;
+
+				ppa->g.pl = pl;
+			}
+			ppa->g.pg = pg;
+		}
+		ppa->g.sec = sec;
+	} else {
+		ppa->m.sec++;
+		if (ppa->m.sec == geo->clba)
+			last = 1;
+	}
+
+	return last;
+}
 
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
-- 
2.7.4

