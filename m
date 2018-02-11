Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326196-2-15844572322983660781
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326196; b=sRPbqXcsCHiEZtmg9Nl1Qv7uW4lWh/GC1tHnYOjQcwQiyV9
    oZt1JDAFCOP+k9NyNMfRm2Rd7Nu15kwjVAguB2boXmJURpshoBiIJM9YcJfFg45C
    D0dIo6frsofsxf546BZpBLCdiNOvSM5ZHxFpL/4sxbYnznpR65i8sUneMhf3AxiX
    GUVO7apqvMToeyBsSB/Cfj/Ts1npdlEz4+M2fIb4M8G43ua6CU3FW911YfqR5UvV
    Ffe9R00pi6qYL1vvpPMyVGevAvPZhSyk/W3vAiSSH+9Bo2VWos8K3lsvR/DrQ5/r
    oEH2CUmwF376QadBppx0yOBJk2hOglyNwKp2mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326196; bh=bz7RY+J4nbHl+RQN/vt
    Y+CZtb3+Duycr5U5TFqY+2g0=; b=D2SMxUf4y0pECGkPW82udQanenSmEqaZ/lp
    5k+aZCBn2kLTRPWkVgt07dvnQOYV5z9RfwEPULVOfyV8saUGkmufsVPy9WogZctQ
    lpsT0gVV/cVlsizGaxAGlKW7LjAR0mtBQZKn94b9al39xpyxzVW4rlvWe4iJ6v2D
    25+x8HK7wNLUmb0FtyYGpRUmxZ+tQe7mkyYT1PDs6THrlPlABidKF8gHL7WB0las
    DeR8BOPikP+1Z4STgcKJgZ2nHBQZWt19n63DUfA0T8d7Yngzm3HJlNgWQPVu5zZr
    +Nou9/c0zTPJGuDJCQiuJzceanF8P4WsvG7/W54sU9lbxdOTrog==
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
        id S1753834AbeBKFOS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:14:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41383 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752611AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ian Kent" <raven@themaw.net>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.420999040@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 49/79] autofs4: autofs4_wait() vs. autofs4_catatonic_mode()
 race
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

commit 4041bcdc7bef06a2fb29c57394c713a74bd13b08 upstream.

We need to recheck ->catatonic after autofs4_wait() got ->wq_mutex
for good, or we might end up with wq inserted into queue after
autofs4_catatonic_mode() had done its thing.  It will stick there
forever, since there won't be anything to clear its ->name.name.

A bit of a complication: validate_request() drops and regains ->wq_mutex.
It actually ends up the most convenient place to stick the check into...

Acked-by: Ian Kent <raven@themaw.net>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/autofs4/waitq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -257,6 +257,9 @@ static int validate_request(struct autof
 	struct autofs_wait_queue *wq;
 	struct autofs_info *ino;
 
+	if (sbi->catatonic)
+		return -ENOENT;
+
 	/* Wait in progress, continue; */
 	wq = autofs4_find_wait(sbi, qstr);
 	if (wq) {
@@ -289,6 +292,9 @@ static int validate_request(struct autof
 			if (mutex_lock_interruptible(&sbi->wq_mutex))
 				return -EINTR;
 
+			if (sbi->catatonic)
+				return -ENOENT;
+
 			wq = autofs4_find_wait(sbi, qstr);
 			if (wq) {
 				*wait = wq;
@@ -389,7 +395,7 @@ int autofs4_wait(struct autofs_sb_info *
 
 	ret = validate_request(&wq, sbi, &qstr, dentry, notify);
 	if (ret <= 0) {
-		if (ret == 0)
+		if (ret != -EINTR)
 			mutex_unlock(&sbi->wq_mutex);
 		kfree(qstr.name);
 		return ret;
