Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323907-2-6088999922231544110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323906; b=EpUN4VD3pTvEsUCejsppLxIJuLgRgFumq1T/hFZfVbf4Gfw
    pKbBjB0dAAoYn+UmxDPO1q+T3zZWsb0+7RmSHwPInozI2pOvR82GMPe+KPTZDHeH
    +Oinrh2O/ePGrGXdRfHh/8SLvfnv21Qg5LYhu94hP12RaSRTPQmyEudDu8XaWO7c
    +FZvYc5+XRm6WOYR3bJETLXnUxamTxg2QNSS3C6NNBOmGdUnoIhNqz6owf5610xt
    y+FaP2zi5sOPYWka1xbwBcqmCzKlPj+bygx2JQEoBr1dL9Tw04Se3mYkSZMZIjK/
    vVenYW1o073n4Bb3rda6SNDxEMcE0l8TRdhMQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323906; bh=Laud0rmDv/zT6uBKtnQ
    0W6QsrbmKqzvymKCh0S2EqHY=; b=Y0TrIG1TjorTFPkjMTKNDak5517iVLCORMo
    AZF8QMDDJraCIwhP0Pytwsx7LwTPZJ7ZD4DeoKBEsRRiYCIJZpbyIC25rC5ZFkqc
    gFx8UYKVgYXgonH+v7u6Mq3RmNMpzX5rPJoQr18ylCE4IhNWEEbDkKE3RfPxLyXn
    e195GbWazYBbxUxH2ddcPWvEvyhKPBzeuLg/J9L3GPNuHNfu2IvVn2Wyx/2PTeTl
    ovDX4GokSkYyD8ZNVHk6K9Y6ebDyw72Gf/jNvuFMJ5djO3aGTM8il7cMytiroTvO
    e3BFB4Z/hAhawdTDMl2nN4KuQlge4tcpLnvUrMk+2pBMnNVU8/Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeBKEhn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:37:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41754 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752980AbeBKEeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Moshe David" <mdavid@infinidat.com>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Nicholas Bellinger" <nab@linux-iscsi.org>,
        "Hannes Reinecke" <hare@suse.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.785313088@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 064/136] target/iscsi: Fix iSCSI task reassignment
 handling
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@sandisk.com>

commit 59b6986dbfcdab96a971f9663221849de79a7556 upstream.

Allocate a task management request structure for all task management
requests, including task reassignment. This change avoids that the
se_tmr->response assignment dereferences an uninitialized se_tmr
pointer.

Reported-by: Moshe David <mdavid@infinidat.com>
Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Moshe David <mdavid@infinidat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
[bwh: Backported to 3.16:
 - Add definition of TMR_UNKNOWN
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1754,7 +1754,7 @@ iscsit_handle_task_mgt_cmd(struct iscsi_
 	struct iscsi_tm *hdr;
 	int out_of_order_cmdsn = 0, ret;
 	bool sess_ref = false;
-	u8 function;
+	u8 function, tcm_function = TMR_UNKNOWN;
 
 	hdr			= (struct iscsi_tm *) buf;
 	hdr->flags &= ~ISCSI_FLAG_CMD_FINAL;
@@ -1800,10 +1800,6 @@ iscsit_handle_task_mgt_cmd(struct iscsi_
 	 * LIO-Target $FABRIC_MOD
 	 */
 	if (function != ISCSI_TM_FUNC_TASK_REASSIGN) {
-
-		u8 tcm_function;
-		int ret;
-
 		transport_init_se_cmd(&cmd->se_cmd,
 				      &lio_target_fabric_configfs->tf_ops,
 				      conn->sess->se_sess, 0, DMA_NONE,
@@ -1840,15 +1836,14 @@ iscsit_handle_task_mgt_cmd(struct iscsi_
 			return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 		}
-
-		ret = core_tmr_alloc_req(&cmd->se_cmd, cmd->tmr_req,
-					 tcm_function, GFP_KERNEL);
-		if (ret < 0)
-			return iscsit_add_reject_cmd(cmd,
+	}
+	ret = core_tmr_alloc_req(&cmd->se_cmd, cmd->tmr_req, tcm_function,
+				 GFP_KERNEL);
+	if (ret < 0)
+		return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 
-		cmd->tmr_req->se_tmr_req = cmd->se_cmd.se_tmr_req;
-	}
+	cmd->tmr_req->se_tmr_req = cmd->se_cmd.se_tmr_req;
 
 	cmd->iscsi_opcode	= ISCSI_OP_SCSI_TMFUNC;
 	cmd->i_state		= ISTATE_SEND_TASKMGTRSP;
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -230,6 +230,7 @@ enum tcm_tmreq_table {
 	TMR_LUN_RESET		= 5,
 	TMR_TARGET_WARM_RESET	= 6,
 	TMR_TARGET_COLD_RESET	= 7,
+	TMR_UNKNOWN		= 0xff,
 };
 
 /* fabric independent task management response values */
