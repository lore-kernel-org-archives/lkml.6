Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324044-2-3168370803466216580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324044; b=J5CSTxd9fxv9DH5aa0mgH/t2ufDH5/RCU9rgeoRvWwQx2km
    CMm6aArfEhcAgtj43MKPk1YT0+Id9jI5m/0Z/F87JaiiHyS+JXjt9Baz+bJq32KY
    0Z5WAYwvuj2hTUaLAcrSaVgMN7wpGYBWpOLIirtz2qk37Z97v74s94Ns5XPPXIC4
    tQWHSfVbdiAHBJ8Ecx/N8JWh5SPfiva6GCA5wcAoMVj1otQuJQhwhjTCrbDnyY9W
    C2uA6JCl2WoF3XAfujNnX4yKuOMJN94DSBUItH6naW9ESnYIONeOP2/VToL03nsF
    CLp4I3Va+qOr5TMf0+WMnh0WavIDfBRYSmPETZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324044; bh=AHMrfT977YUQQ2ABGMg
    oSQp0Vlbz7hVxKcwSKzKU8jc=; b=jcpmgTG8Mu8BPNTOOtRUtnl6KVJmr6t/KOP
    t+RJiDCsUNexpt7PmYLPKXrttj8FFPk0mql4rwu2KHvOCc22cGgJHJUzi7NEkCQf
    +dvE+J6oZF8T/CuNy3C+uWEPP2twg2oTpEoUP3ZZJTicNQXKuvx1ZoyweruZhkG8
    3qaZ91YsW3O27hZ6wH2pvVsTrl2O7nfi+W+sap5iHtvOuinlWW0eL3doUDYGVMcS
    uaT5IIJlfSsRKb8jt4LbhF7wt+Qivy30FoIqM2CGdWf9k3ezhrU6aj7k1bQF270X
    MK8IpOr5kfCVpgwT8XShJpqXG7f/zVjS8+WxP8oTsL/6hwsjijQ==
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
        id S1753276AbeBKEi4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41718 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752960AbeBKEeJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:09 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mike Christie" <mchristi@redhat.com>,
        "Nicholas Bellinger" <nab@linux-iscsi.org>,
        "Hannes Reinecke" <hare@suse.com>, "Donald White" <dew@datera.io>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.139270687@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 065/136] iscsi-target: Make TASK_REASSIGN use proper
 se_cmd->cmd_kref
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

From: Nicholas Bellinger <nab@linux-iscsi.org>

commit ae072726f6109bb1c94841d6fb3a82dde298ea85 upstream.

Since commit 59b6986dbf fixed a potential NULL pointer dereference
by allocating a se_tmr_req for ISCSI_TM_FUNC_TASK_REASSIGN, the
se_tmr_req is currently leaked by iscsit_free_cmd() because no
iscsi_cmd->se_cmd.se_tfo was associated.

To address this, treat ISCSI_TM_FUNC_TASK_REASSIGN like any other
TMR and call transport_init_se_cmd() + target_get_sess_cmd() to
setup iscsi_cmd->se_cmd.se_tfo with se_cmd->cmd_kref of 2.

This will ensure normal release operation once se_cmd->cmd_kref
reaches zero and target_release_cmd_kref() is invoked, se_tmr_req
will be released via existing target_free_cmd_mem() and
core_tmr_release_req() code.

Reported-by: Donald White <dew@datera.io>
Cc: Donald White <dew@datera.io>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
[bwh: Backported to 3.16: Arguments passed to transport_init_se_cmd() and
 target_{get,put}_sess_cmd() are different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/target/iscsi/iscsi_target.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1753,7 +1753,6 @@ iscsit_handle_task_mgt_cmd(struct iscsi_
 	struct iscsi_tmr_req *tmr_req;
 	struct iscsi_tm *hdr;
 	int out_of_order_cmdsn = 0, ret;
-	bool sess_ref = false;
 	u8 function, tcm_function = TMR_UNKNOWN;
 
 	hdr			= (struct iscsi_tm *) buf;
@@ -1795,19 +1794,18 @@ iscsit_handle_task_mgt_cmd(struct iscsi_
 					     buf);
 	}
 
+	transport_init_se_cmd(&cmd->se_cmd,
+			      &lio_target_fabric_configfs->tf_ops,
+			      conn->sess->se_sess, 0, DMA_NONE,
+			      MSG_SIMPLE_TAG, cmd->sense_buffer + 2);
+
+	target_get_sess_cmd(conn->sess->se_sess, &cmd->se_cmd, true);
+
 	/*
 	 * TASK_REASSIGN for ERL=2 / connection stays inside of
 	 * LIO-Target $FABRIC_MOD
 	 */
 	if (function != ISCSI_TM_FUNC_TASK_REASSIGN) {
-		transport_init_se_cmd(&cmd->se_cmd,
-				      &lio_target_fabric_configfs->tf_ops,
-				      conn->sess->se_sess, 0, DMA_NONE,
-				      MSG_SIMPLE_TAG, cmd->sense_buffer + 2);
-
-		target_get_sess_cmd(conn->sess->se_sess, &cmd->se_cmd, true);
-		sess_ref = true;
-
 		switch (function) {
 		case ISCSI_TM_FUNC_ABORT_TASK:
 			tcm_function = TMR_ABORT_TASK;
@@ -1944,12 +1942,8 @@ attach:
 	 * For connection recovery, this is also the default action for
 	 * TMR TASK_REASSIGN.
 	 */
-	if (sess_ref) {
-		pr_debug("Handle TMR, using sess_ref=true check\n");
-		target_put_sess_cmd(conn->sess->se_sess, &cmd->se_cmd);
-	}
-
 	iscsit_add_cmd_to_response_queue(cmd, conn, cmd->i_state);
+	target_put_sess_cmd(conn->sess->se_sess, &cmd->se_cmd);
 	return 0;
 }
 EXPORT_SYMBOL(iscsit_handle_task_mgt_cmd);
