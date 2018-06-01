Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeFANIG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:08:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42111 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeFANFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:05:07 -0400
X-Google-Smtp-Source: ADUXVKJFT7HAy4G2SSkExAKJMzGT1Z2Sqb4JTJOLkiztovURiU6AUmiUE4GGSpN8LxaF8UL4WDINhg==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 11/18] lightnvm: pblk: remove dead function
Date: Fri,  1 Jun 2018 15:04:25 +0200
Message-Id: <20180601130432.30866-12-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180601130432.30866-1-mb@lightnvm.io>
References: <20180601130432.30866-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

Remove dead function for manual sync. I/O

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 drivers/lightnvm/pblk.h      | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 5f1e5b1b3094..5dae72e8b46b 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -342,13 +342,6 @@ void pblk_write_should_kick(struct pblk *pblk)
 		pblk_write_kick(pblk);
 }
 
-void pblk_end_io_sync(struct nvm_rq *rqd)
-{
-	struct completion *waiting = rqd->private;
-
-	complete(waiting);
-}
-
 static void pblk_wait_for_meta(struct pblk *pblk)
 {
 	do {
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 0c69eb880f56..5a4daf0b949d 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -796,7 +796,6 @@ void pblk_down_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas);
 void pblk_up_rq(struct pblk *pblk, struct ppa_addr *ppa_list, int nr_ppas,
 		unsigned long *lun_bitmap);
-void pblk_end_io_sync(struct nvm_rq *rqd);
 int pblk_bio_add_pages(struct pblk *pblk, struct bio *bio, gfp_t flags,
 		       int nr_pages);
 void pblk_bio_free_pages(struct pblk *pblk, struct bio *bio, int off,
-- 
2.11.0
