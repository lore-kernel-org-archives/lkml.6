Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753904AbeD3JLU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:11:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37291 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbeD3JK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:10:27 -0400
X-Google-Smtp-Source: AB8JxZoadQKFu3qUpaW+K+UwMwaYixyP+wnJ1YyfLK4NcMz6hSRHQPk+moHj6vl0+HhUXeV+XtGFMw==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 11/11] lightnvm: pblk: remove dead function
Date: Mon, 30 Apr 2018 11:10:09 +0200
Message-Id: <1525079409-6588-12-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
References: <1525079409-6588-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead function for manual sync. I/O

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 7 -------
 drivers/lightnvm/pblk.h      | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index cc34d5d9652d..5f960a6609c8 100644
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
index 4b725bedc36a..9838d03e1f21 100644
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
2.7.4
