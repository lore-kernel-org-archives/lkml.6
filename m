Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323940-2-11598794592635269177
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323939; b=mqw8N/RV/8e2B2wpPWiuH7YsJLL4t4v4lbl83hkHtt6umKt
    ylFW/va3gUCVxQfOPRLDepMZi5SSrpsMTvf7IyjhdT/yHPwYSua0LbUIO4DhQ696
    RVfUTucUYvRlzMOiH64tf7/9522ThwzyYoWQUIejgZTPAU7smZlT4CkkC5Bd0i4g
    f8EpQ4cxb3oD7Na05xDLW0g+sCRVelD0VCUp+okxFG2kAEXNvLdI0B2k7JKQh0F6
    GaGgJff4UrjdlWF6X/cKMlzfOsTwT4B02yWEJgIaNp2yT7ZAY42ZIryQc6RKe1CV
    hvZKOf08TIdXqjyPuy/UtRqzHJcoEIZ48wxsA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323939; bh=YdLLuiZjKJUH/7TGpgE
    8GH4nAinrzFGKJM00pCHITVM=; b=J74/I+/38zPAHBcduaZLHGmHKvyOn3fueO+
    SX2j6gkXQynKaCwAkHhQNBMKv4bBUUe3rb7Cf4yu5UX8iwwBXzv9RD4gASXNTZW8
    wrGpjsvQMH5rSce/+ozyZFABOLZ60yrm7hACqeP4E9/hdnlkp4wZrtIJCmHskTyG
    KkqDzv1qIGqAKHWLx6CjLOjsNc9YhwJfGuknrFzjLyrRglMTzNTIWro4X15RrAN8
    ys6O8TWqEUe51nkmCe9MOIgoxW2A0qbAK1nwK92HT7UYi5u53yv2d3uWKkbScUDd
    ZDmvEzcm9gS9EjIsid378tFn4mlq3ILj2UBt9f5ri6ekjPY1r3w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeBKEi4 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41697 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752958AbeBKEeJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:09 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hannes Reinecke" <hare@suse.com>,
        "Donald White" <dew@datera.io>,
        "Mike Christie" <mchristi@redhat.com>,
        "Nicholas Bellinger" <nab@linux-iscsi.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.300701618@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 063/136] target: Avoid early CMD_T_PRE_EXECUTE
 failures during ABORT_TASK
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

commit 1c21a48055a67ceb693e9c2587824a8de60a217c upstream.

This patch fixes bug where early se_cmd exceptions that occur
before backend execution can result in use-after-free if/when
a subsequent ABORT_TASK occurs for the same tag.

Since an early se_cmd exception will have had se_cmd added to
se_session->sess_cmd_list via target_get_sess_cmd(), it will
not have CMD_T_COMPLETE set by the usual target_complete_cmd()
backend completion path.

This causes a subsequent ABORT_TASK + __target_check_io_state()
to signal ABORT_TASK should proceed.  As core_tmr_abort_task()
executes, it will bring the outstanding se_cmd->cmd_kref count
down to zero releasing se_cmd, after se_cmd has already been
queued with error status into fabric driver response path code.

To address this bug, introduce a CMD_T_PRE_EXECUTE bit that is
set at target_get_sess_cmd() time, and cleared immediately before
backend driver dispatch in target_execute_cmd() once CMD_T_ACTIVE
is set.

Then, check CMD_T_PRE_EXECUTE within __target_check_io_state() to
determine when an early exception has occured, and avoid aborting
this se_cmd since it will have already been queued into fabric
driver response path code.

Reported-by: Donald White <dew@datera.io>
Cc: Donald White <dew@datera.io>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
[bwh: Backported to 3.16:
 - Use target_core_fabric_ops::get_task_tag to get the tag and %u to format it
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/target/target_core_tmr.c       | 9 +++++++++
 drivers/target/target_core_transport.c | 2 ++
 include/target/target_core_base.h      | 1 +
 3 files changed, 12 insertions(+)

--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -141,6 +141,16 @@ static bool __target_check_io_state(stru
 		spin_unlock(&se_cmd->t_state_lock);
 		return false;
 	}
+	if (se_cmd->transport_state & CMD_T_PRE_EXECUTE) {
+		if (se_cmd->scsi_status) {
+			pr_debug("Attempted to abort io tag: %u early failure"
+				 " status: 0x%02x\n",
+				 se_cmd->se_tfo->get_task_tag(se_cmd),
+				 se_cmd->scsi_status);
+			spin_unlock(&se_cmd->t_state_lock);
+			return false;
+		}
+	}
 	if (sess->sess_tearing_down || se_cmd->cmd_wait_set) {
 		pr_debug("Attempted to abort io tag: %u already shutdown,"
 			" skipping\n", se_cmd->se_tfo->get_task_tag(se_cmd));
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1797,6 +1797,7 @@ void target_execute_cmd(struct se_cmd *c
 	}
 
 	cmd->t_state = TRANSPORT_PROCESSING;
+	cmd->transport_state &= ~CMD_T_PRE_EXECUTE;
 	cmd->transport_state |= CMD_T_ACTIVE|CMD_T_BUSY|CMD_T_SENT;
 	spin_unlock_irq(&cmd->t_state_lock);
 	/*
@@ -2441,6 +2442,7 @@ int target_get_sess_cmd(struct se_sessio
 		ret = -ESHUTDOWN;
 		goto out;
 	}
+	se_cmd->transport_state |= CMD_T_PRE_EXECUTE;
 	list_add_tail(&se_cmd->se_cmd_list, &se_sess->sess_cmd_list);
 out:
 	spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -536,6 +536,7 @@ struct se_cmd {
 #define CMD_T_BUSY		(1 << 9)
 #define CMD_T_TAS		(1 << 10)
 #define CMD_T_FABRIC_STOP	(1 << 11)
+#define CMD_T_PRE_EXECUTE	(1 << 12)
 	spinlock_t		t_state_lock;
 	struct completion	t_transport_stop_comp;
 
