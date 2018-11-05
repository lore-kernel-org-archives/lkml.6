Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0B8ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC84620827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="te6Hid59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC84620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeKEVqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:46:18 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37331 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbeKEVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:46:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id y10-v6so813462edr.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cnKaeRoQQa8i6RB5+OFZeMivpWgE29k57o0EeueExqw=;
        b=te6Hid59cIIWKRRQciZfIZ1h7Cv6AXnsglt3poBcaSqT2WaDwyp8N5qxRwMBsSSl3Y
         ny/nTAL66fQ54S//nu8XROrYTQjQPtUmQXfKx6pCmq0R4nFez80ld4//OJd0ZFFGL0en
         fkRXfFxM7j0hhLFp7UW9HzXXBpSbODwUwQsetLMukMJ+xY1sCWkKOdqi21wdGXOEDomL
         /p/mez+f3j3JEEyzyM/MSzBmrp4PT5GFOGxNnlAc0I5KxiEiNepNxQ3ynkEX3cnGDl8N
         fwt5+GWY8pfQLq+Hqh1wAgi/nMIcbxo5jw0NWT7L9bwKkVRQ9lEJiSeyubq2LZspnMRt
         awKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cnKaeRoQQa8i6RB5+OFZeMivpWgE29k57o0EeueExqw=;
        b=fW66v28/3Mb5tDUbFfZEO0glVhdx4jsEyCuG6r2bjEZDdtnab9/9+5L5aBe2/XVSgN
         InRq1VIPRdgxFr96cZgQKp+Lp9xmbG+awRH2POA+8mzic+QZFeL44OxtvNK355XiDLjO
         S79A8wiGdGbibF4ILiN8pDzoCOgQZ3Cco1bFpBmk8CLNx4sQ0D4yO1p8p537QW0+go4J
         iNUJNZemdgvI8uN6az7Lsoy19ybsyRjSCkvjMmfvTx0MSl2qB77YuIFeD+9YTlKlUMKs
         iDWE+4rV4gxfgBH/Ihx8CM4KQTUjHrlTmQWAs1scbVhZ5FH4PWyowm2xCDKq6OUfjzcE
         lfRQ==
X-Gm-Message-State: AGRZ1gKOp61mCZW7SL0FcDbP+kSX1/00SYUrnN9hIIpvdca4yoglT/eU
        50myd7VXmWST+SOn8q87qDOD+w==
X-Google-Smtp-Source: AJdET5ej0cCSl8cvEGawBuv/2L9zrSC6apK1d/eaAxf4ucQS8Q2vCY7HpQQpBaOjsG6HOw75wYhvVw==
X-Received: by 2002:a17:906:5387:: with SMTP id g7-v6mr14054240ejo.174.1541420804987;
        Mon, 05 Nov 2018 04:26:44 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id 9-v6sm7046056ejw.46.2018.11.05.04.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 04:26:44 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v2 2/7] lightnvm: pblk: account for write error sectors in emeta
Date:   Mon,  5 Nov 2018 13:26:05 +0100
Message-Id: <20181105122610.1555-3-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Lines inflicted with write errors lines might be recovered
if they have not been recycled after write error garbage collection.

Ensure that the emeta accounting of valid lbas is correct
for such lines to avoid recovery inconsistencies.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-write.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 3ddd16f47106..750f04b8a227 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -105,14 +105,20 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 }
 
 /* Map remaining sectors in chunk, starting from ppa */
-static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
+static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa,
+		int rqd_ppas)
 {
 	struct pblk_line *line;
 	struct ppa_addr map_ppa = *ppa;
+	__le64 addr_empty = cpu_to_le64(ADDR_EMPTY);
+	__le64 *lba_list;
 	u64 paddr;
 	int done = 0;
+	int n = 0;
 
 	line = pblk_ppa_to_line(pblk, *ppa);
+	lba_list = emeta_to_lbas(pblk, line->emeta->buf);
+
 	spin_lock(&line->lock);
 
 	while (!done)  {
@@ -121,10 +127,17 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 		if (!test_and_set_bit(paddr, line->map_bitmap))
 			line->left_msecs--;
 
+		if (n < rqd_ppas && lba_list[paddr] != addr_empty)
+			line->nr_valid_lbas--;
+
+		lba_list[paddr] = addr_empty;
+
 		if (!test_and_set_bit(paddr, line->invalid_bitmap))
 			le32_add_cpu(line->vsc, -1);
 
 		done = nvm_next_ppa_in_chk(pblk->dev, &map_ppa);
+
+		n++;
 	}
 
 	line->w_err_gc->has_write_err = 1;
@@ -202,7 +215,7 @@ static void pblk_submit_rec(struct work_struct *work)
 
 	pblk_log_write_err(pblk, rqd);
 
-	pblk_map_remaining(pblk, ppa_list);
+	pblk_map_remaining(pblk, ppa_list, rqd->nr_ppas);
 	pblk_queue_resubmit(pblk, c_ctx);
 
 	pblk_up_rq(pblk, c_ctx->lun_bitmap);
-- 
2.17.1

