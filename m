Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326180-2-665670212878946949
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326179; b=iqzZg2AgUIvrzfVNCaPzr8251fwZ88tUXDpGx0rjQruDG1z
    uSgGCPW/YVwweu0TPsQZr7gyeIEk9n4QsVEM7ox/rkwRObzGWpiVTn837/AEuA+T
    VxK+QAj/WxOBPR03Wr1AcWx3STUe+Qbkkek06m5Ey9pY3/Q/yZgXDvwHLMPNJklY
    tEBHuaCgnsa3An9pX+2bTBj2ujwbtC5TtOQnq9IIPS+hvR2kV0/mJ0/ZPaxap0ww
    6wMoIKef8fn4Ljwgi0Eo5JsjC7d/NCr3/8eXz5PWsRG1L5uvxB+r+bcr5wdifTTP
    axL4xnuioPMQkfVEK6cu3SNlvIXt/Fn5ZP1riAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326179; bh=+7AGl2SALmPzgGsEIYy
    gR5fuQ56vsoBaW0AtQcb4TAc=; b=X4irDNNybas/yw/+BaUr9OUPfIv0NydjQN1
    m/vP+gKxEwWiYYg/J6cV7ESXt0wnsZqAzvtFJZ+4zPMj8KwWW4Cy0za7AUxZwWwF
    0a0jqIx0TlpZ8qXy3qDd778jxU29f5Zlyu/UhgSzMFcqYBisOxn8yR9QGqNNKAYF
    8+EA8hs/msDGPLvCGbjuLBZcGXd2kNqegrZD2wS7AMAzR6LDbK1g3Mu3tpW7QPFS
    o1Ava/KpQVKIITbES2wDDkDW/39WqyWOFA/nAf5WEkFMys+JSLNBSBRliGbEFQlA
    N99f44ztWuiP8Lg0Li3OcdO7epmAfCRaHnk9ROTMKBGsiDOR+cA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbeBKFOV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:14:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41370 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752587AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tuomas Tynkkynen" <tuomas@tuxera.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.16319116@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 13/79] net/9p: Switch to wait_event_killable()
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
[bwh: Backported to 3.2:
 - Drop changes in trans_xen.c
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -740,8 +740,7 @@ p9_client_rpc(struct p9_client *c, int8_
 		goto reterr;
 	}
 	/* Wait for the response */
-	err = wait_event_interruptible(*req->wq,
-				       req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
 
 	if (req->status == REQ_STATUS_ERROR) {
 		P9_DPRINTK(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -276,8 +276,8 @@ req_retry:
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_interruptible(*chan->vc_wq,
-							chan->ring_bufs_avail);
+			err = wait_event_killable(*chan->vc_wq,
+						  chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				return err;
 
@@ -309,7 +309,7 @@ static int p9_get_mapped_pages(struct vi
 		 * Other zc request to finish here
 		 */
 		if (atomic_read(&vp_pinned) >= chan->p9_max_pages) {
-			err = wait_event_interruptible(vp_wq,
+			err = wait_event_killable(vp_wq,
 			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
 			if (err == -ERESTARTSYS)
 				return err;
@@ -419,8 +419,8 @@ req_retry_pinned:
 		if (err == -ENOSPC) {
 			chan->ring_bufs_avail = 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err = wait_event_interruptible(*chan->vc_wq,
-						       chan->ring_bufs_avail);
+			err = wait_event_killable(*chan->vc_wq,
+						  chan->ring_bufs_avail);
 			if (err  == -ERESTARTSYS)
 				goto err_out;
 
@@ -438,8 +438,7 @@ req_retry_pinned:
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	P9_DPRINTK(P9_DEBUG_TRANS, "9p debug: virtio request kicked\n");
-	err = wait_event_interruptible(*req->wq,
-				       req->status >= REQ_STATUS_RCVD);
+	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
