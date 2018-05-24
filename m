Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162636-2-4045398351575713572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162635; b=ALENE9aOA7RjUWEJImyTHFwzoH8AVhbp2JQLrYV4J+u3IuRUEE
    v0GUIrqQjZF/3z2HubvXODgTYQEiqQhEBSjKeFjNKg4jjeMmcDhRyEqfxOtypC4b
    K2GR3Q6+p6DqS08wzxn2YE4JWJkdYK4XNdwwzApjcHU01H/6mNO0CcwWSjvVW26R
    06aHnEGHJf/Pn23tXLM4Tpq8zq41zyqhb2LsQF56tjXb1lY2CqApGfjVEe0b21Ja
    /dvqlkBl9BirtuvhqAvCzuEWgbkcQqSVjqwwbc2Gn9ZrtK8DeeWZPV6LRRj/TpQy
    f9mztFMl8JbwfeRRZya+4Cjqww3mUOyLOwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162635; bh=9IdoMTgcTd91z6avBcfD8MFtpXitAv
    xgPS2U5pRyAnQ=; b=iTpFZaV3/rGc3N5RdZmzCC1AgOw9rSOOe1zPDT2TeHaUbW
    jkxvxbBN7Th80wrhKUy/s1D2UiKvaSA5YfJY+xxomUTW0YItXOIPz9bNmYuY/6Sa
    PQ1xXWjw8QNzQ1IT/XAOa0y1dBEs6654Xsom7u55Ko/oJwJAvNtCA1aTSUnqsi0U
    NFn2gAnjkOg+Ur2UGwbU1P+GykGNPqwFu+OOX/b8kX/FZo9ynNJj9zvI1h6hrUAc
    Ls+a/GvZj4jLbMD9TGyFKqwSJSLvxGo2tLozKnbGX9/6/bD58GfjvVZ0JqIUOdRy
    5EX6VrZpWyG9BYcqo/Q/ZYsV1Er3ns99i3+punpQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Nyx356lE x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Nyx356lE x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN8VbZOdWCOawkMmMcFnEgIzSjhjyJwYDOOsoFs+EkkNDnuDLbXM10e2ikv8odB0LCw7CSDe8kpJiFkZp/ujlxMfqIormbyy3tPmvnjNKAUJ8iOZUqWD
    +/Tvf+X64eiluwcT5Tr3j3Tgmf1GPgfCxpvJYKqTxfLHAu2GnEl9jM54Xn3G2gbbma3jq9xvpckxR1TyOdLQKsiEpT5Dzv8RM35LOri3y+i8E8IsVm4i2ZfZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8
    a=uMzUHNzdoPdU1YanuOsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969334AbeEXLuR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966985AbeEXJq6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 86/92] scsi: zfcp: fix infinite iteration on ERP ready list
Date: Thu, 24 May 2018 11:39:03 +0200
Message-Id: <20180524093207.536307801@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Remus <jremus@linux.ibm.com>

commit fa89adba1941e4f3b213399b81732a5c12fd9131 upstream.

zfcp_erp_adapter_reopen() schedules blocking of all of the adapter's
rports via zfcp_scsi_schedule_rports_block() and enqueues a reopen
adapter ERP action via zfcp_erp_action_enqueue(). Both are separately
processed asynchronously and concurrently.

Blocking of rports is done in a kworker by zfcp_scsi_rport_work(). It
calls zfcp_scsi_rport_block(), which then traces a DBF REC "scpdely" via
zfcp_dbf_rec_trig().  zfcp_dbf_rec_trig() acquires the DBF REC spin lock
and then iterates with list_for_each() over the adapter's ERP ready list
without holding the ERP lock. This opens a race window in which the
current list entry can be moved to another list, causing list_for_each()
to iterate forever on the wrong list, as the erp_ready_head is never
encountered as terminal condition.

Meanwhile the ERP action can be processed in the ERP thread by
zfcp_erp_thread(). It calls zfcp_erp_strategy(), which acquires the ERP
lock and then calls zfcp_erp_action_to_running() to move the ERP action
from the ready to the running list.  zfcp_erp_action_to_running() can
move the ERP action using list_move() just during the aforementioned
race window. It then traces a REC RUN "erator1" via zfcp_dbf_rec_run().
zfcp_dbf_rec_run() tries to acquire the DBF REC spin lock. If this is
held by the infinitely looping kworker, it effectively spins forever.

Example Sequence Diagram:

Process                ERP Thread             rport_work
-------------------    -------------------    -------------------
zfcp_erp_adapter_reopen()
zfcp_erp_adapter_block()
zfcp_scsi_schedule_rports_block()
lock ERP                                      zfcp_scsi_rport_work()
zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_ADAPTER)
list_add_tail() on ready                      !(rport_task==RPORT_ADD)
wake_up() ERP thread                          zfcp_scsi_rport_block()
zfcp_dbf_rec_trig()    zfcp_erp_strategy()    zfcp_dbf_rec_trig()
unlock ERP                                    lock DBF REC
zfcp_erp_wait()        lock ERP
|                      zfcp_erp_action_to_running()
|                                             list_for_each() ready
|                      list_move()              current entry
|                        ready to running
|                      zfcp_dbf_rec_run()       endless loop over running
|                      zfcp_dbf_rec_run_lvl()
|                      lock DBF REC spins forever

Any adapter recovery can trigger this, such as setting the device offline
or reboot.

V4.9 commit 4eeaa4f3f1d6 ("zfcp: close window with unblocked rport
during rport gone") introduced additional tracing of (un)blocking of
rports. It missed that the adapter->erp_lock must be held when calling
zfcp_dbf_rec_trig().

This fix uses the approach formerly introduced by commit aa0fec62391c
("[SCSI] zfcp: Fix sparse warning by providing new entry in dbf") that got
later removed by commit ae0904f60fab ("[SCSI] zfcp: Redesign of the debug
tracing for recovery actions.").

Introduce zfcp_dbf_rec_trig_lock(), a wrapper for zfcp_dbf_rec_trig() that
acquires and releases the adapter->erp_lock for read.

Reported-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Fixes: 4eeaa4f3f1d6 ("zfcp: close window with unblocked rport during rport gone")
Cc: <stable@vger.kernel.org> # 2.6.32+
Reviewed-by: Benjamin Block <bblock@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_dbf.c  |   23 ++++++++++++++++++++++-
 drivers/s390/scsi/zfcp_ext.h  |    5 ++++-
 drivers/s390/scsi/zfcp_scsi.c |   14 +++++++-------
 3 files changed, 33 insertions(+), 9 deletions(-)

--- a/drivers/s390/scsi/zfcp_dbf.c
+++ b/drivers/s390/scsi/zfcp_dbf.c
@@ -3,7 +3,7 @@
  *
  * Debug traces for zfcp.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -287,6 +287,27 @@ void zfcp_dbf_rec_trig(char *tag, struct
 	spin_unlock_irqrestore(&dbf->rec_lock, flags);
 }
 
+/**
+ * zfcp_dbf_rec_trig_lock - trace event related to triggered recovery with lock
+ * @tag: identifier for event
+ * @adapter: adapter on which the erp_action should run
+ * @port: remote port involved in the erp_action
+ * @sdev: scsi device involved in the erp_action
+ * @want: wanted erp_action
+ * @need: required erp_action
+ *
+ * The adapter->erp_lock must not be held.
+ */
+void zfcp_dbf_rec_trig_lock(char *tag, struct zfcp_adapter *adapter,
+			    struct zfcp_port *port, struct scsi_device *sdev,
+			    u8 want, u8 need)
+{
+	unsigned long flags;
+
+	read_lock_irqsave(&adapter->erp_lock, flags);
+	zfcp_dbf_rec_trig(tag, adapter, port, sdev, want, need);
+	read_unlock_irqrestore(&adapter->erp_lock, flags);
+}
 
 /**
  * zfcp_dbf_rec_run_lvl - trace event related to running recovery
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -3,7 +3,7 @@
  *
  * External function declarations.
  *
- * Copyright IBM Corp. 2002, 2016
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #ifndef ZFCP_EXT_H
@@ -34,6 +34,9 @@ extern int zfcp_dbf_adapter_register(str
 extern void zfcp_dbf_adapter_unregister(struct zfcp_adapter *);
 extern void zfcp_dbf_rec_trig(char *, struct zfcp_adapter *,
 			      struct zfcp_port *, struct scsi_device *, u8, u8);
+extern void zfcp_dbf_rec_trig_lock(char *tag, struct zfcp_adapter *adapter,
+				   struct zfcp_port *port,
+				   struct scsi_device *sdev, u8 want, u8 need);
 extern void zfcp_dbf_rec_run(char *, struct zfcp_erp_action *);
 extern void zfcp_dbf_rec_run_lvl(int level, char *tag,
 				 struct zfcp_erp_action *erp);
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -3,7 +3,7 @@
  *
  * Interface to Linux SCSI midlayer.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -616,9 +616,9 @@ static void zfcp_scsi_rport_register(str
 	ids.port_id = port->d_id;
 	ids.roles = FC_RPORT_ROLE_FCP_TARGET;
 
-	zfcp_dbf_rec_trig("scpaddy", port->adapter, port, NULL,
-			  ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD,
-			  ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD);
+	zfcp_dbf_rec_trig_lock("scpaddy", port->adapter, port, NULL,
+			       ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD,
+			       ZFCP_PSEUDO_ERP_ACTION_RPORT_ADD);
 	rport = fc_remote_port_add(port->adapter->scsi_host, 0, &ids);
 	if (!rport) {
 		dev_err(&port->adapter->ccw_device->dev,
@@ -640,9 +640,9 @@ static void zfcp_scsi_rport_block(struct
 	struct fc_rport *rport = port->rport;
 
 	if (rport) {
-		zfcp_dbf_rec_trig("scpdely", port->adapter, port, NULL,
-				  ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL,
-				  ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL);
+		zfcp_dbf_rec_trig_lock("scpdely", port->adapter, port, NULL,
+				       ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL,
+				       ZFCP_PSEUDO_ERP_ACTION_RPORT_DEL);
 		fc_remote_port_delete(rport);
 		port->rport = NULL;
 	}
