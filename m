Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518709857-2-15566694521069977850
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709856; b=c1gZ9QamK7WFcIciCsq1xOY5howKg571XQ36T/fZj8iZ5O+
    6mHNdlQQIGllC28NJrK8cz+f1vgLbBWV1MEbmRKj51/y7nyit74V3Ku+C6Hl/G0Y
    yrlw/qPSnVm82kuYle8nbdacIQkkN+WtEyC9JzaaVh8DDAs2KVPbQh7qJ0tSytx1
    qyc1Ek0SWqo3bZxo52TKQ+yuBd0g4krwxizEmInCxG61erKjrNVbc6FSXIFBOEWO
    TjJDGl2TOwxMSqyH6D5LelbRKz5Lx/QmmSVDIFjYZKOny983pSeZTyD2IU7ZvO60
    DJFwbSR3MAoraWiQRT7xZHokDMz+TflVVErhACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709856; bh=bw20p7nQhFQbbzTdwHcMmSXFjI
    AtyD2LMcYW4uJZu0o=; b=ddGCLIsuMGIC5b4byLfwEYgea0IjrgJAKweapJw6pY
    rjhVK0lg1vQ5kfPUDju0FWY5Z04Ss3enKpnaDQ+GPeN8L2nyUX+AT2vHYnMwAA0B
    1fx7yjSXdB98/2O/7woJCIve93WpGpY/Fzw607HXXGqv0+9DeuWczlI2Yq/XFIR2
    5zqHapbTt7mR7tyZ1fIQyACSgGaaK2Hq1TIaFhccTvMDuPYyLDIn5Yrjb7w9PyX7
    tVHyUG6Kx1igGDOdSZ2CdOnckbPfDcwCxSkRvJ5ws0UB660x8gpraUh7/dXBtNZW
    wOPq7KZmx+gSbHrPK2y04MZgn5vqaKq2L1D5i/oGNGxw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424576AbeBOPrz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:47:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424974AbeBOPru (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 200/202] scsi: core: Ensure that the SCSI error handler gets woken up
Date: Thu, 15 Feb 2018 16:18:20 +0100
Message-Id: <20180215151723.119583957@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 3bd6f43f5cb3714f70c591514f344389df593501 upstream.

If scsi_eh_scmd_add() is called concurrently with
scsi_host_queue_ready() while shost->host_blocked > 0 then it can
happen that neither function wakes up the SCSI error handler. Fix
this by making every function that decreases the host_busy counter
wake up the error handler if necessary and by protecting the
host_failed checks with the SCSI host lock.

Reported-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: https://marc.info/?l=linux-kernel&m=150461610630736
Fixes: commit 746650160866 ("scsi: convert host_busy to atomic_t")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/hosts.c      |    6 ++++++
 drivers/scsi/scsi_error.c |   18 ++++++++++++++++--
 drivers/scsi/scsi_lib.c   |   39 ++++++++++++++++++++++++++++-----------
 include/scsi/scsi_host.h  |    2 ++
 4 files changed, 52 insertions(+), 13 deletions(-)

--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -318,6 +318,9 @@ static void scsi_host_dev_release(struct
 
 	scsi_proc_hostdir_rm(shost->hostt);
 
+	/* Wait for functions invoked through call_rcu(&shost->rcu, ...) */
+	rcu_barrier();
+
 	if (shost->tmf_work_q)
 		destroy_workqueue(shost->tmf_work_q);
 	if (shost->ehandler)
@@ -325,6 +328,8 @@ static void scsi_host_dev_release(struct
 	if (shost->work_q)
 		destroy_workqueue(shost->work_q);
 
+	destroy_rcu_head(&shost->rcu);
+
 	if (shost->shost_state == SHOST_CREATED) {
 		/*
 		 * Free the shost_dev device name here if scsi_host_alloc()
@@ -399,6 +404,7 @@ struct Scsi_Host *scsi_host_alloc(struct
 	INIT_LIST_HEAD(&shost->starved_list);
 	init_waitqueue_head(&shost->host_wait);
 	mutex_init(&shost->scan_mutex);
+	init_rcu_head(&shost->rcu);
 
 	index = ida_simple_get(&host_index_ida, 0, 0, GFP_KERNEL);
 	if (index < 0)
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -220,6 +220,17 @@ static void scsi_eh_reset(struct scsi_cm
 	}
 }
 
+static void scsi_eh_inc_host_failed(struct rcu_head *head)
+{
+	struct Scsi_Host *shost = container_of(head, typeof(*shost), rcu);
+	unsigned long flags;
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	shost->host_failed++;
+	scsi_eh_wakeup(shost);
+	spin_unlock_irqrestore(shost->host_lock, flags);
+}
+
 /**
  * scsi_eh_scmd_add - add scsi cmd to error handling.
  * @scmd:	scmd to run eh on.
@@ -242,9 +253,12 @@ void scsi_eh_scmd_add(struct scsi_cmnd *
 
 	scsi_eh_reset(scmd);
 	list_add_tail(&scmd->eh_entry, &shost->eh_cmd_q);
-	shost->host_failed++;
-	scsi_eh_wakeup(shost);
 	spin_unlock_irqrestore(shost->host_lock, flags);
+	/*
+	 * Ensure that all tasks observe the host state change before the
+	 * host_failed change.
+	 */
+	call_rcu(&shost->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -318,22 +318,39 @@ static void scsi_init_cmd_errh(struct sc
 		cmd->cmd_len = scsi_command_size(cmd->cmnd);
 }
 
-void scsi_device_unbusy(struct scsi_device *sdev)
+/*
+ * Decrement the host_busy counter and wake up the error handler if necessary.
+ * Avoid as follows that the error handler is not woken up if shost->host_busy
+ * == shost->host_failed: use call_rcu() in scsi_eh_scmd_add() in combination
+ * with an RCU read lock in this function to ensure that this function in its
+ * entirety either finishes before scsi_eh_scmd_add() increases the
+ * host_failed counter or that it notices the shost state change made by
+ * scsi_eh_scmd_add().
+ */
+static void scsi_dec_host_busy(struct Scsi_Host *shost)
 {
-	struct Scsi_Host *shost = sdev->host;
-	struct scsi_target *starget = scsi_target(sdev);
 	unsigned long flags;
 
+	rcu_read_lock();
 	atomic_dec(&shost->host_busy);
-	if (starget->can_queue > 0)
-		atomic_dec(&starget->target_busy);
-
-	if (unlikely(scsi_host_in_recovery(shost) &&
-		     (shost->host_failed || shost->host_eh_scheduled))) {
+	if (unlikely(scsi_host_in_recovery(shost))) {
 		spin_lock_irqsave(shost->host_lock, flags);
-		scsi_eh_wakeup(shost);
+		if (shost->host_failed || shost->host_eh_scheduled)
+			scsi_eh_wakeup(shost);
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
+	rcu_read_unlock();
+}
+
+void scsi_device_unbusy(struct scsi_device *sdev)
+{
+	struct Scsi_Host *shost = sdev->host;
+	struct scsi_target *starget = scsi_target(sdev);
+
+	scsi_dec_host_busy(shost);
+
+	if (starget->can_queue > 0)
+		atomic_dec(&starget->target_busy);
 
 	atomic_dec(&sdev->device_busy);
 }
@@ -1532,7 +1549,7 @@ starved:
 		list_add_tail(&sdev->starved_entry, &shost->starved_list);
 	spin_unlock_irq(shost->host_lock);
 out_dec:
-	atomic_dec(&shost->host_busy);
+	scsi_dec_host_busy(shost);
 	return 0;
 }
 
@@ -2020,7 +2037,7 @@ static blk_status_t scsi_queue_rq(struct
 	return BLK_STS_OK;
 
 out_dec_host_busy:
-       atomic_dec(&shost->host_busy);
+	scsi_dec_host_busy(shost);
 out_dec_target_busy:
 	if (scsi_target(sdev)->can_queue > 0)
 		atomic_dec(&scsi_target(sdev)->target_busy);
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -571,6 +571,8 @@ struct Scsi_Host {
 		struct blk_mq_tag_set	tag_set;
 	};
 
+	struct rcu_head rcu;
+
 	atomic_t host_busy;		   /* commands actually active on low-level */
 	atomic_t host_blocked;
 
