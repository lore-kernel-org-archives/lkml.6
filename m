Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469B220846
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FtLAQcPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469B220846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeH2OGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:06:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39044 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbeH2OGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:06:01 -0400
Received: by mail-it0-f65.google.com with SMTP id h1-v6so4514948itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ODcjidieP2i8+4PKVs+kvCzZXfnHJ/1WtHIaljN8HY=;
        b=FtLAQcProxh3GzyK/M3ewHLenRYJ3RDwQSAIqB745Pt8hCJcVH+CDoe8qhlMBXgD0U
         bfrnODw4ioonb3A1bzLVclL2s6bHwzJRgCfHz1I7eF2bVRDRmGP67Sld+uVB9vGua1tT
         4TlX1Dpm2ZqHS9B517/F1E2Oq3hq8bwUJGfCHF26XjT3y7zenctPwKnxCa4eAQzvv9Dj
         4vLDGr9Jyn0CAUsfL4F3P1aeQtSj+KZyTbhf9szFvAMykjOGJeJVwy8xBWwmBd+jrkKQ
         gs6SAoG7sbfmexFDiPMpsUKBWy+j689abdkdKWv5eN6px/AfC4kV1iKcs4fSPrFotr8J
         5DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ODcjidieP2i8+4PKVs+kvCzZXfnHJ/1WtHIaljN8HY=;
        b=TWcof+R0JyPte3F8WPfannNcY4cXBsJggo2Ocop/08e5A44pKlzMt8jmhaHwmYdzJz
         4hUWTFlsxyRA9oXuAq3L2cdCKzOeIVZ9zELq228NruyHSSsVM53B8mfAH16mlC7M31w6
         3TCyLZovw6G5xHWpbl3aQNTutwHokg9v8bw39/wH8Ond5K80Cai4Ox/b/TGHTFBhYr7e
         fwqUVZogAWDw97DqZ8biXhWRc54901UJ1EIOyUuHK3WGj8oku9YpP9e6VeeZm5Lr7a1r
         FiXn0MTfSANVlTyXa++YEgVLA8iRaKrLgEjvHzCNoFaLSJdThqavdFgflVopDt6Wl39c
         9P5Q==
X-Gm-Message-State: APzg51CBhbpguSjKFpcG22mcUnmOIZPqzDO4ERWI1P2IQU6j/nWjnjk3
        X4vjBQnXEzxkkl8PN9KHC2Q1tA==
X-Google-Smtp-Source: ANB0VdY01uJljQOsdLOM8IpmvDCc45ZEqZMsVQVcYWP2NSNphh0gtRGfR9H2GosoF9D3hfOjEr0DfQ==
X-Received: by 2002:a24:190c:: with SMTP id b12-v6mr4624781itb.79.1535537391726;
        Wed, 29 Aug 2018 03:09:51 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1721501iog.42.2018.08.29.03.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 03:09:51 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 1/3] lightnvm: use internal allocation for chunk log page
Date:   Wed, 29 Aug 2018 12:09:28 +0200
Message-Id: <1535537370-10729-2-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lightnvm subsystem provides helpers to retrieve chunk metadata,
where the target needs to provide a buffer to store the metadata. An
implicit assumption is that this buffer is contiguous and can be used to
retrieve the data from the device. If the device exposes too many
chunks, then kmalloc might fail, thus failing instance creation.

This patch removes this assumption by implementing an internal buffer in
the lightnvm subsystem to retrieve chunk metadata. Targets can then
use virtual memory allocations. Since this is a target API change, adapt
pblk accordingly.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c |  4 ++--
 drivers/lightnvm/pblk-init.c |  2 +-
 drivers/nvme/host/lightnvm.c | 23 +++++++++++++++--------
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index fdcbeb920c9e..a311cc29afd8 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -120,7 +120,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
 /*
  * Get information for all chunks from the device.
  *
- * The caller is responsible for freeing the returned structure
+ * The caller is responsible for freeing (vmalloc) the returned structure
  */
 struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 {
@@ -134,7 +134,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
 	ppa.ppa = 0;
 
 	len = geo->all_chunks * sizeof(*meta);
-	meta = kzalloc(len, GFP_KERNEL);
+	meta = vzalloc(len);
 	if (!meta)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e0db6de137d6..a99854439224 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -983,7 +983,7 @@ static int pblk_lines_init(struct pblk *pblk)
 
 	pblk_set_provision(pblk, nr_free_chks);
 
-	kfree(chunk_meta);
+	vfree(chunk_meta);
 	return 0;
 
 fail_free_lines:
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 2c96e7fcdcac..5bfa354c5dd5 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -579,7 +579,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	struct nvm_geo *geo = &ndev->geo;
 	struct nvme_ns *ns = ndev->q->queuedata;
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_nvm_chk_meta *dev_meta = (struct nvme_nvm_chk_meta *)meta;
+	struct nvme_nvm_chk_meta *dev_meta, *dev_meta_off;
 	struct ppa_addr ppa;
 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
 	size_t log_pos, offset, len;
@@ -591,6 +591,10 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	 */
 	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
 
+	dev_meta = kmalloc(max_len, GFP_KERNEL);
+	if (!dev_meta)
+		return -ENOMEM;
+
 	/* Normalize lba address space to obtain log offset */
 	ppa.ppa = slba;
 	ppa = dev_to_generic_addr(ndev, ppa);
@@ -604,6 +608,9 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	while (left) {
 		len = min_t(unsigned int, left, max_len);
 
+		memset(dev_meta, 0, max_len);
+		dev_meta_off = dev_meta;
+
 		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
 				dev_meta, len, offset);
 		if (ret) {
@@ -612,15 +619,15 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 		}
 
 		for (i = 0; i < len; i += sizeof(struct nvme_nvm_chk_meta)) {
-			meta->state = dev_meta->state;
-			meta->type = dev_meta->type;
-			meta->wi = dev_meta->wi;
-			meta->slba = le64_to_cpu(dev_meta->slba);
-			meta->cnlb = le64_to_cpu(dev_meta->cnlb);
-			meta->wp = le64_to_cpu(dev_meta->wp);
+			meta->state = dev_meta_off->state;
+			meta->type = dev_meta_off->type;
+			meta->wi = dev_meta_off->wi;
+			meta->slba = le64_to_cpu(dev_meta_off->slba);
+			meta->cnlb = le64_to_cpu(dev_meta_off->cnlb);
+			meta->wp = le64_to_cpu(dev_meta_off->wp);
 
 			meta++;
-			dev_meta++;
+			dev_meta_off++;
 		}
 
 		offset += len;
-- 
2.7.4

