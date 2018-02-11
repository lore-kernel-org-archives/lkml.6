Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326635-2-15104095992227639481
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
    t=1518326635; b=qNgK1flXxGLsORc5h9jGNQX1/B50hAp+8vxv/UtrUUWb8yr
    ILTevP7k8rrehbx6G85q/Z3AzeJuIlJKc60gQti0APH55icbgbEjRAYg7NhT0sur
    a+0U2lcSvpC717FxxDYIyH5/wbASblmmQ6n3wenNk4QO89YQy+ItEjCyXl40IS5Z
    /VVvvnveNAQbXSCQJ13+OwO2kuwvphTsrRyuVcLGerq90jVvbw076cycd6uKqKQ+
    au6S47gorX3lDJXo+6mpz3WfDL39gisrXU5awmRk+MDZnMa2TNZXJVAbUJKiTlUY
    ztKnQRTawSH4csl9ov12B9pecGolhxUU/zBkFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326635; bh=CCF/mLu2RDSEGNTXRRw
    14+c+q8o6WfLVNqYmxG/DO5Q=; b=P2t+/KU6/d3q6w6lnkhTXBrGx3XD2WcwB59
    6xAixz73Ul4e44UNBi9Y29PDzyhYsHQrET/IkjDoLpDqMnX3JA1DnZNN1zU5f5bC
    HMz+L0WPobDIITrJ86nTa8PO2i0zVFm8ZHDFXVmvDo5ZRsgp4ASlPaldYbzypZtq
    FweIwkfgxEdHziQ0BgZOY97h9V3eGZasEIzBwdpdTOxHGuJVVtvzlKeyoc3N9DPd
    BJ4x+SHd+Mef4MWp46sNv5o2/UDj7ZVD9tMu0q4va/w6xiTnkzmraDu2qfXZuaIr
    2jbiDUCLRwSPEYimieX2JPtU5Gi1decjgUdZPwGPA6wdj731KsA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753579AbeBKFXT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:23:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41340 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752531AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Bart Van Assche" <bart.vanassche@wdc.com>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        "Doug Ledford" <dledford@redhat.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.325817887@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 10/79] IB/srp: Avoid that a cable pull can trigger a
 kernel crash
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 8a0d18c62121d3c554a83eb96e2752861d84d937 upstream.

This patch fixes the following kernel crash:

general protection fault: 0000 [#1] PREEMPT SMP
Workqueue: ib_mad2 timeout_sends [ib_core]
Call Trace:
 ib_sa_path_rec_callback+0x1c4/0x1d0 [ib_core]
 send_handler+0xb2/0xd0 [ib_core]
 timeout_sends+0x14d/0x220 [ib_core]
 process_one_work+0x200/0x630
 worker_thread+0x4e/0x3b0
 kthread+0x113/0x150

Fixes: commit aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Doug Ledford <dledford@redhat.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -310,10 +310,19 @@ static void srp_path_rec_completion(int
 
 static int srp_lookup_path(struct srp_target_port *target)
 {
+	int ret = -ENODEV;
+
 	target->path.numb_path = 1;
 
 	init_completion(&target->done);
 
+	/*
+	 * Avoid that the SCSI host can be removed by srp_remove_target()
+	 * before srp_path_rec_completion() is called.
+	 */
+	if (!scsi_host_get(target->scsi_host))
+		goto out;
+
 	target->path_query_id = ib_sa_path_rec_get(&srp_sa_client,
 						   target->srp_host->srp_dev->dev,
 						   target->srp_host->port,
@@ -327,16 +336,22 @@ static int srp_lookup_path(struct srp_ta
 						   GFP_KERNEL,
 						   srp_path_rec_completion,
 						   target, &target->path_query);
-	if (target->path_query_id < 0)
-		return target->path_query_id;
+	ret = target->path_query_id;
+	if (ret < 0)
+		goto put;
 
 	wait_for_completion(&target->done);
 
-	if (target->status < 0)
+	ret = target->status;
+	if (ret < 0)
 		shost_printk(KERN_WARNING, target->scsi_host,
 			     PFX "Path record query failed\n");
 
-	return target->status;
+put:
+	scsi_host_put(target->scsi_host);
+
+out:
+	return ret;
 }
 
 static int srp_send_req(struct srp_target_port *target)
