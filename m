Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326527-2-18146704233902716271
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
    t=1518326527; b=QQ+QOpCiy6mpLZTdxQKlLW/NEL1YSH91o19btz8y1yG1G7m
    7frXoo5pByZ7A6Gsub2dVoLZnXZJpgjGHVZMWmqHl08ZXiE1rKha8P2kUEFQy4RJ
    hyC322AdLh9l+qaOdOi0JacWuROMgF3A0/jc0IfW3EvA+VGXsrdRiumri5XNlKQK
    V4y3urV5vsJkcHK6yloONCectgdeL5L98XqpG/4g0EdVMPaw/UgTE1Gdo1hoLNTo
    xoTlQfH3jMeVG+HAmjpmILVaeQaAr3LqWZEzU69NW7DnxRmoQsQENQOZ59rp+tbk
    +Hbj9eiQt8qp91Rl8aFfp5YuuRc7+bAaagGEQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326527; bh=fgDCehiM3nGdCMbvvxR
    xgONkUib2RGU6We9qmlgUmBg=; b=hqXggT0oOy5FyNq0558U2VfwatF29hoxfy5
    uJJnXcVhHp/683MEKaeXOJ7gyJiMRbCCHnC3Do87+rYlm1bhTqtB7Y98lbRH/AWe
    PzccGyNPzh+t1e4hAOZHVt1C2i0Mb0Lu3w94CZCOCdGwJlTTRN3I3L25IDiqc/Gk
    IpKsgXNEPRwdRN9YFZAuWf0xENY/SAvBfqiIOdc3unlKoabRU14CoYRcNqmY3HKH
    /U95aZgoEbpht4nzwMXAQnI1s8qGngIECoOt1XAh8g6MRuwvFsBGoxgtdkm7cBh2
    pX2BWVNz7SifxVPit7rqSPZBwNtRudlmvZjQ06DLfNBT1YFSMjQ==
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
        id S1753077AbeBKFVw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:21:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752547AbeBKFSE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:04 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Tuomas Tynkkynen" <tuomas@tuxera.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.443214640@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 028/136] net/9p: Switch to wait_event_killable()
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

From: Tuomas Tynkkynen <tuomas@tuxera.com>

commit 9523feac272ccad2ad8186ba4fcc89103754de52 upstream.

Because userspace gets Very Unhappy when calls like stat() and execve()
return -EINTR on 9p filesystem mounts. For instance, when bash is
looking in PATH for things to execute and some SIGCHLD interrupts
stat(), bash can throw a spurious 'command not found' since it doesn't
retry the stat().

In practice, hitting the problem is rare and needs a really
slow/bogged down 9p server.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16: drop changes in trans_xen.c]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -753,8 +753,7 @@ p9_client_rpc(struct p9_client *c, int8_
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_interruptible(*req->wq,
-				       req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
 
 	/*
 	 * Make sure our req is coherent with regard to updates in other
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -292,8 +292,8 @@ req_retry:
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_interruptible(*chan->vc_wq,
-							chan->ring_bufs_avail);
+			err = wait_event_killable(*chan->vc_wq,
+						  chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				return err;
 
@@ -324,7 +324,7 @@ static int p9_get_mapped_pages(struct vi
 		 * Other zc request to finish here
 		 */
 		if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
-			err = wait_event_interruptible(vp_wq,
+			err = wait_event_killable(vp_wq,
 			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
 			if (err == -ERESTARTSYS)
 				return err;
@@ -454,8 +454,8 @@ req_retry_pinned:
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_interruptible(*chan->vc_wq,
-						       chan->ring_bufs_avail);
+			err = wait_event_killable(*chan->vc_wq,
+						  chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				goto err_out;
 
@@ -472,8 +472,7 @@ req_retry_pinned:
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
-	err = wait_event_interruptible(*req->wq,
-				       req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
