Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB82C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDF62087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="q9ZQk53S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfA3ITN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:19:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39545 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfA3ITM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:19:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so19899944ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=FMk7KZzFNOQZxopX51HKzZjFFbjWtJbENRSvLHUIma8=;
        b=q9ZQk53SePSRAjbg79biacXEPnGYHdd7oZcsugOIgExR7zXyogkAtKpHTlpwEyR0of
         7IODch6/i/NFGOkiZV9U1vYWIqjaU+qZB6IfW7cMeIMA+wnNucCxwW55ldCy4g5SRz4s
         +l+AJV3RBLw7hTT2BYgMS8vsHr6bIlxwBbiqO35DqVNAxvNKJULOwNYig/+hJkUxB4CG
         rJawu69iKJvKSPfIOq1hSVlAe5BgMC2tdjO6Ym4tryUJhri6z63vEXeDu8gvy5D16elO
         ++Knka9U0KyDfpq5af0JxeK6zYdTfWFgdkBRwotWg+eaJ7N/qoJ4fK/sFwSBP8HTOh9/
         9uMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FMk7KZzFNOQZxopX51HKzZjFFbjWtJbENRSvLHUIma8=;
        b=PO8HH/amVmv5ezZhEWwzc7HoeM8FKHEPJXwMxQNU1tpLkI9p0X7gl2V0XMF46Ogwi5
         2TWuqVLYFNbhCBSZBxsAtYUxR7igrmZ/L7pbeUYWUdIez4uTO7haB1QBXVCHLVJgvCIK
         90XHqQd6TeSKPipp08w1ANogLRbDVWFZLdPliIFvdcSmypo7B8obtzAc6H6GWsjz1Y+0
         xilSKAXfbyNBnxcv22jtAtp74/DKywu7GvGUz8yZULbKx7fUTjWZa3k92i2joulFeaFY
         o9P8yDPXcHHTlWi1a1nCzzW4RRftCBdEvOJqLmj9H+K45IP34V9McfAwi11sB/Hf1c5U
         u4lQ==
X-Gm-Message-State: AJcUukdZyIOlenlRRG+D2Jue9+zi9J+U4ueAqLqtQ0HKL3Uv3e3tpDXc
        IdxYouymhkGYBsbM6KPTlypiAg==
X-Google-Smtp-Source: ALg8bN51VHxAoSWcNKirSyrcWCyQaqpWx7A56YqoV5GAGXrc1rVtrHhmiKdAr2+6CBgP5wCHYveENA==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr24196237ljd.45.1548836350284;
        Wed, 30 Jan 2019 00:19:10 -0800 (PST)
Received: from ch-lap-hans.bredbandsbolaget.se (c-0bf2e055.03-91-6d6c6d4.bbcust.telenor.se. [85.224.242.11])
        by smtp.gmail.com with ESMTPSA id r29-v6sm151220ljd.44.2019.01.30.00.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 00:19:09 -0800 (PST)
From:   hans@owltronix.com
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     javier@javigon.com, Zhoujie Wu <zjwu@marvell.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: extend line wp balance check
Date:   Wed, 30 Jan 2019 09:18:57 +0100
Message-Id: <20190130081857.6779-1-hans@owltronix.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

pblk stripes writes of minimal write size across all non-offline chunks
in a line, which means that the maximum write pointer delta should not
exceed the minimal write size.

Extend the line write pointer balance check to cover this case, and
ignore the offline chunk wps.

This will render us a warning during recovery if something unexpected
has happened to the chunk write pointers (i.e. powerloss,  a spurious
chunk reset, ..).

Reported-by: Zhoujie Wu <zjwu@marvell.com>
Tested-by: Zhoujie Wu <zjwu@marvell.com>
Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---

Changes since V1:

	* Squashed with Zhoujie's:
	 "lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced"
	* Clarified commit message based on Javier's comments.
		

 drivers/lightnvm/pblk-recovery.c | 56 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 6761d2afa4d0..d86f580036d3 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -302,35 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
 	return (distance > line->left_msecs) ? line->left_msecs : distance;
 }
 
-static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
-				      struct pblk_line *line)
+/* Return a chunk belonging to a line by stripe(write order) index */
+static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
+						  struct pblk_line *line,
+						  int index)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
-	struct pblk_line_meta *lm = &pblk->lm;
 	struct pblk_lun *rlun;
-	struct nvm_chk_meta *chunk;
 	struct ppa_addr ppa;
-	u64 line_wp;
-	int pos, i;
+	int pos;
 
-	rlun = &pblk->luns[0];
+	rlun = &pblk->luns[index];
 	ppa = rlun->bppa;
 	pos = pblk_ppa_to_pos(geo, ppa);
-	chunk = &line->chks[pos];
 
-	line_wp = chunk->wp;
+	return &line->chks[pos];
+}
 
-	for (i = 1; i < lm->blk_per_line; i++) {
-		rlun = &pblk->luns[i];
-		ppa = rlun->bppa;
-		pos = pblk_ppa_to_pos(geo, ppa);
-		chunk = &line->chks[pos];
+static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
+				      struct pblk_line *line)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	int blk_in_line = lm->blk_per_line;
+	struct nvm_chk_meta *chunk;
+	u64 max_wp, min_wp;
+	int i;
+
+	i = find_first_zero_bit(line->blk_bitmap, blk_in_line);
 
-		if (chunk->wp > line_wp)
+	/* If there is one or zero good chunks in the line,
+	 * the write pointers can't be unbalanced.
+	 */
+	if (i >= (blk_in_line - 1))
+		return 0;
+
+	chunk = pblk_get_stripe_chunk(pblk, line, i);
+	max_wp = chunk->wp;
+	if (max_wp > pblk->max_write_pgs)
+		min_wp = max_wp - pblk->max_write_pgs;
+	else
+		min_wp = 0;
+
+	i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
+	while (i < blk_in_line) {
+		chunk = pblk_get_stripe_chunk(pblk, line, i);
+		if (chunk->wp > max_wp || chunk->wp < min_wp)
 			return 1;
-		else if (chunk->wp < line_wp)
-			line_wp = chunk->wp;
+
+		i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
 	}
 
 	return 0;
@@ -356,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
 	int ret;
 	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
 
-	if (pblk_line_wp_is_unbalanced(pblk, line))
+	if (pblk_line_wps_are_unbalanced(pblk, line))
 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
 
 	ppa_list = p.ppa_list;
-- 
2.17.1

