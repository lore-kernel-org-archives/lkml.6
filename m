Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeC2WMY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:12:24 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41334 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeC2WHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:21 -0400
X-Google-Smtp-Source: AIpwx4+dDrscTmjRXE3Bnv9mpt2oVkKbj7iyTXXbrdFT8HeRNlIwaB54/+hl7fMMOowWsAcaeu4MUQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Heiner Litz <hlitz@ucsc.edu>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 21/37] lightnvm: Avoid validation of default op value
Date: Fri, 30 Mar 2018 00:05:08 +0200
Message-Id: <20180329220524.30363-22-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Litz <hlitz@ucsc.edu>

Fixes: 38401d231de65 ("lightnvm: set target over-provision on create ioctl")
Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 5b197d6bb6d9..c4f12b1ae8b8 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -304,11 +304,9 @@ static int __nvm_config_extended(struct nvm_dev *dev,
 	}
 
 	/* op not set falls into target's default */
-	if (e->op == 0xFFFF)
+	if (e->op == 0xFFFF) {
 		e->op = NVM_TARGET_DEFAULT_OP;
-
-	if (e->op < NVM_TARGET_MIN_OP ||
-	    e->op > NVM_TARGET_MAX_OP) {
+	} else if (e->op < NVM_TARGET_MIN_OP || e->op > NVM_TARGET_MAX_OP) {
 		pr_err("nvm: invalid over provisioning value\n");
 		return -EINVAL;
 	}
-- 
2.11.0
