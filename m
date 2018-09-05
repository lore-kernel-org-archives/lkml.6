Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3032F2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwhytmDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3032F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeIENJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:09:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIENJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:09:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so3096544pff.11;
        Wed, 05 Sep 2018 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0NHXwXFwmPc5N5dOPMXoVD6V+R7knptfBR7UQTfwbng=;
        b=HwhytmDnZM/rWy+ts15RExoKGZnmoG9u3K2TLyooIn7rWU7r7SCP0AMqMctkCCBDU6
         TU94pXLKCva+7sqn2CYaAsIaA7NY4Z1qjR5aa2BiHepNWVIMcw99l74LNen1zSWzBu8s
         nG3TtBYGsyXKyHFXIqnugziJWSq29Ud6cmSuJIa9txS25AY0Srjouhy2IgHU8uWHARgU
         iB0TLMCVeeYPeb8Lh+RgW1fvKsf0+M/0tVEctBFoAtt03UYANDEuBg88WKN1hNq19dt6
         cZ6vRPeOgUCkVNvrdJD3z+b+NpMOSJT3E0xBPgH19xeE71KE1bhIpR8FYTyO24OeolRH
         XAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0NHXwXFwmPc5N5dOPMXoVD6V+R7knptfBR7UQTfwbng=;
        b=PMaUby0nPBb9buw7smCIhFqogbnqNHpof1ccEloIM02shi+19aiLOhxh1jFDzzEi5G
         MItLE3WahcR4ace1bTa/GMun/VHfg49r6TbI107f5CyfmXdqFBMzlwraocEFCKkdmtQb
         miul/Z+O0fdd+EYMj5lmYVWW/5SBeHydoXcDgqMKtwNSCzTZef4APYNVlUS6hxcJcBLY
         qnXSYXNKWfVTKxpq1TK+VJdvJaSJUb8OT5VX6o0eLqrLXH/rlmO0yLMCytSFBUG41soY
         kQLR+NrioQB35zyqJY6I6vXxxAK0cixbx8hHcX/FjwVsGJuPxTsMUvrvrVIn/exHqZE4
         mEFw==
X-Gm-Message-State: APzg51CyMEb8ZCKENGiOcv/2N7Yxx64c6YE2wt+9SgoATAAL9LBAz2Vi
        sP6/zXHbBhVmJn1Poj95LUpo6G2Y
X-Google-Smtp-Source: ANB0VdZA8cIZvyn3CxK31PvcgbeMDJ76hPI98F4qZmzSTPkxc0CgDcd5HmFoAlS6jOxjhZEg8nAwFQ==
X-Received: by 2002:a63:2d87:: with SMTP id t129-v6mr13860925pgt.128.1536136826654;
        Wed, 05 Sep 2018 01:40:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:dd3:bec:d9ff:b901])
        by smtp.gmail.com with ESMTPSA id d12-v6sm2599464pfk.69.2018.09.05.01.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 01:40:26 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mb@lightnvm.io, javier@cnexlabs.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] lightnvm: pblk-recovery: lightnvm: pblk: Fix two sleep-in-atomic-context bugs
Date:   Wed,  5 Sep 2018 16:40:17 +0800
Message-Id: <20180905084017.27593-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 754:
	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048:
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434:
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980:
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976:
	spin_lock in pblk_recov_l2p

[FUNC] bio_map_kern(GFP_KERNEL)
drivers/lightnvm/pblk-core.c, 762:
	bio_map_kern in pblk_line_submit_smeta_io
drivers/lightnvm/pblk-core.c, 1048:
	pblk_line_submit_smeta_io in pblk_line_init_bb
drivers/lightnvm/pblk-core.c, 1434:
	pblk_line_init_bb in pblk_line_replace_data
drivers/lightnvm/pblk-recovery.c, 980:
	pblk_line_replace_data in pblk_recov_l2p
drivers/lightnvm/pblk-recovery.c, 976:
	spin_lock in pblk_recov_l2p

To fix these bugs, the call to pblk_line_replace_data() 
is moved out of the spinlock protection.

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Move the call to pblk_line_replace_data() out of the spinlock 
  protection, instead of v1 that changes GFP_KERNEL to GFP_ATOMIC in
  the calls to bio_map_kern() and nvm_dev_dma_alloc().
  Thanks Javier for good advice.
---
 drivers/lightnvm/pblk-recovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 3a5069183859..5fde414d78bb 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -955,12 +955,14 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		}
 	}
 
-	spin_lock(&l_mg->free_lock);
 	if (!open_lines) {
+		spin_lock(&l_mg->free_lock);
 		WARN_ON_ONCE(!test_and_clear_bit(meta_line,
 							&l_mg->meta_bitmap));
+		spin_unlock(&l_mg->free_lock);
 		pblk_line_replace_data(pblk);
 	} else {
+		spin_lock(&l_mg->free_lock);
 		/* Allocate next line for preparation */
 		l_mg->data_next = pblk_line_get(pblk);
 		if (l_mg->data_next) {
@@ -968,8 +970,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			l_mg->data_next->type = PBLK_LINETYPE_DATA;
 			is_next = 1;
 		}
+		spin_unlock(&l_mg->free_lock);
 	}
-	spin_unlock(&l_mg->free_lock);
 
 	if (is_next)
 		pblk_line_erase(pblk, l_mg->data_next);
-- 
2.17.0

