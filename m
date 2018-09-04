Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A0FC4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786BF2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="qc/ZbqVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786BF2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeIDPCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:02:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42294 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeIDPCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:02:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id l5so2837577edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3K6HHHkVtwTQ7S8qBANmx7kdcYrXaaoxA/0xWXmuSo=;
        b=qc/ZbqVsVMoSsenMKrQV0HBtFKlsrlQIWC9nzaZi2A6wt235I7ixjX+Q6iphZbkduq
         4tIjOBGdTRRXfFSPeKcZM6z7FcGvieSD8inNTOfCaB4gtdeAjeJieRr3urVY210Nf7Sn
         HuFUtfMTEstVTaW6xAy89ktooll/vA05iFrJ6s8EZ3FylhccwruCKIYdcxCSanxCHk3F
         A6+tBad5ZPk9Hk9MJ+/xYyAeafFzw/tZ+vnV1oLI9zvHIVDqB0cTr4j5tU0S74t98N6g
         tmcXDUNwffH1gHr0IL4oXSakqxY5EjYlpB0g7lneGUsB2nPTtEKJfpJFaRxBvQnIId6J
         T0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3K6HHHkVtwTQ7S8qBANmx7kdcYrXaaoxA/0xWXmuSo=;
        b=ImcrE/c805zDpdQ8gYxkKT1ib00zvhh3SWOI8rUWYTvnxCsRPvUWFWJUlsup7UximN
         MhMTsgCson2Srgcjl09NfJBb2G9qMLEB9MvoXBZ5OWe+ap+CSPtMQpbH49IVmIhDErS6
         7AKrvZMqWVVTuP+X/eI/M4PiF/Thd1VkfHAhn1EyIK3Bc2ZWKt6dmiyqfWTPVSkZJCQB
         Zjz+TMnQDHuHfg1VmRcOvUNTfSp7ktNBKEPF6gMH+vMlVEruNgYEuNh2mkHOveU5THJm
         HfKpuCjEM+pkuPjvnluDzyK6TBo+QFO0X3b1WSpwz9F0diCLMN8IscwALMSqFY5wN3uW
         lktg==
X-Gm-Message-State: APzg51CpnzQPqVkPoz3NjhhlihkDNsUdsUXeLfklG5Ht248CfM7qrYVk
        ua928GVpAw3jy+UBt/w6iLkzxA==
X-Google-Smtp-Source: ANB0VdaPp1cZjhEWOzRMkVQXop5XLw24xW3ppemc2RTstsjSFp3TFnRzASExfNkT3L2c1rGCPYII8Q==
X-Received: by 2002:a50:a542:: with SMTP id z2-v6mr34616776edb.77.1536057497909;
        Tue, 04 Sep 2018 03:38:17 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id b44-v6sm11803477edd.93.2018.09.04.03.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:38:17 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH V3] lightnvm: pblk: fix mapping issue on failed writes
Date:   Tue,  4 Sep 2018 12:38:06 +0200
Message-Id: <1536057487-17267-2-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536057487-17267-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1536057487-17267-1-git-send-email-hans.ml.holmberg@owltronix.com>
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
	Renamed variable done->last in the helper function.

Changes in V3:
	Renamed the helper function to nvm_next_ppa_in_chk and changed
	the first parameter to type nvm_tgt_dev

 drivers/lightnvm/pblk-write.c | 12 +-----------
 include/linux/lightnvm.h      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 5e6df65d392c..9e8bf2076beb 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -106,8 +106,6 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 /* Map remaining sectors in chunk, starting from ppa */
 static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 {
-	struct nvm_tgt_dev *dev = pblk->dev;
-	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line *line;
 	struct ppa_addr map_ppa = *ppa;
 	u64 paddr;
@@ -125,15 +123,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
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
+		done = nvm_next_ppa_in_chk(pblk->dev, &map_ppa);
 	}
 
 	line->w_err_gc->has_write_err = 1;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 09f65c6c6676..36a84180c1e8 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -593,6 +593,42 @@ static inline u32 nvm_ppa64_to_ppa32(struct nvm_dev *dev,
 	return ppa32;
 }
 
+static inline int nvm_next_ppa_in_chk(struct nvm_tgt_dev *dev,
+				      struct ppa_addr *ppa)
+{
+	struct nvm_geo *geo = &dev->geo;
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

