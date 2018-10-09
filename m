Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C54C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE92214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IYvhoLaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE92214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeJISaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46360 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeJISaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id v5-v6so654898plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vBmseQYpd6ClG24uD0LYJiRIgM5ORPJ3WfMiUc0Ungk=;
        b=IYvhoLaLXXZfoMbdrAG46zofcFtvXYMU4FftjuYoDo9EjOxRkSCZarc4C5qOJMw/WT
         gE8o2wr76VEzScs+NsHZfz5dnc57aJsXINnemnUlcQZTF2QlakjigOPLQiVHVoVnKos9
         UssMbMwq0qb5iwt2Ic7tvNYk8D0UQlWzjrK4YiOIUFPlMkWig+zyCOvGSi1FD2+t9Xd1
         JxPZTcQJp076oMLhNXfuYiCMuDvUZxRDVG2g6D1oGimBH488zc7iarNHNk2ryP+e0Q+d
         Pmiqu06dByDIQfNlT5vxhPJQ+1n/n1ELcDR7iTAm5kCe1IKTK0bd2+XQvcYRDHdN0PhU
         kDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vBmseQYpd6ClG24uD0LYJiRIgM5ORPJ3WfMiUc0Ungk=;
        b=U6Dvb8DyL/BINoLtqtCM4nlevdqLQjvwTGDa0I9OjQHt7ZfR4winGCDMosCddLCv2R
         m+uhRS8K0OQ2RKaqiBEasKFwddNdcSbcFB60baQmtX9CWVFQ9wqhxKYQH0kTz3xyxCFQ
         Xw6WOMfa2HgHUytxXD3tHfK6ohFbmWE4mbv4RpSZ+Id0gb4rbqFJf04UGXGQsfFXZ9Gs
         PGq1LznQJr/+yBOMkbXKgbtyY9Io/JhiFUwSygnuO1ZTpq6a1lgV0PBzbvEMUaW2P3Ac
         WH4/AaT68n8zBtsv6KoH9bw9be+dDvXdrOSS1DT0lNQLq0O9nrvHGa4sTkYB2baxxCn+
         xyyw==
X-Gm-Message-State: ABuFfogl28vvnX/C9zaAdcZ1N+3WhKhuJEswzA8vKGjnILW1O36ChdxL
        qdr7c0T8YGddkzvCkk1q3Pzzjg==
X-Google-Smtp-Source: ACcGV63IPp/K2DByQ/PBmkgkOA4yPYyniqH5tYSaARz9Y3SMnbUiDdSSScuXftGdejZKRUSeajVX+g==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4-v6mr28533559plo.188.1539083630339;
        Tue, 09 Oct 2018 04:13:50 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:49 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 11/45] lightnvm: pblk: add helpers for chunk addresses
Date:   Tue,  9 Oct 2018 13:11:41 +0200
Message-Id: <20181009111215.7653-12-mb@lightnvm.io>
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

Implement helpers to go from ppas to a chunk within a line and an
address within a chunk.

These helpers will be used on the patches adding trace support in pblk,
which will be sent in this window.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk.h  | 19 +++++++++++++++++++
 include/linux/lightnvm.h | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index be67bbfa3d0a..f95fe75fef6e 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1034,6 +1034,25 @@ static inline struct ppa_addr addr_to_gen_ppa(struct pblk *pblk, u64 paddr,
 	return ppa;
 }
 
+static inline struct nvm_chk_meta *pblk_dev_ppa_to_chunk(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+	struct nvm_geo *geo = &dev->geo;
+	struct pblk_line *line = &pblk->lines[pblk_ppa_to_line(p)];
+	int pos = pblk_ppa_to_pos(geo, p);
+
+	return &line->chks[pos];
+}
+
+static inline u64 pblk_dev_ppa_to_chunk_addr(struct pblk *pblk,
+							struct ppa_addr p)
+{
+	struct nvm_tgt_dev *dev = pblk->dev;
+
+	return dev_to_chunk_addr(dev->parent, &pblk->addrf, p);
+}
+
 static inline u64 pblk_dev_ppa_to_line_addr(struct pblk *pblk,
 							struct ppa_addr p)
 {
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 0106984400bc..77743a02ec0d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -487,6 +487,25 @@ static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 	return l;
 }
 
+static inline u64 dev_to_chunk_addr(struct nvm_dev *dev, void *addrf,
+				    struct ppa_addr p)
+{
+	struct nvm_geo *geo = &dev->geo;
+	u64 caddr;
+
+	if (geo->version == NVM_OCSSD_SPEC_12) {
+		struct nvm_addrf_12 *ppaf = (struct nvm_addrf_12 *)addrf;
+
+		caddr = (u64)p.g.pg << ppaf->pg_offset;
+		caddr |= (u64)p.g.pl << ppaf->pln_offset;
+		caddr |= (u64)p.g.sec << ppaf->sec_offset;
+	} else {
+		caddr = p.m.sec;
+	}
+
+	return caddr;
+}
+
 typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bio *);
 typedef sector_t (nvm_tgt_capacity_fn)(void *);
 typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
-- 
2.17.1

