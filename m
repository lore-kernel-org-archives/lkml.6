Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7342083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="uj14UinM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7342083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeH2QUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:20:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35980 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeH2QUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:20:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so3783740edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UQkDiPooqhwWS1BzntFMujGan16736ogBbBumqTDCUA=;
        b=uj14UinMVay5ZkiWviYTdI+pTG4xbCVOnBBgOKyHEuByq4aDPd6zu8ET9xtNACGtvZ
         Qib4Ajq4vl23c7ywIGB61Oxgde9xo/q6ueEjbwFEi2GCp+iGn11/Ads6ZgDHTWp36OgZ
         H1OSUxtqzIqDjr26ZMyBHe8uTi9EQ/m+zTRr9OcqRJjmddoltDMs3N4Ki3dH1zMoInqv
         7Jm/VUSZm+MvNcaIfmp7gqHLbstOOlAP1TX2TkPdITL22Ng0IV0pcAhL271yREljpU0/
         7mkTRlsHGIz8cz7+ZnIEuAsgPc1WD+PdMsDhPL5gA19umgkHRije+x/auHRIA/mOSzR9
         QgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UQkDiPooqhwWS1BzntFMujGan16736ogBbBumqTDCUA=;
        b=t6mbHWE+ngpKbszQFp1PP6zzvush/+3VgrovrkGmkdjh8d59xKXTGZvZUQfRRILbO0
         odhdSX0wLytDWzh59d4Wv8AyM3OPNLUE2iVc+sZ1CQoZ9WniwHDGjsHZhc8Cf2urm32v
         2U8xmisRFValQrPxb5wntpapZfBf9ooSBiai2at2+iaUrU8uckCFangYoXGaFqL9GZ0F
         RRksn/0xDgN6lfZ6WwaHGpq90bktk70pTWrey1sIZnpNxzeHg4s8NoFJrWLcP7tlZy/1
         xzIFT+gn4iPfMnYcK0dQhxxsEkzSLQg7aEOPmE1mGxPVm4rvUED8hgx/UyedXRsSJjcn
         BeTQ==
X-Gm-Message-State: APzg51CACDQMYnIzP5ScT+/VDR3Ug0IrNnV1RtU2uTYbU/DiSQrBGZnd
        mjPHGSMtynLpIJGtxAclyPKJcQ==
X-Google-Smtp-Source: ANB0VdbmFoXZYiJkhlK15N2JZfPiVCuEudCTsMRA/aKm8KcSrbBICal50+bFN6jR+RFrduz9RX4ASQ==
X-Received: by 2002:a05:6402:1348:: with SMTP id y8mr7430321edw.222.1535545433868;
        Wed, 29 Aug 2018 05:23:53 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1752068edb.28.2018.08.29.05.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:23:53 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 2/7] lightnvm: pblk: fix mapping issue on failed writes
Date:   Wed, 29 Aug 2018 14:23:29 +0200
Message-Id: <1535545414-550-3-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
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
 drivers/lightnvm/pblk-write.c | 45 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 1bc879ab679d..fd67325f6e54 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -103,6 +103,41 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
 	pblk_rb_sync_end(&pblk->rwb, &flags);
 }
 
+static int pblk_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *ppa)
+{
+	int done = 0;
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
+					done = 1;
+
+				ppa->g.pl = pl;
+			}
+			ppa->g.pg = pg;
+		}
+		ppa->g.sec = sec;
+	} else {
+		ppa->m.sec++;
+		if (ppa->m.sec == geo->clba)
+			done = 1;
+	}
+
+	return done;
+}
+
 /* Map remaining sectors in chunk, starting from ppa */
 static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
 {
@@ -125,15 +160,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
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
+		done = pblk_next_ppa_in_blk(geo, &map_ppa);
 	}
 
 	line->w_err_gc->has_write_err = 1;
-- 
2.7.4

