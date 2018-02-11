Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325750-2-15829497225702872379
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
    t=1518325749; b=BCB712vBn0WG8Gh7l/rQHvBd1eY9QBQ4r6ujOZ7aCy8hlNH
    4W4D7MsjsFKfMSrn12/emQNIE1eWMtIRpXb0N9jHXZkx94oAyJghA+KFLZO25JMr
    hkVfm5i9l/4tS92OKl/4FIahVlGphu8jmbs33wr0BwmE2mU8cE+5pb4OURcF6YOu
    WO3DsI8g//0UwVRQ6778fGEgTTiRw/sCay75Pp28jXMpwckUu3UUWkYIYEU9VGIW
    cGhXMSqjhkV9GlcsZ8pQHMToLeWnzPrJUT6cwCifTIG9MbjQPDyfidct/ZBF7FQj
    okn+cLMQChK8WQV/W8Ubd9WgQbIC/vmJViyDO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325749; bh=I38j7KqPMgZaGKRBdld
    A0r1vYU/o3jDifGioPPlLI1o=; b=CCkmnd9oFNsv9cYpMDV0ZDzdVvIpv9uQA3G
    i0PszLv1CijqIQS5TG4s7ZvmhMHpWJuHL3r8VzeNh1nyJa9oGDLZ2xBiofvjYjQb
    scz/C1RxpnkQfv5qbXYF6JVdbptq4s2RYRKRuHA7WP7tR2uqt0E4MIKB285sIKkA
    7nSyrUee/rhvomoBxOSYliAzRVkCmkL641AH774F9zOCxrkTzYT0t5nxmA2pAQJB
    j1C4lYAZ361/Wsly5Ux4BnvC9JSo5lzltXlTqvpHHgcGRa8I1Eq6SNZfAZpovj3G
    cTbZO1GSdD9N4pqQ/Rs+8bCScDweGgfXhYAUSmbwdWsE5+reZMg==
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
        id S1753530AbeBKFHa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:07:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41477 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752669AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Tyler Hicks" <tyhicks@canonical.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.311122845@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 27/79] eCryptfs: use after free in ecryptfs_release_messaging()
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit db86be3a12d0b6e5c5b51c2ab2a48f06329cb590 upstream.

We're freeing the list iterator so we should be using the _safe()
version of hlist_for_each_entry().

Fixes: 88b4a07e6610 ("[PATCH] eCryptfs: Public key transport mechanism")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -550,17 +550,17 @@ void ecryptfs_release_messaging(void)
 		mutex_unlock(&ecryptfs_msg_ctx_lists_mux);
 	}
 	if (ecryptfs_daemon_hash) {
-		struct hlist_node *elem;
 		struct ecryptfs_daemon *daemon;
+		struct hlist_node *elem, *n;
 		int i;
 
 		mutex_lock(&ecryptfs_daemon_hash_mux);
 		for (i = 0; i < (1 << ecryptfs_hash_bits); i++) {
 			int rc;
 
-			hlist_for_each_entry(daemon, elem,
-					     &ecryptfs_daemon_hash[i],
-					     euid_chain) {
+			hlist_for_each_entry_safe(daemon, elem, n,
+						  &ecryptfs_daemon_hash[i],
+						  euid_chain) {
 				rc = ecryptfs_exorcise_daemon(daemon);
 				if (rc)
 					printk(KERN_ERR "%s: Error whilst "
