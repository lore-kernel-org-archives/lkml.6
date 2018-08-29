Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DAFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D38520867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0dcYBmMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D38520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeH2SJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:09:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40819 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeH2SJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:09:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so4038064edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHb2Fj4c/EKcT5PWsDuwpEQ5t+ICfBbEQ7K89qCIqUQ=;
        b=0dcYBmMri24XX0YcZ0Lgf7+6An4icqrwMI51VmXsRvH6J5WM+wl4i+SEI2r+g+4nfJ
         c/fGU39LkafxSP1jCLbyJap219B1gC/Ad62rA3BOFroCGXE8UcoGu4JlYfr39k9RMz7B
         upojuP2QO9EBre3s1nrmJbo5B7v6RJ4ccPMYPf4LyyS5DReLN44RAvnTGSXFk/rrH/w/
         xTpvIVFECGSefiCGBVgxvBUBqtS+8+EleY+oyGgZGArIED2QqHaD1tad8QbBMrkerj4R
         9TuJlmvsEHCUon96oGYw8FZo4K8RH9gsZQHOAm7DybZd+6xAj7IUozK9wp6d8VE8pzPz
         V5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHb2Fj4c/EKcT5PWsDuwpEQ5t+ICfBbEQ7K89qCIqUQ=;
        b=aubOs4/Fp/ePpIuckgA2lrPvjUtfed6PeojkvYFiG3rssI9d4LekfMfezvUEeyv+Wd
         m5BqfLdO5DNyCyqPw2WScZDECRQq+B7oLunNXR1icATPEvFk2MR5+viivir8+/VwgKYU
         AdCk5JGayf7TCB8WIigAfvCqwu6AxbKntLcaKU+zQRdOOAgfmW2wzxK2FXpXR+OxvpZh
         w+n7bdn4rteIATaUyOjvsIv6OQygV2s0nxeNUuTJDtFSFIGE9Mq+XXpJ0w9TkFoAXTE6
         9+s2ajU1iuTq6QL9KykNNCQewwe97M8yXWdWyLDyEy/uW4eSjxb9VpOux4djha+alA9O
         /JxQ==
X-Gm-Message-State: APzg51D8QwDL7E8Nj/6FpDCB9SKutcIOs9jKrXSzdoFdqoyteh8mrzpo
        BBMszi7M2QTlhNy7JFu5HIwEuw==
X-Google-Smtp-Source: ANB0VdYErwjMD6NnKftpRVLjOgugO9i9ZtaEaSJ+bbEP+auMw0+QeiKbl55/ptZMvocM6tN/ZbwLlg==
X-Received: by 2002:aa7:c1ce:: with SMTP id d14-v6mr7953188edp.262.1535551954802;
        Wed, 29 Aug 2018 07:12:34 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id p28-v6sm3359554eda.85.2018.08.29.07.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 07:12:34 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: move ppa transformations to core
Date:   Wed, 29 Aug 2018 16:12:06 +0200
Message-Id: <1535551926-4731-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing the effort of moving 1.2 and 2.0 specific code to core, move
64_to_32 and 32_to_64 ppa helpers from pblk to core.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk.h  | 78 +++------------------------------------------
 include/linux/lightnvm.h | 83 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index f95fe75fef6e..88ff529290f8 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1086,86 +1086,16 @@ static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 
 static inline struct ppa_addr pblk_ppa32_to_ppa64(struct pblk *pblk, u32 ppa32)
 {
-	struct ppa_addr ppa64;
+	struct nvm_tgt_dev *dev = pblk->dev;
 
-	ppa64.ppa = 0;
-
-	if (ppa32 == -1) {
-		ppa64.ppa = ADDR_EMPTY;
-	} else if (ppa32 & (1U << 31)) {
-		ppa64.c.line = ppa32 & ((~0U) >> 1);
-		ppa64.c.is_cached = 1;
-	} else {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			struct nvm_addrf_12 *ppaf =
-					(struct nvm_addrf_12 *)&pblk->addrf;
-
-			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
-							ppaf->ch_offset;
-			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
-							ppaf->lun_offset;
-			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
-							ppaf->blk_offset;
-			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
-							ppaf->pg_offset;
-			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
-							ppaf->pln_offset;
-			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
-							ppaf->sec_offset;
-		} else {
-			struct nvm_addrf *lbaf = &pblk->addrf;
-
-			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
-							lbaf->ch_offset;
-			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
-							lbaf->lun_offset;
-			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
-							lbaf->chk_offset;
-			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
-							lbaf->sec_offset;
-		}
-	}
-
-	return ppa64;
+	return ppa32_to_ppa64(dev->parent, &pblk->addrf, ppa32);
 }
 
 static inline u32 pblk_ppa64_to_ppa32(struct pblk *pblk, struct ppa_addr ppa64)
 {
-	u32 ppa32 = 0;
+	struct nvm_tgt_dev *dev = pblk->dev;
 
-	if (ppa64.ppa == ADDR_EMPTY) {
-		ppa32 = ~0U;
-	} else if (ppa64.c.is_cached) {
-		ppa32 |= ppa64.c.line;
-		ppa32 |= 1U << 31;
-	} else {
-		struct nvm_tgt_dev *dev = pblk->dev;
-		struct nvm_geo *geo = &dev->geo;
-
-		if (geo->version == NVM_OCSSD_SPEC_12) {
-			struct nvm_addrf_12 *ppaf =
-					(struct nvm_addrf_12 *)&pblk->addrf;
-
-			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
-			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
-			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
-			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
-			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
-			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
-		} else {
-			struct nvm_addrf *lbaf = &pblk->addrf;
-
-			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
-			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
-			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
-			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
-		}
-	}
-
-	return ppa32;
+	return ppa64_to_ppa32(dev->parent, &pblk->addrf, ppa64);
 }
 
 static inline struct ppa_addr pblk_trans_map_get(struct pblk *pblk,
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 77743a02ec0d..7107a8b84039 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -506,6 +506,89 @@ static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
 	return caddr;
 }
 
+static inline struct ppa_addr ppa32_to_ppa64(struct nvm_dev *dev,
+					     void *addrf, u32 ppa32)
+{
+	struct ppa_addr ppa64;
+
+	ppa64.ppa = 0;
+
+	if (ppa32 == -1) {
+		ppa64.ppa = ADDR_EMPTY;
+	} else if (ppa32 & (1U << 31)) {
+		ppa64.c.line = ppa32 & ((~0U) >> 1);
+		ppa64.c.is_cached = 1;
+	} else {
+		struct nvm_geo *geo = &dev->geo;
+
+		if (geo->version == NVM_OCSSD_SPEC_12) {
+			struct nvm_addrf_12 *ppaf = addrf;
+
+			ppa64.g.ch = (ppa32 & ppaf->ch_mask) >>
+							ppaf->ch_offset;
+			ppa64.g.lun = (ppa32 & ppaf->lun_mask) >>
+							ppaf->lun_offset;
+			ppa64.g.blk = (ppa32 & ppaf->blk_mask) >>
+							ppaf->blk_offset;
+			ppa64.g.pg = (ppa32 & ppaf->pg_mask) >>
+							ppaf->pg_offset;
+			ppa64.g.pl = (ppa32 & ppaf->pln_mask) >>
+							ppaf->pln_offset;
+			ppa64.g.sec = (ppa32 & ppaf->sec_mask) >>
+							ppaf->sec_offset;
+		} else {
+			struct nvm_addrf *lbaf = addrf;
+
+			ppa64.m.grp = (ppa32 & lbaf->ch_mask) >>
+							lbaf->ch_offset;
+			ppa64.m.pu = (ppa32 & lbaf->lun_mask) >>
+							lbaf->lun_offset;
+			ppa64.m.chk = (ppa32 & lbaf->chk_mask) >>
+							lbaf->chk_offset;
+			ppa64.m.sec = (ppa32 & lbaf->sec_mask) >>
+							lbaf->sec_offset;
+		}
+	}
+
+	return ppa64;
+}
+
+static inline u32 ppa64_to_ppa32(struct nvm_dev *dev,
+				 void *addrf, struct ppa_addr ppa64)
+{
+	u32 ppa32 = 0;
+
+	if (ppa64.ppa == ADDR_EMPTY) {
+		ppa32 = ~0U;
+	} else if (ppa64.c.is_cached) {
+		ppa32 |= ppa64.c.line;
+		ppa32 |= 1U << 31;
+	} else {
+		struct nvm_geo *geo = &dev->geo;
+
+		if (geo->version == NVM_OCSSD_SPEC_12) {
+			struct nvm_addrf_12 *ppaf = addrf;
+
+			ppa32 |= ppa64.g.ch << ppaf->ch_offset;
+			ppa32 |= ppa64.g.lun << ppaf->lun_offset;
+			ppa32 |= ppa64.g.blk << ppaf->blk_offset;
+			ppa32 |= ppa64.g.pg << ppaf->pg_offset;
+			ppa32 |= ppa64.g.pl << ppaf->pln_offset;
+			ppa32 |= ppa64.g.sec << ppaf->sec_offset;
+		} else {
+			struct nvm_addrf *lbaf = addrf;
+
+			ppa32 |= ppa64.m.grp << lbaf->ch_offset;
+			ppa32 |= ppa64.m.pu << lbaf->lun_offset;
+			ppa32 |= ppa64.m.chk << lbaf->chk_offset;
+			ppa32 |= ppa64.m.sec << lbaf->sec_offset;
+		}
+	}
+
+	return ppa32;
+}
+
+
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.7.4

