Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA97C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8E02075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 04:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksjQ7VM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8E02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeIFJKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 05:10:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55085 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeIFJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 05:10:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so9976496wmb.4;
        Wed, 05 Sep 2018 21:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jrP+uifvr7tPAyyU0KvnJrThnPNwdpdoWfrDnDXnVjM=;
        b=ksjQ7VM21+jUFt8GFFlMLzH9iEHhzrmJXp1Go3jtpHUldEK8P/rUZUu60gH9zchrps
         zAl5asDXD4X2hqIIc6v1UyxEzPcMdLeDxRAQ68y9z58v2IQ1DQSC7o7PfgE2y7KyiaVA
         Ef2y4JJBIAbUM6UTQAeRCTJjGN4E65Q7n1+gCId9/mpNcaOzFC8OkZvzmQKAuvw/O1qt
         oNNlHq2vc6Sg9hRstujEzAJF8Wbu25U136Gy29MZ8N8jI691V1O5ZUdTfVWdWTgx07pE
         izQ9Hgbb0TzjGP6wNpS5mY/n5AnmuGOP/1ce5tcSOm2qxKI4/tthQGkpmPVR7LHke6Im
         UAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jrP+uifvr7tPAyyU0KvnJrThnPNwdpdoWfrDnDXnVjM=;
        b=G7RBqs0FrlpS34ddwtPY1UDFHNqNM9+ST2G2nsI0OUjChpDcXIpGMi2ec1olZvtTMJ
         tH33T+BKhlPaPu1zDigYGXciDkGRDs1YL5YHwCM0q006nDyH92uMiXRf6aiqkyb8GFSn
         I12QsnUk+2Pt7QCzZYnqBq+/js/p8IhSobUEBlKq8ve+lgVl0R7evWFWSvj+HUBXz4qz
         qsvtWUokwtd7Vmfio6OD5CaYs4lr3UYCI3BT3wbYKgoK4re0iDXWO4VwcmDuTcUJc8oo
         jN1S2vTeb6i8B+Hhbu1qJPI5KXHUJMeHQseo4C3iW3SJNMinqsQ4JyAbKsorBtpMLDBh
         aS9A==
X-Gm-Message-State: APzg51AYSzukcN4ChorODu0TPaPi7CTKymoMMYMUQKmiiBLnNNx1U8Jg
        KwhXxeNOpMPA902Bvj8lDw59J/oJw7I=
X-Google-Smtp-Source: ANB0Vdaoyw1cVRt5U+fEn78SiwZLVAwUcdvfcSDgld+v+5baMglgBm9QqCqcTshpBUQdh0YCpqk2QA==
X-Received: by 2002:a1c:2108:: with SMTP id h8-v6mr805530wmh.108.1536208628050;
        Wed, 05 Sep 2018 21:37:08 -0700 (PDT)
Received: from alpaca.bmw-carit.intra ([145.253.130.2])
        by smtp.gmail.com with ESMTPSA id k5-v6sm9243936wrm.96.2018.09.05.21.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 21:37:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, QLogic-Storage-Upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        QLogic-Storage-Upstream@cavium.com, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fcoe: make use of fip_mode enum complete
Date:   Thu,  6 Sep 2018 06:36:42 +0200
Message-Id: <1536208602-25765-1-git-send-email-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1917d42d14b7 ("fcoe: use enum for fip_mode") introduces a separate
enum for the fip_mode that shall be used during initialisation handling
until it is passed to fcoe_ctrl_link_up to set the initial fip_state.
That change was incomplete and gcc quietly converted in various places
between the fip_mode and the fip_state enum values with implicit enum
conversions, which fortunately cannot cause any issues in the actual
code's execution.

clang however warns about these implicit enum conversions in the scsi
drivers. This commit consolidates the use of the two enums, guided by
clang's enum-conversion warnings.

This commit now completes the use of the fip_mode:
It expects and uses fip_mode in {bnx2fc,fcoe}_interface_create and
fcoe_ctlr_init, and it explicitly converts from fip_mode to fip_state
only at the single point in fcoe_ctlr_link_up.

To eliminate that adding or removing values from fip_mode or fip_state enum
break the right mapping of values, all fip_mode values are assigned to
their fip_state counterparts.

Fixes: 1917d42d14b7 ("fcoe: use enum for fip_mode")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
checkpatch.pl complains about:
WARNING: function definition argument 'struct fcoe_ctlr *' should also have an identifier name
#133: FILE: include/scsi/libfcoe.h:253:
+void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_mode);

I can address that with:
-void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_mode);
+void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode);

However, all the other FIP API function signatures currently also have no
identifier name; so I will keep that line as-is for local consistency.

If I should address the checkpatch.pl issue, I can provide a separate
patch to make all fcoe functions in the header follow the coding style
suggested by checkpatch.pl. Just let me know what you want.

compile tested allyesconfig on top of next-20180831 with gcc-8.2.0,
clang-6.0.1 and clang-7

 drivers/scsi/bnx2fc/bnx2fc_fcoe.c  | 2 +-
 drivers/scsi/fcoe/fcoe.c           | 2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c      | 4 ++--
 drivers/scsi/fcoe/fcoe_transport.c | 2 +-
 drivers/scsi/qedf/qedf_main.c      | 2 +-
 include/scsi/libfcoe.h             | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index f000458..83aaab4 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1445,7 +1445,7 @@ static struct bnx2fc_hba *bnx2fc_hba_create(struct cnic_dev *cnic)
 static struct bnx2fc_interface *
 bnx2fc_interface_create(struct bnx2fc_hba *hba,
 			struct net_device *netdev,
-			enum fip_state fip_mode)
+			enum fip_mode fip_mode)
 {
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct bnx2fc_interface *interface;
diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f46b312..6768b2e 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -390,7 +390,7 @@ static int fcoe_interface_setup(struct fcoe_interface *fcoe,
  * Returns: pointer to a struct fcoe_interface or NULL on error
  */
 static struct fcoe_interface *fcoe_interface_create(struct net_device *netdev,
-						    enum fip_state fip_mode)
+						    enum fip_mode fip_mode)
 {
 	struct fcoe_ctlr_device *ctlr_dev;
 	struct fcoe_ctlr *ctlr;
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 54da316..a52d3ad 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -147,7 +147,7 @@ static void fcoe_ctlr_map_dest(struct fcoe_ctlr *fip)
  * fcoe_ctlr_init() - Initialize the FCoE Controller instance
  * @fip: The FCoE controller to initialize
  */
-void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_state mode)
+void fcoe_ctlr_init(struct fcoe_ctlr *fip, enum fip_mode mode)
 {
 	fcoe_ctlr_set_state(fip, FIP_ST_LINK_WAIT);
 	fip->mode = mode;
@@ -454,7 +454,7 @@ void fcoe_ctlr_link_up(struct fcoe_ctlr *fip)
 		mutex_unlock(&fip->ctlr_mutex);
 		fc_linkup(fip->lp);
 	} else if (fip->state == FIP_ST_LINK_WAIT) {
-		fcoe_ctlr_set_state(fip, fip->mode);
+		fcoe_ctlr_set_state(fip, (enum fip_state) fip->mode);
 		switch (fip->mode) {
 		default:
 			LIBFCOE_FIP_DBG(fip, "invalid mode %d\n", fip->mode);
diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index f4909cd..b381ab0 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -873,7 +873,7 @@ static int fcoe_transport_create(const char *buffer,
 	int rc = -ENODEV;
 	struct net_device *netdev = NULL;
 	struct fcoe_transport *ft = NULL;
-	enum fip_state fip_mode = (enum fip_state)(long)kp->arg;
+	enum fip_mode fip_mode = (enum fip_mode)(long)kp->arg;
 
 	mutex_lock(&ft_mutex);
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 0a5dd55..cd61905 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -1418,7 +1418,7 @@ static struct libfc_function_template qedf_lport_template = {
 
 static void qedf_fcoe_ctlr_setup(struct qedf_ctx *qedf)
 {
-	fcoe_ctlr_init(&qedf->ctlr, FIP_ST_AUTO);
+	fcoe_ctlr_init(&qedf->ctlr, FIP_MODE_AUTO);
 
 	qedf->ctlr.send = qedf_fip_send;
 	qedf->ctlr.get_src_addr = qedf_get_src_mac;
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index cb8a273..10d6d92 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -80,9 +80,9 @@ enum fip_state {
  */
 enum fip_mode {
 	FIP_MODE_AUTO = FIP_ST_AUTO,
-	FIP_MODE_NON_FIP,
-	FIP_MODE_FABRIC,
-	FIP_MODE_VN2VN,
+	FIP_MODE_NON_FIP = FIP_ST_NON_FIP,
+	FIP_MODE_FABRIC = FIP_ST_ENABLED,
+	FIP_MODE_VN2VN = FIP_ST_VNMP_START,
 };
 
 /**
@@ -250,7 +250,7 @@ struct fcoe_rport {
 };
 
 /* FIP API functions */
-void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_state);
+void fcoe_ctlr_init(struct fcoe_ctlr *, enum fip_mode);
 void fcoe_ctlr_destroy(struct fcoe_ctlr *);
 void fcoe_ctlr_link_up(struct fcoe_ctlr *);
 int fcoe_ctlr_link_down(struct fcoe_ctlr *);
-- 
2.7.4

