Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D324C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A552084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="cAuaHREc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A552084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeH2RKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:10:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39662 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeH2RKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:10:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so3894875edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPqHvsZYjVfDOk5t9lhQur82y1d1OeKD6j2efcpCl9I=;
        b=cAuaHREcwYZikBjkmHvpyMVH6KPuAcRTXAXG67zVA1r8EOVqsK+wJ0sFBV0SP8S0QR
         O+NLwflKdPMaJ2WRDXXsf3ktZVHb4hTy4XREPd/qD2VO69peXWimC6jkY7aP8I8+3BG8
         mIrW+YsWDCTSMfv5oLMXVh/1SyX5yclKpcilTeussb3JoLFAB9548Udmr2LFU3LyHhh8
         i0QheXW+5v3vihAWwG9wypcy+hdYXJhlh7XP0HHz9YwoPfhr/nVdnulGoKOMG1fakGTQ
         HRnEWu8spoAZHQLt0OhUZb5AvipRqCBhrLvM7cnKxfDEWosIeQLBGYj7r5KiNo0vc+Vt
         9Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPqHvsZYjVfDOk5t9lhQur82y1d1OeKD6j2efcpCl9I=;
        b=NVUTv/O+6dAXADo+qWG+m9hjaimZKCxn1IMzTpVrXssVbaTSP76m72Bj13ZvAgIPeX
         saQcjFNs3Rcs9rhsIHVYp5TDGMj/7MMiji8IWYYgMd3c3pl0L/jDX7XeZzJRDl9D0Pdl
         B/w81NWuUP9loTJkskek4XUTswiZAaSaxwDlgu/5z7Ftrc0x9+hBMWty2x5vZ5McGlzZ
         NM6OsBd25A4gaAcgeV2JvpD/4Lfq49qyNcaEreKbvSycGj155g9roK6cLn6tsPLSfs3K
         gXrbiDGaC0DdHKfCL8Xra59jbyBDfhgP4RDncDrIdIkzNMlx9tO4R/edMd/IgkYoqABj
         nuCg==
X-Gm-Message-State: APzg51BucgtlsHwzAOHf99zQy1WFUDa9pKTKqG0ve9cUKH0aKy65dk+w
        PAoqA6ORBpDnpa9Up1tnvpGhVg==
X-Google-Smtp-Source: ANB0Vdbg7f/oQVwVdEFTSplVHIUv/HQOHnmTU1HeFTQqt+OuiRoVRI8Salv+Z8mx0hilWHEbZ6MBJg==
X-Received: by 2002:a50:de03:: with SMTP id z3-v6mr7716679edk.245.1535548390180;
        Wed, 29 Aug 2018 06:13:10 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id g4-v6sm1921929eda.86.2018.08.29.06.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 06:13:09 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [V2 PATCH] lightnvm: pblk: add helpers for chunk addresses
Date:   Wed, 29 Aug 2018 15:12:59 +0200
Message-Id: <1535548379-11125-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Changes since V1:
 - Move 1.2 / 2.0 specific code to core (form Matias)

Implement helpers to go from ppas to a chunk within a line and an
address within a chunk.

These helpers will be used on the patches adding trace support in pblk,
which will be sent in this window.

Signed-off-by: Javier González <javier@cnexlabs.com>
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
2.7.4

