Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325946-2-14556579938648498658
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
    t=1518325945; b=F/igbxAKkZ7bOYc8kpGqnknPYjpFJ7W1FKmGTSFa5vdideJ
    Uo4bTlcz2qIPWfvF0qeAjmr5mKYUzzw/Rk8f8H3mhtCZV5BR7UiVYupRrYU8S9CW
    roHghlGvx002reQLdR+Tw7tMcb7tC5R0pbCZ6SD4VD++vubXMp4VWQEXTnCH1fHO
    d+TkxbojnE5rVF9FQId1K8DAcao4lftPK+BNpgbvz51rgPYscM55A+vNUix1knXg
    GtxvGloL+ByMjqPjfIpwKwz0wkXCgyW8Uba9HtMwTASHitY+gbMxB4kBY5XlF20f
    vw2DkQpUq647D215meZXzsrkSnH7VV7y2F++1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325945; bh=w8ShemzT2ulHYa1MXBO
    zleI4h3c+NmYh1QYbRXbUl64=; b=iPRuI3wdfcRvqkv7kWEr1d5rWoeIGCbYQbY
    G6vtVoocuA0ErJWVSraBUrZ6YTJZnFLYZdk6MJGDDaZvpbDYLzrEmvxZW0VVjk/n
    gFA/psksN+wg3rSgNPxXclOuOMQ8o22S09EXvIkRZ4FFjhZztK53/Ym9ZkZaiod/
    w4rI4/o+4DmTiw+8gXJjjpFUSSMU0DvcwXSyDx55YSRQEblDIc0b6NyhRlYpftig
    byv50VlgOzxMj2xPBaeRO3mI1W/BicQDXnI0lfYxgPPELjzmvusftXzJAG0A0nIc
    epQdagKoeMOXpAsR3gErAhWukJzhrn0faZ7e24drp2jQfUaF7ew==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeBKFMX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:12:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41381 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752602AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Ian Kent" <raven@themaw.net>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.316822394@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 50/79] autofs4: catatonic_mode vs. notify_daemon race
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

From: Al Viro <viro@zeniv.linux.org.uk>

commit 8753333266be67ff3a984ac1f6566d31c260bee4 upstream.

we need to hold ->wq_mutex while we are forming the packet to send,
lest we have autofs4_catatonic_mode() setting wq->name.name to NULL
just as autofs4_notify_daemon() decides to memcpy() from it...

We do have check for catatonic mode immediately after that (under
->wq_mutex, as it ought to be) and packet won't be actually sent,
but it'll be too late for us if we oops on that memcpy() from NULL...

Fix is obvious - just extend the area covered by ->wq_mutex over
that switch and check whether it's catatonic *before* doing anything
else.

Acked-by: Ian Kent <raven@themaw.net>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/autofs4/waitq.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -110,6 +110,13 @@ static void autofs4_notify_daemon(struct
 
 	pkt.hdr.proto_version = sbi->version;
 	pkt.hdr.type = type;
+	mutex_lock(&sbi->wq_mutex);
+
+	/* Check if we have become catatonic */
+	if (sbi->catatonic) {
+		mutex_unlock(&sbi->wq_mutex);
+		return;
+	}
 	switch (type) {
 	/* Kernel protocol v4 missing and expire packets */
 	case autofs_ptype_missing:
@@ -163,22 +170,18 @@ static void autofs4_notify_daemon(struct
 	}
 	default:
 		printk("autofs4_notify_daemon: bad type %d!\n", type);
+		mutex_unlock(&sbi->wq_mutex);
 		return;
 	}
 
-	/* Check if we have become catatonic */
-	mutex_lock(&sbi->wq_mutex);
-	if (!sbi->catatonic) {
-		pipe = sbi->pipe;
-		get_file(pipe);
-	}
+	pipe = sbi->pipe;
+	get_file(pipe);
+
 	mutex_unlock(&sbi->wq_mutex);
 
-	if (pipe) {
-		if (autofs4_write(pipe, &pkt, pktsz))
-			autofs4_catatonic_mode(sbi);
-		fput(pipe);
-	}
+	if (autofs4_write(pipe, &pkt, pktsz))
+		autofs4_catatonic_mode(sbi);
+	fput(pipe);
 }
 
 static int autofs4_getpath(struct autofs_sb_info *sbi,
