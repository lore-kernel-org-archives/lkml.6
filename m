Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeBIMOS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:14:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33845 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeBIMOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:14:16 -0500
From: Colin King <colin.king@canonical.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] CIFS: SMBD: fix spelling mistake: "faield" and "legnth"
Date: Fri,  9 Feb 2018 12:14:15 +0000
Message-Id: <20180209121415.564-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in log_rdma_send and log_rdma_mr
message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/smbdirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 91710eb571fb..5aa0b54b32ce 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -1025,7 +1025,7 @@ static int smbd_post_send(struct smbd_connection *info,
 
 	for (i = 0; i < request->num_sge; i++) {
 		log_rdma_send(INFO,
-			"rdma_request sge[%d] addr=%llu legnth=%u\n",
+			"rdma_request sge[%d] addr=%llu length=%u\n",
 			i, request->sge[0].addr, request->sge[0].length);
 		ib_dma_sync_single_for_device(
 			info->id->device,
@@ -2295,7 +2295,7 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 				rc = ib_dereg_mr(smbdirect_mr->mr);
 				if (rc) {
 					log_rdma_mr(ERR,
-						"ib_dereg_mr faield rc=%x\n",
+						"ib_dereg_mr failed rc=%x\n",
 						rc);
 					smbd_disconnect_rdma_connection(info);
 				}
-- 
2.15.1
