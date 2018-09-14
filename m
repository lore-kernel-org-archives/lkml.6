Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA07FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3AC20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3AC20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeINRm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:42:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57883 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeINRm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:42:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g0nCi-0003qG-WC; Fri, 14 Sep 2018 12:28:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Nicholas A . Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bvanassche@acm.org>,
        target-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: iscsi: target: fix spelling mistake "entires" -> "entries"
Date:   Fri, 14 Sep 2018 13:28:08 +0100
Message-Id: <20180914122808.5447-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in function name and comment

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/target/iscsi/iscsi_target.c       | 2 +-
 drivers/target/iscsi/iscsi_target_erl2.c  | 2 +-
 drivers/target/iscsi/iscsi_target_erl2.h  | 2 +-
 drivers/target/iscsi/iscsi_target_login.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index cc756a123fd8..c1d5a173553d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4355,7 +4355,7 @@ int iscsit_close_session(struct iscsi_session *sess)
 	transport_deregister_session(sess->se_sess);
 
 	if (sess->sess_ops->ErrorRecoveryLevel == 2)
-		iscsit_free_connection_recovery_entires(sess);
+		iscsit_free_connection_recovery_entries(sess);
 
 	iscsit_free_all_ooo_cmdsns(sess);
 
diff --git a/drivers/target/iscsi/iscsi_target_erl2.c b/drivers/target/iscsi/iscsi_target_erl2.c
index 8df9c90f3db3..b08b620b1bf0 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.c
+++ b/drivers/target/iscsi/iscsi_target_erl2.c
@@ -125,7 +125,7 @@ struct iscsi_conn_recovery *iscsit_get_inactive_connection_recovery_entry(
 	return NULL;
 }
 
-void iscsit_free_connection_recovery_entires(struct iscsi_session *sess)
+void iscsit_free_connection_recovery_entries(struct iscsi_session *sess)
 {
 	struct iscsi_cmd *cmd, *cmd_tmp;
 	struct iscsi_conn_recovery *cr, *cr_tmp;
diff --git a/drivers/target/iscsi/iscsi_target_erl2.h b/drivers/target/iscsi/iscsi_target_erl2.h
index 93e180d68d07..a39b0caf2337 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.h
+++ b/drivers/target/iscsi/iscsi_target_erl2.h
@@ -13,7 +13,7 @@ extern void iscsit_create_conn_recovery_datain_values(struct iscsi_cmd *, __be32
 extern void iscsit_create_conn_recovery_dataout_values(struct iscsi_cmd *);
 extern struct iscsi_conn_recovery *iscsit_get_inactive_connection_recovery_entry(
 			struct iscsi_session *, u16);
-extern void iscsit_free_connection_recovery_entires(struct iscsi_session *);
+extern void iscsit_free_connection_recovery_entries(struct iscsi_session *);
 extern int iscsit_remove_active_connection_recovery_entry(
 			struct iscsi_conn_recovery *, struct iscsi_session *);
 extern int iscsit_remove_cmd_from_connection_recovery(struct iscsi_cmd *,
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index bb90c80ff388..ae3209efd0e0 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -578,7 +578,7 @@ int iscsi_login_post_auth_non_zero_tsih(
 	}
 
 	/*
-	 * Check for any connection recovery entires containing CID.
+	 * Check for any connection recovery entries containing CID.
 	 * We use the original ExpStatSN sent in the first login request
 	 * to acknowledge commands for the failed connection.
 	 *
-- 
2.17.1

