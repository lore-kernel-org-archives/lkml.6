Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E20C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284521754
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="1XLrwi/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2284521754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeHCKuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:50:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44448 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbeHCKuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:50:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so3502598lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhWG67qTTauUONHtvYIKHt5AVpM/AdhgRLjS8xMeBnY=;
        b=1XLrwi/uegYCGxVBMBiNLyGw92Z6t7NKrniTiqtVfdLM4feT2EaI5DSWS/1TTp1lxo
         hypHGgMPdEC0SjpvdhvuBE02yIiugm6lRrAciVwmKonM8BDVhGNA+eFsfWIg3i4i4niO
         9eQG2kzKFw1A6+rRqCdpou6RAA4vJ3FZRarqf02LdCzzjQ+7NAz2ghEteUVn2QfUM377
         CW5HW+Oh7v8vV3CnbnEasee7R/s59Mwex504AXFpk3FJp5KGu3qZPTgc6vOCGBpHuIh5
         v0XiLva9QzQAm/7R+H2Zvi7WkYEvfn9Xlhv73fOc6v3YAjWHGZiO/s8UvY1Qw4PTtwiy
         iHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhWG67qTTauUONHtvYIKHt5AVpM/AdhgRLjS8xMeBnY=;
        b=I2OD+h/E/UDwGZ9vhYZjoyh1fz/JGbT8OPfCiOfITt69un0fHdeH7HK18aT647ZnKc
         Pdw7LnQ2VSz792qPGPQX/5QhbE3mOm7bEmv0CY+/gXeR47gASiK+U1u4OriYyTx8IZeY
         v7iLVuXWImpTytGakFib4PZWjf6oRK7pPy3gr/2XAZG7xAJFRdxD6JHC+bFWVVoAoR8M
         H1PVMNghX/qcsQ6tcd1Tr6cD8eqe1ZkOuoWx1VUKh+ti4k2CapsLTcTF2SLs613UgGLm
         ++O7n8q0ygVHywBTlmJdcHapU2ftmdgXsDcUBk9t4DVWpqERL9OmRWObH3/K6MHj4/dq
         2zHQ==
X-Gm-Message-State: AOUpUlHT4xHqJ2CpoiXqYgaMh73IUzZoKIilCn2KSfJjvUzH0N9dKQ1I
        zXsWNM4ISvFRodTWK3dDTiz8rQ==
X-Google-Smtp-Source: AAOMgpdF5LGp/rHQQshnviHojTc+NyeNnNSnWi91VBkjqH3+g14UkXj6J1FEjQIVkJCFTxEtdYoQsQ==
X-Received: by 2002:a19:988f:: with SMTP id a137-v6mr4322123lfe.128.1533286501229;
        Fri, 03 Aug 2018 01:55:01 -0700 (PDT)
Received: from localhost.localdomain (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.gmail.com with ESMTPSA id a140-v6sm637345lfb.21.2018.08.03.01.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 01:55:00 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [PATCH] lightnvm: move device L2P detection to core
Date:   Fri,  3 Aug 2018 10:54:49 +0200
Message-Id: <20180803085449.3436-1-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 1.2 device is able to manage the logical to physical mapping
table internally or leave it to the host.

A target only supports one of those approaches, and therefore must
check on initialization. Move this check to core to avoid each target
implement the check.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c      | 5 +++++
 drivers/lightnvm/pblk-init.c | 7 -------
 include/linux/lightnvm.h     | 6 ++++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 68553c7ae937..964352720a03 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -355,6 +355,11 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		return -EINVAL;
 	}
 
+	if ((tt->flags & NVM_TGT_F_HOST_L2P) != (dev->geo.dom & NVM_RSP_L2P)) {
+		pr_err("nvm: device is incompatible with target L2P type.\n");
+		return -EINVAL;
+	}
+
 	if (nvm_target_exists(create->tgtname)) {
 		pr_err("nvm: target name already exists (%s)\n",
 							create->tgtname);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index e9e2fedff387..cc8a59e3c240 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1202,13 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->state = PBLK_STATE_RUNNING;
 	pblk->gc.gc_enabled = 0;
 
-	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
-		pblk_err(pblk, "host-side L2P table not supported. (%x)\n",
-							geo->dom);
-		kfree(pblk);
-		return ERR_PTR(-EINVAL);
-	}
-
 	spin_lock_init(&pblk->resubmit_lock);
 	spin_lock_init(&pblk->trans_lock);
 	spin_lock_init(&pblk->lock);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 8acc2fe277d6..f4a84694e5e2 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -495,9 +495,15 @@ typedef void (nvm_tgt_exit_fn)(void *, bool);
 typedef int (nvm_tgt_sysfs_init_fn)(struct gendisk *);
 typedef void (nvm_tgt_sysfs_exit_fn)(struct gendisk *);
 
+enum {
+	NVM_TGT_F_DEV_L2P = 0,
+	NVM_TGT_F_HOST_L2P = 1 << 0,
+};
+
 struct nvm_tgt_type {
 	const char *name;
 	unsigned int version[3];
+	int flags;
 
 	/* target entry points */
 	nvm_tgt_make_rq_fn *make_rq;
-- 
2.11.0

