Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAADC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB59214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="cfZGOv7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB59214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJISbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37265 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeJISbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so679800pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09SNCuKjBv0ENghLQH2mjMFjiTQQS+mH3krte2z34eM=;
        b=cfZGOv7aIH9yA/d8WRD6kGX+S/JHJx1x7OfdJtsc98aXsOxh0ASwNTHlMmZEwWeFAr
         V4GAKaiNyRw9+67IjOEGRXjsaZ5pTwegalalgOs0IpTVMG2+4mgvj8rTyLU1PHooTUQY
         aKxKDnIIeu/pQU6pmwFXmq6uXzQJ/AxVy/C49JehtXJPrycjvzctF0eHPBDpwu5yXtki
         CBDKQ54n2mIHAESxtO6JGmJ4wgoMjTqh5y7WYj1EiJkiFDd78zqKclH4Qw4bvFs8PSHi
         iq8M1lEnQwqp6M7MDi3LrU3G+j38F/K/li8OZWvGXTkSONu/dkPNqSXmm0KKMAL+qoB6
         2CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09SNCuKjBv0ENghLQH2mjMFjiTQQS+mH3krte2z34eM=;
        b=UFEWpSMexUihIxkjHOimyrWbHkGvoP45D4r+B19LR2jUazOzJLGLJbkXlPyjCziTJV
         9TT8jlJV4Aw3W/X/QzpnOSVwJojGaKHlS6grBhPVAX+5OtNAL86Qv4ppfiuzS56X7qyV
         wkJGcrwOwMYE/OmoQu1vkePYJYRB95UK1cWZHzIsKt3Dpr9Cnu4Ri29q0UsPh+wKROzl
         mPMhfI3nTGMmGJsYVQoFBdDy2R7XDjOafXZyVZ9Ow4D6djtQzQ8hnVt/WEXB2H4HHdyW
         0GY0hg5C7aA3H96Jhasu8iAzPdWrMzpoXvLhRI5THp1cpQs6PY5udF5mxyoCbqDwEBJK
         uLfA==
X-Gm-Message-State: ABuFfoiAwNf8Xh3K7OA3O6rAKE4pW89ZfQYyOTmsBCgJiJzPhvUHBhxF
        SR1EAswV7QeMOrEoYOkzdmFkmg==
X-Google-Smtp-Source: ACcGV61+vu23ZqFEmY3d4F/NeyTq0cZqXE9WpVBNSR0kbh9Go7UKOP58DVLvROszrDhVGHUTAj4A+w==
X-Received: by 2002:a63:b04f:: with SMTP id z15-v6mr23482859pgo.442.1539083691085;
        Tue, 09 Oct 2018 04:14:51 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:49 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 29/45] lightnvm: pblk: fix mapping issue on failed writes
Date:   Tue,  9 Oct 2018 13:11:59 +0200
Message-Id: <20181009111215.7653-30-mb@lightnvm.io>
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

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

On 1.2-devices, the mapping-out of remaning sectors in the
failed-write's block can result in an infinite loop,
stalling the write pipeline, fix this.

Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 12 +-----------
 include/linux/lightnvm.h      | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 61fe22ccc7a1..9554febee480 100644
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
index eb7300c20f24..2fdeac1a420d 100644
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
2.17.1

