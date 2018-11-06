Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B1EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE0C20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="LA6L1IQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE0C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbeKFW67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:58:59 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39718 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbeKFW65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:58:57 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so17566938itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cnKaeRoQQa8i6RB5+OFZeMivpWgE29k57o0EeueExqw=;
        b=LA6L1IQUzuO7LC97IoxUFJ778GmWPnjKnd181fn1Ini/4EZFzqI2WR7H1iV8OHKZ16
         AbXJVL6bANE3obMTJwdjHkF06XuAAjZXaMmeOl98MLlBqzbEPoEcOzTpAAkXz9RKN5We
         0sKl1qCIHXKlOaH16rV/6rA9LUblii89utgG5byK4b418tC3c7DgWm3p5qtcDEfEuJ38
         eNMKT1qdvwYEGJEKvpxcXOv9PO6unuvguxfvm5yteT+QjbkOzNAQ4BMbFDzSpmxqz15/
         OSbmI9J5Cv+Vyc3eHnV/Qs9SpmyqhPVjX/T2KUHjCjHechMin4nceQN5zbzUbGAEeyc/
         f06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cnKaeRoQQa8i6RB5+OFZeMivpWgE29k57o0EeueExqw=;
        b=EN2pzL3DzV46gHNU0Qb5zMgxicpLuTQa8uZk3YOWsTYjsadbb2qBZGsqFLxVL+e751
         SX5sHW9jyYTE9XCJ0io2rS0IU2b+lI4ZkXGigqUuyP6XYtzdF27ThNYqTRQjmMv24iTM
         tjfyO37uC16OBIfelcHmnCYEqOk0cxyAWuejfNqfgDN8JqCBxRvkX5NzH+6dVFmP/rdk
         B0IRDLnftF6xesKUTahThh6RjMZD2lQ3N7vv/Et8OWC2FWZuyE1jeRAttM9q7v44TJjz
         dBTUuhHAzdMjKHI2o0IeBDhdhEyMUid0wan2wEh3QG19uck8mfK5JIh01U6wbK0Z8hdX
         B2Xw==
X-Gm-Message-State: AGRZ1gINN9V2WwA8RAJBzOdzp6SXjT4rlHAWERgQZauVfViq68CLhdam
        v88nRv7thvvgBGldsqhTOAH+BQ==
X-Google-Smtp-Source: AJdET5c9JGSZL+3CGhx0pmgvDHQlJdOwX0yjQFs41YDdKAFmrYMLXMOTeUw4TnidTWXXreij/iK2Jg==
X-Received: by 2002:a24:59c1:: with SMTP id p184-v6mr1986559itb.93.1541511222242;
        Tue, 06 Nov 2018 05:33:42 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u132-v6sm897282itb.21.2018.11.06.05.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:33:41 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 2/7] lightnvm: pblk: account for write error sectors in emeta
Date:   Tue,  6 Nov 2018 14:33:25 +0100
Message-Id: <20181106133330.26570-3-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
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

