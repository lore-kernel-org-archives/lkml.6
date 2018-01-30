Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeA3N0S (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:26:18 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42573 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeA3N0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:26:16 -0500
X-Google-Smtp-Source: AH8x224oJbfMOQ0/BEiiRB6/fnSeVBgT3oa2u8G1OVzRb1aYfQHPBgnIbNuKO8il/k36IwG6X+UOgQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 1/2] lightnvm: remove mlc pairs structure
Date: Tue, 30 Jan 2018 14:26:04 +0100
Message-Id: <20180130132605.28635-1-m@bjorling.me>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The known implementations of the 1.2 specification, and upcoming 2.0
implementation all expose a sequential list of pages to write.
Remove the data structure, as it is no longer needed.

Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 50ef71ee3d86..16906327645e 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -116,17 +116,6 @@ struct nvme_nvm_command {
 	};
 };
 
-#define NVME_NVM_LP_MLC_PAIRS 886
-struct nvme_nvm_lp_mlc {
-	__le16			num_pairs;
-	__u8			pairs[NVME_NVM_LP_MLC_PAIRS];
-};
-
-struct nvme_nvm_lp_tbl {
-	__u8			id[8];
-	struct nvme_nvm_lp_mlc	mlc;
-};
-
 struct nvme_nvm_id_group {
 	__u8			mtype;
 	__u8			fmtype;
@@ -150,8 +139,7 @@ struct nvme_nvm_id_group {
 	__le32			mpos;
 	__le32			mccap;
 	__le16			cpar;
-	__u8			reserved[10];
-	struct nvme_nvm_lp_tbl lptbl;
+	__u8			reserved[906];
 } __packed;
 
 struct nvme_nvm_addr_format {
-- 
2.11.0
