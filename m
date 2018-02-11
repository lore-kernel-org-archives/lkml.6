Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323826-2-14707771748559870617
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
    t=1518323825; b=fN/JTlLYnFptX9FKuKXcE1eXZZLsme7EYIHx5gs0t2UASSl
    vCW2fcLNzG64dKJPaPcug0NeDjz36/G90dp+I3VfNbLeClwVZbSMrO3Yisgt8aBm
    /X6V1Z+Rrn7GL5l8xrgU3BUfIXFbji0Hk9CyXvSBS/+x3JL3+2tIDAVihv/DvvLQ
    U/iYSdYm4Ku7rBGbvLWWAAUMexQYfJiInnzXJhwLfoJey2zTWiElbYMtC7+/CS/R
    YIaOiCh0MEkAFtxr/+vnjwZafYFcCaasGHjNmki/t5at1he4kxqcxmZAJ4/atBkS
    y1sbzHv7c/81AqNWG0nuV6HHuXfz2lH9TTXxEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323825; bh=XKAZ3GzTdMEL9/VqL7E
    PuP7LgToccbXWso8i69hF/DM=; b=ZAqti72NqERGWW5s0yfktolekMMUgKHUbQx
    1U07wJvgatTOEodoqlioxVWwvD2ZVcradpuoQqwd2GzjurdZB5XVG6ic3TsFvGnf
    JAh15oQ71RSH/N8rPoJqGMMv+hmUFt3Gs2IVLT4QMlT0iNjaxO2Gq4j/3nEnxRrp
    VZhyHv5BYlJfMdwhOV2/e447yDLe0hAEj/UXhv3luaLdz0X/cTQcZPRQceEX1Prn
    CBY+lq5KdUyUASIDIXQEXSUStIY4W0wDUMyBIB8y20dpabsr6ft/YdP78D1Eo11E
    Y+LmEDLFDvIglaYp0d89zC03wLwVuMnxYXlPMEodLuDPXRBpwjA==
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
        id S1753007AbeBKEfE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41753 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753003AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tyler Hicks" <tyhicks@canonical.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.515152594@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 058/136] eCryptfs: use after free in ecryptfs_release_messaging()
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit db86be3a12d0b6e5c5b51c2ab2a48f06329cb590 upstream.

We're freeing the list iterator so we should be using the _safe()
version of hlist_for_each_entry().

Fixes: 88b4a07e6610 ("[PATCH] eCryptfs: Public key transport mechanism")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ecryptfs/messaging.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -443,15 +443,16 @@ void ecryptfs_release_messaging(void)
 	}
 	if (ecryptfs_daemon_hash) {
 		struct ecryptfs_daemon *daemon;
+		struct hlist_node *n;
 		int i;
 
 		mutex_lock(&ecryptfs_daemon_hash_mux);
 		for (i = 0; i < (1 << ecryptfs_hash_bits); i++) {
 			int rc;
 
-			hlist_for_each_entry(daemon,
-					     &ecryptfs_daemon_hash[i],
-					     euid_chain) {
+			hlist_for_each_entry_safe(daemon, n,
+						  &ecryptfs_daemon_hash[i],
+						  euid_chain) {
 				rc = ecryptfs_exorcise_daemon(daemon);
 				if (rc)
 					printk(KERN_ERR "%s: Error whilst "
