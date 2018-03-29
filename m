Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeC2WHV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:07:21 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45475 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbeC2WHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:15 -0400
X-Google-Smtp-Source: AIpwx48Wv9z6NsxrWjLD4f/FuTuiGTPieZoYmRFBJ28sOAonoXtcoxK5jb5N8r9vZQkjK61VdNDMmQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 16/37] lightnvm: remove max_rq_size
Date: Fri, 30 Mar 2018 00:05:03 +0200
Message-Id: <20180329220524.30363-17-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field is no longer used.

Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c  | 1 -
 include/linux/lightnvm.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 521f520a1bb4..a59ad29600c3 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -874,7 +874,6 @@ static int nvm_core_init(struct nvm_dev *dev)
 	geo->sec_size = id->csecs;
 	geo->oob_size = id->sos;
 	geo->mccap = id->mccap;
-	geo->max_rq_size = dev->ops->max_phys_sect * geo->sec_size;
 
 	geo->sec_per_chk = id->clba;
 	geo->sec_per_lun = geo->sec_per_chk * geo->nr_chks;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index b717c000b712..67b4fa8e4906 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -295,8 +295,6 @@ struct nvm_geo {
 	int ws_seq;
 	int ws_per_chk;
 
-	int max_rq_size;
-
 	int op;
 
 	struct nvm_addr_format ppaf;
-- 
2.11.0
